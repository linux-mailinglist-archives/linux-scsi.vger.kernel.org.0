Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 592CDEA08
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfD2SWE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 14:22:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43125 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2SWE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 14:22:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so5448282plp.10
        for <linux-scsi@vger.kernel.org>; Mon, 29 Apr 2019 11:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIAzjRYURKS9BEE6C/jNgk3T6Gz91H/f1XBdRbfMNUo=;
        b=VYrCMhE7D3AHuafCknt2rnWLaVtQHa3BMrxjPzMHSWC2dI4RMNY7lO9h7s2RJTIegU
         tF+sTKAHi/8rHBNwqj6rNsuDAadjyQ3dB2HWh5ynQGcbBJRKck6LprZFv07cU6HQUBG7
         mglA35Nr8VNXxktE0FVDG7msI9/IZu8fDrOIIDLEWhsgTY8ulP5jXPnXgvMjRZ2tW7T8
         od9DBsHn+jXZV4T2tJi5PW4farfFDoiHKNFsWqN+wkJurr0SAQmJTxz75NDDclPxxY80
         Mnj3UYRXoFU8We3O4cS82vQ51TDm/qX/I7okRGbLeia5oxla/l041c4FHQS54yU9ghle
         CsWw==
X-Gm-Message-State: APjAAAV3S/yQ6sqNMmS06/XyVIG56MpoRaVTEcX7+F8rqsDKWIZh1tXL
        YzqiEYjCxY53okOPvMB0NfM=
X-Google-Smtp-Source: APXvYqy61YRh1YofUWfhIYs/+RdpH+4nEjb25MnEL4H7ggLd8GuQyOyt5bOn6iy4NFusSitLyuG7ww==
X-Received: by 2002:a17:902:d83:: with SMTP id 3mr65909324plv.125.1556562123657;
        Mon, 29 Apr 2019 11:22:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z22sm35657227pgv.23.2019.04.29.11.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 11:22:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] sd: Revert "Inline sd_probe_part2()"
Date:   Mon, 29 Apr 2019 11:21:52 -0700
Message-Id: <20190429182153.206292-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190429182153.206292-1-bvanassche@acm.org>
References: <20190429182153.206292-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reverts commit d16ece577bf2 to make a clean revert of its predecessor
possible.

Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd.c | 101 ++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index e610b393809b..f29c0ca8a5f1 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3285,6 +3285,63 @@ static int sd_format_disk_name(char *prefix, int index, char *buf, int buflen)
 	return 0;
 }
 
+static void sd_probe_part2(struct scsi_disk *sdkp)
+{
+	struct scsi_device *sdp;
+	struct gendisk *gd;
+	u32 index;
+	struct device *dev;
+
+	sdp = sdkp->device;
+	gd = sdkp->disk;
+	index = sdkp->index;
+	dev = &sdp->sdev_gendev;
+
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
+}
+
 /**
  *	sd_probe - called during driver initialization and whenever a
  *	new scsi device is attached to the system. It is called once
@@ -3374,49 +3431,7 @@ static int sd_probe(struct device *dev)
 	get_device(dev);
 	dev_set_drvdata(dev, sdkp);
 
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
+	sd_probe_part2(sdkp);
 
 	return 0;
 
-- 
2.21.0.196.g041f5ea1cf98

