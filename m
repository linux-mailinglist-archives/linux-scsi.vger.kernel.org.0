Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFEE6EF25A
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 01:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfKEA5k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 19:57:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36290 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbfKEA5j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Nov 2019 19:57:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so18124506wmd.1
        for <linux-scsi@vger.kernel.org>; Mon, 04 Nov 2019 16:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LdDRek12ECZd9JIdoD9em14u86KBs/B3dDzCT3BZ3sQ=;
        b=EuyPF1MkB0Mx5cpdKvOHloV9f8soZnGPSurvP9EMZPaYTQvcCOiAJNUTUluUnhZav/
         DbRct25cUfNBCfBuB772DFmZG3sS/bYcjKzfPEMEs7jHd17En87pyFs/PdbBRBh53WWV
         ZFSQyNfAVyaWfCRNtwkQlAa1/9RbH8MRlS9zbYOW3OFWDApCBL1ivJsvc8IyCTcZcDUl
         PS9iqwnen7lEcWCSV4za2RkBsJpLMvSkjQByt2uHSRwFqvNyp+zTTqtBgeTkpgxirFYN
         P8cvZKGMwkUYnLNrfxPmpguaWTJI8VUUfF/d+KmhP6xNFJpISuWCkj4lUNduOASvOPGp
         0YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LdDRek12ECZd9JIdoD9em14u86KBs/B3dDzCT3BZ3sQ=;
        b=pclroAH0QEdudULQvYfPbBhxGpLXvaYHRBzdy0ix9cgLFUUYdlPK4bmGyaOtUU3q6X
         /IU/hA62BiczWIh+5PWntbn+euLh4bboPWTrp9AtpuGDih1ZWFv13HvWiO8Cn6is9Kbx
         pSxmjMcNTvE4aI0UkKWt68z5BYCaE2U2jG+AMvYPcclJsBdmfEz+yi2MpoXrGxjBpmyl
         /mm2dUaXs9pH/ZCSfc5IGF6fptatI053b1h0aF3ARy4fsiii0kLA2ZekzOxYoh8gda1Y
         H3TPU7xXSNstWOQa0b7qxA6mVE2rX0MVrtxeKJMtZ1fTULMzMKFp8T+GYmWk7uxltoIU
         FDrA==
X-Gm-Message-State: APjAAAVKM3y/kTc5e5hXEpiQDxX/c8MFafwfVJyyPsw6iVzX7T8OfdrV
        +fIwlcFPH9+arl+9GeeT5KQnDeFg8CM=
X-Google-Smtp-Source: APXvYqxz5JZxF177AuV/6AeqD+hZhz3F6/1n1iRXJx/Q3RoLky76fNo81lU7+4t7FYKbl5tvyd/Izg==
X-Received: by 2002:a05:600c:2152:: with SMTP id v18mr1461072wml.23.1572915454212;
        Mon, 04 Nov 2019 16:57:34 -0800 (PST)
Received: from pallmd1.broadcom.com ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id g5sm16920991wma.43.2019.11.04.16.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 16:57:33 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 08/11] lpfc: Add registration for CPU Offline/Online events
Date:   Mon,  4 Nov 2019 16:57:05 -0800
Message-Id: <20191105005708.7399-9-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191105005708.7399-1-jsmart2021@gmail.com>
References: <20191105005708.7399-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The recent affinitization didn't address cpu offlining/onlining.
If an interrupt vector is shared and the low order cpu owning
the vector is offlined, as interrupts are managed, the vector
is taken offline. This causes the other cpu's sharing the vector
will hang as they can't get io completions.

Correct by registering callbacks with the system for Offline/Online
events. When a cpu is taken offline, its eq, which is tied to an
interrupt vector is found. If the cpu is the "owner" of the vector
and if the eq/vector is shared by other cpu's, the eq is placed
into a polled mode.  Additionally, code paths that perform io
submission on the "sharing cpus" will check the eq state and poll
for completion after submission of new io to a wq that uses the eq.

