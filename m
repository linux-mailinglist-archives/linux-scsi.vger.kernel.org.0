Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8381043F81D
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Oct 2021 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhJ2HwE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 Oct 2021 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhJ2Hve (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 29 Oct 2021 03:51:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E54C061714
        for <linux-scsi@vger.kernel.org>; Fri, 29 Oct 2021 00:49:05 -0700 (PDT)
Date:   Fri, 29 Oct 2021 09:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635493743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kCVfujiMtegohQ4S2Q7Fjd13bEy/EhAeULXGF6dl6Sk=;
        b=rvJUPUe6khMcVhuc+36acMqXExETUDQEVEiY2FNndrxKWAK1eUp6PNm6HDmU/fvqBluPIO
        JkNFTHKRmizAEUZpmBl0tJosKaOX4VjxX/g8VD0PGOcxrEI5yT4a6FOSkUNDdAju8V4RoD
        JLdze3nFD1Zcd8BE0zwCY3s2moZ6D4Ldjnmzkjyqhe+Ty9+VxOs5ifS//tBSeveB6JmJHS
        8TEGeP9vvQKrbGmgX0k2zeE4DL9IWBtFSOAM6B8/cJBxdjrDvAtWvuGJhue+3lZkECEmLq
        zzYECwoze6yM0Rwy8aN81ADOZdtsQWYKcTyrhMlRHrp1c/bKO4Xh1Luo5tfpwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635493743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kCVfujiMtegohQ4S2Q7Fjd13bEy/EhAeULXGF6dl6Sk=;
        b=F6YWFwAXTBi8V4PDau0zgJefFsxs4kEeGqRZfNkzf1O6XxiNLB/Fdt3XUZhwpVSS7qmdBh
        mmErKKyzZV2XTeBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-scsi@vger.kernel.org,
        Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] scsi: be2iscsi: Replace irq_poll with threaded IRQ
 handler.
Message-ID: <20211029074902.4fayed6mcltifgdz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver is using irq_poll() (a NAPI like generic interface) for
completing individual I/O requests.
This could be replaced with threaded interrupts. The threaded interrupt
runs as a RT thread with priority 50-FIFO. It should run as the first
task after the interrupt unless a task with higher priority is active.
It can be interrupt by another hardware interrupt or a softirq.

This has been compile tested only. I'm interested if it causes any
regressions, improves the situation or neither.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1=E2=80=A6v2:
  - Properly initialize variables in be_isr_misx_th() as reported by the
    bot.

  - Drop jitendra.bhivare@broadcom.com and
    subbu.seetharaman@broadcom.com from Cc:, the email bounces.

 drivers/scsi/be2iscsi/Kconfig    |   1 -
 drivers/scsi/be2iscsi/be.h       |   3 +-
 drivers/scsi/be2iscsi/be_iscsi.c |   8 +-
 drivers/scsi/be2iscsi/be_main.c  | 146 ++++++++++++++-----------------
 drivers/scsi/be2iscsi/be_main.h  |   2 +-
 5 files changed, 75 insertions(+), 85 deletions(-)

diff --git a/drivers/scsi/be2iscsi/Kconfig b/drivers/scsi/be2iscsi/Kconfig
index 958c9b46ec787..0118b2a765caf 100644
--- a/drivers/scsi/be2iscsi/Kconfig
+++ b/drivers/scsi/be2iscsi/Kconfig
@@ -4,7 +4,6 @@ config BE2ISCSI
 	depends on PCI && SCSI && NET
 	select SCSI_ISCSI_ATTRS
 	select ISCSI_BOOT_SYSFS
-	select IRQ_POLL
=20
 	help
 	This driver implements the iSCSI functionality for Emulex
diff --git a/drivers/scsi/be2iscsi/be.h b/drivers/scsi/be2iscsi/be.h
index 4c58a02590c7b..8623886810310 100644
--- a/drivers/scsi/be2iscsi/be.h
+++ b/drivers/scsi/be2iscsi/be.h
@@ -12,7 +12,7 @@
=20
 #include <linux/pci.h>
 #include <linux/if_vlan.h>
-#include <linux/irq_poll.h>
+
 #define FW_VER_LEN	32
 #define MCC_Q_LEN	128
 #define MCC_CQ_LEN	256
@@ -90,7 +90,6 @@ struct be_eq_obj {
 	struct beiscsi_hba *phba;
 	struct be_queue_info *cq;
 	struct work_struct mcc_work; /* Work Item */
-	struct irq_poll	iopoll;
 };
