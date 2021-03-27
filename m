Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D734B4EE
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Mar 2021 08:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC0HCB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 27 Mar 2021 03:02:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15340 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhC0HBw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 27 Mar 2021 03:01:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6qTR5lMDz93tg;
        Sat, 27 Mar 2021 14:59:39 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 15:01:35 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 1/2] scsi: myrb: Make symbols DAC960_{LA/PG/PD/P}_privdata static
Date:   Sat, 27 Mar 2021 15:31:56 +0800
Message-ID: <20210327073156.1786722-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This symbol is not used outside of myrb.c, so we can marks it static.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/scsi/myrb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index d469a4889777..56767f8610d4 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -2809,7 +2809,7 @@ static irqreturn_t DAC960_LA_intr_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-struct myrb_privdata DAC960_LA_privdata = {
+static struct myrb_privdata DAC960_LA_privdata = {
 	.hw_init =	DAC960_LA_hw_init,
 	.irq_handler =	DAC960_LA_intr_handler,
 	.mmio_size =	DAC960_LA_mmio_size,
@@ -3085,7 +3085,7 @@ static irqreturn_t DAC960_PG_intr_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-struct myrb_privdata DAC960_PG_privdata = {
+static struct myrb_privdata DAC960_PG_privdata = {
 	.hw_init =	DAC960_PG_hw_init,
 	.irq_handler =	DAC960_PG_intr_handler,
 	.mmio_size =	DAC960_PG_mmio_size,
@@ -3288,7 +3288,7 @@ static irqreturn_t DAC960_PD_intr_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-struct myrb_privdata DAC960_PD_privdata = {
+static struct myrb_privdata DAC960_PD_privdata = {
 	.hw_init =	DAC960_PD_hw_init,
 	.irq_handler =	DAC960_PD_intr_handler,
 	.mmio_size =	DAC960_PD_mmio_size,
@@ -3486,7 +3486,7 @@ static irqreturn_t DAC960_P_intr_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-struct myrb_privdata DAC960_P_privdata = {
+static struct myrb_privdata DAC960_P_privdata = {
 	.hw_init =	DAC960_P_hw_init,
 	.irq_handler =	DAC960_P_intr_handler,
 	.mmio_size =	DAC960_PD_mmio_size,
-- 
2.25.1

