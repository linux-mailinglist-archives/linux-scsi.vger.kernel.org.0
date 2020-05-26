Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB01B1D06
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2020 05:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgDUDld (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Apr 2020 23:41:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2419 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728384AbgDUDlc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 Apr 2020 23:41:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3F5AC2FF1769DAD9BECD;
        Tue, 21 Apr 2020 11:41:30 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 11:41:20 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <yanaijie@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: isci: use true,false for bool variables
Date:   Tue, 21 Apr 2020 11:40:50 +0800
Message-ID: <20200421034050.28193-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/isci/isci.h:515:1-12: WARNING: Assignment of 0/1 to bool
variable
drivers/scsi/isci/isci.h:503:1-12: WARNING: Assignment of 0/1 to bool
variable
drivers/scsi/isci/isci.h:509:1-12: WARNING: Assignment of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/isci/isci.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/isci/isci.h b/drivers/scsi/isci/isci.h
index 680e30947671..4e6b1decbca7 100644
--- a/drivers/scsi/isci/isci.h
+++ b/drivers/scsi/isci/isci.h
@@ -500,19 +500,19 @@ struct sci_timer {
 static inline
 void sci_init_timer(struct sci_timer *tmr, void (*fn)(struct timer_list *t))
 {
-	tmr->cancel = 0;
+	tmr->cancel = false;
 	timer_setup(&tmr->timer, fn, 0);
 }
 
 static inline void sci_mod_timer(struct sci_timer *tmr, unsigned long msec)
 {
-	tmr->cancel = 0;
+	tmr->cancel = false;
 	mod_timer(&tmr->timer, jiffies + msecs_to_jiffies(msec));
 }
 
 static inline void sci_del_timer(struct sci_timer *tmr)
 {
-	tmr->cancel = 1;
+	tmr->cancel = true;
 	del_timer(&tmr->timer);
 }
 
-- 
2.21.1

