Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE09249181
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFQUjA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 16:39:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37501 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUjA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 16:39:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id n65so1963382pga.4
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 13:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwVxZ9x8jLMCEUponWxTsNELuKUKbJInolbkD3bRoJA=;
        b=VbSohp88roxbkaYTMiYtHhojaUpGGFbwHXxlenSyCyPyfd7QsBKwXsyuX6IU/5D80r
         OeN3M8qITFIav583fSA0U2jO8RRssJIC9lMWAMrUZVUVRk11mZig7i4A8PtHVSRS9V9Q
         y35YcJ/hpVTXeQPYw2US9w85wVVtOCgJqVvdpfqfAUSm2Urx7KNbB/uXu1DULC6VZaOO
         XWzcFR2j0wIV1mHGPm/9gkv8LWLZZwAUEaV9872H6F11dNMcjIPOt4BAuzi03atR0Sen
         wXM15+mfRU7cPotkhlEoyzXPkGGoBGDCp6/Q3s5J/Lve17BnrEzFYxf6kRy6hraPs+Q4
         bRXQ==
X-Gm-Message-State: APjAAAUtaAyyAvq5BSgphkSTdA8pRZBqdHiKIy40lO5I/ThMRyZolcYM
        6EzAXsW0nujBTO8HoyBEM/o=
X-Google-Smtp-Source: APXvYqwMaV8v1syDHQCuLwVBvLUXB5iX4Vz/w4MR9SjxmBldMYvs6h3kG0yBboHs3M0cIqF1iIEgEQ==
X-Received: by 2002:a17:90a:9dc5:: with SMTP id x5mr876197pjv.110.1560803939072;
        Mon, 17 Jun 2019 13:38:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z20sm16835620pfk.72.2019.06.17.13.38.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:38:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 2/6] qla2xxx: Really fix qla2xxx_eh_abort()
Date:   Mon, 17 Jun 2019 13:38:43 -0700
Message-Id: <20190617203847.184407-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617203847.184407-1-bvanassche@acm.org>
References: <20190617203847.184407-1-bvanassche@acm.org>
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
index 1bdf634e7117..1ab472799938 100644
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
@@ -1304,6 +1305,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 		return SUCCESS;
 	}
 
+	/* Get a reference to the sp and drop the lock. */
 	if (sp_get(sp)){
 		/* ref_count is already 0 */
 		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
@@ -1318,6 +1320,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	    "Aborting from RISC nexus=%ld:%d:%llu sp=%p cmd=%p handle=%x\n",
 	    vha->host_no, id, lun, sp, cmd, sp->handle);
 
+	ret = SUCCESS;
 	rval = ha->isp_ops->abort_command(sp);
 	ql_dbg(ql_dbg_taskm, vha, 0x8003,
 	       "Abort command mbx cmd=%p, rval=%x.\n", cmd, rval);
@@ -1329,17 +1332,27 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
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
2.22.0.rc3

