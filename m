Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB9338670
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Mar 2021 08:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhCLHOc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Mar 2021 02:14:32 -0500
Received: from mail-m971.mail.163.com ([123.126.97.1]:42830 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCLHO3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Mar 2021 02:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3JnpMfJsXvZJj+k53w
        TdygQRRMU1DsxnCaw7gbwLK5s=; b=TXJdXuyq5Up085iymXp6MqU7Eq843dEE/c
        5Iac+Gu+q92UK/OV/6ebAUM4025GgQ5iqZP1LKBk6b32AlaWLyTby0hY8+ckkDGb
        dUviIxaw7ynGqAWWeGGraUCrfU1AWaTpNaFxvM0SVzHZudxLpjgIi0PyxRG3ybp7
        FAW347fy0=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp1 (Coremail) with SMTP id GdxpCgD37fO7FEtgvVMDCQ--.133S2;
        Fri, 12 Mar 2021 15:14:10 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     stanley.chu@mediatek.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, matthias.bgg@gmail.com
Cc:     linux-scsi@vger.kernel.org, huyue2@yulong.com,
        dongjian <dongjian@yulong.com>
Subject: [PATCH] scsi: ufs-mediatek: Correct operator & -> &&
Date:   Fri, 12 Mar 2021 15:14:20 +0800
Message-Id: <1615533260-175467-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: GdxpCgD37fO7FEtgvVMDCQ--.133S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWfur1UXF1Uur18JF1rXrb_yoWfWFg_CF
        W8XrsxW3yUKF4xAr1rXr4Fyry2va1rWw48A3ZYvF9YyF9rWaySqw4vqr4v9w45X3y3Xasx
        u3Z0grnIyFn5GjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0aYLPUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiTAJT3VSIm4uLTgAAsJ
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: dongjian <dongjian@yulong.com>

The "lpm" and "->enabled" are all bool type, it should be using
operator && rather than bit operator.

Signed-off-by: dongjian <dongjian@yulong.com>
Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/scsi/ufs/ufs-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index c55202b..a981f26 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -911,7 +911,7 @@ static void ufs_mtk_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
 	if (!hba->vreg_info.vccq2 || !hba->vreg_info.vcc)
 		return;
 
-	if (lpm & !hba->vreg_info.vcc->enabled)
+	if (lpm && !hba->vreg_info.vcc->enabled)
 		regulator_set_mode(hba->vreg_info.vccq2->reg,
 				   REGULATOR_MODE_IDLE);
 	else if (!lpm)
-- 
1.9.1

