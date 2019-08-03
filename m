Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D1A80670
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbfHCOAX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43377 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHCOAW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id r26so1514367pgl.10
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tmqwx9/SkOq74hygAn4QdOSztCIfacQ5T68S4Gl8EP8=;
        b=LHZuG+UiPTuCXQsQ2JbEel9xYDEfhqLi4iB9hw3BPbqxiD8K1pItsADap616pWn50c
         MlNHkSg/mOB23HHLclrHKQraOGA4USntYSe0Ym+ATRDCwRlgg4TbgSgDNjG/InuGk/0V
         k+hCqomdcqcxkNu4WXt1jpy9Oa/0bSEA3vLt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tmqwx9/SkOq74hygAn4QdOSztCIfacQ5T68S4Gl8EP8=;
        b=EI6uKz6ZDKusqHdMsAPqJpN1Ge0XQK25PSa8A/pfywpjy5XOkTZ6825tXMt+lifrQ+
         Bsuk6O1tIyKmZgV70JH1usQ9RY0KCxrxo/eFTJzAZAmU3Wh5UAoMINrWrvZEw5dqpSVg
         GR19z33CNWVa8L7Xg4JvRNMNTgYLQGNXGa5rIgoGN0yZxfPVdbO8rEdCUh+aPYTRzVGi
         3P4H9+AaRfG08spvGkOOEz1OhfCE47I390G2s+1tb0WmLaq5VW6vyXX1uvwCIXoA09nc
         gz0Q5+P8eIvDR2KiralffUOHgjEx2HS1l6SosRfLkZD58Cx0kbZxz6Z1ENBOjjwhpkE3
         eSAg==
X-Gm-Message-State: APjAAAXELdJzFhpOQ9MH/gEqH9BzJwQ5VAkHLEaU2lTvnaMTWXNlGm+j
        PI2y71VKJEuD5OBlwzAH5h1dpNrtaFxeAntXDElKPsdlqSe3FI9lnoyAhuA+4NrL/fPoiJ4aA8t
        tgnyyFFiE+NDRvUAdH5X/cyY7GTqwIdmzjWho5qA9ohTfHLVr/8X0f9jpu6hqsiTcmxnb/df1Xd
        4VJDo5HG0ubJOFgaAREw==
X-Google-Smtp-Source: APXvYqwrdhcBQgGcbmzw3K6KNTLY3H1MTYdA9zm/v7dWKAnmnnwG36WeUFGGQvXwWEIi3uJbY7ISww==
X-Received: by 2002:a17:90a:2163:: with SMTP id a90mr8969055pje.3.1564840821726;
        Sat, 03 Aug 2019 07:00:21 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:21 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 05/12] mpt3sas: Enumerate SES of a managed PCIe switch
Date:   Sat,  3 Aug 2019 09:59:50 -0400
Message-Id: <1564840797-5876-6-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SES device of managed PCIe switch will be enumerated same as
NVMe drives.

The device info type for this SES device is
        MPI26_PCIE_DEVINFO_SCSI (0x4),
whereas the device info type for NVMe drives is
        MPI26_PCIE_DEVINFO_NVME (0x3).
So, based on this device info type driver determines whether the
device is NVMe drive or a SES device of a managed PCIe switch.

This SES device doesn't have the PCIe device page 2 information like
NVMe drives, so driver won't read PCIe device page 2 information for
SES device.

