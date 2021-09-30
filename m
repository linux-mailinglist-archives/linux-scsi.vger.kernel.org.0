Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5297441CF03
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Sep 2021 00:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347200AbhI2WJz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Sep 2021 18:09:55 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:44832 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbhI2WJu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 Sep 2021 18:09:50 -0400
Received: by mail-pl1-f179.google.com with SMTP id t11so2516008plq.11
        for <linux-scsi@vger.kernel.org>; Wed, 29 Sep 2021 15:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3kwkp9RPpQX5SuOt71gSstEbEO312gWBI1qgz1y1kw=;
        b=jwfX4PuOkQAFCtlf7AolgpbMjSKTiS6aCI/zWwJNKeswMGkMCwh3JZHE/7fre+JrZy
         v+ZBKpTweqOEp30MvS3+TbQytiUBDJnxYTfQc/9o13lAAMjlhDR/vgrmmx7VhdwWjHCQ
         d3V0kqF5f8cZilq9+lv6NY/a9ycQ03vLT9Fjte9ziOCwydzwkxNFgKwsQXPjQ9nxtRkR
         vzGocD+dxGl8HS5x1SJXLR+GGfCdtZ2uJ1HM3hgMSlAndxd02ZXNYKjRcyvprn1Aa6TT
         Coj9YDQHch5zXwau/8zP8bxef7uZkQ+4+hd1wZVZl5dYLOqb4IS9ZTsmiBRVR8QVTt2/
         hSvw==
X-Gm-Message-State: AOAM533NuEftCCCbGqrxv1+9p78n4mU+rVo13L/GR7GfsqNFCsVh3Qqu
        dB61s0lx2J0myhe0gk6kNYc=
X-Google-Smtp-Source: ABdhPJwLc/peX5TS5wGamFKB2MWaKktqKahZRVSzbJemRQ14qM/relAFzhnUQLWku+JDiQOLRXiTuQ==
X-Received: by 2002:a17:902:b08f:b0:13e:67df:9fa9 with SMTP id p15-20020a170902b08f00b0013e67df9fa9mr888215plr.85.1632953288496;
        Wed, 29 Sep 2021 15:08:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5c11:c4f:db56:119])
        by smtp.gmail.com with ESMTPSA id gk14sm2785585pjb.35.2021.09.29.15.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:08:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 71/84] stex: Call scsi_done() directly
Date:   Wed, 29 Sep 2021 15:05:47 -0700
Message-Id: <20210929220600.3509089-72-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929220600.3509089-1-bvanassche@acm.org>
References: <20210929220600.3509089-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Conditional statements are faster than indirect calls. Hence call
scsi_done() directly.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/stex.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index f1ba7f5b52a8..2f96a2fdaa40 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -574,7 +574,7 @@ static void return_abnormal_state(struct st_hba *hba, int status)
 		if (ccb->cmd) {
 			scsi_dma_unmap(ccb->cmd);
 			ccb->cmd->result = status << 16;
-			ccb->cmd->scsi_done(ccb->cmd);
+			scsi_done(ccb->cmd);
 			ccb->cmd = NULL;
 		}
 	}
@@ -688,8 +688,6 @@ stex_queuecommand_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 		break;
 	}
 
-	cmd->scsi_done = done;
-
 	tag = scsi_cmd_to_rq(cmd)->tag;
 
 	if (unlikely(tag >= host->can_queue))
@@ -764,7 +762,7 @@ static void stex_scsi_done(struct st_ccb *ccb)
 	}
 
 	cmd->result = result;
-	cmd->scsi_done(cmd);
+	scsi_done(cmd);
 }
 
 static void stex_copy_data(struct st_ccb *ccb,
