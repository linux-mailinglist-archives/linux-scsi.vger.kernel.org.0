Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA7839A40E
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Jun 2021 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhFCPOd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Jun 2021 11:14:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3532 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhFCPOd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 3 Jun 2021 11:14:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fwq7p112ZzYrBt;
        Thu,  3 Jun 2021 23:09:58 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 23:12:43 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 23:12:43 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
Subject: [PATCH -next resend] scsi: mpi3mr: Fix error return code in mpi3mr_init_ioc()
Date:   Thu, 3 Jun 2021 23:16:53 +0800
Message-ID: <20210603151653.711020-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: fb9b04574f14 ("scsi: mpi3mr: Add support for recovering controller")
Fixes: 824a156633df ("scsi: mpi3mr: Base driver code")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index acb2be62080a..dbf116414855 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3295,6 +3295,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 	}
 	ioc_state = mpi3mr_get_iocstate(mrioc);
 	if (ioc_state != MRIOC_STATE_RESET) {
+		retval = -1;
 		ioc_err(mrioc, "Cannot bring IOC to reset state\n");
 		goto out_failed;
 	}
@@ -3391,6 +3392,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
 
 	if (re_init &&
 	    (mrioc->shost->nr_hw_queues > mrioc->num_op_reply_q)) {
+		retval = -1;
 		ioc_err(mrioc,
 		    "Cannot create minimum number of OpQueues expected:%d created:%d\n",
 		    mrioc->shost->nr_hw_queues, mrioc->num_op_reply_q);
-- 
2.25.1

