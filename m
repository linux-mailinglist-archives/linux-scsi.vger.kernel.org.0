Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ADB27DE6D
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 04:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgI3CVj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 22:21:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbgI3CVj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 29 Sep 2020 22:21:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BFABEFEDE23BB8A9F0FF;
        Wed, 30 Sep 2020 10:21:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 10:21:30 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <njavali@marvell.com>, <mrangankar@marvell.com>,
        <linux-scsi@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: qla4xxx: Fix Fix inconsistent of format with argument type in ql4_nx.c
Date:   Wed, 30 Sep 2020 10:22:28 +0800
Message-ID: <20200930022228.2840587-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix follow warning:
[drivers/scsi/qla4xxx/ql4_nx.c:3228]: (warning) %ld in format string (no. 1)
	requires 'long' but the argument type is 'unsigned long'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/qla4xxx/ql4_nx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
index fd3aabb6a190..f1767b21076f 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.c
+++ b/drivers/scsi/qla4xxx/ql4_nx.c
@@ -3225,7 +3225,7 @@ static void qla4_8xxx_uevent_emit(struct scsi_qla_host *ha, u32 code)
 
 	switch (code) {
 	case QL4_UEVENT_CODE_FW_DUMP:
-		snprintf(event_string, sizeof(event_string), "FW_DUMP=%ld",
+		snprintf(event_string, sizeof(event_string), "FW_DUMP=%lu",
 			 ha->host_no);
 		break;
 	default:
-- 
2.25.4

