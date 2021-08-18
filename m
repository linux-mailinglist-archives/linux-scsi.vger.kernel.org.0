Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848863F0572
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Aug 2021 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhHRN6v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Aug 2021 09:58:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3664 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhHRN6t (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Aug 2021 09:58:49 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GqTwr0WmZz6H6wL;
        Wed, 18 Aug 2021 21:57:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 18 Aug 2021 15:58:13 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 18 Aug 2021 14:58:10 +0100
From:   John Garry <john.garry@huawei.com>
To:     <mdr@sgi.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bvanassche@acm.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] scsi: qla1280: Stop using scsi_cmnd.tag
Date:   Wed, 18 Aug 2021 21:53:20 +0800
Message-ID: <1629294801-32102-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629294801-32102-1-git-send-email-john.garry@huawei.com>
References: <1629294801-32102-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use scsi_cmd_to_rq(cmd)->tag instead of scsi_cmnd.tag as preference.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/qla1280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index aec92471c5f2..b4f7d8d7a01c 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -3980,7 +3980,7 @@ __qla1280_print_scsi_cmd(struct scsi_cmnd *cmd)
 	   qla1280_dump_buffer(1, (char *)sg, (cmd->use_sg*sizeof(struct scatterlist)));
 	   } */
 	printk("  tag=%d, transfersize=0x%x \n",
-	       cmd->tag, cmd->transfersize);
+	       scsi_cmd_to_rq(cmd)->tag, cmd->transfersize);
 	printk("  SP=0x%p\n", CMD_SP(cmd));
 	printk(" underflow size = 0x%x, direction=0x%x\n",
 	       cmd->underflow, cmd->sc_data_direction);
-- 
2.17.1

