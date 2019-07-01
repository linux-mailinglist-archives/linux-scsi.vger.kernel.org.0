Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2D746352
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFNPsg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 11:48:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfFNPsg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Jun 2019 11:48:36 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3BF7377BCBC15E276B64;
        Fri, 14 Jun 2019 23:48:31 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 23:48:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <QLogic-Storage-Upstream@cavium.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: qedi: Make some symbols static
Date:   Fri, 14 Jun 2019 23:48:20 +0800
Message-ID: <20190614154820.26744-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix sparse warnings:

drivers/scsi/qedi/qedi_iscsi.c:1541:6: warning:
 symbol 'qedi_get_iscsi_error' was not declared. Should it be static?
drivers/scsi/qedi/qedi_main.c:1806:17: warning:
 symbol 'qedi_get_cmd_from_tid' was not declared. Should it be static?
drivers/scsi/qedi/qedi_main.c:47:6: warning:
 symbol 'qedi_ll2_buf_size' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/qedi/qedi_iscsi.c | 2 +-
 drivers/scsi/qedi/qedi_main.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 8829880..e0bc8c8 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -1535,7 +1535,7 @@ static const struct {
 	},
 };
 
-char *qedi_get_iscsi_error(enum iscsi_error_types err_code)
+static char *qedi_get_iscsi_error(enum iscsi_error_types err_code)
 {
 	int i;
 	char *msg = NULL;
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 1b58e63..4651a20 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -41,7 +41,7 @@ module_param(qedi_io_tracing, uint, 0644);
 MODULE_PARM_DESC(qedi_io_tracing,
 		 " Enable logging of SCSI requests/completions into trace buffer. (default off).");
 
-uint qedi_ll2_buf_size = 0x400;
+static uint qedi_ll2_buf_size = 0x400;
 module_param(qedi_ll2_buf_size, uint, 0644);
 MODULE_PARM_DESC(qedi_ll2_buf_size,
 		 "parameter to set ping packet size, default - 0x400, Jumbo packets - 0x2400.");
@@ -1813,7 +1813,7 @@ void qedi_get_proto_itt(struct qedi_ctx *qedi, u32 tid, u32 *proto_itt)
 		  tid, *proto_itt);
 }
 
-struct qedi_cmd *qedi_get_cmd_from_tid(struct qedi_ctx *qedi, u32 tid)
+static struct qedi_cmd *qedi_get_cmd_from_tid(struct qedi_ctx *qedi, u32 tid)
 {
 	struct qedi_cmd *cmd = NULL;
 
-- 
2.7.4


