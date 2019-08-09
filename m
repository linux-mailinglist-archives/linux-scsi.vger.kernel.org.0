Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC96287D90
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2019 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407237AbfHIPDQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Aug 2019 11:03:16 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:40626 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfHIPDP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Aug 2019 11:03:15 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d35 with ME
        id n33C200010Dzhgk0333Crb; Fri, 09 Aug 2019 17:03:13 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 09 Aug 2019 17:03:13 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: pmcraid: Fix a typo - pcmraid --> pmcraid
Date:   Fri,  9 Aug 2019 17:02:14 +0200
Message-Id: <20190809150214.24454-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This should be 'pmcraid', not 'pcmraid'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/pmcraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index ca22526aff7f..a052e2450efb 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -5841,7 +5841,7 @@ static int pmcraid_probe(struct pci_dev *pdev,
 }
 
 /*
- * PCI driver structure of pcmraid driver
+ * PCI driver structure of pmcraid driver
  */
 static struct pci_driver pmcraid_driver = {
 	.name = PMCRAID_DRIVER_NAME,
-- 
2.20.1

