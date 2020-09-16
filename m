Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE926BCCC
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIPGWY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Sep 2020 02:22:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726447AbgIPGVJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 16 Sep 2020 02:21:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6E0EB37061E1FD290D1E;
        Wed, 16 Sep 2020 14:21:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:55 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] scsi: qedf: use vzalloc() instead of vmalloc() and memset(0)
Date:   Wed, 16 Sep 2020 14:21:36 +0800
Message-ID: <20200916062136.191141-1-miaoqinglang@huawei.com>
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

Use vzalloc() instead of vmalloc() and memset(0) to clean the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/scsi/qedf/qedf_dbg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
index e0387e495..0d2aed828 100644
--- a/drivers/scsi/qedf/qedf_dbg.c
+++ b/drivers/scsi/qedf/qedf_dbg.c
@@ -106,11 +106,10 @@ qedf_dbg_info(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 int
 qedf_alloc_grc_dump_buf(u8 **buf, uint32_t len)
 {
-		*buf = vmalloc(len);
+		*buf = vzalloc(len);
 		if (!(*buf))
 			return -ENOMEM;
 
-		memset(*buf, 0, len);
 		return 0;
 }
 
-- 
2.23.0