Similarly, when a cpu comes back online and owns an offline'd vector,
the eq is taken out of polled mode and rearmed to start driving
interrupts for eq.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |   7 ++
 drivers/scsi/lpfc/lpfc_crtn.h |   6 ++
 drivers/scsi/lpfc/lpfc_init.c | 202 +++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_sli.c  | 164 ++++++++++++++++++++++++++++++++--
 drivers/scsi/lpfc/lpfc_sli4.h |  21 ++++-
 5 files changed, 388 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 4559f1700c6d..88d5fd99f5ec 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1215,6 +1215,13 @@ struct lpfc_hba {
 	uint64_t ktime_seg10_min;
 	uint64_t ktime_seg10_max;
 #endif
+
+	struct hlist_node cpuhp;	/* used for cpuhp per hba callback */
+	struct timer_list cpuhp_poll_timer;
+	struct list_head poll_list;	/* slowpath eq polling list */
+#define LPFC_POLL_HB	1		/* slowpath heartbeat */
+#define LPFC_POLL_FASTPATH	0	/* called from fastpath */
+#define LPFC_POLL_SLOWPATH	1	/* called from slowpath */
 };
 
 static inline struct Scsi_Host *
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 6e09fd98a922..d91aa5330306 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -215,6 +215,12 @@ irqreturn_t lpfc_sli_fp_intr_handler(int, void *);
 irqreturn_t lpfc_sli4_intr_handler(int, void *);
 irqreturn_t lpfc_sli4_hba_intr_handler(int, void *);
 
+inline void lpfc_sli4_cleanup_poll_list(struct lpfc_hba *phba);
+int lpfc_sli4_poll_eq(struct lpfc_queue *q, uint8_t path);
+void lpfc_sli4_poll_hbtimer(struct timer_list *t);
+void lpfc_sli4_start_polling(struct lpfc_queue *q);
+void lpfc_sli4_stop_polling(struct lpfc_queue *q);
+
 void lpfc_read_rev(struct lpfc_hba *, LPFC_MBOXQ_t *);
 void lpfc_sli4_swap_str(struct lpfc_hba *, LPFC_MBOXQ_t *);
 void lpfc_config_ring(struct lpfc_hba *, int, LPFC_MBOXQ_t *);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index ec9dbc042a41..888ad32d5267 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -40,6 +40,7 @@
 #include <linux/irq.h>
 #include <linux/bitops.h>
 #include <linux/crash_dump.h>
+#include <linux/cpuhotplug.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
@@ -66,9 +67,13 @@
 #include "lpfc_version.h"
 #include "lpfc_ids.h"
 
+static enum cpuhp_state lpfc_cpuhp_state;
 /* Used when mapping IRQ vectors in a driver centric manner */
 static uint32_t lpfc_present_cpu;
 
+static void __lpfc_cpuhp_remove(struct lpfc_hba *phba);
+static void lpfc_cpuhp_remove(struct lpfc_hba *phba);
+static void lpfc_cpuhp_add(struct lpfc_hba *phba);
 static void lpfc_get_hba_model_desc(struct lpfc_hba *, uint8_t *, uint8_t *);
 static int lpfc_post_rcv_buf(struct lpfc_hba *);
 static int lpfc_sli4_queue_verify(struct lpfc_hba *);
@@ -3379,6 +3384,8 @@ lpfc_online(struct lpfc_hba *phba)
 	if (phba->cfg_xri_rebalancing)
 		lpfc_create_multixri_pools(phba);
 
+	lpfc_cpuhp_add(phba);
+
 	lpfc_unblock_mgmt_io(phba);
 	return 0;
 }
@@ -3542,6 +3549,7 @@ lpfc_offline(struct lpfc_hba *phba)
 			spin_unlock_irq(shost->host_lock);
 		}
 	lpfc_destroy_vport_work_array(phba, vports);
+	__lpfc_cpuhp_remove(phba);
 
 	if (phba->cfg_xri_rebalancing)
 		lpfc_destroy_multixri_pools(phba);
@@ -9255,6 +9263,8 @@ lpfc_sli4_queue_destroy(struct lpfc_hba *phba)
 	}
 	spin_unlock_irq(&phba->hbalock);
 
+	lpfc_sli4_cleanup_poll_list(phba);
+
 	/* Release HBA eqs */
 	if (phba->sli4_hba.hdwq)
 		lpfc_sli4_release_hdwq(phba);
