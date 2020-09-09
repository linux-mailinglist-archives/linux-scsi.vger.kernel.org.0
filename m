Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08C2262AD5
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgIIIqd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Sep 2020 04:46:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729986AbgIIIqa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Sep 2020 04:46:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 77862B920E8747D5D302;
        Wed,  9 Sep 2020 16:46:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 16:46:21 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <linuxdrivers@attotech.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: esas2r: prevent a potential NULL dereference in esas2r_probe()
Date:   Wed, 9 Sep 2020 16:46:53 +0800
Message-ID: <20200909084653.79341-1-jingxiangfeng@huawei.com>
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

esas2r_probe() calls scsi_host_put() in an error path. However,
esas2r_log_dev() may hit a potential NULL dereference. So use NUll instead.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/esas2r/esas2r_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index 7b49e2e9fcde..7d3fa9dac4ce 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -456,7 +456,7 @@ static int esas2r_probe(struct pci_dev *pcid,
 
 		scsi_host_put(host);
 
-		esas2r_log_dev(ESAS2R_LOG_INFO, &(host->shost_gendev),
+		esas2r_log_dev(ESAS2R_LOG_INFO, NULL,
 			       "pci_set_drvdata(%p, NULL) called",
 			       pcid);
 
-- 
2.17.1

