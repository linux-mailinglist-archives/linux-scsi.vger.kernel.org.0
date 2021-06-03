Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD3439A482
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Jun 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhFCPZa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Jun 2021 11:25:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7096 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhFCPZ3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 3 Jun 2021 11:25:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FwqNS51MqzYpD7;
        Thu,  3 Jun 2021 23:20:56 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 23:23:42 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 23:23:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
Subject: [PATCH -next] scsi: mpi3mr: Fix missing unlock on error
Date:   Thu, 3 Jun 2021 23:28:03 +0800
Message-ID: <20210603152803.717505-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Goto unlock path before return from function
in the error handling case.

Fixes: c9566231cfaf ("scsi: mpi3mr: Create operational request and reply queue pair")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index dbf116414855..8aea1c2ae712 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1583,7 +1583,7 @@ static int mpi3mr_create_op_reply_q(struct mpi3mr_ioc *mrioc, u16 qidx)
 	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
 		retval = -1;
 		ioc_err(mrioc, "CreateRepQ: Init command is in use\n");
-		goto out;
+		goto out_unlock;
 	}
 	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
 	mrioc->init_cmds.is_waiting = 1;
@@ -1692,7 +1692,7 @@ static int mpi3mr_create_op_req_q(struct mpi3mr_ioc *mrioc, u16 idx,
 	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
 		retval = -1;
 		ioc_err(mrioc, "CreateReqQ: Init command is in use\n");
-		goto out;
+		goto out_unlock;
 	}
 	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
 	mrioc->init_cmds.is_waiting = 1;
-- 
2.25.1

