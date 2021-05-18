Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237773879B5
	for <lists+linux-scsi@lfdr.de>; Tue, 18 May 2021 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349504AbhERNTX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 May 2021 09:19:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2972 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhERNTX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 May 2021 09:19:23 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkxLr10j8zCv5C;
        Tue, 18 May 2021 21:15:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 21:18:01 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 21:18:01 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <martin.petersen@oracle.com>, <skashyap@marvell.com>
Subject: [PATCH -next] scsi: qedf: use vzalloc() instead of vmalloc()/memset(0)
Date:   Tue, 18 May 2021 21:20:18 +0800
Message-ID: <20210518132018.1312995-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use vzalloc() instead of vmalloc() and memset(0) to simpify
the code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/scsi/qedf/qedf_dbg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
index e0387e495261..0d2aed82882a 100644
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
2.25.1

