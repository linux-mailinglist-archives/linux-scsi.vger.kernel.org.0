Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8559E2B0ADF
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Nov 2020 18:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKLQ76 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Nov 2020 11:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgKLQ74 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 12 Nov 2020 11:59:56 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDDDB206FA;
        Thu, 12 Nov 2020 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605200395;
        bh=HV0mNVfZW2IHT8Fak9dlxfmN7InMpLamOL6lcK/5ibo=;
        h=From:To:Cc:Subject:Date:From;
        b=ClZjiwrcfyJ2KG60k7orzDXQLYua4CCZMWQFqt9WqQTw2pHVoDUBPB65LxSt8chaA
         cmFb+Wg16wGvMnTTwlnr8eb11QbeeL45xNhg6JlSQrtSs9jnsHwdjEncMPNUyvoxOF
         SeK+DJp8a2mNnXHSzsgUZHg0osr8484fi5/tmRFY=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     Leo Liou <leoliou@google.com>
Subject: [PATCH] scsi: ufs: show lba and length for unmap commands
Date:   Thu, 12 Nov 2020 08:59:50 -0800
Message-Id: <20201112165950.518952-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Leo Liou <leoliou@google.com>

We have lba and length for unmap commands.

Signed-off-by: Leo Liou <leoliou@google.com>
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

