Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DF63579C0
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Apr 2021 03:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhDHBqj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Apr 2021 21:46:39 -0400
Received: from smtp.infotech.no ([82.134.31.41]:45223 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhDHBqa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 7 Apr 2021 21:46:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 58450204275;
        Thu,  8 Apr 2021 03:46:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T5OrZxAKcUXe; Thu,  8 Apr 2021 03:46:15 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id BDB8D204269;
        Thu,  8 Apr 2021 03:46:10 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v17 31/45] sg: add sg_iosubmit_v3 and sg_ioreceive_v3 ioctls
Date:   Wed,  7 Apr 2021 21:45:17 -0400
Message-Id: <20210408014531.248890-32-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408014531.248890-1-dgilbert@interlog.com>
References: <20210408014531.248890-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add ioctl(SG_IOSUBMIT_V3) and ioctl(SG_IORECEIVE_V3). These ioctls
are meant to be (almost) drop-in replacements for the write()/read()
async version 3 interface. They only accept the version 3 interface.

See the webpage at: http://sg.danny.cz/sg/sg_v40.html
specifically the table in the section titled: "13 SG interface
support changes".

If sgv3 is a struct sg_io_hdr object, suitably configured, then
    res = write(sg_fd, &sgv3, sizeof(sgv3));
and
    res = ioctl(sg_fd, SG_IOSUBMIT_V3, &sgv3);
are equivalent. Dito for read() and ioctl(SG_IORECEIVE_V3).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 76 ++++++++++++++++++++++++++++++++++++++++++
 include/uapi/scsi/sg.h |  6 ++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 668722a2750f..bc54097b1d41 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -833,6 +833,24 @@ sg_ctl_iosubmit(struct file *filp, struct sg_fd *sfp, void __user *p)
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
 #if IS_ENABLED(SG_LOG_ACTIVE)
 static void
 sg_rq_state_fail_msg(struct sg_fd *sfp, enum sg_rq_state exp_old_st,
@@ -1157,6 +1175,7 @@ sg_receive_v3(struct sg_fd *sfp, struct sg_request *srp, size_t count,
 	hp->sb_len_wr = srp->sense_len;
 	hp->info = srp->rq_info;
 	hp->resid = srp->in_resid;
+	hp->pack_id = srp->pack_id;
 	hp->duration = srp->duration;
 	hp->status = rq_result & 0xff;
 	hp->masked_status = status_byte(rq_result);
@@ -1272,6 +1291,57 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 	return sg_receive_v4(sfp, srp, p, h4p);
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
+	return sg_receive_v3(sfp, srp, SZ_SG_IO_HDR, p);
+}
+
 static int
 sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
 	     struct sg_request *srp)
@@ -1864,9 +1934,15 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
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
 		return sg_ctl_scsi_id(sdev, sfp, p);
 	case SG_SET_FORCE_PACK_ID:
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index af14379d5dcb..6162a5d5995c 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -357,6 +357,12 @@ struct sg_header {
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
2.25.1

