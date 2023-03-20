Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B96C0929
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Mar 2023 04:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCTDD6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 Mar 2023 23:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCTDDw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 19 Mar 2023 23:03:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C25B76F
        for <linux-scsi@vger.kernel.org>; Sun, 19 Mar 2023 20:03:48 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pg01C2J6mz9v3c;
        Mon, 20 Mar 2023 11:03:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 11:03:46 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        Yihang Li <liyihang9@huawei.com>,
        Xiang Chen <chenxiang66@hislicon.com>
Subject: [PATCH 4/4] scsi: hisi_sas: Exit suspending state when usage count is greater than 0
Date:   Mon, 20 Mar 2023 11:34:25 +0800
Message-ID: <1679283265-115066-5-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1679283265-115066-1-git-send-email-chenxiang66@hisilicon.com>
References: <1679283265-115066-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Yihang Li <liyihang9@huawei.com>

When the current status of the host controller is suspended, enabling a
local PHY just after disabling all local PHYs in expander envirnment,
a hung as follows occurs.

[  486.854655] INFO: task kworker/u256:1:899 blocked for more than 120 seconds.
[  486.862207]       Not tainted 6.1.0-rc4+ #1
[  486.870545] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  486.878893] task:kworker/u256:1  state:D stack:0     pid:899   ppid:2      flags:0x00000008
[  486.887745] Workqueue: 0000:74:02.0_disco_q sas_discover_domain [libsas]
[  486.894704] Call trace:
[  486.897400]  __switch_to+0xf0/0x170
[  486.901146]  __schedule+0x3e4/0x1160
[  486.904970]  schedule+0x64/0x104
[  486.908442]  rpm_resume+0x158/0x6a0
[  486.912163]  __pm_runtime_resume+0x5c/0x84
[  486.916489]  smp_execute_task_sg+0x1f8/0x264 [libsas]
[  486.921773]  sas_discover_expander.part.0+0xbc/0x720 [libsas]
[  486.927750]  sas_discover_root_expander+0x90/0x154 [libsas]
[  486.933552]  sas_discover_domain+0x444/0x6d0 [libsas]
[  486.938826]  process_one_work+0x1e0/0x450
[  486.943057]  worker_thread+0x150/0x44c
[  486.947015]  kthread+0x114/0x120
[  486.950447]  ret_from_fork+0x10/0x20
[  486.954292] INFO: task kworker/u256:2:1780 blocked for more than 120 seconds.
[  486.961637]       Not tainted 6.1.0-rc4+ #1
[  486.966087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  486.974356] task:kworker/u256:2  state:D stack:0     pid:1780  ppid:2      flags:0x00000208
[  486.983141] Workqueue: 0000:74:02.0_event_q sas_port_event_worker [libsas]
[  486.990252] Call trace:
[  486.992930]  __switch_to+0xf0/0x170
[  486.996645]  __schedule+0x3e4/0x1160
[  487.000439]  schedule+0x64/0x104
[  487.003886]  schedule_timeout+0x17c/0x1c0
[  487.008102]  wait_for_completion+0x7c/0x160
[  487.012488]  __flush_workqueue+0x104/0x3e0
[  487.016782]  sas_porte_bytes_dmaed+0x414/0x454 [libsas]
[  487.022203]  sas_port_event_worker+0x38/0x60 [libsas]
[  487.027449]  process_one_work+0x1e0/0x450
[  487.031645]  worker_thread+0x150/0x44c
[  487.035594]  kthread+0x114/0x120
[  487.039017]  ret_from_fork+0x10/0x20
[  487.042828] INFO: task bash:11488 blocked for more than 121 seconds.
[  487.049366]       Not tainted 6.1.0-rc4+ #1
[  487.053746] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  487.061953] task:bash            state:D stack:0     pid:11488 ppid:10977  flags:0x00000204
[  487.070698] Call trace:
[  487.073355]  __switch_to+0xf0/0x170
[  487.077050]  __schedule+0x3e4/0x1160
[  487.080833]  schedule+0x64/0x104
[  487.084270]  schedule_timeout+0x17c/0x1c0
[  487.088474]  wait_for_completion+0x7c/0x160
[  487.092851]  __flush_workqueue+0x104/0x3e0
[  487.097137]  drain_workqueue+0xb8/0x160
[  487.101159]  __sas_drain_work+0x50/0x90 [libsas]
[  487.105963]  sas_suspend_ha+0x64/0xd4 [libsas]
[  487.110590]  suspend_v3_hw+0x198/0x1e8 [hisi_sas_v3_hw]
[  487.115989]  pci_pm_runtime_suspend+0x5c/0x1d0
[  487.120606]  __rpm_callback+0x50/0x150
[  487.124535]  rpm_callback+0x74/0x80
[  487.128204]  rpm_suspend+0x110/0x640
[  487.131955]  rpm_idle+0x1f4/0x2d0
[  487.135447]  __pm_runtime_idle+0x58/0x94
[  487.139538]  queue_phy_enable+0xcc/0xf0 [libsas]
[  487.144330]  store_sas_phy_enable+0x74/0x100
[  487.148770]  dev_attr_store+0x20/0x34
[  487.152606]  sysfs_kf_write+0x4c/0x5c
[  487.156437]  kernfs_fop_write_iter+0x120/0x1b0
[  487.161049]  vfs_write+0x2d0/0x36c
[  487.164625]  ksys_write+0x70/0x100
[  487.168194]  __arm64_sys_write+0x24/0x30
[  487.172280]  invoke_syscall+0x50/0x120
[  487.176186]  el0_svc_common.constprop.0+0x168/0x190
[  487.181214]  do_el0_svc+0x34/0xc0
[  487.184680]  el0_svc+0x2c/0xb4
[  487.187879]  el0t_64_sync_handler+0xb8/0xbc
[  487.192205]  el0t_64_sync+0x19c/0x1a0

