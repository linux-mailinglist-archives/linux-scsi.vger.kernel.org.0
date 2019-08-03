Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B7A80673
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391072AbfHCOAa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34368 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391048AbfHCOAa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so31249135pgc.1
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vA//u+LjihGzn1EIeH14S/bHag5XpW93Lbs2u7dCS3M=;
        b=C9QK0f31yjwOfhcemDVRIpyeFJRvIhc5m/xz7Xyyq07E7ha4VRbPJpuDwAcByMKDTz
         JCA0SUbkhmSbOe1VPlvuAeWTJHxlXED5uEEIFNhp+XxII1jPODMz5+KNiM7oQiI9aEFD
         CTJJ2pFRgkk5Z7TSLPYf+ID6iVwxW69fIQYR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vA//u+LjihGzn1EIeH14S/bHag5XpW93Lbs2u7dCS3M=;
        b=tOA8JqipAmP0oyZpAC/TTIF2BCD6Yj7AlFVhs+xzV+et9UnCFpq+cCCoxgG7RBArQK
         zhqTLGBKE6TAGklmQLVF9XrYqt5n/+fSImphw3zZ+Q+i6py85z90edUZdIAwUhrLWUzW
         CCFibo80K65rqQY+CTxk+StzCQ825Yab6Q49NOadMwHAzyNkqONTvVzqBNpgHhErwUIT
         ZnVf1f+PsQ/mZLJZk9lXT4shL4Nb70T7Vedf+5engB0LnosiK9cq7DQaF+7XNn8/jhCQ
         UC8A3/MlO3Ga/TPuLMFFvclNwbrumrht/MPacTBMdFf2jfbvskW4wZc/7K8L2+QwawEU
         R3ZQ==
X-Gm-Message-State: APjAAAVDdIePv5ofWMiTw3eVBg/I37TIjicChE6v1sxm4aWDC8PZ7utt
        adXtqjv3auyPn7EYZ4C56xhvAmXeeEWTchOqtFt8c5vMJvhE2CwAkJ7a0dHsk3wGWBXDHVozjuB
        JWpFelcCqu8InO8Zg6RBAgN+OVWcMq9RZsMa6hGuFI0ntou4zhwbgDsTv6Bpv/z9nunQfe6r3uT
        o1HTBPtW5fHX5557b0Eg==
X-Google-Smtp-Source: APXvYqzNvf0UpGOEW3AciW9PO0xRFp/pafrsvt/iuBkz+1PdhZO3VfcPQXvZzGlozzlYdgorWh4RaA==
X-Received: by 2002:a65:6093:: with SMTP id t19mr49071849pgu.79.1564840828865;
        Sat, 03 Aug 2019 07:00:28 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:28 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 08/12] mpt3sas: Add sysfs to know supported features
Date:   Sat,  3 Aug 2019 09:59:53 -0400
Message-Id: <1564840797-5876-9-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently with sysfs parameter "drv_support_bitmap" driver exposes
whether driver supports toolbox memory move command or not.

And application should issue the toolbox memory move command only
if driver tell that memory move tool box command is supported
through this sysfs parameter.

In future we can utilize this sysfs parameter if any new feature
is added and need to notify the same to applications.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  4 ++++
 drivers/scsi/mpt3sas/mpt3sas_ctl.c   | 19 +++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 5094319..fa5f1a6 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1047,6 +1047,7 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  * @schedule_dead_ioc_flush_running_cmds: callback to flush pending commands
  * @thresh_hold: Max number of reply descriptors processed
  *				before updating Host Index
+ * @drv_support_bitmap: driver's supported feature bit map
  * @scsi_io_cb_idx: shost generated commands
  * @tm_cb_idx: task management commands
  * @scsih_cb_idx: scsih internal commands
@@ -1230,6 +1231,7 @@ struct MPT3SAS_ADAPTER {
 	bool            msix_load_balance;
 	u16		thresh_hold;
 	u8		high_iops_queues;
+	u32		drv_support_bitmap;
 
 	/* internal commands, callback index */
 	u8		scsi_io_cb_idx;
@@ -1454,6 +1456,8 @@ struct MPT3SAS_ADAPTER {
 	GET_MSIX_INDEX get_msix_index_for_smlio;
 };
 
+#define MPT_DRV_SUPPORT_BITMAP_MEMMOVE 0x00000001
+
 typedef u8 (*MPT_CALLBACK)(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
 	u32 reply);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 7179e5f..daf1959 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3375,6 +3375,24 @@ static DEVICE_ATTR_RW(diag_trigger_mpi);
 
 /*****************************************/
 
+/**
+ * drv_support_bitmap_show - driver supported feature bitmap
+ * @cdev - pointer to embedded class device
+ * @buf - the buffer returned
+ *
+ * A sysfs 'read-only' shost attribute.
+ */
+static ssize_t
+drv_support_bitmap_show(struct device *cdev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(cdev);
+	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", ioc->drv_support_bitmap);
+}
+static DEVICE_ATTR_RO(drv_support_bitmap);
+
 struct device_attribute *mpt3sas_host_attrs[] = {
 	&dev_attr_version_fw,
 	&dev_attr_version_bios,
@@ -3400,6 +3418,7 @@ struct device_attribute *mpt3sas_host_attrs[] = {
 	&dev_attr_diag_trigger_event,
 	&dev_attr_diag_trigger_scsi,
 	&dev_attr_diag_trigger_mpi,
+	&dev_attr_drv_support_bitmap,
 	&dev_attr_BRM_status,
 	NULL,
 };
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 325b5b7..9b89fa4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10499,6 +10499,10 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ioc->tm_sas_control_cb_idx = tm_sas_control_cb_idx;
 	ioc->logging_level = logging_level;
 	ioc->schedule_dead_ioc_flush_running_cmds = &_scsih_flush_running_cmds;
+	/*
+	 * Enable MEMORY MOVE support flag.
+	 */
+	ioc->drv_support_bitmap |= MPT_DRV_SUPPORT_BITMAP_MEMMOVE;
 	/* misc semaphores and spin locks */
 	mutex_init(&ioc->reset_in_progress_mutex);
 	/* initializing pci_access_mutex lock */
-- 
1.8.3.1

