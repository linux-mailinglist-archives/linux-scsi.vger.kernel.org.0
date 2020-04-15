Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F541A9646
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2020 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894436AbgDOIYU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Apr 2020 04:24:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894396AbgDOIYR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Apr 2020 04:24:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6B37E7132864A788BC61;
        Wed, 15 Apr 2020 16:24:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 16:24:06 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: qedi: make qedi_ll2_buf_size static
Date:   Wed, 15 Apr 2020 16:50:29 +0800
Message-ID: <20200415085029.7170-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following sparse warning:

drivers/scsi/qedi/qedi_main.c:44:6: warning: symbol 'qedi_ll2_buf_size'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/qedi/qedi_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index b9a5c842a76e..4dd965860c98 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -45,7 +45,7 @@ module_param(qedi_io_tracing, uint, 0644);
 MODULE_PARM_DESC(qedi_io_tracing,
 		 " Enable logging of SCSI requests/completions into trace buffer. (default off).");
 
-uint qedi_ll2_buf_size = 0x400;
+static uint qedi_ll2_buf_size = 0x400;
 module_param(qedi_ll2_buf_size, uint, 0644);
 MODULE_PARM_DESC(qedi_ll2_buf_size,
 		 "parameter to set ping packet size, default - 0x400, Jumbo packets - 0x2400.");
-- 
2.21.1

