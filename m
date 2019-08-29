Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059E6A0F8A
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Aug 2019 04:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfH2C1d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Aug 2019 22:27:33 -0400
Received: from smtp.infotech.no ([82.134.31.41]:40139 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfH2C1d (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 28 Aug 2019 22:27:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1CF70204258;
        Thu, 29 Aug 2019 04:27:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pzGRuNziA-GX; Thu, 29 Aug 2019 04:27:30 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id D37ED204259;
        Thu, 29 Aug 2019 04:27:28 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bvanassche@acm.org, hch@infradead.org,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v4 17/22] sg: add sg_iosubmit_v3 and sg_ioreceive_v3 ioctls
Date:   Wed, 28 Aug 2019 22:26:54 -0400
Message-Id: <20190829022659.23130-18-dgilbert@interlog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190829022659.23130-1-dgilbert@interlog.com>
References: <20190829022659.23130-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add ioctl(SG_IOSUBMIT_V3) and ioctl(SG_IORECEIVE_V3). These ioctls
are meant to be (almost) drop-in replacements for the write()/read()
async version 3 interface. They only accept the version 3 interface.

See the webpage at: http://sg.danny.cz/sg/sg_v40.html
specifically the table in the section titled: "12 SG interface
support changes".

If sgv3 is a struct sg_io_hdr object, suitably configured, then
    res = write(sg_fd, &sgv3, sizeof(sgv3));
and
    res = ioctl(sg_fd, SG_IOSUBMIT_V3, &sgv3);
are equivalent. Dito for read() and ioctl(SG_IORECEIVE_V3).

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/scsi/sg.c      | 79 ++++++++++++++++++++++++++++++++++++++++--
 include/uapi/scsi/sg.h |  6 ++++
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 51a8511dc331..904f3ac8add7 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -806,6 +806,24 @@ sg_ctl_iosubmit(struct file *filp, struct sg_fd *sfp, void __user *p)
 	return -EPERM;
 }
 
+static int
+sg_ctl_iosubmit_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
+{
+	int res;
+	u8 hdr_store[SZ_SG_IO_V4];      /* max(v3interface, v4interface) */
+	struct sg_io_hdr *h3p = (struct sg_io_hdr *)hdr_store;
+	struct sg_device *sdp = sfp->parentdp;
+
+	res = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NONBLOCK));
+	if (unlikely(res))
+		return res;
+	if (copy_from_user(h3p, p, SZ_SG_IO_HDR))
+		return -EFAULT;
+	if (h3p->interface_id == 'S')
+		return sg_v3_submit(filp, sfp, h3p, false, NULL);
+	return -EPERM;
+}
+
 static void
 sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 {
@@ -1107,7 +1125,7 @@ sg_v4_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 	h4p->din_resid = srp->in_resid;
 	h4p->dout_resid = srp->s_hdr4.out_resid;
 	h4p->usr_ptr = srp->s_hdr4.usr_ptr;
-	h4p->response = (u64)srp->s_hdr4.sbp;
+	h4p->response = (u64)(unsigned long)srp->s_hdr4.sbp;
 	h4p->request_extra = srp->pack_id;
 	if (p) {
 		if (copy_to_user(p, h4p, SZ_SG_IO_V4))
@@ -1170,6 +1188,57 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 	return sg_v4_receive(sfp, srp, p, h4p);
 }
 
+/*
+ * Called when ioctl(SG_IORECEIVE_V3) received. Expects a v3 interface.
+ * Checks if O_NONBLOCK file flag given, if not checks given flags field
+ * to see if SGV4_FLAG_IMMED is set. Either of these implies non blocking.
+ * When non-blocking and there is no request waiting, yields EAGAIN;
+ * otherwise it waits.
+ */
+static int
+sg_ctl_ioreceive_v3(struct file *filp, struct sg_fd *sfp, void __user *p)
+{
+	bool non_block = !!(filp->f_flags & O_NONBLOCK);
+	int res;
+	int pack_id = SG_PACK_ID_WILDCARD;
+	u8 v3_holder[SZ_SG_IO_HDR];
+	struct sg_io_hdr *h3p = (struct sg_io_hdr *)v3_holder;
+	struct sg_device *sdp = sfp->parentdp;
+	struct sg_request *srp;
+
+	res = sg_allow_if_err_recovery(sdp, non_block);
+	if (unlikely(res))
+		return res;
+	/* Get first three 32 bit integers: guard, proto+subproto */
+	if (copy_from_user(h3p, p, SZ_SG_IO_HDR))
+		return -EFAULT;
+	/* for v3: interface_id=='S' (in a 32 bit int) */
+	if (h3p->interface_id != 'S')
+		return -EPERM;
+	if (h3p->flags & SGV4_FLAG_IMMED)
+		non_block = true;	/* set by either this or O_NONBLOCK */
+	SG_LOG(3, sfp, "%s: non_block(+IMMED)=%d\n", __func__, non_block);
+
+	if (test_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm))
+		pack_id = h3p->pack_id;
+
+	srp = sg_find_srp_by_id(sfp, pack_id);
+	if (!srp) {     /* nothing available so wait on packet or */
+		if (unlikely(SG_IS_DETACHING(sdp)))
+			return -ENODEV;
+		if (non_block)
+			return -EAGAIN;
+		res = wait_event_interruptible
+				(sfp->read_wait,
+				 sg_get_ready_srp(sfp, &srp, pack_id));
+		if (unlikely(SG_IS_DETACHING(sdp)))
+			return -ENODEV;
+		if (unlikely(res))
+			return res;	/* signal --> -ERESTARTSYS */
+	}	/* now srp should be valid */
+	return sg_v3_receive(sfp, srp, p);
+}
+
 static int
 sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 	   struct sg_request *srp)
