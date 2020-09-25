Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E528F27804F
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Sep 2020 08:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgIYGID (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Sep 2020 02:08:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727240AbgIYGID (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 25 Sep 2020 02:08:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6D1260DFD6FBC84E4AB;
        Fri, 25 Sep 2020 14:08:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 25 Sep 2020 14:07:51 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <kartilak@cisco.com>, <sebaddel@cisco.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: snic: Remove unnecessary condition to simplify the code
Date:   Fri, 25 Sep 2020 14:07:54 +0800
Message-ID: <20200925060754.156599-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

ret is always zero or an error in this code path. So the assignment to
ret is redundant, and the code jumping to a label is unneed.
Let's remove them to simplify the code. No functional changes.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/snic/snic_scsi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index b3650c989ed4..0c2f31b8ea05 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -1387,10 +1387,6 @@ snic_issue_tm_req(struct snic *snic,
 	}
 
 	ret = snic_queue_itmf_req(snic, tmreq, sc, tmf, req_id);
-	if (ret)
-		goto tmreq_err;
-
-	ret = 0;
 
 tmreq_err:
 	if (ret) {
-- 
2.17.1

