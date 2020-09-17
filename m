Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A657226D140
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Sep 2020 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIQCe3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Sep 2020 22:34:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12807 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgIQCe1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 16 Sep 2020 22:34:27 -0400
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:34:22 EDT
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 570AAE60C77A1D0DC78B;
        Thu, 17 Sep 2020 10:18:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 10:18:47 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <skashyap@marvell.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: qedf: remove redundant assignment to variable 'rc'
Date:   Thu, 17 Sep 2020 10:19:06 +0800
Message-ID: <20200917021906.175933-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This assignment is  meaningless, so remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/qedf/qedf_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index acd9774a9387..c04078283121 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -2159,7 +2159,6 @@ int qedf_initiate_cleanup(struct qedf_ioreq *io_req,
 	/* Sanity check qedf_rport before dereferencing any pointers */
 	if (!test_bit(QEDF_RPORT_SESSION_READY, &fcport->flags)) {
 		QEDF_ERR(NULL, "tgt not offloaded\n");
-		rc = 1;
 		return SUCCESS;
 	}
 
-- 
2.17.1

