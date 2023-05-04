Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47E56F745C
	for <lists+linux-scsi@lfdr.de>; Thu,  4 May 2023 21:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjEDTua (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 May 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjEDTtw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 May 2023 15:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1CC132B7;
        Thu,  4 May 2023 12:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1AD86378B;
        Thu,  4 May 2023 19:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597B9C433D2;
        Thu,  4 May 2023 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229518;
        bh=Ex+dSI8/PadXncBAPFgE2Ub5ghngxRhMwAEdr5gdSIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+j36t5Sq94T2jWcdx6Aai0tixq7Hc05wj3oOUsz2OwXwYoX7ZH5Ca2ItUZ2aSnFY
         NO7blopTlElnyCm0Atm1NBiFvmKomLfc+3jwlUYWsTHPF6bGdtL+IZ1jDBsiSubzG0
         Fju7ogHOodUf36mglalNT763PlhfdFzikqJkhIUtBGdj8GGsfTwxjYV31ogQGJocIV
         NjPO+RXgFPQayeX9svMb4XNYeihzM127DDVgTDh42U2RHR4PFNBdVR16j3Uu0GGyMz
         I0ZNOID8wrbPegtTCzKKiVpkGSXz9iZFHVIClZkHn8lNguDq2k6wQddZyGuJukbS94
         U1rt/Pj14TkgA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xingui Yang <yangxingui@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 21/53] scsi: hisi_sas: Grab sas_dev lock when traversing the members of sas_dev.list
Date:   Thu,  4 May 2023 15:43:41 -0400
Message-Id: <20230504194413.3806354-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xingui Yang <yangxingui@huawei.com>

[ Upstream commit 71fb36b5ff113a7674710b9d6063241eada84ff7 ]

When freeing slots in function slot_complete_v3_hw(), it is possible that
sas_dev.list is being traversed elsewhere, and it may trigger a NULL
pointer exception, such as follows:

==>cq thread                    ==>scsi_eh_6

                                ==>scsi_error_handler()
				  ==>sas_eh_handle_sas_errors()
				    ==>sas_scsi_find_task()
				      ==>lldd_abort_task()
==>slot_complete_v3_hw()              ==>hisi_sas_abort_task()
  ==>hisi_sas_slot_task_free()	        ==>dereg_device_v3_hw()
    ==>list_del_init()        		  ==>list_for_each_entry_safe()

