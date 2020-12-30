Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89932E76C0
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Dec 2020 08:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgL3HFK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Dec 2020 02:05:10 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55121 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbgL3HFK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 30 Dec 2020 02:05:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UKCfZdo_1609311862;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UKCfZdo_1609311862)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Dec 2020 15:04:27 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, intel-linux-scu@intel.com,
        artur.paszkiewicz@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] isci: style: remove the unneeded variable: "status".
Date:   Wed, 30 Dec 2020 15:04:20 +0800
Message-Id: <1609311860-102820-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The variable 'status' is being initialized with SCI_SUCCESS and never 
update later with a new value. The initialization is redundant and can 
be removed.

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci <abaci@linux.alibaba.com>
---
 drivers/scsi/isci/request.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 6e08179..bee1685 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -2103,8 +2103,6 @@ enum sci_status
 static enum sci_status stp_request_udma_await_tc_event(struct isci_request *ireq,
 						       u32 completion_code)
 {
-	enum sci_status status = SCI_SUCCESS;
-
 	switch (SCU_GET_COMPLETION_TL_STATUS(completion_code)) {
 	case SCU_MAKE_COMPLETION_STATUS(SCU_TASK_DONE_GOOD):
 		ireq->scu_status = SCU_TASK_DONE_GOOD;
@@ -2148,7 +2146,7 @@ static enum sci_status stp_request_udma_await_tc_event(struct isci_request *ireq
 		break;
 	}
 
-	return status;
+	return SCI_SUCCESS;
 }
 
 static enum sci_status atapi_raw_completion(struct isci_request *ireq, u32 completion_code,
-- 
1.8.3.1

