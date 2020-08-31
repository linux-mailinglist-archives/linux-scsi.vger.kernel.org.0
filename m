Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91F5257519
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Aug 2020 10:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHaIMN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Aug 2020 04:12:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728129AbgHaIML (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 31 Aug 2020 04:12:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 07E9957EC208D680D2AE;
        Mon, 31 Aug 2020 16:12:02 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 31 Aug 2020
 16:11:55 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <yanaijie@huawei.com>, <linux-scsi@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 3/4] scsi: fnic: remove set but not used 'fr_len'
Date:   Mon, 31 Aug 2020 16:11:25 +0800
Message-ID: <20200831081126.3251288-4-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200831081126.3251288-1-yanaijie@huawei.com>
References: <20200831081126.3251288-1-yanaijie@huawei.com>
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

drivers/scsi/fnic/fnic_fcs.c: In function ‘fnic_fcoe_send_vlan_req’:
drivers/scsi/fnic/fnic_fcs.c:379:6: warning: variable ‘fr_len’ set but
not used [-Wunused-but-set-variable]
  379 |  int fr_len;
      |      ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/fnic/fnic_fcs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 894c0d28c534..643622f8e1d9 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -372,7 +372,6 @@ static void fnic_fcoe_send_vlan_req(struct fnic *fnic)
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 	struct sk_buff *skb;
 	char *eth_fr;
-	int fr_len;
 	struct fip_vlan *vlan;
 	u64 vlan_tov;
 
@@ -387,7 +386,6 @@ static void fnic_fcoe_send_vlan_req(struct fnic *fnic)
 	if (!skb)
 		return;
 
-	fr_len = sizeof(*vlan);
 	eth_fr = (char *)skb->data;
 	vlan = (struct fip_vlan *)eth_fr;
 
-- 
2.25.4

