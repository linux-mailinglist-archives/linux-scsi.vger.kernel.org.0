Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3F3A4D51
	for <lists+linux-scsi@lfdr.de>; Sat, 12 Jun 2021 09:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhFLHUm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 12 Jun 2021 03:20:42 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:57980 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230028AbhFLHUj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 12 Jun 2021 03:20:39 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d74 with ME
        id G7Jc2500P21Fzsu037Jd1X; Sat, 12 Jun 2021 09:18:38 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Jun 2021 09:18:38 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     subbu.seetharaman@broadcom.com, ketan.mukadam@broadcom.com,
        jitendra.bhivare@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, minhduc.tran@emulex.com,
        sony.john-n@emulex.com, JBottomley@Parallels.com,
        jayamohank@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] scsi: be2iscsi: Fix an error handling path in 'beiscsi_dev_probe()'
Date:   Sat, 12 Jun 2021 09:18:34 +0200
Message-Id: <77adb02cfea7f1364e5603ecf3930d8597ae356e.1623482155.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If an error occurs after a 'pci_enable_pcie_error_reporting()' call, it
must be undone by a corresponding 'pci_disable_pcie_error_reporting()'
call, as already done in the remove function.

Fixes: 3567f36a09d1 ("[SCSI] be2iscsi: Fix AER handling in driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/be2iscsi/be_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 310b801c6c87..b89a7db477c7 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -5743,6 +5743,7 @@ static int beiscsi_dev_probe(struct pci_dev *pcidev,
 	pci_disable_msix(phba->pcidev);
 	pci_dev_put(phba->pcidev);
 	iscsi_host_free(phba->shost);
+	pci_disable_pcie_error_reporting(pcidev);
 	pci_set_drvdata(pcidev, NULL);
 disable_pci:
 	pci_release_regions(pcidev);
-- 
2.30.2

