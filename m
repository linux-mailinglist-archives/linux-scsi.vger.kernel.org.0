Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FED67E183
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbfHAR40 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45621 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4Z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so32561203plr.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGpQh7s/OTyN+tS40sCjD5AYt6tQBje7LHq3xgSml/E=;
        b=ao2TeBAkQxV7F0B6wYDfK0Kakz4cdUodpqUY0xNwEAM8ntXTv1HJaKXGv2q8onlunV
         zmE2aF4o1auBtOw3T6xQmLVLJpax9m742p3fhk9hnkF17KTyHAaAdbmxX0/4GH07t4qw
         7nuhVe+5UOsTgkFnGu/5JH4wMcgfa6YXoSrZdYfVZTLA1WK3hCY44b64hNvKR3O3WirO
         tW2u06DyZYYCeKF8DtxNRW+jyYNtfDN1q4152fIyb4tNI/FJJ2W3YVXuC1wPgWBnfSbL
         1Z6kr//e1CsDQ7rdWWZHO5gmO4UNVeMie1t6jTNZYMts1cIq95u9UbisMxKLyNVDyX+F
         vKzA==
X-Gm-Message-State: APjAAAWEg8fADudX75tsNKFPY03sSY5z1zChjYvGO3nWc10FW1ZH3O5k
        Lpzccq3n4pLjtupDsU5uHvc=
X-Google-Smtp-Source: APXvYqzQDfghxv6dZZ0BFUKI34PK4sWzK0SGqiljq1FTtgheR91A9GiV+/dIYlH+15UG2RFo15vZ+A==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr129480843pla.5.1564682185070;
        Thu, 01 Aug 2019 10:56:25 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 02/59] qla2xxx: Really fix qla2xxx_eh_abort()
Date:   Thu,  1 Aug 2019 10:55:17 -0700
Message-Id: <20190801175614.73655-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

I'm not sure how this happened but the patch that was intended to fix
abort handling was incomplete. This patch fixes that patch as follows:
- If aborting the SCSI command failed, wait until the SCSI command
  completes.
- Return SUCCESS instead of FAILED if an abort attempt races with SCSI
  command completion.
- Since qla2xxx_eh_abort() increments the sp reference count by calling
  sp_get(), decrement the sp reference count before returning.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Fixes: 219d27d7147e ("scsi: qla2xxx: Fix race conditions in the code for aborting SCSI commands")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index b667f13b62df..a0ab47082238 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1269,6 +1269,7 @@ static int
 qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 {
 	scsi_qla_host_t *vha = shost_priv(cmd->device->host);
+	DECLARE_COMPLETION_ONSTACK(comp);
 	srb_t *sp;
 	int ret;
 	unsigned int id;
@@ -1307,6 +1308,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 		return SUCCESS;
 	}
 
+	/* Get a reference to the sp and drop the lock. */
 	if (sp_get(sp)){
 		/* ref_count is already 0 */
 		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
@@ -1321,6 +1323,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	    "Aborting from RISC nexus=%ld:%d:%llu sp=%p cmd=%p handle=%x\n",
 	    vha->host_no, id, lun, sp, cmd, sp->handle);
 
+	ret = SUCCESS;
 	rval = ha->isp_ops->abort_command(sp);
 	ql_dbg(ql_dbg_taskm, vha, 0x8003,
 	       "Abort command mbx cmd=%p, rval=%x.\n", cmd, rval);
@@ -1332,17 +1335,27 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 		 * won't report a completion.
 		 */
 		sp->done(sp, DID_ABORT << 16);
-		ret = SUCCESS;
 		break;
-	default:
-		/*
-		 * Either abort failed or abort and completion raced. Let
-		 * the SCSI core retry the abort in the former case.
-		 */
-		ret = FAILED;
+	case QLA_FUNCTION_PARAMETER_ERROR:
+	default: {
+		/* Wait for the command completion. */
+		uint32_t ratov = ha->r_a_tov/10;
+		uint32_t ratov_j = msecs_to_jiffies(4 * ratov * 1000);
+
+		sp->comp = &comp;
+		if (!wait_for_completion_timeout(&comp, ratov_j)) {
+			ql_dbg(ql_dbg_taskm, vha, 0xffff,
+			    "%s: Abort wait timer (4 * R_A_TOV[%d]) expired\n",
+			    __func__, ha->r_a_tov);
+			ret = FAILED;
+			break;
+		}
 		break;
 	}
+	}
 
+	sp->comp = NULL;
+	atomic_dec(&sp->ref_count);
 	ql_log(ql_log_info, vha, 0x801c,
 	    "Abort command issued nexus=%ld:%d:%llu -- %x.\n",
 	    vha->host_no, id, lun, ret);
-- 
2.22.0.770.g0f2c4a37fd-goog

