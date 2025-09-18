Return-Path: <linux-scsi+bounces-16216-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D62B28D25
	for <lists+linux-scsi@lfdr.de>; Sat, 16 Aug 2025 12:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9601CE76BB
	for <lists+linux-scsi@lfdr.de>; Sat, 16 Aug 2025 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288852D0C71;
	Sat, 16 Aug 2025 10:53:21 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5582BD59E;
	Sat, 16 Aug 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341601; cv=none; b=PbkASGjT4bmGCcqBBex2hno3sHKPREWXf4Kw67VrlYp6NR7Zku+n4dRIsyOhcbGWJA11gIIi2OB0EDrIb7OoLQm5ND30VX1+4uBPnutEUTBSx2Ryt8kIYqgfjWISUbqKzyTnCBdaSvGHCi+RxG3WlTdOg31w8t81vdmPdPlLaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341601; c=relaxed/simple;
	bh=O0hdZPocvQU+gp7j/QXbA4boVviLicrP/JZ2u4a2kYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pd0Qr9iQf/Fh2wusTyVVPh0Vf4Txa6hFtGyS56EWkUjkp5xLTKAFhFqw4By2pG0oAnNd0JVSD44qiY49c1l/5RGWntBSSblxpMcVyW4k65DN8E4x2gNGNZNRN0X9Z9N0B70sA8v/7HsEVP1wegI03JglYs0DuvUhsZzd4Ez/otU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c3wm03YqdztSxr;
	Sat, 16 Aug 2025 18:52:16 +0800 (CST)
Received: from kwepemk500001.china.huawei.com (unknown [7.202.194.86])
	by mail.maildlp.com (Postfix) with ESMTPS id 21EF71402CD;
	Sat, 16 Aug 2025 18:53:16 +0800 (CST)
Received: from localhost.localdomain (10.175.104.170) by
 kwepemk500001.china.huawei.com (7.202.194.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 Aug 2025 18:53:15 +0800
From: JiangJianJun <jiangjianjun3@huawei.com>
To: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<linux-scsi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <hare@suse.de>, <bvanassche@acm.org>,
	<michael.christie@oracle.com>, <hch@infradead.org>, <haowenchao22@gmail.com>,
	<john.g.garry@oracle.com>, <hewenliang4@huawei.com>, <yangyun50@huawei.com>,
	<wuyifeng10@huawei.com>, <wubo40@huawei.com>, <yangxingui@h-partners.com>
Subject: [PATCH 12/14] scsi: scsi_debug: Add params for configuring the error handler
Date: Sat, 16 Aug 2025 19:24:15 +0800
Message-ID: <20250816112417.3581253-13-jiangjianjun3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250816112417.3581253-1-jiangjianjun3@huawei.com>
References: <20250816112417.3581253-1-jiangjianjun3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500001.china.huawei.com (7.202.194.86)

From: JiangJianJun <jiangjianjun3@h-partners.com>

Add a new module parameter to configure error handlers based on
LUN/targets and toggle the enable/disable fallback functionality.

Signed-off-by: JiangJianJun <jiangjianjun3@h-partners.com>
---
 drivers/scsi/scsi_debug.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 0847767d4d43..64d5b85d961b 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -961,6 +961,10 @@ static bool write_since_sync;
 static bool sdebug_statistics = DEF_STATISTICS;
 static bool sdebug_wp;
 static bool sdebug_allow_restart;
+static bool sdebug_lun_eh;
+static bool sdebug_lun_eh_fallback;
+static bool sdebug_target_eh;
+static bool sdebug_target_eh_fallback;
 static enum {
 	BLK_ZONED_NONE	= 0,
 	BLK_ZONED_HA	= 1,
@@ -7362,6 +7366,10 @@ module_param_named(zone_max_open, sdeb_zbc_max_open, int, S_IRUGO);
 module_param_named(zone_nr_conv, sdeb_zbc_nr_conv, int, S_IRUGO);
 module_param_named(zone_size_mb, sdeb_zbc_zone_size_mb, int, S_IRUGO);
 module_param_named(allow_restart, sdebug_allow_restart, bool, S_IRUGO | S_IWUSR);
+module_param_named(lun_eh, sdebug_lun_eh, bool, 0444);
+module_param_named(lun_eh_fallback, sdebug_lun_eh_fallback, bool, 0444);
+module_param_named(target_eh, sdebug_target_eh, bool, 0444);
+module_param_named(target_eh_fallback, sdebug_target_eh_fallback, bool, 0444);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -7441,6 +7449,10 @@ MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones; [0] for no limit
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones (def=1)");
 MODULE_PARM_DESC(zone_size_mb, "Zone size in MiB (def=auto)");
 MODULE_PARM_DESC(allow_restart, "Set scsi_device's allow_restart flag(def=0)");
+MODULE_PARM_DESC(lun_eh, "LUN based error handle (def=0)");
+MODULE_PARM_DESC(lun_eh_fallback, "Fallback to further recovery if LUN recovery failed (def=0)");
+MODULE_PARM_DESC(target_eh, "target based error handle (def=0)");
+MODULE_PARM_DESC(target_eh_fallback, "Fallback to further recovery if target recovery failed (def=0)");
 
 #define SDEBUG_INFO_LEN 256
 static char sdebug_info[SDEBUG_INFO_LEN];
@@ -8427,6 +8439,7 @@ static struct attribute *sdebug_drv_attrs[] = {
 ATTRIBUTE_GROUPS(sdebug_drv);
 
 static struct device *pseudo_primary;
+static struct scsi_host_template sdebug_driver_template;
 
 static int __init scsi_debug_init(void)
 {
@@ -8435,6 +8448,17 @@ static int __init scsi_debug_init(void)
 	int k, ret, hosts_to_add;
 	int idx = -1;
 
+	if (sdebug_lun_eh) {
+		sdebug_driver_template.sdev_setup_eh = scsi_device_setup_eh;
+		sdebug_driver_template.sdev_clear_eh = scsi_device_clear_eh;
+		sdebug_driver_template.sdev_eh_fallback = sdebug_lun_eh_fallback;
+	}
+	if (sdebug_target_eh) {
+		sdebug_driver_template.target_setup_eh = scsi_target_setup_eh;
+		sdebug_driver_template.target_clear_eh = scsi_target_clear_eh;
+		sdebug_driver_template.target_eh_fallback = sdebug_target_eh_fallback;
+	}
+
 	if (sdebug_ndelay >= 1000 * 1000 * 1000) {
 		pr_warn("ndelay must be less than 1 second, ignored\n");
 		sdebug_ndelay = 0;
@@ -9412,7 +9436,7 @@ static int sdebug_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	return 0;
 }
 
-static const struct scsi_host_template sdebug_driver_template = {
+static struct scsi_host_template sdebug_driver_template = {
 	.show_info =		scsi_debug_show_info,
 	.write_info =		scsi_debug_write_info,
 	.proc_name =		sdebug_proc_name,
-- 
2.33.0


