Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C644B813
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Nov 2021 23:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344077AbhKIWkL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Nov 2021 17:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345393AbhKIWiK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 9 Nov 2021 17:38:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A63261B07;
        Tue,  9 Nov 2021 22:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636496584;
        bh=Ih8lef4ya+QPtcqo86096rCXdlZrEfhQi94MHmziKR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lB4OR1KC4wmzXmD/3NNZCS+GRTn59FXs6Xekrp5II+Bn9GedpEAMQeQbU5w4Yd4H+
         kFM4RleTeab0CE4bq96bI2hMN7lTLFBQSyxdwc0sh+3UUAkmD6SHpLRcAtZKM3anNj
         sp2dX8nDugMhOCgDVXlMEnIGufDytx7CfvSwiD2IgCJU9QEvfHdVz/t11zByxlvdhT
         xbOvprRhbduQ3GXpqjqyGkGTmBc4HifyTK2zNKoq4VjUTr59FfVZLAa+wWfAN0TXLH
         QgvpKt4YLcyYLHuk6TvA3me5FDCUkqct7nv42OenJtcPA5e/s9QRW4dx3SGQAzlXE7
         XZJuvQEUpz+9g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, nab@linux-iscsi.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 26/30] scsi: target: Fix alua_tg_pt_gps_count tracking
Date:   Tue,  9 Nov 2021 17:22:20 -0500
Message-Id: <20211109222224.1235388-26-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109222224.1235388-1-sashal@kernel.org>
References: <20211109222224.1235388-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 1283c0d1a32bb924324481586b5d6e8e76f676ba ]

We can't free the tg_pt_gp in core_alua_set_tg_pt_gp_id() because it's
still accessed via configfs. Its release must go through the normal
configfs/refcount process.

The max alua_tg_pt_gps_count check should probably have been done in
core_alua_allocate_tg_pt_gp(), but with the current code userspace could
have created 0x0000ffff + 1 groups, but only set the id for 0x0000ffff.
Then it could have deleted a group with an ID set, and then set the ID for
that extra group and it would work ok.

It's unlikely, but just in case this patch continues to allow that type of
behavior, and just fixes the kfree() while in use bug.

Link: https://lore.kernel.org/r/20210930020422.92578-4-michael.christie@oracle.com
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_alua.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 385e4cf9cfa63..0fc3135d3e4f6 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -1702,7 +1702,6 @@ int core_alua_set_tg_pt_gp_id(
 		pr_err("Maximum ALUA alua_tg_pt_gps_count:"
 			" 0x0000ffff reached\n");
 		spin_unlock(&dev->t10_alua.tg_pt_gps_lock);
-		kmem_cache_free(t10_alua_tg_pt_gp_cache, tg_pt_gp);
 		return -ENOSPC;
 	}
 again:
-- 
2.33.0

