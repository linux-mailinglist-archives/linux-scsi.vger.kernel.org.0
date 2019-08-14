Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E210B8D705
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Aug 2019 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfHNPOx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Aug 2019 11:14:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41884 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfHNPOx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Aug 2019 11:14:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so50658340pls.8;
        Wed, 14 Aug 2019 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NKpqOapAWm4LEktIkgNSd0a4A6OSDVbmFmubwx0bM4o=;
        b=NgNteJCk2mSV3JY7rR/LBMl+FadI6Ex4jEXkm46r/DwWGYiFaHEkL35h6jTE4Uy324
         yNmc1ym1iCjMAVoR0YTp0Lj5gAms1SHpXtBuGeyTWrajtgpiWb9zIrO1tOQVOotFHS2A
         NISDfppIWw3A9gTK1umr00+h6bnKOBem87V3ywW8H9jHT1zmC4fAeN4UwPiKg9BAVx/C
         wZtwJGfyGxdbLSQ+XXQgzuG3q8jp790wW8JoOXZzLgJQ9hDG5wsClqTJvVeFmnd5sVTU
         6tpevqqu5aFm8jZzANI9+4CkwyHxW6p3PAPUUWTgh/qQL2tsyEWc9W+VbIKxDuwJGMPI
         X29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NKpqOapAWm4LEktIkgNSd0a4A6OSDVbmFmubwx0bM4o=;
        b=Ky0BicdDYOCdv2W/4qxvIJdfuyfVC7m+We7+70BH59If5Ak1xWbopMqXodfZ5R35e1
         8dwSp6xTHgu8JxY0Ai0+MnSyeXaWpy0rKRkwpoc6xnoca3a4AhAh0EqPsmkK28sSh75X
         55oQSI0ftq7yHUZLDaCE5SCiM2rPq0bQ35GKB91HCrhAmsAVuny98n0J5eQYMI10LcHX
         IgtuoHmm/TebxKGD6x6OPBNeJVbSfMnjcxtO/+VanUNEtqGOuk0piLahumYzR2HRFQXV
         apjXGyeZw/KH8XILvRw1Yet0M6UOWSyUzG/tdBeftOeFLaYMvviusQLQSv8f0QYPNy4N
         hbhA==
X-Gm-Message-State: APjAAAWRxDrd8sdu/GxVRd6piHM7qO78X2KK/SBu/zIZW2hG++Uvi4KL
        N06+1r4YABDyeBEKq2JCtTU=
X-Google-Smtp-Source: APXvYqy48q8co+N47bCPvSzzsDOSVv1OOWfIE4vMuZ7XfxCNGfcKYcDNlLmXfHHDiv641oXCe9OxZw==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr40714277ply.251.1565795692291;
        Wed, 14 Aug 2019 08:14:52 -0700 (PDT)
Received: from localhost.localdomain (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id q22sm20500pgh.49.2019.08.14.08.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 08:14:51 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
To:     sathya.prakash@broadcom.com
Cc:     suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Balantzyan <mbalant3@gmail.com>
Subject: [PATCH] lsilogic mpt fusion: mptctl: Fixed race condition around mptctl_id variable using mutexes
Date:   Wed, 14 Aug 2019 08:14:46 -0700
Message-Id: <20190814151446.37695-1-mbalant3@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Certain functions in the driver, such as mptctl_do_fw_download() and
mptctl_do_mpt_command(), rely on the instance of mptctl_id, which does the
id-ing. There is race condition possible when these functions operate in
concurrency. Via, mutexes, the functions are mutually signalled to cooperate.

Signed-off-by: Mark Balantzyan <mbalant3@gmail.com>

---
 drivers/message/fusion/mptctl.c | 36 ++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 4470630d..58ce0fc0 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -816,12 +816,15 @@ mptctl_do_fw_download(int ioc, char __user *ufwbuf, size_t fwlen)
 
 		/*  Valid device. Get a message frame and construct the FW download message.
 	 	*/
+		mutex_lock(&mpctl_mutex);
 		if ((mf = mpt_get_msg_frame(mptctl_id, iocp)) == NULL)
+		mutex_unlock(&mpctl_mutex);
 			return -EAGAIN;
 	}
-
+	mutex_lock(&mpctl_mutex);
 	dctlprintk(iocp, printk(MYIOC_s_DEBUG_FMT
 	    "mptctl_do_fwdl called. mptctl_id = %xh.\n", iocp->name, mptctl_id));
