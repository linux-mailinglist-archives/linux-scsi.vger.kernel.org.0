Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4745B127D6F
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfLTOeO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Dec 2019 09:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfLTOac (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10A42469A;
        Fri, 20 Dec 2019 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852232;
        bh=jLRbyEh3v+4dIORUjQ5y/dUimDiqgJ1vGemZ8HWNewg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRx6It6s3WZkQZEhaBwUZkdonslYA/z/5WgiIi3arGlHTyWDl36wZwuEyNWcLl9OK
         Q2YaTqHTP944KQFWN+gwP/bfLkk1bbRFvpuPc6XSYAjMjl73SvTyaKkEL6wyd4XUCf
         M2VD27tdu0SJOnKBSW7trWbomg9I6+0wH3Zj1nWs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roman Bolshakov <r.bolshakov@yadro.com>,
        Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 27/52] scsi: qla2xxx: Fix PLOGI payload and ELS IOCB dump length
Date:   Fri, 20 Dec 2019 09:29:29 -0500
Message-Id: <20191220142954.9500-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Roman Bolshakov <r.bolshakov@yadro.com>

[ Upstream commit 0334cdea1fba36fad8bdf9516f267ce01de625f7 ]

The size of the buffer is hardcoded as 0x70 or 112 bytes, while the size of
ELS IOCB is 0x40 and the size of PLOGI payload returned by Get Parameters
command is 0x74.

Cc: Quinn Tran <qutran@marvell.com>
Link: https://lore.kernel.org/r/20191125165702.1013-9-r.bolshakov@yadro.com
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 44dc97cebb06b..bdf1994251b9b 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2684,7 +2684,8 @@ qla24xx_els_logo_iocb(srb_t *sp, struct els_entry_24xx *els_iocb)
 		ql_dbg(ql_dbg_io + ql_dbg_buffer, vha, 0x3073,
 		    "PLOGI ELS IOCB:\n");
 		ql_dump_buffer(ql_log_info, vha, 0x0109,
-		    (uint8_t *)els_iocb, 0x70);
+		    (uint8_t *)els_iocb,
+		    sizeof(*els_iocb));
 	} else {
 		els_iocb->control_flags = 1 << 13;
 		els_iocb->tx_byte_count =
@@ -2850,7 +2851,8 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	ql_dbg(ql_dbg_disc + ql_dbg_buffer, vha, 0x3073, "PLOGI buffer:\n");
 	ql_dump_buffer(ql_dbg_disc + ql_dbg_buffer, vha, 0x0109,
-	    (uint8_t *)elsio->u.els_plogi.els_plogi_pyld, 0x70);
+	    (uint8_t *)elsio->u.els_plogi.els_plogi_pyld,
+	    sizeof(*elsio->u.els_plogi.els_plogi_pyld));
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-- 
2.20.1

