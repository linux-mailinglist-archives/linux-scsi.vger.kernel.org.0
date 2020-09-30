Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2C27DE7C
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 04:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgI3CY2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 22:24:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729665AbgI3CY1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 29 Sep 2020 22:24:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CA44BC44A70D4C4316F2;
        Wed, 30 Sep 2020 10:24:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 10:24:19 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <linux-scsi@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 2/3] scsi: qla2xxx: Fix inconsistent of format with argument type in qla_os.c
Date:   Wed, 30 Sep 2020 10:25:14 +0800
Message-ID: <20200930022515.2862532-3-yebin10@huawei.com>
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
[drivers/scsi/qla2xxx/qla_os.c:4882]: (warning) %ld in format string (no. 2)
	requires 'long' but the argument type is 'unsigned long'.
[drivers/scsi/qla2xxx/qla_os.c:5011]: (warning) %ld in format string (no. 1)
	requires 'long' but the argument type is 'unsigned long'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 910a6ed0ccc7..473a02603697 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4879,7 +4879,7 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
 
-	sprintf(vha->host_str, "%s_%ld", QLA2XXX_DRIVER_NAME, vha->host_no);
+	sprintf(vha->host_str, "%s_%lu", QLA2XXX_DRIVER_NAME, vha->host_no);
 	ql_dbg(ql_dbg_init, vha, 0x0041,
 	    "Allocated the host=%p hw=%p vha=%p dev_name=%s",
 	    vha->host, vha->hw, vha,
@@ -5008,7 +5008,7 @@ qla2x00_uevent_emit(struct scsi_qla_host *vha, u32 code)
 
 	switch (code) {
 	case QLA_UEVENT_CODE_FW_DUMP:
-		snprintf(event_string, sizeof(event_string), "FW_DUMP=%ld",
+		snprintf(event_string, sizeof(event_string), "FW_DUMP=%lu",
 		    vha->host_no);
 		break;
 	default:
-- 
2.25.4

