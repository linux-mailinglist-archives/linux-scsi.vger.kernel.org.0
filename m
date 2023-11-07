Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487C87E44A5
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Nov 2023 16:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjKGPzs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Nov 2023 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjKGPzV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Nov 2023 10:55:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717247A2;
        Tue,  7 Nov 2023 07:50:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BEDC433C7;
        Tue,  7 Nov 2023 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372240;
        bh=oexVi2LphfvVm18NAPWwVlJEW441Aua5B+bNWPJVR7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7nEY7pTcBcoBlpHRVwqFyZfQU9UYJcHRGyyOR1sTGdMZSV0jRKE2R5C/YEdSdEKj
         ptIr5fmRh91UsVdeiQF1mqCWjP7chnod8yfH+WJaRynU+2ENDnIMvYPL0M75A0WM99
         WW8/42qi96lSg/Dxq8Dotdp8sgkNGzP6stoCSZtqEa510XXqwmZqp1z1HzNx9MBMRS
         I986uWiYUNeyCXktD1vaBLn28vNYr6GWIlJz13QrK/VAKMMaqFc2z1jN6mWxYQv01P
         J0FAL4dWB+gb01+e9O21DYlMYj1qATAA/yjq6q1GyHmvvY3LlO2dnxGjtEh9r4h0fQ
         2epvaXe2jetYw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yihang Li <liyihang9@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/30] scsi: hisi_sas: Set debugfs_dir pointer to NULL after removing debugfs
Date:   Tue,  7 Nov 2023 10:49:41 -0500
Message-ID: <20231107155024.3766950-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Yihang Li <liyihang9@huawei.com>

[ Upstream commit 6de426f9276c448e2db7238911c97fb157cb23be ]

If init debugfs failed during device registration due to memory allocation
failure, debugfs_remove_recursive() is called, after which debugfs_dir is
not set to NULL. debugfs_remove_recursive() will be called again during
device removal. As a result, illegal pointer is accessed.

[ 1665.467244] hisi_sas_v3_hw 0000:b4:02.0: failed to init debugfs!
...
[ 1669.836708] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000a0
[ 1669.872669] pc : down_write+0x24/0x70
[ 1669.876315] lr : down_write+0x1c/0x70
[ 1669.879961] sp : ffff000036f53a30
[ 1669.883260] x29: ffff000036f53a30 x28: ffffa027c31549f8
[ 1669.888547] x27: ffffa027c3140000 x26: 0000000000000000
[ 1669.893834] x25: ffffa027bf37c270 x24: ffffa027bf37c270
[ 1669.899122] x23: ffff0000095406b8 x22: ffff0000095406a8
[ 1669.904408] x21: 0000000000000000 x20: ffffa027bf37c310
[ 1669.909695] x19: 00000000000000a0 x18: ffff8027dcd86f10
[ 1669.914982] x17: 0000000000000000 x16: 0000000000000000
[ 1669.920268] x15: 0000000000000000 x14: ffffa0274014f870
[ 1669.925555] x13: 0000000000000040 x12: 0000000000000228
[ 1669.930842] x11: 0000000000000020 x10: 0000000000000bb0
[ 1669.936129] x9 : ffff000036f537f0 x8 : ffff80273088ca10
[ 1669.941416] x7 : 000000000000001d x6 : 00000000ffffffff
[ 1669.946702] x5 : ffff000008a36310 x4 : ffff80273088be00
[ 1669.951989] x3 : ffff000009513e90 x2 : 0000000000000000
[ 1669.957276] x1 : 00000000000000a0 x0 : ffffffff00000001
[ 1669.962563] Call trace:
[ 1669.965000]  down_write+0x24/0x70
[ 1669.968301]  debugfs_remove_recursive+0x5c/0x1b0
[ 1669.972905]  hisi_sas_debugfs_exit+0x24/0x30 [hisi_sas_main]
[ 1669.978541]  hisi_sas_v3_remove+0x130/0x150 [hisi_sas_v3_hw]
[ 1669.984175]  pci_device_remove+0x48/0xd8
[ 1669.988082]  device_release_driver_internal+0x1b4/0x250
[ 1669.993282]  device_release_driver+0x28/0x38
[ 1669.997534]  pci_stop_bus_device+0x84/0xb8
[ 1670.001611]  pci_stop_and_remove_bus_device_locked+0x24/0x40
[ 1670.007244]  remove_store+0xfc/0x140
[ 1670.010802]  dev_attr_store+0x44/0x60
[ 1670.014448]  sysfs_kf_write+0x58/0x80
[ 1670.018095]  kernfs_fop_write+0xe8/0x1f0
[ 1670.022000]  __vfs_write+0x60/0x190
[ 1670.025472]  vfs_write+0xac/0x1c0
[ 1670.028771]  ksys_write+0x6c/0xd8
[ 1670.032071]  __arm64_sys_write+0x24/0x30
[ 1670.035977]  el0_svc_common+0x78/0x130
[ 1670.039710]  el0_svc_handler+0x38/0x78
[ 1670.043442]  el0_svc+0x8/0xc

To fix this, set debugfs_dir to NULL after debugfs_remove_recursive().

Signed-off-by: Yihang Li <liyihang9@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/1694571327-78697-2-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index c0e74d768716d..c4305ec38ebf3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4717,6 +4717,12 @@ static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_hba->debugfs_bist_linkrate = SAS_LINK_RATE_1_5_GBPS;
 }
 
+static void debugfs_exit_v3_hw(struct hisi_hba *hisi_hba)
+{
+	debugfs_remove_recursive(hisi_hba->debugfs_dir);
+	hisi_hba->debugfs_dir = NULL;
+}
+
 static void debugfs_init_v3_hw(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
@@ -4740,18 +4746,13 @@ static void debugfs_init_v3_hw(struct hisi_hba *hisi_hba)
 
 	for (i = 0; i < hisi_sas_debugfs_dump_count; i++) {
 		if (debugfs_alloc_v3_hw(hisi_hba, i)) {
-			debugfs_remove_recursive(hisi_hba->debugfs_dir);
+			debugfs_exit_v3_hw(hisi_hba);
 			dev_dbg(dev, "failed to init debugfs!\n");
 			break;
 		}
 	}
 }
 
-static void debugfs_exit_v3_hw(struct hisi_hba *hisi_hba)
-{
-	debugfs_remove_recursive(hisi_hba->debugfs_dir);
-}
-
 static int
 hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-- 
2.42.0

