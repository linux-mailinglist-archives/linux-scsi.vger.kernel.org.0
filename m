Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567E480671
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391060AbfHCOAZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40247 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391048AbfHCOAZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so37423378pfp.7
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=St9MEIkrv8Xz87oSli+iSLjsQPV39f+9VQxA9HZnemo=;
        b=dLNcuemzHtQzWg4zdxbKvQlWn6EzHj6hEgIRmI0ywU3f4eksf6WrIiGjdKKyFcjkkJ
         jn9ZxniRHG7wvggX55OmsMQivE4EAfykfkpCvShktNXh8WGXHuJF4DpensrQ4xsvT3p1
         naJXI7I34+QTdGQ3+oRFbp8a0veFNaE3V+ICo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=St9MEIkrv8Xz87oSli+iSLjsQPV39f+9VQxA9HZnemo=;
        b=eSovvb6sGwjFVxyq41dh9sw3bKFG5oyl25ECgAFSDOjcY0VI6eQPsuYlPDOU+1Aehe
         dBrM/Zm/4+nY6yqBcUg0yQpePOe9XWIDlvhWdWKw2PCzND84SBN/GUnQwk32mqiDNTvr
         2NhiMp6jNTTFR3eocbZ7zoCD4YQZZsLuxPPYKX6TcJRnoE4Ip+g5yi9OJbUF0WzLroSa
         swtzJ1+nrSc9f41DhbulFuTjrDjetU7dBrAoqyxTA4ZuViF58sNzaiAKAv6dB0Ey1qAo
         f7O3xAp6dgCyVqnw4CWiS+SNyZSya3tTTu1t6Nr9gRoy5oCTJIGIQaGiWLOZbpUcXZAH
         L82Q==
X-Gm-Message-State: APjAAAVza+US3xeTw55NkxJH4K4q9Bi+dpV8AVlIzjzmj7fNrUP0t8Xz
        75lZaswVNuFDX2/0atSdqREmTnLE+gOBI8YyXrQ6kJrbXBrFDhH2U13r+VOICHFCCyIZxUqeaBY
        AQe/c9vXUQPqJYhxR/kAptEiNVHBlRVFwBK1jtio33CuVmUy/oaFxLArTsyAkj336NzvP4UW9oE
        TdSdcIrAUNtFIEsDZa3g==
X-Google-Smtp-Source: APXvYqwyBEO6BHeWgs8os/6j0tQb7iXVo+WJ6CVK45kjgxuLzoYRR+obwPh9eXnyDfWHR9lhyAKjCA==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr9066783pjs.109.1564840824007;
        Sat, 03 Aug 2019 07:00:24 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:23 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 06/12] mpt3sas: Allow ioctls to blocked access status NVMe
Date:   Sat,  3 Aug 2019 09:59:51 -0400
Message-Id: <1564840797-5876-7-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Description:
Currently if driver see the NVMe drive with "DEVICE_BLOCKED"
AcessStatus in it's PCIe Device Page0 then driver removes the
drive from it's internal list and does not allow any IOCTL
commands to be sent to the drive and will return the IOCTLs
with "-ENODEV" status.

Now driver will allow NVMe Encapsulated IOCTL issued to the
NVMe device with an access status of DEVICE_BLOCKED.

This change allows the user to flash new drive
firmware online and make the drive working.

Implementation:
Add NVMe device only in the driver's internal list even though
the device is in the blocked state so that the device will
be visible to Apps. So that Apps can send NVMe Encapsulated IOCTLs
to this drive and make the drive online. This NVMe drive with
DEVICE_BLOCKED access status won't added to the SML, it will be
added only in the driver's internal list.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  2 ++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 66a68be..5094319 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -583,6 +583,7 @@ static inline void sas_device_put(struct _sas_device *s)
  * @enclosure_level: The level of device's enclosure from the controller
  * @connector_name: ASCII value of the Connector's name
  * @serial_number: pointer of serial number string allocated runtime
