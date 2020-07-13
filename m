Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E744F21D15E
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2020 10:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgGMIIi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Jul 2020 04:08:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728833AbgGMIIh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 Jul 2020 04:08:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A88EE6C494C7A4DF989A;
        Mon, 13 Jul 2020 16:08:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Jul 2020 16:08:27 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] scsi: hisi_sas: Remove one kerneldoc comment
Date:   Mon, 13 Jul 2020 16:04:31 +0800
Message-ID: <1594627471-235395-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1594627471-235395-1-git-send-email-john.garry@huawei.com>
References: <1594627471-235395-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The comment for interrupt_init_v2_hw() should not be a kerneldoc comment,
so remove it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 4151b2c04923..ce84f2ba7f68 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3302,7 +3302,7 @@ static irq_handler_t fatal_interrupts[HISI_SAS_FATAL_INT_NR] = {
 	fatal_axi_int_v2_hw
 };
 
-/**
+/*
  * There is a limitation in the hip06 chipset that we need
  * to map in all mbigen interrupts, even if they are not used.
  */
-- 
2.26.2

