Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF37E1B9
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbfHAR5f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36996 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfHAR5e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so1804773pgp.4
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2B5lrA3zLcK3bpoJJzdqJNZu4X732tmsYAvxdfnLPU=;
        b=EC6XG9tmANGt7WgauHwerLpT6kZ7K3V8zf4sRzBPzIzFiVPuP6fxMhuABs7UVUyrKr
         h6Ttw+3hRIv9TieShJ+SQ78D0svWkUs/DNXBV/TH2PEUpstIT2XBQaMNxkgFnnocfXUx
         YmRdsFKeKfTEDWQN8fcyKOF3AczGKa34w8p7wAE/IF50SmXiStax0woYKp68O8cV7Fm+
         Qjx0ILiS2tjR0/5TUD1J8vmUYUEr5HE75acL4BTR9DZ2viZNjeVDmeBkchfc1lRtc39R
         mubw6WEAAM/4r9+qsUAYJokREKTWK3w3qo5t5SV6/Q/Bn9QrpSHOm5HPkqwvhefj6yFS
         RN+Q==
X-Gm-Message-State: APjAAAVjcKPDNguAH/rTUSEBMOQMzqnCVXxQrFHnTDy4lEOI6n1w9BUX
        /wVPiFk57KyHJKGtdRf29nM=
X-Google-Smtp-Source: APXvYqzHnTDeaZ0kpF4hkLsUHwitcftahXQyhnM8UPjZsie7RMztmodc0Vqg8ZxfToDJJxqTvzWouA==
X-Received: by 2002:a65:614a:: with SMTP id o10mr5336249pgv.407.1564682253988;
        Thu, 01 Aug 2019 10:57:33 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 53/59] qla2xxx: Remove superfluous sts_entry_* casts
Date:   Thu,  1 Aug 2019 10:56:08 -0700
Message-Id: <20190801175614.73655-54-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The C language supports implicit casting of void pointers to non-void
pointers. Remove explicit sts_entry_* casts that are not necessary.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 7533e420e571..5c65f2e67448 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1513,7 +1513,7 @@ qla2x00_ct_entry(scsi_qla_host_t *vha, struct req_que *req,
 		    if (comp_status == CS_DATA_UNDERRUN) {
 			    res = DID_OK << 16;
 			    bsg_reply->reply_payload_rcv_len =
-				le16_to_cpu(((sts_entry_t *)pkt)->rsp_info_len);
+				le16_to_cpu(pkt->rsp_info_len);
 
 			    ql_log(ql_log_warn, vha, 0x5048,
 				"CT pass-through-%s error comp_status=0x%x total_byte=0x%x.\n",
@@ -2256,11 +2256,8 @@ qla25xx_process_bidir_status_iocb(scsi_qla_host_t *vha, void *pkt,
 	struct bsg_job *bsg_job = NULL;
 	struct fc_bsg_request *bsg_request;
 	struct fc_bsg_reply *bsg_reply;
-	sts_entry_t *sts;
-	struct sts_entry_24xx *sts24;
-
-	sts = (sts_entry_t *) pkt;
-	sts24 = (struct sts_entry_24xx *) pkt;
+	sts_entry_t *sts = pkt;
+	struct sts_entry_24xx *sts24 = pkt;
 
 	/* Validate handle. */
 	if (index >= req->num_outstanding_cmds) {
@@ -2406,8 +2403,8 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 	srb_t		*sp;
 	fc_port_t	*fcport;
 	struct scsi_cmnd *cp;
-	sts_entry_t *sts;
-	struct sts_entry_24xx *sts24;
+	sts_entry_t *sts = pkt;
+	struct sts_entry_24xx *sts24 = pkt;
 	uint16_t	comp_status;
 	uint16_t	scsi_status;
 	uint16_t	ox_id;
@@ -2425,8 +2422,6 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 	uint16_t state_flags = 0;
 	uint16_t retry_delay = 0;
 
-	sts = (sts_entry_t *) pkt;
-	sts24 = (struct sts_entry_24xx *) pkt;
 	if (IS_FWI2_CAPABLE(ha)) {
 		comp_status = le16_to_cpu(sts24->comp_status);
 		scsi_status = le16_to_cpu(sts24->scsi_status) & SS_MASK;
-- 
2.22.0.770.g0f2c4a37fd-goog

