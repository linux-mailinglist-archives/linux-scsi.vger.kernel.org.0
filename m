Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88926F958
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIRJcR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Sep 2020 05:32:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgIRJcR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 18 Sep 2020 05:32:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78C7A460323D27677148;
        Fri, 18 Sep 2020 17:32:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 17:32:05 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lee.jones@linaro.org>, <colin.king@canonical.com>,
        <axboe@kernel.dk>, <mchehab+huawei@kernel.org>,
        <gustavoars@kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: arcmsr: Remove the superfluous break
Date:   Fri, 18 Sep 2020 17:32:30 +0800
Message-ID: <20200918093230.49050-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove the superfluous break, as there is a 'return' before it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index ec895d0319f0..74add6d247d5 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -2699,10 +2699,8 @@ static irqreturn_t arcmsr_interrupt(struct AdapterControlBlock *acb)
 	switch (acb->adapter_type) {
 	case ACB_ADAPTER_TYPE_A:
 		return arcmsr_hbaA_handle_isr(acb);
-		break;
 	case ACB_ADAPTER_TYPE_B:
 		return arcmsr_hbaB_handle_isr(acb);
-		break;
 	case ACB_ADAPTER_TYPE_C:
 		return arcmsr_hbaC_handle_isr(acb);
 	case ACB_ADAPTER_TYPE_D:
-- 
2.17.1

