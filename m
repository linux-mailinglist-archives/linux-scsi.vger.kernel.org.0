Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CA75FE0
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 09:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfGZHcs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 03:32:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46226 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZHcs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 03:32:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so24399050plz.13
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 00:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JTzi688dvcEDs53S6Y4n25SxoPHfMYuMDFN+H/opIWU=;
        b=X09F7DsQ+0eLDsjvNH6b2zNm7ahZTGhdZtE6XfSqhqtEOBhJi9vqFCTXHMm++03nax
         2jlsn8N93qkNX7M5uJ9CmoAHyKGxJBHnTNdrvsbeBg7Q4FqADeaX2W81FO1KMkL44Ol3
         duGeS8jdqbjB8azP3uliXMyJFSadp972FVGQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JTzi688dvcEDs53S6Y4n25SxoPHfMYuMDFN+H/opIWU=;
        b=tu8W8P2CSZTaOPZNfDJa4kRv2R85fQZva30/UqhI6cY+pmA53RjWUBro4K3OJ4zMEm
         mHsbA8zxHGdcoQdLCX93jhy0viQKpOHtXrfa04wqXtWfBdxx0azBSzY08DBu4ka1srXG
         +YETouUtF2ySpyyIEFEi3hmdEBl2Yd11tvEuASU6X0p6hrUtMh15WZBYW2utFYA8ht1C
         KlPH3D7vljcfQPvv7p6/xA99RTmuxGdSjI8Zt8mFsMYtU4zzP/xmlw9HnnRcmI2l8aM5
         IszHQY4Jgo2YyaJuNJHHLlsjCKYE9gaYnlY3ZTxrDg7FqfBjwtl6iWupTl2zTc/pOOKG
         ppyw==
X-Gm-Message-State: APjAAAWyMjfjy9x5rzUcCzCNz7b5UYlsHxavePaSbcaTFdZKpaJYf+Z9
        C54TcUyT40iFtcUqEuVsBigETETuOYY73DfVLfivZaseee65LuATGE36ryO5DJjz//k/+KAZ8hf
        H3/AxV/brWBpJYZnZfilUTt6Y8e8hNcpAKL/OU65xBHxln6iLN5Nw9R4EtJf/0R6e6PjBQ1SlpQ
        MrwVl1k/3XlrEW
X-Google-Smtp-Source: APXvYqwSaq/FHx3mrR8yxilskEiGEC8ffyUeN2+fUWPM/p9f5l0HzyhAmjFMfbuFGJ9wQmouqliR0Q==
X-Received: by 2002:a17:902:82c4:: with SMTP id u4mr94947481plz.196.1564126367155;
        Fri, 26 Jul 2019 00:32:47 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v138sm59653272pfc.15.2019.07.26.00.32.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 00:32:46 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH] megaraid_sas: change sdev queue depth max vs optimal
Date:   Fri, 26 Jul 2019 13:02:14 +0530
Message-Id: <20190726073214.23820-1-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch provides the module parameter and sysfs interface to switch
between the firmware provided (optimal) queue depth and controller 
queue depth (can_queue).
Although We have sysfs interface per sdev to change the queue depth
of individual scsi devices this implementation provides the single
sysfs entry per shost to switch between the max and optimal queue depth.
Also module parameter can provide interface for one time grub settings
and provide persistent settings across the boot.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h      |   1 +
 drivers/scsi/megaraid/megaraid_sas_base.c | 112 ++++++++++++++++++++++++------
 2 files changed, 92 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index b4b27d0..fe2a4e0 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2441,6 +2441,7 @@ struct megasas_instance {
 	u8 adapter_type;
 	bool consistent_mask_64bit;
 	bool support_nvme_passthru;
+	bool enable_sdev_max_qd;
 	u8 task_abort_tmo;
 	u8 max_reset_tmo;
 	u8 snapdump_wait_time;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 178f8e2..1d593e4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -121,6 +121,10 @@ int event_log_level = MFI_EVT_CLASS_CRITICAL;
 module_param(event_log_level, int, 0644);
 MODULE_PARM_DESC(event_log_level, "Asynchronous event logging level- range is: -2(CLASS_DEBUG) to 4(CLASS_DEAD), Default: 2(CLASS_CRITICAL)");
 
+unsigned int enable_sdev_max_qd;
+module_param(enable_sdev_max_qd, int, 0444);
+MODULE_PARM_DESC(enable_sdev_max_qd, "Enable sdev max qd as can_queue. Default: 0");
+
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGASAS_VERSION);
 MODULE_AUTHOR("megaraidlinux.pdl@broadcom.com");
@@ -1953,25 +1957,19 @@ megasas_set_nvme_device_properties(struct scsi_device *sdev, u32 max_io_size)
 	blk_queue_virt_boundary(sdev->request_queue, mr_nvme_pg_size - 1);
 }
 
-
 /*
- * megasas_set_static_target_properties -
- * Device property set by driver are static and it is not required to be
- * updated after OCR.
- *
- * set io timeout
- * set device queue depth
- * set nvme device properties. see - megasas_set_nvme_device_properties
+ * megasas_set_fw_assisted_qd -
+ * set device queue depth to can_queue
+ * set device queue depth to fw assisted qd
  *
  * @sdev:				scsi device
  * @is_target_prop			true, if fw provided target properties.
  */
