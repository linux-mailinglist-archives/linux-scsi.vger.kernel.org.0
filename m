Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8B7E5CA
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 00:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfHAWiq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 18:38:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45930 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389786AbfHAWi0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 18:38:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so32833734plr.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 15:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdI3e5GaK9pYEbtX509YFy7N5zid+B8W5ttf/by311I=;
        b=giQdteZX9AR3L4pCo/5711pGJGcWUhHDEtse3vmL+Q1E1+cqv3IQUkxjvE6d/hGMAw
         2JD3goE0RGnrbLFwa2pa1Top+HsG2wxZ/bAhEO7+X9g9ed+RIF+e7MIeUQJpxbTWeA1L
         zAtBidarkcoJFN5FsguhOurgjh99uu7wk1EUoSWylhsZGPjolLxIU5m/AhYiys2Bur/F
         5cRl2q98d3P7ZbYEnvCSYelLbZI9iwsbETqg/nxuwYXN4wu/BnFwuXuMX3xnGrJpHA2n
         +FnYYTCMDBeyLoNj9F2mlJBjQnbtY/9nkI2jw7vyqhHlA6z0A1oHpuCHcCRpGct3Vqww
         AyMg==
X-Gm-Message-State: APjAAAW7CWafWsOfWhXAL25DOD0s4xkhWKmi+PzRzlfkhxcYOROwsV1C
        acpw6Y3Z3p6qI5kWEsdSZrk=
X-Google-Smtp-Source: APXvYqxbIvzAQnEpm2Vu8SmWp9cvTf/eJm/OtughedLANulcWV/kSI5xnudV2R2No+YWTw6fU8ISow==
X-Received: by 2002:a17:902:4643:: with SMTP id o61mr99780585pld.101.1564699105634;
        Thu, 01 Aug 2019 15:38:25 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b26sm82344632pfo.129.2019.08.01.15.38.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:38:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 2/3] Complain if scsi_target_block() fails
Date:   Thu,  1 Aug 2019 15:38:13 -0700
Message-Id: <20190801223814.140729-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801223814.140729-1-bvanassche@acm.org>
References: <20190801223814.140729-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If scsi_target_block() fails that can break the code that calls this
function. Hence complain loudly if scsi_target_block() fails.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7a4ac7a8e907..d47d637e6be2 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2772,7 +2772,12 @@ static int scsi_internal_device_unblock(struct scsi_device *sdev,
 static void
 device_block(struct scsi_device *sdev, void *data)
 {
-	scsi_internal_device_block(sdev);
+	int ret;
+
+	ret = scsi_internal_device_block(sdev);
+
+	WARN_ONCE(ret, "scsi_internal_device_block(%s) failed: ret = %d\n",
+		  dev_name(&sdev->sdev_gendev), ret);
 }
 
 static int
-- 
2.22.0.770.g0f2c4a37fd-goog

