Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8872C5554
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Nov 2020 14:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbgKZNae (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Nov 2020 08:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390052AbgKZNad (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Nov 2020 08:30:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BB5C0617A7
        for <linux-scsi@vger.kernel.org>; Thu, 26 Nov 2020 05:30:32 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606397431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBYalvQNYVNA2galq9HAG+ZzSJ6S7VbYrFShfgOIJ7k=;
        b=zE/KQFnW3QuanfbNtQInVp/I+KzCgOTuiDXvRLcj3yShlmc2yE8/PfD0youvT0qAWDHg5m
        o9AOIE5LJzX2WJaxzW+guSfwVzLStSgS15gM0fuXDqRNHZ6URXAVowI1OaGfGwNPm4NcCQ
        HdHUI4zeZdXAZU3mRfZESOmqAgGPr8xLqDS4ecJxFoKf4vOtz++ZU+ooILLTUo6hj7eclW
        6NmfHuAxQneGzgNvA/T3nsnjt5+dMOVsy++fHzNMccpIX5srU2Nj20BAuihjnMvip/7Dah
        Nu8STX+gMMowT8E+5ISUy/aTzwXmS1LhmxhQdIIQrOFOSgz9v/HUEpL9SecHhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606397431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBYalvQNYVNA2galq9HAG+ZzSJ6S7VbYrFShfgOIJ7k=;
        b=I1lZIBbKN1385hl/hDFtpJGO+IXWN/TFqnIYz3TNWRKc5piVJ6+Lig9SnVQluE8An6Yb0z
        3d65DVjlC+pCaTBA==
To:     linux-scsi@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        John Garry <john.garry@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        Manish Rangankar <mrangankar@marvell.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        Nilesh Javali <njavali@marvell.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Vikram Auradkar <auradkar@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/14] scsi: qla4xxx: qla4_82xx_crb_win_lock(): Remove in_interrupt().
Date:   Thu, 26 Nov 2020 14:29:41 +0100
Message-Id: <20201126132952.2287996-4-bigeasy@linutronix.de>
In-Reply-To: <20201126132952.2287996-1-bigeasy@linutronix.de>
References: <20201126132952.2287996-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

qla4_82xx_crb_win_lock() spins on a certain hardware state until it's
updated. At the end of each spin, if in_interrupt() is true, it does 20
loops of cpu_relax(). Otherwise, it yields the CPU.

The in_interrupt() macro is ill-defined as it does not provide what the
name suggests, and it does not catch the intended use-case here.

qla4_82xx_crb_win_lock() is always invoked with scsi_qla_host::hw_lock
acquired, with disabled interrupts. If the caller is in process context,
as in qla4_82xx_need_reset_handler(), then in_interrupt() will return
false even though it is not allowed to call schedule().

Remove the in_interrupt() check.

Change qla4_82xx_crb_win_lock() specification to a purely atomic
function. Mark it as static, remove its forward declaration, and move it
above its callers. To avoid hammering the PCI bus while spinning, use a
10 micro-second delay instead of cpu_relax().

Fixes: f4f5df23bf72 ("[SCSI] qla4xxx: Added support for ISP82XX")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Nilesh Javali <njavali@marvell.com>
Cc: Manish Rangankar <mrangankar@marvell.com>
Cc: <GR-QLogic-Storage-Upstream@marvell.com>
---
 drivers/scsi/qla4xxx/ql4_glbl.h |  1 -
 drivers/scsi/qla4xxx/ql4_nx.c   | 63 +++++++++++++++------------------
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_glbl.h b/drivers/scsi/qla4xxx/ql4_glb=
l.h
index b8f02210aeb03..ea60057b2e20a 100644
--- a/drivers/scsi/qla4xxx/ql4_glbl.h
+++ b/drivers/scsi/qla4xxx/ql4_glbl.h
@@ -114,7 +114,6 @@ irqreturn_t qla4_82xx_intr_handler(int irq, void *dev_i=
d);
 void qla4_82xx_queue_iocb(struct scsi_qla_host *ha);
 void qla4_82xx_complete_iocb(struct scsi_qla_host *ha);
=20
-int qla4_82xx_crb_win_lock(struct scsi_qla_host *);
 void qla4_82xx_crb_win_unlock(struct scsi_qla_host *);
 int qla4_82xx_pci_get_crb_addr_2M(struct scsi_qla_host *, ulong *);
 void qla4_82xx_wr_32(struct scsi_qla_host *, ulong, u32);
diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
index f1767b21076f7..da903a545b2c0 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.c
+++ b/drivers/scsi/qla4xxx/ql4_nx.c
@@ -375,6 +375,35 @@ qla4_82xx_pci_set_crbwindow_2M(struct scsi_qla_host *h=
a, ulong *off)
 	*off =3D (*off & MASK(16)) + CRB_INDIRECT_2M + ha->nx_pcibase;
 }
=20
+#define CRB_WIN_LOCK_TIMEOUT 100000000
+
+/*
+ * Context: atomic
+ */
+static int qla4_82xx_crb_win_lock(struct scsi_qla_host *ha)
+{
+	int done =3D 0, timeout =3D 0;
+
+	while (!done) {
+		/* acquire semaphore3 from PCI HW block */
+		done =3D qla4_82xx_rd_32(ha, QLA82XX_PCIE_REG(PCIE_SEM7_LOCK));
+		if (done =3D=3D 1)
+			break;
+		if (timeout >=3D CRB_WIN_LOCK_TIMEOUT)
+			return -1;
+
+		timeout++;
+		udelay(10);
+	}
+	qla4_82xx_wr_32(ha, QLA82XX_CRB_WIN_LOCK_ID, ha->func_num);
+	return 0;
+}
+
+void qla4_82xx_crb_win_unlock(struct scsi_qla_host *ha)
+{
+	qla4_82xx_rd_32(ha, QLA82XX_PCIE_REG(PCIE_SEM7_UNLOCK));
+}
+
 void
 qla4_82xx_wr_32(struct scsi_qla_host *ha, ulong off, u32 data)
 {
@@ -475,40 +504,6 @@ int qla4_82xx_md_wr_32(struct scsi_qla_host *ha, uint3=
2_t off, uint32_t data)
 	return rval;
 }
=20
-#define CRB_WIN_LOCK_TIMEOUT 100000000
-
-int qla4_82xx_crb_win_lock(struct scsi_qla_host *ha)
-{
-	int i;
-	int done =3D 0, timeout =3D 0;
-
-	while (!done) {
-		/* acquire semaphore3 from PCI HW block */
-		done =3D qla4_82xx_rd_32(ha, QLA82XX_PCIE_REG(PCIE_SEM7_LOCK));
-		if (done =3D=3D 1)
-			break;
-		if (timeout >=3D CRB_WIN_LOCK_TIMEOUT)
-			return -1;
-
-		timeout++;
-
-		/* Yield CPU */
-		if (!in_interrupt())
-			schedule();
-		else {
-			for (i =3D 0; i < 20; i++)
-				cpu_relax();    /*This a nop instr on i386*/
-		}
-	}
-	qla4_82xx_wr_32(ha, QLA82XX_CRB_WIN_LOCK_ID, ha->func_num);
-	return 0;
-}
-
-void qla4_82xx_crb_win_unlock(struct scsi_qla_host *ha)
-{
-	qla4_82xx_rd_32(ha, QLA82XX_PCIE_REG(PCIE_SEM7_UNLOCK));
-}
-
 #define IDC_LOCK_TIMEOUT 100000000
=20
 /**
--=20
2.29.2

