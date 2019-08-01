Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C227E1A8
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbfHAR5P (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:15 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:46347 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbfHAR5P (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:15 -0400
Received: by mail-pg1-f172.google.com with SMTP id k189so15573933pgk.13
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpV3tGlhBshNNcPB9L1G2zdw+asPZW6ui3AMbEMf1ak=;
        b=RIEyZpuwGzWvkmh6D3P0WL7RiJPtWBzdc2B2rtwZggE+Rn8VgG6o6FcTxM33ESlrSU
         HzX/VpJhukWFuE0+g44kLCWn5U5Y31DQuG6rwD8p8qPjQv5nFHzocoZfbA+rlaef829J
         683aaMxBXW5EfQaIuUEj77UGJTELDNpznDV7WXQmP5/Y80Afv5efxOz6g/5zNpYTlKgw
         DbbMp+DpdN+GCcuNbmj1FgrTzkqZtrXR2bHCOfRoCVbgtFyT7LA4mKv5uqk+pJKUuUy5
         5Fw6SUenE6n5WnfxkumSAwMSTOqRWL5Rnsi15EGKvYB7zvJcgapAIytwFCc+ke2oUIVM
         kCgQ==
X-Gm-Message-State: APjAAAXmxabcSAeR4QyKcYcqJVls1FBZGSg5vhoiRYhGhJIhA3qBpRHd
        Zftk7wK3D7G/aktidBj98U7qBS/S
X-Google-Smtp-Source: APXvYqxUInQJ78LzjBqhVaUkxcr5HAcWlGsRBSAdcagv6jzx2avnTxofVika4zDFiDs+HLs2dVwU9g==
X-Received: by 2002:aa7:8102:: with SMTP id b2mr13690903pfi.105.1564682234657;
        Thu, 01 Aug 2019 10:57:14 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 39/59] qla2xxx: Check secondary image if reading the primary image fails
Date:   Thu,  1 Aug 2019 10:55:54 -0700
Message-Id: <20190801175614.73655-40-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes several Coverity complaints about reading data that
has not been initialized.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 5258d2486e25..a6a66b5d36a3 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -7562,8 +7562,12 @@ qla27xx_get_active_image(struct scsi_qla_host *vha,
 		goto check_sec_image;
 	}
 
-	qla24xx_read_flash_data(vha, (void *)(&pri_image_status),
-	    ha->flt_region_img_status_pri, sizeof(pri_image_status) >> 2);
+	if (qla24xx_read_flash_data(vha, (void *)(&pri_image_status),
+	    ha->flt_region_img_status_pri, sizeof(pri_image_status) >> 2) !=
+	    QLA_SUCCESS) {
+		WARN_ON_ONCE(true);
+		goto check_sec_image;
+	}
 	qla27xx_print_image(vha, "Primary image", &pri_image_status);
 
 	if (qla27xx_check_image_status_signature(&pri_image_status)) {
-- 
2.22.0.770.g0f2c4a37fd-goog

