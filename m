Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCBC5F0710
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Sep 2022 11:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiI3JDw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Sep 2022 05:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiI3JDu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 30 Sep 2022 05:03:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DDAFEE4E;
        Fri, 30 Sep 2022 02:03:49 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mf45j2ZJvz689Q8;
        Fri, 30 Sep 2022 17:03:37 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:03:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:03:43 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>,
        <yanaijie@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/6] scsi: libsas: Add sas_task_find_rq()
Date:   Fri, 30 Sep 2022 16:56:19 +0800
Message-ID: <1664528184-162714-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

blk-mq already provides a unique tag per request. Some libsas LLDDs - like
hisi_sas - already use this tag as the unique per-IO HW tag.

Add a common function to provide the request associated with a sas_task
for all libsas LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/scsi/libsas.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index f86b56bf7833..f498217961db 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -644,6 +644,24 @@ static inline bool sas_is_internal_abort(struct sas_task *task)
 	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
 }
 
+static inline struct request *sas_task_find_rq(struct sas_task *task)
+{
+	struct scsi_cmnd *scmd;
+
+	if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
+		struct ata_queued_cmd *qc = task->uldd_task;
+
+		scmd = qc ? qc->scsicmd : NULL;
+	} else {
+		scmd = task->uldd_task;
+	}
+
+	if (!scmd)
+		return NULL;
+
+	return scsi_cmd_to_rq(scmd);
+}
+
 struct sas_domain_function_template {
 	/* The class calls these to notify the LLDD of an event. */
 	void (*lldd_port_formed)(struct asd_sas_phy *);
-- 
2.35.3

