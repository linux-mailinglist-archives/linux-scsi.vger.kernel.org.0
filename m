Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175F02E0AE1
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Dec 2020 14:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgLVNeq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Dec 2020 08:34:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9548 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgLVNeq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Dec 2020 08:34:46 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0cjZ2FGvzhrsJ;
        Tue, 22 Dec 2020 21:33:22 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:33:58 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] scsi: bfa: Remove unnecessary memset
Date:   Tue, 22 Dec 2020 21:34:33 +0800
Message-ID: <20201222133433.20023-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

memcpy operation is next to memset code, and the size to copy is equals to the size to
memset, so the memset operation is unnecessary, remove it.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/scsi/bfa/bfa_ioc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index 325ad8a592bb..8d808ca2ec20 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -2748,7 +2748,6 @@ bfa_ioc_get_type(struct bfa_ioc_s *ioc)
 void
 bfa_ioc_get_adapter_serial_num(struct bfa_ioc_s *ioc, char *serial_num)
 {
-	memset((void *)serial_num, 0, BFA_ADAPTER_SERIAL_NUM_LEN);
 	memcpy((void *)serial_num,
 			(void *)ioc->attr->brcd_serialnum,
 			BFA_ADAPTER_SERIAL_NUM_LEN);
-- 
2.22.0

