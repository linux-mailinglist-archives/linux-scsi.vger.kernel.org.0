Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A090B348F24
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Mar 2021 12:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCYL0P (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Mar 2021 07:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhCYLZf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Mar 2021 07:25:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CFA261A17;
        Thu, 25 Mar 2021 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616671535;
        bh=MsYtOeDemGbcokM8hsiKx5R02YdUNOKpwe4MvVUZzP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWQ6OaK+jzxBm0HeOhzrAzLWlphIjvBOTapenXjbIrPXz1f8/GPwEtfbt0ouYI0to
         QjCO7ESaA03jMKBMlQuA7bAVryqNGKcXYL0VIHlJ7bCHDwbXxEz59dzUhIHRHFEPwm
         dERAaVChRZR/LNeV/MBA3pt5nFhtj3sZDtNyJngHpWXfgbRXXx/7idDiwexFziCRhI
         e1DWHC4ELFfFqb3vvbXIkcj0ut8VERwJfVAwvnnF4RJmvw088eNCveXaE6+37hGlno
         JSvjl9ip6TUFMPVkgct9+4bvyexDF0ycKCpZlQlnBl8oCMiZUOEbOtpiYL5nrQqxKU
         zDii/kPnNaxbw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <kai.makisara@kolumbus.fi>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 27/44] scsi: st: Fix a use after free in st_open()
Date:   Thu, 25 Mar 2021 07:24:42 -0400
Message-Id: <20210325112459.1926846-27-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112459.1926846-1-sashal@kernel.org>
References: <20210325112459.1926846-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>

[ Upstream commit c8c165dea4c8f5ad67b1240861e4f6c5395fa4ac ]

In st_open(), if STp->in_use is true, STp will be freed by
scsi_tape_put(). However, STp is still used by DEBC_printk() after. It is
better to DEBC_printk() before scsi_tape_put().

Link: https://lore.kernel.org/r/20210311064636.10522-1-lyl2019@mail.ustc.edu.cn
Acked-by: Kai Mäkisara <kai.makisara@kolumbus.fi>
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 43f7624508a9..8b10fa4e381a 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -1269,8 +1269,8 @@ static int st_open(struct inode *inode, struct file *filp)
 	spin_lock(&st_use_lock);
 	if (STp->in_use) {
 		spin_unlock(&st_use_lock);
-		scsi_tape_put(STp);
 		DEBC_printk(STp, "Device already in use.\n");
+		scsi_tape_put(STp);
 		return (-EBUSY);
 	}
 
-- 
2.30.1

