Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54C2E61D
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfE2U2t (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35876 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE2U2t (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id u22so2375380pfm.3
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMZiGdZsrMSNVn0F0GPSCrFK0pjBSTmmoY4lx6CF80Y=;
        b=gWI8vkOYloaAMQR6DalxV640EFj7pBEIsMEW5336EimocGO81ae5A9hDlcBt2tRE7/
         hzrzjGaR1YATpWMxRYrZKJrOBhlOsm4oEulh2xCIDB7jbObjrhY9WPCOZ1ra4U1IrpZk
         bYFID7upbWBzvuawB+Q64IWh8/2QWuikaFhlHqxl8EXMJdng6us/WmRiJRUbIp9cCkNw
         qkfsUaKujrAU25yVzkhycqA8doTfJtHXrSp9iuqL273xQSEw7WgmLnwSztGQvqk7SNaL
         QcaMOimCJFC/BiQqyVT8HMQl/F1f8cRwRblBNYq5kd6B8oozcieNEiZCPRj6diknXfbA
         ortg==
X-Gm-Message-State: APjAAAXkwY/NrQav3O+GkoYQEGDHQgdnmSaLbxxCGxuqSDx9rr4Tdvkj
        nJP7Ge8/LU2kkRZx/UZT12o=
X-Google-Smtp-Source: APXvYqxUZxhWTU1Fl8pK6TWIe8xp31+NkxPAuQBPFpGkrYegEsrE02s3SJH4dYxycqlwto0Bo39kSw==
X-Received: by 2002:a17:90a:6fc5:: with SMTP id e63mr5712346pjk.29.1559161728511;
        Wed, 29 May 2019 13:28:48 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 09/20] qla2xxx: Change data_dsd into an array
Date:   Wed, 29 May 2019 13:28:15 -0700
Message-Id: <20190529202826.204499-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch avoids that Coverity complains about using a scalar as an array.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h    | 4 ++--
 drivers/scsi/qla2xxx/qla_iocb.c   | 4 ++--
 drivers/scsi/qla2xxx/qla_target.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 1a4095c56eee..46a260038c30 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -1848,7 +1848,7 @@ struct crc_context {
 			uint16_t	reserved_2;
 			uint16_t	reserved_3;
 			uint32_t	reserved_4;
-			struct dsd64	data_dsd;
+			struct dsd64	data_dsd[1];
 			uint32_t	reserved_5[2];
 			uint32_t	reserved_6;
 		} nobundling;
@@ -1858,7 +1858,7 @@ struct crc_context {
 			uint16_t	reserved_1;
 			__le16	dseg_count;	/* Data segment count */
 			uint32_t	reserved_2;
-			struct dsd64	data_dsd;
+			struct dsd64	data_dsd[1];
 			struct dsd64	dif_dsd;
 		} bundling;
 	} u;
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 9312b19ed708..b6161dfc7527 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -1515,7 +1515,7 @@ qla24xx_build_scsi_crc_2_iocbs(srb_t *sp, struct cmd_type_crc_2 *cmd_pkt,
 	}
 
 	if (!bundling) {
-		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd;
+		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd[0];
 	} else {
 		/*
 		 * Configure Bundling if we need to fetch interlaving
@@ -1525,7 +1525,7 @@ qla24xx_build_scsi_crc_2_iocbs(srb_t *sp, struct cmd_type_crc_2 *cmd_pkt,
 		crc_ctx_pkt->u.bundling.dif_byte_count = cpu_to_le32(dif_bytes);
 		crc_ctx_pkt->u.bundling.dseg_count = cpu_to_le16(tot_dsds -
 							tot_prot_dsds);
-		cur_dsd = &crc_ctx_pkt->u.bundling.data_dsd;
+		cur_dsd = &crc_ctx_pkt->u.bundling.data_dsd[0];
 	}
 
 	/* Finish the common fields of CRC pkt */
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index d3457cea61e3..c3a371d84595 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3173,7 +3173,7 @@ qlt_build_ctio_crc2_pkt(struct qla_qpair *qpair, struct qla_tgt_prm *prm)
 	pkt->crc_context_len = CRC_CONTEXT_LEN_FW;
 
 	if (!bundling) {
-		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd;
+		cur_dsd = &crc_ctx_pkt->u.nobundling.data_dsd[0];
 	} else {
 		/*
 		 * Configure Bundling if we need to fetch interlaving
@@ -3183,7 +3183,7 @@ qlt_build_ctio_crc2_pkt(struct qla_qpair *qpair, struct qla_tgt_prm *prm)
 		crc_ctx_pkt->u.bundling.dif_byte_count = cpu_to_le32(dif_bytes);
 		crc_ctx_pkt->u.bundling.dseg_count =
 			cpu_to_le16(prm->tot_dsds - prm->prot_seg_cnt);
-		cur_dsd = &crc_ctx_pkt->u.bundling.data_dsd;
+		cur_dsd = &crc_ctx_pkt->u.bundling.data_dsd[0];
 	}
 
 	/* Finish the common fields of CRC pkt */
-- 
2.22.0.rc1

