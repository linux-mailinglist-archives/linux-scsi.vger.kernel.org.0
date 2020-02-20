Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91716680D
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2020 21:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgBTUJE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Feb 2020 15:09:04 -0500
Received: from smtp.infotech.no ([82.134.31.41]:47283 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbgBTUJD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Feb 2020 15:09:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id C2D1A204258;
        Thu, 20 Feb 2020 21:09:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dweRMY0EmT9M; Thu, 20 Feb 2020 21:08:58 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 219B4204155;
        Thu, 20 Feb 2020 21:08:55 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
Subject: [PATCH v3 11/15] scsi_debug: zbc parameter can be string
Date:   Thu, 20 Feb 2020 15:08:34 -0500
Message-Id: <20200220200838.15809-12-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220200838.15809-1-dgilbert@interlog.com>
References: <20200220200838.15809-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Change the zbc module parameter to:
    0: none (probably a convential disk)
    1: host_aware
    2: host_managed

These values are chosen to match 'enum blk_zoned_model' found in
include/linux/blkdev.h . One of the strings 'none', 'aware' or
'managed' can be given instead of a number. Those strings may
be prefixed by 'host_' or 'host-'.

At this time there is no ZBC "host-aware" implementation so that
string (or the value '1') has no effect.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 116 ++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1a3cca5f3ec6..ec8ab3c4380c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -39,6 +39,7 @@
 #include <linux/uuid.h>
 #include <linux/t10-pi.h>
 #include <linux/random.h>
+#include <linux/ctype.h>
 
 #include <net/checksum.h>
 
@@ -110,7 +111,9 @@ static const char *sdebug_version_date = "20190125";
 #define DEF_ATO 1
 #define DEF_CDB_LEN 10
 #define DEF_JDELAY   1		/* if > 0 unit is a jiffy */
+#define DEF_DEV_SIZE_PRE_INIT   0
 #define DEF_DEV_SIZE_MB   8
+#define DEF_ZBC_DEV_SIZE_MB   128
 #define DEF_DIF 0
 #define DEF_DIX 0
 #define DEF_DOUBLESTORE false
@@ -713,7 +716,7 @@ static int sdebug_add_host = DEF_NUM_HOST;
 static int sdebug_ato = DEF_ATO;
 static int sdebug_cdb_len = DEF_CDB_LEN;
 static int sdebug_jdelay = DEF_JDELAY;	/* if > 0 then unit is jiffies */
-static int sdebug_dev_size_mb = DEF_DEV_SIZE_MB;
+static int sdebug_dev_size_mb = DEF_DEV_SIZE_PRE_INIT;
 static int sdebug_dif = DEF_DIF;
 static int sdebug_dix = DEF_DIX;
 static int sdebug_dsense = DEF_D_SENSE;
@@ -741,6 +744,8 @@ static int sdebug_scsi_level = DEF_SCSI_LEVEL;
 static int sdebug_sector_size = DEF_SECTOR_SIZE;
 static int sdebug_virtual_gb = DEF_VIRTUAL_GB;
 static int sdebug_vpd_use_hostno = DEF_VPD_USE_HOSTNO;
+/* Following enum: 0: no zbc, def; 1: host aware; 2: host managed */
+static enum blk_zoned_model sdeb_zbc_model;
 static unsigned int sdebug_lbpu = DEF_LBPU;
 static unsigned int sdebug_lbpws = DEF_LBPWS;
 static unsigned int sdebug_lbpws10 = DEF_LBPWS10;
@@ -763,7 +768,7 @@ static bool have_dif_prot;
 static bool write_since_sync;
 static bool sdebug_statistics = DEF_STATISTICS;
 static bool sdebug_wp;
-static bool sdebug_zbc;
+static char *sdeb_zbc_model_s;
 
 static unsigned int sdebug_store_sectors;
 static sector_t sdebug_capacity;	/* in sectors */
@@ -5446,7 +5451,7 @@ module_param_named(vpd_use_hostno, sdebug_vpd_use_hostno, int,
 module_param_named(wp, sdebug_wp, bool, S_IRUGO | S_IWUSR);
 module_param_named(write_same_length, sdebug_write_same_length, int,
 		   S_IRUGO | S_IWUSR);
-module_param_named(zbc, sdebug_zbc, bool, S_IRUGO | S_IWUSR);
+module_param_named(zbc, sdeb_zbc_model_s, charp, S_IRUGO | S_IWUSR);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -5508,7 +5513,7 @@ MODULE_PARM_DESC(virtual_gb, "virtual gigabyte (GiB) size (def=0 -> use dev_size
 MODULE_PARM_DESC(vpd_use_hostno, "0 -> dev ids ignore hostno (def=1 -> unique dev ids)");
 MODULE_PARM_DESC(wp, "Write Protect (def=0)");
 MODULE_PARM_DESC(write_same_length, "Maximum blocks per WRITE SAME cmd (def=0xffff)");
-MODULE_PARM_DESC(zbc, "Emulate ZBC device(s) (def=false) [same action as ptype=0x14]");
+MODULE_PARM_DESC(zbc, "'none' [0]; 'aware' [1]; 'managed' [2] (def=0). Can have 'host_' prefix");
 
 #define SDEBUG_INFO_LEN 256
 static char sdebug_info[SDEBUG_INFO_LEN];
@@ -5718,7 +5723,13 @@ static ssize_t ptype_store(struct device_driver *ddp, const char *buf,
 	if ((count > 0) && (1 == sscanf(buf, "%d", &n)) && (n >= 0)) {
 		prev_pdt = sdebug_ptype;
 		sdebug_ptype = n;
-		sdeb_zbc_in_use = (sdebug_ptype == TYPE_ZBC);
+		if (sdebug_ptype == TYPE_ZBC) {
+			sdeb_zbc_in_use = true;
+			sdeb_zbc_model = BLK_ZONED_HM;
+		} else if (prev_pdt == TYPE_ZBC) {
+			sdeb_zbc_in_use = false;
+			sdeb_zbc_model = BLK_ZONED_NONE;
+		}
 		return count;
 	}
 	return -EINVAL;
@@ -6230,38 +6241,63 @@ static ssize_t cdb_len_store(struct device_driver *ddp, const char *buf,
 }
 static DRIVER_ATTR_RW(cdb_len);
 
+static int sdeb_zbc_model_str(const char *cp)
+{
+	int res = -EINVAL;
+
+	if (isalpha(cp[0])) {
+		if (strstr(cp, "none"))
+			res = BLK_ZONED_NONE;
+		else if (strstr(cp, "aware"))
+			res = BLK_ZONED_HA;
+		else if (strstr(cp, "managed"))
+			res = BLK_ZONED_HM;
+	} else {
+		int n, ret;
+
+		ret = kstrtoint(cp, 0, &n);
+		if (ret)
+			return ret;
+		if (n >= 0 || n <= 2)
+			res = n;
+	}
+	return res;
+}
+
 static ssize_t zbc_show(struct device_driver *ddp, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", sdebug_ptype == TYPE_ZBC);
+	switch (sdeb_zbc_model) {
+	case BLK_ZONED_NONE:	/* 0 */
+		return scnprintf(buf, PAGE_SIZE, "none\n");
+	case BLK_ZONED_HA:	/* 1, not yet supported */
+		return scnprintf(buf, PAGE_SIZE, "host_aware\n");
+	case BLK_ZONED_HM:	/* 2 */
+		return scnprintf(buf, PAGE_SIZE, "host_managed\n");
+	default:
+		return scnprintf(buf, PAGE_SIZE, "unknown_zbc_model [0x%x]\n",
+				 (unsigned int)sdeb_zbc_model);
+	}
 }
 static ssize_t zbc_store(struct device_driver *ddp, const char *buf,
 			 size_t count)
 {
-	bool want_zbc;
-	int ret, n;
+	bool want_man_zbc;
+	int n;
 	int prev_pdt = sdebug_ptype;
 
-	ret = kstrtoint(buf, 0, &n);
-	if (ret)
-		return ret;
-	want_zbc = !!n;
-	if (prev_pdt == TYPE_ZBC || want_zbc) {
-		if (prev_pdt == TYPE_ZBC && want_zbc)
+	n = sdeb_zbc_model_str(buf);
+	if (n < 0)
+		return n;
+	sdeb_zbc_model = n;
+	want_man_zbc = (sdeb_zbc_model == BLK_ZONED_HM);
+	if (prev_pdt == TYPE_ZBC || want_man_zbc) {
+		if (prev_pdt == TYPE_ZBC && want_man_zbc)
 			return count;
-		sdeb_zbc_in_use = want_zbc;
-		if (sdeb_zbc_in_use) {
-			struct sdeb_zone_state *zsp = sdeb_zstate_a;
-
+		sdeb_zbc_in_use = want_man_zbc;
+		if (sdeb_zbc_in_use)
 			sdebug_ptype = TYPE_ZBC;
-			zbc_swrz_start = sdebug_capacity >> 1;
-			zsp->write_pointer = zbc_swrz_start;
-			zsp->z_cond = zc1_empty;
-			++zsp;
-			zsp->write_pointer = zbc_swrz_start;
-			zsp->z_cond = zc1_empty;
-		} else {
+		else
 			sdebug_ptype = DEF_PTYPE;	/* a disk ? ? */
-		}
 	}
 	return count;
 }
@@ -6398,7 +6434,30 @@ static int __init scsi_debug_init(void)
 	for (k = 0; k < submit_queues; ++k)
 		spin_lock_init(&sdebug_q_arr[k].qc_lock);
 
-	if (sdebug_dev_size_mb < 1)
+	/* check for host managed zoned block device [ptype=0x14] */
+	if (sdebug_ptype == TYPE_ZBC) {
+		sdeb_zbc_in_use = true;
+		sdeb_zbc_model = BLK_ZONED_HM;
+		if (sdebug_dev_size_mb == DEF_DEV_SIZE_PRE_INIT)
+			sdebug_dev_size_mb = DEF_ZBC_DEV_SIZE_MB;
+	}
+	if (sdeb_zbc_model_s && *sdeb_zbc_model_s) { /* e.g. 'zbc=managed' */
+		k = sdeb_zbc_model_str(sdeb_zbc_model_s);
+		if (k < 0) {
+			ret = k;
+			goto free_vm;
+		}
+		sdeb_zbc_model = k;
+		if (sdeb_zbc_model == BLK_ZONED_HM) {
+			sdeb_zbc_in_use = true;
+			sdebug_ptype = TYPE_ZBC;
+			if (sdebug_dev_size_mb == DEF_DEV_SIZE_PRE_INIT)
+				sdebug_dev_size_mb = DEF_ZBC_DEV_SIZE_MB;
+		}
+	}
+	if (sdebug_dev_size_mb == DEF_DEV_SIZE_PRE_INIT)
+		sdebug_dev_size_mb = DEF_DEV_SIZE_MB;
+	if (sdebug_dev_size_mb < 1)	/* could be negative */
 		sdebug_dev_size_mb = 1;  /* force minimum 1 MB ramdisk */
 	sz = (unsigned long)sdebug_dev_size_mb * 1048576;
 	sdebug_store_sectors = sz / sdebug_sector_size;
@@ -6497,9 +6556,6 @@ static int __init scsi_debug_init(void)
 		if (sdebug_num_parts)
 			map_region(0, 2);
 	}
-	/* check for host managed zoned block device [ptype=0x14] */
-	if (sdebug_ptype == TYPE_ZBC)
-		sdeb_zbc_in_use = true;
 
 	pseudo_primary = root_device_register("pseudo_0");
 	if (IS_ERR(pseudo_primary)) {
-- 
2.25.0

