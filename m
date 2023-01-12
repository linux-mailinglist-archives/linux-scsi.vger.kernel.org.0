Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB886674AC
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Jan 2023 15:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjALOKr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Jan 2023 09:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjALOJ6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Jan 2023 09:09:58 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083F517EE;
        Thu, 12 Jan 2023 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673532316; x=1705068316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kigI8xABdMP1xwtDT4vgVnuAAix5zSZ65zwoSPiYgck=;
  b=FYlxYe66Ov53c+5oDY34ta97mrEcWgRvM+JSHsg3YZzAZ0ehQq6W9924
   j6JmPNV0tRpebPVx4WqvTt9i7T7BpL5GFyKyLl1jh4freuK1VYFocm5Vn
   wyDOcDWSijmWer7tr1iY0r2H+EONAyTJJoBY5BROiUvgvsdIa2zu6urLk
   5z/E7lUy/XKOhkxtd6VuZOdOo0uFet6aFDF7kHGUy9m7ZlPIBKzEZN18s
   kyh0fs+EWp7JmQda48fTJsKkqaL1L9pCWJ/2X3+sUsTiwfzm5p/dyr43j
   vTWGfuaIJ/xVFnEHbWjC3WKd4QjcHv7c2NbgmcUGWcISGU1WXYnlAqFPu
   g==;
X-IronPort-AV: E=Sophos;i="5.97,211,1669046400"; 
   d="scan'208";a="332632740"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 22:04:59 +0800
IronPort-SDR: i7Faa++nr6qxlk8F8mhlWzrnmXWD4h8nItyP+1N0R1+NuoM5NMw0L6bTdqt/SPa7x0AZPwfhgJ
 VT+aEJMHHls/V8jFEMpGDrvx5+iKOXkrqIn4ETafJGAqYurckSsEQOvt45z6VD3udbNJ9EniQn
 oyPc6qkqeydIPmIfImQ5s/0S3UI/1g3PaLLBdwfcn+myqfZQ+E87DXiei2jEG1QrfQ/C6k2fic
 rXZcg5Mlngu9D+oNUHGjPNxCAbqiY2++iGZzcS08I4pgQ/VaHzJjqYGo0YsIo6XYtcxtwt4mPO
 SoE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jan 2023 05:17:02 -0800
IronPort-SDR: 3zET9HnOI/MQpp2mvHmnMNPUo1z4S64D5TPxnaGkLpUB+4kRiU1Kuz0SHLUpKLYdDM3ZnXVPt9
 VIp/rLo13bXo7DGWwp5nWUolk5e/f+agFq1OUmt58y8h6+ztryG+lf4PoS8gAmaiYyQL2XwyC/
 pdDoKkIdSUKo4thDl5bZ4nbRzj7mM+sHpu0aGv/FL7JvrkQxxx3eM81BgbuA0eTQIpTSun/ifN
 mbLuJXnBUolBSfyOLgSR7uDCZco1kqIm/Uw2/c8yuHec7hz9pQvwiF4W0qkZs9RbTO4HrF/yYa
 S9A=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.12])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2023 06:04:58 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 14/18] scsi: sd: detect support for command duration limits
Date:   Thu, 12 Jan 2023 15:04:03 +0100
Message-Id: <20230112140412.667308-15-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112140412.667308-1-niklas.cassel@wdc.com>
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Detect if a disk supports command duration limits. Support for
the READ 16, WRITE 16, READ 32 and WRITE 32 commands is tested using
the function scsi_report_opcode(). For a disk supporting command
duration limits, the mode page indicating the command duration limits
descriptors that apply to the command is indicated using the rwcdlp
and cdlp bits.

Support duration limits is advertizes through sysfs using the new
"duration_limits" sysfs sub-directory of the generic device directory,
that is, /sys/block/sdX/device/duration_limits. Within this new
directory, the limit descriptors that apply to read and write operations
are exposed within the read and write directories, with descriptor
attributes grouped together in directories. The overall sysfs structure
created is:

/sys/block/sde/device/duration_limits/
├── perf_vs_duration_guideline
├── read
│   ├── 1
│   │   ├── duration_guideline
│   │   ├── duration_guideline_policy
│   │   ├── max_active_time
│   │   ├── max_active_time_policy
│   │   ├── max_inactive_time
│   │   └── max_inactive_time_policy
│   ├── 2
│   │   ├── duration_guideline
...
│   └── page
└── write
    ├── 1
    │   ├── duration_guideline
    │   ├── duration_guideline_policy
