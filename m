Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D59746125
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 16:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfFNOmA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 10:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbfFNOmA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Jun 2019 10:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E327B30984D1;
        Fri, 14 Jun 2019 14:41:54 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CCF6605CA;
        Fri, 14 Jun 2019 14:41:52 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com, Sathya.Prakash@broadcom.com
Subject: [PATCH 2/2] scsi: mpt3sass: use DEVICE_ATTR_{RO, RW}
Date:   Fri, 14 Jun 2019 16:41:44 +0200
Message-Id: <20190614144144.6448-3-thenzl@redhat.com>
In-Reply-To: <20190614144144.6448-1-thenzl@redhat.com>
References: <20190614144144.6448-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 14 Jun 2019 14:41:59 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use existing macros.  No functional change.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 210 +++++++++++++----------------
 1 file changed, 97 insertions(+), 113 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index b5cae5821..d4ecfbbe7 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2457,7 +2457,7 @@ _ctl_mpt2_ioctl_compat(struct file *file, unsigned cmd, unsigned long arg)
 
 /* scsi host attributes */
 /**
- * _ctl_version_fw_show - firmware version
+ * version_fw_show - firmware version
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2465,7 +2465,7 @@ _ctl_mpt2_ioctl_compat(struct file *file, unsigned cmd, unsigned long arg)
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_version_fw_show(struct device *cdev, struct device_attribute *attr,
+version_fw_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2477,10 +2477,10 @@ _ctl_version_fw_show(struct device *cdev, struct device_attribute *attr,
 	    (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
 	    ioc->facts.FWVersion.Word & 0x000000FF);
 }
-static DEVICE_ATTR(version_fw, S_IRUGO, _ctl_version_fw_show, NULL);
+static DEVICE_ATTR_RO(version_fw);
 
 /**
- * _ctl_version_bios_show - bios version
+ * version_bios_show - bios version
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2488,7 +2488,7 @@ static DEVICE_ATTR(version_fw, S_IRUGO, _ctl_version_fw_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_version_bios_show(struct device *cdev, struct device_attribute *attr,
+version_bios_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2502,10 +2502,10 @@ _ctl_version_bios_show(struct device *cdev, struct device_attribute *attr,
 	    (version & 0x0000FF00) >> 8,
 	    version & 0x000000FF);
 }
-static DEVICE_ATTR(version_bios, S_IRUGO, _ctl_version_bios_show, NULL);
+static DEVICE_ATTR_RO(version_bios);
 
 /**
- * _ctl_version_mpi_show - MPI (message passing interface) version
+ * version_mpi_show - MPI (message passing interface) version
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2513,7 +2513,7 @@ static DEVICE_ATTR(version_bios, S_IRUGO, _ctl_version_bios_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_version_mpi_show(struct device *cdev, struct device_attribute *attr,
+version_mpi_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2522,10 +2522,10 @@ _ctl_version_mpi_show(struct device *cdev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%03x.%02x\n",
 	    ioc->facts.MsgVersion, ioc->facts.HeaderVersion >> 8);
 }
-static DEVICE_ATTR(version_mpi, S_IRUGO, _ctl_version_mpi_show, NULL);
+static DEVICE_ATTR_RO(version_mpi);
 
 /**
- * _ctl_version_product_show - product name
+ * version_product_show - product name
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2533,7 +2533,7 @@ static DEVICE_ATTR(version_mpi, S_IRUGO, _ctl_version_mpi_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_version_product_show(struct device *cdev, struct device_attribute *attr,
+version_product_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2541,10 +2541,10 @@ _ctl_version_product_show(struct device *cdev, struct device_attribute *attr,
 
 	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.ChipName);
 }
-static DEVICE_ATTR(version_product, S_IRUGO, _ctl_version_product_show, NULL);
+static DEVICE_ATTR_RO(version_product);
 
 /**
- * _ctl_version_nvdata_persistent_show - ndvata persistent version
+ * version_nvdata_persistent_show - ndvata persistent version
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2552,7 +2552,7 @@ static DEVICE_ATTR(version_product, S_IRUGO, _ctl_version_product_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_version_nvdata_persistent_show(struct device *cdev,
+version_nvdata_persistent_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2561,11 +2561,10 @@ _ctl_version_nvdata_persistent_show(struct device *cdev,
 	return snprintf(buf, PAGE_SIZE, "%08xh\n",
 	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionPersistent.Word));
 }
-static DEVICE_ATTR(version_nvdata_persistent, S_IRUGO,
-	_ctl_version_nvdata_persistent_show, NULL);
+static DEVICE_ATTR_RO(version_nvdata_persistent);
 
 /**
- * _ctl_version_nvdata_default_show - nvdata default version
+ * version_nvdata_default_show - nvdata default version
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2573,7 +2572,7 @@ static DEVICE_ATTR(version_nvdata_persistent, S_IRUGO,
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_version_nvdata_default_show(struct device *cdev, struct device_attribute
+version_nvdata_default_show(struct device *cdev, struct device_attribute
 	*attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2582,11 +2581,10 @@ _ctl_version_nvdata_default_show(struct device *cdev, struct device_attribute
 	return snprintf(buf, PAGE_SIZE, "%08xh\n",
 	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionDefault.Word));
 }
-static DEVICE_ATTR(version_nvdata_default, S_IRUGO,
-	_ctl_version_nvdata_default_show, NULL);
+static DEVICE_ATTR_RO(version_nvdata_default);
 
 /**
- * _ctl_board_name_show - board name
+ * board_name_show - board name
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2594,7 +2592,7 @@ static DEVICE_ATTR(version_nvdata_default, S_IRUGO,
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_board_name_show(struct device *cdev, struct device_attribute *attr,
+board_name_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2602,10 +2600,10 @@ _ctl_board_name_show(struct device *cdev, struct device_attribute *attr,
 
 	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardName);
 }
-static DEVICE_ATTR(board_name, S_IRUGO, _ctl_board_name_show, NULL);
+static DEVICE_ATTR_RO(board_name);
 
 /**
- * _ctl_board_assembly_show - board assembly name
+ * board_assembly_show - board assembly name
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2613,7 +2611,7 @@ static DEVICE_ATTR(board_name, S_IRUGO, _ctl_board_name_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_board_assembly_show(struct device *cdev, struct device_attribute *attr,
+board_assembly_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2621,10 +2619,10 @@ _ctl_board_assembly_show(struct device *cdev, struct device_attribute *attr,
 
 	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardAssembly);
 }
-static DEVICE_ATTR(board_assembly, S_IRUGO, _ctl_board_assembly_show, NULL);
+static DEVICE_ATTR_RO(board_assembly);
 
 /**
- * _ctl_board_tracer_show - board tracer number
+ * board_tracer_show - board tracer number
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2632,7 +2630,7 @@ static DEVICE_ATTR(board_assembly, S_IRUGO, _ctl_board_assembly_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_board_tracer_show(struct device *cdev, struct device_attribute *attr,
+board_tracer_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2640,10 +2638,10 @@ _ctl_board_tracer_show(struct device *cdev, struct device_attribute *attr,
 
 	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardTracerNumber);
 }
-static DEVICE_ATTR(board_tracer, S_IRUGO, _ctl_board_tracer_show, NULL);
+static DEVICE_ATTR_RO(board_tracer);
 
 /**
- * _ctl_io_delay_show - io missing delay
+ * io_delay_show - io missing delay
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2654,7 +2652,7 @@ static DEVICE_ATTR(board_tracer, S_IRUGO, _ctl_board_tracer_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_io_delay_show(struct device *cdev, struct device_attribute *attr,
+io_delay_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2662,10 +2660,10 @@ _ctl_io_delay_show(struct device *cdev, struct device_attribute *attr,
 
 	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
 }
-static DEVICE_ATTR(io_delay, S_IRUGO, _ctl_io_delay_show, NULL);
+static DEVICE_ATTR_RO(io_delay);
 
 /**
- * _ctl_device_delay_show - device missing delay
+ * device_delay_show - device missing delay
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2676,7 +2674,7 @@ static DEVICE_ATTR(io_delay, S_IRUGO, _ctl_io_delay_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_device_delay_show(struct device *cdev, struct device_attribute *attr,
+device_delay_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2684,10 +2682,10 @@ _ctl_device_delay_show(struct device *cdev, struct device_attribute *attr,
 
 	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->device_missing_delay);
 }
-static DEVICE_ATTR(device_delay, S_IRUGO, _ctl_device_delay_show, NULL);
+static DEVICE_ATTR_RO(device_delay);
 
 /**
- * _ctl_fw_queue_depth_show - global credits
+ * fw_queue_depth_show - global credits
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2697,7 +2695,7 @@ static DEVICE_ATTR(device_delay, S_IRUGO, _ctl_device_delay_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_fw_queue_depth_show(struct device *cdev, struct device_attribute *attr,
+fw_queue_depth_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2705,10 +2703,10 @@ _ctl_fw_queue_depth_show(struct device *cdev, struct device_attribute *attr,
 
 	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->facts.RequestCredit);
 }
-static DEVICE_ATTR(fw_queue_depth, S_IRUGO, _ctl_fw_queue_depth_show, NULL);
+static DEVICE_ATTR_RO(fw_queue_depth);
 
 /**
- * _ctl_sas_address_show - sas address
+ * sas_address_show - sas address
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2718,7 +2716,7 @@ static DEVICE_ATTR(fw_queue_depth, S_IRUGO, _ctl_fw_queue_depth_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_host_sas_address_show(struct device *cdev, struct device_attribute *attr,
+host_sas_address_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 
 {
@@ -2728,11 +2726,10 @@ _ctl_host_sas_address_show(struct device *cdev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
 	    (unsigned long long)ioc->sas_hba.sas_address);
 }
-static DEVICE_ATTR(host_sas_address, S_IRUGO,
-	_ctl_host_sas_address_show, NULL);
+static DEVICE_ATTR_RO(host_sas_address);
 
 /**
- * _ctl_logging_level_show - logging level
+ * logging_level_show - logging level
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2740,7 +2737,7 @@ static DEVICE_ATTR(host_sas_address, S_IRUGO,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_logging_level_show(struct device *cdev, struct device_attribute *attr,
+logging_level_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2749,7 +2746,7 @@ _ctl_logging_level_show(struct device *cdev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->logging_level);
 }
 static ssize_t
-_ctl_logging_level_store(struct device *cdev, struct device_attribute *attr,
+logging_level_store(struct device *cdev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2764,11 +2761,10 @@ _ctl_logging_level_store(struct device *cdev, struct device_attribute *attr,
 		 ioc->logging_level);
 	return strlen(buf);
 }
-static DEVICE_ATTR(logging_level, S_IRUGO | S_IWUSR, _ctl_logging_level_show,
-	_ctl_logging_level_store);
+static DEVICE_ATTR_RW(logging_level);
 
 /**
- * _ctl_fwfault_debug_show - show/store fwfault_debug
+ * fwfault_debug_show - show/store fwfault_debug
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2777,7 +2773,7 @@ static DEVICE_ATTR(logging_level, S_IRUGO | S_IWUSR, _ctl_logging_level_show,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_fwfault_debug_show(struct device *cdev, struct device_attribute *attr,
+fwfault_debug_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2786,7 +2782,7 @@ _ctl_fwfault_debug_show(struct device *cdev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->fwfault_debug);
 }
 static ssize_t
-_ctl_fwfault_debug_store(struct device *cdev, struct device_attribute *attr,
+fwfault_debug_store(struct device *cdev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2801,11 +2797,10 @@ _ctl_fwfault_debug_store(struct device *cdev, struct device_attribute *attr,
 		 ioc->fwfault_debug);
 	return strlen(buf);
 }
-static DEVICE_ATTR(fwfault_debug, S_IRUGO | S_IWUSR,
-	_ctl_fwfault_debug_show, _ctl_fwfault_debug_store);
+static DEVICE_ATTR_RW(fwfault_debug);
 
 /**
- * _ctl_ioc_reset_count_show - ioc reset count
+ * ioc_reset_count_show - ioc reset count
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2815,7 +2810,7 @@ static DEVICE_ATTR(fwfault_debug, S_IRUGO | S_IWUSR,
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_ioc_reset_count_show(struct device *cdev, struct device_attribute *attr,
+ioc_reset_count_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2823,10 +2818,10 @@ _ctl_ioc_reset_count_show(struct device *cdev, struct device_attribute *attr,
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->ioc_reset_count);
 }
-static DEVICE_ATTR(ioc_reset_count, S_IRUGO, _ctl_ioc_reset_count_show, NULL);
+static DEVICE_ATTR_RO(ioc_reset_count);
 
 /**
- * _ctl_ioc_reply_queue_count_show - number of reply queues
+ * reply_queue_count_show - number of reply queues
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2836,7 +2831,7 @@ static DEVICE_ATTR(ioc_reset_count, S_IRUGO, _ctl_ioc_reset_count_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_ioc_reply_queue_count_show(struct device *cdev,
+reply_queue_count_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	u8 reply_queue_count;
@@ -2851,11 +2846,10 @@ _ctl_ioc_reply_queue_count_show(struct device *cdev,
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", reply_queue_count);
 }
-static DEVICE_ATTR(reply_queue_count, S_IRUGO, _ctl_ioc_reply_queue_count_show,
-	NULL);
+static DEVICE_ATTR_RO(reply_queue_count);
 
 /**
- * _ctl_BRM_status_show - Backup Rail Monitor Status
+ * BRM_status_show - Backup Rail Monitor Status
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2865,7 +2859,7 @@ static DEVICE_ATTR(reply_queue_count, S_IRUGO, _ctl_ioc_reply_queue_count_show,
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_BRM_status_show(struct device *cdev, struct device_attribute *attr,
+BRM_status_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2927,7 +2921,7 @@ _ctl_BRM_status_show(struct device *cdev, struct device_attribute *attr,
 	mutex_unlock(&ioc->pci_access_mutex);
 	return rc;
 }
-static DEVICE_ATTR(BRM_status, S_IRUGO, _ctl_BRM_status_show, NULL);
+static DEVICE_ATTR_RO(BRM_status);
 
 struct DIAG_BUFFER_START {
 	__le32	Size;
@@ -2940,7 +2934,7 @@ struct DIAG_BUFFER_START {
 };
 
 /**
- * _ctl_host_trace_buffer_size_show - host buffer size (trace only)
+ * host_trace_buffer_size_show - host buffer size (trace only)
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2948,7 +2942,7 @@ struct DIAG_BUFFER_START {
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_host_trace_buffer_size_show(struct device *cdev,
+host_trace_buffer_size_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -2980,11 +2974,10 @@ _ctl_host_trace_buffer_size_show(struct device *cdev,
 	ioc->ring_buffer_sz = size;
 	return snprintf(buf, PAGE_SIZE, "%d\n", size);
 }
-static DEVICE_ATTR(host_trace_buffer_size, S_IRUGO,
-	_ctl_host_trace_buffer_size_show, NULL);
+static DEVICE_ATTR_RO(host_trace_buffer_size);
 
 /**
- * _ctl_host_trace_buffer_show - firmware ring buffer (trace only)
+ * host_trace_buffer_show - firmware ring buffer (trace only)
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -2996,7 +2989,7 @@ static DEVICE_ATTR(host_trace_buffer_size, S_IRUGO,
  * offset to the same attribute, it will move the pointer.
  */
 static ssize_t
