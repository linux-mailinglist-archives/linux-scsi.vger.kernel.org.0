Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9191C5539
	for <lists+linux-scsi@lfdr.de>; Tue,  5 May 2020 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEEMPB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 May 2020 08:15:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728180AbgEEMPB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 5 May 2020 08:15:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8C1FA2E917DF3D332DDE;
        Tue,  5 May 2020 20:14:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 20:14:55 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: qedi: remove unused variable udev & uctrl
Date:   Tue, 5 May 2020 20:19:04 +0800
Message-ID: <20200505121904.25702-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

uctrl and udev are unused after commit 9632a6b4b747
("scsi: qedi: Move LL2 producer index processing in BH.")

Remove them.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 drivers/scsi/qedi/qedi_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index b995b19865ca..313f7e10aed9 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -658,8 +658,6 @@ static struct qedi_ctx *qedi_host_alloc(struct pci_dev *pdev)
 static int qedi_ll2_rx(void *cookie, struct sk_buff *skb, u32 arg1, u32 arg2)
 {
 	struct qedi_ctx *qedi = (struct qedi_ctx *)cookie;
-	struct qedi_uio_dev *udev;
-	struct qedi_uio_ctrl *uctrl;
 	struct skb_work_list *work;
 	struct ethhdr *eh;
 
@@ -698,9 +696,6 @@ static int qedi_ll2_rx(void *cookie, struct sk_buff *skb, u32 arg1, u32 arg2)
 		  "Allowed frame ethertype [0x%x] len [0x%x].\n",
 		  eh->h_proto, skb->len);
 
-	udev = qedi->udev;
-	uctrl = udev->uctrl;
-
 	work = kzalloc(sizeof(*work), GFP_ATOMIC);
 	if (!work) {
 		QEDI_WARN(&qedi->dbg_ctx,
-- 
2.20.1