We find that when all local PHYs are disabled, all the devices will be
removed, the ->runtime_suspend() callback suspend_v3_hw() directly execute
since the controller usage count drop to 0. On the other side, the first
local PHY is enabled through the sysfs interface, and ensures that
function phy_up_v3_hw() is completed due to suspend_v3_hw()->
interrupt_disable_v3_hw(). In the expander scenario,
sas_discover_root_expander() is executed in event work
DISCE_DISCOVER_DOMAIN, which will increases the controller usage count and
carry out a resume and sends SMPIO, it cannot be completed because the
runtime PM status of the controller is RPM_SUSPENDING. At the same time,
the ->runtime_suspend() callback suspend_v3_hw() also cannot complete the
process because of drain libsas event queue in sas_suspend_ha(), so hung
occurs.

           (thread 1)                   |        (thread 2)
...                                     |
rpm_idle()                              |
 ...                                    |
 __update_runtime_status(RPM_SUSPENDING)|
  ...                                   | ...
  suspend_v3_hw()                       | smp_execute_task_sg()
   ...                                  |  ...
   interrupt_disable_v3_hw()            |  pm_runtime_get_sync()
                                        |   ...
   ...                                  |   rpm_resume() //RPM_SUSPENDING
                                        |
    __sas_drain_work()                  |

To fix it, check if the current runtime PM status of the controller allows
to be suspended continue after interrupt_disable_v3_hw(), return
immediately if not.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hislicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 73 ++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 791c0eab..592170a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -604,6 +604,27 @@ static u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
 	readl_poll_timeout_atomic(regs, val, cond, delay_us, timeout_us);\
 })
 
