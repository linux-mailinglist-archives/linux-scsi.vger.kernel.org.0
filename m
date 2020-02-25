Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A816B9B1
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Feb 2020 07:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgBYGYS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Feb 2020 01:24:18 -0500
Received: from smtp.infotech.no ([82.134.31.41]:36159 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbgBYGYQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 Feb 2020 01:24:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 0B758204188;
        Tue, 25 Feb 2020 07:24:14 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RSfSWO4yldXr; Tue, 25 Feb 2020 07:24:12 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 456C7204259;
        Tue, 25 Feb 2020 07:24:11 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com, Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v4 12/14] scsi_debug: zone_nr_conv module parameter
Date:   Tue, 25 Feb 2020 01:23:49 -0500
Message-Id: <20200225062351.21267-13-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225062351.21267-1-dgilbert@interlog.com>
References: <20200225062351.21267-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Allow controlling the number of conventional zones of a zbc device with
the new zone_nr_conv module parameter. The default value is 1 and the
specified value must be less than the total number of zones of the
device. This parameter is ignored for device types other than 0x14
(zbc=2 case).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index c40ec259ff1b..16f6358403f9 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -155,6 +155,7 @@ static const char *sdebug_version_date = "20190125";
 /* Default parameters for ZBC drives */
 #define DEF_ZBC_ZONE_SIZE_MB	128
 #define DEF_ZBC_MAX_OPEN_ZONES	8
+#define DEF_ZBC_NR_CONV_ZONES	1
 
 #define SDEBUG_LUN_0_VAL 0
 
@@ -292,6 +293,7 @@ struct sdebug_dev_info {
 	sector_t zsize;
 	sector_t zsize_shift;
 	unsigned int nr_zones;
+	unsigned int nr_conv_zones;
 	unsigned int nr_imp_open;
 	unsigned int nr_exp_open;
 	unsigned int nr_closed;
@@ -800,6 +802,7 @@ static int dif_errors;
 static bool sdeb_zbc_in_use;		/* true when ptype=TYPE_ZBC [0x14] */
 static const int zbc_zone_size_mb;
 static int sdeb_zbc_max_open = DEF_ZBC_MAX_OPEN_ZONES;
+static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
 static struct sdebug_queue *sdebug_q_arr;  /* ptr to array of submit queues */
@@ -4699,6 +4702,13 @@ static int sdebug_device_create_zones(struct sdebug_dev_info *devip)
 	devip->zsize_shift = ilog2(devip->zsize);
 	devip->nr_zones = (capacity + devip->zsize - 1) >> devip->zsize_shift;
 
+	if (sdeb_zbc_nr_conv >= devip->nr_zones) {
+		pr_err("Number of conventional zones too large\n");
+		return -EINVAL;
+	}
+
+	devip->nr_conv_zones = sdeb_zbc_nr_conv;
+
 	/* sdeb_zbc_max_open can be 0, meaning "no limit" */
 	if (sdeb_zbc_max_open >= devip->nr_zones - 1)
 		devip->max_open = (devip->nr_zones - 1) / 2;
@@ -4715,7 +4725,7 @@ static int sdebug_device_create_zones(struct sdebug_dev_info *devip)
 
 		zsp->z_start = zstart;
 
-		if (i == 0) {
+		if (i < devip->nr_conv_zones) {
 			zsp->z_cond = ZBC_NOT_WRITE_POINTER;
 			zsp->z_wp = (sector_t)-1;
 		} else {
@@ -5453,6 +5463,7 @@ module_param_named(write_same_length, sdebug_write_same_length, int,
 		   S_IRUGO | S_IWUSR);
 module_param_named(zbc, sdeb_zbc_model_s, charp, S_IRUGO);
 module_param_named(zone_max_open, sdeb_zbc_max_open, int, S_IRUGO);
+module_param_named(zone_nr_conv, sdeb_zbc_nr_conv, int, S_IRUGO);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -5516,6 +5527,7 @@ MODULE_PARM_DESC(wp, "Write Protect (def=0)");
 MODULE_PARM_DESC(write_same_length, "Maximum blocks per WRITE SAME cmd (def=0xffff)");
 MODULE_PARM_DESC(zbc, "'none' [0]; 'aware' [1]; 'managed' [2] (def=0). Can have 'host_' prefix");
 MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones; [0] for no limit (def=auto)");
+MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones (def=1)");
 
 #define SDEBUG_INFO_LEN 256
 static char sdebug_info[SDEBUG_INFO_LEN];
-- 
2.25.1

