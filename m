Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE8101EE
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Apr 2019 23:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfD3Vja (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Apr 2019 17:39:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33072 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfD3Vj3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Apr 2019 17:39:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so2407448pfk.0
        for <linux-scsi@vger.kernel.org>; Tue, 30 Apr 2019 14:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfAcBuXThS+7jaQPLbyImV91LIDg9kl8z4j/a/RqlS0=;
        b=lhdrMAfVK1ejB1I2P0zpGrDqja1AsI2BBp4S9SyVsmj8d+mjXUeglc3k/T080LQpff
         F5DBzrhDzkBgAO290mtMQVY4tjtPv5CoSD8ahDsB8dgNLOgJ3hGMysjxblWuZcO/xh29
         07GFWDIud3n1/G8zA9aNvL+n8Ba10a+Ks/qGpVUS6aAUKbTtbglBqFBVmmjTBWCDMsIv
         tz4KU8R8X1PyQWL4kiTfW5ZXsap7BleUcrNA40GuMOmVE3lgBCdOikaMYDnEDPCDAoDP
         l/67N7YLjIppw+qDHLtE3N6jZTi9hvxXEizT0T6ZEIL8kRtPh+OMq32GewolmwTgI/uj
         49sg==
X-Gm-Message-State: APjAAAVTvoRERrAKKgKTT3XC+C4vtqe4xrxk30pBB29ifIncW+KxO1R0
        tOLLeNGx3yI2MVVha6Sk8M4=
X-Google-Smtp-Source: APXvYqzOmb4VfW5bp//y4pEg5izP76qppmRiaMNcH5A35rkESTJNV2DstcPPBzIn0ZmOpAMegO0sng==
X-Received: by 2002:aa7:8a92:: with SMTP id a18mr74725479pfc.218.1556660369072;
        Tue, 30 Apr 2019 14:39:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h4sm39379820pgv.61.2019.04.30.14.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 14:39:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>,
        Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <lduncan@suse.com>, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 2/2] sd: Inline sd_probe_part2()
Date:   Tue, 30 Apr 2019 14:39:19 -0700
Message-Id: <20190430213919.97437-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190430213919.97437-1-bvanassche@acm.org>
References: <20190430213919.97437-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make sd_probe() easier to read by inlining sd_probe_part2(). This
patch does not change any functionality.

Cc: Lee Duncan <lduncan@suse.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd.c | 101 ++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 58 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ae6634885afe..ab79c50539eb 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3285,63 +3285,6 @@ static int sd_format_disk_name(char *prefix, int index, char *buf, int buflen)
 	return 0;
 }
 
-static void sd_probe_part2(struct scsi_disk *sdkp)
-{
-	struct scsi_device *sdp;
-	struct gendisk *gd;
-	u32 index;
-	struct device *dev;
-
-	sdp = sdkp->device;
-	gd = sdkp->disk;
-	index = sdkp->index;
-	dev = &sdp->sdev_gendev;
-
-	gd->major = sd_major((index & 0xf0) >> 4);
-	gd->first_minor = ((index & 0xf) << 4) | (index & 0xfff00);
-
-	gd->fops = &sd_fops;
-	gd->private_data = &sdkp->driver;
-	gd->queue = sdkp->device->request_queue;
-
-	/* defaults, until the device tells us otherwise */
-	sdp->sector_size = 512;
-	sdkp->capacity = 0;
-	sdkp->media_present = 1;
-	sdkp->write_prot = 0;
-	sdkp->cache_override = 0;
-	sdkp->WCE = 0;
-	sdkp->RCD = 0;
-	sdkp->ATO = 0;
-	sdkp->first_scan = 1;
-	sdkp->max_medium_access_timeouts = SD_MAX_MEDIUM_TIMEOUTS;
-
-	sd_revalidate_disk(gd);
-
-	gd->flags = GENHD_FL_EXT_DEVT;
-	if (sdp->removable) {
-		gd->flags |= GENHD_FL_REMOVABLE;
-		gd->events |= DISK_EVENT_MEDIA_CHANGE;
-	}
-
-	blk_pm_runtime_init(sdp->request_queue, dev);
-	device_add_disk(dev, gd, NULL);
-	if (sdkp->capacity)
-		sd_dif_config_host(sdkp);
-
-	sd_revalidate_disk(gd);
-
-	if (sdkp->security) {
-		sdkp->opal_dev = init_opal_dev(sdp, &sd_sec_submit);
-		if (sdkp->opal_dev)
-			sd_printk(KERN_NOTICE, sdkp, "supports TCG Opal\n");
-	}
-
-	sd_printk(KERN_NOTICE, sdkp, "Attached SCSI %sdisk\n",
-		  sdp->removable ? "removable " : "");
-	scsi_autopm_put_device(sdp);
-}
-
 /**
  *	sd_probe - called during driver initialization and whenever a
  *	new scsi device is attached to the system. It is called once
@@ -3431,7 +3374,49 @@ static int sd_probe(struct device *dev)
 	get_device(dev);
 	dev_set_drvdata(dev, sdkp);
 
-	sd_probe_part2(sdkp);
+	gd->major = sd_major((index & 0xf0) >> 4);
+	gd->first_minor = ((index & 0xf) << 4) | (index & 0xfff00);
+
+	gd->fops = &sd_fops;
+	gd->private_data = &sdkp->driver;
+	gd->queue = sdkp->device->request_queue;
+
+	/* defaults, until the device tells us otherwise */
+	sdp->sector_size = 512;
+	sdkp->capacity = 0;
+	sdkp->media_present = 1;
+	sdkp->write_prot = 0;
+	sdkp->cache_override = 0;
+	sdkp->WCE = 0;
+	sdkp->RCD = 0;
+	sdkp->ATO = 0;
+	sdkp->first_scan = 1;
+	sdkp->max_medium_access_timeouts = SD_MAX_MEDIUM_TIMEOUTS;
+
+	sd_revalidate_disk(gd);
+
+	gd->flags = GENHD_FL_EXT_DEVT;
+	if (sdp->removable) {
+		gd->flags |= GENHD_FL_REMOVABLE;
+		gd->events |= DISK_EVENT_MEDIA_CHANGE;
+	}
+
+	blk_pm_runtime_init(sdp->request_queue, dev);
+	device_add_disk(dev, gd, NULL);
+	if (sdkp->capacity)
+		sd_dif_config_host(sdkp);
+
+	sd_revalidate_disk(gd);
+
+	if (sdkp->security) {
+		sdkp->opal_dev = init_opal_dev(sdp, &sd_sec_submit);
+		if (sdkp->opal_dev)
+			sd_printk(KERN_NOTICE, sdkp, "supports TCG Opal\n");
+	}
+
+	sd_printk(KERN_NOTICE, sdkp, "Attached SCSI %sdisk\n",
+		  sdp->removable ? "removable " : "");
+	scsi_autopm_put_device(sdp);
 
 	return 0;
 
-- 
2.21.0.196.g041f5ea1cf98

