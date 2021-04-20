Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED52B364F30
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 02:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhDTAKc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 20:10:32 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42604 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhDTAKX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 20:10:23 -0400
Received: by mail-pf1-f180.google.com with SMTP id w8so20842542pfn.9
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 17:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCh6KRaGXaunJ5pzRXGp3DSpjoA5wdd+6Er39dLk7AU=;
        b=Jozww6RNfzrVbsJcpz7Sot5+hMsdeRpJfcYCRtBjkxmhRvc+Lu1dmadHwl+3NEWsbF
         ywM0IMXKHqcm9fzmbLdBFT4RWtAJSh9UgTPbvCgJHbegpRcy44VPStxkcpqFxpUkSVOU
         5cB4T/JwHQekZDJa4Y1eDZpF3sCBYR54HnaPv9YjyAd7G2xnjATLubaUwGXT/JbqOvAL
         Sf1kgwRAaPb4m54wb2AnMAFgQKB8CXWvr8LquhCeYP/0mayhKN9XfPN6tGEq62UMuliO
         tgtnHV+9U+IKqPLbxmmA+C72zKWculqhxv/8gsNP/i9EXeJQf9TmI3BjgcDCXZWDdySg
         Pgmw==
X-Gm-Message-State: AOAM5314ospRkjZxfzXfO5XYoJgdVpixHNmtEPzUhZTMtQowug3+FpFG
        0GDXXF3vDfSYsIcFCWsezLc=
X-Google-Smtp-Source: ABdhPJw4JbjoPJbBUydGJUlobpxMQ7ZiG0qMXjYFYxQBwnaOmk6Y5km09XacwGrH2HSGeNTzk7NCAA==
X-Received: by 2002:a05:6a00:1aca:b029:25a:b810:94c7 with SMTP id f10-20020a056a001acab029025ab81094c7mr15506153pfv.15.1618877393254;
        Mon, 19 Apr 2021 17:09:53 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3e77:56a4:910b:42a9])
        by smtp.gmail.com with ESMTPSA id 33sm14006787pgq.21.2021.04.19.17.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:09:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 053/117] ib_srp: Convert to the scsi_status union
Date:   Mon, 19 Apr 2021 17:07:41 -0700
Message-Id: <20210420000845.25873-54-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210420000845.25873-1-bvanassche@acm.org>
References: <20210420000845.25873-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

An explanation of the purpose of this patch is available in the patch
"scsi: Introduce the scsi_status union".

Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 27 ++++++++++++++-------------
 include/scsi/scsi_transport_srp.h   | 15 +++++++++++----
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 31f8aa2c40ed..4b85ab860abf 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1279,13 +1279,14 @@ static void srp_free_req(struct srp_rdma_ch *ch, struct srp_request *req,
 }
 
 static void srp_finish_req(struct srp_rdma_ch *ch, struct srp_request *req,
-			   struct scsi_device *sdev, int result)
+			   struct scsi_device *sdev,
+			   enum host_status host_status)
 {
 	struct scsi_cmnd *scmnd = srp_claim_req(ch, req, sdev, NULL);
 
 	if (scmnd) {
 		srp_free_req(ch, req, scmnd, 0);
-		scmnd->result = result;
+		scmnd->status = (union scsi_status){.b.host = host_status};
 		scmnd->scsi_done(scmnd);
 	}
 }
@@ -1302,8 +1303,7 @@ static void srp_terminate_io(struct srp_rport *rport)
 		for (j = 0; j < target->req_ring_size; ++j) {
 			struct srp_request *req = &ch->req_ring[j];
 
-			srp_finish_req(ch, req, NULL,
-				       DID_TRANSPORT_FAILFAST << 16);
+			srp_finish_req(ch, req, NULL, DID_TRANSPORT_FAILFAST);
 		}
 	}
 }