-_ctl_host_trace_buffer_show(struct device *cdev, struct device_attribute *attr,
+host_trace_buffer_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3028,7 +3021,7 @@ _ctl_host_trace_buffer_show(struct device *cdev, struct device_attribute *attr,
 }
 
 static ssize_t
-_ctl_host_trace_buffer_store(struct device *cdev, struct device_attribute *attr,
+host_trace_buffer_store(struct device *cdev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3041,14 +3034,13 @@ _ctl_host_trace_buffer_store(struct device *cdev, struct device_attribute *attr,
 	ioc->ring_buffer_offset = val;
 	return strlen(buf);
 }
-static DEVICE_ATTR(host_trace_buffer, S_IRUGO | S_IWUSR,
-	_ctl_host_trace_buffer_show, _ctl_host_trace_buffer_store);
+static DEVICE_ATTR_RW(host_trace_buffer);
 
 
 /*****************************************/
 
 /**
- * _ctl_host_trace_buffer_enable_show - firmware ring buffer (trace only)
+ * host_trace_buffer_enable_show - firmware ring buffer (trace only)
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3058,7 +3050,7 @@ static DEVICE_ATTR(host_trace_buffer, S_IRUGO | S_IWUSR,
  * This is a mechnism to post/release host_trace_buffers
  */
 static ssize_t
-_ctl_host_trace_buffer_enable_show(struct device *cdev,
+host_trace_buffer_enable_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3076,7 +3068,7 @@ _ctl_host_trace_buffer_enable_show(struct device *cdev,
 }
 
 static ssize_t
-_ctl_host_trace_buffer_enable_store(struct device *cdev,
+host_trace_buffer_enable_store(struct device *cdev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3126,14 +3118,12 @@ _ctl_host_trace_buffer_enable_store(struct device *cdev,
  out:
 	return strlen(buf);
 }
-static DEVICE_ATTR(host_trace_buffer_enable, S_IRUGO | S_IWUSR,
-	_ctl_host_trace_buffer_enable_show,
-	_ctl_host_trace_buffer_enable_store);
+static DEVICE_ATTR_RW(host_trace_buffer_enable);
 
 /*********** diagnostic trigger suppport *********************************/
 
 /**
- * _ctl_diag_trigger_master_show - show the diag_trigger_master attribute
+ * diag_trigger_master_show - show the diag_trigger_master attribute
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3141,7 +3131,7 @@ static DEVICE_ATTR(host_trace_buffer_enable, S_IRUGO | S_IWUSR,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_diag_trigger_master_show(struct device *cdev,
+diag_trigger_master_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 
 {
@@ -3158,7 +3148,7 @@ _ctl_diag_trigger_master_show(struct device *cdev,
 }
 
 /**
- * _ctl_diag_trigger_master_store - store the diag_trigger_master attribute
+ * diag_trigger_master_store - store the diag_trigger_master attribute
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3167,7 +3157,7 @@ _ctl_diag_trigger_master_show(struct device *cdev,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_diag_trigger_master_store(struct device *cdev,
+diag_trigger_master_store(struct device *cdev,
 	struct device_attribute *attr, const char *buf, size_t count)
 
 {
@@ -3186,12 +3176,11 @@ _ctl_diag_trigger_master_store(struct device *cdev,
 	spin_unlock_irqrestore(&ioc->diag_trigger_lock, flags);
 	return rc;
 }
-static DEVICE_ATTR(diag_trigger_master, S_IRUGO | S_IWUSR,
-	_ctl_diag_trigger_master_show, _ctl_diag_trigger_master_store);
+static DEVICE_ATTR_RW(diag_trigger_master);
 
 
 /**
- * _ctl_diag_trigger_event_show - show the diag_trigger_event attribute
+ * diag_trigger_event_show - show the diag_trigger_event attribute
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3199,7 +3188,7 @@ static DEVICE_ATTR(diag_trigger_master, S_IRUGO | S_IWUSR,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_diag_trigger_event_show(struct device *cdev,
+diag_trigger_event_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3215,7 +3204,7 @@ _ctl_diag_trigger_event_show(struct device *cdev,
 }
 
 /**
- * _ctl_diag_trigger_event_store - store the diag_trigger_event attribute
+ * diag_trigger_event_store - store the diag_trigger_event attribute
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3224,7 +3213,7 @@ _ctl_diag_trigger_event_show(struct device *cdev,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_diag_trigger_event_store(struct device *cdev,
+diag_trigger_event_store(struct device *cdev,
 	struct device_attribute *attr, const char *buf, size_t count)
 
 {
@@ -3243,12 +3232,11 @@ _ctl_diag_trigger_event_store(struct device *cdev,
 	spin_unlock_irqrestore(&ioc->diag_trigger_lock, flags);
 	return sz;
 }
-static DEVICE_ATTR(diag_trigger_event, S_IRUGO | S_IWUSR,
-	_ctl_diag_trigger_event_show, _ctl_diag_trigger_event_store);
+static DEVICE_ATTR_RW(diag_trigger_event);
 
 
 /**
- * _ctl_diag_trigger_scsi_show - show the diag_trigger_scsi attribute
+ * diag_trigger_scsi_show - show the diag_trigger_scsi attribute
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3256,7 +3244,7 @@ static DEVICE_ATTR(diag_trigger_event, S_IRUGO | S_IWUSR,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_diag_trigger_scsi_show(struct device *cdev,
+diag_trigger_scsi_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3272,7 +3260,7 @@ _ctl_diag_trigger_scsi_show(struct device *cdev,
 }
 
 /**
- * _ctl_diag_trigger_scsi_store - store the diag_trigger_scsi attribute
+ * diag_trigger_scsi_store - store the diag_trigger_scsi attribute
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3281,7 +3269,7 @@ _ctl_diag_trigger_scsi_show(struct device *cdev,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_diag_trigger_scsi_store(struct device *cdev,
+diag_trigger_scsi_store(struct device *cdev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3299,12 +3287,11 @@ _ctl_diag_trigger_scsi_store(struct device *cdev,
 	spin_unlock_irqrestore(&ioc->diag_trigger_lock, flags);
 	return sz;
 }
-static DEVICE_ATTR(diag_trigger_scsi, S_IRUGO | S_IWUSR,
-	_ctl_diag_trigger_scsi_show, _ctl_diag_trigger_scsi_store);
+static DEVICE_ATTR_RW(diag_trigger_scsi);
 
 
 /**
- * _ctl_diag_trigger_scsi_show - show the diag_trigger_mpi attribute
+ * diag_trigger_scsi_show - show the diag_trigger_mpi attribute
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3312,7 +3299,7 @@ static DEVICE_ATTR(diag_trigger_scsi, S_IRUGO | S_IWUSR,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_diag_trigger_mpi_show(struct device *cdev,
+diag_trigger_mpi_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3328,7 +3315,7 @@ _ctl_diag_trigger_mpi_show(struct device *cdev,
 }
 
 /**
- * _ctl_diag_trigger_mpi_store - store the diag_trigger_mpi attribute
+ * diag_trigger_mpi_store - store the diag_trigger_mpi attribute
  * @cdev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3337,7 +3324,7 @@ _ctl_diag_trigger_mpi_show(struct device *cdev,
  * A sysfs 'read/write' shost attribute.
  */
 static ssize_t
-_ctl_diag_trigger_mpi_store(struct device *cdev,
+diag_trigger_mpi_store(struct device *cdev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3356,8 +3343,7 @@ _ctl_diag_trigger_mpi_store(struct device *cdev,
 	return sz;
 }
 
-static DEVICE_ATTR(diag_trigger_mpi, S_IRUGO | S_IWUSR,
-	_ctl_diag_trigger_mpi_show, _ctl_diag_trigger_mpi_store);
+static DEVICE_ATTR_RW(diag_trigger_mpi);
 
 /*********** diagnostic trigger suppport *** END ****************************/
 
@@ -3395,7 +3381,7 @@ struct device_attribute *mpt3sas_host_attrs[] = {
 /* device attributes */
 
 /**
- * _ctl_device_sas_address_show - sas address
+ * sas_address_show - sas address
  * @dev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3405,7 +3391,7 @@ struct device_attribute *mpt3sas_host_attrs[] = {
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_device_sas_address_show(struct device *dev, struct device_attribute *attr,
+sas_address_show(struct device *dev, struct device_attribute *attr,
 	char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
@@ -3414,10 +3400,10 @@ _ctl_device_sas_address_show(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
 	    (unsigned long long)sas_device_priv_data->sas_target->sas_address);
 }
-static DEVICE_ATTR(sas_address, S_IRUGO, _ctl_device_sas_address_show, NULL);
+static DEVICE_ATTR_RO(sas_address);
 
 /**
- * _ctl_device_handle_show - device handle
+ * sas_device_handle_show - device handle
  * @dev: pointer to embedded class device
  * @attr: ?
  * @buf: the buffer returned
@@ -3427,7 +3413,7 @@ static DEVICE_ATTR(sas_address, S_IRUGO, _ctl_device_sas_address_show, NULL);
  * A sysfs 'read-only' shost attribute.
  */
 static ssize_t
-_ctl_device_handle_show(struct device *dev, struct device_attribute *attr,
+sas_device_handle_show(struct device *dev, struct device_attribute *attr,
 	char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
@@ -3436,10 +3422,10 @@ _ctl_device_handle_show(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "0x%04x\n",
 	    sas_device_priv_data->sas_target->handle);
 }
-static DEVICE_ATTR(sas_device_handle, S_IRUGO, _ctl_device_handle_show, NULL);
+static DEVICE_ATTR_RO(sas_device_handle);
 
 /**
- * _ctl_device_ncq_io_prio_show - send prioritized io commands to device
+ * sas_ncq_io_prio_show - send prioritized io commands to device
  * @dev: pointer to embedded device
  * @attr: ?
  * @buf: the buffer returned
@@ -3447,7 +3433,7 @@ static DEVICE_ATTR(sas_device_handle, S_IRUGO, _ctl_device_handle_show, NULL);
  * A sysfs 'read/write' sdev attribute, only works with SATA
  */
 static ssize_t
-_ctl_device_ncq_prio_enable_show(struct device *dev,
+sas_ncq_prio_enable_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
@@ -3458,7 +3444,7 @@ _ctl_device_ncq_prio_enable_show(struct device *dev,
 }
 
 static ssize_t
-_ctl_device_ncq_prio_enable_store(struct device *dev,
+sas_ncq_prio_enable_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
@@ -3475,9 +3461,7 @@ _ctl_device_ncq_prio_enable_store(struct device *dev,
 	sas_device_priv_data->ncq_prio_enable = ncq_prio_enable;
 	return strlen(buf);
 }
-static DEVICE_ATTR(sas_ncq_prio_enable, S_IRUGO | S_IWUSR,
-		   _ctl_device_ncq_prio_enable_show,
-		   _ctl_device_ncq_prio_enable_store);
+static DEVICE_ATTR_RW(sas_ncq_prio_enable);
 
 struct device_attribute *mpt3sas_dev_attrs[] = {
 	&dev_attr_sas_address,
-- 
2.20.1

