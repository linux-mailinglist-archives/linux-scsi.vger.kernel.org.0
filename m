Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C8427DE5F
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgI3COl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 22:14:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729322AbgI3COl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 29 Sep 2020 22:14:41 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02F3FF4909FD708AF7BF;
        Wed, 30 Sep 2020 10:14:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 10:14:29 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <linuxdrivers@attotech.com>, <linux-scsi@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: esas2r: Fix inconsistent of format with argument type
Date:   Wed, 30 Sep 2020 10:15:27 +0800
Message-ID: <20200930021527.2831077-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix follow warnings:
[drivers/scsi/esas2r/esas2r_vda.c:313]: (warning) %u in format string (no. 1)
	requires 'unsigned int' but the argument type is 'signed int'.
[drivers/scsi/esas2r/esas2r_vda.c:313]: (warning) %u in format string (no. 2)
	requires 'unsigned int' but the argument type is 'signed int'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/esas2r/esas2r_vda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_vda.c b/drivers/scsi/esas2r/esas2r_vda.c
index 30028e56df63..e655b87ddb6b 100644
--- a/drivers/scsi/esas2r/esas2r_vda.c
+++ b/drivers/scsi/esas2r/esas2r_vda.c
@@ -310,7 +310,7 @@ static void esas2r_complete_vda_ioctl(struct esas2r_adapter *a,
 				le32_to_cpu(rsp->vda_version);
 			cfg->data.init.fw_build = rsp->fw_build;
 
-			snprintf(buf, sizeof(buf), "%1.1u.%2.2u",
+			snprintf(buf, sizeof(buf), "%1.1d.%2.2d",
 				 (int)LOBYTE(le16_to_cpu(rsp->fw_release)),
 				 (int)HIBYTE(le16_to_cpu(rsp->fw_release)));
 
-- 
2.25.4

