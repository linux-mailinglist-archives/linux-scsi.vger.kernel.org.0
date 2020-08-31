Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC53257E87
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Aug 2020 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHaQTW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Aug 2020 12:19:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:45866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgHaQTV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 31 Aug 2020 12:19:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86E31AEA8;
        Mon, 31 Aug 2020 16:19:19 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Martin Wilck <mwilck@suse.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 4/4] qla2xxx: Handle incorrect entry_type entries
Date:   Mon, 31 Aug 2020 18:18:54 +0200
Message-Id: <20200831161854.70879-5-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200831161854.70879-1-dwagner@suse.de>
References: <20200831161854.70879-1-dwagner@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

It was observed on an ISP8324 16Gb HBA with fw=8.08.203 (d0d5) that
pkt->entry_type was MBX_IOCB_TYPE/0x39 with an sp->type SRB_SCSI_CMD
which is invalid and should not be possible.

A careful code review of the crash dump didn't reveal any short
comings. Reading the entry_type from the crash dump shows the expected
value of STATUS_TYPE/0x03 but the call trace shows that
qla24xx_mbx_iocb_entry() is used.

One possible explanation is when pkt->entry_type is read it doesn't
contain the correct information. That means the driver observes an data
race by the firmware.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/qla2xxx/qla_isr.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index b787643f5031..22aa4c0b901d 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3392,6 +3392,33 @@ void qla24xx_nvme_ls4_iocb(struct scsi_qla_host *vha,
 	sp->done(sp, comp_status);
 }
 
+static void qla24xx_process_mbx_iocb_response(struct scsi_qla_host *vha,
+	struct rsp_que *rsp, struct sts_entry_24xx *pkt)
+{
+	srb_t *sp;
+
+	sp = qla2x00_get_sp_from_handle(vha, rsp->req, pkt);
+	if (!sp)
+		return;
+
+	if (sp->type == SRB_SCSI_CMD ||
+	    sp->type == SRB_NVME_CMD ||
+	    sp->type == SRB_TM_CMD) {
+		/* Some firmware version don't update the entry_type
+		 * correctly.  It was observed entry_type contained
+		 * MBCX_IOCB_TYPE instead of the expected STATUS_TYPE
+		 * for sp->type SRB_SCSI_CMD, SRB_NVME_CMD or
+		 * SRB_TM_CMD.
+		 */
+		ql_log(ql_log_warn, vha, 0x509d,
+		       "Firmware didn't update entry_type correctly\n");
+		qla2x00_status_entry(vha, rsp, pkt);
+		return;
+	}
+
+	qla24xx_mbx_iocb_entry(vha, rsp->req, (struct mbx_24xx_entry *)pkt);
+}
+
 /**
  * qla24xx_process_response_queue() - Process response queue entries.
  * @vha: SCSI driver HA context
@@ -3499,8 +3526,7 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 			    (struct abort_entry_24xx *)pkt);
 			break;
 		case MBX_IOCB_TYPE:
-			qla24xx_mbx_iocb_entry(vha, rsp->req,
-			    (struct mbx_24xx_entry *)pkt);
+			qla24xx_process_mbx_iocb_response(vha, rsp, pkt);
 			break;
 		case VP_CTRL_IOCB_TYPE:
 			qla_ctrlvp_completed(vha, rsp->req,
-- 
2.16.4