@@ -11058,6 +11068,170 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 }
 
 /**
+ * lpfc_cpuhp_get_eq
+ *
+ * @phba:   pointer to lpfc hba data structure.
+ * @cpu:    cpu going offline
+ * @eqlist:
+ */
+static void
+lpfc_cpuhp_get_eq(struct lpfc_hba *phba, unsigned int cpu,
+		  struct list_head *eqlist)
+{
+	struct lpfc_vector_map_info *map;
+	const struct cpumask *maskp;
+	struct lpfc_queue *eq;
+	unsigned int i;
+	cpumask_t tmp;
+	u16 idx;
+
+	for (idx = 0; idx < phba->cfg_irq_chann; idx++) {
+		maskp = pci_irq_get_affinity(phba->pcidev, idx);
+		if (!maskp)
+			continue;
+		/*
+		 * if irq is not affinitized to the cpu going
+		 * then we don't need to poll the eq attached
+		 * to it.
+		 */
+		if (!cpumask_and(&tmp, maskp, cpumask_of(cpu)))
+			continue;
+		/* get the cpus that are online and are affini-
+		 * tized to this irq vector.  If the count is
+		 * more than 1 then cpuhp is not going to shut-
+		 * down this vector.  Since this cpu has not
+		 * gone offline yet, we need >1.
+		 */
+		cpumask_and(&tmp, maskp, cpu_online_mask);
+		if (cpumask_weight(&tmp) > 1)
+			continue;
+
+		/* Now that we have an irq to shutdown, get the eq
+		 * mapped to this irq.  Note: multiple hdwq's in
+		 * the software can share an eq, but eventually
+		 * only eq will be mapped to this vector
+		 */
+		for_each_possible_cpu(i) {
+			map = &phba->sli4_hba.cpu_map[i];
+			if (!(map->irq == pci_irq_vector(phba->pcidev, idx)))
+				continue;
+			eq = phba->sli4_hba.hdwq[map->hdwq].hba_eq;
+			list_add(&eq->_poll_list, eqlist);
+			/* 1 is good enough. others will be a copy of this */
+			break;
+		}
+	}
+}
+
+static void __lpfc_cpuhp_remove(struct lpfc_hba *phba)
+{
+	if (phba->sli_rev != LPFC_SLI_REV4)
+		return;
+
+	cpuhp_state_remove_instance_nocalls(lpfc_cpuhp_state,
+					    &phba->cpuhp);
+	/*
+	 * unregistering the instance doesn't stop the polling
+	 * timer. Wait for the poll timer to retire.
+	 */
+	synchronize_rcu();
+	del_timer_sync(&phba->cpuhp_poll_timer);
+}
+
+static void lpfc_cpuhp_remove(struct lpfc_hba *phba)
+{
+	if (phba->pport->fc_flag & FC_OFFLINE_MODE)
+		return;
+
+	__lpfc_cpuhp_remove(phba);
+}
+
+static void lpfc_cpuhp_add(struct lpfc_hba *phba)
+{
+	if (phba->sli_rev != LPFC_SLI_REV4)
+		return;
+
+	rcu_read_lock();
+
+	if (!list_empty(&phba->poll_list)) {
+		timer_setup(&phba->cpuhp_poll_timer, lpfc_sli4_poll_hbtimer, 0);
+		mod_timer(&phba->cpuhp_poll_timer,
+			  jiffies + msecs_to_jiffies(LPFC_POLL_HB));
+	}
+
+	rcu_read_unlock();
+
+	cpuhp_state_add_instance_nocalls(lpfc_cpuhp_state,
+					 &phba->cpuhp);
+}
+
+static int __lpfc_cpuhp_checks(struct lpfc_hba *phba, int *retval)
+{
+	if (phba->pport->load_flag & FC_UNLOADING) {
+		*retval = -EAGAIN;
+		return true;
+	}
+
+	if (phba->sli_rev != LPFC_SLI_REV4) {
+		*retval = 0;
+		return true;
+	}
+
+	/* proceed with the hotplug */
+	return false;
+}
+
+static int lpfc_cpu_offline(unsigned int cpu, struct hlist_node *node)
+{
+	struct lpfc_hba *phba = hlist_entry_safe(node, struct lpfc_hba, cpuhp);
+	struct lpfc_queue *eq, *next;
+	LIST_HEAD(eqlist);
+	int retval;
+
+	if (!phba) {
+		WARN_ONCE(!phba, "cpu: %u. phba:NULL", raw_smp_processor_id());
+		return 0;
+	}
+
+	if (__lpfc_cpuhp_checks(phba, &retval))
+		return retval;
+
+	lpfc_cpuhp_get_eq(phba, cpu, &eqlist);
+
+	/* start polling on these eq's */
+	list_for_each_entry_safe(eq, next, &eqlist, _poll_list) {
+		list_del_init(&eq->_poll_list);
+		lpfc_sli4_start_polling(eq);
+	}
+
+	return 0;
+}
+
+static int lpfc_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct lpfc_hba *phba = hlist_entry_safe(node, struct lpfc_hba, cpuhp);
+	struct lpfc_queue *eq, *next;
+	unsigned int n;
+	int retval;
+
+	if (!phba) {
+		WARN_ONCE(!phba, "cpu: %u. phba:NULL", raw_smp_processor_id());
+		return 0;
+	}
+
+	if (__lpfc_cpuhp_checks(phba, &retval))
+		return retval;
+
+	list_for_each_entry_safe(eq, next, &phba->poll_list, _poll_list) {
+		n = lpfc_find_cpu_handle(phba, eq->hdwq, LPFC_FIND_BY_HDWQ);
+		if (n == cpu)
+			lpfc_sli4_stop_polling(eq);
+	}
+
+	return 0;
+}
+
+/**
  * lpfc_sli4_enable_msix - Enable MSI-X interrupt mode to SLI-4 device
  * @phba: pointer to lpfc hba data structure.
  *
@@ -11460,6 +11634,9 @@ lpfc_sli4_hba_unset(struct lpfc_hba *phba)
 	/* Wait for completion of device XRI exchange busy */
 	lpfc_sli4_xri_exchange_busy_wait(phba);
 