...

For each of the read and write descriptor directories, the page
attribute file indicate the command duration limit page providing the
descriptors. The possible values for the page attribute are "A", "B",
"T2A" and "T2B".

The new "duration_limits" attributes directory is added only for disks
that supports command duration limits.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/scsi/Makefile |   2 +-
 drivers/scsi/sd.c     |   2 +
 drivers/scsi/sd.h     |  61 ++++
 drivers/scsi/sd_cdl.c | 764 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 828 insertions(+), 1 deletion(-)
 create mode 100644 drivers/scsi/sd_cdl.c

diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index f055bfd54a68..0e48cb6d21d6 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -170,7 +170,7 @@ scsi_mod-$(CONFIG_BLK_DEV_BSG)	+= scsi_bsg.o
 
 hv_storvsc-y			:= storvsc_drv.o
 
-sd_mod-objs	:= sd.o
+sd_mod-objs	:= sd.o sd_cdl.o
 sd_mod-$(CONFIG_BLK_DEV_INTEGRITY) += sd_dif.o
 sd_mod-$(CONFIG_BLK_DEV_ZONED) += sd_zbc.o
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2b56ff4fcf8a..45ff44a73256 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3306,6 +3306,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_read_write_same(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
 		sd_config_protection(sdkp);
+		sd_read_cdl(sdkp, buffer);
 	}
 
 	/*
@@ -3626,6 +3627,7 @@ static void scsi_disk_release(struct device *dev)
 
 	ida_free(&sd_index_ida, sdkp->index);
 	sd_zbc_free_zone_info(sdkp);
+	sd_cdl_release(sdkp);
 	put_device(&sdkp->device->sdev_gendev);
 	free_opal_dev(sdkp->opal_dev);
 
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..e60d33bd222a 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -81,6 +81,62 @@ struct zoned_disk_info {
 	u32		zone_blocks;
 };
 
+/*
+ * Command duration limits sub-pages for the control mode page 0Ah.
+ */
+enum sd_cdlp {
+	SD_CDLP_A,
+	SD_CDLP_B,
+	SD_CDLP_T2A,
+	SD_CDLP_T2B,
+	SD_CDLP_NONE,
+
+	SD_CDL_MAX_PAGES = SD_CDLP_NONE,
+};
+
+enum sd_cdl_cmd {
+	SD_CDL_READ_16,
+	SD_CDL_WRITE_16,
+	SD_CDL_READ_32,
+	SD_CDL_WRITE_32,
+
+	SD_CDL_CMD_MAX,
+};
+
+enum sd_cdl_rw {
+	SD_CDL_READ,
+	SD_CDL_WRITE,
+	SD_CDL_RW,
+};
+
+struct sd_cdl_desc {
+	struct kobject	kobj;
+	u64		max_inactive_time;
+	u64		max_active_time;
+	u64		duration;
+	u8		max_inactive_policy;
+	u8		max_active_policy;
+	u8		duration_policy;
+	u8		cdlp;
+};
+
+#define SD_CDL_MAX_DESC		7
+
+struct sd_cdl_page {
+	struct kobject		kobj;
+	bool			sysfs_registered;
+	enum sd_cdl_rw		rw;
+	enum sd_cdlp		cdlp;
+	struct sd_cdl_desc      descs[SD_CDL_MAX_DESC];
+};
+
+struct sd_cdl {
+	struct kobject		kobj;
+	bool			sysfs_registered;
+	u8			perf_vs_duration_guideline;
+	struct sd_cdl_page	pages[SD_CDL_RW];
+};
+
 struct scsi_disk {
 	struct scsi_device *device;
 
@@ -131,6 +187,7 @@ struct scsi_disk {
 	u8		provisioning_mode;
 	u8		zeroing_mode;
 	u8		nr_actuators;		/* Number of actuators */
+	struct sd_cdl	*cdl;
 	unsigned	ATO : 1;	/* state of disk ATO bit */
 	unsigned	cache_override : 1; /* temp override of WCE,RCD */
 	unsigned	WCE : 1;	/* state of disk WCE bit */
@@ -295,4 +352,8 @@ static inline blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd,
 void sd_print_sense_hdr(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr);
 void sd_print_result(const struct scsi_disk *sdkp, const char *msg, int result);
 
+/* Command duration limits support (in sd_cdl.c) */
+void sd_read_cdl(struct scsi_disk *sdkp, unsigned char *buf);
+void sd_cdl_release(struct scsi_disk *sdkp);
+
 #endif /* _SCSI_DISK_H */
diff --git a/drivers/scsi/sd_cdl.c b/drivers/scsi/sd_cdl.c
new file mode 100644
index 000000000000..513cd989f19a
--- /dev/null
+++ b/drivers/scsi/sd_cdl.c
@@ -0,0 +1,764 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SCSI Command Duration Limits (CDL)
+ *
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+#include <linux/vmalloc.h>
+#include <linux/mutex.h>
+
+#include <asm/unaligned.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+
+#include "sd.h"
+
+/*
+ * Command duration limits sub-pages for the control mode page 0Ah.
+ */
+static const struct sd_cdlp_info {
+	u8	subpage;
+	char	*name;
+} cdl_page[SD_CDL_MAX_PAGES + 1] = {
+	{ 0x03,	"A"	},
+	{ 0x04,	"B"	},
+	{ 0x07,	"T2A"	},
+	{ 0x08,	"T2B"	},
+	{ 0x00,	"none"	},
+};
+
+static const struct sd_cdl_cmd_info {
+	u8	opcode;
+	u16	sa;
+	char	*name;
+} cdl_cmd[SD_CDL_CMD_MAX] = {
+	{ READ_16,		0,		"READ_16"	},
+	{ WRITE_16,		0,		"WRITE_16"	},
+	{ VARIABLE_LENGTH_CMD,	READ_32,	"READ_32"	},
+	{ VARIABLE_LENGTH_CMD,	WRITE_32,	"WRITE_32"	},
+};
+
+static const char *sd_cdl_perf_name(u8 val)
+{
+	switch (val) {
+	case 0x00:
+		return "0";
+	case 0x01:
+		return "0.5";
+	case 0x02:
+		return "1.0";
+	case 0x03:
+		return "1.5";
+	case 0x04:
+		return "2.0";
+	case 0x05:
+		return "2.5";
+	case 0x06:
+		return "3";
+	case 0x07:
+		return "4";
+	case 0x08:
+		return "5";
+	case 0x09:
+		return "8";
+	case 0x0A:
+		return "10";
+	case 0x0B:
+		return "15";
+	case 0x0C:
+		return "20";
+	default:
+		return "?";
+	}
+}
+
+static const char *sd_cdl_policy_name(u8 policy)
+{
+	switch (policy) {
+	case 0x00:
+		return "complete-earliest";
+	case 0x01:
+		return "continue-next-limit";
+	case 0x02:
+		return "continue-no-limit";
+	case 0x0d:
+		return "complete-unavailable";
+	case 0x0e:
+		return "abort-recovery";
+	case 0x0f:
+		return "abort";
+	default:
+		return "?";
+	}
+}
+
+/*
+ * Command duration limits descriptors sysfs plumbing.
+ */
+struct sd_cdl_desc_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct sd_cdl_desc *desc, char *buf);
+};
+
+#define CDL_DESC_ATTR_RO(_name)	\
+	static struct sd_cdl_desc_sysfs_entry				\
+	cdl_desc_##_name##_entry = {					\
+		.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+		.show	= cdl_desc_##_name##_show,			\
+	}
+
+static ssize_t cdl_desc_max_inactive_time_show(struct sd_cdl_desc *desc,
+					       char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", desc->max_inactive_time);
+}
+CDL_DESC_ATTR_RO(max_inactive_time);
+
+static ssize_t cdl_desc_max_inactive_time_policy_show(struct sd_cdl_desc *desc,
+						      char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			sd_cdl_policy_name(desc->max_inactive_policy));
+}
+CDL_DESC_ATTR_RO(max_inactive_time_policy);
+
+static ssize_t cdl_desc_max_active_time_show(struct sd_cdl_desc *desc,
+					     char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", desc->max_active_time);
+}
+CDL_DESC_ATTR_RO(max_active_time);
+
+static ssize_t cdl_desc_max_active_time_policy_show(struct sd_cdl_desc *desc,
+						    char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			sd_cdl_policy_name(desc->max_active_policy));
+}
+CDL_DESC_ATTR_RO(max_active_time_policy);
+
+static ssize_t cdl_desc_duration_guideline_show(struct sd_cdl_desc *desc,
+						char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", desc->duration);
+}
+CDL_DESC_ATTR_RO(duration_guideline);
+
+static ssize_t cdl_desc_duration_guideline_policy_show(struct sd_cdl_desc *desc,
+						       char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+		sd_cdl_policy_name(desc->duration_policy));
+}
+CDL_DESC_ATTR_RO(duration_guideline_policy);
+
+static umode_t sd_cdl_desc_attr_visible(struct kobject *kobj,
+					struct attribute *attr, int n)
+{
+	struct sd_cdl_desc *desc = container_of(kobj, struct sd_cdl_desc, kobj);
+
+	/*
+	 * Descriptors in pages A and B only have the duration guideline
+	 * field.
+	 */
+	if ((desc->cdlp == SD_CDLP_A || desc->cdlp == SD_CDLP_B) &&
+	    (attr != &cdl_desc_duration_guideline_entry.attr))
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *sd_cdl_desc_attrs[] = {
+	&cdl_desc_max_inactive_time_entry.attr,
+	&cdl_desc_max_inactive_time_policy_entry.attr,
+	&cdl_desc_max_active_time_entry.attr,
+	&cdl_desc_max_active_time_policy_entry.attr,
+	&cdl_desc_duration_guideline_entry.attr,
+	&cdl_desc_duration_guideline_policy_entry.attr,
+	NULL,
+};
+
+static const struct attribute_group sd_cdl_desc_group = {
+	.attrs = sd_cdl_desc_attrs,
+	.is_visible = sd_cdl_desc_attr_visible,
+};
+__ATTRIBUTE_GROUPS(sd_cdl_desc);
+
+static ssize_t sd_cdl_desc_sysfs_show(struct kobject *kobj,
+				      struct attribute *attr, char *buf)
+{
+	struct sd_cdl_desc_sysfs_entry *entry =
+		container_of(attr, struct sd_cdl_desc_sysfs_entry, attr);
+	struct sd_cdl_desc *desc = container_of(kobj, struct sd_cdl_desc, kobj);
+
+	return entry->show(desc, buf);
+}
+
+static const struct sysfs_ops sd_cdl_desc_sysfs_ops = {
+	.show	= sd_cdl_desc_sysfs_show,
+};
+
+static void sd_cdl_sysfs_nop_release(struct kobject *kobj) { }
+
+static struct kobj_type sd_cdl_desc_ktype = {
+	.sysfs_ops	= &sd_cdl_desc_sysfs_ops,
+	.default_groups	= sd_cdl_desc_groups,
+	.release	= sd_cdl_sysfs_nop_release,
+};
+
+/*
+ * Duration limits page sysfs plumbing.
+ */
+struct sd_cdl_page_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct sd_cdl_page *page, char *buf);
+};
+
+#define CDL_PAGE_ATTR_RO(_name)	\
+	static struct sd_cdl_page_sysfs_entry				\
+	cdl_page_##_name##_entry = {					\
+		.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+		.show	= cdl_page_##_name##_show,			\
+	}
+
+static ssize_t cdl_page_page_show(struct sd_cdl_page *page, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", cdl_page[page->cdlp].name);
+}
+CDL_PAGE_ATTR_RO(page);
+
+static struct attribute *sd_cdl_page_attrs[] = {
+	&cdl_page_page_entry.attr,
+	NULL,
+};
+
+static const struct attribute_group sd_cdl_page_group = {
+	.attrs = sd_cdl_page_attrs,
+};
+__ATTRIBUTE_GROUPS(sd_cdl_page);
+
+static ssize_t sd_cdl_page_sysfs_show(struct kobject *kobj,
+				      struct attribute *attr, char *buf)
+{
+	struct sd_cdl_page_sysfs_entry *entry =
+		container_of(attr, struct sd_cdl_page_sysfs_entry, attr);
+	struct sd_cdl_page *page = container_of(kobj, struct sd_cdl_page, kobj);
+
+	return entry->show(page, buf);
+}
+
+static const struct sysfs_ops sd_cdl_page_sysfs_ops = {
+	.show	= sd_cdl_page_sysfs_show,
+};
+
+static struct kobj_type sd_cdl_page_ktype = {
+	.sysfs_ops	= &sd_cdl_page_sysfs_ops,
+	.default_groups	= sd_cdl_page_groups,
+	.release	= sd_cdl_sysfs_nop_release,
+};
+
+static void sd_cdl_sysfs_unregister_page(struct sd_cdl_page *page)
+{
+	int i;
+
+	for (i = 0; i < SD_CDL_MAX_DESC; i++) {
+		if (page->sysfs_registered)
+			kobject_del(&page->descs[i].kobj);
+		kobject_put(&page->descs[i].kobj);
+	}
+	if (page->sysfs_registered)
+		kobject_del(&page->kobj);
+	kobject_put(&page->kobj);
+
+	page->cdlp = SD_CDLP_NONE;
+	page->sysfs_registered = false;
+}
+
+static int sd_cdl_sysfs_register_page(struct scsi_disk *sdkp,
+				      struct sd_cdl_page *page)
+{
+	int i, ret;
+
+	/*
+	 * If the page is already registered, the updated page descriptors
+	 * are already exported.
+	 */
+	if (page->sysfs_registered)
+		return 0;
+
+	ret = kobject_add(&page->kobj, &sdkp->cdl->kobj,
+			  "%s", page->rw ? "write" : "read");
+	if (ret) {
+		kobject_put(&page->kobj);
+		return ret;
+	}
+
+	for (i = 0; i < SD_CDL_MAX_DESC; i++) {
+		ret = kobject_add(&page->descs[i].kobj, &page->kobj,
+				  "%d", i + 1);
+		if (ret) {
+			int j;
+
+			kobject_put(&page->descs[i].kobj);
+			for (j = 0; j < SD_CDL_MAX_DESC; j++) {
+				if (j < i)
+					kobject_del(&page->descs[j].kobj);
+				kobject_put(&page->descs[j].kobj);
+			}
+			kobject_del(&page->kobj);
+			kobject_put(&page->kobj);
+			return ret;
+		}
+	}
+
+	page->sysfs_registered = true;
+
+	return 0;
+}
+
+/*
+ * Command duration limits sysfs plumbing, top level (duration limits directory
+ * under the "device" sysfs directory.
+ */
+struct sd_cdl_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct sd_cdl *cdl, char *buf);
+};
+
+#define CDL_ATTR_RO(_name)	\
+	static struct sd_cdl_sysfs_entry cdl_##_name##_entry = {	\
+		.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+		.show	= cdl_##_name##_show,				\
+	}
+
+static ssize_t cdl_perf_vs_duration_guideline_show(struct sd_cdl *cdl,
+						   char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  sd_cdl_perf_name(cdl->perf_vs_duration_guideline));
+}
+CDL_ATTR_RO(perf_vs_duration_guideline);
+
+static struct attribute *sd_cdl_attrs[] = {
+	&cdl_perf_vs_duration_guideline_entry.attr,
+	NULL,
+};
+
+static umode_t sd_cdl_attr_visible(struct kobject *kobj,
+				   struct attribute *attr, int n)
+{
+	struct sd_cdl *cdl = container_of(kobj, struct sd_cdl, kobj);
+
+	/* perf_vs_duration_guideline exists only if page T2A is supported */
+	if (attr == &cdl_perf_vs_duration_guideline_entry.attr &&
+	    cdl->pages[SD_CDL_READ].cdlp != SD_CDLP_T2A &&
+	    cdl->pages[SD_CDL_WRITE].cdlp != SD_CDLP_T2A)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group sd_cdl_group = {
+	.attrs		= sd_cdl_attrs,
+	.is_visible	= sd_cdl_attr_visible,
+};
+__ATTRIBUTE_GROUPS(sd_cdl);
+
+static ssize_t sd_cdl_sysfs_show(struct kobject *kobj,
+				 struct attribute *attr, char *page)
+{
+	struct sd_cdl_sysfs_entry *entry =
+		container_of(attr, struct sd_cdl_sysfs_entry, attr);
+	struct sd_cdl *cdl = container_of(kobj, struct sd_cdl, kobj);
+
+	return entry->show(cdl, page);
+}
+
+static const struct sysfs_ops sd_cdl_sysfs_ops = {
+	.show	= sd_cdl_sysfs_show,
+};
+
+static void sd_cdl_sysfs_release(struct kobject *kobj)
+{
+	struct sd_cdl *cdl = container_of(kobj, struct sd_cdl, kobj);
+
+	kfree(cdl);
+}
+
+static struct kobj_type sd_cdl_ktype = {
+	.sysfs_ops	= &sd_cdl_sysfs_ops,
+	.default_groups	= sd_cdl_groups,
+	.release	= sd_cdl_sysfs_release,
+};
+
+static void sd_cdl_sysfs_unregister(struct scsi_disk *sdkp)
+{
+	struct sd_cdl *cdl = NULL;
+	int i;
+
+	swap(sdkp->cdl, cdl);
+	if (!cdl)
+		return;
+
+	if (!cdl->sysfs_registered) {
+		kfree(cdl);
+		return;
+	}
+
+	for (i = 0; i < SD_CDL_RW; i++) {
+		if (cdl->pages[i].sysfs_registered)
+			sd_cdl_sysfs_unregister_page(&cdl->pages[i]);
+	}
+
+	kobject_del(&cdl->kobj);
+	kobject_put(&cdl->kobj);
+}
+
+static void sd_cdl_sysfs_register(struct scsi_disk *sdkp)
+{
+	struct scsi_device *sdev = sdkp->device;
+	struct sd_cdl *cdl = sdkp->cdl;
+	struct sd_cdl_page *page;
+	int i, ret;
+
+	if (!cdl->sysfs_registered) {
+		ret = kobject_add(&cdl->kobj, &sdev->sdev_gendev.kobj,
+				  "duration_limits");
+		if (ret) {
+			kobject_put(&cdl->kobj);
+			goto unregister;
+		}
+
+		cdl->sysfs_registered = true;
+	}
+
+	/* Check if the pages changed */
+	for (i = 0; i < SD_CDL_RW; i++) {
+		page = &cdl->pages[i];
+		if (page->cdlp == SD_CDLP_NONE) {
+			sd_cdl_sysfs_unregister_page(page);
+			continue;
+		}
+
+		ret = sd_cdl_sysfs_register_page(sdkp, page);
+		if (ret) {
+			page->cdlp = SD_CDLP_NONE;
+			goto unregister;
+		}
+	}
+
+	return;
+
+unregister:
+	sd_cdl_sysfs_unregister(sdkp);
+}
+
+/*
+ * CDL pages A and B time limits in microseconds.
+ */
+static u64 sd_cdl_time(u8 *buf, u8 cdlunit)
+{
+	u64 val = get_unaligned_be16(buf);
+	u64 factor;
+
+	switch (cdlunit) {
+	case 0x00:
+		return 0;
+	case 0x04:
+		/* 1 microsecond */
+		factor = NSEC_PER_USEC;
+		break;
+	case 0x05:
+		/* 10 milliseconds */
+		factor = 10ULL * USEC_PER_MSEC;
+		break;
+	case 0x06:
+		/* 500 milliseconds */
+		factor = 500ULL * USEC_PER_MSEC;
+		break;
+	default:
+		return 0;
+	}
+
+	return val * factor;
+}
+
+/*
+ * CDL pages T2A and T2B time limits in microseconds.
+ */
+static u64 sd_cdl_t2time(u8 *buf, u8 t2cdlunits)
+{
+	u64 val = get_unaligned_be16(buf);
+	u64 factor;
+
+	switch (t2cdlunits) {
+	case 0x00:
+		return 0;
+	case 0x06:
+		/* 500 nanoseconds */
+		factor = 500;
+		break;
+	case 0x08:
+		/* 1 microsecond */
+		factor = NSEC_PER_USEC;
+		break;
+	case 0x0A:
+		/* 10 milliseconds */
+		factor = 10ULL * NSEC_PER_MSEC;
+		break;
+	case 0x0E:
+		/* 500 milliseconds */
+		factor = 500ULL * NSEC_PER_MSEC;
+		break;
+	default:
+		return 0;
+	}
+
+	val *= factor;
+	do_div(val, NSEC_PER_USEC);
+
+	return val;
+}
+
+static int sd_cdl_read_page(struct scsi_disk *sdkp, struct sd_cdl_page *page,
+			    unsigned char *buf)
+{
+	struct sd_cdl *cdl = sdkp->cdl;
+	struct sd_cdl_desc *desc = &page->descs[0];
+	u8 cdlp = page->cdlp;
+	struct scsi_mode_data data;
+	int i, ret;
+
+	ret = scsi_mode_sense(sdkp->device, 0x08, 0x0a, cdl_page[cdlp].subpage,
+			      buf, SD_BUF_SIZE, SD_TIMEOUT, sdkp->max_retries,
+			      &data, NULL);
+	if (ret) {
+		sd_printk(KERN_ERR, sdkp,
+			  "Command duration limits: read CDL page %s failed\n",
+			  cdl_page[cdlp].name);
+		return ret;
+	}
+	buf += data.header_length + data.block_descriptor_length;
+
+	if (cdlp == SD_CDLP_A || cdlp == SD_CDLP_B) {
+		buf += 8;
+
+		for (i = 0; i < SD_CDL_MAX_DESC; i++, buf += 4, desc++) {
+			u8 cdlunit = (buf[0] & 0xe0) >> 5;
+
+			desc->duration = sd_cdl_time(&buf[2], cdlunit);
+			desc->cdlp = cdlp;
+		}
+	} else {
+		/* T2A and T2B limits page */
+		if (cdlp == SD_CDLP_T2A)
+			cdl->perf_vs_duration_guideline = buf[7] >> 4;
+
+		buf += 8;
+
+		for (i = 0; i < SD_CDL_MAX_DESC; i++, buf += 32, desc++) {
+			u8 t2cdlunits = buf[0] & 0x0f;
+
+			desc->max_inactive_time =
+				sd_cdl_t2time(&buf[2], t2cdlunits);
+			desc->max_active_time =
+				sd_cdl_t2time(&buf[4], t2cdlunits);
+			desc->duration =
+				sd_cdl_t2time(&buf[10], t2cdlunits);
+			desc->max_inactive_policy =  (buf[6] >> 4) & 0x0f;
+			desc->max_active_policy = buf[6] & 0x0f;
+			desc->duration_policy = buf[14] & 0x0f;
+			desc->cdlp = cdlp;
+		}
+	}
+
+	return 0;
+}
+
+static int sd_cdl_read_pages(struct scsi_disk *sdkp, enum sd_cdlp *rw_cdlp,
+			     unsigned char *buf)
+{
+	struct sd_cdl *cdl = sdkp->cdl;
+	struct sd_cdl_page *page;
+	int i, ret;
+
+	/* Read supported pages */
+	for (i = 0; i < SD_CDL_RW; i++) {
+		page = &cdl->pages[i];
+		page->cdlp = rw_cdlp[i];
+		if (page->cdlp == SD_CDLP_NONE)
+			continue;
+
+		ret = sd_cdl_read_page(sdkp, page, buf);
+		if (ret) {
+			page->cdlp = SD_CDLP_NONE;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static u8 sd_cdl_check_cmd_support(struct scsi_disk *sdkp,
+				   enum sd_cdl_cmd cmd, unsigned char *buf)
+{
+	u8 opcode = cdl_cmd[cmd].opcode;
+	u16 sa = cdl_cmd[cmd].sa;
+	u8 cdlp;
+
+	/*
+	 * READ 32 and WRITE 32 are used only for disks that also support
+	 * type 2 data protection. If the disk does not have such feature,
+	 * ignore these commands.
+	 */
+	if ((sa == READ_32 || sa == WRITE_32) &&
+	    sdkp->protection_type != T10_PI_TYPE2_PROTECTION)
+		return SD_CDLP_NONE;
+
+	/* Check operation code */
+	if (scsi_report_opcode(sdkp->device, buf, SD_BUF_SIZE, opcode, sa) < 0)
+		return SD_CDLP_NONE;
+
+	if ((buf[1] & 0x03) != 0x03)
+		return SD_CDLP_NONE;
+
+	/* See SPC-6, one command format of REPORT SUPPORTED OPERATION CODES */
+	cdlp = (buf[1] & 0x18) >> 3;
+	if (buf[0] & 0x01) {
+		/* rwcdlp == 1 */
+		switch (cdlp) {
+		case 0x01:
+			return SD_CDLP_T2A;
+		case 0x02:
+			return SD_CDLP_T2B;
+		}
+	} else {
+		/* rwcdlp == 0 */
+		switch (cdlp) {
+		case 0x01:
+			return SD_CDLP_A;
+		case 0x02:
+			return SD_CDLP_B;
+		}
+	}
+
+	return SD_CDLP_NONE;
+}
+
+static bool sd_cdl_supported(struct scsi_disk *sdkp, enum sd_cdlp *rw_cdlp,
+			     unsigned char *buf)
+{
+	enum sd_cdlp cmd_cdlp[SD_CDL_CMD_MAX];
+	int i;
+
+	/*
+	 * Command duration limits is supported for READ 16, WRITE 16,
+	 * READ 32 and WRITE 32. Go through all these commands one at a time
+	 * and check if any support duration limits.
+	 */
+	for (i = 0; i < SD_CDL_CMD_MAX; i++)
+		cmd_cdlp[i] = sd_cdl_check_cmd_support(sdkp, i, buf);
+
+	/*
+	 * Allow support only for drives that report the same CDL page for the
+	 * read 16 and 32 variants and the same page for the write 16 and 32
+	 * variants.
+	 */
+	if (cmd_cdlp[SD_CDL_READ_32] != SD_CDLP_NONE &&
+	    cmd_cdlp[SD_CDL_READ_16] != SD_CDLP_NONE) {
+		if (cmd_cdlp[SD_CDL_READ_32] != cmd_cdlp[SD_CDL_READ_16])
+			rw_cdlp[SD_CDL_READ] = SD_CDLP_NONE;
+		else
+			rw_cdlp[SD_CDL_READ] = cmd_cdlp[SD_CDL_READ_16];
+	} else {
+		rw_cdlp[SD_CDL_READ] = cmd_cdlp[SD_CDL_READ_16];
+	}
+
+	if (cmd_cdlp[SD_CDL_WRITE_32] != SD_CDLP_NONE &&
+	    cmd_cdlp[SD_CDL_WRITE_16] != SD_CDLP_NONE) {
+		if (cmd_cdlp[SD_CDL_WRITE_32] != cmd_cdlp[SD_CDL_WRITE_16])
+			rw_cdlp[SD_CDL_WRITE] = SD_CDLP_NONE;
+		else
+			rw_cdlp[SD_CDL_WRITE] = cmd_cdlp[SD_CDL_WRITE_16];
+	} else {
+		rw_cdlp[SD_CDL_WRITE] = cmd_cdlp[SD_CDL_WRITE_16];
+	}
+
+	return rw_cdlp[SD_CDL_READ] != SD_CDLP_NONE ||
+		rw_cdlp[SD_CDL_WRITE] != SD_CDLP_NONE;
+}
+
+static struct sd_cdl *sd_cdl_alloc(void)
+{
+	struct sd_cdl *cdl;
+	struct sd_cdl_page *page;
+	int i, j;
+
+	cdl = kzalloc(sizeof(struct sd_cdl), GFP_KERNEL);
+	if (!cdl)
+		return NULL;
+
+	kobject_init(&cdl->kobj, &sd_cdl_ktype);
+	for (i = 0; i < SD_CDL_RW; i++) {
+		page = &cdl->pages[i];
+		kobject_init(&page->kobj, &sd_cdl_page_ktype);
+		page->rw = i;
+		page->cdlp = SD_CDLP_NONE;
+		for (j = 0; j < SD_CDL_MAX_DESC; j++)
+			kobject_init(&page->descs[j].kobj, &sd_cdl_desc_ktype);
+	}
+
+	return cdl;
+}
+
+void sd_read_cdl(struct scsi_disk *sdkp, unsigned char *buf)
+{
+	struct sd_cdl *cdl = sdkp->cdl;
+	enum sd_cdlp rw_cdlp[SD_CDL_RW];
+
+	/*
+	 * Check for CDL support. If the disk does not support duration limits,
+	 * clear any support information that was previously registered.
+	 */
+	if (!sd_cdl_supported(sdkp, rw_cdlp, buf))
+		goto unregister;
+
+	if (!cdl) {
+		cdl = sd_cdl_alloc();
+		if (!cdl)
+			return;
+	}
+
+	/*
+	 * We have CDL support: force the use of READ16/WRITE16.
+	 * READ32 and WRITE32 will be used automatically for disks with
+	 * T10_PI_TYPE2_PROTECTION support.
+	 */
+	sdkp->device->use_16_for_rw = 1;
+	sdkp->device->use_10_for_rw = 0;
+
+	if (!sdkp->cdl) {
+		sd_printk(KERN_NOTICE, sdkp,
+			"Command duration limits supported, reads: %s, writes: %s\n",
+			cdl_page[rw_cdlp[SD_CDL_READ]].name,
+			cdl_page[rw_cdlp[SD_CDL_WRITE]].name);
+		sdkp->cdl = cdl;
+	}
+
+	/* Update duration limits descriptor pages */
+	if (sd_cdl_read_pages(sdkp, rw_cdlp, buf))
+		goto unregister;
+
+	sd_cdl_sysfs_register(sdkp);
+
+	return;
+
+unregister:
+	sd_cdl_sysfs_unregister(sdkp);
+}
+
+void sd_cdl_release(struct scsi_disk *sdkp)
+{
+	sd_cdl_sysfs_unregister(sdkp);
+}
-- 
2.39.0