-static void megasas_set_static_target_properties(struct scsi_device *sdev,
+static void megasas_set_fw_assisted_qd(struct scsi_device *sdev,
 						 bool is_target_prop)
 {
 	u8 interface_type;
 	u32 device_qd = MEGASAS_DEFAULT_CMD_PER_LUN;
-	u32 max_io_size_kb = MR_DEFAULT_NVME_MDTS_KB;
 	u32 tgt_device_qd;
 	struct megasas_instance *instance;
 	struct MR_PRIV_DEVICE *mr_device_priv_data;
@@ -1980,11 +1978,6 @@ static void megasas_set_static_target_properties(struct scsi_device *sdev,
 	mr_device_priv_data = sdev->hostdata;
 	interface_type  = mr_device_priv_data->interface_type;
 
-	/*
-	 * The RAID firmware may require extended timeouts.
-	 */
-	blk_queue_rq_timeout(sdev->request_queue, scmd_timeout * HZ);
-
 	switch (interface_type) {
 	case SAS_PD:
 		device_qd = MEGASAS_SAS_QD;
@@ -2002,18 +1995,49 @@ static void megasas_set_static_target_properties(struct scsi_device *sdev,
 		if (tgt_device_qd &&
 		    (tgt_device_qd <= instance->host->can_queue))
 			device_qd = tgt_device_qd;
+	}
 
-		/* max_io_size_kb will be set to non zero for
-		 * nvme based vd and syspd.
-		 */
+	if (instance->enable_sdev_max_qd && interface_type != UNKNOWN_DRIVE)
+		device_qd = instance->host->can_queue;
+
+	scsi_change_queue_depth(sdev, device_qd);
+}
+
+/*
+ * megasas_set_static_target_properties -
+ * Device property set by driver are static and it is not required to be
+ * updated after OCR.
+ *
+ * set io timeout
+ * set device queue depth
+ * set nvme device properties. see - megasas_set_nvme_device_properties
+ *
+ * @sdev:				scsi device
+ * @is_target_prop			true, if fw provided target properties.
+ */
+static void megasas_set_static_target_properties(struct scsi_device *sdev,
+						 bool is_target_prop)
+{
+	u32 max_io_size_kb = MR_DEFAULT_NVME_MDTS_KB;
+	struct megasas_instance *instance;
+
+	instance = megasas_lookup_instance(sdev->host->host_no);
+
+	/*
+	 * The RAID firmware may require extended timeouts.
+	 */
+	blk_queue_rq_timeout(sdev->request_queue, scmd_timeout * HZ);
+
+	/* max_io_size_kb will be set to non zero for
+	 * nvme based vd and syspd.
+	 */
+	if (is_target_prop)
 		max_io_size_kb = le32_to_cpu(instance->tgt_prop->max_io_size_kb);
-	}
 
 	if (instance->nvme_page_size && max_io_size_kb)
 		megasas_set_nvme_device_properties(sdev, (max_io_size_kb << 10));
 
-	scsi_change_queue_depth(sdev, device_qd);
-
+	megasas_set_fw_assisted_qd(sdev, is_target_prop);
 }
 
 
@@ -3294,6 +3318,48 @@ fw_cmds_outstanding_show(struct device *cdev,
 }
 
 static ssize_t
+enable_sdev_max_qd_show(struct device *cdev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(cdev);
+	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", instance->enable_sdev_max_qd);
+}
+
+static ssize_t
+enable_sdev_max_qd_store(struct device *cdev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(cdev);
+	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
+	u32 val = 0;
+	bool is_target_prop;
+	int ret_target_prop = DCMD_FAILED;
+	struct scsi_device *sdev;
+
+	if (kstrtou32(buf, 0, &val) != 0) {
+		pr_err("megasas: could not set enable_sdev_max_qd\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&instance->reset_mutex);
+	if (val)
+		instance->enable_sdev_max_qd = true;
+	else
+		instance->enable_sdev_max_qd = false;
+
+	shost_for_each_device(sdev, shost) {
+		ret_target_prop = megasas_get_target_prop(instance, sdev);
+		is_target_prop = (ret_target_prop == DCMD_SUCCESS) ? true : false;
+		megasas_set_fw_assisted_qd(sdev, is_target_prop);
+	}
+	mutex_unlock(&instance->reset_mutex);
+
+	return strlen(buf);
+}
+
+static ssize_t
 dump_system_regs_show(struct device *cdev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -3322,6 +3388,7 @@ static DEVICE_ATTR_RW(fw_crash_state);
 static DEVICE_ATTR_RO(page_size);
 static DEVICE_ATTR_RO(ldio_outstanding);
 static DEVICE_ATTR_RO(fw_cmds_outstanding);
+static DEVICE_ATTR_RW(enable_sdev_max_qd);
 static DEVICE_ATTR_RO(dump_system_regs);
 static DEVICE_ATTR_RO(raid_map_id);
 
@@ -3332,6 +3399,7 @@ static struct device_attribute *megaraid_host_attrs[] = {
 	&dev_attr_page_size,
 	&dev_attr_ldio_outstanding,
 	&dev_attr_fw_cmds_outstanding,
+	&dev_attr_enable_sdev_max_qd,
 	&dev_attr_dump_system_regs,
 	&dev_attr_raid_map_id,
 	NULL,
@@ -5903,6 +5971,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			MR_MAX_RAID_MAP_SIZE_MASK);
 	}
 
+	instance->enable_sdev_max_qd = enable_sdev_max_qd;
+
 	switch (instance->adapter_type) {
 	case VENTURA_SERIES:
 		fusion->pcie_bw_limitation = true;
-- 
2.9.5

