Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFB1487D0
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Jan 2020 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392275AbgAXOV4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Jan 2020 09:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392260AbgAXOVz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03907222C2;
        Fri, 24 Jan 2020 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875714;
        bh=VFVlQoFiGed9NGWrouU+wwPZbLrl4yDz2ygQYAGuk40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siQSW/xmDnZAuVP75njzWAEZ9bULds+eMNWig+yk1XZGgrFvqxyirWfuIjQvipbV6
         cBCG8Zr+WslMdBInQ4Q2KEvvlyKQVOhXFcOhIQCDheool09O9z1LHmMp31Ib84MdId
         tiM/dC0Cj/qs6/uB9sc4d+jY+LyG98GflWQ0qAzI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Tom Hatskevich <tom2001tom.23@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        MPT-FusionLinux.pdl@avagotech.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 29/32] scsi: mptfusion: Fix double fetch bug in ioctl
Date:   Fri, 24 Jan 2020 09:21:16 -0500
Message-Id: <20200124142119.30484-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142119.30484-1-sashal@kernel.org>
References: <20200124142119.30484-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 28d76df18f0ad5bcf5fa48510b225f0ed262a99b ]

Tom Hatskevich reported that we look up "iocp" then, in the called
functions we do a second copy_from_user() and look it up again.
The problem that could cause is:

drivers/message/fusion/mptctl.c
   674          /* All of these commands require an interrupt or
   675           * are unknown/illegal.
   676           */
   677          if ((ret = mptctl_syscall_down(iocp, nonblock)) != 0)
                                               ^^^^
We take this lock.

   678                  return ret;
   679
   680          if (cmd == MPTFWDOWNLOAD)
   681                  ret = mptctl_fw_download(arg);
                                                 ^^^
Then the user memory changes and we look up "iocp" again but a different
one so now we are holding the incorrect lock and have a race condition.

   682          else if (cmd == MPTCOMMAND)
   683                  ret = mptctl_mpt_command(arg);

The security impact of this bug is not as bad as it could have been
because these operations are all privileged and root already has
enormous destructive power.  But it's still worth fixing.

This patch passes the "iocp" pointer to the functions to avoid the
second lookup.  That deletes 100 lines of code from the driver so
it's a nice clean up as well.

