Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF57F1B1D03
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2020 05:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgDUDlT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Apr 2020 23:41:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2813 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgDUDlT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 Apr 2020 23:41:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F2D035F1BC01DD94B4DE;
        Tue, 21 Apr 2020 11:41:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 11:41:10 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <QLogic-Storage-Upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: qla4xxx: remove unneeded semicolon in ql4_os.c
Date:   Tue, 21 Apr 2020 11:40:38 +0800
Message-ID: <20200421034038.28113-1-yanaijie@huawei.com>
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

drivers/scsi/qla4xxx/ql4_os.c:969:3-4: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 5504ab11decc..5dc697ce8b5d 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -966,7 +966,7 @@ static int qla4xxx_set_chap_entry(struct Scsi_Host *shost, void *data, int len)
 				   "%s: No such sysfs attribute\n", __func__);
 			rc = -ENOSYS;
 			goto exit_set_chap;
-		};
+		}
 	}
 
 	if (chap_rec.chap_type == CHAP_TYPE_IN)
-- 
2.21.1

