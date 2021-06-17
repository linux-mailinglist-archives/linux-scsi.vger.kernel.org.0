Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55E3AA902
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Jun 2021 04:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFQCk1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Jun 2021 22:40:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7311 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFQCk1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 16 Jun 2021 22:40:27 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G55hC6gltz1BNMk;
        Thu, 17 Jun 2021 10:33:15 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 10:38:17 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] scsi: elx: efct: Fix error handling in efct_hw_init()
Date:   Thu, 17 Jun 2021 02:48:37 +0000
Message-ID: <20210617024837.1023069-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, also fix typo in error message.

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/scsi/elx/efct/efct_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index ce4736c41564..6324683f9e8e 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -1044,8 +1044,8 @@ efct_hw_init(struct efct_hw *hw)
 	 */
 	hw->wq_reqtag_pool = efct_hw_reqtag_pool_alloc(hw);
 	if (!hw->wq_reqtag_pool) {
-		efc_log_err(hw->os, "efct_hw_reqtag_init failed %d\n", rc);
-		return rc;
+		efc_log_err(hw->os, "efct_hw_reqtag_pool_alloc failed\n");
+		return -ENOMEM;
 	}
 
 	rc = efct_hw_setup_io(hw);

