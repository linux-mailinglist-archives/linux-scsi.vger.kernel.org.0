Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A899A676
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 06:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfHWECh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Aug 2019 00:02:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfHWECh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Aug 2019 00:02:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE2A86D44B4D10D0A3E1;
        Fri, 23 Aug 2019 12:02:15 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 12:02:07 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] scsi: isci: remove set but not used variable 'index'
Date:   Fri, 23 Aug 2019 12:08:39 +0800
Message-ID: <1566533319-23019-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/isci/host.c: In function sci_controller_complete_io:
drivers/scsi/isci/host.c:2674:6: warning: variable index set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/isci/host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
index 7b5deae..7ebfa3c 100644
--- a/drivers/scsi/isci/host.c
+++ b/drivers/scsi/isci/host.c
@@ -2671,7 +2671,6 @@ enum sci_status sci_controller_complete_io(struct isci_host *ihost,
 					   struct isci_request *ireq)
 {
 	enum sci_status status;
-	u16 index;

 	switch (ihost->sm.current_state_id) {
 	case SCIC_STOPPING:
@@ -2682,7 +2681,6 @@ enum sci_status sci_controller_complete_io(struct isci_host *ihost,
 		if (status != SCI_SUCCESS)
 			return status;

-		index = ISCI_TAG_TCI(ireq->io_tag);
 		clear_bit(IREQ_ACTIVE, &ireq->flags);
 		return SCI_SUCCESS;
 	default:
--
2.7.4

