Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F147E1AA
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfHAR5S (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43227 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbfHAR5S (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id r22so7018461pgk.10
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PovcotU8DbX5bHo1fcUepWMJUFF4zr/eTWjoB68qYno=;
        b=VPg0dcQVLszMiARD4ZBSvTxaXhACU7zS47RZ5UQEVVg5TlLeoXNUtJypTPlQMwtic0
         w6WBNDuWC0isaSV9B+aw2xlr0I5XYMDcCHuY/VsyrUdqsep4XWaT3Lmijga0XDjTjcMn
         lEkkoWPnqxBvWjt7cWUFpJSuUwSNAuBA7NEYRAnRVqZ9q6X1WtVibqY6FOHfUGy9dUCc
         HjUiZu3v/+vZ4sxuO8CMzlFlKKqEiG9zMwnrKzeDA2cuKVqCMai3J8oqZDtbnb7pTkpO
         9u1hL1nOLI7LQa94vWDYRiRV1XtajCaA1yFK2EnhLkYXEJHqPFwOa4TdCAgVzVrM3XnA
         pagw==
X-Gm-Message-State: APjAAAWHWYv/XdYjsKAmxv3M2wGlFwmNk4KZWL34LgmvbttDVBhS19kq
        KYjhZ9rKNUuSUARq6PCp+1Y=
X-Google-Smtp-Source: APXvYqxiX9tJhCghZTcXaQMwZN6LwLwKhq4bZrO6Y7St7rzjWKEoaJvNG7Ph1y/8+Kl189Uli95IHQ==
X-Received: by 2002:a63:4522:: with SMTP id s34mr119340297pga.362.1564682237537;
        Thu, 01 Aug 2019 10:57:17 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 41/59] qla2xxx: Set the responder mode if appropriate for ELS pass-through IOCBs
Date:   Thu,  1 Aug 2019 10:55:56 -0700
Message-Id: <20190801175614.73655-42-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

According to the firmware documentation responder mode must be set for
ELS pass-through IOCBs if a response is expected.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index c7b91827c1e7..2da7c92e320b 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2700,9 +2700,9 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
 	els_iocb->s_id[0] = vha->d_id.b.al_pa;
 	els_iocb->s_id[1] = vha->d_id.b.area;
 	els_iocb->s_id[2] = vha->d_id.b.domain;
-	els_iocb->control_flags = 0;
 
 	if (elsio->u.els_logo.els_cmd == ELS_DCMD_PLOGI) {
+		els_iocb->control_flags = 0;
 		els_iocb->tx_byte_count = els_iocb->tx_len =
 			cpu_to_le32(sizeof(struct els_plogi_payload));
 		put_unaligned_le64(elsio->u.els_plogi.els_plogi_pyld_dma,
@@ -2718,6 +2718,7 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
 		ql_dump_buffer(ql_log_info, vha, 0x0109,
 		    (uint8_t *)els_iocb, 0x70);
 	} else {
+		els_iocb->control_flags = 1 << 13;
 		els_iocb->tx_byte_count =
 			cpu_to_le32(sizeof(struct els_logo_payload));
 		put_unaligned_le64(elsio->u.els_logo.els_logo_pyld_dma,
-- 
2.22.0.770.g0f2c4a37fd-goog

