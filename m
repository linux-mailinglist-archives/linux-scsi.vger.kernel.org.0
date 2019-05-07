Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D27168CC
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfEGRHW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:07:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46945 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRHW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:07:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id t187so4492020pgb.13
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mjBm/G9jb/ie0LFa0cAX5VBnmTMZLp5bHfBrb3mYO14=;
        b=KMTZHSvV/RJNwJh+rRWpXTGujaoigfAUanUO8V4wx75daz9jgXgqRZECB2rCF8l64r
         ecE94jcww5sF30jBMbo4rU9dSdUXsm/mlb/MQItT/X7kW01b9+mdVk3fTvP5UwtS0iCL
         6+6UloVeE/fwmSOz7AwnFUZxWll7wjpERWlQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mjBm/G9jb/ie0LFa0cAX5VBnmTMZLp5bHfBrb3mYO14=;
        b=BUXNgOABqglSzSQXAvpycOjwVFE1C54TliEIWT4GuZXpK/8lL9IMp4sS8iRN6QE1iF
         ke1FQZdNANEEomUb6xdpbhRRhotdIyCyUksiodEeJNu46C/jpmFOrdcXdEv7jOQXeZdT
         P2L/kZ6jarUJKGfWpCxisszfVcuLtAaXS130Fmm942sMUSlRKqwwOQ6eySTRcNB013K5
         enWA+TVzZS2GgfRgJvPYYy/EGazOQIHAbRpd64yQxfB/x4/rrEcXHbBoIfIXZLh2LQCC
         aXvsqmVMykMlWIa/ptiPBRlGs0jJL4cbIa8YcOrAsJq3UEjVhAtfrB+qVI+iz/vkWdfr
         64LA==
X-Gm-Message-State: APjAAAVQcrynOmASizO5SsoXD82oGDzEJ8swiP7Ppw3Ad2IkvMn+m3YI
        GZ+PeSg7ZTB+1cbnkjS3qN/RoxHGxJm+H4H2rk8I+AOrYOm0covAuVClqNNPiGquS7FdBOB3Tle
        +JM83xu64bPHfpQ7VxoDLVGoaRJNepgPuoQgOLpeNeOgV4zTR/CJdI6w66Yfx5ZJnTKDoFrO0ar
        gKP0TcLWeF/xRdlLIFajvV
X-Google-Smtp-Source: APXvYqzGiymFnknoimUywxRBuXbgY49Q6GOwIbxKJXymyiX4PyDsDvKJ9SBiwdQIwctaAO/0rpfMCg==
X-Received: by 2002:a65:64d3:: with SMTP id t19mr41292709pgv.57.1557248841218;
        Tue, 07 May 2019 10:07:21 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:07:20 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 20/21] megaraid_sas: Export RAID map through debugfs
Date:   Tue,  7 May 2019 10:05:49 -0700
Message-Id: <1557248750-4099-21-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Create a debugfs interface for megaraid_sas driver.
Provide interface to dump driver RAID map in debugfs.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/Makefile               |   2 +-
 drivers/scsi/megaraid/megaraid_sas.h         |   4 +
 drivers/scsi/megaraid/megaraid_sas_base.c    |  14 +++
 drivers/scsi/megaraid/megaraid_sas_debugfs.c | 180 +++++++++++++++++++++++++++
 drivers/scsi/megaraid/megaraid_sas_fusion.h  |   5 +
 5 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 drivers/scsi/megaraid/megaraid_sas_debugfs.c

diff --git a/drivers/scsi/megaraid/Makefile b/drivers/scsi/megaraid/Makefile
index 6e74d21227a5..12177e4cae65 100644
--- a/drivers/scsi/megaraid/Makefile
+++ b/drivers/scsi/megaraid/Makefile
@@ -3,4 +3,4 @@ obj-$(CONFIG_MEGARAID_MM)	+= megaraid_mm.o
 obj-$(CONFIG_MEGARAID_MAILBOX)	+= megaraid_mbox.o
 obj-$(CONFIG_MEGARAID_SAS)	+= megaraid_sas.o
 megaraid_sas-objs := megaraid_sas_base.o megaraid_sas_fusion.o \
