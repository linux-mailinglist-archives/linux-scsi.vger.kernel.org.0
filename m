Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA97639331A
	for <lists+linux-scsi@lfdr.de>; Thu, 27 May 2021 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhE0QDR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 May 2021 12:03:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236168AbhE0QDN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 May 2021 12:03:13 -0400
X-UUID: e02f11ae00784b768253217163e76cf7-20210528
X-UUID: e02f11ae00784b768253217163e76cf7-20210528
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <alice.chao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 174291854; Fri, 28 May 2021 00:01:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 00:01:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 00:01:15 +0800
From:   Alice <alice.chao@mediatek.com>
To:     <stanley.chu@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <jonathan.hsu@mediatek.com>, <powen.kao@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>
Subject: [PATCH 1/1] scsi: ufs-mediatek: Fix HWReset timing
Date:   Thu, 27 May 2021 23:58:17 +0800
Message-ID: <20210527155817.15006-2-alice.chao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210527155817.15006-1-alice.chao@mediatek.com>
References: <20210527155817.15006-1-alice.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: "Alice.Chao" <alice.chao@mediatek.com>

HCI disable before HW Reset.
Because of the property of mtk ufshci,
we need to change reset flow to avoid potential issues.

Change-Id: I3eb917fd2953b58dcf7e021286d1de71c9232cfb
Signed-off-by: Alice.Chao <alice.chao@mediatek.com>
CR-Id: ALPS05728133
Feature: UFS(Universal Flash Storage)
---
 drivers/scsi/ufs/ufs-mediatek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index a981f261b304..c62603ed3d33 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -846,6 +846,9 @@ static int ufs_mtk_device_reset(struct ufs_hba *hba)
 {
 	struct arm_smccc_res res;
 
+	/* disable hba before device reset */
+	ufshcd_hba_stop(hba);
+
 	ufs_mtk_device_reset_ctrl(0, res);
 
 	/*
-- 
2.18.0