This SES device uses only IEEE SGL's, So driver build's IEEE SGL's
whenever it receives any SCSI commands for this SES device.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c  |  5 ++
 drivers/scsi/mpt3sas/mpt3sas_base.h  | 16 +++++++
 drivers/scsi/mpt3sas/mpt3sas_ctl.c   |  7 +--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 92 +++++++++++++++++++++++-------------
 4 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index a2a70a5..03d15f5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2260,6 +2260,11 @@ base_is_prp_possible(struct MPT3SAS_ADAPTER *ioc,
 	bool build_prp = true;
 
 	data_length = scsi_bufflen(scmd);
+	if (pcie_device &&
+	    (mpt3sas_scsih_is_pcie_scsi_device(pcie_device->device_info))) {
+		build_prp = false;
+		return build_prp;
+	}
 
 	/* If Datalenth is <= 16K and number of SGE’s entries are <= 2
 	 * we built IEEE SGL
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 5cd6148..66a68be 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1735,4 +1735,20 @@ mpt3sas_setup_direct_io(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd,
 /* NCQ Prio Handling Check */
 bool scsih_ncq_prio_supp(struct scsi_device *sdev);
 
+/**
+ * _scsih_is_pcie_scsi_device - determines if device is an pcie scsi device
+ * @device_info: bitfield providing information about the device.
+ * Context: none
+ *
+ * Returns 1 if scsi device.
+ */
+static inline int
+mpt3sas_scsih_is_pcie_scsi_device(u32 device_info)
+{
+	if ((device_info &
+	    MPI26_PCIE_DEVINFO_MASK_DEVICE_TYPE) == MPI26_PCIE_DEVINFO_SCSI)
+		return 1;
+	else
+		return 0;
+}
 #endif /* MPT3SAS_BASE_H_INCLUDED */
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index ea87871..29ecaa4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -654,7 +654,6 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	size_t data_in_sz = 0;
 	long ret;
 	u16 device_handle = MPT3SAS_INVALID_DEVICE_HANDLE;
-	u8 tr_method = MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE;
 
 	issue_reset = 0;
 
@@ -1049,12 +1048,14 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 			mpt3sas_halt_firmware(ioc);
 			pcie_device = mpt3sas_get_pdev_by_handle(ioc,
 				le16_to_cpu(mpi_request->FunctionDependent1));
-			if (pcie_device && (!ioc->tm_custom_handling))
+			if (pcie_device && (!ioc->tm_custom_handling) &&
+			    (!(mpt3sas_scsih_is_pcie_scsi_device(
+			    pcie_device->device_info))))
 				mpt3sas_scsih_issue_locked_tm(ioc,
 				  le16_to_cpu(mpi_request->FunctionDependent1),
 				  0, MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET, 0,
 				  0, pcie_device->reset_timeout,
-				  tr_method);
+			MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE);
 			else
 				mpt3sas_scsih_issue_locked_tm(ioc,
 				  le16_to_cpu(mpi_request->FunctionDependent1),
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 27c731a..f7610b8 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -1433,17 +1433,20 @@ _scsih_is_end_device(u32 device_info)
 }
 
 /**
- * _scsih_is_nvme_device - determines if device is an nvme device
+ * _scsih_is_nvme_pciescsi_device - determines if
+ *			device is an pcie nvme/scsi device
  * @device_info: bitfield providing information about the device.
  * Context: none
  *
- * Return: 1 if nvme device.
+ * Returns 1 if device is pcie device type nvme/scsi.
  */
 static int
