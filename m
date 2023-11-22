Return-Path: <linux-scsi+bounces-62-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0623B7F4FCF
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Nov 2023 19:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371EC1C209E9
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Nov 2023 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF856B92
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Nov 2023 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="G4xwtv3a";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="s43TIAx2"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ED8191;
	Wed, 22 Nov 2023 09:25:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700673927; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BYBlEf7wyIk7+oXl2lHUQyvHBUSD8xBeio7lEreICVuJ9HSFeoKD5kEfiXEbV4yhu3
    sM31fj0W4dZA2Em4qnHj56d1/E7OAB/wF1qM8pfGdPrAadb3oGRStRkUhOkqQCNgWaQG
    HVHnLGPn/LFOrcVaRndZyfI48SMpdl0ycv0hqKL48Z6dJstIjwkcNUwUdKly2sgT2fSJ
    fneiCT6STYiU6oPtUeGKjW9cNM0iYD0nM4eSRjOgyseplvL6h3zXLBxAj9nXWpn2b5D9
    UHyEoLi8sIOwLMkZAp4TL7nQExHrOVS/+vq1gC6se/TIk71y2Tf9V4FXIj5tniKCb8YQ
    QXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1700673927;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j/Fpf9xbkhtgTtWXZAuLn992yVFCJnNNn3gf8aRTnEo=;
    b=VayH621UvEwywwpJEZ2R3w4pfFpFRU941OXaBuMFrXTQbBXW8Rvfdy7M4Z0Wlj3+Bm
    emGOUvumkfb2k36w0IUxidtf/JztTXABn7nKijBsLIexvAiAmodjOyCjrrdrZAAz+0LL
    EeI/nRCxF4wj7PVpa9GiFALe5xjq5Ge2bRArJb9JDnx+K/di9oQnVtvn8gF2AUYpG+5+
    pPO6qx6gLAbZhgJNrVAAwq7Ylbl40OmQiL+rTNvd35abGQ1AXPC4bDLYNlfavzs31Fh+
    nMaMX4THitAzSNVdEtBx9wM/JDLnK920mDH7FQRgysO8yeLGWCmIk+PYWCrWnN5npXcN
    JuvQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1700673927;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j/Fpf9xbkhtgTtWXZAuLn992yVFCJnNNn3gf8aRTnEo=;
    b=G4xwtv3aTHQ4LZS7w/eJT223GybOAvBTGpQwl4DvtwzUNl28s+znOwe3LbSeypJhYN
    kdAiemHBkSW6EbsTWSBihxkpb4WrytVfVB4UcshqLhifM0hipSyogDPTdwNLludOtuU1
    iObyu4Vr0j7TtshpZ8V3rpYvj2RgYbEcVz1P3YZYHgyd28Zzl9E4RHGoxGoE8SCJQngp
    Ei83iacHBGnog8M35BRNgL2eHCedfJ6lTv0zFrgI5X1JuujWs0qWTHQdjEXtzuaISqPR
    mTs7jia6aMO4gyGL39xQ0ZHXOESJmNvhWYjg+c9P3GjnjUg6lHKYZfRQJCsuPQgsxPO1
    YH7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1700673927;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j/Fpf9xbkhtgTtWXZAuLn992yVFCJnNNn3gf8aRTnEo=;
    b=s43TIAx2HDCkootfShOyYkyD9e0Z5VLM5OiaMJ5ZKJ4hUFuKJDM1BOdMAgemgOJXTE
    dvBgfwZOvzkE/dbKpYDQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id z758a5zAMHPRtqK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 22 Nov 2023 18:25:27 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	bvanassche@acm.org,
	alim.akhtar@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	mani@kernel.org,
	quic_cang@quicinc.com,
	quic_asutoshd@quicinc.com,
	beanhuo@micron.com,
	thomas@t-8ch.de
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mikebi@micron.com,
	lporzio@micron.com
Subject: [PATCH v2 1/3] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
Date: Wed, 22 Nov 2023 18:25:10 +0100
Message-Id: <20231122172512.103748-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122172512.103748-1-beanhuo@iokpp.de>
References: <20231122172512.103748-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Add helper inline for retrieving whether UFS device is busy or not.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd.c | 6 +-----
 include/ufs/ufshcd.h      | 8 +++++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 68d7da02944f..5d009d2c34f0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1916,11 +1916,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 					hba->clk_gating.state);
 		goto rel_lock;
 	}
-
-	if (hba->clk_gating.active_reqs
-		|| hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
-		|| hba->outstanding_reqs || hba->outstanding_tasks
-		|| hba->active_uic_cmd || hba->uic_async_done)
+	if (ufshcd_is_ufs_dev_busy(hba))
 		goto rel_lock;
 
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7f0b2c5599cd..b0cd6c6591ef 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -126,7 +126,6 @@ enum uic_link_state {
 	((h)->curr_dev_pwr_mode == UFS_POWERDOWN_PWR_MODE)
 #define ufshcd_is_ufs_dev_deepsleep(h) \
 	((h)->curr_dev_pwr_mode == UFS_DEEPSLEEP_PWR_MODE)
-
 /*
  * UFS Power management levels.
  * Each level is in increasing order of power savings, except DeepSleep
@@ -1408,6 +1407,13 @@ static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
 	return 0;
 }
 
+static inline bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
+{
+	return (hba->clk_gating.active_reqs || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
+		hba->outstanding_reqs || hba->outstanding_tasks || hba->active_uic_cmd ||
+		hba->uic_async_done);
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
-- 
2.34.1


