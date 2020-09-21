Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC35271CDB
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Sep 2020 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIUICk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 04:02:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbgIUICi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A866F1E292AC08D72B00;
        Mon, 21 Sep 2020 16:02:35 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:27 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] [SCSI] fnic: simplify the return expression of vnic_wq_copy_alloc
Date:   Mon, 21 Sep 2020 16:24:52 +0800
Message-ID: <20200921082452.2592085-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/scsi/fnic/vnic_wq_copy.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/fnic/vnic_wq_copy.c b/drivers/scsi/fnic/vnic_wq_copy.c
index 9eab7e7caf38..7b18635df7e6 100644
--- a/drivers/scsi/fnic/vnic_wq_copy.c
+++ b/drivers/scsi/fnic/vnic_wq_copy.c
@@ -79,8 +79,6 @@ int vnic_wq_copy_alloc(struct vnic_dev *vdev, struct vnic_wq_copy *wq,
 		       unsigned int index, unsigned int desc_count,
 		       unsigned int desc_size)
 {
-	int err;
-
 	wq->index = index;
 	wq->vdev = vdev;
 	wq->to_use_index = wq->to_clean_index = 0;
@@ -92,11 +90,7 @@ int vnic_wq_copy_alloc(struct vnic_dev *vdev, struct vnic_wq_copy *wq,
 
 	vnic_wq_copy_disable(wq);
 
-	err = vnic_dev_alloc_desc_ring(vdev, &wq->ring, desc_count, desc_size);
-	if (err)
-		return err;
-
-	return 0;
+	return vnic_dev_alloc_desc_ring(vdev, &wq->ring, desc_count, desc_size);
 }
 
 void vnic_wq_copy_init(struct vnic_wq_copy *wq, unsigned int cq_index,
-- 
2.25.1

