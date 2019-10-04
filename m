Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64610CB7BA
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Oct 2019 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbfJDJ5e (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Oct 2019 05:57:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387466AbfJDJ5e (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Oct 2019 05:57:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4605C306947CD426709;
        Fri,  4 Oct 2019 17:57:32 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 4 Oct 2019
 17:57:25 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <jsmart2021@gmail.com>, <james.smart@broadcom.com>,
        <dick.kennedy@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] scsi: lpfc: Make function lpfc_defer_pt2pt_acc static
Date:   Fri, 4 Oct 2019 18:04:37 +0800
Message-ID: <1570183477-137273-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix sparse warnings:

drivers/scsi/lpfc/lpfc_nportdisc.c:290:1: warning: symbol 'lpfc_defer_pt2pt_acc' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 4e96d28..cc6b1b0 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -286,7 +286,7 @@ lpfc_els_abort(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
  * This routine is only called if we are SLI3, direct connect pt2pt
  * mode and the remote NPort issues the PLOGI after link up.
  */
-void
+static void
 lpfc_defer_pt2pt_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *link_mbox)
 {
 	LPFC_MBOXQ_t *login_mbox;
--
2.7.4

