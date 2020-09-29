Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4A27BAC9
	for <lists+linux-scsi@lfdr.de>; Tue, 29 Sep 2020 04:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgI2CZS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 28 Sep 2020 22:25:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbgI2CZS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 28 Sep 2020 22:25:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0C7B2C0EE627B64DE7D2;
        Tue, 29 Sep 2020 10:25:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 10:25:04 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <hare@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: myrb: remove redundant assignment to variable timeout
Date:   Tue, 29 Sep 2020 10:24:58 +0800
Message-ID: <20200929022458.40652-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The variable timeout has been initialized with a value '0'. The assignment
before while loop is redundant. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/myrb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index b2869c5dd7fb..687a808969ac 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -2732,7 +2732,6 @@ static int DAC960_LA_hw_init(struct pci_dev *pdev,
 	DAC960_LA_disable_intr(base);
 	DAC960_LA_ack_hw_mbox_status(base);
 	udelay(1000);
-	timeout = 0;
 	while (DAC960_LA_init_in_progress(base) &&
 	       timeout < MYRB_MAILBOX_TIMEOUT) {
 		if (DAC960_LA_read_error_status(base, &error,
-- 
2.17.1

