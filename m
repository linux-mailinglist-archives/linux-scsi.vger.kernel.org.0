Return-Path: <linux-scsi+bounces-5731-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE3907BFC
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2024 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5772D1F2437A
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2024 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21EE14B94F;
	Thu, 13 Jun 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AJfme48G"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989CF9F8
	for <linux-scsi@vger.kernel.org>; Thu, 13 Jun 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305465; cv=none; b=CltY2UGKVA8NBFVxVjqLysy/A5YVbdnXmirvR2o8iDPsmvbjTEVINLERCUNMbGjJwH6tpvJwlpyceIv54QQ4EtAKUmtx0/4ampFSLVaZhMVmq1pk36eLjsfwotBC2ooV5uqxuIhKcrz2+BkW221cq1WeYE/uSB5zstlYkb6jylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305465; c=relaxed/simple;
	bh=w+c8N3EtcBhNWmmnINWY+BmWEEj5Qvry1xjjQub//aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIIcU8+VGuEusqI3YkOlWwYfJRS8yOeKisrvjt3zW8F3zrazdDBLyL0P2MHK+a79H6N8rvLIPLD7BlvpUIJj4b8LfIpMqhrMbhqMBqAHK4SmTLpZdnqBObH0XrjUqdRxVbkUv026ACRhtqtjdLPEyV9fMDS0t++H63p7Y2EcA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AJfme48G; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6e183f084so10941115ad.1
        for <linux-scsi@vger.kernel.org>; Thu, 13 Jun 2024 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718305463; x=1718910263; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=US5A9me3mxLMt6n8DXgFGsYk/Xyv1VqDW/Nh6QOR5Ww=;
        b=AJfme48Got/irbsZCiTGcdqVHKYJMinBfZjv3T249YzYW8cSMmYkNGLR21MdYRZkCA
         5XaJGRRAbMwsjuXCxLxXPWQP2apnsrnKoDfBwHeXkVreGGClpyN6NgSw/+5O9RU1w7pW
         AUTGxoKAbKvoCi3seewDWJhqwX0Y+vu0veLEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305463; x=1718910263;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=US5A9me3mxLMt6n8DXgFGsYk/Xyv1VqDW/Nh6QOR5Ww=;
        b=aEUzwMyHcjCYPkRXq12G0BNyWLhDpXY3S2CjcR0u8Ks5xMCCKlSTz6YZSID78FM6sn
         v2YTSMPCb9KU1VrADsPBhdEeK/h054LtLD1+Vx7wqDbCdDpeUzVLwYUspCJYKlJ7R0W/
         ZxNa7gjFLLIUFehabgUdZEghpRJBGo+fwJcBa2r9gkpHNUWzUCZBl1QENUXBhzQUD89N
         H7vubo7Sk75x5HzAJW7UCLHENA4jRgBDDEDEQkQcmNbEa8DK90S4ovVjLqP7sr4aQbBo
         WxZ9EZg4tSD5mFl0bwR6fxEudgBWMHUPYRCjPGngTs7OxYVXETAixQWXJmvYgB8dXo8v
         M7xQ==
X-Gm-Message-State: AOJu0Yxxym2ufe64FIB5/Etgr3y208UbEXjckwtWQbzPkZHvmhjv4oCg
	qTZoUtKF1rkIWlg9Kwvb3zzH/TyEDyWR7VR98a5AD23CqSci8B4PLubWDlIT+Q==
X-Google-Smtp-Source: AGHT+IHg2g6TysQQxQsRv88QKCRGZH+ClL/vPVq5MZqh9NXgC6ZuoHNSmUqUDyL0VpHVysasVJxmbg==
X-Received: by 2002:a17:902:eccc:b0:1f7:5a6c:ae3e with SMTP id d9443c01a7336-1f8627e337dmr8346425ad.33.1718305463084;
        Thu, 13 Jun 2024 12:04:23 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f16a3esm17366905ad.232.2024.06.13.12.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:04:22 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	helgaas@kernel.org,
	sathya.prakash@broadcom.com,
	chandrakanth.patil@broadcom.com,
	ranjan.kumar@broadcom.com,
	prayas.patel@broadcom.com
