Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAEC31148
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 17:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEaP2C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 11:28:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfEaP2C (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 May 2019 11:28:02 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF5FD3F2C15E38F35514;
        Fri, 31 May 2019 23:27:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 23:27:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jsmart2021@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: lpfc: Remove set but not used variables 'qp'
Date:   Fri, 31 May 2019 23:27:45 +0800
Message-ID: <20190531152745.7928-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warnings:

drivers/scsi/lpfc/lpfc_init.c: In function lpfc_setup_cq_lookup:
drivers/scsi/lpfc/lpfc_init.c:9359:30: warning: variable qp set but not used [-Wunused-but-set-variable]

It's not used since commit e70596a60f88 ("scsi: lpfc: Fix
poor use of hardware queues if fewer irq vectors")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 24965a06f55d..cd8e47544d07 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -9356,10 +9356,8 @@ static void
 lpfc_setup_cq_lookup(struct lpfc_hba *phba)
 {
 	struct lpfc_queue *eq, *childq;
-	struct lpfc_sli4_hdw_queue *qp;
 	int qidx;
 
-	qp = phba->sli4_hba.hdwq;
 	memset(phba->sli4_hba.cq_lookup, 0,
 	       (sizeof(struct lpfc_queue *) * (phba->sli4_hba.cq_max + 1)));
 	/* Loop thru all IRQ vectors */
-- 
2.17.1


