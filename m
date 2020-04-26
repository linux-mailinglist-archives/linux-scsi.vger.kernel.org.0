Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881941B8E86
	for <lists+linux-scsi@lfdr.de>; Sun, 26 Apr 2020 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDZJns (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 Apr 2020 05:43:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2911 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgDZJns (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 26 Apr 2020 05:43:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 14C08C1C595CDC8A7D25;
        Sun, 26 Apr 2020 17:43:46 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 17:43:38 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <stanley.chu@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: ufs: use true for bool variables in ufshcd_complete_dev_init()
Date:   Sun, 26 Apr 2020 17:43:05 +0800
Message-ID: <20200426094305.24083-1-yanaijie@huawei.com>
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

Fix the following coccicheck warning:

drivers/scsi/ufs/ufshcd.c:4140:6-14: WARNING: Assignment of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 52990c39bc16..fd1541111cc3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4137,7 +4137,7 @@ static int ufshcd_complete_dev_init(struct ufs_hba *hba)
 {
 	int i;
 	int err;
-	bool flag_res = 1;
+	bool flag_res = true;
 
 	err = ufshcd_query_flag_retry(hba, UPIU_QUERY_OPCODE_SET_FLAG,
 		QUERY_FLAG_IDN_FDEVICEINIT, NULL);
-- 
2.21.1

