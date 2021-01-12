Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0942F2D80
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbhALLI1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 06:08:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbhALLIZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Jan 2021 06:08:25 -0500
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610449662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBWzZ0GcwzebbE/wsjf0JM8q8zjLyexE1+i/CwapnjI=;
        b=npjO/H2DEgIPz5Yn5X0TP6Uid4W4HO/uhbTfg8SJ9CDksABs01WWPblcufrCcifaqxaK8s
        ji4RqGgrJ8n5SrkuVX7e/SP1rcaV4TwC3QJIp+ohSCcAij6wjZO2lAF6wxTuybGdOts71x
        a0x2DVk8Y90HZoyfnSNmVjdbV64C3Ll8d2p4FbRAdtH4atMOlHB4K55cLx2C16g1YQx+sF
        K3Y4V47o8uC8J0B3WuoaUjPiOVfCxEp2jMd5zUShIv2jBO8IcJVtQ4X0lutN+8+uBWpHfc
        GNHFSjiBLHWjuDfD0Y0B0dK2Rn0T8fDkUGU/aaUvB/91Mg9AHZG51HvLlJZPeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610449662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBWzZ0GcwzebbE/wsjf0JM8q8zjLyexE1+i/CwapnjI=;
        b=x1VL7TbDU7UW8de6E785ULMlR+ax1c3sfSTViStiucSseDzRft/GUqHBYaD6O8+9yKQVFB
        89rADHHv5jF0TCCQ==
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Daniel Wagner <dwagner@suse.de>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-scsi@vger.kernel.org, intel-linux-scu@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 11/19] scsi: hisi_sas: Pass gfp_t flags to libsas event notifiers
Date:   Tue, 12 Jan 2021 12:06:39 +0100
Message-Id: <20210112110647.627783-12-a.darwish@linutronix.de>
In-Reply-To: <20210112110647.627783-1-a.darwish@linutronix.de>
References: <20210112110647.627783-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the new libsas event notifiers API, which requires callers to
explicitly pass the gfp_t memory allocation flags.

Below are the context analysis for modified functions:

=> hisi_sas_bytes_dmaed():

Since it is invoked from both process and atomic contexts, let its
callers pass the gfp_t flags:

  * hisi_sas_main.c:
  ------------------

    hisi_sas_phyup_work(): workqueue context
      -> hisi_sas_bytes_dmaed(..., GFP_KERNEL)

    hisi_sas_controller_reset_done(): has an msleep()
      -> hisi_sas_rescan_topology()
        -> hisi_sas_phy_down()
          -> hisi_sas_bytes_dmaed(..., GFP_KERNEL)

    hisi_sas_debug_I_T_nexus_reset(): calls wait_for_completion_timeout()
      -> hisi_sas_phy_down()
        -> hisi_sas_bytes_dmaed(..., GFP_KERNEL)

  * hisi_sas_v1_hw.c:
  -------------------

    int_abnormal_v1_hw(): irq handler
      -> hisi_sas_phy_down()
        -> hisi_sas_bytes_dmaed(..., GFP_ATOMIC)

  * hisi_sas_v[23]_hw.c:
  ----------------------

    int_phy_updown_v[23]_hw(): irq handler
      -> phy_down_v[23]_hw()
        -> hisi_sas_phy_down()
          -> hisi_sas_bytes_dmaed(..., GFP_ATOMIC)

=> int_bcast_v1_hw() and phy_bcast_v3_hw():

Both are invoked exclusively from irq handlers. Pass GFP_ATOMIC.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  3 ++-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 25 ++++++++++++++-----------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  5 +++--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  5 +++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  5 +++--
 5 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index e821dd32dd28..873bfffa626d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -637,7 +637,8 @@ extern void hisi_sas_scan_start(struct Scsi_Host *shost);
 extern int hisi_sas_host_reset(struct Scsi_Host *shost, int reset_type);
 extern void hisi_sas_phy_enable(struct hisi_hba *hisi_hba, int phy_no,
 				int enable);
