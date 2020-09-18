Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B826F68F
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 09:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgIRHQg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Sep 2020 03:16:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgIRHQf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 18 Sep 2020 03:16:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D16A17424A1A53C96146;
        Fri, 18 Sep 2020 15:16:30 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 15:16:20 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] rapidio: Remove set but not used variable 'rc'
Date:   Fri, 18 Sep 2020 15:17:13 +0800
Message-ID: <20200918071713.19706-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/rapidio/rio_cm.c: In function rio_txcq_handler:
drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]

rc is never used, so remove it.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/rapidio/rio_cm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 50ec53d67a4c..545693bd86a3 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -670,12 +670,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
 	 */
 	if (!list_empty(&cm->tx_reqs) && (cm->tx_cnt < RIOCM_TX_RING_SIZE)) {
 		struct tx_req *req, *_req;
-		int rc;
 
 		list_for_each_entry_safe(req, _req, &cm->tx_reqs, node) {
 			list_del(&req->node);
 			cm->tx_buf[cm->tx_slot] = req->buffer;
-			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
+			rio_add_outb_message(cm->mport, req->rdev, cmbox,
 						  req->buffer, req->len);
 			kfree(req->buffer);
 			kfree(req);
-- 
2.17.1