Cc: linux-scsi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v3 1/3] mpi3mr: Support PCIe Error Recovery callback handlers
Date: Fri, 14 Jun 2024 00:30:20 +0530
Message-Id: <20240613190022.4128-2-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240613190022.4128-1-sumit.saxena@broadcom.com>
References: <20240613190022.4128-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c5a90e061aca2a64"

--000000000000c5a90e061aca2a64
Content-Transfer-Encoding: 8bit

This patch adds support for the PCIe error recovery callback handlers which is
crucial for the recovery of the controllers. This feature is necessary for
addressing the errors reported by the PCI Error Recovery mechanism.

Signed-off-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr.h    |   7 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c | 221 ++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 8255ef1854ac..a2c236babb52 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -23,6 +23,7 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -130,6 +131,7 @@ extern atomic64_t event_counter;
 #define MPI3MR_PREPARE_FOR_RESET_TIMEOUT	180
 #define MPI3MR_RESET_ACK_TIMEOUT		30
 #define MPI3MR_MUR_TIMEOUT			120
+#define MPI3MR_RESET_TIMEOUT			510
 
 #define MPI3MR_WATCHDOG_INTERVAL		1000 /* in milli seconds */
 
@@ -1173,7 +1175,8 @@ struct scmd_priv {
  * @trace_release_trigger_active: Trace trigger active flag
  * @fw_release_trigger_active: Fw release trigger active flag
  * @snapdump_trigger_active: Snapdump trigger active flag
- *
+ * @pci_err_recovery: PCI error recovery in progress
+ * @block_on_pci_err: Block IO during PCI error recovery
  */
 struct mpi3mr_ioc {
 	struct list_head list;
@@ -1377,6 +1380,8 @@ struct mpi3mr_ioc {
 	bool snapdump_trigger_active;
 	bool trace_release_trigger_active;
 	bool fw_release_trigger_active;
+	bool pci_err_recovery;
+	bool block_on_pci_err;
 };
 
 /**
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index eac179dc9370..9e532467faf1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5546,6 +5546,219 @@ mpi3mr_resume(struct device *dev)
 	return 0;
 }
 
+/**
+ * mpi3mr_pcierr_detected - PCI error detected callback
+ * @pdev: PCI device instance
+ * @state: channel state
+ *
+ * This function is called by the PCI error recovery driver and
+ * based on the state passed the driver decides what actions to
+ * be recommended back to PCI driver.
+ *
+ * For all of the states if there is no valid mrioc or scsi host
+ * references in the PCI device then this function will return
+ * the result as disconnect.
+ *
+ * For normal state, this function will return the result as can
+ * recover.
+ *
+ * For frozen state, this function will block for any pending
+ * controller initialization or re-initialization to complete,
+ * stop any new interactions with the controller and return
+ * status as reset required.
+ *
+ * For permanent failure state, this function will mark the
+ * controller as unrecoverable and return status as disconnect.
+ *
+ * Returns: PCI_ERS_RESULT_NEED_RESET or CAN_RECOVER or
+ * DISCONNECT based on the controller state.
+ */
+static pci_ers_result_t
+mpi3mr_pcierr_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	struct Scsi_Host *shost;
+	struct mpi3mr_ioc *mrioc;
+	unsigned int timeout = MPI3MR_RESET_TIMEOUT;
+
+	dev_info(&pdev->dev, "%s: callback invoked state(%d)\n", __func__,
+	    state);
+
+	shost = pci_get_drvdata(pdev);
+	mrioc = shost_priv(shost);
+
+	if (!shost || !mrioc) {
+		dev_err(&pdev->dev, "device not available\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		mrioc->pci_err_recovery = true;
+		mrioc->block_on_pci_err = true;
+		do {
+			if (mrioc->reset_in_progress || mrioc->is_driver_loading)
+				ssleep(1);
+			else
+				break;
+		} while (--timeout);
+
+		if (!timeout) {
+			mrioc->pci_err_recovery = true;
+			mrioc->block_on_pci_err = true;
+			mrioc->unrecoverable = 1;
+			mpi3mr_stop_watchdog(mrioc);
+			mpi3mr_flush_cmds_for_unrecovered_controller(mrioc);
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
+
+		scsi_block_requests(mrioc->shost);
+		mpi3mr_stop_watchdog(mrioc);
+		mpi3mr_cleanup_resources(mrioc);
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		mrioc->pci_err_recovery = true;
+		mrioc->block_on_pci_err = true;
+		mrioc->unrecoverable = 1;
+		mpi3mr_stop_watchdog(mrioc);
+		mpi3mr_flush_cmds_for_unrecovered_controller(mrioc);
+		return PCI_ERS_RESULT_DISCONNECT;
+	default:
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+}
+
+/**
+ * mpi3mr_pcierr_slot_reset - Post slot reset callback
+ * @pdev: PCI device instance
+ *
+ * This function is called by the PCI error recovery driver
+ * after a slot or link reset issued by it for the recovery, the
+ * driver is expected to bring back the controller and
+ * initialize it.
+ *
+ * This function restores PCI state and reinitializes controller
+ * resources and the controller, this blocks for any pending
+ * reset to complete.
+ *
+ * Returns: PCI_ERS_RESULT_DISCONNECT on failure or
+ * PCI_ERS_RESULT_RECOVERED
+ */
+static pci_ers_result_t mpi3mr_pcierr_slot_reset(struct pci_dev *pdev)
+{
+	struct Scsi_Host *shost;
+	struct mpi3mr_ioc *mrioc;
+	unsigned int timeout = MPI3MR_RESET_TIMEOUT;
+
+	dev_info(&pdev->dev, "%s: callback invoked\n", __func__);
+
+	shost = pci_get_drvdata(pdev);
+	mrioc = shost_priv(shost);
+
+	if (!shost || !mrioc) {
+		dev_err(&pdev->dev, "device not available\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	do {
+		if (mrioc->reset_in_progress)
+			ssleep(1);
+		else
+			break;
+	} while (--timeout);
+
+	if (!timeout)
+		goto out_failed;
+
+	pci_restore_state(pdev);
+
+	if (mpi3mr_setup_resources(mrioc)) {
+		ioc_err(mrioc, "setup resources failed\n");
+		goto out_failed;
+	}
+	mrioc->unrecoverable = 0;
+	mrioc->pci_err_recovery = false;
+
+	if (mpi3mr_soft_reset_handler(mrioc, MPI3MR_RESET_FROM_FIRMWARE, 0))
+		goto out_failed;
+
+	return PCI_ERS_RESULT_RECOVERED;
+
+out_failed:
+	mrioc->unrecoverable = 1;
+	mrioc->block_on_pci_err = false;
+	scsi_unblock_requests(shost);
+	mpi3mr_start_watchdog(mrioc);
+	return PCI_ERS_RESULT_DISCONNECT;
+}
+
+/**
+ * mpi3mr_pcierr_resume - PCI error recovery resume
+ * callback
+ * @pdev: PCI device instance
+ *
+ * This function enables all I/O and IOCTLs post reset issued as
+ * part of the PCI error recovery
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_pcierr_resume(struct pci_dev *pdev)
+{
+	struct Scsi_Host *shost;
+	struct mpi3mr_ioc *mrioc;
+
+	dev_info(&pdev->dev, "%s: callback invoked\n", __func__);
+
+	shost = pci_get_drvdata(pdev);
+	mrioc = shost_priv(shost);
+
+	if (!shost || !mrioc) {
+		dev_err(&pdev->dev, "device not available\n");
+		return;
+	}
+
+	pci_aer_clear_nonfatal_status(pdev);
+
+	if (mrioc->block_on_pci_err) {
+		mrioc->block_on_pci_err = false;
+		scsi_unblock_requests(shost);
+		mpi3mr_start_watchdog(mrioc);
+	}
+}
+
+/**
+ * mpi3mr_pcierr_mmio_enabled - PCI error recovery callback
+ * @pdev: PCI device instance
+ *
+ * This is called only if _pcierr_error_detected returns
+ * PCI_ERS_RESULT_CAN_RECOVER.
+ *
+ * Return: PCI_ERS_RESULT_DISCONNECT when the controller is
+ * unrecoverable or when the shost/mrioc reference cannot be
+ * found, else return PCI_ERS_RESULT_RECOVERED
+ */
+static pci_ers_result_t mpi3mr_pcierr_mmio_enabled(struct pci_dev *pdev)
+{
+	struct Scsi_Host *shost;
+	struct mpi3mr_ioc *mrioc;
+
+	dev_info(&pdev->dev, "%s: callback invoked\n", __func__);
+
+	shost = pci_get_drvdata(pdev);
+	mrioc = shost_priv(shost);
+
+	if (!shost || !mrioc) {
+		dev_err(&pdev->dev, "device not available\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	if (mrioc->unrecoverable)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static const struct pci_device_id mpi3mr_pci_id_table[] = {
 	{
 		PCI_DEVICE_SUB(MPI3_MFGPAGE_VENDORID_BROADCOM,
@@ -5563,6 +5776,13 @@ static const struct pci_device_id mpi3mr_pci_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, mpi3mr_pci_id_table);
 
+static struct pci_error_handlers mpi3mr_err_handler = {
+	.error_detected = mpi3mr_pcierr_detected,
+	.mmio_enabled = mpi3mr_pcierr_mmio_enabled,
+	.slot_reset = mpi3mr_pcierr_slot_reset,
+	.resume = mpi3mr_pcierr_resume,
+};
+
 static SIMPLE_DEV_PM_OPS(mpi3mr_pm_ops, mpi3mr_suspend, mpi3mr_resume);
 
 static struct pci_driver mpi3mr_pci_driver = {
@@ -5571,6 +5791,7 @@ static struct pci_driver mpi3mr_pci_driver = {
 	.probe = mpi3mr_probe,
 	.remove = mpi3mr_remove,
 	.shutdown = mpi3mr_shutdown,
+	.err_handler = &mpi3mr_err_handler,
 	.driver.pm = &mpi3mr_pm_ops,
 };
 
-- 
2.31.1


--000000000000c5a90e061aca2a64
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
1J8x62/iEVbCstJaE1Nt3oXnL5yBlqX1Ihp8cZLe1weS7Wp/v5Jg2Ks13jeYOKW45xXExpqPPd1f
3meFjTf9K+rGZHb63htWaJtf0NYbE+5yIbXFv21cBxECAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZc3VtaXQuc2F4ZW5hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUTIFIrhFDaoMEbXuV9O+Y+XgS
kVwwDQYJKoZIhvcNAQELBQADggEBAFyioHqB2PHWcQ5cU8nprPRk37uSWK2x0w7W50jjc0cooz6G
G6pltJ+DvbG7XIzCU8cKHmuyAxoe1+/vhB8yJH78MVdfKDDND7zL/IqfhZedxHcHG5jVqbVH/ufu
H19y4fHxo5bLkybX3UxkN9b3bMsBZ4FFCLSCFgFfjI0BmTx6IoGyi0R89rzD0H1rURy7WTn0ijl1
nERsqENeyGfUTJLcDSURb49qpFqqWweJ7ifC64Iak8wCK2CxCe8lHfTyEgC9MuEa586NMQJDguvw
jlC7kxrgwf4sZ/9Wj/GS2HLzZPkxWCcQIrgNJm2wceHQwPBpM0ZoqL1D2tsFgOA8BvYxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwdgevXLIdo6fbCNI8w
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKuJx3MFDx6Yz2sV8UIpPHobmloAl8hm
LuZ7uvZvd/WaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYx
MzE5MDQyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAcXkH7NTOY+qQBH7flHnh3Rx/iqqRVHVJP+O58SGWG/GovE0lP
/AWlMGuUhrEo47ElrFfi6FmJWNh4DlxOdgdZSGzhsousXu4MJ4LtaBpdwI+Nq12t72DaYP3wydBW
N580KcKKxlRNgPTmFX9sdtLFDmlHEWpjlO1ce8olh/qCgFidqYyXWHHD44efO3j24XwLhxTClvo4
6BqDcmrQ9c3Nf5rvdHOhlAy5wgEy+ObJBH8dzk7ICXv+Syn/ggYviX2Vsp9G6lUhCPs1K8sxGqxw
jV1ITzCupcLkyZ197sb7OCN2wSNlMDcHtO20hPsRFrl4ynHDuQ5W2lGy0AYI8wAd
--000000000000c5a90e061aca2a64--

