Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78116271CEC
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Sep 2020 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIUIDD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 04:03:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbgIUICm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EAC8F36642FD99D8F596;
        Mon, 21 Sep 2020 16:02:39 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:30 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] snic: simplify the return expression of svnic_cq_alloc
Date:   Mon, 21 Sep 2020 16:24:55 +0800
Message-ID: <20200921082455.2592190-1-liushixin2@huawei.com>
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
 drivers/scsi/snic/vnic_cq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/snic/vnic_cq.c b/drivers/scsi/snic/vnic_cq.c
index 4c8e64e4fba6..3455dd7e73f4 100644
--- a/drivers/scsi/snic/vnic_cq.c
+++ b/drivers/scsi/snic/vnic_cq.c
@@ -31,8 +31,6 @@ void svnic_cq_free(struct vnic_cq *cq)
 int svnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq,
 	unsigned int index, unsigned int desc_count, unsigned int desc_size)
 {
-	int err;
-
 	cq->index = index;
 	cq->vdev = vdev;
 
@@ -43,11 +41,7 @@ int svnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq,
 		return -EINVAL;
 	}
 
-	err = svnic_dev_alloc_desc_ring(vdev, &cq->ring, desc_count, desc_size);
-	if (err)
-		return err;
-
-	return 0;
+	return svnic_dev_alloc_desc_ring(vdev, &cq->ring, desc_count, desc_size);
 }
 
 void svnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
-- 
2.25.1