[ 7165.434918] sas: Enter sas_scsi_recover_host busy: 32 failed: 32
[ 7165.434926] sas: trying to find task 0x00000000769b5ba5
[ 7165.434927] sas: sas_scsi_find_task: aborting task 0x00000000769b5ba5
[ 7165.434940] hisi_sas_v3_hw 0000:b4:02.0: slot complete: task(00000000769b5ba5) aborted
[ 7165.434964] hisi_sas_v3_hw 0000:b4:02.0: slot complete: task(00000000c9f7aa07) ignored
[ 7165.434965] hisi_sas_v3_hw 0000:b4:02.0: slot complete: task(00000000e2a1cf01) ignored
[ 7165.434968] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[ 7165.434972] hisi_sas_v3_hw 0000:b4:02.0: slot complete: task(0000000022d52d93) ignored
[ 7165.434975] hisi_sas_v3_hw 0000:b4:02.0: slot complete: task(0000000066a7516c) ignored
[ 7165.434976] Mem abort info:
[ 7165.434982]   ESR = 0x96000004
[ 7165.434991]   Exception class = DABT (current EL), IL = 32 bits
[ 7165.434992]   SET = 0, FnV = 0
[ 7165.434993]   EA = 0, S1PTW = 0
[ 7165.434994] Data abort info:
[ 7165.434994]   ISV = 0, ISS = 0x00000004
[ 7165.434995]   CM = 0, WnR = 0
[ 7165.434997] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000f29543f2
[ 7165.434998] [0000000000000000] pgd=0000000000000000
[ 7165.435003] Internal error: Oops: 96000004 [#1] SMP
[ 7165.439863] Process scsi_eh_6 (pid: 4109, stack limit = 0x00000000c43818d5)
[ 7165.468862] pstate: 00c00009 (nzcv daif +PAN +UAO)
[ 7165.473637] pc : dereg_device_v3_hw+0x68/0xa8 [hisi_sas_v3_hw]
[ 7165.479443] lr : dereg_device_v3_hw+0x2c/0xa8 [hisi_sas_v3_hw]
[ 7165.485247] sp : ffff00001d623bc0
[ 7165.488546] x29: ffff00001d623bc0 x28: ffffa027d03b9508
[ 7165.493835] x27: ffff80278ed50af0 x26: ffffa027dd31e0a8
[ 7165.499123] x25: ffffa027d9b27f88 x24: ffffa027d9b209f8
[ 7165.504411] x23: ffffa027c45b0d60 x22: ffff80278ec07c00
[ 7165.509700] x21: 0000000000000008 x20: ffffa027d9b209f8
[ 7165.514988] x19: ffffa027d9b27f88 x18: ffffffffffffffff
[ 7165.520276] x17: 0000000000000000 x16: 0000000000000000
[ 7165.525564] x15: ffff0000091d9708 x14: ffff0000093b7dc8
[ 7165.530852] x13: ffff0000093b7a23 x12: 6e7265746e692067
[ 7165.536140] x11: 0000000000000000 x10: 0000000000000bb0
[ 7165.541429] x9 : ffff00001d6238f0 x8 : ffffa027d877af00
[ 7165.546718] x7 : ffffa027d6329600 x6 : ffff7e809f58ca00
[ 7165.552006] x5 : 0000000000001f8a x4 : 000000000000088e
[ 7165.557295] x3 : ffffa027d9b27fa8 x2 : 0000000000000000
[ 7165.562583] x1 : 0000000000000000 x0 : 000000003000188e
[ 7165.567872] Call trace:
[ 7165.570309]  dereg_device_v3_hw+0x68/0xa8 [hisi_sas_v3_hw]
[ 7165.575775]  hisi_sas_abort_task+0x248/0x358 [hisi_sas_main]
[ 7165.581415]  sas_eh_handle_sas_errors+0x258/0x8e0 [libsas]
[ 7165.586876]  sas_scsi_recover_host+0x134/0x458 [libsas]
[ 7165.592082]  scsi_error_handler+0xb4/0x488
[ 7165.596163]  kthread+0x134/0x138
[ 7165.599380]  ret_from_fork+0x10/0x18
[ 7165.602940] Code: d5033e9f b9000040 aa0103e2 eb03003f (f9400021)
[ 7165.609004] kernel fault(0x1) notification starting on CPU 75
[ 7165.700728] ---[ end trace fc042cbbea224efc ]---
[ 7165.705326] Kernel panic - not syncing: Fatal exception

To fix the issue, grab sas_dev lock when traversing the members of
sas_dev.list in dereg_device_v3_hw() and hisi_sas_release_tasks() to avoid
concurrency of adding and deleting member. When function
hisi_sas_release_tasks() calls hisi_sas_do_release_task() to free slot, the
lock cannot be grabbed again in hisi_sas_slot_task_free(), then a bool
parameter need_lock is added.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/1679283265-115066-2-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  3 ++-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 25 ++++++++++++++++---------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  4 +++-
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 6f8a52a1b8087..423af1dc36487 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -653,7 +653,8 @@ extern void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy,
 extern void hisi_sas_phy_bcast(struct hisi_sas_phy *phy);
 extern void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba,
 				    struct sas_task *task,
-				    struct hisi_sas_slot *slot);
+				    struct hisi_sas_slot *slot,
+				    bool need_lock);
 extern void hisi_sas_init_mem(struct hisi_hba *hisi_hba);
 extern void hisi_sas_rst_work_handler(struct work_struct *work);
 extern void hisi_sas_sync_rst_work_handler(struct work_struct *work);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 8c038ccf1c095..2093c1e828177 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -205,7 +205,7 @@ static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
 }
 
 void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
-			     struct hisi_sas_slot *slot)
+			     struct hisi_sas_slot *slot, bool need_lock)
 {
 	int device_id = slot->device_id;
 	struct hisi_sas_device *sas_dev = &hisi_hba->devices[device_id];
@@ -239,9 +239,13 @@ void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
 		}
 	}
 
-	spin_lock(&sas_dev->lock);
-	list_del_init(&slot->entry);
-	spin_unlock(&sas_dev->lock);
+	if (need_lock) {
+		spin_lock(&sas_dev->lock);
+		list_del_init(&slot->entry);
+		spin_unlock(&sas_dev->lock);
+	} else {
+		list_del_init(&slot->entry);
+	}
 
 	memset(slot, 0, offsetof(struct hisi_sas_slot, buf));
 
