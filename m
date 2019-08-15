Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA608E8B7
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Aug 2019 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfHOKBM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Aug 2019 06:01:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40498 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbfHOKBL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 15 Aug 2019 06:01:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so1113479pfn.7;
        Thu, 15 Aug 2019 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u9M8Ie+Sea7JBN6GH+XMlP3J5MvPOCzhgB0q0n+x2T8=;
        b=Rj39qPFOeLmI7SKd7EqTks255Mm7tsVJ5hdIEctzkS2RRpzLAuIrminpe5jHtX9WI4
         p7F8CjI3Wbs72K1QTCM9AZiJsjZ4rdlv313NDKSOsDrVLMRT/tvklL2dDsMpLovedE6B
         2er1SU7UEtniQTIDXOYZMsahpAM0z13Sv+2gYDUWJYGnbNgZp43QMqveuW27mjq/JB5W
         0IpopY0RA+UPixgwV/13dpKO1g85kzEq6usDDPZfFWNXJXq/3Tx2JYFfeeH8Q6cw71vr
         Gn77HgWaRnlLtSAz+9eYSVTRvRxr05WRmnP9TPvNN6wS3kSEypkLrb3jqgn+jEwV5b8M
         kr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u9M8Ie+Sea7JBN6GH+XMlP3J5MvPOCzhgB0q0n+x2T8=;
        b=QVi3vxUvrCCVW/GgIu1oHmsKweVEBXReia0wUrV8RP5G+C59koUzW1qiECAbeOVHG+
         0ttgCaSv4FObo+kcVJs4RSJIr9iauv+lMy/wju77OfDCECtR0INI6pYMVbU3/RnPk5Hh
         RYd+Ara1s80X1e020mtvjPBjNLRdXyyGcN/H/KBp6F+CZ5tMi0giS0D+09Xa1eox3rqD
         tvedcXkYnsSX7R34uyH4sXhaKvopnRqqaGQCFf3YOQ+HdBuPSe3fG++dPrn6WMu8EpMr
         dGjtXCQS+z9dlAb1DGSKvA4f2nI+T6cudNKzTVnDRNYEFWJQh7YsskcvaHt3lWHHsL4u
         xOJA==
X-Gm-Message-State: APjAAAUFjseDu57xwgUvJouzdxxUjY1Tw/lI61DR0KQnLaEdwRlOivYm
        jgW3M0B/TMEIV7dtMKc1frM=
X-Google-Smtp-Source: APXvYqyVC7FM1xYBZQceDYVCmIGq7PbMRzoTft6VBCeAIUTmOaKkaSA20iIVV5jLqhJ+8DWKisfq1g==
X-Received: by 2002:a17:90a:240e:: with SMTP id h14mr1553379pje.9.1565863270769;
        Thu, 15 Aug 2019 03:01:10 -0700 (PDT)
Received: from localhost.localdomain (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id j12sm2152541pff.4.2019.08.15.03.01.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 03:01:10 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
To:     sathya.prakash@broadcom.com
Cc:     suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Balantzyan <mbalant3@gmail.com>
Subject: [PATCH v3] lsilogic mpt fusion: mptctl: Fixed race condition around mptctl_id variable using mutexes
Date:   Thu, 15 Aug 2019 03:00:50 -0700
Message-Id: <20190815100050.3924-1-mbalant3@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Certain functions in the driver, such as mptctl_do_fw_download() and
mptctl_do_mpt_command(), rely on the instance of mptctl_id, which does the
id-ing. There is race condition possible when these functions operate in
concurrency. Via, mutexes, the functions are mutually signalled to cooperate.

Changelog v2

Lacked a version number but added properly terminated else condition at
(former) line 2300.

Changelog v3

Fixes "return -EAGAIN" lines which were erroneously tabbed as if to be guarded
by "if" conditions lying above them.

Signed-off-by: Mark Balantzyan <mbalant3@gmail.com>

---
 drivers/message/fusion/mptctl.c | 43 +++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 4470630d..3270843c 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -816,12 +816,15 @@ mptctl_do_fw_download(int ioc, char __user *ufwbuf, size_t fwlen)
 
 		/*  Valid device. Get a message frame and construct the FW download message.
 	 	*/
+		mutex_lock(&mpctl_mutex);
 		if ((mf = mpt_get_msg_frame(mptctl_id, iocp)) == NULL)
-			return -EAGAIN;
+			mutex_unlock(&mpctl_mutex);
+		return -EAGAIN;
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
@@ -1889,8 +1894,10 @@ mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
 
 	/* Get a free request frame and save the message context.
 	 */
+	mutex_lock(&mpctl_mutex);
         if ((mf = mpt_get_msg_frame(mptctl_id, ioc)) == NULL)
-                return -EAGAIN;
+		mutex_unlock(&mpctl_mutex);
+        return -EAGAIN;
 
 	hdr = (MPIHeader_t *) mf;
 	msgContext = le32_to_cpu(hdr->MsgContext);
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
@@ -2287,8 +2297,11 @@ mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
 			}
 		}
 
-	} else
+	} else {
+		mutex_lock(&mpctl_mutex);
 		mpt_put_msg_frame(mptctl_id, ioc, mf);
+		mutex_unlock(&mpctl_mutex);
+	}
 
 	/* Now wait for the command to complete */
 	timeout = (karg.timeout > 0) ? karg.timeout : MPT_IOCTL_DEFAULT_TIMEOUT;
@@ -2563,7 +2576,9 @@ mptctl_hp_hostinfo(unsigned long arg, unsigned int data_size)
 	/* 
 	 * Gather ISTWI(Industry Standard Two Wire Interface) Data
 	 */
+	mutex_lock(&mpctl_mutex);
 	if ((mf = mpt_get_msg_frame(mptctl_id, ioc)) == NULL) {
+	mutex_unlock(&mpctl_mutex);
 		dfailprintk(ioc, printk(MYIOC_s_WARN_FMT
 			"%s, no msg frames!!\n", ioc->name, __func__));
 		goto out;
@@ -2593,7 +2608,9 @@ mptctl_hp_hostinfo(unsigned long arg, unsigned int data_size)
 	SET_MGMT_MSG_CONTEXT(ioc->ioctl_cmds.msg_context,
 				IstwiRWRequest->MsgContext);
 	INITIALIZE_MGMT_STATUS(ioc->ioctl_cmds.status)
+	mutex_lock(&mpctl_mutex);
 	mpt_put_msg_frame(mptctl_id, ioc, mf);
+	mutex_unlock(&mpctl_mutex);
 
 retry_wait:
 	timeleft = wait_for_completion_timeout(&ioc->ioctl_cmds.done,
@@ -3010,9 +3027,11 @@ static int __init mptctl_init(void)
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
@@ -3022,13 +3041,14 @@ static int __init mptctl_init(void)
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
 
@@ -3044,13 +3064,14 @@ out_fail:
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
 
@@ -3058,6 +3079,8 @@ static void mptctl_exit(void)
 	mpt_deregister(mptctl_taskmgmt_id);
 	mpt_deregister(mptctl_id);
 
+	mutex_unlock(&mpctl_mutex);
+
         mpt_device_driver_deregister(MPTCTL_DRIVER);
 
 }
-- 
2.17.1

