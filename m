Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E37E1A9
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfHAR5R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40989 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbfHAR5Q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so32422655pls.8
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pp7OvrYC0nJ/EPdn5pDdQGfjoGl0YNVSGEvxTi+SKno=;
        b=NzYF/j1ByGPKW6R6XXRUKUusfsWT2++Sw3/8XYczxijipeV2RBIO1ItJdTi92KMpug
         iuB3K+TR2bFHK7633L3aDJbgaexlRwmcpytYRS/Ta1CSQNpqZxeSSAWfJltDhAVn3gMa
         jvIB+arvo8FcHU1GhxaibsBWTBcHED2gYAgopruzeXo2JY+ivEdf6d7Ft1XJ+ep5N8tp
         nciHluHb/VIpck/Fd2BYC7hQ13pqaJttwgIqPEiN9gDxG1X1xd/wpqU5UKEQ/yTXmvWJ
         u6KH8wKaFAb8EDM5v/Q1ot9mkcjW1P1DOMrm0U+V2N5Evwm+DzcN4XkSgDLbaVFYdshL
         +1oA==
X-Gm-Message-State: APjAAAW0T5Y+4dH2+acdZeVv8yNLNhpxvNczKOkM7ZESD9/UXGs6W7r9
        y007+XZlQO1r6bn3ylTcWMI=
X-Google-Smtp-Source: APXvYqwshBp9XmYctVr3QcWQwYDQvF6Oi2DbF2i8A+MaLFwfD0m39pHyobVjbSv0HDyGUvgRps/tVA==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr129446112plz.38.1564682235805;
        Thu, 01 Aug 2019 10:57:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 40/59] qla2xxx: Make it explicit that ELS pass-through IOCBs use little endian
Date:   Thu,  1 Aug 2019 10:55:55 -0700
Message-Id: <20190801175614.73655-41-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

According to the firmware documentation the firmware expects all ELS
pass-through IOCB parameters in little endian format. Make this explicit.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_fw.h   | 8 ++++----
 drivers/scsi/qla2xxx/qla_iocb.c | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index df079a8c2b33..732bb871c433 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -761,13 +761,13 @@ struct els_entry_24xx {
 #define ECF_CLR_PASSTHRU_PEND	BIT_12
 #define ECF_INCL_FRAME_HDR	BIT_11
 
-	uint32_t rx_byte_count;
-	uint32_t tx_byte_count;
+	__le32	 rx_byte_count;
+	__le32	 tx_byte_count;
 
 	__le64	 tx_address __packed;	/* Data segment 0 address. */
-	uint32_t tx_len;		/* Data segment 0 length. */
+	__le32	 tx_len;		/* Data segment 0 length. */
 	__le64	 rx_address __packed;	/* Data segment 1 address. */
-	uint32_t rx_len;		/* Data segment 1 length. */
+	__le32	 rx_len;		/* Data segment 1 length. */
 };
 
 struct els_sts_entry_24xx {
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 6b120254f414..c7b91827c1e7 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2704,12 +2704,12 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
 
 	if (elsio->u.els_logo.els_cmd == ELS_DCMD_PLOGI) {
 		els_iocb->tx_byte_count = els_iocb->tx_len =
-			sizeof(struct els_plogi_payload);
+			cpu_to_le32(sizeof(struct els_plogi_payload));
 		put_unaligned_le64(elsio->u.els_plogi.els_plogi_pyld_dma,
 				   &els_iocb->tx_address);
 		els_iocb->rx_dsd_count = 1;
 		els_iocb->rx_byte_count = els_iocb->rx_len =
-			sizeof(struct els_plogi_payload);
+			cpu_to_le32(sizeof(struct els_plogi_payload));
 		put_unaligned_le64(elsio->u.els_plogi.els_resp_pyld_dma,
 				   &els_iocb->rx_address);
 
@@ -2718,7 +2718,8 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
 		ql_dump_buffer(ql_log_info, vha, 0x0109,
 		    (uint8_t *)els_iocb, 0x70);
 	} else {
-		els_iocb->tx_byte_count = sizeof(struct els_logo_payload);
+		els_iocb->tx_byte_count =
+			cpu_to_le32(sizeof(struct els_logo_payload));
 		put_unaligned_le64(elsio->u.els_logo.els_logo_pyld_dma,
 				   &els_iocb->tx_address);
 		els_iocb->tx_len = cpu_to_le32(sizeof(struct els_logo_payload));
-- 
2.22.0.770.g0f2c4a37fd-goog

