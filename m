Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814BD38D475
	for <lists+linux-scsi@lfdr.de>; Sat, 22 May 2021 10:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEVImO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 22 May 2021 04:42:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3654 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhEVImH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 22 May 2021 04:42:07 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FnH1V47MtzmXpk;
        Sat, 22 May 2021 16:38:22 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 16:40:40 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 22 May 2021 16:40:40 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>, Michael Reed <mdr@sgi.com>
Subject: [PATCH 16/24] scsi: qla1280: remove leading space before tabs
Date:   Sat, 22 May 2021 16:37:20 +0800
Message-ID: <1621672648-39955-17-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621672648-39955-1-git-send-email-tanghui20@huawei.com>
References: <1621672648-39955-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There are a few leading spaces before tabs and remove it by running
the following commard:

    $ find . -name '*.[ch]' | xargs sed -r -i 's/^[ ]+\t/\t/'

Cc: Michael Reed <mdr@sgi.com>
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/scsi/qla1280.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 928da90..54cbfda 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -38,7 +38,7 @@
 	- Initialize completion queue to avoid OOPS on probe
 	- Handle interrupts during mailbox testing
     Rev  3.24 November 17, 2003, Christoph Hellwig
-    	- use struct list_head for completion queue
+	- use struct list_head for completion queue
 	- avoid old Scsi_FOO typedefs
 	- cleanup 2.4 compat glue a bit
 	- use <scsi/scsi_*.h> headers on 2.6 instead of "scsi.h"
@@ -4058,7 +4058,7 @@ qla1280_setup(char *s)
 			val = 0x10000;
 			ptr += 3;
 		} else if (!strcmp(ptr, "no")) {
- 			val = 0;
+			val = 0;
 			ptr += 2;
 		} else
 			val = simple_strtoul(ptr, &ptr, 0);
-- 
2.8.1

