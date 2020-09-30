Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA1727DE7D
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 04:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgI3CY2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 22:24:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbgI3CY1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 29 Sep 2020 22:24:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D25C4177412E2E410A3F;
        Wed, 30 Sep 2020 10:24:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 10:24:20 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <linux-scsi@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 3/3] scsi: qla2xxx: Fix inconsistent of format with argument type in qla_dbg.c
Date:   Wed, 30 Sep 2020 10:25:15 +0800
Message-ID: <20200930022515.2862532-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200930022515.2862532-1-yebin10@huawei.com>
References: <20200930022515.2862532-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix follow warning:
[drivers/scsi/qla2xxx/qla_dbg.c:2451]: (warning) %ld in format string (no. 4)
	requires 'long' but the argument type is 'unsigned long'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 1434789c9919..bb7431912d41 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -2448,7 +2448,7 @@ static void ql_dbg_prefix(char *pbuf, int pbuf_size,
 		const struct pci_dev *pdev = vha->hw->pdev;
 
 		/* <module-name> [<dev-name>]-<msg-id>:<host>: */
-		snprintf(pbuf, pbuf_size, "%s [%s]-%04x:%ld: ", QL_MSGHDR,
+		snprintf(pbuf, pbuf_size, "%s [%s]-%04x:%lu: ", QL_MSGHDR,
 			 dev_name(&(pdev->dev)), msg_id, vha->host_no);
 	} else {
 		/* <module-name> [<dev-name>]-<msg-id>: : */
-- 
2.25.4

