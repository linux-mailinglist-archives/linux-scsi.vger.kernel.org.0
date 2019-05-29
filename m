Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550732E1CB
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2QAv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 12:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2QAu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 12:00:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5680930C0DF9;
        Wed, 29 May 2019 16:00:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 806204A2;
        Wed, 29 May 2019 16:00:48 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com
Subject: [PATCH 3/3] megaraid_sas: use DEVICE_ATTR_{RO, RW}
Date:   Wed, 29 May 2019 18:00:41 +0200
Message-Id: <20190529160041.7242-4-thenzl@redhat.com>
In-Reply-To: <20190529160041.7242-1-thenzl@redhat.com>
References: <20190529160041.7242-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 29 May 2019 16:00:50 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use existing macros.
No functional change.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 44 ++++++++++-------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 0522821a5..aa6a5d86d 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3121,7 +3121,7 @@ megasas_service_aen(struct megasas_instance *instance, struct megasas_cmd *cmd)
 }
 
 static ssize_t
-megasas_fw_crash_buffer_store(struct device *cdev,
+fw_crash_buffer_store(struct device *cdev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3140,7 +3140,7 @@ megasas_fw_crash_buffer_store(struct device *cdev,
 }
 
 static ssize_t
-megasas_fw_crash_buffer_show(struct device *cdev,
+fw_crash_buffer_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3185,7 +3185,7 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 }
 
 static ssize_t
-megasas_fw_crash_buffer_size_show(struct device *cdev,
+fw_crash_buffer_size_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3197,7 +3197,7 @@ megasas_fw_crash_buffer_size_show(struct device *cdev,
 }
 
 static ssize_t
-megasas_fw_crash_state_store(struct device *cdev,
+fw_crash_state_store(struct device *cdev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3232,7 +3232,7 @@ megasas_fw_crash_state_store(struct device *cdev,
 }
 
 static ssize_t
-megasas_fw_crash_state_show(struct device *cdev,
+fw_crash_state_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3243,14 +3243,14 @@ megasas_fw_crash_state_show(struct device *cdev,
 }
 
 static ssize_t
-megasas_page_size_show(struct device *cdev,
+page_size_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)PAGE_SIZE - 1);
 }
 
 static ssize_t
-megasas_ldio_outstanding_show(struct device *cdev, struct device_attribute *attr,
+ldio_outstanding_show(struct device *cdev, struct device_attribute *attr,
 	char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3260,7 +3260,7 @@ megasas_ldio_outstanding_show(struct device *cdev, struct device_attribute *attr
 }
 
 static ssize_t
-megasas_fw_cmds_outstanding_show(struct device *cdev,
+fw_cmds_outstanding_show(struct device *cdev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3270,7 +3270,7 @@ megasas_fw_cmds_outstanding_show(struct device *cdev,
 }
 
 static ssize_t
-megasas_dump_system_regs_show(struct device *cdev,
+dump_system_regs_show(struct device *cdev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3281,7 +3281,7 @@ megasas_dump_system_regs_show(struct device *cdev,
 }
 
 static ssize_t
-megasas_raid_map_id_show(struct device *cdev, struct device_attribute *attr,
+raid_map_id_show(struct device *cdev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(cdev);
@@ -3292,22 +3292,14 @@ megasas_raid_map_id_show(struct device *cdev, struct device_attribute *attr,
 			(unsigned long)instance->map_id);
 }
 
-static DEVICE_ATTR(fw_crash_buffer, S_IRUGO | S_IWUSR,
-	megasas_fw_crash_buffer_show, megasas_fw_crash_buffer_store);
-static DEVICE_ATTR(fw_crash_buffer_size, S_IRUGO,
-	megasas_fw_crash_buffer_size_show, NULL);
-static DEVICE_ATTR(fw_crash_state, S_IRUGO | S_IWUSR,
-	megasas_fw_crash_state_show, megasas_fw_crash_state_store);
-static DEVICE_ATTR(page_size, S_IRUGO,
-	megasas_page_size_show, NULL);
-static DEVICE_ATTR(ldio_outstanding, S_IRUGO,
-	megasas_ldio_outstanding_show, NULL);
-static DEVICE_ATTR(fw_cmds_outstanding, S_IRUGO,
-	megasas_fw_cmds_outstanding_show, NULL);
-static DEVICE_ATTR(dump_system_regs, S_IRUGO,
-	megasas_dump_system_regs_show, NULL);
-static DEVICE_ATTR(raid_map_id, S_IRUGO,
-	megasas_raid_map_id_show, NULL);
+static DEVICE_ATTR_RW(fw_crash_buffer);
+static DEVICE_ATTR_RO(fw_crash_buffer_size);
+static DEVICE_ATTR_RW(fw_crash_state);
+static DEVICE_ATTR_RO(page_size);
+static DEVICE_ATTR_RO(ldio_outstanding);
+static DEVICE_ATTR_RO(fw_cmds_outstanding);
+static DEVICE_ATTR_RO(dump_system_regs);
+static DEVICE_ATTR_RO(raid_map_id);
 
 struct device_attribute *megaraid_host_attrs[] = {
 	&dev_attr_fw_crash_buffer_size,
-- 
2.20.1

