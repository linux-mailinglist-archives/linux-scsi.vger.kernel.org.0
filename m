Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9571026A104
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Sep 2020 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIOIi4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 04:38:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgIOIiy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 15 Sep 2020 04:38:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D1F4514BC5690FA0589F;
        Tue, 15 Sep 2020 16:38:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 16:38:42 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: isci: make scu_link_layer_set_txcomsas_timeout() static
Date:   Tue, 15 Sep 2020 16:40:00 +0800
Message-ID: <20200915084000.2826741-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This addresses the following sparse warning:

drivers/scsi/isci/phy.c:672:6: warning: symbol
'scu_link_layer_set_txcomsas_timeout' was not declared. Should it be
static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/isci/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
index 4cacb800b530..7041e2e3ab48 100644
--- a/drivers/scsi/isci/phy.c
+++ b/drivers/scsi/isci/phy.c
@@ -669,7 +669,7 @@ static const char *phy_event_name(u32 event_code)
 		phy_state_name(state), phy_event_name(code), code)
 
 
-void scu_link_layer_set_txcomsas_timeout(struct isci_phy *iphy, u32 timeout)
+static void scu_link_layer_set_txcomsas_timeout(struct isci_phy *iphy, u32 timeout)
 {
 	u32 val;
 
-- 
2.25.4