Link: https://lore.kernel.org/r/20200114123414.GA7957@kadam
Reported-by: Tom Hatskevich <tom2001tom.23@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/message/fusion/mptctl.c | 213 ++++++++------------------------
 1 file changed, 50 insertions(+), 163 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index cf6ce9f600ca8..f9b2e652c399c 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -100,19 +100,19 @@ struct buflist {
  * Function prototypes. Called from OS entry point mptctl_ioctl.
  * arg contents specific to function.
  */
-static int mptctl_fw_download(unsigned long arg);
-static int mptctl_getiocinfo(unsigned long arg, unsigned int cmd);
-static int mptctl_gettargetinfo(unsigned long arg);
-static int mptctl_readtest(unsigned long arg);
-static int mptctl_mpt_command(unsigned long arg);
-static int mptctl_eventquery(unsigned long arg);
-static int mptctl_eventenable(unsigned long arg);
-static int mptctl_eventreport(unsigned long arg);
-static int mptctl_replace_fw(unsigned long arg);
-
-static int mptctl_do_reset(unsigned long arg);
-static int mptctl_hp_hostinfo(unsigned long arg, unsigned int cmd);
-static int mptctl_hp_targetinfo(unsigned long arg);
+static int mptctl_fw_download(MPT_ADAPTER *iocp, unsigned long arg);
+static int mptctl_getiocinfo(MPT_ADAPTER *iocp, unsigned long arg, unsigned int cmd);
+static int mptctl_gettargetinfo(MPT_ADAPTER *iocp, unsigned long arg);
+static int mptctl_readtest(MPT_ADAPTER *iocp, unsigned long arg);
+static int mptctl_mpt_command(MPT_ADAPTER *iocp, unsigned long arg);
+static int mptctl_eventquery(MPT_ADAPTER *iocp, unsigned long arg);
+static int mptctl_eventenable(MPT_ADAPTER *iocp, unsigned long arg);
+static int mptctl_eventreport(MPT_ADAPTER *iocp, unsigned long arg);
+static int mptctl_replace_fw(MPT_ADAPTER *iocp, unsigned long arg);
+
+static int mptctl_do_reset(MPT_ADAPTER *iocp, unsigned long arg);
+static int mptctl_hp_hostinfo(MPT_ADAPTER *iocp, unsigned long arg, unsigned int cmd);
+static int mptctl_hp_targetinfo(MPT_ADAPTER *iocp, unsigned long arg);
 
 static int  mptctl_probe(struct pci_dev *, const struct pci_device_id *);
 static void mptctl_remove(struct pci_dev *);
@@ -123,8 +123,8 @@ static long compat_mpctl_ioctl(struct file *f, unsigned cmd, unsigned long arg);
 /*
  * Private function calls.
  */
-static int mptctl_do_mpt_command(struct mpt_ioctl_command karg, void __user *mfPtr);
-static int mptctl_do_fw_download(int ioc, char __user *ufwbuf, size_t fwlen);
+static int mptctl_do_mpt_command(MPT_ADAPTER *iocp, struct mpt_ioctl_command karg, void __user *mfPtr);
+static int mptctl_do_fw_download(MPT_ADAPTER *iocp, char __user *ufwbuf, size_t fwlen);
 static MptSge_t *kbuf_alloc_2_sgl(int bytes, u32 dir, int sge_offset, int *frags,
 		struct buflist **blp, dma_addr_t *sglbuf_dma, MPT_ADAPTER *ioc);
 static void kfree_sgl(MptSge_t *sgl, dma_addr_t sgl_dma,
@@ -656,19 +656,19 @@ __mptctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	 * by TM and FW reloads.
 	 */
 	if ((cmd & ~IOCSIZE_MASK) == (MPTIOCINFO & ~IOCSIZE_MASK)) {
-		return mptctl_getiocinfo(arg, _IOC_SIZE(cmd));
+		return mptctl_getiocinfo(iocp, arg, _IOC_SIZE(cmd));
 	} else if (cmd == MPTTARGETINFO) {
-		return mptctl_gettargetinfo(arg);
+		return mptctl_gettargetinfo(iocp, arg);
 	} else if (cmd == MPTTEST) {
-		return mptctl_readtest(arg);
+		return mptctl_readtest(iocp, arg);
 	} else if (cmd == MPTEVENTQUERY) {
-		return mptctl_eventquery(arg);
+		return mptctl_eventquery(iocp, arg);
 	} else if (cmd == MPTEVENTENABLE) {
-		return mptctl_eventenable(arg);
+		return mptctl_eventenable(iocp, arg);
 	} else if (cmd == MPTEVENTREPORT) {
-		return mptctl_eventreport(arg);
+		return mptctl_eventreport(iocp, arg);
 	} else if (cmd == MPTFWREPLACE) {
-		return mptctl_replace_fw(arg);
+		return mptctl_replace_fw(iocp, arg);
 	}
 
 	/* All of these commands require an interrupt or
@@ -678,15 +678,15 @@ __mptctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return ret;
 
 	if (cmd == MPTFWDOWNLOAD)
-		ret = mptctl_fw_download(arg);
+		ret = mptctl_fw_download(iocp, arg);
 	else if (cmd == MPTCOMMAND)
-		ret = mptctl_mpt_command(arg);
+		ret = mptctl_mpt_command(iocp, arg);
 	else if (cmd == MPTHARDRESET)
-		ret = mptctl_do_reset(arg);
+		ret = mptctl_do_reset(iocp, arg);
 	else if ((cmd & ~IOCSIZE_MASK) == (HP_GETHOSTINFO & ~IOCSIZE_MASK))
-		ret = mptctl_hp_hostinfo(arg, _IOC_SIZE(cmd));
+		ret = mptctl_hp_hostinfo(iocp, arg, _IOC_SIZE(cmd));
 	else if (cmd == HP_GETTARGETINFO)
-		ret = mptctl_hp_targetinfo(arg);
+		ret = mptctl_hp_targetinfo(iocp, arg);
 	else
 		ret = -EINVAL;
 
@@ -705,11 +705,10 @@ mptctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
-static int mptctl_do_reset(unsigned long arg)
+static int mptctl_do_reset(MPT_ADAPTER *iocp, unsigned long arg)
 {
 	struct mpt_ioctl_diag_reset __user *urinfo = (void __user *) arg;
 	struct mpt_ioctl_diag_reset krinfo;
-	MPT_ADAPTER		*iocp;
 
 	if (copy_from_user(&krinfo, urinfo, sizeof(struct mpt_ioctl_diag_reset))) {
 		printk(KERN_ERR MYNAM "%s@%d::mptctl_do_reset - "
@@ -718,12 +717,6 @@ static int mptctl_do_reset(unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (mpt_verify_adapter(krinfo.hdr.iocnum, &iocp) < 0) {
-		printk(KERN_DEBUG MYNAM "%s@%d::mptctl_do_reset - ioc%d not found!\n",
-				__FILE__, __LINE__, krinfo.hdr.iocnum);
-		return -ENODEV; /* (-6) No such device or address */
-	}
-
 	dctlprintk(iocp, printk(MYIOC_s_DEBUG_FMT "mptctl_do_reset called.\n",
 	    iocp->name));
 
@@ -754,7 +747,7 @@ static int mptctl_do_reset(unsigned long arg)
  *		-ENOMSG if FW upload returned bad status
  */
 static int
-mptctl_fw_download(unsigned long arg)
+mptctl_fw_download(MPT_ADAPTER *iocp, unsigned long arg)
 {
 	struct mpt_fw_xfer __user *ufwdl = (void __user *) arg;
 	struct mpt_fw_xfer	 kfwdl;
@@ -766,7 +759,7 @@ mptctl_fw_download(unsigned long arg)
 		return -EFAULT;
 	}
 
-	return mptctl_do_fw_download(kfwdl.iocnum, kfwdl.bufp, kfwdl.fwlen);
+	return mptctl_do_fw_download(iocp, kfwdl.bufp, kfwdl.fwlen);
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
@@ -784,11 +777,10 @@ mptctl_fw_download(unsigned long arg)
  *		-ENOMSG if FW upload returned bad status
  */
 static int
-mptctl_do_fw_download(int ioc, char __user *ufwbuf, size_t fwlen)
+mptctl_do_fw_download(MPT_ADAPTER *iocp, char __user *ufwbuf, size_t fwlen)
 {
 	FWDownload_t		*dlmsg;
 	MPT_FRAME_HDR		*mf;
-	MPT_ADAPTER		*iocp;
 	FWDownloadTCSGE_t	*ptsge;
 	MptSge_t		*sgl, *sgIn;
 	char			*sgOut;
@@ -808,17 +800,10 @@ mptctl_do_fw_download(int ioc, char __user *ufwbuf, size_t fwlen)
 	pFWDownloadReply_t	 ReplyMsg = NULL;
 	unsigned long		 timeleft;
 
-	if (mpt_verify_adapter(ioc, &iocp) < 0) {
-		printk(KERN_DEBUG MYNAM "ioctl_fwdl - ioc%d not found!\n",
-				 ioc);
-		return -ENODEV; /* (-6) No such device or address */
-	} else {
-
-		/*  Valid device. Get a message frame and construct the FW download message.
-	 	*/
-		if ((mf = mpt_get_msg_frame(mptctl_id, iocp)) == NULL)
-			return -EAGAIN;
-	}
+	/*  Valid device. Get a message frame and construct the FW download message.
+	*/
+	if ((mf = mpt_get_msg_frame(mptctl_id, iocp)) == NULL)
+		return -EAGAIN;
 
 	dctlprintk(iocp, printk(MYIOC_s_DEBUG_FMT
 	    "mptctl_do_fwdl called. mptctl_id = %xh.\n", iocp->name, mptctl_id));
@@ -826,8 +811,6 @@ mptctl_do_fw_download(int ioc, char __user *ufwbuf, size_t fwlen)
 	    iocp->name, ufwbuf));
 	dctlprintk(iocp, printk(MYIOC_s_DEBUG_FMT "DbG: kfwdl.fwlen = %d\n",
 	    iocp->name, (int)fwlen));