@@ -1021,7 +1025,7 @@ static void hisi_sas_port_notify_formed(struct asd_sas_phy *sas_phy)
 }
 
 static void hisi_sas_do_release_task(struct hisi_hba *hisi_hba, struct sas_task *task,
-				     struct hisi_sas_slot *slot)
+				     struct hisi_sas_slot *slot, bool need_lock)
 {
 	if (task) {
 		unsigned long flags;
@@ -1038,7 +1042,7 @@ static void hisi_sas_do_release_task(struct hisi_hba *hisi_hba, struct sas_task
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
 	}
 
-	hisi_sas_slot_task_free(hisi_hba, task, slot);
+	hisi_sas_slot_task_free(hisi_hba, task, slot, need_lock);
 }
 
 static void hisi_sas_release_task(struct hisi_hba *hisi_hba,
@@ -1047,8 +1051,11 @@ static void hisi_sas_release_task(struct hisi_hba *hisi_hba,
 	struct hisi_sas_slot *slot, *slot2;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 
+	spin_lock(&sas_dev->lock);
 	list_for_each_entry_safe(slot, slot2, &sas_dev->list, entry)
-		hisi_sas_do_release_task(hisi_hba, slot->task, slot);
+		hisi_sas_do_release_task(hisi_hba, slot->task, slot, false);
+
+	spin_unlock(&sas_dev->lock);
 }
 
 void hisi_sas_release_tasks(struct hisi_hba *hisi_hba)
@@ -1574,7 +1581,7 @@ static int hisi_sas_abort_task(struct sas_task *task)
 		 */
 		if (rc == TMF_RESP_FUNC_COMPLETE && rc2 != TMF_RESP_FUNC_SUCC) {
 			if (task->lldd_task)
-				hisi_sas_do_release_task(hisi_hba, task, slot);
+				hisi_sas_do_release_task(hisi_hba, task, slot, true);
 		}
 	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
 		task->task_proto & SAS_PROTOCOL_STP) {
@@ -1594,7 +1601,7 @@ static int hisi_sas_abort_task(struct sas_task *task)
 			 */
 			if ((sas_dev->dev_status == HISI_SAS_DEV_NCQ_ERR) &&
 			    qc && qc->scsicmd) {
-				hisi_sas_do_release_task(hisi_hba, task, slot);
+				hisi_sas_do_release_task(hisi_hba, task, slot, true);
 				rc = TMF_RESP_FUNC_COMPLETE;
 			} else {
 				rc = hisi_sas_softreset_ata_disk(device);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index d643c5a49aa94..7ea3665996994 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1306,7 +1306,7 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 	}
 
 out:
-	hisi_sas_slot_task_free(hisi_hba, task, slot);
+	hisi_sas_slot_task_free(hisi_hba, task, slot, true);
 
 	if (task->task_done)
 		task->task_done(task);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index cded42f4ca445..ef896ef439705 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2462,7 +2462,7 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 	}
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
-	hisi_sas_slot_task_free(hisi_hba, task, slot);
+	hisi_sas_slot_task_free(hisi_hba, task, slot, true);
 
 	if (!is_internal && (task->task_proto != SAS_PROTOCOL_SMP)) {
 		spin_lock_irqsave(&device->done_lock, flags);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index a63279f55d096..81fe84a8a1508 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -883,6 +883,7 @@ static void dereg_device_v3_hw(struct hisi_hba *hisi_hba,
 
 	cfg_abt_set_query_iptt = hisi_sas_read32(hisi_hba,
 		CFG_ABT_SET_QUERY_IPTT);
+	spin_lock(&sas_dev->lock);
 	list_for_each_entry_safe(slot, slot2, &sas_dev->list, entry) {
 		cfg_abt_set_query_iptt &= ~CFG_SET_ABORTED_IPTT_MSK;
 		cfg_abt_set_query_iptt |= (1 << CFG_SET_ABORTED_EN_OFF) |
@@ -890,6 +891,7 @@ static void dereg_device_v3_hw(struct hisi_hba *hisi_hba,
 		hisi_sas_write32(hisi_hba, CFG_ABT_SET_QUERY_IPTT,
 			cfg_abt_set_query_iptt);
 	}
+	spin_unlock(&sas_dev->lock);
 	cfg_abt_set_query_iptt &= ~(1 << CFG_SET_ABORTED_EN_OFF);
 	hisi_sas_write32(hisi_hba, CFG_ABT_SET_QUERY_IPTT,
 		cfg_abt_set_query_iptt);
@@ -2374,7 +2376,7 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	}
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
-	hisi_sas_slot_task_free(hisi_hba, task, slot);
+	hisi_sas_slot_task_free(hisi_hba, task, slot, true);
 
 	if (!is_internal && (task->task_proto != SAS_PROTOCOL_SMP)) {
 		spin_lock_irqsave(&device->done_lock, flags);
-- 
2.39.2