=20
 struct be_mcc_obj {
diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_is=
csi.c
index 8aeaddc93b167..e15d5c7ef611e 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -1224,15 +1224,17 @@ static void beiscsi_flush_cq(struct beiscsi_hba *ph=
ba)
 	struct be_eq_obj *pbe_eq;
 	struct hwi_controller *phwi_ctrlr;
 	struct hwi_context_memory *phwi_context;
+	struct pci_dev *pcidev;
=20
 	phwi_ctrlr =3D phba->phwi_ctrlr;
 	phwi_context =3D phwi_ctrlr->phwi_ctxt;
+	pcidev =3D phba->pcidev;
=20
 	for (i =3D 0; i < phba->num_cpus; i++) {
 		pbe_eq =3D &phwi_context->be_eq[i];
-		irq_poll_disable(&pbe_eq->iopoll);
-		beiscsi_process_cq(pbe_eq, BE2_MAX_NUM_CQ_PROC);
-		irq_poll_enable(&pbe_eq->iopoll);
+		disable_irq(pci_irq_vector(pcidev, i));
+		beiscsi_process_cq(pbe_eq);
+		enable_irq(pci_irq_vector(pcidev, i));
 	}
 }
=20
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_mai=
n.c
index e70f69f791db6..ef09e298cca94 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -35,7 +35,6 @@
 #include <linux/iscsi_boot_sysfs.h>
 #include <linux/module.h>
 #include <linux/bsg-lib.h>
-#include <linux/irq_poll.h>
=20
 #include <scsi/libiscsi.h>
 #include <scsi/scsi_bsg_iscsi.h>
@@ -51,7 +50,6 @@
 #include "be_mgmt.h"
 #include "be_cmds.h"
=20
-static unsigned int be_iopoll_budget =3D 10;
 static unsigned int be_max_phys_size =3D 64;
 static unsigned int enable_msix =3D 1;
=20
@@ -59,7 +57,6 @@ MODULE_DESCRIPTION(DRV_DESC " " BUILD_STR);
 MODULE_VERSION(BUILD_STR);
 MODULE_AUTHOR("Emulex Corporation");
 MODULE_LICENSE("GPL");
-module_param(be_iopoll_budget, int, 0);
 module_param(enable_msix, int, 0);
 module_param(be_max_phys_size, uint, S_IRUGO);
 MODULE_PARM_DESC(be_max_phys_size,
@@ -696,6 +693,48 @@ static irqreturn_t be_isr_mcc(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
=20
+static irqreturn_t be_iopoll(struct be_eq_obj *pbe_eq)
+{
+	struct beiscsi_hba *phba;
+	unsigned int ret, io_events;
+	struct be_eq_entry *eqe =3D NULL;
+	struct be_queue_info *eq;
+
+	phba =3D pbe_eq->phba;
+	if (beiscsi_hba_in_error(phba))
+		return IRQ_NONE;
+
+	io_events =3D 0;
+	eq =3D &pbe_eq->q;
+	eqe =3D queue_tail_node(eq);
+	while (eqe->dw[offsetof(struct amap_eq_entry, valid) / 32] &
+			EQE_VALID_MASK) {
+		AMAP_SET_BITS(struct amap_eq_entry, valid, eqe, 0);
+		queue_tail_inc(eq);
+		eqe =3D queue_tail_node(eq);
+		io_events++;
+	}
+	hwi_ring_eq_db(phba, eq->id, 1, io_events, 0, 1);
+
+	ret =3D beiscsi_process_cq(pbe_eq);
+	pbe_eq->cq_count +=3D ret;
+	beiscsi_log(phba, KERN_INFO,
+		    BEISCSI_LOG_CONFIG | BEISCSI_LOG_IO,
+		    "BM_%d : rearm pbe_eq->q.id =3D%d ret %d\n",
+		    pbe_eq->q.id, ret);
+	if (!beiscsi_hba_in_error(phba))
+		hwi_ring_eq_db(phba, pbe_eq->q.id, 0, 0, 1, 1);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t be_isr_misx_th(int irq, void *dev_id)
+{
+	struct be_eq_obj *pbe_eq  =3D dev_id;
+
+	return be_iopoll(pbe_eq);
+}
+
 /**
  * be_isr_msix - The isr routine of the driver.
  * @irq: Not used
@@ -713,9 +752,22 @@ static irqreturn_t be_isr_msix(int irq, void *dev_id)
 	phba =3D pbe_eq->phba;
 	/* disable interrupt till iopoll completes */
 	hwi_ring_eq_db(phba, eq->id, 1,	0, 0, 1);
-	irq_poll_sched(&pbe_eq->iopoll);
=20
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t be_isr_thread(int irq, void *dev_id)
+{
+	struct beiscsi_hba *phba;
+	struct hwi_controller *phwi_ctrlr;
+	struct hwi_context_memory *phwi_context;
+	struct be_eq_obj *pbe_eq;
+
+	phba =3D dev_id;
+	phwi_ctrlr =3D phba->phwi_ctrlr;
+	phwi_context =3D phwi_ctrlr->phwi_ctxt;
+	pbe_eq =3D &phwi_context->be_eq[0];
+	return be_iopoll(pbe_eq);
 }
=20
 /**
@@ -735,6 +787,7 @@ static irqreturn_t be_isr(int irq, void *dev_id)
 	struct be_ctrl_info *ctrl;
 	struct be_eq_obj *pbe_eq;
 	int isr, rearm;
+	irqreturn_t ret;
=20
 	phba =3D dev_id;
 	ctrl =3D &phba->ctrl;
@@ -774,10 +827,11 @@ static irqreturn_t be_isr(int irq, void *dev_id)
 		/* rearm for MCCQ */
 		rearm =3D 1;
 	}
+	ret =3D IRQ_HANDLED;
 	if (io_events)
-		irq_poll_sched(&pbe_eq->iopoll);
+		ret =3D IRQ_WAKE_THREAD;
 	hwi_ring_eq_db(phba, eq->id, 0, (io_events + mcc_events), rearm, 1);
-	return IRQ_HANDLED;
+	return ret;
 }
=20
 static void beiscsi_free_irqs(struct beiscsi_hba *phba)
@@ -819,9 +873,10 @@ static int beiscsi_init_irqs(struct beiscsi_hba *phba)
 				goto free_msix_irqs;
 			}
