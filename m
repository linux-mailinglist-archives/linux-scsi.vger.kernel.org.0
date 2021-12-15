Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595AE475ADD
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Dec 2021 15:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbhLOOnV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Dec 2021 09:43:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4292 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbhLOOnS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 Dec 2021 09:43:18 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdCw5gjsz67wfM;
        Wed, 15 Dec 2021 22:38:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 15:43:13 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:43:10 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Qi Liu <liuqi115@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 6/8] scsi: hisi_sas: Prevent parallel FLR and controller reset
Date:   Wed, 15 Dec 2021 22:37:39 +0800
Message-ID: <1639579061-179473-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
References: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

If we issue a controller reset command during executing a FLR a hung task
may be found:

 Call trace:
  __switch_to+0x158/0x1cc
  __schedule+0x2e8/0x85c
  schedule+0x7c/0x110
  schedule_timeout+0x190/0x1cc
  __down+0x7c/0xd4
  down+0x5c/0x7c
  hisi_sas_task_exec+0x510/0x680 [hisi_sas_main]
  hisi_sas_queue_command+0x24/0x30 [hisi_sas_main]
  smp_execute_task_sg+0xf4/0x23c [libsas]
  sas_smp_phy_control+0x110/0x1e0 [libsas]
  transport_sas_phy_reset+0xc8/0x190 [libsas]
  phy_reset_work+0x2c/0x40 [libsas]
  process_one_work+0x1dc/0x48c
  worker_thread+0x15c/0x464
  kthread+0x160/0x170
  ret_from_fork+0x10/0x18

This is a race condition which occurs when the FLR completes first.

Here the host HISI_SAS_RESETTING_BIT flag out gets of sync as
HISI_SAS_RESETTING_BIT is not always cleared with the hisi_hba.sem held,
so now only set/unset HISI_SAS_RESETTING_BIT under hisi_hba.sem .

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 8 +++++---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 977911580d8f..0e14f90dbb1e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1574,7 +1574,6 @@ void hisi_sas_controller_reset_prepare(struct hisi_hba *hisi_hba)
 {
 	struct Scsi_Host *shost = hisi_hba->shost;
 
-	down(&hisi_hba->sem);
 	hisi_hba->phy_state = hisi_hba->hw->get_phys_state(hisi_hba);
 
 	scsi_block_requests(shost);
@@ -1599,9 +1598,9 @@ void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba)
 	if (hisi_hba->reject_stp_links_msk)
 		hisi_sas_terminate_stp_reject(hisi_hba);
 	hisi_sas_reset_init_all_devices(hisi_hba);
-	up(&hisi_hba->sem);
 	scsi_unblock_requests(shost);
 	clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
+	up(&hisi_hba->sem);
 
 	hisi_sas_rescan_topology(hisi_hba, hisi_hba->phy_state);
 }
@@ -1612,8 +1611,11 @@ static int hisi_sas_controller_prereset(struct hisi_hba *hisi_hba)
 	if (!hisi_hba->hw->soft_reset)
 		return -1;
 
-	if (test_and_set_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
+	down(&hisi_hba->sem);
+	if (test_and_set_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags)) {
+		up(&hisi_hba->sem);
 		return -1;
+	}
 
 	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct[0].itct)
 		hisi_hba->hw->debugfs_snapshot_regs(hisi_hba);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0ef6c21bf081..11a44d9dd9b2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4848,6 +4848,7 @@ static void hisi_sas_reset_prepare_v3_hw(struct pci_dev *pdev)
 	int rc;
 
 	dev_info(dev, "FLR prepare\n");
+	down(&hisi_hba->sem);
 	set_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
 	hisi_sas_controller_reset_prepare(hisi_hba);
 
-- 
2.26.2

