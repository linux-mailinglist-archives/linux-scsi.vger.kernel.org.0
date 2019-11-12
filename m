Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0EF8BEA
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Nov 2019 10:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKLJe1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Nov 2019 04:34:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbfKLJe0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Nov 2019 04:34:26 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CAD395C1204561B52913;
        Tue, 12 Nov 2019 17:34:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 17:34:19 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/4] scsi: hisi_sas: Stop converting a bool into a bool
Date:   Tue, 12 Nov 2019 17:30:59 +0800
Message-ID: <1573551059-107873-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573551059-107873-1-git-send-email-john.garry@huawei.com>
References: <1573551059-107873-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The !! operator on a bool is pointless, so remove an example in
hisi_sas_rescan_topology().

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index c72fc59353bd..03588ec3c394 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1413,7 +1413,7 @@ static void hisi_sas_rescan_topology(struct hisi_hba *hisi_hba, u32 state)
 		struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
 		struct asd_sas_phy *sas_phy = &phy->sas_phy;
 		struct asd_sas_port *sas_port = sas_phy->port;
-		bool do_port_check = !!(_sas_port != sas_port);
+		bool do_port_check = _sas_port != sas_port;
 
 		if (!sas_phy->phy->enabled)
 			continue;
-- 
2.17.1