-	dctlprintk(iocp, printk(MYIOC_s_DEBUG_FMT "DbG: kfwdl.ioc   = %04xh\n",
-	    iocp->name, ioc));
 
 	dlmsg = (FWDownload_t*) mf;
 	ptsge = (FWDownloadTCSGE_t *) &dlmsg->SGL;
@@ -1238,13 +1221,11 @@ kfree_sgl(MptSge_t *sgl, dma_addr_t sgl_dma, struct buflist *buflist, MPT_ADAPTE
  *		-ENODEV  if no such device/adapter
  */
 static int
-mptctl_getiocinfo (unsigned long arg, unsigned int data_size)
+mptctl_getiocinfo (MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 {
 	struct mpt_ioctl_iocinfo __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_iocinfo *karg;
-	MPT_ADAPTER		*ioc;
 	struct pci_dev		*pdev;
-	int			iocnum;
 	unsigned int		port;
 	int			cim_rev;
 	struct scsi_device 	*sdev;
@@ -1272,14 +1253,6 @@ mptctl_getiocinfo (unsigned long arg, unsigned int data_size)
 		return PTR_ERR(karg);
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg->hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_getiocinfo() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		kfree(karg);
-		return -ENODEV;
-	}
-
 	/* Verify the data transfer size is correct. */
 	if (karg->hdr.maxDataSize != data_size) {
 		printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_getiocinfo - "
@@ -1385,15 +1358,13 @@ mptctl_getiocinfo (unsigned long arg, unsigned int data_size)
  *		-ENODEV  if no such device/adapter
  */
 static int
-mptctl_gettargetinfo (unsigned long arg)
+mptctl_gettargetinfo (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_targetinfo __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_targetinfo karg;
-	MPT_ADAPTER		*ioc;
 	VirtDevice		*vdevice;
 	char			*pmem;
 	int			*pdata;
-	int			iocnum;
 	int			numDevices = 0;
 	int			lun;
 	int			maxWordsLeft;
@@ -1408,13 +1379,6 @@ mptctl_gettargetinfo (unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_gettargetinfo() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
-
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_gettargetinfo called.\n",
 	    ioc->name));
 	/* Get the port number and set the maximum number of bytes
@@ -1510,12 +1474,10 @@ mptctl_gettargetinfo (unsigned long arg)
  *		-ENODEV  if no such device/adapter
  */
 static int
-mptctl_readtest (unsigned long arg)
+mptctl_readtest (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_test __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_test	 karg;
-	MPT_ADAPTER *ioc;
-	int iocnum;
 
 	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_test))) {
 		printk(KERN_ERR MYNAM "%s@%d::mptctl_readtest - "
@@ -1524,13 +1486,6 @@ mptctl_readtest (unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_readtest() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
-
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_readtest called.\n",
 	    ioc->name));
 	/* Fill in the data and return the structure to the calling
@@ -1571,12 +1526,10 @@ mptctl_readtest (unsigned long arg)
  *		-ENODEV  if no such device/adapter
  */
 static int
-mptctl_eventquery (unsigned long arg)
+mptctl_eventquery (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_eventquery __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_eventquery	 karg;
-	MPT_ADAPTER *ioc;
-	int iocnum;
 
 	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_eventquery))) {
 		printk(KERN_ERR MYNAM "%s@%d::mptctl_eventquery - "
@@ -1585,13 +1538,6 @@ mptctl_eventquery (unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_eventquery() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
-
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_eventquery called.\n",
 	    ioc->name));
 	karg.eventEntries = MPTCTL_EVENT_LOG_SIZE;
@@ -1610,12 +1556,10 @@ mptctl_eventquery (unsigned long arg)
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 static int
-mptctl_eventenable (unsigned long arg)
+mptctl_eventenable (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_eventenable __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_eventenable	 karg;
-	MPT_ADAPTER *ioc;
-	int iocnum;
 
 	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_eventenable))) {
 		printk(KERN_ERR MYNAM "%s@%d::mptctl_eventenable - "
@@ -1624,13 +1568,6 @@ mptctl_eventenable (unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_eventenable() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
-
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_eventenable called.\n",
 	    ioc->name));
 	if (ioc->events == NULL) {
@@ -1658,12 +1595,10 @@ mptctl_eventenable (unsigned long arg)
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 static int
-mptctl_eventreport (unsigned long arg)
+mptctl_eventreport (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_eventreport __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_eventreport	 karg;
-	MPT_ADAPTER		 *ioc;
-	int			 iocnum;
 	int			 numBytes, maxEvents, max;
 
 	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_eventreport))) {
@@ -1673,12 +1608,6 @@ mptctl_eventreport (unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_eventreport() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_eventreport called.\n",
 	    ioc->name));
 
