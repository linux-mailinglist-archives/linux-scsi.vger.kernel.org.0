Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB054956B8
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Aug 2019 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfHTFgt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Aug 2019 01:36:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728957AbfHTFgt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Aug 2019 01:36:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 567314AB32F8CB5D20B5;
        Tue, 20 Aug 2019 13:36:46 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 20 Aug 2019
 13:36:38 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] scsi: fcoe: fix null-ptr-deref Read in fc_release_transport
Date:   Tue, 20 Aug 2019 13:43:09 +0800
Message-ID: <1566279789-58207-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In fcoe_if_init, if fc_attach_transport(&fcoe_vport_fc_functions)
fails, need to free the previously memory and return fail,
otherwise will trigger null-ptr-deref Read in fc_release_transport.

fcoe_exit
  fcoe_if_exit
    fc_release_transport(fcoe_vport_scsi_transport)

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/fcoe/fcoe.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 00dd47b..2f82e56 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1250,15 +1250,21 @@ static int __init fcoe_if_init(void)
 	/* attach to scsi transport */
 	fcoe_nport_scsi_transport =
 		fc_attach_transport(&fcoe_nport_fc_functions);
+	if (!fcoe_nport_scsi_transport)
+		goto err;
+
 	fcoe_vport_scsi_transport =
 		fc_attach_transport(&fcoe_vport_fc_functions);
-
-	if (!fcoe_nport_scsi_transport) {
-		printk(KERN_ERR "fcoe: Failed to attach to the FC transport\n");
-		return -ENODEV;
-	}
+	if (!fcoe_vport_scsi_transport)
+		goto err_vport;

 	return 0;
+
+err_vport:
+	fc_release_transport(fcoe_nport_scsi_transport);
+err:
+	printk(KERN_ERR "fcoe: Failed to attach to the FC transport\n");
+	return -ENODEV;
 }

 /**
--
2.7.4

