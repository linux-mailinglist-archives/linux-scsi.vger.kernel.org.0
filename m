Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94216680E
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2020 21:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgBTUJE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Feb 2020 15:09:04 -0500
Received: from smtp.infotech.no ([82.134.31.41]:47291 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbgBTUJD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Feb 2020 15:09:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 07AA420425A;
        Thu, 20 Feb 2020 21:09:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T6fWFfvlD3Pz; Thu, 20 Feb 2020 21:09:00 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 630B320424C;
        Thu, 20 Feb 2020 21:08:57 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com, Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 12/15] scsi_debug: zone_max_open module parameter
Date:   Thu, 20 Feb 2020 15:08:35 -0500
Message-Id: <20200220200838.15809-13-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220200838.15809-1-dgilbert@interlog.com>
References: <20200220200838.15809-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Add the zone_max_open module parameters to control the maximum number
of open zones of a ZBC device. This parameter is ignored for device
types other than 0x14 (zbc=2 case).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index ec8ab3c4380c..d4022eafe834 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -799,7 +799,7 @@ static int dif_errors;
 /* ZBC global data */
 static bool sdeb_zbc_in_use;		/* true when ptype=TYPE_ZBC [0x14] */
 static const int zbc_zone_size_mb;
-static const int zbc_max_open_zones = DEF_ZBC_MAX_OPEN_ZONES;
+static int sdeb_zbc_max_open = DEF_ZBC_MAX_OPEN_ZONES;
 
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
 static struct sdebug_queue *sdebug_q_arr;  /* ptr to array of submit queues */
@@ -4699,11 +4699,11 @@ static int sdebug_device_create_zones(struct sdebug_dev_info *devip)
 	devip->zsize_shift = ilog2(devip->zsize);
 	devip->nr_zones = (capacity + devip->zsize - 1) >> devip->zsize_shift;
 
-	/* zbc_max_open_zones can be 0, meaning "no limit" */
-	if (zbc_max_open_zones >= devip->nr_zones - 1)
+	/* sdeb_zbc_max_open can be 0, meaning "no limit" */
+	if (sdeb_zbc_max_open >= devip->nr_zones - 1)
 		devip->max_open = (devip->nr_zones - 1) / 2;
 	else
-		devip->max_open = zbc_max_open_zones;
+		devip->max_open = sdeb_zbc_max_open;
 
 	devip->zstate = kcalloc(sizeof(struct sdeb_zone_state),
 				devip->nr_zones, GFP_KERNEL);
@@ -5452,6 +5452,7 @@ module_param_named(wp, sdebug_wp, bool, S_IRUGO | S_IWUSR);
 module_param_named(write_same_length, sdebug_write_same_length, int,
 		   S_IRUGO | S_IWUSR);
 module_param_named(zbc, sdeb_zbc_model_s, charp, S_IRUGO | S_IWUSR);
+module_param_named(zone_max_open, sdeb_zbc_max_open, int, S_IRUGO);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -5514,6 +5515,7 @@ MODULE_PARM_DESC(vpd_use_hostno, "0 -> dev ids ignore hostno (def=1 -> unique de
 MODULE_PARM_DESC(wp, "Write Protect (def=0)");
 MODULE_PARM_DESC(write_same_length, "Maximum blocks per WRITE SAME cmd (def=0xffff)");
 MODULE_PARM_DESC(zbc, "'none' [0]; 'aware' [1]; 'managed' [2] (def=0). Can have 'host_' prefix");
+MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones; [0] for no limit (def=auto)");
 
 #define SDEBUG_INFO_LEN 256
 static char sdebug_info[SDEBUG_INFO_LEN];
-- 
2.25.0