-extern void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy);
+extern void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy,
+			      gfp_t gfp_flags);
 extern void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba,
 				    struct sas_task *task,
 				    struct hisi_sas_slot *slot);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 76f8fc3fad59..f781b52c6441 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -612,7 +612,8 @@ static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
 	return rc;
 }
 
-static void hisi_sas_bytes_dmaed(struct hisi_hba *hisi_hba, int phy_no)
+static void hisi_sas_bytes_dmaed(struct hisi_hba *hisi_hba, int phy_no,
+				 gfp_t gfp_flags)
 {
 	struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
@@ -626,7 +627,7 @@ static void hisi_sas_bytes_dmaed(struct hisi_hba *hisi_hba, int phy_no)
 		return;
 	}
 
-	sas_notify_phy_event(sas_phy, PHYE_OOB_DONE);
+	sas_notify_phy_event_gfp(sas_phy, PHYE_OOB_DONE, gfp_flags);
 
 	if (sas_phy->phy) {
 		struct sas_phy *sphy = sas_phy->phy;
@@ -654,7 +655,7 @@ static void hisi_sas_bytes_dmaed(struct hisi_hba *hisi_hba, int phy_no)
 	}
 
 	sas_phy->frame_rcvd_size = phy->frame_rcvd_size;
-	sas_notify_port_event(sas_phy, PORTE_BYTES_DMAED);
+	sas_notify_port_event_gfp(sas_phy, PORTE_BYTES_DMAED, gfp_flags);
 }
 
 static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
@@ -860,7 +861,7 @@ static void hisi_sas_phyup_work(struct work_struct *work)
 
 	if (phy->identify.target_port_protocols == SAS_PROTOCOL_SSP)
 		hisi_hba->hw->sl_notify_ssp(hisi_hba, phy_no);
-	hisi_sas_bytes_dmaed(hisi_hba, phy_no);
+	hisi_sas_bytes_dmaed(hisi_hba, phy_no, GFP_KERNEL);
 }
 
 static void hisi_sas_linkreset_work(struct work_struct *work)
@@ -1429,11 +1430,12 @@ static void hisi_sas_rescan_topology(struct hisi_hba *hisi_hba, u32 state)
 				_sas_port = sas_port;
 
 				if (dev_is_expander(dev->dev_type))
-					sas_notify_port_event(sas_phy,
-							PORTE_BROADCAST_RCVD);
+					sas_notify_port_event_gfp(sas_phy,
+							PORTE_BROADCAST_RCVD,
+							GFP_KERNEL);
 			}
 		} else {
-			hisi_sas_phy_down(hisi_hba, phy_no, 0);
+			hisi_sas_phy_down(hisi_hba, phy_no, 0, GFP_KERNEL);
 		}
 	}
 }
@@ -1787,7 +1789,7 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 
 		/* report PHY down if timed out */
 		if (!ret)
-			hisi_sas_phy_down(hisi_hba, sas_phy->id, 0);
+			hisi_sas_phy_down(hisi_hba, sas_phy->id, 0, GFP_KERNEL);
 	} else if (sas_dev->dev_status != HISI_SAS_DEV_INIT) {
 		/*
 		 * If in init state, we rely on caller to wait for link to be
@@ -2187,7 +2189,8 @@ static void hisi_sas_phy_disconnected(struct hisi_sas_phy *phy)
 	spin_unlock_irqrestore(&phy->lock, flags);
 }
 
-void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy)
+void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy,
+		       gfp_t gfp_flags)
 {
 	struct hisi_sas_phy *phy = &hisi_hba->phy[phy_no];
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
@@ -2195,7 +2198,7 @@ void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy)
 
 	if (rdy) {
 		/* Phy down but ready */
-		hisi_sas_bytes_dmaed(hisi_hba, phy_no);
+		hisi_sas_bytes_dmaed(hisi_hba, phy_no, gfp_flags);
 		hisi_sas_port_notify_formed(sas_phy);
 	} else {
 		struct hisi_sas_port *port  = phy->port;
@@ -2206,7 +2209,7 @@ void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy)
 			return;
 		}
 		/* Phy down and not ready */
