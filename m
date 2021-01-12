Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F702F2D8B
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 12:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbhALLI7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 06:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbhALLI6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Jan 2021 06:08:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA844C0617A3;
        Tue, 12 Jan 2021 03:08:17 -0800 (PST)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610449696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSRLR0xMDwTwwbyyyC9ocHLpsatGTsDq9ZmBYoQalws=;
        b=qW+Lul+I3ErWAK/ENsItkjsMjo6esCpFBmvYKAminIBMKvXfOpyetc6N6KOyzJXs2IL6P8
        d5de7Kpuo2lCHtNg4IMaFIEClibCm6EIU+CqGMHVz3PhZlD6Qn1SjW9Se96JMhOjm9pPO+
        gJmgBNwDOziHgn83T6Zg6e97JMUl+PlC7ents1bHQ7zE5UKVp7KVuoozkmM4U3wru/qZSl
        9CXdK1duiJCRUE9a1B4+wuGiUkJ6i0H/BgO8dMXRDhkEfcjR33Nktj0Deqw9nT5Gj59RsS
        HkajBuA/2XK2wdn0kMhMvJfNuesjR/8DF2HNd75mq1+JI7g74yjJ4TkrkadnSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610449696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSRLR0xMDwTwwbyyyC9ocHLpsatGTsDq9ZmBYoQalws=;
        b=aunxO5Iu/H+8AE/DZ+QvUexo60QxKp81FldL6EJZYMjTpjx7/RD3xnfBJk1N/b9sfagrtK
        ml6LGa+KV+Xd+TBg==
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
Subject: [PATCH v2 18/19] scsi: mvsas: Switch back to original libsas event notifiers
Date:   Tue, 12 Jan 2021 12:06:46 +0100
Message-Id: <20210112110647.627783-19-a.darwish@linutronix.de>
In-Reply-To: <20210112110647.627783-1-a.darwish@linutronix.de>
References: <20210112110647.627783-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

libsas event notifiers required an extension where gfp_t flags must be
explicitly passed. For bisectability, a temporary _gfp() variant of such
functions were added. All call sites then got converted use the _gfp()
variants and explicitly pass GFP context. Having no callers left, the
original libsas notifiers were then modified to accept gfp_t flags by
default.

Switch back to the original libas API, while still passing GFP context.
The libsas _gfp() variants will be removed afterwards.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 drivers/scsi/mvsas/mv_sas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index e80f760f8abd..9336e2987879 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -229,7 +229,7 @@ static void mvs_bytes_dmaed(struct mvs_info *mvi, int i, gfp_t gfp_flags)
 		return;
 	}
 
-	sas_notify_phy_event_gfp(sas_phy, PHYE_OOB_DONE, gfp_flags);
+	sas_notify_phy_event(sas_phy, PHYE_OOB_DONE, gfp_flags);
 
 	if (sas_phy->phy) {
 		struct sas_phy *sphy = sas_phy->phy;
@@ -261,7 +261,7 @@ static void mvs_bytes_dmaed(struct mvs_info *mvi, int i, gfp_t gfp_flags)
 
 	sas_phy->frame_rcvd_size = phy->frame_rcvd_size;
 
-	sas_notify_port_event_gfp(sas_phy, PORTE_BYTES_DMAED, gfp_flags);
+	sas_notify_port_event(sas_phy, PORTE_BYTES_DMAED, gfp_flags);
 }
 
 void mvs_scan_start(struct Scsi_Host *shost)
@@ -1892,7 +1892,7 @@ static void mvs_work_queue(struct work_struct *work)
 			if (!(tmp & PHY_READY_MASK)) {
 				sas_phy_disconnected(sas_phy);
 				mvs_phy_disconnected(phy);
-				sas_notify_phy_event_gfp(sas_phy,
+				sas_notify_phy_event(sas_phy,
 					PHYE_LOSS_OF_SIGNAL, GFP_ATOMIC);
 				mv_dprintk("phy%d Removed Device\n", phy_no);
 			} else {
@@ -1905,7 +1905,7 @@ static void mvs_work_queue(struct work_struct *work)
 		}
 	} else if (mwq->handler & EXP_BRCT_CHG) {
 		phy->phy_event &= ~EXP_BRCT_CHG;
-		sas_notify_port_event_gfp(sas_phy, PORTE_BROADCAST_RCVD, GFP_ATOMIC);
+		sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD, GFP_ATOMIC);
 		mv_dprintk("phy%d Got Broadcast Change\n", phy_no);
 	}
 	list_del(&mwq->entry);
-- 
2.30.0