+static void interrupt_enable_v3_hw(struct hisi_hba *hisi_hba)
+{
+	int i;
+
+	for (i = 0; i < hisi_hba->queue_count; i++)
+		hisi_sas_write32(hisi_hba, OQ0_INT_SRC_MSK + 0x4 * i, 0);
+
+	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK1, 0xfefefefe);
+	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK2, 0xfefefefe);
+	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK3, 0xffc220ff);
+	hisi_sas_write32(hisi_hba, SAS_ECC_INTR_MSK, 0x155555);
+
+	for (i = 0; i < hisi_hba->n_phy; i++) {
+		hisi_sas_phy_write32(hisi_hba, i, CHL_INT1_MSK, 0xf2057fff);
+		hisi_sas_phy_write32(hisi_hba, i, CHL_INT2_MSK, 0xffffbfe);
+		hisi_sas_phy_write32(hisi_hba, i, PHYCTRL_NOT_RDY_MSK, 0x0);
+		hisi_sas_phy_write32(hisi_hba, i, PHYCTRL_PHY_ENA_MSK, 0x0);
+		hisi_sas_phy_write32(hisi_hba, i, SL_RX_BCAST_CHK_MSK, 0x0);
+	}
+}
+
 static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 {
 	int i, j;
@@ -624,20 +645,14 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_sas_write32(hisi_hba, ENT_INT_SRC1, 0xffffffff);
 	hisi_sas_write32(hisi_hba, ENT_INT_SRC2, 0xffffffff);
 	hisi_sas_write32(hisi_hba, ENT_INT_SRC3, 0xffffffff);
-	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK1, 0xfefefefe);
-	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK2, 0xfefefefe);
-	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK3, 0xffc220ff);
 	hisi_sas_write32(hisi_hba, CHNL_PHYUPDOWN_INT_MSK, 0x0);
 	hisi_sas_write32(hisi_hba, CHNL_ENT_INT_MSK, 0x0);
 	hisi_sas_write32(hisi_hba, HGC_COM_INT_MSK, 0x0);
-	hisi_sas_write32(hisi_hba, SAS_ECC_INTR_MSK, 0x155555);
 	hisi_sas_write32(hisi_hba, AWQOS_AWCACHE_CFG, 0xf0f0);
 	hisi_sas_write32(hisi_hba, ARQOS_ARCACHE_CFG, 0xf0f0);
-	for (i = 0; i < hisi_hba->queue_count; i++)
-		hisi_sas_write32(hisi_hba, OQ0_INT_SRC_MSK + 0x4 * i, 0);
-
 	hisi_sas_write32(hisi_hba, HYPER_STREAM_ID_EN_CFG, 1);
 