+	/* per-phba callback de-registration for hotplug event */
+	lpfc_cpuhp_remove(phba);
+
 	/* Disable PCI subsystem interrupt */
 	lpfc_sli4_disable_intr(phba);
 
@@ -12752,6 +12929,9 @@ lpfc_pci_probe_one_s4(struct pci_dev *pdev, const struct pci_device_id *pid)
 	/* Enable RAS FW log support */
 	lpfc_sli4_ras_setup(phba);
 
+	INIT_LIST_HEAD(&phba->poll_list);
+	cpuhp_state_add_instance_nocalls(lpfc_cpuhp_state, &phba->cpuhp);
+
 	return 0;
 
 out_free_sysfs_attr:
@@ -13569,11 +13749,24 @@ lpfc_init(void)
 	/* Initialize in case vector mapping is needed */
 	lpfc_present_cpu = num_present_cpus();
 
+	error = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+					"lpfc/sli4:online",
+					lpfc_cpu_online, lpfc_cpu_offline);
+	if (error < 0)
+		goto cpuhp_failure;
+	lpfc_cpuhp_state = error;
+
 	error = pci_register_driver(&lpfc_driver);
-	if (error) {
-		fc_release_transport(lpfc_transport_template);
-		fc_release_transport(lpfc_vport_transport_template);
-	}
+	if (error)
+		goto unwind;
+
+	return error;
+
+unwind:
+	cpuhp_remove_multi_state(lpfc_cpuhp_state);
+cpuhp_failure:
+	fc_release_transport(lpfc_transport_template);
+	fc_release_transport(lpfc_vport_transport_template);
 
 	return error;
 }
@@ -13590,6 +13783,7 @@ lpfc_exit(void)
 {
 	misc_deregister(&lpfc_mgmt_dev);
 	pci_unregister_driver(&lpfc_driver);
+	cpuhp_remove_multi_state(lpfc_cpuhp_state);
 	fc_release_transport(lpfc_transport_template);
 	fc_release_transport(lpfc_vport_transport_template);
 	idr_destroy(&lpfc_hba_index);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 660f96218b25..5f097328d236 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -515,7 +515,8 @@ lpfc_sli4_eqcq_flush(struct lpfc_hba *phba, struct lpfc_queue *eq)
 }
 
 static int