@@ -1726,9 +1795,15 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_IOSUBMIT:
 		SG_LOG(3, sfp, "%s:    SG_IOSUBMIT\n", __func__);
 		return sg_ctl_iosubmit(filp, sfp, p);
+	case SG_IOSUBMIT_V3:
+		SG_LOG(3, sfp, "%s:    SG_IOSUBMIT_V3\n", __func__);
+		return sg_ctl_iosubmit_v3(filp, sfp, p);
 	case SG_IORECEIVE:
 		SG_LOG(3, sfp, "%s:    SG_IORECEIVE\n", __func__);
 		return sg_ctl_ioreceive(filp, sfp, p);
+	case SG_IORECEIVE_V3:
+		SG_LOG(3, sfp, "%s:    SG_IORECEIVE_V3\n", __func__);
+		return sg_ctl_ioreceive_v3(filp, sfp, p);
 	case SG_GET_SCSI_ID:
 		if (SG_IS_DETACHING(sdp))
 			return -ENODEV;
@@ -2997,7 +3072,7 @@ static struct sg_request *
 sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 {
 	__maybe_unused bool is_bad_st = false;
-	__maybe_unused enum sg_rq_state bad_sr_st;
+	__maybe_unused enum sg_rq_state bad_sr_st = SG_RS_INACTIVE;
 	bool search_for_1 = (pack_id != SG_PACK_ID_WILDCARD);
 	enum sg_rq_state sr_st;
 	int res;
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 2c9cb92b3515..7c941e48a0d2 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -356,6 +356,12 @@ struct sg_header {
 /* Gives some v4 identifying info to driver, receives associated response */
 #define SG_IORECEIVE _IOWR(SG_IOCTL_MAGIC_NUM, 0x42, struct sg_io_v4)
 
+/* Submits a v3 interface object to driver */
+#define SG_IOSUBMIT_V3 _IOWR(SG_IOCTL_MAGIC_NUM, 0x45, struct sg_io_hdr)
+
+/* Gives some v3 identifying info to driver, receives associated response */
+#define SG_IORECEIVE_V3 _IOWR(SG_IOCTL_MAGIC_NUM, 0x46, struct sg_io_hdr)
+
 /* command queuing is always on when the v3 or v4 interface is used */
 #define SG_DEF_COMMAND_Q 0
 
-- 
2.23.0

