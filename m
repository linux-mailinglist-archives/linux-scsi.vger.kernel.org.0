Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4367E18D
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfHAR4j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35596 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so28319710pgr.2
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz0ZLNPnfgJ5eCThZEBeBFG8tLseY4mBsFyWC5oXz2w=;
        b=irstQjuYrb6H+9f53oERwBmNnHvoxMiqW3vP2vVDMvNvyX7e+wVVIig4QmhqcdwtFL
         ZjBl5MqTKYzcDJovsRtGIKkCinR851wYVmTk7VdJVn6+uIVxFvR91S+kU8kQr+TsJQy6
         n2JPw+oHGnWPFpkwurByVBbl8CmVdz6qwzLAW9wQS4loLTml6iOy2mhaV40exN38ldqS
         HcwpxSJP/GG4zTG4bBGYDqI4GiFd8eO41vrzashAu7NazOX0Ex+eG+u+DaFo/WMV893Q
         hY3DBRHVfr7R1JZhmxLtGa7XXE4xPwH3RNzdQDhtAmN6ZwQVG9iW+7qp/diEsHZ99QkP
         RN7g==
X-Gm-Message-State: APjAAAV0/aWsUiv0xViJJ6+64RmhR3t3KC9vdwyxaBKF0mXGWWZ6YrXH
        nO3elvIks9hL9I7uxChRW20=
X-Google-Smtp-Source: APXvYqw4aVOydLiKUNCTMNmaBNpeHiqEu+RQlFdmW97FwJ922DiA56xE672mj9sRzYfmqThMTd9iHw==
X-Received: by 2002:a17:90a:37e9:: with SMTP id v96mr57709pjb.10.1564682198390;
        Thu, 01 Aug 2019 10:56:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 12/59] qla2xxx: Change data_dsd into an array
Date:   Thu,  1 Aug 2019 10:55:27 -0700
Message-Id: <20190801175614.73655-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch does not change any functionality but fixes a Coverity
complaint about using a scalar as an array.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h    | 4 ++--
 drivers/scsi/qla2xxx/qla_iocb.c   | 4 ++--
 drivers/scsi/qla2xxx/qla_target.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index a94b0d440f0f..1c6811bd5625 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -1852,7 +1852,7 @@ struct crc_context {
 			uint16_t	reserved_2;
 			uint16_t	reserved_3;
 			uint32_t	reserved_4;
-			struct dsd64	data_dsd;
+			struct dsd64	data_dsd[1];
 			uint32_t	reserved_5[2];
 			uint32_t	reserved_6;
 		} nobundling;
@@ -1862,7 +1862,7 @@ struct crc_context {
 			uint16_t	reserved_1;
 			__le16	dseg_count;	/* Data segment count */
 			uint32_t	reserved_2;
-			struct dsd64	data_dsd;
+			struct dsd64	data_dsd[1];
 			struct dsd64	dif_dsd;
 		} bundling;
 	} u;
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index b514ab4d243e..6b120254f414 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -1516,7 +1516,7 @@ qla24xx_build_scsi_crc_2_iocbs(srb_t *sp, struct cmd_type_crc_2 *cmd_pkt,
 	}
 
 	if (!bundling) {
-		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd;
+		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd[0];
 	} else {
 		/*
 		 * Configure Bundling if we need to fetch interlaving
@@ -1526,7 +1526,7 @@ qla24xx_build_scsi_crc_2_iocbs(srb_t *sp, struct cmd_type_crc_2 *cmd_pkt,
 		crc_ctx_pkt->u.bundling.dif_byte_count = cpu_to_le32(dif_bytes);
 		crc_ctx_pkt->u.bundling.dseg_count = cpu_to_le16(tot_dsds -
 							tot_prot_dsds);
-		cur_dsd = &crc_ctx_pkt->u.bundling.data_dsd;
+		cur_dsd = &crc_ctx_pkt->u.bundling.data_dsd[0];
 	}
 
 	/* Finish the common fields of CRC pkt */
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 4c5f9c02c379..b8241d7b1f8a 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3163,7 +3163,7 @@ qlt_build_ctio_crc2_pkt(struct qla_qpair *qpair, struct qla_tgt_prm *prm)
 	pkt->crc_context_len = CRC_CONTEXT_LEN_FW;
 
 	if (!bundling) {
-		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd;
+		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd[0];
 	} else {
 		/*
 		 * Configure Bundling if we need to fetch interlaving
@@ -3173,7 +3173,7 @@ qlt_build_ctio_crc2_pkt(struct qla_qpair *qpair, struct qla_tgt_prm *prm)
 		crc_ctx_pkt->u.bundling.dif_byte_count = cpu_to_le32(dif_bytes);
 		crc_ctx_pkt->u.bundling.dseg_count =
 			cpu_to_le16(prm->tot_dsds - prm->prot_seg_cnt);
-		cur_dsd = &crc_ctx_pkt->u.bundling.data_dsd;
+		cur_dsd = &crc_ctx_pkt->u.bundling.data_dsd[0];
 	}
 
 	/* Finish the common fields of CRC pkt */
-- 
2.22.0.770.g0f2c4a37fd-goog

