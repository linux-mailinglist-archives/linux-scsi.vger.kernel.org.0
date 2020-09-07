Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF1725F442
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Sep 2020 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgIGHqP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Sep 2020 03:46:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgIGHqI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Sep 2020 03:46:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5BAF0AA835BB1C160851;
        Mon,  7 Sep 2020 15:46:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Sep 2020
 15:45:59 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mdr@sgi.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <yanaijie@huawei.com>, <tbogendoerfer@suse.de>,
        <linux-scsi@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 1/4] scsi: qla1280: remove set but not used variable in qla1280_done()
Date:   Mon, 7 Sep 2020 15:45:15 +0800
Message-ID: <20200907074518.2326360-2-yanaijie@huawei.com>
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

drivers/scsi/qla1280.c: In function ‘qla1280_done’:
drivers/scsi/qla1280.c:1244:19: warning: variable ‘lun’ set but not used
[-Wunused-but-set-variable]
 1244 |  int bus, target, lun;
      |                   ^~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/qla1280.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 441a45349349..42c68bd98fa5 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -1241,7 +1241,7 @@ qla1280_done(struct scsi_qla_host *ha)
 {
 	struct srb *sp;
 	struct list_head *done_q;
-	int bus, target, lun;
+	int bus, target;
 	struct scsi_cmnd *cmd;
 
 	ENTER("qla1280_done");
@@ -1256,7 +1256,6 @@ qla1280_done(struct scsi_qla_host *ha)
 		cmd = sp->cmd;
 		bus = SCSI_BUS_32(cmd);
 		target = SCSI_TCN_32(cmd);
-		lun = SCSI_LUN_32(cmd);
 
 		switch ((CMD_RESULT(cmd) >> 16)) {
 		case DID_RESET:
-- 
2.25.4

