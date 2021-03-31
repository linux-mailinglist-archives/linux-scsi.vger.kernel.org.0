Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8AE349797
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Mar 2021 18:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhCYRH6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Mar 2021 13:07:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35703 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCYRHe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Mar 2021 13:07:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lPTSF-0003xZ-EY; Thu, 25 Mar 2021 17:07:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: a100u2w: remove unused variable biosaddr
Date:   Thu, 25 Mar 2021 17:07:31 +0000
Message-Id: <20210325170731.484651-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable biosaddr is being assigned a value that is never read,
the variable is redundant and can be safely removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/a100u2w.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index c9ed210d77b3..028af6b1057c 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1088,7 +1088,6 @@ static int inia100_probe_one(struct pci_dev *pdev,
 	unsigned long port, bios;
 	int error = -ENODEV;
 	u32 sz;
-	unsigned long biosaddr;
 
 	if (pci_enable_device(pdev))
 		goto out;
@@ -1138,8 +1137,6 @@ static int inia100_probe_one(struct pci_dev *pdev,
 		goto out_free_scb_array;
 	}
 
-	biosaddr = host->BIOScfg;
-	biosaddr = (biosaddr << 4);
 	if (init_orchid(host)) {	/* Initialize orchid chip */
 		printk("inia100: initial orchid fail!!\n");
 		goto out_free_escb_array;
-- 
2.30.2