@@ -1366,7 +1366,7 @@ static int srp_rport_reconnect(struct srp_rport *rport)
 		for (j = 0; j < target->req_ring_size; ++j) {
 			struct srp_request *req = &ch->req_ring[j];
 
-			srp_finish_req(ch, req, NULL, DID_RESET << 16);
+			srp_finish_req(ch, req, NULL, DID_RESET);
 		}
 	}
 	for (i = 0; i < target->ch_count; i++) {
@@ -1980,7 +1980,7 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 
 			return;
 		}
-		scmnd->result = rsp->status;
+		scmnd->status = (union scsi_status){.b.status = rsp->status};
 
 		if (rsp->flags & SRP_RSP_FLAG_SNSVALID) {
 			memcpy(scmnd->sense_buffer, rsp->data +
@@ -2178,8 +2178,8 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 	u16 idx;
 	int len, ret;
 
-	scmnd->result = srp_chkready(target->rport);
-	if (unlikely(scmnd->result))
+	scmnd->status = srp_chkready(target->rport);
+	if (unlikely(scmnd->status.combined))
 		goto err;
 
 	WARN_ON_ONCE(scmnd->request->tag < 0);
@@ -2231,8 +2231,9 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 		 * max_pages_per_mr sg-list elements, tell the SCSI mid-layer
 		 * to reduce queue depth temporarily.
 		 */
-		scmnd->result = len == -ENOMEM ?
-			DID_OK << 16 | QUEUE_FULL << 1 : DID_ERROR << 16;
+		scmnd->status = len == -ENOMEM ?
+			(union scsi_status){.b.status = SAM_STAT_TASK_SET_FULL}:
+			(union scsi_status){.b.host = DID_ERROR};
 		goto err_iu;
 	}
 
@@ -2241,7 +2242,7 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 
 	if (srp_post_send(ch, iu, len)) {
 		shost_printk(KERN_ERR, target->scsi_host, PFX "Send failed\n");
-		scmnd->result = DID_ERROR << 16;
+		scmnd->status = (union scsi_status){.b.host = DID_ERROR};
 		goto err_unmap;
 	}
 
@@ -2260,7 +2261,7 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 	req->scmnd = NULL;
 
 err:
-	if (scmnd->result) {
+	if (scmnd->status.combined) {
 		scmnd->scsi_done(scmnd);
 		ret = 0;
 	} else {
@@ -2832,7 +2833,7 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 		ret = FAILED;
 	if (ret == SUCCESS) {
 		srp_free_req(ch, req, scmnd, 0);
-		scmnd->result = DID_ABORT << 16;
+		scmnd->status = (union scsi_status){.b.host = DID_ABORT };
 		scmnd->scsi_done(scmnd);
 	}
 
diff --git a/include/scsi/scsi_transport_srp.h b/include/scsi/scsi_transport_srp.h
index d22df12584f9..3528b2ac6204 100644
--- a/include/scsi/scsi_transport_srp.h
+++ b/include/scsi/scsi_transport_srp.h
@@ -5,6 +5,7 @@
 #include <linux/transport_class.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <scsi/scsi_status.h>
 
 #define SRP_RPORT_ROLE_INITIATOR 0
 #define SRP_RPORT_ROLE_TARGET 1
@@ -128,18 +129,24 @@ enum blk_eh_timer_return srp_timed_out(struct scsi_cmnd *scmd);
  * implementation. The role of this function is similar to that of
  * fc_remote_port_chkready().
  */
-static inline int srp_chkready(struct srp_rport *rport)
+static inline union scsi_status srp_chkready(struct srp_rport *rport)
 {
+	enum host_status status = 0;
+
 	switch (rport->state) {
 	case SRP_RPORT_RUNNING:
 	case SRP_RPORT_BLOCKED:
 	default:
-		return 0;
+		break;
 	case SRP_RPORT_FAIL_FAST:
-		return DID_TRANSPORT_FAILFAST << 16;
+		status = DID_TRANSPORT_FAILFAST;
+		break;
 	case SRP_RPORT_LOST:
-		return DID_NO_CONNECT << 16;
+		status = DID_NO_CONNECT;
+		break;
 	}
+
+	return (union scsi_status){.b.host = status};
 }
 
 #endif