-	megaraid_sas_fp.o
+	megaraid_sas_fp.o megaraid_sas_debugfs.o
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 840506f2f33c..56b3204d3fc6 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2390,6 +2390,10 @@ struct megasas_instance {
 	u8 task_abort_tmo;
 	u8 max_reset_tmo;
 	u8 snapdump_wait_time;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_root;
+	struct dentry *raidmap_dump;
+#endif
 	u8 enable_fw_dev_list;
 };
 struct MR_LD_VF_MAP {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 5f7842982d57..1006364ce0d0 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -188,6 +188,12 @@ static bool support_nvme_encapsulation;
 /* define lock for aen poll */
 spinlock_t poll_aen_lock;
 
+extern struct dentry *megasas_debugfs_root;
+extern void megasas_init_debugfs(void);
+extern void megasas_exit_debugfs(void);
+extern void megasas_setup_debugfs(struct megasas_instance *instance);
+extern void megasas_destroy_debugfs(struct megasas_instance *instance);
+
 void
 megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
 		     u8 alt_status);
@@ -7141,6 +7147,8 @@ static int megasas_probe_one(struct pci_dev *pdev,
 		goto fail_start_aen;
 	}
 
+	megasas_setup_debugfs(instance);
+
 	/* Get current SR-IOV LD/VF affiliation */
 	if (instance->requestorId)
 		megasas_get_ld_vf_affiliation(instance, 1);
@@ -7611,6 +7619,8 @@ static void megasas_detach_one(struct pci_dev *pdev)
 
 	megasas_free_ctrl_mem(instance);
 
+	megasas_destroy_debugfs(instance);
+
 	scsi_host_put(host);
 
 	pci_disable_device(pdev);
@@ -8538,6 +8548,8 @@ static int __init megasas_init(void)
 
 	megasas_mgmt_majorno = rval;
 
+	megasas_init_debugfs();
+
 	/*
 	 * Register ourselves as PCI hotplug module
 	 */
@@ -8597,6 +8609,7 @@ static int __init megasas_init(void)
 err_dcf_attr_ver:
 	pci_unregister_driver(&megasas_pci_driver);
 err_pcidrv:
+	megasas_exit_debugfs();
 	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
 	return rval;
 }
@@ -8619,6 +8632,7 @@ static void __exit megasas_exit(void)
 			   &driver_attr_support_nvme_encapsulation);
 
 	pci_unregister_driver(&megasas_pci_driver);
+	megasas_exit_debugfs();
 	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
 }
 
