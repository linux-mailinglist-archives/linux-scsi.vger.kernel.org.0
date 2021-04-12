Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2771135B8E5
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Apr 2021 05:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhDLDXF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 11 Apr 2021 23:23:05 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35628 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235234AbhDLDXF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 11 Apr 2021 23:23:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UVCHNlN_1618197761;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVCHNlN_1618197761)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Apr 2021 11:22:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: a100u2w: remove useless variable
Date:   Mon, 12 Apr 2021 11:22:39 +0800
Message-Id: <1618197759-128087-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following gcc warning:

drivers/scsi/a100u2w.c:1092:8: warning: variable ‘bios_phys’ set but not
used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/a100u2w.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 66c5143..855a3fe 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1089,7 +1089,6 @@ static int inia100_probe_one(struct pci_dev *pdev,
 	int error = -ENODEV;
 	u32 sz;
 	unsigned long biosaddr;
-	char *bios_phys;
 
 	if (pci_enable_device(pdev))
 		goto out;
@@ -1141,7 +1140,7 @@ static int inia100_probe_one(struct pci_dev *pdev,
 
 	biosaddr = host->BIOScfg;
 	biosaddr = (biosaddr << 4);
-	bios_phys = phys_to_virt(biosaddr);
+	phys_to_virt(biosaddr);
 	if (init_orchid(host)) {	/* Initialize orchid chip */
 		printk("inia100: initial orchid fail!!\n");
 		goto out_free_escb_array;
-- 
1.8.3.1