-lpfc_sli4_process_eq(struct lpfc_hba *phba, struct lpfc_queue *eq)
+lpfc_sli4_process_eq(struct lpfc_hba *phba, struct lpfc_queue *eq,
+		     uint8_t rearm)
 {
 	struct lpfc_eqe *eqe;
 	int count = 0, consumed = 0;
@@ -549,8 +550,8 @@ lpfc_sli4_process_eq(struct lpfc_hba *phba, struct lpfc_queue *eq)
 	eq->queue_claimed = 0;
 
 rearm_and_exit:
-	/* Always clear and re-arm the EQ */
-	phba->sli4_hba.sli4_write_eq_db(phba, eq, consumed, LPFC_QUEUE_REARM);
+	/* Always clear the EQ. */
+	phba->sli4_hba.sli4_write_eq_db(phba, eq, consumed, rearm);
 
 	return count;
 }
@@ -7948,7 +7949,7 @@ lpfc_sli4_process_missed_mbox_completions(struct lpfc_hba *phba)
 
 	if (mbox_pending)
 		/* process and rearm the EQ */
-		lpfc_sli4_process_eq(phba, fpeq);
+		lpfc_sli4_process_eq(phba, fpeq, LPFC_QUEUE_REARM);
 	else
 		/* Always clear and re-arm the EQ */
 		sli4_hba->sli4_write_eq_db(phba, fpeq, 0, LPFC_QUEUE_REARM);