@@ -1712,12 +1641,10 @@ mptctl_eventreport (unsigned long arg)
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 static int
-mptctl_replace_fw (unsigned long arg)
+mptctl_replace_fw (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_replace_fw __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_replace_fw	 karg;
-	MPT_ADAPTER		 *ioc;
-	int			 iocnum;
 	int			 newFwSize;
 
 	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_replace_fw))) {
@@ -1727,13 +1654,6 @@ mptctl_replace_fw (unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_replace_fw() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
-
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_replace_fw called.\n",
 	    ioc->name));
 	/* If caching FW, Free the old FW image
@@ -1780,12 +1700,10 @@ mptctl_replace_fw (unsigned long arg)
  *		-ENOMEM if memory allocation error
  */
 static int
-mptctl_mpt_command (unsigned long arg)
+mptctl_mpt_command (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_command __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_command  karg;
-	MPT_ADAPTER	*ioc;
-	int		iocnum;
 	int		rc;
 
 
@@ -1796,14 +1714,7 @@ mptctl_mpt_command (unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_mpt_command() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
-
-	rc = mptctl_do_mpt_command (karg, &uarg->MF);
+	rc = mptctl_do_mpt_command (ioc, karg, &uarg->MF);
 
 	return rc;
 }
@@ -1821,9 +1732,8 @@ mptctl_mpt_command (unsigned long arg)
  *		-EPERM if SCSI I/O and target is untagged
  */
 static int
-mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
+mptctl_do_mpt_command (MPT_ADAPTER *ioc, struct mpt_ioctl_command karg, void __user *mfPtr)
 {
-	MPT_ADAPTER	*ioc;
 	MPT_FRAME_HDR	*mf = NULL;
 	MPIHeader_t	*hdr;
 	char		*psge;
@@ -1832,7 +1742,7 @@ mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
 	dma_addr_t	dma_addr_in;
 	dma_addr_t	dma_addr_out;
 	int		sgSize = 0;	/* Num SG elements */
-	int		iocnum, flagsLength;
+	int		flagsLength;
 	int		sz, rc = 0;
 	int		msgContext;
 	u16		req_idx;
@@ -1847,13 +1757,6 @@ mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
 	bufIn.kptr = bufOut.kptr = NULL;
 	bufIn.len = bufOut.len = 0;
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_do_mpt_command() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
-
 	spin_lock_irqsave(&ioc->taskmgmt_lock, flags);
 	if (ioc->ioc_reset_in_progress) {
 		spin_unlock_irqrestore(&ioc->taskmgmt_lock, flags);
@@ -2418,17 +2321,15 @@ done_free_mem:
  *		-ENOMEM if memory allocation error
  */
 static int
-mptctl_hp_hostinfo(unsigned long arg, unsigned int data_size)
+mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 {
 	hp_host_info_t	__user *uarg = (void __user *) arg;
-	MPT_ADAPTER		*ioc;
 	struct pci_dev		*pdev;
 	char                    *pbuf=NULL;
 	dma_addr_t		buf_dma;
 	hp_host_info_t		karg;
 	CONFIGPARMS		cfg;
 	ConfigPageHeader_t	hdr;
-	int			iocnum;
 	int			rc, cim_rev;
 	ToolboxIstwiReadWriteRequest_t	*IstwiRWRequest;
 	MPT_FRAME_HDR		*mf = NULL;
@@ -2452,12 +2353,6 @@ mptctl_hp_hostinfo(unsigned long arg, unsigned int data_size)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-	    (ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_hp_hostinfo() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT ": mptctl_hp_hostinfo called.\n",
 	    ioc->name));
 
@@ -2670,15 +2565,13 @@ retry_wait:
  *		-ENOMEM if memory allocation error
  */
 static int
-mptctl_hp_targetinfo(unsigned long arg)
+mptctl_hp_targetinfo(MPT_ADAPTER *ioc, unsigned long arg)
 {
 	hp_target_info_t __user *uarg = (void __user *) arg;
 	SCSIDevicePage0_t	*pg0_alloc;
 	SCSIDevicePage3_t	*pg3_alloc;
-	MPT_ADAPTER		*ioc;
 	MPT_SCSI_HOST 		*hd = NULL;
 	hp_target_info_t	karg;
-	int			iocnum;
 	int			data_sz;
 	dma_addr_t		page_dma;
 	CONFIGPARMS	 	cfg;
@@ -2692,12 +2585,6 @@ mptctl_hp_targetinfo(unsigned long arg)
 		return -EFAULT;
 	}
 
-	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
-		(ioc == NULL)) {
-		printk(KERN_DEBUG MYNAM "%s::mptctl_hp_targetinfo() @%d - ioc%d not found!\n",
-				__FILE__, __LINE__, iocnum);
-		return -ENODEV;
-	}
 	if (karg.hdr.id >= MPT_MAX_FC_DEVICES)
 		return -EINVAL;
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_hp_targetinfo called.\n",
@@ -2865,7 +2752,7 @@ compat_mptfwxfer_ioctl(struct file *filp, unsigned int cmd,
 	kfw.fwlen = kfw32.fwlen;
 	kfw.bufp = compat_ptr(kfw32.bufp);
 
-	ret = mptctl_do_fw_download(kfw.iocnum, kfw.bufp, kfw.fwlen);
+	ret = mptctl_do_fw_download(iocp, kfw.bufp, kfw.fwlen);
 
 	mutex_unlock(&iocp->ioctl_cmds.mutex);
 
@@ -2919,7 +2806,7 @@ compat_mpt_command(struct file *filp, unsigned int cmd,
 
 	/* Pass new structure to do_mpt_command
 	 */
-	ret = mptctl_do_mpt_command (karg, &uarg->MF);
+	ret = mptctl_do_mpt_command (iocp, karg, &uarg->MF);
 
 	mutex_unlock(&iocp->ioctl_cmds.mutex);
 
-- 
2.20.1

