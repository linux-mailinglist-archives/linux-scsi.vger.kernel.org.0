Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF32BA3B6
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Nov 2020 08:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKTHoX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Nov 2020 02:44:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8561 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgKTHoX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 20 Nov 2020 02:44:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcpTD0j64zLrlb;
        Fri, 20 Nov 2020 15:44:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 15:44:12 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] scsi: iscsi: fix inappropriate use of put_device
Date:   Fri, 20 Nov 2020 15:48:52 +0800
Message-ID: <20201120074852.31658-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

kfree(conn) is called inside put_device(&conn->dev) so that
another one would cause use-after-free. Besides, device_unregister
should be used here rather than put_device.

Fixes: f3c893e3dbb5 ("scsi: iscsi: Fail session and connection on transport registration failure")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 2eb3e4f93..2e68c0a87 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2313,7 +2313,9 @@ iscsi_create_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
 	return conn;
 
 release_conn_ref:
-	put_device(&conn->dev);
+	device_unregister(&conn->dev);
+	put_device(&session->dev);
+	return NULL;
 release_parent_ref:
 	put_device(&session->dev);
 free_conn:
-- 
2.23.0

