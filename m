Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94452F2413
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 01:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405529AbhALAZo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jan 2021 19:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403834AbhAKXLx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Jan 2021 18:11:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C53C061795;
        Mon, 11 Jan 2021 15:11:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c7so249167edv.6;
        Mon, 11 Jan 2021 15:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ah/q3uu0NF5NAJc51bIJTM6fDruzI2XSC5DNs/Dxtm8=;
        b=oBAekmOfTMxtV955Smgg9ThMJh8PQiUuaMEwpaCtJSwWjegEz2RHCH8fuiCPkTnZ0E
         iX3KmVuH8cpAZQUBZ19adgGrKSRVUTT7XSG3+k5mXXjLEZA/CqXq7X9nM4FD3hbXltxT
         SOijpUN4NoqmmN5B2sorRei87jLoWdJf4Zb3Qg3Sy129UZP2c/ZS8uWqo7NJviVBZnlh
         HkWEK4v+5mZn7H3nunU/K4hHqtYyn820b5vaYiAKILq1OxuZvB7bC7CBTsaJ1mrQXxkA
         D4j1GLzloPtV1S09N+sbVgPt3o66kDuuKelSs3/EVHyYDjeTfSS9OnAq5DGWL+xMn1Hn
         SD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ah/q3uu0NF5NAJc51bIJTM6fDruzI2XSC5DNs/Dxtm8=;
        b=RPyRYw1ot7cpHtxcTJykaOYSbasG3ttogUJ/8+1SJbfeQGSzjf9YJgrKuIFb0mRC1X
         PNtLgRPv+7t6TI4e9rDWIsOtlrecNf42OQI45clLu9MGyAASbAJGkh75EAvE+yQpn7vj
         t5mzQXWLxE+siUB9mjYg+3ec3HNC7Ch5wnsPWlFrjtIIe57I2iiVRkQoDbt/YlLKIRXZ
         CmS0548Wnycs4uakLskbOD5ONk/v1HGkDXGIx8vWbo7yN2RspuCI11q381cG+8tXm15g
         8sOth70yQX8h6cLFlmlkvxSr97eB89k2c1qVGbtsQJxqBV0w/WtglXi6FdeD7U1S1bZi
         /KZg==
X-Gm-Message-State: AOAM531mCQCHLSraVONFNpIBE4GTjsIhhMhZNXilxnhmcvdVEQmRTOF7
        CHwQZJJ91COb9R3AMXAnDyI=
X-Google-Smtp-Source: ABdhPJw8RaPy3vaS+Af/3aRdG9msO3YdlwcnHzpK1kAPmEgmMAKhDgBkxr6pCclxqmHylrE6cRAmQw==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr1171584edj.293.1610406672012;
        Mon, 11 Jan 2021 15:11:12 -0800 (PST)
Received: from localhost.localdomain (ip5f5bfcff.dynamic.kabel-deutschland.de. [95.91.252.255])
        by smtp.gmail.com with ESMTPSA id ch30sm598175edb.8.2021.01.11.15.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 15:11:11 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        john.garry@huawei.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, ebiggers@google.com, satyat@google.com,
        shipujin.t@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 1/2] scsi: hisi_sas: Remove unnecessary devm_kfree
Date:   Tue, 12 Jan 2021 00:10:57 +0100
Message-Id: <20210111231058.14559-2-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210111231058.14559-1-huobean@gmail.com>
References: <20210111231058.14559-1-huobean@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

The memory allocated with devm_kzalloc() is freed automatically
no need to explicitly call devm_kfree.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 28 +-------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 91a7286e8102..5600411a0820 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4172,30 +4172,6 @@ static void debugfs_work_handler_v3_hw(struct work_struct *work)
 	hisi_hba->debugfs_dump_index++;
 }
 
-static void debugfs_release_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
-{
-	struct device *dev = hisi_hba->dev;
-	int i;
-
-	devm_kfree(dev, hisi_hba->debugfs_iost_cache[dump_index].cache);
-	devm_kfree(dev, hisi_hba->debugfs_itct_cache[dump_index].cache);
-	devm_kfree(dev, hisi_hba->debugfs_iost[dump_index].iost);
-	devm_kfree(dev, hisi_hba->debugfs_itct[dump_index].itct);
-
-	for (i = 0; i < hisi_hba->queue_count; i++)
-		devm_kfree(dev, hisi_hba->debugfs_dq[dump_index][i].hdr);
-
-	for (i = 0; i < hisi_hba->queue_count; i++)
-		devm_kfree(dev,
-			   hisi_hba->debugfs_cq[dump_index][i].complete_hdr);
-
-	for (i = 0; i < DEBUGFS_REGS_NUM; i++)
-		devm_kfree(dev, hisi_hba->debugfs_regs[dump_index][i].data);
-
-	for (i = 0; i < hisi_hba->n_phy; i++)
-		devm_kfree(dev, hisi_hba->debugfs_port_reg[dump_index][i].data);
-}
-
 static const struct hisi_sas_debugfs_reg *debugfs_reg_array_v3_hw[DEBUGFS_REGS_NUM] = {
 	[DEBUGFS_GLOBAL] = &debugfs_global_reg,
 	[DEBUGFS_AXI] = &debugfs_axi_reg,
@@ -4206,7 +4182,7 @@ static int debugfs_alloc_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
 {
 	const struct hisi_sas_hw *hw = hisi_hba->hw;
 	struct device *dev = hisi_hba->dev;
-	int p, c, d, r, i;
+	int p, c, d, r;
 	size_t sz;
 
 	for (r = 0; r < DEBUGFS_REGS_NUM; r++) {
@@ -4286,8 +4262,6 @@ static int debugfs_alloc_v3_hw(struct hisi_hba *hisi_hba, int dump_index)
 
 	return 0;
 fail:
-	for (i = 0; i < hisi_sas_debugfs_dump_count; i++)
-		debugfs_release_v3_hw(hisi_hba, i);
 	return -ENOMEM;
 }
 
-- 
2.17.1