+	mutex_unlock(&mpctl_mutex);
 	dctlprintk(iocp, printk(MYIOC_s_DEBUG_FMT "DbG: kfwdl.bufp  = %p\n",
 	    iocp->name, ufwbuf));
 	dctlprintk(iocp, printk(MYIOC_s_DEBUG_FMT "DbG: kfwdl.fwlen = %d\n",
@@ -943,7 +946,9 @@ mptctl_do_fw_download(int ioc, char __user *ufwbuf, size_t fwlen)
 	ReplyMsg = NULL;
 	SET_MGMT_MSG_CONTEXT(iocp->ioctl_cmds.msg_context, dlmsg->MsgContext);
 	INITIALIZE_MGMT_STATUS(iocp->ioctl_cmds.status)
+	mutex_lock(&mpctl_mutex);
 	mpt_put_msg_frame(mptctl_id, iocp, mf);
+	mutex_lock(&mpctl_mutex);
 
 	/* Now wait for the command to complete */
 retry_wait:
@@ -1889,7 +1894,9 @@ mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
 
 	/* Get a free request frame and save the message context.
 	 */
+	mutex_lock(&mpctl_mutex);
         if ((mf = mpt_get_msg_frame(mptctl_id, ioc)) == NULL)
+	mutex_unlock(&mpctl_mutex);
                 return -EAGAIN;
 
 	hdr = (MPIHeader_t *) mf;
@@ -2271,11 +2278,14 @@ mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
 		DBG_DUMP_TM_REQUEST_FRAME(ioc, (u32 *)mf);
 
 		if ((ioc->facts.IOCCapabilities & MPI_IOCFACTS_CAPABILITY_HIGH_PRI_Q) &&
-		    (ioc->facts.MsgVersion >= MPI_VERSION_01_05))
+		    (ioc->facts.MsgVersion >= MPI_VERSION_01_05)) {
+			mutex_lock(&mpctl_mutex);
 			mpt_put_msg_frame_hi_pri(mptctl_id, ioc, mf);
-		else {
-			rc =mpt_send_handshake_request(mptctl_id, ioc,
-				sizeof(SCSITaskMgmt_t), (u32*)mf, CAN_SLEEP);
+			mutex_unlock(&mpctl_mutex);
+		} else {
+			mutex_lock(&mpctl_mutex);
+			rc = mpt_send_handshake_request(mptctl_id, ioc, sizeof(SCSITaskMgmt_t), (u32 *)mf, CAN_SLEEP);
+			mutex_unlock(&mpctl_mutex);
 			if (rc != 0) {
 				dfailprintk(ioc, printk(MYIOC_s_ERR_FMT
 				    "send_handshake FAILED! (ioc %p, mf %p)\n",
@@ -2288,7 +2298,9 @@ mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
 		}
 
 	} else
+		mutex_lock(&mpctl_mutex);
 		mpt_put_msg_frame(mptctl_id, ioc, mf);
+		mutex_unlock(&mpctl_mutex);
 
 	/* Now wait for the command to complete */
 	timeout = (karg.timeout > 0) ? karg.timeout : MPT_IOCTL_DEFAULT_TIMEOUT;
@@ -2563,7 +2575,9 @@ mptctl_hp_hostinfo(unsigned long arg, unsigned int data_size)
 	/* 
 	 * Gather ISTWI(Industry Standard Two Wire Interface) Data
 	 */
+	mutex_lock(&mpctl_mutex);
 	if ((mf = mpt_get_msg_frame(mptctl_id, ioc)) == NULL) {
+	mutex_unlock(&mpctl_mutex);
 		dfailprintk(ioc, printk(MYIOC_s_WARN_FMT
 			"%s, no msg frames!!\n", ioc->name, __func__));
 		goto out;
@@ -2593,7 +2607,9 @@ mptctl_hp_hostinfo(unsigned long arg, unsigned int data_size)
 	SET_MGMT_MSG_CONTEXT(ioc->ioctl_cmds.msg_context,
 				IstwiRWRequest->MsgContext);
 	INITIALIZE_MGMT_STATUS(ioc->ioctl_cmds.status)
+	mutex_lock(&mpctl_mutex);
 	mpt_put_msg_frame(mptctl_id, ioc, mf);
+	mutex_unlock(&mpctl_mutex);
 
 retry_wait:
 	timeleft = wait_for_completion_timeout(&ioc->ioctl_cmds.done,
@@ -3010,9 +3026,11 @@ static int __init mptctl_init(void)
 	 *  Install our handler
 	 */
 	++where;
+	mutex_lock(&mpctl_mutex);
 	mptctl_id = mpt_register(mptctl_reply, MPTCTL_DRIVER,
 	    "mptctl_reply");
 	if (!mptctl_id || mptctl_id >= MPT_MAX_PROTOCOL_DRIVERS) {
+		mutex_unlock(&mpctl_mutex);
 		printk(KERN_ERR MYNAM ": ERROR: Failed to register with Fusion MPT base driver\n");
 		misc_deregister(&mptctl_miscdev);
 		err = -EBUSY;
@@ -3022,13 +3040,14 @@ static int __init mptctl_init(void)
 	mptctl_taskmgmt_id = mpt_register(mptctl_taskmgmt_reply, MPTCTL_DRIVER,
 	    "mptctl_taskmgmt_reply");
 	if (!mptctl_taskmgmt_id || mptctl_taskmgmt_id >= MPT_MAX_PROTOCOL_DRIVERS) {
+		mutex_unlock(&mpctl_mutex);
 		printk(KERN_ERR MYNAM ": ERROR: Failed to register with Fusion MPT base driver\n");
 		mpt_deregister(mptctl_id);
 		misc_deregister(&mptctl_miscdev);
 		err = -EBUSY;
 		goto out_fail;
 	}
-
+	mutex_unlock(&mpctl_mutex);
 	mpt_reset_register(mptctl_id, mptctl_ioc_reset);
 	mpt_event_register(mptctl_id, mptctl_event_process);
 
@@ -3044,13 +3063,14 @@ out_fail:
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 static void mptctl_exit(void)
 {
+	mutex_lock(&mpctl_mutex);
 	misc_deregister(&mptctl_miscdev);
 	printk(KERN_INFO MYNAM ": Deregistered /dev/%s @ (major,minor=%d,%d)\n",
 			 mptctl_miscdev.name, MISC_MAJOR, mptctl_miscdev.minor);
 
 	/* De-register event handler from base module */
 	mpt_event_deregister(mptctl_id);
-
+
 	/* De-register reset handler from base module */
 	mpt_reset_deregister(mptctl_id);
 
@@ -3058,6 +3078,8 @@ static void mptctl_exit(void)
 	mpt_deregister(mptctl_taskmgmt_id);
 	mpt_deregister(mptctl_id);
 
+	mutex_unlock(&mpctl_mutex);
+
         mpt_device_driver_deregister(MPTCTL_DRIVER);
 
 }
-- 
2.17.1

