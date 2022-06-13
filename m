Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5D547D92
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jun 2022 04:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiFMCNF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Jun 2022 22:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiFMCNE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 12 Jun 2022 22:13:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD912AF5;
        Sun, 12 Jun 2022 19:13:01 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LLw605LFrz1K9Df;
        Mon, 13 Jun 2022 10:11:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 10:12:59 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scsi: lpfc: Use memset_startat() helper in lpfc_nvmet_xmt_fcp_op_cmp
Date:   Mon, 13 Jun 2022 10:10:57 +0800
Message-ID: <20220613021057.58263-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use memset_startat() helper to simply the code, no functional change in
this patch.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index c0ee0b39075d..c3cb7e8a2a7c 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -722,7 +722,7 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct nvmefc_tgt_fcp_req *rsp;
 	struct lpfc_async_xchg_ctx *ctxp;
-	uint32_t status, result, op, start_clean, logerr;
+	uint32_t status, result, op, logerr;
 	struct lpfc_wcqe_complete *wcqe = &rspwqe->wcqe_cmpl;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	int id;
@@ -820,9 +820,7 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		/* lpfc_nvmet_xmt_fcp_release() will recycle the context */
 	} else {
 		ctxp->entry_cnt++;
-		start_clean = offsetof(struct lpfc_iocbq, cmd_flag);
-		memset(((char *)cmdwqe) + start_clean, 0,
-		       (sizeof(struct lpfc_iocbq) - start_clean));
+		memset_startat(cmdwqe, 0, cmd_flag);
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 		if (ctxp->ts_cmd_nvme) {
 			ctxp->ts_isr_data = cmdwqe->isr_timestamp;
-- 
2.17.1

