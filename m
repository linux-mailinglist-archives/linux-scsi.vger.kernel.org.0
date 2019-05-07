Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C536168C3
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfEGRGu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41163 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id l132so4018400pfc.8
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RG6TTEe10onRho7UWIoWs5g+MDWSxE1s51WAEHTfYQ4=;
        b=da4lpKA4nv14OZJX00jyvXcFI9VnC3D3b4GvuELO8jmgsRnI1ro97BfB78r2rUADmD
         Pp+ofrfBac08KSVKtFdPW/19aEtAgxOZDGvCeqXqKmmVYyerTDC2zT0V2AJhavG1Q6/3
         mHuWgJpICDvlXTY5vFvANFiHm2iHrL9mvxNOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RG6TTEe10onRho7UWIoWs5g+MDWSxE1s51WAEHTfYQ4=;
        b=HsIYR6SH7Pi7OqY96p/En5mqbhPBQeazNsI98h2lIwPrYIpAVducC3dGBTQpClM1E4
         u8MZFeC6FnAvnY4s9A8/HDiAcxkjcMNVu47Zvyu9I23I/XxIbqpGsdqUM1TAyZ5AIRmK
         BjzfnkbFU0MBTCUbx2rG2YUV2+qvPUijR3tNrxNuS27MlznJOE39owDMEGNu3dQSzUSE
         ZfdG0WuAma+ilgEUJoBaX1+RNrX6rq8ovfbB7vLtV4NI8O14lV5+JQMhA6u2+WXo+I8Q
         KgZg5Cz3m9vA44NLjRcdIk5vlmDNAo4pDhDPjhtJ6VgFh79VPQSEn+kU+eTaYfYzj+rb
         FCjA==
X-Gm-Message-State: APjAAAUQzocjjmxC0YLI5rkPakxWzuxhuSoNyTpuu/qS9HxLikuK7/c/
        12xHNOHKUaWhUfOUHupU0zqP9Fa77cfm3Kv/pPqe/epwgVlFlsPeOBa8BFgJzAkdsjJN8onM8mb
        zWusUkRn4vPlEtMiw65qPHHic9dkB5Z5cy+MwjtKQ3637p1PY6T/K54jMTAhtF7lvJLnJGjJN90
        4rzgVbD+m5NP4Hr9jxIN/W
X-Google-Smtp-Source: APXvYqxwaFIiVWzqsUQ2WiMBmkqqhqA6RlbQkEB4Wu+jHwZ8O7+nndynPucDXOI2TQNw46zo8ivmOQ==
X-Received: by 2002:a62:56c8:: with SMTP id h69mr7209922pfj.49.1557248808622;
        Tue, 07 May 2019 10:06:48 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:47 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 11/21] megaraid_sas: Dump system interface regs from sysfs
Date:   Tue,  7 May 2019 10:05:40 -0700
Message-Id: <1557248750-4099-12-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a sysfs interface to dump the controller's system interface registers.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
Changes in v2:
Fixed the sparse warnings reported by kbuild_test_robot and removed the
endianness conversion after readl.

 drivers/scsi/megaraid/megaraid_sas_base.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index d0fd307e30af..e2a89821bdd2 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2901,6 +2901,29 @@ megasas_dump_fusion_io(struct scsi_cmnd *scmd)
 
 }
 
+/*
+ * megasas_dump_sys_regs - This function will dump system registers through
+ *			    sysfs.
+ * @reg_set:		    Pointer to System register set.
+ * @buf:		    Buffer to which output is to be written.
+ * @return:		    Number of bytes written to buffer.
+ */
+static inline ssize_t
+megasas_dump_sys_regs(void __iomem *reg_set, char *buf)
+{
+	unsigned int i, sz = 256;
+	int bytes_wrote = 0;
+	char *loc = (char *)buf;
+	u32 __iomem *reg = (u32 __iomem *)reg_set;
+
+	for (i = 0; i < sz / sizeof(u32); i++) {
+		bytes_wrote += snprintf(loc + bytes_wrote, PAGE_SIZE,
+					"%08x: %08x\n", (i * 4),
+					readl(&reg[i]));
+	}
+	return bytes_wrote;
+}
+
 /**
  * megasas_reset_bus_host -	Bus & host reset handler entry point
  */
@@ -3223,6 +3246,17 @@ megasas_fw_cmds_outstanding_show(struct device *cdev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->fw_outstanding));
 }
 
+static ssize_t
+megasas_dump_system_regs_show(struct device *cdev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(cdev);
+	struct megasas_instance *instance =
+			(struct megasas_instance *)shost->hostdata;
+
+	return megasas_dump_sys_regs(instance->reg_set, buf);
+}
+
 static DEVICE_ATTR(fw_crash_buffer, S_IRUGO | S_IWUSR,
 	megasas_fw_crash_buffer_show, megasas_fw_crash_buffer_store);
 static DEVICE_ATTR(fw_crash_buffer_size, S_IRUGO,
@@ -3235,6 +3269,8 @@ static DEVICE_ATTR(ldio_outstanding, S_IRUGO,
 	megasas_ldio_outstanding_show, NULL);
 static DEVICE_ATTR(fw_cmds_outstanding, S_IRUGO,
 	megasas_fw_cmds_outstanding_show, NULL);
+static DEVICE_ATTR(dump_system_regs, S_IRUGO,
+	megasas_dump_system_regs_show, NULL);
 
 struct device_attribute *megaraid_host_attrs[] = {
 	&dev_attr_fw_crash_buffer_size,
@@ -3243,6 +3279,7 @@ struct device_attribute *megaraid_host_attrs[] = {
 	&dev_attr_page_size,
 	&dev_attr_ldio_outstanding,
 	&dev_attr_fw_cmds_outstanding,
+	&dev_attr_dump_system_regs,
 	NULL,
 };
 
-- 
2.16.1

