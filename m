Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417DC26EB13
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 04:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgIRCC6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 22:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgIRCC5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 22:02:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23BC422211;
        Fri, 18 Sep 2020 02:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600394576;
        bh=JFGEpZLpPHzMDKTeFQbeHcdCovvkCDJKqX0Y+ymn4TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ve+EdNPiwapXdWqcfJVEnoPcmfduI2i35D/Q6aPFFyoHkG55WCLAr7MdsyaTBCf6N
         sQ8llVkYeVeUJ2VJoWPdOl8XsU2vl0duK6cfsJ5QX7hTf9BWDv/wCyw57E6CRSlvGr
         Wi7H4Wrc1crMxp9cJpp4wJYyAx8wtHUGhaPWUu+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 088/330] scsi: qla2xxx: Fix stuck session in GNL
Date:   Thu, 17 Sep 2020 21:57:08 -0400
Message-Id: <20200918020110.2063155-88-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit e1217dc3edce62895595cf484af33b9e0379b7f3 ]

Fix race condition between GNL completion processing and GNL request. Late
submission of GNL request was not seen by the GNL completion thread. This
patch will re-submit the GNL request for late submission fcport.

Link: https://lore.kernel.org/r/20191217220617.28084-13-hmadhani@marvell.com
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c   | 15 +++++++++++++--
 drivers/scsi/qla2xxx/qla_target.c | 21 +++++++++++++++------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index ac4c47fc5f4c1..2f2e059f4575e 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1002,7 +1002,7 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 		set_bit(loop_id, vha->hw->loop_id_map);
 		wwn = wwn_to_u64(e->port_name);
 
-		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x20e8,
+		ql_dbg(ql_dbg_disc, vha, 0x20e8,
 		    "%s %8phC %02x:%02x:%02x CLS %x/%x lid %x \n",
 		    __func__, (void *)&wwn, e->port_id[2], e->port_id[1],
 		    e->port_id[0], e->current_login_state, e->last_login_state,
@@ -1061,6 +1061,16 @@ static void qla24xx_async_gnl_sp_done(srb_t *sp, int res)
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	vha->gnl.sent = 0;
+	if (!list_empty(&vha->gnl.fcports)) {
+		/* retrigger gnl */
+		list_for_each_entry_safe(fcport, tf, &vha->gnl.fcports,
+		    gnl_entry) {
+			list_del_init(&fcport->gnl_entry);
+			fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+			if (qla24xx_post_gnl_work(vha, fcport) == QLA_SUCCESS)
+				break;
+		}
+	}
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 
 	sp->free(sp);
@@ -1995,7 +2005,7 @@ qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 			qla24xx_post_prli_work(vha, ea->fcport);
 		} else {
 			ql_dbg(ql_dbg_disc, vha, 0x20ea,
-			    "%s %d %8phC LoopID 0x%x in use with %06x. post gnl\n",
+			    "%s %d %8phC LoopID 0x%x in use with %06x. post gpdb\n",
 			    __func__, __LINE__, ea->fcport->port_name,
 			    ea->fcport->loop_id, ea->fcport->d_id.b24);
 
@@ -2066,6 +2076,7 @@ qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 			set_bit(lid, vha->hw->loop_id_map);
 			ea->fcport->loop_id = lid;
 			ea->fcport->keep_nport_handle = 0;
+			ea->fcport->logout_on_delete = 1;
 			qlt_schedule_sess_for_deletion(ea->fcport);
 		}
 		break;
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index b75e6e4d58c06..a7acc266cec06 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -957,7 +957,7 @@ void qlt_free_session_done(struct work_struct *work)
 	struct qlt_plogi_ack_t *own =
 		sess->plogi_link[QLT_PLOGI_LINK_SAME_WWN];
 
