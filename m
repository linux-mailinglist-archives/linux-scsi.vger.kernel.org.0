Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE02B6AEA
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Nov 2020 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKQQ6w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Nov 2020 11:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgKQQ6v (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Nov 2020 11:58:51 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6685124654;
        Tue, 17 Nov 2020 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605632330;
        bh=Ujm6AOGcwTqpbSeByjOuwLbjf2DAK+DlSnBSYGaADds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxi6YlBi/yuswURA/U8Re7vuouH5xfI1JHa43cCOeeDyTxZKWwElXsQ6OodOxf3XB
         o2p1QoPkoYqymaVIdRFcPF9ocovSe/Qo2jzlkqvFmVgOxmgRwOpM3/bVJzYAQpaXyc
         6Q+bsh83zSOSTgAXfnB6S3YnGeW/bt2q6B06/YBA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, Leo Liou <leoliou@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v5 7/7] scsi: ufs: show lba and length for unmap commands
Date:   Tue, 17 Nov 2020 08:58:39 -0800
Message-Id: <20201117165839.1643377-8-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117165839.1643377-1-jaegeuk@kernel.org>
References: <20201117165839.1643377-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Leo Liou <leoliou@google.com>

We have lba and length for unmap commands.

Signed-off-by: Leo Liou <leoliou@google.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 86c8dee01ca9..dba3ee307307 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -376,6 +376,11 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba,
 				lrbp->ucd_req_ptr->sc.exp_data_transfer_len);
 			if (opcode == WRITE_10)
 				group_id = lrbp->cmd->cmnd[6];
+		} else if (opcode == UNMAP) {
+			if (cmd->request) {
+				lba = scsi_get_lba(cmd);
+				transfer_len = blk_rq_bytes(cmd->request);
+			}
 		}
 	}
 
-- 
2.29.2.299.gdc1121823c-goog