+	interrupt_enable_v3_hw(hisi_hba);
 	for (i = 0; i < hisi_hba->n_phy; i++) {
 		enum sas_linkrate max;
 		struct hisi_sas_phy *phy = &hisi_hba->phy[i];
@@ -660,13 +675,8 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 		hisi_sas_phy_write32(hisi_hba, i, CHL_INT1, 0xffffffff);
 		hisi_sas_phy_write32(hisi_hba, i, CHL_INT2, 0xffffffff);
 		hisi_sas_phy_write32(hisi_hba, i, RXOP_CHECK_CFG_H, 0x1000);
-		hisi_sas_phy_write32(hisi_hba, i, CHL_INT1_MSK, 0xf2057fff);
-		hisi_sas_phy_write32(hisi_hba, i, CHL_INT2_MSK, 0xffffbfe);
 		hisi_sas_phy_write32(hisi_hba, i, PHY_CTRL_RDY_MSK, 0x0);
-		hisi_sas_phy_write32(hisi_hba, i, PHYCTRL_NOT_RDY_MSK, 0x0);
 		hisi_sas_phy_write32(hisi_hba, i, PHYCTRL_DWS_RESET_MSK, 0x0);
-		hisi_sas_phy_write32(hisi_hba, i, PHYCTRL_PHY_ENA_MSK, 0x0);
-		hisi_sas_phy_write32(hisi_hba, i, SL_RX_BCAST_CHK_MSK, 0x0);
 		hisi_sas_phy_write32(hisi_hba, i, PHYCTRL_OOB_RESTART_MSK, 0x1);
 		hisi_sas_phy_write32(hisi_hba, i, STP_LINK_TIMER, 0x7f7a120);
 		hisi_sas_phy_write32(hisi_hba, i, CON_CFG_DRIVER, 0x2a0a01);
@@ -2661,7 +2671,6 @@ static int disable_host_v3_hw(struct hisi_hba *hisi_hba)
 	u32 status, reg_val;
 	int rc;
 
-	interrupt_disable_v3_hw(hisi_hba);
 	hisi_sas_sync_poll_cqs(hisi_hba);
 	hisi_sas_write32(hisi_hba, DLVRY_QUEUE_ENABLE, 0x0);
 
@@ -2692,6 +2701,7 @@ static int soft_reset_v3_hw(struct hisi_hba *hisi_hba)
 	struct device *dev = hisi_hba->dev;
 	int rc;
 
+	interrupt_disable_v3_hw(hisi_hba);
 	rc = disable_host_v3_hw(hisi_hba);
 	if (rc) {
 		dev_err(dev, "soft reset: disable host failed rc=%d\n", rc);
@@ -5060,6 +5070,7 @@ static void hisi_sas_reset_prepare_v3_hw(struct pci_dev *pdev)
 	set_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
 	hisi_sas_controller_reset_prepare(hisi_hba);
 
+	interrupt_disable_v3_hw(hisi_hba);
 	rc = disable_host_v3_hw(hisi_hba);
 	if (rc)
 		dev_err(dev, "FLR: disable host failed rc=%d\n", rc);
@@ -5089,6 +5100,21 @@ enum {
 	hip08,
 };
 
+static void enable_host_v3_hw(struct hisi_hba *hisi_hba)
+{
+	u32 reg_val;
+
+	hisi_sas_write32(hisi_hba, DLVRY_QUEUE_ENABLE,
+			 (u32)((1ULL << hisi_hba->queue_count) - 1));
+
+	phys_init_v3_hw(hisi_hba);
+	reg_val = hisi_sas_read32(hisi_hba, AXI_MASTER_CFG_BASE +
+				  AM_CTRL_GLOBAL);
+	reg_val &= ~AM_CTRL_SHUTDOWN_REQ_MSK;
+	hisi_sas_write32(hisi_hba, AXI_MASTER_CFG_BASE +
+			 AM_CTRL_GLOBAL, reg_val);
+}
+
 static int _suspend_v3_hw(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
@@ -5111,14 +5137,18 @@ static int _suspend_v3_hw(struct device *device)
 	scsi_block_requests(shost);
 	set_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 	flush_workqueue(hisi_hba->wq);
+	interrupt_disable_v3_hw(hisi_hba);
+
+	if (atomic_read(&device->power.usage_count)) {
+		dev_err(dev, "PM suspend: host status cannot be suspended\n");
+		rc = -EBUSY;
+		goto err_out;
+	}
 
 	rc = disable_host_v3_hw(hisi_hba);
 	if (rc) {
 		dev_err(dev, "PM suspend: disable host failed rc=%d\n", rc);
-		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
-		clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
-		scsi_unblock_requests(shost);
-		return rc;
+		goto err_out_recover_host;
 	}
 
 	hisi_sas_init_mem(hisi_hba);
@@ -5129,6 +5159,15 @@ static int _suspend_v3_hw(struct device *device)
 
 	dev_warn(dev, "end of suspending controller\n");
 	return 0;
+
+err_out_recover_host:
+	enable_host_v3_hw(hisi_hba);
+err_out:
+	interrupt_enable_v3_hw(hisi_hba);
+	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
+	clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
+	scsi_unblock_requests(shost);
+	return rc;
 }
 
 static int _resume_v3_hw(struct device *device)
-- 
2.8.1

