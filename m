Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699592545A9
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Aug 2020 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgH0M76 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Aug 2020 08:59:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10333 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728981AbgH0M7X (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Aug 2020 08:59:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F307EFE4E176E3835862;
        Thu, 27 Aug 2020 20:59:17 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 20:59:11 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: isci: remove set but not used 'index'
Date:   Thu, 27 Aug 2020 20:58:51 +0800
Message-ID: <20200827125851.428071-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/scsi/isci/host.c: In function ‘sci_controller_complete_io’:
drivers/scsi/isci/host.c:2674:6: warning: variable ‘index’ set but not
used [-Wunused-but-set-variable]
 2674 |  u16 index;
      |      ^~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/isci/host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
index 7b5deae68d33..7ebfa3c8cdc7 100644
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
2.25.4

