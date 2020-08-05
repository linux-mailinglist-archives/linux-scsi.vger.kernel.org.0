Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C590323D1CE
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Aug 2020 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgHEUGg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Aug 2020 16:06:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:53198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgHEUGa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 5 Aug 2020 16:06:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F402AC7C;
        Wed,  5 Aug 2020 20:06:44 +0000 (UTC)
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: qla2xxx: use MBX_TOV_SECONDS for mailbox command timeout values
Date:   Wed,  5 Aug 2020 17:05:46 -0300
Message-Id: <20200805200546.22497-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Improves readability of qla_mbx.c

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index df31ee0d59b2..b99eed55eb4a 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5190,7 +5190,7 @@ qla2x00_read_ram_word(scsi_qla_host_t *vha, uint32_t risc_addr, uint32_t *data)
 	mcp->mb[8] = MSW(risc_addr);
 	mcp->out_mb = MBX_8|MBX_1|MBX_0;
 	mcp->in_mb = MBX_3|MBX_2|MBX_0;
-	mcp->tov = 30;
+	mcp->tov = MBX_TOV_SECONDS;
 	mcp->flags = 0;
 	rval = qla2x00_mailbox_command(vha, mcp);
 	if (rval != QLA_SUCCESS) {
@@ -5378,7 +5378,7 @@ qla2x00_write_ram_word(scsi_qla_host_t *vha, uint32_t risc_addr, uint32_t data)
 	mcp->mb[8] = MSW(risc_addr);
 	mcp->out_mb = MBX_8|MBX_3|MBX_2|MBX_1|MBX_0;
 	mcp->in_mb = MBX_1|MBX_0;
-	mcp->tov = 30;
+	mcp->tov = MBX_TOV_SECONDS;
 	mcp->flags = 0;
 	rval = qla2x00_mailbox_command(vha, mcp);
 	if (rval != QLA_SUCCESS) {
@@ -5650,7 +5650,7 @@ qla24xx_set_fcp_prio(scsi_qla_host_t *vha, uint16_t loop_id, uint16_t priority,
 	mcp->mb[9] = vha->vp_idx;
 	mcp->out_mb = MBX_9|MBX_4|MBX_3|MBX_2|MBX_1|MBX_0;
 	mcp->in_mb = MBX_4|MBX_3|MBX_1|MBX_0;
-	mcp->tov = 30;
+	mcp->tov = MBX_TOV_SECONDS;
 	mcp->flags = 0;
 	rval = qla2x00_mailbox_command(vha, mcp);
 	if (mb != NULL) {
@@ -5737,7 +5737,7 @@ qla82xx_mbx_intr_enable(scsi_qla_host_t *vha)
 
 	mcp->out_mb = MBX_1|MBX_0;
 	mcp->in_mb = MBX_0;
-	mcp->tov = 30;
+	mcp->tov = MBX_TOV_SECONDS;
 	mcp->flags = 0;
 
 	rval = qla2x00_mailbox_command(vha, mcp);
@@ -5772,7 +5772,7 @@ qla82xx_mbx_intr_disable(scsi_qla_host_t *vha)
 
 	mcp->out_mb = MBX_1|MBX_0;
 	mcp->in_mb = MBX_0;
-	mcp->tov = 30;
+	mcp->tov = MBX_TOV_SECONDS;
 	mcp->flags = 0;
 
 	rval = qla2x00_mailbox_command(vha, mcp);
@@ -5964,7 +5964,7 @@ qla81xx_set_led_config(scsi_qla_host_t *vha, uint16_t *led_cfg)
 	if (IS_QLA8031(ha))
 		mcp->out_mb |= MBX_6|MBX_5|MBX_4|MBX_3;
 	mcp->in_mb = MBX_0;
-	mcp->tov = 30;
+	mcp->tov = MBX_TOV_SECONDS;
 	mcp->flags = 0;
 
 	rval = qla2x00_mailbox_command(vha, mcp);
@@ -6000,7 +6000,7 @@ qla81xx_get_led_config(scsi_qla_host_t *vha, uint16_t *led_cfg)
 	mcp->in_mb = MBX_2|MBX_1|MBX_0;
 	if (IS_QLA8031(ha))
 		mcp->in_mb |= MBX_6|MBX_5|MBX_4|MBX_3;
-	mcp->tov = 30;
+	mcp->tov = MBX_TOV_SECONDS;
 	mcp->flags = 0;
 
 	rval = qla2x00_mailbox_command(vha, mcp);
-- 
2.28.0

