Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7E364019
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Apr 2021 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhDSLCo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 07:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDSLCl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 07:02:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2224DC061760
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 04:02:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 20so13523955pll.7
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZNxQJIhRoVKmm4tyjT+6vp5ddjrismbLRPFOu1YRY+8=;
        b=FtpJmHA11xsQJ1mH7oZou1C/5d/PbWfFnqDmajoFg9ccV77/QIkpf5A9LuoEuG7aTq
         AchwQgGqzMkCljmBSzyLPnFvsjzoaMeaEsh8YopepyGc7LI/BtGM7r9l6HHrKyq2Ea/h
         xfeE+w2hidUsG/je2hqWu6FzR6UFJicALADjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZNxQJIhRoVKmm4tyjT+6vp5ddjrismbLRPFOu1YRY+8=;
        b=o0D3yWX9RFCV/sx+32W9Yk7c/+QNMRKsLluWMY10LSTDMeCdbxzFCytSDzazQGDoAX
         Vd2hDnBvhx3hIQEs6a85kFYsC0B/2lnEYQS+eNYz6OJYLWlXv6eeePeX7xvnQBvLKcnr
         CN9DWeKKQIRzKHLv4WzLtU7BW6jWkJQ/PqOypW5z3VFJQ1eqYtN9NWxnX6Eg/g8eMInE
         YGTIIuPkqIi/fqOP7IHVb9JFd4l0pzcIXdZT/Ujv+FOXfKE3nuet61GrAOWkalSApRJA
         zzaSXi1ONFyMnkIZZt10v78eLDXTqGKgzPtrhD0AtdrlPmmJlwU0zJLMNCtBu9h1+XjY
         HiZA==
X-Gm-Message-State: AOAM5334eK772rkav+wcs/KAmewRaIcJKjRGttyQHqNJKQRefs76kmHq
        wexYfX8bbuADtJsJTMQehjkggc7VTK92iW4AfuV1arp4X3leVU6Dy6p3C8iOAZszIxYCZIZtpnm
        LDWX4TxA7RqteOaQj5PgaMb9KdeRrSvutWprcqIULsPpc5saDvcsLyuouTke8dRsyVicGgfAXQf
        QL2wBaCIS6
X-Google-Smtp-Source: ABdhPJxs+4ekp2cuaKLsaiLgj7nDpLhU2kOrCwmu3onyfFzUHCuTQONAym9HAXxSFJc5ScTAU3qVXQ==
X-Received: by 2002:a17:90a:ab02:: with SMTP id m2mr8021253pjq.194.1618830131135;
        Mon, 19 Apr 2021 04:02:11 -0700 (PDT)
Received: from drv-bst-rhel8.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k13sm11825736pfc.50.2021.04.19.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:02:10 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        sathya.prakash@broadcom.com
Subject: [PATCH v3 05/24] mpi3mr: add support of internal watchdog thread
Date:   Mon, 19 Apr 2021 16:31:37 +0530
Message-Id: <20210419110156.1786882-6-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210419110156.1786882-1-kashyap.desai@broadcom.com>
References: <20210419110156.1786882-1-kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f275a105c05142fe"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000f275a105c05142fe

