Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09AF99557
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbfHVNlw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 09:41:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731907AbfHVNlw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Aug 2019 09:41:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C5F04BD9821E702B9EEE;
        Thu, 22 Aug 2019 21:41:39 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 21:41:31 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <QLogic-Storage-Upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 2/3] scsi: qla4xxx: remove set but not used variable 'func_number'
Date:   Thu, 22 Aug 2019 21:48:00 +0800
Message-ID: <1566481681-92765-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566481681-92765-1-git-send-email-zhengbin13@huawei.com>
References: <1566481681-92765-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/qla4xxx/ql4_init.c: In function ql4xxx_set_mac_number:
drivers/scsi/qla4xxx/ql4_init.c:17:10: warning: variable func_number set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/qla4xxx/ql4_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_init.c b/drivers/scsi/qla4xxx/ql4_init.c
index 2bf5e3e..2c14384 100644
--- a/drivers/scsi/qla4xxx/ql4_init.c
+++ b/drivers/scsi/qla4xxx/ql4_init.c
@@ -14,7 +14,6 @@
 static void ql4xxx_set_mac_number(struct scsi_qla_host *ha)
 {
 	uint32_t value;
-	uint8_t func_number;
 	unsigned long flags;

 	/* Get the function number */
@@ -22,7 +21,6 @@ static void ql4xxx_set_mac_number(struct scsi_qla_host *ha)
 	value = readw(&ha->reg->ctrl_status);
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);

-	func_number = (uint8_t) ((value >> 4) & 0x30);
 	switch (value & ISP_CONTROL_FN_MASK) {
 	case ISP_CONTROL_FN0_SCSI:
 		ha->mac_index = 1;
--
2.7.4

