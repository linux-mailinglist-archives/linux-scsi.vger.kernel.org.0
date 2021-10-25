Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AC5439C7A
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Oct 2021 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhJYRDi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Oct 2021 13:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234383AbhJYRC5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 25 Oct 2021 13:02:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6574F60F22;
        Mon, 25 Oct 2021 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635181235;
        bh=4mgiK3nFsNNXTltp0Boa25H/zAbuXwJIsrhUfwUkd7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCW1J6ZBop5YQmwvlwnVQeqxKcJE9baiW+us8wFci8rKAACxMZzygPAc4IsZAd4CU
         nSqdeUSAvGdRGrPdpTAbVuBc3di9U03Dl502gTCvbqkAZ9Mttquddpl1KRGsLTF3+y
         6wMetr/V6nBEQ9A0JJOZLZ51mnZkxWWbe4AQVbrLeS0RMNeNeBjuCORDEyTYZDr3/6
         b6Pk6iEQF+A7i5bStNWGZ58XavZ/diBCuCAmfyGymLzF5WO6G6iaKpFBTkLwTSN0n2
         dMo7ZKQ7AT5+Bwrti7YjtkYC1uCQLqygQ8+dqVyaKiHTPN0gaNLWetHrBSn4cBRuWa
         Fpq3YZQQtp9Yw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, njavali@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/13] scsi: qla2xxx: Fix unmap of already freed sgl
Date:   Mon, 25 Oct 2021 13:00:15 -0400
Message-Id: <20211025170023.1394358-6-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025170023.1394358-1-sashal@kernel.org>
References: <20211025170023.1394358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

[ Upstream commit 4a8f71014b4d56c4fb287607e844c0a9f68f46d9 ]

The sgl is freed in the target stack in target_release_cmd_kref() before
calling qlt_free_cmd() but there is an unmap of sgl in qlt_free_cmd() that
causes a panic if sgl is not yet DMA unmapped:

NIP dma_direct_unmap_sg+0xdc/0x180
LR  dma_direct_unmap_sg+0xc8/0x180
Call Trace:
 ql_dbg_prefix+0x68/0xc0 [qla2xxx] (unreliable)
 dma_unmap_sg_attrs+0x54/0xf0
 qlt_unmap_sg.part.19+0x54/0x1c0 [qla2xxx]
 qlt_free_cmd+0x124/0x1d0 [qla2xxx]
 tcm_qla2xxx_release_cmd+0x4c/0xa0 [tcm_qla2xxx]
 target_put_sess_cmd+0x198/0x370 [target_core_mod]
 transport_generic_free_cmd+0x6c/0x1b0 [target_core_mod]
 tcm_qla2xxx_complete_free+0x6c/0x90 [tcm_qla2xxx]

The sgl may be left unmapped in error cases of response sending.  For
instance, qlt_rdy_to_xfer() maps sgl and exits when session is being
deleted keeping the sgl mapped.

This patch removes use-after-free of the sgl and ensures that the sgl is
unmapped for any command that was not sent to firmware.

Link: https://lore.kernel.org/r/20211018122650.11846-1-d.bogdanov@yadro.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 8d4976725a75..ebed14bed783 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3256,8 +3256,7 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 			"RESET-RSP online/active/old-count/new-count = %d/%d/%d/%d.\n",
 			vha->flags.online, qla2x00_reset_active(vha),
 			cmd->reset_count, qpair->chip_reset);
-		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
-		return 0;
+		goto out_unmap_unlock;
 	}
 
 	/* Does F/W have an IOCBs for this request */
@@ -3380,10 +3379,6 @@ int qlt_rdy_to_xfer(struct qla_tgt_cmd *cmd)
 	prm.sg = NULL;
 	prm.req_cnt = 1;
 
-	/* Calculate number of entries and segments required */
-	if (qlt_pci_map_calc_cnt(&prm) != 0)
-		return -EAGAIN;
-
 	if (!qpair->fw_started || (cmd->reset_count != qpair->chip_reset) ||
 	    (cmd->sess && cmd->sess->deleted)) {
 		/*
@@ -3401,6 +3396,10 @@ int qlt_rdy_to_xfer(struct qla_tgt_cmd *cmd)
 		return 0;
 	}
 
+	/* Calculate number of entries and segments required */
+	if (qlt_pci_map_calc_cnt(&prm) != 0)
+		return -EAGAIN;
+
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 	/* Does F/W have an IOCBs for this request */
 	res = qlt_check_reserve_free_req(qpair, prm.req_cnt);
@@ -3805,9 +3804,6 @@ void qlt_free_cmd(struct qla_tgt_cmd *cmd)
 
 	BUG_ON(cmd->cmd_in_wq);
 
-	if (cmd->sg_mapped)
-		qlt_unmap_sg(cmd->vha, cmd);
-
 	if (!cmd->q_full)
 		qlt_decr_num_pend_cmds(cmd->vha);
 
-- 
2.33.0

