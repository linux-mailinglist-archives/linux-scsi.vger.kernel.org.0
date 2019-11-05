Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC8EF448
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 05:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfKEEAR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 23:00:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfKEEAR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Nov 2019 23:00:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5779060D8F; Tue,  5 Nov 2019 04:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572926416;
        bh=jx/SmZAawFg/FnEm6roPssceTWagqsaNGcQB2jC2CHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cExlzQodbfYgnkzcEAHQrVSFfYk6spYc9L7u+hVPBfQqkLjcgeTtDb5z5rbESgg7m
         3pEIPa7pH7ny5l5U+JYU3Ojg6RVl+C7sxMR31vKnUl2JgllofPNA+75qhmzd1K2puu
         8G3nIvUcvJhZt3snZfHc9ExOlhAu6LDJJT17jous=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AB0F60CED;
        Tue,  5 Nov 2019 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572926415;
        bh=jx/SmZAawFg/FnEm6roPssceTWagqsaNGcQB2jC2CHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m48xTo6NRdHoYhfTbQu+a44CTJNUjCnB3HXmGDS5pEbD53hpJi19VCO9vDIYVn1oV
         xBPUgAhOLUvwMaQRaJe8o4rF02dDReGvn1AV5f91U3Wb/R6SPjoFnDdFdPjSAym/p+
         7Wl3segeARi649bRFYXnAVQbRSXP/kBfyfLlzRqc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AB0F60CED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/7] scsi: ufs: Add device reset in link recovery path
Date:   Mon,  4 Nov 2019 19:57:09 -0800
Message-Id: <1572926236-720-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572926236-720-1-git-send-email-cang@codeaurora.org>
References: <1572926236-720-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In order to recover from hibern8 exit failure, perform a reset in
link recovery path before issuing link start-up.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c28c144..525f8e6 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3859,6 +3859,9 @@ static int ufshcd_link_recovery(struct ufs_hba *hba)
 	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
+	/* Reset the attached device */
+	ufshcd_vops_device_reset(hba);
+
 	ret = ufshcd_host_reset_and_restore(hba);
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

