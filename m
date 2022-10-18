Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028EC60298E
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Oct 2022 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJRKp4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Oct 2022 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJRKpx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Oct 2022 06:45:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C6B48B6;
        Tue, 18 Oct 2022 03:45:49 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ms9V56fvlz689QP;
        Tue, 18 Oct 2022 18:44:45 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 12:45:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 11:45:44 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 3/7] scsi: hisi_sas: Put reserved tags in lower region of tagset
Date:   Tue, 18 Oct 2022 19:15:59 +0800
Message-ID: <1666091763-11023-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1666091763-11023-1-git-send-email-john.garry@huawei.com>
References: <1666091763-11023-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

To be consistent with blk-mq, put the reserved tags in the lower region of
the tagset. Eventually we hope to get rid of all this reserved tag
management.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 26e474b0f53f..54860d252466 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -183,16 +183,16 @@ static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
 	void *bitmap = hisi_hba->slot_index_tags;
 
 	if (rq)
-		return rq->tag;
+		return rq->tag + HISI_SAS_RESERVED_IPTT;
 
 	spin_lock(&hisi_hba->lock);
-	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
+	index = find_next_zero_bit(bitmap, HISI_SAS_RESERVED_IPTT,
 				   hisi_hba->last_slot_index + 1);
-	if (index >= hisi_hba->slot_index_count) {
+	if (index >= HISI_SAS_RESERVED_IPTT) {
 		index = find_next_zero_bit(bitmap,
-				hisi_hba->slot_index_count,
-				HISI_SAS_UNRESERVED_IPTT);
-		if (index >= hisi_hba->slot_index_count) {
+				HISI_SAS_RESERVED_IPTT,
+				0);
+		if (index >= HISI_SAS_RESERVED_IPTT) {
 			spin_unlock(&hisi_hba->lock);
 			return -SAS_QUEUE_FULL;
 		}
@@ -2216,7 +2216,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 	if (!hisi_hba->sata_breakpoint)
 		goto err_out;
 
-	hisi_hba->last_slot_index = HISI_SAS_UNRESERVED_IPTT;
+	hisi_hba->last_slot_index = 0;
 
 	hisi_hba->wq = create_singlethread_workqueue(dev_name(dev));
 	if (!hisi_hba->wq) {
-- 
2.35.3