-		sas_notify_phy_event(sas_phy, PHYE_LOSS_OF_SIGNAL);
+		sas_notify_phy_event_gfp(sas_phy, PHYE_LOSS_OF_SIGNAL, gfp_flags);
 		sas_phy_disconnected(sas_phy);
 
 		if (port) {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 22eecc89d41b..b0a72ffce4f0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1423,7 +1423,7 @@ static irqreturn_t int_bcast_v1_hw(int irq, void *p)
 	}
 
 	if (!test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
-		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD);
+		sas_notify_port_event_gfp(sas_phy, PORTE_BROADCAST_RCVD, GFP_ATOMIC);
 
 end:
 	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT2,
@@ -1452,7 +1452,8 @@ static irqreturn_t int_abnormal_v1_hw(int irq, void *p)
 		u32 phy_state = hisi_sas_read32(hisi_hba, PHY_STATE);
 
 		hisi_sas_phy_down(hisi_hba, phy_no,
-				  (phy_state & 1 << phy_no) ? 1 : 0);
+				  (phy_state & 1 << phy_no) ? 1 : 0,
+				  GFP_ATOMIC);
 	}
 
 	if (irq_value & CHL_INT0_ID_TIMEOUT_MSK)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 10ba0680da04..d8f8fb2ed63b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2734,7 +2734,8 @@ static int phy_down_v2_hw(int phy_no, struct hisi_hba *hisi_hba)
 
 	phy_state = hisi_sas_read32(hisi_hba, PHY_STATE);
 	dev_info(dev, "phydown: phy%d phy_state=0x%x\n", phy_no, phy_state);
-	hisi_sas_phy_down(hisi_hba, phy_no, (phy_state & 1 << phy_no) ? 1 : 0);
+	hisi_sas_phy_down(hisi_hba, phy_no, (phy_state & 1 << phy_no) ? 1 : 0,
+			  GFP_ATOMIC);
 
 	sl_ctrl = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL,
@@ -2824,7 +2825,7 @@ static void phy_bcast_v2_hw(int phy_no, struct hisi_hba *hisi_hba)
 	bcast_status = hisi_sas_phy_read32(hisi_hba, phy_no, RX_PRIMS_STATUS);
 	if ((bcast_status & RX_BCAST_CHG_MSK) &&
 	    !test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
-		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD);
+		sas_notify_port_event_gfp(sas_phy, PORTE_BROADCAST_RCVD, GFP_ATOMIC);
 	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT0,
 			     CHL_INT0_SL_RX_BCST_ACK_MSK);
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_RX_BCAST_CHK_MSK, 0);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 9d9dcc11a866..87392de60e9d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1580,7 +1580,8 @@ static irqreturn_t phy_down_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 
 	phy_state = hisi_sas_read32(hisi_hba, PHY_STATE);
 	dev_info(dev, "phydown: phy%d phy_state=0x%x\n", phy_no, phy_state);
-	hisi_sas_phy_down(hisi_hba, phy_no, (phy_state & 1 << phy_no) ? 1 : 0);
+	hisi_sas_phy_down(hisi_hba, phy_no, (phy_state & 1 << phy_no) ? 1 : 0,
+			  GFP_ATOMIC);
 
 	sl_ctrl = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL,
@@ -1606,7 +1607,7 @@ static irqreturn_t phy_bcast_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	bcast_status = hisi_sas_phy_read32(hisi_hba, phy_no, RX_PRIMS_STATUS);
 	if ((bcast_status & RX_BCAST_CHG_MSK) &&
 	    !test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
-		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD);
+		sas_notify_port_event_gfp(sas_phy, PORTE_BROADCAST_RCVD, GFP_ATOMIC);
 	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT0,
 			     CHL_INT0_SL_RX_BCST_ACK_MSK);
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_RX_BCAST_CHK_MSK, 0);
-- 
2.30.0

