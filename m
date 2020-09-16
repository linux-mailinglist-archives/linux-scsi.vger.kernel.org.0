Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95F26BCCE
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 08:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIPGWg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Sep 2020 02:22:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbgIPGVC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 16 Sep 2020 02:21:02 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B17F5452E6FFA92E3802;
        Wed, 16 Sep 2020 14:20:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:51 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] scsi: bnx2i: remove unnecessary mutex_init()
Date:   Wed, 16 Sep 2020 14:21:33 +0800
Message-ID: <20200916062133.191000-1-miaoqinglang@huawei.com>
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

The mutex bnx2i_dev_lock is initialized statically. It is
unnecessary to initialize by mutex_init().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/scsi/bnx2i/bnx2i_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/bnx2i/bnx2i_init.c b/drivers/scsi/bnx2i/bnx2i_init.c
index 6018cdd17..2b3f0c104 100644
--- a/drivers/scsi/bnx2i/bnx2i_init.c
+++ b/drivers/scsi/bnx2i/bnx2i_init.c
@@ -474,8 +474,6 @@ static int __init bnx2i_mod_init(void)
 	if (sq_size && !is_power_of_2(sq_size))
 		sq_size = roundup_pow_of_two(sq_size);
 
-	mutex_init(&bnx2i_dev_lock);
-
 	bnx2i_scsi_xport_template =
 			iscsi_register_transport(&bnx2i_iscsi_transport);
 	if (!bnx2i_scsi_xport_template) {
-- 
2.23.0

