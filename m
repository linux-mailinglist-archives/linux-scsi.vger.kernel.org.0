Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476D126A103
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Sep 2020 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIOIiq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 04:38:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgIOIip (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 15 Sep 2020 04:38:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D5804E2762AE349CE23;
        Tue, 15 Sep 2020 16:38:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 16:38:31 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@wdc.com>,
        <megaraidlinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: megaraid: make smp_affinity_enable static
Date:   Tue, 15 Sep 2020 16:39:48 +0800
Message-ID: <20200915083948.2826598-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This addresses the following sparse warning:

drivers/scsi/megaraid/megaraid_sas_base.c:80:5: warning: symbol
'smp_affinity_enable' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 2b7e7b5f38ed..e158d3d62056 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -77,7 +77,7 @@ unsigned int resetwaittime = MEGASAS_RESET_WAIT_TIME;
 module_param(resetwaittime, int, 0444);
 MODULE_PARM_DESC(resetwaittime, "Wait time in (1-180s) after I/O timeout before resetting adapter. Default: 180s");
 
-int smp_affinity_enable = 1;
+static int smp_affinity_enable = 1;
 module_param(smp_affinity_enable, int, 0444);
 MODULE_PARM_DESC(smp_affinity_enable, "SMP affinity feature enable/disable Default: enable(1)");
 
-- 
2.25.4

