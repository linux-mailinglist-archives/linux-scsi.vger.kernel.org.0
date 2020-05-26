Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62841A053E
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Apr 2020 05:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDGDXn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Apr 2020 23:23:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgDGDXn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 Apr 2020 23:23:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 160BCC0CCD409DCE83D6;
        Tue,  7 Apr 2020 11:23:40 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 11:23:33 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 6/7] scsi: bfa: bfad_attr.c: make two funcitons static
Date:   Tue, 7 Apr 2020 11:22:01 +0800
Message-ID: <20200407032202.36789-7-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200407032202.36789-1-yanaijie@huawei.com>
References: <20200407032202.36789-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following sparse warning:

drivers/scsi/bfa/bfad_attr.c:441:1: warning: symbol
'bfad_im_issue_fc_host_lip' was not declared. Should it be static?
drivers/scsi/bfa/bfad_attr.c:566:1: warning: symbol
'bfad_im_vport_set_symbolic_name' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/bfa/bfad_attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_attr.c b/drivers/scsi/bfa/bfad_attr.c
index fbfce02e5b93..5ae1e3f78910 100644
--- a/drivers/scsi/bfa/bfad_attr.c
+++ b/drivers/scsi/bfa/bfad_attr.c
@@ -437,7 +437,7 @@ bfad_im_vport_create(struct fc_vport *fc_vport, bool disable)
 	return status;
 }
 
-int
+static int
 bfad_im_issue_fc_host_lip(struct Scsi_Host *shost)
 {
 	struct bfad_im_port_s *im_port =
@@ -562,7 +562,7 @@ bfad_im_vport_disable(struct fc_vport *fc_vport, bool disable)
 	return 0;
 }
 
-void
+static void
 bfad_im_vport_set_symbolic_name(struct fc_vport *fc_vport)
 {
 	struct bfad_vport_s *vport = (struct bfad_vport_s *)fc_vport->dd_data;
-- 
2.17.2