-	ql_dbg(ql_dbg_tgt_mgt, vha, 0xf084,
+	ql_dbg(ql_dbg_disc, vha, 0xf084,
 		"%s: se_sess %p / sess %p from port %8phC loop_id %#04x"
 		" s_id %02x:%02x:%02x logout %d keep %d els_logo %d\n",
 		__func__, sess->se_sess, sess, sess->port_name, sess->loop_id,
@@ -1024,7 +1024,7 @@ void qlt_free_session_done(struct work_struct *work)
 
 		while (!READ_ONCE(sess->logout_completed)) {
 			if (!traced) {
-				ql_dbg(ql_dbg_tgt_mgt, vha, 0xf086,
+				ql_dbg(ql_dbg_disc, vha, 0xf086,
 					"%s: waiting for sess %p logout\n",
 					__func__, sess);
 				traced = true;
@@ -1045,6 +1045,10 @@ void qlt_free_session_done(struct work_struct *work)
 			(struct imm_ntfy_from_isp *)sess->iocb, SRB_NACK_LOGO);
 	}
 
+	spin_lock_irqsave(&vha->work_lock, flags);
+	sess->flags &= ~FCF_ASYNC_SENT;
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	if (sess->se_sess) {
 		sess->se_sess = NULL;
@@ -1108,7 +1112,7 @@ void qlt_free_session_done(struct work_struct *work)
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 	sess->free_pending = 0;
 
-	ql_dbg(ql_dbg_tgt_mgt, vha, 0xf001,
+	ql_dbg(ql_dbg_disc, vha, 0xf001,
 	    "Unregistration of sess %p %8phC finished fcp_cnt %d\n",
 		sess, sess->port_name, vha->fcport_count);
 
@@ -1151,6 +1155,11 @@ void qlt_unreg_sess(struct fc_port *sess)
 		return;
 	}
 	sess->free_pending = 1;
+	/*
+	 * Use FCF_ASYNC_SENT flag to block other cmds used in sess
+	 * management from being sent.
+	 */
+	sess->flags |= FCF_ASYNC_SENT;
 	spin_unlock_irqrestore(&sess->vha->work_lock, flags);
 
 	if (sess->se_sess)
@@ -4580,7 +4589,7 @@ qlt_find_sess_invalidate_other(scsi_qla_host_t *vha, uint64_t wwn,
 		/* find other sess with nport_id collision */
 		if (port_id.b24 == other_sess->d_id.b24) {
 			if (loop_id != other_sess->loop_id) {
-				ql_dbg(ql_dbg_tgt_tmr, vha, 0x1000c,
+				ql_dbg(ql_dbg_disc, vha, 0x1000c,
 				    "Invalidating sess %p loop_id %d wwn %llx.\n",
 				    other_sess, other_sess->loop_id, other_wwn);
 
@@ -4596,7 +4605,7 @@ qlt_find_sess_invalidate_other(scsi_qla_host_t *vha, uint64_t wwn,
 				 * Another wwn used to have our s_id/loop_id
 				 * kill the session, but don't free the loop_id
 				 */
-				ql_dbg(ql_dbg_tgt_tmr, vha, 0xf01b,
+				ql_dbg(ql_dbg_disc, vha, 0xf01b,
 				    "Invalidating sess %p loop_id %d wwn %llx.\n",
 				    other_sess, other_sess->loop_id, other_wwn);
 
@@ -4611,7 +4620,7 @@ qlt_find_sess_invalidate_other(scsi_qla_host_t *vha, uint64_t wwn,
 		/* find other sess with nport handle collision */
 		if ((loop_id == other_sess->loop_id) &&
 			(loop_id != FC_NO_LOOP_ID)) {
-			ql_dbg(ql_dbg_tgt_tmr, vha, 0x1000d,
+			ql_dbg(ql_dbg_disc, vha, 0x1000d,
 			       "Invalidating sess %p loop_id %d wwn %llx.\n",
 			       other_sess, other_sess->loop_id, other_wwn);
 
-- 
2.25.1

