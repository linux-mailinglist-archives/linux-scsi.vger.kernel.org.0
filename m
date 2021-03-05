Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E812F32E56E
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Mar 2021 10:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCEJ6a (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 5 Mar 2021 04:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCEJ6Q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 5 Mar 2021 04:58:16 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71556C061574;
        Fri,  5 Mar 2021 01:58:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id j12so1627819pfj.12;
        Fri, 05 Mar 2021 01:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=INlAlYygcCr8qFIw5Y+aGmBMuUbzyX/B9XRXD/oolTA=;
        b=IdODdt96RTZyyooVjpTz93+P0LMMsTXlm0eZU9AuBwtMERFZ2xtpzVHsMCLFFQqIAV
         8DqDEWPUoEoBw5EbbCEeFGlWpoyiphtM259DTpauGd9tJATvPI2qj+7T6lUIOznK+665
         8jUJ0V1iQ4vCMYkuZzMzZGRCdMDu1xXn6Ub8PluxF3HTQ1wGnCBWzNWKH+USmcjn975U
         ZpLutmb1hk6kI/gJM/1iGZPQNmgu9vXtSNUSU4h+icbJzxaEKy83KMDr9/nWfUyA8tk6
         YeG8v2FM+YJc3d7qjf7GC5Uf9J/QBTBNWMamiAZB1V/JKtwv9ZLHkboo5a6UrZXLkdY1
         t9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=INlAlYygcCr8qFIw5Y+aGmBMuUbzyX/B9XRXD/oolTA=;
        b=nHSb5ej0TgVYSRQ0OXXwAPuLe7ntQTt9sJO6litbRb3X8iEDVk/o+6Rg85W8HfulyY
         RnPs5n9hT8ErsSdcnxK9PUvziDlzYHuuJt4bgfDxxQAq9W8JdBLxBS3jMR9vmPbqwEye
         KzbPxkWWkN4k81bL3xUErGfB7MzafZ4RX+kCoMMioHMrmMxwbTEKSqVRk3nhZ5FGmsZZ
         SuT73OgIzoliotIkKuMeqxNrP8gV9F/OB+vnlrDizmUfq5UyRJ0P0FInEdT3XKlRYZ5X
         2FEDDktyU6Wl48mvmDrEbwhRUVhOJwO2HgXRMCiVlRusMQVzebh+Y003ro3FmHQb7wiq
         Cckg==
X-Gm-Message-State: AOAM5331E0aaA1CYuVIlTDQlUdL6fNwfUep5DRxhiODw9RUzgEQPO2cx
        5/99qEKtEeo9fefIfsHAYK8=
X-Google-Smtp-Source: ABdhPJyMuRf+cpk5pKHXlHgHBpG6eV399lzhZDsO+lyz7OAT/99v+UL9vovetCwr7FrLSy1W79Z1jQ==
X-Received: by 2002:a63:5c23:: with SMTP id q35mr7926120pgb.418.1614938296114;
        Fri, 05 Mar 2021 01:58:16 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id c193sm2193231pfc.180.2021.03.05.01.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:58:15 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        cang@codeaurora.org, beanhuo@micron.com, jaegeuk@kernel.org,
        asutoshd@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: ufs: fix error return code of ufshcd_devfreq_target()
Date:   Fri,  5 Mar 2021 01:58:08 -0800
Message-Id: <20210305095808.14119-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When the list of clk_list is empty, no error return code of
ufshcd_devfreq_target() is assigned.
To fix this bug, ret is assigned with -ENOENT as error return code.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/ufs/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 77161750c9fb..d31aae56fd96 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1337,6 +1337,7 @@ static int ufshcd_devfreq_target(struct device *dev,
 
 	if (list_empty(clk_list)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
+		ret = -ENOENT;
 		goto out;
 	}
 
-- 
2.17.1