@@ -10113,10 +10114,13 @@ lpfc_sli_issue_iocb(struct lpfc_hba *phba, uint32_t ring_number,
 		    struct lpfc_iocbq *piocb, uint32_t flag)
 {
 	struct lpfc_sli_ring *pring;
+	struct lpfc_queue *eq;
 	unsigned long iflags;
 	int rc;
 
 	if (phba->sli_rev == LPFC_SLI_REV4) {
+		eq = phba->sli4_hba.hdwq[piocb->hba_wqidx].hba_eq;
+
 		pring = lpfc_sli4_calc_ring(phba, piocb);
 		if (unlikely(pring == NULL))
 			return IOCB_ERROR;
@@ -10124,6 +10128,8 @@ lpfc_sli_issue_iocb(struct lpfc_hba *phba, uint32_t ring_number,
 		spin_lock_irqsave(&pring->ring_lock, iflags);
 		rc = __lpfc_sli_issue_iocb(phba, ring_number, piocb, flag);
 		spin_unlock_irqrestore(&pring->ring_lock, iflags);
+
+		lpfc_sli4_poll_eq(eq, LPFC_POLL_FASTPATH);
 	} else {
 		/* For now, SLI2/3 will still use hbalock */
 		spin_lock_irqsave(&phba->hbalock, iflags);
@@ -14302,7 +14308,7 @@ lpfc_sli4_hba_intr_handler(int irq, void *dev_id)
 		lpfc_sli4_mod_hba_eq_delay(phba, fpeq, LPFC_MAX_AUTO_EQ_DELAY);
 
 	/* process and rearm the EQ */
-	ecount = lpfc_sli4_process_eq(phba, fpeq);
+	ecount = lpfc_sli4_process_eq(phba, fpeq, LPFC_QUEUE_REARM);
 
 	if (unlikely(ecount == 0)) {
 		fpeq->EQ_no_entry++;
@@ -14362,6 +14368,147 @@ lpfc_sli4_intr_handler(int irq, void *dev_id)
 	return (hba_handled == true) ? IRQ_HANDLED : IRQ_NONE;
 } /* lpfc_sli4_intr_handler */
 
+void lpfc_sli4_poll_hbtimer(struct timer_list *t)
+{
+	struct lpfc_hba *phba = from_timer(phba, t, cpuhp_poll_timer);
+	struct lpfc_queue *eq;
+	int i = 0;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(eq, &phba->poll_list, _poll_list)
+		i += lpfc_sli4_poll_eq(eq, LPFC_POLL_SLOWPATH);
+	if (!list_empty(&phba->poll_list))
+		mod_timer(&phba->cpuhp_poll_timer,
+			  jiffies + msecs_to_jiffies(LPFC_POLL_HB));
+
+	rcu_read_unlock();
+}
+
+inline int lpfc_sli4_poll_eq(struct lpfc_queue *eq, uint8_t path)
+{
+	struct lpfc_hba *phba = eq->phba;
+	int i = 0;
+
+	/*
+	 * Unlocking an irq is one of the entry point to check
+	 * for re-schedule, but we are good for io submission
+	 * path as midlayer does a get_cpu to glue us in. Flush
+	 * out the invalidate queue so we can see the updated
+	 * value for flag.
+	 */
+	smp_rmb();
+
+	if (READ_ONCE(eq->mode) == LPFC_EQ_POLL)
+		/* We will not likely get the completion for the caller
+		 * during this iteration but i guess that's fine.
+		 * Future io's coming on this eq should be able to
+		 * pick it up.  As for the case of single io's, they
+		 * will be handled through a sched from polling timer
+		 * function which is currently triggered every 1msec.
+		 */
+		i = lpfc_sli4_process_eq(phba, eq, LPFC_QUEUE_NOARM);
+
+	return i;
+}
+
+static inline void lpfc_sli4_add_to_poll_list(struct lpfc_queue *eq)
+{
+	struct lpfc_hba *phba = eq->phba;
+
+	if (list_empty(&phba->poll_list)) {
+		timer_setup(&phba->cpuhp_poll_timer, lpfc_sli4_poll_hbtimer, 0);
+		/* kickstart slowpath processing for this eq */
+		mod_timer(&phba->cpuhp_poll_timer,
+			  jiffies + msecs_to_jiffies(LPFC_POLL_HB));
+	}
+
+	list_add_rcu(&eq->_poll_list, &phba->poll_list);
+	synchronize_rcu();
+}
+
+static inline void lpfc_sli4_remove_from_poll_list(struct lpfc_queue *eq)
+{
+	struct lpfc_hba *phba = eq->phba;
+
+	/* Disable slowpath processing for this eq.  Kick start the eq
+	 * by RE-ARMING the eq's ASAP
+	 */
+	list_del_rcu(&eq->_poll_list);
+	synchronize_rcu();
+
+	if (list_empty(&phba->poll_list))
+		del_timer_sync(&phba->cpuhp_poll_timer);
+}
+
+inline void lpfc_sli4_cleanup_poll_list(struct lpfc_hba *phba)
+{
+	struct lpfc_queue *eq, *next;
+
+	list_for_each_entry_safe(eq, next, &phba->poll_list, _poll_list)
+		list_del(&eq->_poll_list);
+
+	INIT_LIST_HEAD(&phba->poll_list);
+	synchronize_rcu();
+}
+
+static inline void
+__lpfc_sli4_switch_eqmode(struct lpfc_queue *eq, uint8_t mode)
+{
+	if (mode == eq->mode)
+		return;
+	/*
+	 * currently this function is only called during a hotplug
+	 * event and the cpu on which this function is executing
+	 * is going offline.  By now the hotplug has instructed
+	 * the scheduler to remove this cpu from cpu active mask.
+	 * So we don't need to work about being put aside by the
+	 * scheduler for a high priority process.  Yes, the inte-
+	 * rrupts could come but they are known to retire ASAP.
+	 */
+
+	/* Disable polling in the fastpath */
+	WRITE_ONCE(eq->mode, mode);
+	/* flush out the store buffer */
+	smp_wmb();
+
+	/*
+	 * Add this eq to the polling list and start polling. For
+	 * a grace period both interrupt handler and poller will
+	 * try to process the eq _but_ that's fine.  We have a
+	 * synchronization mechanism in place (queue_claimed) to
+	 * deal with it.  This is just a draining phase for int-
+	 * errupt handler (not eq's) as we have guranteed through
+	 * barrier that all the cpu's have seen the new CQ_POLLED
+	 * state. which will effectively disable the REARMING of
+	 * the EQ.  The whole idea is eq's die off eventually as
+	 * we are not rearming EQ's anymore.
+	 */
+	mode ? lpfc_sli4_add_to_poll_list(eq) :
+	       lpfc_sli4_remove_from_poll_list(eq);
+}
+
+void lpfc_sli4_start_polling(struct lpfc_queue *eq)
+{
+	__lpfc_sli4_switch_eqmode(eq, LPFC_EQ_POLL);
+}
+
+void lpfc_sli4_stop_polling(struct lpfc_queue *eq)
+{
+	struct lpfc_hba *phba = eq->phba;
+
+	__lpfc_sli4_switch_eqmode(eq, LPFC_EQ_INTERRUPT);
+
+	/* Kick start for the pending io's in h/w.
+	 * Once we switch back to interrupt processing on a eq
+	 * the io path completion will only arm eq's when it
+	 * receives a completion.  But since eq's are in disa-
+	 * rmed state it doesn't receive a completion.  This
+	 * creates a deadlock scenaro.
+	 */
+	phba->sli4_hba.sli4_write_eq_db(phba, eq, 0, LPFC_QUEUE_REARM);
+}
+
 /**
  * lpfc_sli4_queue_free - free a queue structure and associated memory
  * @queue: The queue structure to free.
@@ -14436,6 +14583,7 @@ lpfc_sli4_queue_alloc(struct lpfc_hba *phba, uint32_t page_size,
 		return NULL;
 
 	INIT_LIST_HEAD(&queue->list);
+	INIT_LIST_HEAD(&queue->_poll_list);
 	INIT_LIST_HEAD(&queue->wq_list);
 	INIT_LIST_HEAD(&queue->wqfull_list);
 	INIT_LIST_HEAD(&queue->page_list);
@@ -19757,6 +19905,8 @@ lpfc_sli4_issue_wqe(struct lpfc_hba *phba, struct lpfc_sli4_hdw_queue *qp,
 
 		lpfc_sli_ringtxcmpl_put(phba, pring, pwqe);
 		spin_unlock_irqrestore(&pring->ring_lock, iflags);
+
+		lpfc_sli4_poll_eq(qp->hba_eq, LPFC_POLL_FASTPATH);
 		return 0;
 	}
 
@@ -19777,6 +19927,8 @@ lpfc_sli4_issue_wqe(struct lpfc_hba *phba, struct lpfc_sli4_hdw_queue *qp,
 		}
 		lpfc_sli_ringtxcmpl_put(phba, pring, pwqe);
 		spin_unlock_irqrestore(&pring->ring_lock, iflags);
+
+		lpfc_sli4_poll_eq(qp->hba_eq, LPFC_POLL_FASTPATH);
 		return 0;
 	}
 
@@ -19805,6 +19957,8 @@ lpfc_sli4_issue_wqe(struct lpfc_hba *phba, struct lpfc_sli4_hdw_queue *qp,
 		}
 		lpfc_sli_ringtxcmpl_put(phba, pring, pwqe);
 		spin_unlock_irqrestore(&pring->ring_lock, iflags);
+
+		lpfc_sli4_poll_eq(qp->hba_eq, LPFC_POLL_FASTPATH);
 		return 0;
 	}
 	return WQE_ERROR;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index bbe24c19b1d9..ef32159248d7 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -133,6 +133,23 @@ struct lpfc_rqb {
 struct lpfc_queue {
 	struct list_head list;
 	struct list_head wq_list;
+
+	/*
+	 * If interrupts are in effect on _all_ the eq's the footprint
+	 * of polling code is zero (except mode). This memory is chec-
+	 * ked for every io to see if the io needs to be polled and
+	 * while completion to check if the eq's needs to be rearmed.
+	 * Keep in same cacheline as the queue ptr to avoid cpu fetch
+	 * stalls. Using 1B memory will leave us with 7B hole. Fill
+	 * it with other frequently used members.
+	 */
+	uint16_t last_cpu;	/* most recent cpu */
+	uint16_t hdwq;
+	uint8_t	 qe_valid;
+	uint8_t  mode;	/* interrupt or polling */
+#define LPFC_EQ_INTERRUPT	0
+#define LPFC_EQ_POLL		1
+
 	struct list_head wqfull_list;
 	enum lpfc_sli4_queue_type type;
 	enum lpfc_sli4_queue_subtype subtype;
@@ -240,10 +257,8 @@ struct lpfc_queue {
 	struct delayed_work	sched_spwork;
 
 	uint64_t isr_timestamp;
-	uint16_t hdwq;
-	uint16_t last_cpu;	/* most recent cpu */
-	uint8_t	qe_valid;
 	struct lpfc_queue *assoc_qp;
+	struct list_head _poll_list;
 	void **q_pgs;	/* array to index entries per page */
 };
 
-- 
2.13.7

