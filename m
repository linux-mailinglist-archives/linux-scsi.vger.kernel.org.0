Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE39168C6
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfEGRHA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:07:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45567 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRHA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:07:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so3544943pls.12
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pXKzISJZP1hfca4sn8XSTMaP204q8qEUTDJkeALfHOs=;
        b=ahCF8SanL1HiiVm1MhMzRSbOLmvg8WnGrwmBLF7teZfuW8uaW0AcFGBSq2icyts4IQ
         /pE/8zcxm8jxZTovEGhku8Y5589FIAW/A7XWXYqfvzjahetJoxoqN30N5o8RKChbyRIj
         jEGZoyZXzYBh8wlqvpaktRLlDWJXhIPp3g098=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pXKzISJZP1hfca4sn8XSTMaP204q8qEUTDJkeALfHOs=;
        b=k+f3YlQlhbv+mXAxwVDdDRFQW52MH8stACVmWMtuBCMlMcfLF/yu+p4o6jRKJz9yZh
         5azBXzQp0EKh3/+3ZcXw7B1YaleCEh+YS2myXW+Dalz4S8TP0p5XRtGtP47XF0f3dg73
         IXVqj2Mzi71mg4TrkJDZ0tmbJkGvW3ZaagwNeiujU6rIz9fq4EKvzA3140yvcRUdXor4
         XuFGUSIKF0ADlbFsdiaeNGrJdN7uy7bJCr4mTHPcIYzSzX+fJlKojdAEtSpqu80F2wk0
         wZs0u9rBBeobrO+3mBSGZBLE7QWOrwQRmlF2j74rkB5umRCYAZcEFQZiIXJ5JHd34p5n
         y8Cg==
X-Gm-Message-State: APjAAAX/QOrMOb8+gTUXITgFCSs8kkGNpxl8RIJc9tivht8iiXpgEe9Q
        Y+fa67TGe/+TXO1vCGviZ3uX95PEzGxDKwkHvMYa7QEC33qAVxr7WleBIinMQfZQ8XuLj5RbcvW
        kVkLIgQ6yuWm+pLf6KTfBpAmz4m5ANG+Nq+lGayMtus+7eqIrnEdZZSfEQmOUOnZ5DdDcpmXl4N
        x3ohZwKXRX2fMSyMsGXRUF
X-Google-Smtp-Source: APXvYqxz5rN+eXLP0cXEBkezyIl+uLimg2q0NKD2zQ9i/sRJWJ0L+M2K/60MDafdVXJYY9h45E39Eg==
X-Received: by 2002:a17:902:441:: with SMTP id 59mr41305585ple.242.1557248819420;
        Tue, 07 May 2019 10:06:59 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:58 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 14/21] megaraid_sas: Export RAID map id through sysfs
Date:   Tue,  7 May 2019 10:05:43 -0700
Message-Id: <1557248750-4099-15-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a sysfs interface to get the raid map index that is being used by
driver.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 18d142f2a2a2..c560d1e748f4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3275,6 +3275,18 @@ megasas_dump_system_regs_show(struct device *cdev,
 	return megasas_dump_sys_regs(instance->reg_set, buf);
 }
 
+static ssize_t
+megasas_raid_map_id_show(struct device *cdev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(cdev);
+	struct megasas_instance *instance =
+			(struct megasas_instance *)shost->hostdata;
+
+	return snprintf(buf, PAGE_SIZE, "%ld\n",
+			(unsigned long)instance->map_id);
+}
+
 static DEVICE_ATTR(fw_crash_buffer, S_IRUGO | S_IWUSR,
 	megasas_fw_crash_buffer_show, megasas_fw_crash_buffer_store);
 static DEVICE_ATTR(fw_crash_buffer_size, S_IRUGO,
@@ -3289,6 +3301,8 @@ static DEVICE_ATTR(fw_cmds_outstanding, S_IRUGO,
 	megasas_fw_cmds_outstanding_show, NULL);
 static DEVICE_ATTR(dump_system_regs, S_IRUGO,
 	megasas_dump_system_regs_show, NULL);
+static DEVICE_ATTR(raid_map_id, S_IRUGO,
+	megasas_raid_map_id_show, NULL);
 
 struct device_attribute *megaraid_host_attrs[] = {
 	&dev_attr_fw_crash_buffer_size,
@@ -3298,6 +3312,7 @@ struct device_attribute *megaraid_host_attrs[] = {
 	&dev_attr_ldio_outstanding,
 	&dev_attr_fw_cmds_outstanding,
 	&dev_attr_dump_system_regs,
+	&dev_attr_raid_map_id,
 	NULL,
 };
 
-- 
2.16.1

