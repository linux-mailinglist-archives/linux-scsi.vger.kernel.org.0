Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2CA26311A
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgIIP7Y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Sep 2020 11:59:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730702AbgIIP6z (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:58:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E63D99C6675E0ABF571C;
        Wed,  9 Sep 2020 21:57:20 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:57:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <yuehaibing@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scsi: aic94xx: Remove unused inline function
Date:   Wed, 9 Sep 2020 21:57:11 +0800
Message-ID: <20200909135711.35728-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx.h b/drivers/scsi/aic94xx/aic94xx.h
index c23bbb609126..98978bc199ff 100644
--- a/drivers/scsi/aic94xx/aic94xx.h
+++ b/drivers/scsi/aic94xx/aic94xx.h
@@ -42,14 +42,6 @@
 extern struct kmem_cache *asd_dma_token_cache;
 extern struct kmem_cache *asd_ascb_cache;
 
-static inline void asd_stringify_sas_addr(char *p, const u8 *sas_addr)
-{
-	int i;
-	for (i = 0; i < SAS_ADDR_SIZE; i++, p += 2)
-		snprintf(p, 3, "%02X", sas_addr[i]);
-	*p = '\0';
-}
-
 struct asd_ha_struct;
 struct asd_ascb;
 
-- 
2.17.1