+ * @access_status: Device's Access Status
  * @refcount: reference count for deletion
  */
 struct _pcie_device {
@@ -604,6 +605,7 @@ struct _pcie_device {
 	u8	connector_name[4];
 	u8	*serial_number;
 	u8	reset_timeout;
+	u8	access_status;
 	struct kref refcount;
 };
 /**
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index f7610b8..325b5b7 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -1152,6 +1152,11 @@ _scsih_pcie_device_add(struct MPT3SAS_ADAPTER *ioc,
 	list_add_tail(&pcie_device->list, &ioc->pcie_device_list);
 	spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
 
+	if (pcie_device->access_status ==
+	    MPI26_PCIEDEV0_ASTATUS_DEVICE_BLOCKED) {
+		clear_bit(pcie_device->handle, ioc->pend_os_device_add);
+		return;
+	}
 	if (scsi_add_device(ioc->shost, PCIE_CHANNEL, pcie_device->id, 0)) {
 		_scsih_pcie_device_remove(ioc, pcie_device);
 	} else if (!pcie_device->starget) {
@@ -1196,7 +1201,9 @@ _scsih_pcie_device_init_add(struct MPT3SAS_ADAPTER *ioc,
 	spin_lock_irqsave(&ioc->pcie_device_lock, flags);
 	pcie_device_get(pcie_device);
 	list_add_tail(&pcie_device->list, &ioc->pcie_device_init_list);
-	_scsih_determine_boot_device(ioc, pcie_device, PCIE_CHANNEL);
+	if (pcie_device->access_status !=
+	    MPI26_PCIEDEV0_ASTATUS_DEVICE_BLOCKED)
+		_scsih_determine_boot_device(ioc, pcie_device, PCIE_CHANNEL);
 	spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
 }
 /**
@@ -6548,6 +6555,11 @@ _scsih_check_pcie_access_status(struct MPT3SAS_ADAPTER *ioc, u64 wwid,
 		break;
 	case MPI26_PCIEDEV0_ASTATUS_DEVICE_BLOCKED:
 		desc = "PCIe device blocked";
+		ioc_info(ioc,
+		    "Device with Access Status (%s): wwid(0x%016llx), "
+		    "handle(0x%04x)\n ll only be added to the internal list",
+		    desc, (u64)wwid, handle);
+		rc = 0;
 		break;
 	case MPI26_PCIEDEV0_ASTATUS_MEMORY_SPACE_ACCESS_FAILED:
 		desc = "PCIe device mem space access failed";
@@ -6652,7 +6664,8 @@ _scsih_pcie_device_remove_from_sml(struct MPT3SAS_ADAPTER *ioc,
 			 pcie_device->enclosure_level,
 			 pcie_device->connector_name);
 
-	if (pcie_device->starget)
+	if (pcie_device->starget && (pcie_device->access_status !=
+				MPI26_PCIEDEV0_ASTATUS_DEVICE_BLOCKED))
 		scsi_remove_target(&pcie_device->starget->dev);
 	dewtprintk(ioc,
 		   ioc_info(ioc, "%s: exit: handle(0x%04x), wwid(0x%016llx)\n",
@@ -6718,6 +6731,7 @@ _scsih_pcie_check_device(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	if (unlikely(pcie_device->handle != handle)) {
 		starget = pcie_device->starget;
 		sas_target_priv_data = starget->hostdata;
+		pcie_device->access_status = pcie_device_pg0.AccessStatus;
 		starget_printk(KERN_INFO, starget,
 		    "handle changed from(0x%04x) to (0x%04x)!!!\n",
 		    pcie_device->handle, handle);
@@ -6859,6 +6873,7 @@ _scsih_pcie_add_device(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	pcie_device->id = ioc->pcie_target_id++;
 	pcie_device->channel = PCIE_CHANNEL;
 	pcie_device->handle = handle;
+	pcie_device->access_status = pcie_device_pg0.AccessStatus;
 	pcie_device->device_info = le32_to_cpu(pcie_device_pg0.DeviceInfo);
 	pcie_device->wwid = wwid;
 	pcie_device->port_num = pcie_device_pg0.PortNum;
@@ -8531,6 +8546,8 @@ _scsih_mark_responding_pcie_device(struct MPT3SAS_ADAPTER *ioc,
 		if ((pcie_device->wwid == le64_to_cpu(pcie_device_pg0->WWID))
 		    && (pcie_device->slot == le16_to_cpu(
 		    pcie_device_pg0->Slot))) {
+			pcie_device->access_status =
+					pcie_device_pg0->AccessStatus;
 			pcie_device->responding = 1;
 			starget = pcie_device->starget;
 			if (starget && starget->hostdata) {
@@ -10063,6 +10080,12 @@ _scsih_probe_pcie(struct MPT3SAS_ADAPTER *ioc)
 			pcie_device_put(pcie_device);
 			continue;
 		}
+		if (pcie_device->access_status ==
+		    MPI26_PCIEDEV0_ASTATUS_DEVICE_BLOCKED) {
+			pcie_device_make_active(ioc, pcie_device);
+			pcie_device_put(pcie_device);
+			continue;
+		}
 		rc = scsi_add_device(ioc->shost, PCIE_CHANNEL,
 			pcie_device->id, 0);
 		if (rc) {
-- 
1.8.3.1

