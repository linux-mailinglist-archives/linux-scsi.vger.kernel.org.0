Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8534B4F0
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Mar 2021 08:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhC0HCD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 27 Mar 2021 03:02:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14569 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhC0HBv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 27 Mar 2021 03:01:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6qSt4tfdzPtLr;
        Sat, 27 Mar 2021 14:59:10 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 15:01:36 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 2/2] scsi: myrs: Make symbols DAC960_{GEM/BA/LP}_privdata static
Date:   Sat, 27 Mar 2021 15:31:57 +0800
Message-ID: <20210327073157.1786772-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This symbol is not used outside of myrs.c, so we can marks it static.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/scsi/myrs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 9ebff2449a54..d5ec1cdea0e1 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -2656,7 +2656,7 @@ static irqreturn_t DAC960_GEM_intr_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-struct myrs_privdata DAC960_GEM_privdata = {
+static struct myrs_privdata DAC960_GEM_privdata = {
 	.hw_init =		DAC960_GEM_hw_init,
 	.irq_handler =		DAC960_GEM_intr_handler,
 	.mmio_size =		DAC960_GEM_mmio_size,
@@ -2906,7 +2906,7 @@ static irqreturn_t DAC960_BA_intr_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-struct myrs_privdata DAC960_BA_privdata = {
+static struct myrs_privdata DAC960_BA_privdata = {
 	.hw_init =		DAC960_BA_hw_init,
 	.irq_handler =		DAC960_BA_intr_handler,
 	.mmio_size =		DAC960_BA_mmio_size,
@@ -3156,7 +3156,7 @@ static irqreturn_t DAC960_LP_intr_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-struct myrs_privdata DAC960_LP_privdata = {
+static struct myrs_privdata DAC960_LP_privdata = {
 	.hw_init =		DAC960_LP_hw_init,
 	.irq_handler =		DAC960_LP_intr_handler,
 	.mmio_size =		DAC960_LP_mmio_size,
-- 
2.25.1