Watchdog thread is driver's internal thread which does few things like
detecting FW fault and reset the controller, Timestamp sync etc.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Cc: sathya.prakash@broadcom.com
---
 drivers/scsi/mpi3mr/mpi3mr.h    |  11 +++
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 125 ++++++++++++++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr_os.c |   3 +
 3 files changed, 139 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 00a1b63a6e16..7769ba16c9bc 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -478,6 +478,10 @@ struct scmd_priv {
  * @sense_buf_q_dma: Sense buffer queue DMA address
  * @sbq_lock: Sense buffer queue lock
  * @sbq_host_index: Sense buffer queuehost index
+ * @watchdog_work_q_name: Fault watchdog worker thread name
+ * @watchdog_work_q: Fault watchdog worker thread
+ * @watchdog_work: Fault watchdog work
+ * @watchdog_lock: Fault watchdog lock
  * @is_driver_loading: Is driver still loading
  * @scan_started: Async scan started
  * @scan_failed: Asycn scan failed
@@ -491,6 +495,7 @@ struct scmd_priv {
  * @chain_buf_lock: Chain buffer list lock
  * @reset_in_progress: Reset in progress flag
  * @unrecoverable: Controller unrecoverable flag
+ * @diagsave_timeout: Diagnostic information save timeout
  * @logging_level: Controller debug logging level
  * @current_event: Firmware event currently in process
  * @driver_info: Driver, Kernel, OS information to firmware
@@ -572,6 +577,11 @@ struct mpi3mr_ioc {
 	spinlock_t sbq_lock;
 	u32 sbq_host_index;
 
+	char watchdog_work_q_name[20];
+	struct workqueue_struct *watchdog_work_q;
+	struct delayed_work watchdog_work;
+	spinlock_t watchdog_lock;
+
 	u8 is_driver_loading;
 	u8 scan_started;
 	u16 scan_failed;
@@ -589,6 +599,7 @@ struct mpi3mr_ioc {
 	u8 reset_in_progress;
 	u8 unrecoverable;
 
+	u16 diagsave_timeout;
 	int logging_level;
 
 	struct mpi3mr_fwevt *current_event;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 787483fc60eb..4c45e12154d6 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1475,6 +1475,129 @@ int mpi3mr_op_request_post(struct mpi3mr_ioc *mrioc,
 	return retval;
 }
 
+/**
+ * mpi3mr_watchdog_work - watchdog thread to monitor faults
+ * @work: work struct
+ *
+ * Watch dog work periodically executed (1 second interval) to
+ * monitor firmware fault and to issue periodic timer sync to
+ * the firmware.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_watchdog_work(struct work_struct *work)
+{
+	struct mpi3mr_ioc *mrioc =
+	    container_of(work, struct mpi3mr_ioc, watchdog_work.work);
+	unsigned long flags;
+	enum mpi3mr_iocstate ioc_state;
+	u32 fault, host_diagnostic;
+
+	/*Check for fault state every one second and issue Soft reset*/
+	ioc_state = mpi3mr_get_iocstate(mrioc);
+	if (ioc_state == MRIOC_STATE_FAULT) {
+		fault = readl(&mrioc->sysif_regs->Fault) &
+		    MPI3_SYSIF_FAULT_CODE_MASK;
+		host_diagnostic = readl(&mrioc->sysif_regs->HostDiagnostic);
+		if (host_diagnostic & MPI3_SYSIF_HOST_DIAG_SAVE_IN_PROGRESS) {
+			if (!mrioc->diagsave_timeout) {
+				mpi3mr_print_fault_info(mrioc);
+				ioc_warn(mrioc, "Diag save in progress\n");
+			}
+			if ((mrioc->diagsave_timeout++) <=
+			    MPI3_SYSIF_DIAG_SAVE_TIMEOUT)
+				goto schedule_work;
+		} else
+			mpi3mr_print_fault_info(mrioc);
+		mrioc->diagsave_timeout = 0;
+
+		if (fault == MPI3_SYSIF_FAULT_CODE_FACTORY_RESET) {
+			ioc_info(mrioc,
+			    "Factory Reset Fault occurred marking controller as unrecoverable"
+			    );
+			mrioc->unrecoverable = 1;
+			goto out;
+		}
+
+		if ((fault == MPI3_SYSIF_FAULT_CODE_DIAG_FAULT_RESET)
+		    || (fault == MPI3_SYSIF_FAULT_CODE_SOFT_RESET_IN_PROGRESS)
+		    || (mrioc->reset_in_progress))
+			goto out;
+		if (fault == MPI3_SYSIF_FAULT_CODE_CI_ACTIVATION_RESET)
+			mpi3mr_soft_reset_handler(mrioc,
+			    MPI3MR_RESET_FROM_CIACTIV_FAULT, 0);
+		else
+			mpi3mr_soft_reset_handler(mrioc,
+			    MPI3MR_RESET_FROM_FAULT_WATCH, 0);
+	}
+
+schedule_work:
+	spin_lock_irqsave(&mrioc->watchdog_lock, flags);
+	if (mrioc->watchdog_work_q)
+		queue_delayed_work(mrioc->watchdog_work_q,
+		    &mrioc->watchdog_work,
+		    msecs_to_jiffies(MPI3MR_WATCHDOG_INTERVAL));
+	spin_unlock_irqrestore(&mrioc->watchdog_lock, flags);
+out:
+	return;
+}
+
+/**
+ * mpi3mr_start_watchdog - Start watchdog
+ * @mrioc: Adapter instance reference
+ *
+ * Create and start the watchdog thread to monitor controller
+ * faults.
+ *
+ * Return: Nothing.
+ */
+void mpi3mr_start_watchdog(struct mpi3mr_ioc *mrioc)
+{
+	if (mrioc->watchdog_work_q)
+		return;
+
+	INIT_DELAYED_WORK(&mrioc->watchdog_work, mpi3mr_watchdog_work);
+	snprintf(mrioc->watchdog_work_q_name,
+	    sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
+	    mrioc->id);
+	mrioc->watchdog_work_q =
+	    create_singlethread_workqueue(mrioc->watchdog_work_q_name);
+	if (!mrioc->watchdog_work_q) {
+		ioc_err(mrioc, "%s: failed (line=%d)\n", __func__, __LINE__);
+		return;
+	}
+
+	if (mrioc->watchdog_work_q)
+		queue_delayed_work(mrioc->watchdog_work_q,
+		    &mrioc->watchdog_work,
+		    msecs_to_jiffies(MPI3MR_WATCHDOG_INTERVAL));
+}
+
+/**
+ * mpi3mr_stop_watchdog - Stop watchdog
+ * @mrioc: Adapter instance reference
+ *
+ * Stop the watchdog thread created to monitor controller
+ * faults.
+ *
+ * Return: Nothing.
+ */
+void mpi3mr_stop_watchdog(struct mpi3mr_ioc *mrioc)
+{
+	unsigned long flags;
+	struct workqueue_struct *wq;
+
+	spin_lock_irqsave(&mrioc->watchdog_lock, flags);
+	wq = mrioc->watchdog_work_q;
+	mrioc->watchdog_work_q = NULL;
+	spin_unlock_irqrestore(&mrioc->watchdog_lock, flags);
+	if (wq) {
+		if (!cancel_delayed_work_sync(&mrioc->watchdog_work))
+			flush_workqueue(wq);
+		destroy_workqueue(wq);
+	}
+}
+
 
 /**
  * mpi3mr_setup_admin_qpair - Setup admin queue pair
@@ -2631,6 +2754,8 @@ void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc)
 {
 	enum mpi3mr_iocstate ioc_state;
 
+	mpi3mr_stop_watchdog(mrioc);
+
 	mpi3mr_ioc_disable_intr(mrioc);
 
 	ioc_state = mpi3mr_get_iocstate(mrioc);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 01be5f337826..7b0d52481929 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -570,6 +570,7 @@ static int mpi3mr_scan_finished(struct Scsi_Host *shost,
 	if (mrioc->scan_started)
 		return 0;
 	ioc_info(mrioc, "%s :port enable: SUCCESS\n", __func__);
+	mpi3mr_start_watchdog(mrioc);
 	mrioc->is_driver_loading = 0;
 
 	return 1;
@@ -856,9 +857,11 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&mrioc->admin_req_lock);
 	spin_lock_init(&mrioc->reply_free_queue_lock);
 	spin_lock_init(&mrioc->sbq_lock);
+	spin_lock_init(&mrioc->watchdog_lock);
 	spin_lock_init(&mrioc->chain_buf_lock);
 
 	mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
+
 	if (pdev->revision)
 		mrioc->enable_segqueue = true;
 
-- 
2.18.1


--000000000000f275a105c05142fe
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFiXUAojrNKGWpYtxtWd7DbVIbo0
sgwbMz3BfaQpMcllMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQxOTExMDIxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBtpu9DT/xDo91dRZMcVVNF0KwQM8DUncSShQVAVPqgpOO+
XHFL/xX4qSWGAIammJJzSIZZQMmLXMgY38eUhuBxK/nALyIc74nSLXkYEcviyG5bIbr3G00+HmgJ
EIkRfH/Dz3VmTin46DOJ8dzlAP0+JtG4HI4BTBypVO8zEdTTQoQ+K/uljcTmcRqtfUs92SAEQFLf
80EXTfRzOeo8pf4M3JtmXBkNWPHhRWQxm7Rdd9XwgHCw7NkR7FnmjMFnXBJUd4j5H5RAeuwAQGal
IzQguzfTap7fnUiR7akyGTVxl1dqnHIypqAxEGASmSGWySP6NqWkgTlhI3fB4PpT8gjF
--000000000000f275a105c05142fe--
