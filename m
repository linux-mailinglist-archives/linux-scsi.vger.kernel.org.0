Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95847105E79
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Nov 2019 03:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVCK5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Nov 2019 21:10:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfKVCK5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 21 Nov 2019 21:10:57 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A1361C4F7D82AC032453;
        Fri, 22 Nov 2019 10:10:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 22 Nov 2019 10:10:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] scsi: pm80xx: Remove unused including <linux/version.h>
Date:   Fri, 22 Nov 2019 02:09:11 +0000
Message-ID: <20191122020911.33269-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 19601138e889..6402629bcd40 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -37,7 +37,6 @@
  * POSSIBILITY OF SUCH DAMAGES.
  *
  */
- #include <linux/version.h>
  #include <linux/slab.h>
  #include "pm8001_sas.h"
  #include "pm80xx_hwi.h"



