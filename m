Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69E926BA32
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 04:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIPC1v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 22:27:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbgIPC1v (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 15 Sep 2020 22:27:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3ABDBE6E4519D84347FA;
        Wed, 16 Sep 2020 10:27:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:43 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <linux-scsi@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: lpfc: Remove Unneeded variable 'status' in lpfc_fcp_cpu_map_store
Date:   Wed, 16 Sep 2020 10:28:59 +0800
Message-ID: <20200916022859.349089-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes coccicheck warning:
drivers/scsi/lpfc/lpfc_attr.c:5341:5-11: Unneeded variable: "status". Return "- EINVAL" on line 5342

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index ece6c250ebaf..e94eac194676 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5338,8 +5338,7 @@ static ssize_t
 lpfc_fcp_cpu_map_store(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
-	int status = -EINVAL;
-	return status;
+	return -EINVAL;
 }
 
 /*
-- 
2.25.4