=20
-			ret =3D request_irq(pci_irq_vector(pcidev, i),
-					  be_isr_msix, 0, phba->msi_name[i],
-					  &phwi_context->be_eq[i]);
+			ret =3D request_threaded_irq(pci_irq_vector(pcidev, i),
+						   be_isr_msix, be_isr_misx_th,
+						   0, phba->msi_name[i],
+						   &phwi_context->be_eq[i]);
 			if (ret) {
 				beiscsi_log(phba, KERN_ERR, BEISCSI_LOG_INIT,
 					    "BM_%d : %s-Failed to register msix for i =3D %d\n",
@@ -847,8 +902,8 @@ static int beiscsi_init_irqs(struct beiscsi_hba *phba)
 		}
=20
 	} else {
-		ret =3D request_irq(pcidev->irq, be_isr, IRQF_SHARED,
-				  "beiscsi", phba);
+		ret =3D request_threaded_irq(pcidev->irq, be_isr, be_isr_thread,
+					   IRQF_SHARED, "beiscsi", phba);
 		if (ret) {
 			beiscsi_log(phba, KERN_ERR, BEISCSI_LOG_INIT,
 				    "BM_%d : %s-Failed to register irq\n",
@@ -1839,12 +1894,11 @@ static void beiscsi_mcc_work(struct work_struct *wo=
rk)
 /**
  * beiscsi_process_cq()- Process the Completion Queue
  * @pbe_eq: Event Q on which the Completion has come
- * @budget: Max number of events to processed
  *
  * return
  *     Number of Completion Entries processed.
  **/
-unsigned int beiscsi_process_cq(struct be_eq_obj *pbe_eq, int budget)
+unsigned int beiscsi_process_cq(struct be_eq_obj *pbe_eq)
 {
 	struct be_queue_info *cq;
 	struct sol_cqe *sol;
@@ -2018,55 +2072,12 @@ unsigned int beiscsi_process_cq(struct be_eq_obj *p=
be_eq, int budget)
 		queue_tail_inc(cq);
 		sol =3D queue_tail_node(cq);
 		num_processed++;
-		if (total =3D=3D budget)
-			break;
 	}
=20
 	hwi_ring_cq_db(phba, cq->id, num_processed, 1);
 	return total;
 }
=20
-static int be_iopoll(struct irq_poll *iop, int budget)
-{
-	unsigned int ret, io_events;
-	struct beiscsi_hba *phba;
-	struct be_eq_obj *pbe_eq;
-	struct be_eq_entry *eqe =3D NULL;
-	struct be_queue_info *eq;
-
-	pbe_eq =3D container_of(iop, struct be_eq_obj, iopoll);
-	phba =3D pbe_eq->phba;
-	if (beiscsi_hba_in_error(phba)) {
-		irq_poll_complete(iop);
-		return 0;
-	}
-
-	io_events =3D 0;
-	eq =3D &pbe_eq->q;
-	eqe =3D queue_tail_node(eq);
-	while (eqe->dw[offsetof(struct amap_eq_entry, valid) / 32] &
-			EQE_VALID_MASK) {
-		AMAP_SET_BITS(struct amap_eq_entry, valid, eqe, 0);
-		queue_tail_inc(eq);
-		eqe =3D queue_tail_node(eq);
-		io_events++;
-	}
-	hwi_ring_eq_db(phba, eq->id, 1, io_events, 0, 1);
-
-	ret =3D beiscsi_process_cq(pbe_eq, budget);
-	pbe_eq->cq_count +=3D ret;
-	if (ret < budget) {
-		irq_poll_complete(iop);
-		beiscsi_log(phba, KERN_INFO,
-			    BEISCSI_LOG_CONFIG | BEISCSI_LOG_IO,
-			    "BM_%d : rearm pbe_eq->q.id =3D%d ret %d\n",
-			    pbe_eq->q.id, ret);
-		if (!beiscsi_hba_in_error(phba))
-			hwi_ring_eq_db(phba, pbe_eq->q.id, 0, 0, 1, 1);
-	}
-	return ret;
-}
-
 static void
 hwi_write_sgl_v2(struct iscsi_wrb *pwrb, struct scatterlist *sg,
 		  unsigned int num_sg, struct beiscsi_io_task *io_task)
@@ -5308,10 +5319,6 @@ static int beiscsi_enable_port(struct beiscsi_hba *p=
hba)
=20
 	phwi_ctrlr =3D phba->phwi_ctrlr;
 	phwi_context =3D phwi_ctrlr->phwi_ctxt;
-	for (i =3D 0; i < phba->num_cpus; i++) {
-		pbe_eq =3D &phwi_context->be_eq[i];
-		irq_poll_init(&pbe_eq->iopoll, be_iopoll_budget, be_iopoll);
-	}
=20
 	i =3D (phba->pcidev->msix_enabled) ? i : 0;
 	/* Work item for MCC handling */
@@ -5344,10 +5351,6 @@ static int beiscsi_enable_port(struct beiscsi_hba *p=
hba)
 	return 0;
=20
 cleanup_port:
-	for (i =3D 0; i < phba->num_cpus; i++) {
-		pbe_eq =3D &phwi_context->be_eq[i];
-		irq_poll_disable(&pbe_eq->iopoll);
-	}
 	hwi_cleanup_port(phba);
=20
 disable_msix:
@@ -5379,10 +5382,6 @@ static void beiscsi_disable_port(struct beiscsi_hba =
*phba, int unload)
 	beiscsi_free_irqs(phba);
 	pci_free_irq_vectors(phba->pcidev);
=20
-	for (i =3D 0; i < phba->num_cpus; i++) {
-		pbe_eq =3D &phwi_context->be_eq[i];
-		irq_poll_disable(&pbe_eq->iopoll);
-	}
 	cancel_delayed_work_sync(&phba->eqd_update);
 	cancel_work_sync(&phba->boot_work);
 	/* WQ might be running cancel queued mcc_work if we are not exiting */
@@ -5637,11 +5636,6 @@ static int beiscsi_dev_probe(struct pci_dev *pcidev,
 	phwi_ctrlr =3D phba->phwi_ctrlr;
 	phwi_context =3D phwi_ctrlr->phwi_ctxt;
=20
-	for (i =3D 0; i < phba->num_cpus; i++) {
-		pbe_eq =3D &phwi_context->be_eq[i];
-		irq_poll_init(&pbe_eq->iopoll, be_iopoll_budget, be_iopoll);
-	}
-
 	i =3D (phba->pcidev->msix_enabled) ? i : 0;
 	/* Work item for MCC handling */
 	pbe_eq =3D &phwi_context->be_eq[i];
@@ -5698,10 +5692,6 @@ static int beiscsi_dev_probe(struct pci_dev *pcidev,
 	hwi_disable_intr(phba);
 	beiscsi_free_irqs(phba);
 disable_iopoll:
-	for (i =3D 0; i < phba->num_cpus; i++) {
-		pbe_eq =3D &phwi_context->be_eq[i];
-		irq_poll_disable(&pbe_eq->iopoll);
-	}
 	destroy_workqueue(phba->wq);
 free_twq:
 	hwi_cleanup_port(phba);
diff --git a/drivers/scsi/be2iscsi/be_main.h b/drivers/scsi/be2iscsi/be_mai=
n.h
index 98977c0700f1a..5c0e54eaf9e99 100644
--- a/drivers/scsi/be2iscsi/be_main.h
+++ b/drivers/scsi/be2iscsi/be_main.h
@@ -799,7 +799,7 @@ void hwi_ring_cq_db(struct beiscsi_hba *phba,
 		     unsigned int id, unsigned int num_processed,
 		     unsigned char rearm);
=20
-unsigned int beiscsi_process_cq(struct be_eq_obj *pbe_eq, int budget);
+unsigned int beiscsi_process_cq(struct be_eq_obj *pbe_eq);
 void beiscsi_process_mcc_cq(struct beiscsi_hba *phba);
=20
 struct pdu_nop_out {
--=20
2.33.1

