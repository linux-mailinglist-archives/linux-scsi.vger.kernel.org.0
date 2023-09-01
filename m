Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61AD78FB20
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Sep 2023 11:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348930AbjIAJmM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Sep 2023 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348881AbjIAJmF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Sep 2023 05:42:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A975610D7;
        Fri,  1 Sep 2023 02:41:56 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RcXz35PtczQjKk;
        Fri,  1 Sep 2023 17:38:39 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:41:53 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 05/19] scsi: scsi_error: Add helper scsi_eh_sdev_reset to do lun reset
Date:   Fri, 1 Sep 2023 17:41:13 +0800
Message-ID: <20230901094127.2010873-6-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230901094127.2010873-1-haowenchao2@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add helper function scsi_eh_sdev_reset() to perform lun reset and check
if to finish some error commands.

This is preparation for a genernal LUN/target based error handle
strategy and did not change original logic.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 54 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 64eb616261ec..16888540b663 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1635,6 +1635,34 @@ static int scsi_eh_stu(struct Scsi_Host *shost,
 	return list_empty(work_q);
 }
 
+static int scsi_eh_sdev_reset(struct scsi_cmnd *scmd,
+			      struct list_head *work_q,
+			      struct list_head *done_q)
+{
+	struct scsi_cmnd *next;
+	struct scsi_device *sdev = scmd->device;
+	enum scsi_disposition rtn;
+
+	SCSI_LOG_ERROR_RECOVERY(3, sdev_printk(KERN_INFO, sdev,
+			     "%s: Sending BDR\n", current->comm));
+
+	rtn = scsi_try_bus_device_reset(scmd);
+	if (rtn != SUCCESS && rtn != FAST_IO_FAIL) {
+		SCSI_LOG_ERROR_RECOVERY(3,
+			sdev_printk(KERN_INFO, sdev,
+				    "%s: BDR failed\n", current->comm));
+		return 0;
+	}
+
+	if (!scsi_device_online(sdev) || rtn == FAST_IO_FAIL ||
+	    !scsi_eh_tur(scmd))
+		list_for_each_entry_safe(scmd, next, work_q, eh_entry)
+			if (scmd->device == sdev &&
+			    scsi_eh_action(scmd, rtn) != FAILED)
+				scsi_eh_finish_cmd(scmd, done_q);
+
+	return list_empty(work_q);
+}
 
 /**
  * scsi_eh_bus_device_reset - send bdr if needed
@@ -1652,9 +1680,8 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 				    struct list_head *work_q,
 				    struct list_head *done_q)
 {
-	struct scsi_cmnd *scmd, *bdr_scmd, *next;
+	struct scsi_cmnd *scmd, *bdr_scmd;
 	struct scsi_device *sdev;
-	enum scsi_disposition rtn;
 
 	shost_for_each_device(sdev, shost) {
 		if (scsi_host_eh_past_deadline(shost)) {
@@ -1675,26 +1702,9 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 		if (!bdr_scmd)
 			continue;
 
-		SCSI_LOG_ERROR_RECOVERY(3,
-			sdev_printk(KERN_INFO, sdev,
-				     "%s: Sending BDR\n", current->comm));
-		rtn = scsi_try_bus_device_reset(bdr_scmd);
-		if (rtn == SUCCESS || rtn == FAST_IO_FAIL) {
-			if (!scsi_device_online(sdev) ||
-			    rtn == FAST_IO_FAIL ||
-			    !scsi_eh_tur(bdr_scmd)) {
-				list_for_each_entry_safe(scmd, next,
-							 work_q, eh_entry) {
-					if (scmd->device == sdev &&
-					    scsi_eh_action(scmd, rtn) != FAILED)
-						scsi_eh_finish_cmd(scmd,
-								   done_q);
-				}
-			}
-		} else {
-			SCSI_LOG_ERROR_RECOVERY(3,
-				sdev_printk(KERN_INFO, sdev,
-					    "%s: BDR failed\n", current->comm));
+		if (scsi_eh_sdev_reset(bdr_scmd, work_q, done_q)) {
+			scsi_device_put(sdev);
+			break;
 		}
 	}
 
-- 
2.35.3

