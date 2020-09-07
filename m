Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3623D25F440
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Sep 2020 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgIGHqN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Sep 2020 03:46:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbgIGHqJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Sep 2020 03:46:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5769F874728AD5573BBE;
        Mon,  7 Sep 2020 15:46:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Sep 2020
 15:46:00 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mdr@sgi.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <yanaijie@huawei.com>, <tbogendoerfer@suse.de>,
        <linux-scsi@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 3/4] scsi: qla1280: remove set but not used variable in qla1280_mailbox_command()
Date:   Mon, 7 Sep 2020 15:45:17 +0800
Message-ID: <20200907074518.2326360-4-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200907074518.2326360-1-yanaijie@huawei.com>
References: <20200907074518.2326360-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/scsi/qla1280.c: In function ‘qla1280_mailbox_command’:
drivers/scsi/qla1280.c:2430:11: warning: variable ‘data’ set but not
used [-Wunused-but-set-variable]
 2430 |  uint16_t data;
      |           ^~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/qla1280.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 72f92733e75f..fe4b88aaf5cb 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -2425,7 +2425,6 @@ qla1280_mailbox_command(struct scsi_qla_host *ha, uint8_t mr, uint16_t *mb)
 	int cnt;
 	uint16_t *optr, *iptr;
 	uint16_t __iomem *mptr;
-	uint16_t data;
 	DECLARE_COMPLETION_ONSTACK(wait);
 
 	ENTER("qla1280_mailbox_command");
@@ -2460,7 +2459,7 @@ qla1280_mailbox_command(struct scsi_qla_host *ha, uint8_t mr, uint16_t *mb)
 
 	spin_unlock_irq(ha->host->host_lock);
 	WRT_REG_WORD(&reg->host_cmd, HC_SET_HOST_INT);
-	data = qla1280_debounce_register(&reg->istatus);
+	qla1280_debounce_register(&reg->istatus);
 
 	wait_for_completion(&wait);
 	del_timer_sync(&ha->mailbox_timer);
-- 
2.25.4

