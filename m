Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D46294392
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 21:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438417AbgJTTxI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 15:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391578AbgJTTxH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 15:53:07 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEC72237B;
        Tue, 20 Oct 2020 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603223587;
        bh=i4tSJFhcpdoYyFGdbx8qrSq1ZVm7uZj3YCN+HiJv7sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCNO2UfMeKXrpQQ6GHndJ9kWYAbp1IRSoueEjJ3ZtPV/FTGsCvfaW3wDRwmwFQUru
         s/nw0+kWMfH3Ii+djdeT4xhGczYXdv1uOdS/qT+HEDSMKnZbx64gsa87Tf1nZuwNR2
         NtI2fAZlZkkii30Lsq4As3BQIolUlk8z1vat/1hk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Can Guo <cang@codeaurora.org>
Subject: [PATCH v2 3/5] scsi: ufs: use WQ_HIGHPRI for gating work
Date:   Tue, 20 Oct 2020 12:52:56 -0700
Message-Id: <20201020195258.2005605-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020195258.2005605-1-jaegeuk@kernel.org>
References: <20201020195258.2005605-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@google.com>

Must have WQ_MEM_RECLAIM
``WQ_MEM_RECLAIM``
  All wq which might be used in the memory reclaim paths **MUST**
  have this flag set.  The wq is guaranteed to have at least one
  execution context regardless of memory pressure.

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Can Guo <cang@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index feb10ebf7a35..0858c0b55eac 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1867,7 +1867,7 @@ static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 	snprintf(wq_name, ARRAY_SIZE(wq_name), "ufs_clk_gating_%d",
 		 hba->host->host_no);
 	hba->clk_gating.clk_gating_workq = alloc_ordered_workqueue(wq_name,
-							   WQ_MEM_RECLAIM);
+					WQ_MEM_RECLAIM | WQ_HIGHPRI);
 
 	hba->clk_gating.is_enabled = true;
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