diff --git a/drivers/scsi/megaraid/megaraid_sas_debugfs.c b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
new file mode 100644
index 000000000000..e52837bb6807
--- /dev/null
+++ b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
@@ -0,0 +1,180 @@
+/*
+ *  Linux MegaRAID driver for SAS based RAID controllers
+ *
+ *  Copyright (c) 2003-2018  LSI Corporation.
+ *  Copyright (c) 2003-2018  Avago Technologies.
+ *  Copyright (c) 2003-2018  Broadcom Inc.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version 2
+ *  of the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ *  Authors: Broadcom Inc.
+ *           Kashyap Desai <kashyap.desai@broadcom.com>
+ *           Sumit Saxena <sumit.saxena@broadcom.com>
+ *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
+ *
+ *  Send feedback to: megaraidlinux.pdl@broadcom.com
+ */
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/compat.h>
+#include <linux/irq_poll.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+
+#include "megaraid_sas_fusion.h"
+#include "megaraid_sas.h"
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+struct dentry *megasas_debugfs_root;
+
+static ssize_t
+megasas_debugfs_read(struct file *filp, char __user *ubuf, size_t cnt,
+		      loff_t *ppos)
+{
+	struct megasas_debugfs_buffer *debug = filp->private_data;
+
+	if (!debug || !debug->buf)
+		return 0;
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, debug->buf, debug->len);
+}
+
+static int
+megasas_debugfs_raidmap_open(struct inode *inode, struct file *file)
+{
+	struct megasas_instance *instance = inode->i_private;
+	struct megasas_debugfs_buffer *debug;
+	struct fusion_context *fusion;
+
+	fusion = instance->ctrl_context;
+
+	debug = kzalloc(sizeof(struct megasas_debugfs_buffer), GFP_KERNEL);
+	if (!debug)
+		return -ENOMEM;
+
+	debug->buf = (void *)fusion->ld_drv_map[(instance->map_id & 1)];
+	debug->len = fusion->drv_map_sz;
+	file->private_data = debug;
+
+	return 0;
+}
+
+static int
+megasas_debugfs_release(struct inode *inode, struct file *file)
+{
+	struct megasas_debug_buffer *debug = file->private_data;
+
+	if (!debug)
+		return 0;
+
+	file->private_data = NULL;
+	kfree(debug);
+	return 0;
+}
+
+static const struct file_operations megasas_debugfs_raidmap_fops = {
+	.owner		= THIS_MODULE,
+	.open           = megasas_debugfs_raidmap_open,
+	.read           = megasas_debugfs_read,
+	.release        = megasas_debugfs_release,
+};
+
+/*
+ * megasas_init_debugfs :	Create debugfs root for megaraid_sas driver
+ */
+void megasas_init_debugfs(void)
+{
+	megasas_debugfs_root = debugfs_create_dir("megaraid_sas", NULL);
+	if (!megasas_debugfs_root)
+		pr_info("Cannot create debugfs root\n");
+}
+
+/*
+ * megasas_exit_debugfs :	Remove debugfs root for megaraid_sas driver
+ */
+void megasas_exit_debugfs(void)
+{
+	debugfs_remove_recursive(megasas_debugfs_root);
+}
+
+/*
+ * megasas_setup_debugfs :	Setup debugfs per Fusion adapter
+ * instance:				Soft instance of adapter
+ */
+void
+megasas_setup_debugfs(struct megasas_instance *instance)
+{
+	char name[64];
+	struct fusion_context *fusion;
+
+	fusion = instance->ctrl_context;
+
+	if (fusion) {
+		snprintf(name, sizeof(name),
+			 "scsi_host%d", instance->host->host_no);
+		if (!instance->debugfs_root) {
+			instance->debugfs_root =
+				debugfs_create_dir(name, megasas_debugfs_root);
+			if (!instance->debugfs_root) {
+				dev_err(&instance->pdev->dev,
+					"Cannot create per adapter debugfs directory\n");
+				return;
+			}
+		}
+
+		snprintf(name, sizeof(name), "raidmap_dump");
+		instance->raidmap_dump =
+			debugfs_create_file(name, S_IRUGO,
+					    instance->debugfs_root, instance,
+					    &megasas_debugfs_raidmap_fops);
+		if (!instance->raidmap_dump) {
+			dev_err(&instance->pdev->dev,
+				"Cannot create raidmap debugfs file\n");
+			debugfs_remove(instance->debugfs_root);
+			return;
+		}
+	}
+
+}
+
+/*
+ * megasas_destroy_debugfs :	Destroy debugfs per Fusion adapter
+ * instance:					Soft instance of adapter
+ */
+void megasas_destroy_debugfs(struct megasas_instance *instance)
+{
+	debugfs_remove_recursive(instance->debugfs_root);
+}
+
+#else
+void megasas_init_debugfs(void)
+{
+}
+void megasas_exit_debugfs(void)
+{
+}
+void megasas_setup_debugfs(struct megasas_instance *instance)
+{
+}
+void megasas_destroy_debugfs(struct megasas_instance *instance)
+{
+}
+#endif /*CONFIG_DEBUG_FS*/
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index 160ac16941fe..98738290c533 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -1360,6 +1360,11 @@ struct  MR_SNAPDUMP_PROPERTIES {
 	u8       reserved[12];
 };
 
+struct megasas_debugfs_buffer {
+	void *buf;
+	u32 len;
+};
+
 void megasas_free_cmds_fusion(struct megasas_instance *instance);
 int megasas_ioc_init_fusion(struct megasas_instance *instance);
 u8 megasas_get_map_info(struct megasas_instance *instance);
-- 
2.16.1