-_scsih_is_nvme_device(u32 device_info)
+_scsih_is_nvme_pciescsi_device(u32 device_info)
 {
-	if ((device_info & MPI26_PCIE_DEVINFO_MASK_DEVICE_TYPE)
-					== MPI26_PCIE_DEVINFO_NVME)
+	if (((device_info & MPI26_PCIE_DEVINFO_MASK_DEVICE_TYPE)
+	    == MPI26_PCIE_DEVINFO_NVME) ||
+	    ((device_info & MPI26_PCIE_DEVINFO_MASK_DEVICE_TYPE)
+	    == MPI26_PCIE_DEVINFO_SCSI))
 		return 1;
 	else
 		return 0;
@@ -2872,7 +2875,8 @@ scsih_abort(struct scsi_cmnd *scmd)
 
 	handle = sas_device_priv_data->sas_target->handle;
 	pcie_device = mpt3sas_get_pdev_by_handle(ioc, handle);
-	if (pcie_device && (!ioc->tm_custom_handling))
+	if (pcie_device && (!ioc->tm_custom_handling) &&
+	    (!(mpt3sas_scsih_is_pcie_scsi_device(pcie_device->device_info))))
 		timeout = ioc->nvme_abort_timeout;
 	r = mpt3sas_scsih_issue_locked_tm(ioc, handle, scmd->device->lun,
 		MPI2_SCSITASKMGMT_TASKTYPE_ABORT_TASK,
@@ -2943,11 +2947,13 @@ scsih_dev_reset(struct scsi_cmnd *scmd)
 
 	pcie_device = mpt3sas_get_pdev_by_handle(ioc, handle);
 
-	if (pcie_device && (!ioc->tm_custom_handling)) {
+	if (pcie_device && (!ioc->tm_custom_handling) &&
+	    (!(mpt3sas_scsih_is_pcie_scsi_device(pcie_device->device_info)))) {
 		tr_timeout = pcie_device->reset_timeout;
 		tr_method = MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE;
 	} else
 		tr_method = MPI2_SCSITASKMGMT_MSGFLAGS_LINK_RESET;
+
 	r = mpt3sas_scsih_issue_locked_tm(ioc, handle, scmd->device->lun,
 		MPI2_SCSITASKMGMT_TASKTYPE_LOGICAL_UNIT_RESET, 0, 0,
 		tr_timeout, tr_method);
@@ -3020,7 +3026,8 @@ scsih_target_reset(struct scsi_cmnd *scmd)
 
 	pcie_device = mpt3sas_get_pdev_by_handle(ioc, handle);
 
-	if (pcie_device && (!ioc->tm_custom_handling)) {
+	if (pcie_device && (!ioc->tm_custom_handling) &&
+	    (!(mpt3sas_scsih_is_pcie_scsi_device(pcie_device->device_info)))) {
 		tr_timeout = pcie_device->reset_timeout;
 		tr_method = MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE;
 	} else
@@ -3598,7 +3605,9 @@ _scsih_tm_tr_send(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 			sas_address = pcie_device->wwid;
 		}
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
-		if (pcie_device && (!ioc->tm_custom_handling))
+		if (pcie_device && (!ioc->tm_custom_handling) &&
+		    (!(mpt3sas_scsih_is_pcie_scsi_device(
+		    pcie_device->device_info))))
 			tr_method =
 			    MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE;
 		else
@@ -6694,7 +6703,7 @@ _scsih_pcie_check_device(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 
 	/* check if this is end device */
 	device_info = le32_to_cpu(pcie_device_pg0.DeviceInfo);
-	if (!(_scsih_is_nvme_device(device_info)))
+	if (!(_scsih_is_nvme_pciescsi_device(device_info)))
 		return;
 
 	wwid = le64_to_cpu(pcie_device_pg0.WWID);
@@ -6803,7 +6812,8 @@ _scsih_pcie_add_device(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	    pcie_device_pg0.AccessStatus))
 		return 0;
 
-	if (!(_scsih_is_nvme_device(le32_to_cpu(pcie_device_pg0.DeviceInfo))))
+	if (!(_scsih_is_nvme_pciescsi_device(le32_to_cpu
+	    (pcie_device_pg0.DeviceInfo))))
 		return 0;
 
 	pcie_device = mpt3sas_get_pdev_by_wwid(ioc, wwid);
@@ -6813,6 +6823,31 @@ _scsih_pcie_add_device(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 		return 0;
 	}
 
+	/* PCIe Device Page 2 contains read-only information about a
+	 * specific NVMe device; therefore, this page is only
+	 * valid for NVMe devices and skip for pcie devices of type scsi.
+	 */
+	if (!(mpt3sas_scsih_is_pcie_scsi_device(
+		le32_to_cpu(pcie_device_pg0.DeviceInfo)))) {
+		if (mpt3sas_config_get_pcie_device_pg2(ioc, &mpi_reply,
+		    &pcie_device_pg2, MPI2_SAS_DEVICE_PGAD_FORM_HANDLE,
+		    handle)) {
+			ioc_err(ioc,
+			    "failure at %s:%d/%s()!\n", __FILE__,
+			    __LINE__, __func__);
+			return 0;
+		}
+
+		ioc_status = le16_to_cpu(mpi_reply.IOCStatus) &
+					MPI2_IOCSTATUS_MASK;
+		if (ioc_status != MPI2_IOCSTATUS_SUCCESS) {
+			ioc_err(ioc,
+			    "failure at %s:%d/%s()!\n", __FILE__,
+			    __LINE__, __func__);
+			return 0;
+		}
+	}
+
 	pcie_device = kzalloc(sizeof(struct _pcie_device), GFP_KERNEL);
 	if (!pcie_device) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -6855,27 +6890,16 @@ _scsih_pcie_add_device(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 			    le64_to_cpu(enclosure_dev->pg0.EnclosureLogicalID);
 	}
 	/* TODO -- Add device name once FW supports it */
-	if (mpt3sas_config_get_pcie_device_pg2(ioc, &mpi_reply,
-		&pcie_device_pg2, MPI2_SAS_DEVICE_PGAD_FORM_HANDLE, handle)) {
-		ioc_err(ioc, "failure at %s:%d/%s()!\n",
-			__FILE__, __LINE__, __func__);
-		kfree(pcie_device);
-		return 0;
-	}
-
-	ioc_status = le16_to_cpu(mpi_reply.IOCStatus) & MPI2_IOCSTATUS_MASK;
-	if (ioc_status != MPI2_IOCSTATUS_SUCCESS) {
-		ioc_err(ioc, "failure at %s:%d/%s()!\n",
-			__FILE__, __LINE__, __func__);
-		kfree(pcie_device);
-		return 0;
-	}
-	pcie_device->nvme_mdts =
-		le32_to_cpu(pcie_device_pg2.MaximumDataTransferSize);
-	if (pcie_device_pg2.ControllerResetTO)
-		pcie_device->reset_timeout =
-			pcie_device_pg2.ControllerResetTO;
-	else
+	if (!(mpt3sas_scsih_is_pcie_scsi_device(
+	    le32_to_cpu(pcie_device_pg0.DeviceInfo)))) {
+		pcie_device->nvme_mdts =
+		    le32_to_cpu(pcie_device_pg2.MaximumDataTransferSize);
+		if (pcie_device_pg2.ControllerResetTO)
+			pcie_device->reset_timeout =
+			    pcie_device_pg2.ControllerResetTO;
+		else
+			pcie_device->reset_timeout = 30;
+	} else
 		pcie_device->reset_timeout = 30;
 
 	if (ioc->wait_for_discovery_to_complete)
@@ -8594,7 +8618,7 @@ _scsih_search_responding_pcie_devices(struct MPT3SAS_ADAPTER *ioc)
 		}
 		handle = le16_to_cpu(pcie_device_pg0.DevHandle);
 		device_info = le32_to_cpu(pcie_device_pg0.DeviceInfo);
-		if (!(_scsih_is_nvme_device(device_info)))
+		if (!(_scsih_is_nvme_pciescsi_device(device_info)))
 			continue;
 		_scsih_mark_responding_pcie_device(ioc, &pcie_device_pg0);
 	}
@@ -9175,7 +9199,7 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 			break;
 		}
 		handle = le16_to_cpu(pcie_device_pg0.DevHandle);
-		if (!(_scsih_is_nvme_device(
+		if (!(_scsih_is_nvme_pciescsi_device(
 			le32_to_cpu(pcie_device_pg0.DeviceInfo))))
 			continue;
 		pcie_device = mpt3sas_get_pdev_by_wwid(ioc,
-- 
1.8.3.1

