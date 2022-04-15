Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F442502FAD
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Apr 2022 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351663AbiDOUUk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Apr 2022 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351651AbiDOUUe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Apr 2022 16:20:34 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8FCDE900
        for <linux-scsi@vger.kernel.org>; Fri, 15 Apr 2022 13:18:05 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so12543692pjn.3
        for <linux-scsi@vger.kernel.org>; Fri, 15 Apr 2022 13:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bd/S00o1uxB2jL0fDuscxZ+oiIj73g4QzHcVwE7Ykww=;
        b=evIf2oiID31DcxzKJDZxT+RVQsdVwYRZ39EKzM9VarXL24mm53TM8mtAkUkkMhYcas
         GhEqJ+I2danrt4vCcZZnPeMwCPBxh/azR1e9UM0ZiIGpDTia5gv9TRVkkXVox6fau4KE
         vZnNBtTjIUajhvJwOchQsMGt3BO09rCeyiZEUwxHth4lpDn6ccMMxryJ0pwixu/4ZDp+
         cA7JyIWrRT725B1sLCztJ+guieTrubRrIGzzGp4UOtSSn3JXBZOY/H19WuhRLg7DkvZx
         MnD9PWj4s/V/fBuFFOf/czY7e9/1eDzo7lt++GsypuyT5L1xhjEhuQ2r/Bh3XVQLOdC+
         pw7g==
X-Gm-Message-State: AOAM533DYRG06Z7RaUtunhzQwOt7zbVHXe7e/tNktXWX19+WahdTnJYk
        3w2NgPx6m2msbusP1CiONos=
X-Google-Smtp-Source: ABdhPJwNLOg8GkVRFURNcvmHC8C2TWiEk3rzYkEQkXSurprmZpq1zPmZ8YscHqRXTMab0P487ZiyBw==
X-Received: by 2002:a17:90b:1b10:b0:1d1:3f5e:d071 with SMTP id nu16-20020a17090b1b1000b001d13f5ed071mr594295pjb.22.1650053884650;
        Fri, 15 Apr 2022 13:18:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a014:c21c:c3f8:d62])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004fe1a045e97sm3641141pfj.118.2022.04.15.13.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:18:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Shaun Tancheff <shaun.tancheff@seagate.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 2/8] scsi: sd_zbc: Rename a local variable
Date:   Fri, 15 Apr 2022 13:17:46 -0700
Message-Id: <20220415201752.2793700-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220415201752.2793700-1-bvanassche@acm.org>
References: <20220415201752.2793700-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For zoned storage the word 'capacity' can either refer to the device
capacity or to the zone capacity. Prevent confusion between these two
concepts by renaming 'capacity' into 'device_capacity'.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd_zbc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 925976ac5113..d0275855b16c 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -223,7 +223,8 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	sector_t capacity = logical_to_sectors(sdkp->device, sdkp->capacity);
+	sector_t device_capacity = logical_to_sectors(sdkp->device,
+						      sdkp->capacity);
 	unsigned int nr, i;
 	unsigned char *buf;
 	size_t offset, buflen = 0;
@@ -234,7 +235,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		/* Not a zoned device */
 		return -EOPNOTSUPP;
 
-	if (!capacity)
+	if (!device_capacity)
 		/* Device gone or invalid */
 		return -ENODEV;
 
@@ -242,7 +243,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	if (!buf)
 		return -ENOMEM;
 
-	while (zone_idx < nr_zones && sector < capacity) {
+	while (zone_idx < nr_zones && sector < device_capacity) {
 		ret = sd_zbc_do_report_zones(sdkp, buf, buflen,
 				sectors_to_logical(sdkp->device, sector), true);
 		if (ret)
