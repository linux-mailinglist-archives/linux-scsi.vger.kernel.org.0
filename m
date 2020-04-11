Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE391A54AB
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Apr 2020 01:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgDKXG1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 11 Apr 2020 19:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbgDKXG1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 11 Apr 2020 19:06:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99CEA2166E;
        Sat, 11 Apr 2020 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646387;
        bh=l0fFTNJtxod3pYGpCsxpnMquGUX0NKnpAKROwSU37T4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4SDCmHAFnwmmrZyuPlSu8nfAX4iah91eF/s2gwJte3dZrkLfiMTJp1a2NKzIi2g6
         AsjufiXhRfgkXbBP0KR9D76zPnSlVxMR5ZdjF5rNrrlEtTYEpxwec/WPRwFFqyppK9
         LMhW6L52WKHbKvlNYPeUKmy1AlB1o2QgbB21hODI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 127/149] scsi: qla2xxx: Fix control flags for login/logout IOCB
Date:   Sat, 11 Apr 2020 19:03:24 -0400
Message-Id: <20200411230347.22371-127-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Himanshu Madhani <hmadhani@marvell.com>

[ Upstream commit 419ae5fe73e50084fa794934fb62fab34f564b7c ]

This patch fixes control flag options for login/logout IOCB.

Link: https://lore.kernel.org/r/20200212214436.25532-23-hmadhani@marvell.com
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 47bf60a9490a0..86881d68af19b 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2362,6 +2362,8 @@ qla24xx_login_iocb(srb_t *sp, struct logio_entry_24xx *logio)
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 
 	logio->entry_type = LOGINOUT_PORT_IOCB_TYPE;
+	logio->control_flags = cpu_to_le16(LCF_COMMAND_PLOGI);
+
 	if (lio->u.logio.flags & SRB_LOGIN_PRLI_ONLY) {
 		logio->control_flags = cpu_to_le16(LCF_COMMAND_PRLI);
 	} else {
@@ -2939,7 +2941,6 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	sp->fcport = fcport;
 
 	elsio->timeout = qla2x00_els_dcmd2_iocb_timeout;
-	init_completion(&elsio->u.els_plogi.comp);
 	if (wait)
 		sp->flags = SRB_WAKEUP_ON_COMP;
 
@@ -2949,7 +2950,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	elsio->u.els_plogi.tx_size = elsio->u.els_plogi.rx_size = DMA_POOL_SIZE;
 
 	ptr = elsio->u.els_plogi.els_plogi_pyld =
-	    dma_alloc_coherent(&ha->pdev->dev, DMA_POOL_SIZE,
+	    dma_alloc_coherent(&ha->pdev->dev, elsio->u.els_plogi.tx_size,
 		&elsio->u.els_plogi.els_plogi_pyld_dma, GFP_KERNEL);
 
 	if (!elsio->u.els_plogi.els_plogi_pyld) {
@@ -2958,7 +2959,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	}
 
 	resp_ptr = elsio->u.els_plogi.els_resp_pyld =
-	    dma_alloc_coherent(&ha->pdev->dev, DMA_POOL_SIZE,
+	    dma_alloc_coherent(&ha->pdev->dev, elsio->u.els_plogi.rx_size,
 		&elsio->u.els_plogi.els_resp_pyld_dma, GFP_KERNEL);
 
 	if (!elsio->u.els_plogi.els_resp_pyld) {
@@ -2982,6 +2983,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	    (uint8_t *)elsio->u.els_plogi.els_plogi_pyld,
 	    sizeof(*elsio->u.els_plogi.els_plogi_pyld));
 
+	init_completion(&elsio->u.els_plogi.comp);
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
 		rval = QLA_FUNCTION_FAILED;
-- 
2.20.1

