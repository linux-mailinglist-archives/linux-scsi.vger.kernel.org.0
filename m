Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715763EAE6C
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Aug 2021 04:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhHMCJ2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Aug 2021 22:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbhHMCJV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Aug 2021 22:09:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA43DC0617A8
        for <linux-scsi@vger.kernel.org>; Thu, 12 Aug 2021 19:08:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so18509992pjs.0
        for <linux-scsi@vger.kernel.org>; Thu, 12 Aug 2021 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1r9F4BcVJaFoaV+ssKQiiY/3FWjB0yLdcG6fY/wnbdU=;
        b=vP5buMa7uTkN7bEFv7CdRzNqBVgtxv8QCwDqxsNr/eWGZy51YenEFSBG95SoX+2CI3
         93ELd6rKc2n2592SRQtKo7whvpX+RufjrGQsprebUlL16xRwXdD6R6LigG504iNE6b8C
         mFEkw03+vFJ6p4uzj2iO4YEolvdq0/x+kdznmTILMFOjIKWtOl3Jt2/s2ybPblBQTIW6
         f4kwhP7L2fxuQ3pkf7A1i4Jc0oMTYeglw65EJdPleMyCI7YLWnoK1F7cAGyDdkDi1Xei
         yuYsa8sCuhgjUcr7j/IteCz+UL0LFxPOFR3QeBOmtutA3a0LHuHcG00NIUNVjGWO+owZ
         2I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1r9F4BcVJaFoaV+ssKQiiY/3FWjB0yLdcG6fY/wnbdU=;
        b=Z5RwR6gSjbYiDYeTmSfApAC1EIDQeVDnuYzEvThJlQalcDzebhgQ/ILtIVQH+mDalh
         cNwEX8yk2IlmPxbQJxFFLutwwJHiRwiTRXmfdE9d1aWq3OOzsmCbLy8sKYgge3bPi1jE
         yUAH9FL6d6qg00VzNYjGrkU/44vspDP0yj0gUKT8CI+ZWl0Ia7d0pa12Zy7+wSOuWLqd
         7xhxw9LscctXeuT8C25y+uMNfohKmCz4GS7mclLwtfg2BdIaXYwM42/3jXPvi/dPnurg
         TSwAwzzI603E9X0qTSZ3EHiXXv86OZ7eZ7ASulOAwqkgYaZrKDBvuUAJxkrAUBGokoK1
         yP3w==
X-Gm-Message-State: AOAM530zKnxwudvmJXSNR7vJMxXLIJ2sH003lBAjdBXLOJ45vLnTPl2U
        UJaFLaFtmO3oofzQadgA0524lC1T/Hs=
X-Google-Smtp-Source: ABdhPJxCV+ZzR0U52vVbYEuQaaSLNCb/ApxHQbXKpTwduwWgHQMjMw+MGV0vAC8CO+I8ReT+0hWEgw==
X-Received: by 2002:a63:1d63:: with SMTP id d35mr75983pgm.238.1628820535467;
        Thu, 12 Aug 2021 19:08:55 -0700 (PDT)
Received: from localhost.localdomain (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id ca7sm102619pjb.11.2021.08.12.19.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 19:08:55 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 10/16] lpfc: Add rx monitoring statistics
Date:   Thu, 12 Aug 2021 19:08:06 -0700
Message-Id: <20210813020812.99014-11-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210813020812.99014-1-jsmart2021@gmail.com>
References: <20210813020812.99014-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver provides overwatch of the cm behavior by maintaining a set
of rx io statistics. This information is also used in later updating
of the cm statistics buffer.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      | 21 +++++++++++++++
 drivers/scsi/lpfc/lpfc_init.c | 50 +++++++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_mem.c  |  4 +++
 drivers/scsi/lpfc/lpfc_scsi.c |  2 ++
 drivers/scsi/lpfc/lpfc_sli.c  | 15 +++++++++++
 5 files changed, 92 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 298b908e9126..640075885540 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1546,6 +1546,12 @@ struct lpfc_hba {
 	u32 cgn_sig_freq;
 	u32 cgn_acqe_cnt;
 
+	/* RX monitor handling for CMF */
+	struct rxtable_entry *rxtable;  /* RX_monitor information */
+	atomic_t rxtable_idx_head;
+#define LPFC_RXMONITOR_TABLE_IN_USE     (LPFC_MAX_RXMONITOR_ENTRY + 73)
+	atomic_t rxtable_idx_tail;
+	atomic_t rx_max_read_cnt;       /* Maximum read bytes */
 	uint64_t rx_block_cnt;
 
 	/* Congestion parameters from flash */
@@ -1591,6 +1597,21 @@ struct lpfc_hba {
 	struct dbg_log_ent dbg_log[DBG_LOG_SZ];
 };
 
+#define LPFC_MAX_RXMONITOR_ENTRY	800
+struct rxtable_entry {
+	uint64_t total_bytes;   /* Total no of read bytes requested */
+	uint64_t rcv_bytes;     /* Total no of read bytes completed */
+	uint64_t avg_io_size;
+	uint64_t avg_io_latency;/* Average io latency in microseconds */
+	uint64_t max_read_cnt;  /* Maximum read bytes */
+	uint64_t max_bytes_per_interval;
+	uint32_t cmf_busy;
+	uint32_t cmf_info;      /* CMF_SYNC_WQE info */
+	uint32_t io_cnt;
+	uint32_t timer_utilization;
+	uint32_t timer_interval;
+};
+
 static inline struct Scsi_Host *
 lpfc_shost_from_vport(struct lpfc_vport *vport)
 {
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 65d5ee9b3e30..b4b5326cb57c 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -5452,9 +5452,13 @@ lpfc_cmf_timer(struct hrtimer *timer)
 {
 	struct lpfc_hba *phba = container_of(timer, struct lpfc_hba,
 					     cmf_timer);
+	struct rxtable_entry *entry;
 	uint32_t io_cnt;
+	uint32_t head, tail;
+	uint32_t busy, max_read;
 	uint64_t total, rcv, lat, mbpi;
 	int timer_interval = LPFC_CMF_INTERVAL;
+	uint32_t ms;
 	struct lpfc_cgn_stat *cgs;
 	int cpu;
 
@@ -5479,6 +5483,14 @@ lpfc_cmf_timer(struct hrtimer *timer)
 	 */
 	atomic_set(&phba->cmf_stop_io, 1);
 
+	/* First we need to calculate the actual ms between
+	 * the last timer interrupt and this one. We ask for
+	 * LPFC_CMF_INTERVAL, however the actual time may
+	 * vary depending on system overhead.
+	 */
+	ms = lpfc_calc_cmf_latency(phba);
+
+
 	/* Immediately after we calculate the time since the last
 	 * timer interrupt, set the start time for the next
 	 * interrupt
@@ -5525,6 +5537,8 @@ lpfc_cmf_timer(struct hrtimer *timer)
 		atomic_add(io_cnt, &phba->cgn_latency_evt_cnt);
 		atomic64_add(lat, &phba->cgn_latency_evt);
 	}
+	busy = atomic_xchg(&phba->cmf_busy, 0);
+	max_read = atomic_xchg(&phba->rx_max_read_cnt, 0);
 
 	/* Calculate MBPI for the next timer interval */
 	if (mbpi) {
@@ -5539,6 +5553,42 @@ lpfc_cmf_timer(struct hrtimer *timer)
 			phba->cmf_max_bytes_per_interval = mbpi;
 	}
 
+	/* Save rxmonitor information for debug */
+	if (phba->rxtable) {
+		head = atomic_xchg(&phba->rxtable_idx_head,
+				   LPFC_RXMONITOR_TABLE_IN_USE);
+		entry = &phba->rxtable[head];
+		entry->total_bytes = total;
+		entry->rcv_bytes = rcv;
+		entry->cmf_busy = busy;
+		entry->cmf_info = phba->cmf_active_info;
+		if (io_cnt) {
+			entry->avg_io_latency = lat / io_cnt;
+			entry->avg_io_size = rcv / io_cnt;
+		} else {
+			entry->avg_io_latency = 0;
+			entry->avg_io_size = 0;
+		}
+		entry->max_read_cnt = max_read;
+		entry->io_cnt = io_cnt;
+		entry->max_bytes_per_interval = mbpi;
+		if (phba->cmf_active_mode == LPFC_CFG_MANAGED)
+			entry->timer_utilization = phba->cmf_last_ts;
+		else
+			entry->timer_utilization = ms;
+		entry->timer_interval = ms;
+		phba->cmf_last_ts = 0;
+
+		/* Increment rxtable index */
+		head = (head + 1) % LPFC_MAX_RXMONITOR_ENTRY;
+		tail = atomic_read(&phba->rxtable_idx_tail);
+		if (head == tail) {
+			tail = (tail + 1) % LPFC_MAX_RXMONITOR_ENTRY;
+			atomic_set(&phba->rxtable_idx_tail, tail);
+		}
+		atomic_set(&phba->rxtable_idx_head, head);
+	}
+
 	if (phba->cmf_active_mode == LPFC_CFG_MONITOR) {
 		/* If Monitor mode, check if we are oversubscribed
 		 * against the full line rate.
diff --git a/drivers/scsi/lpfc/lpfc_mem.c b/drivers/scsi/lpfc/lpfc_mem.c
index bbb181ab334b..7cb9f4b52b49 100644
--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -344,6 +344,10 @@ lpfc_mem_free_all(struct lpfc_hba *phba)
 		phba->cgn_i = NULL;
 	}
 
+	/* Free RX table */
+	kfree(phba->rxtable);
+	phba->rxtable = NULL;
+
 	/* Free the iocb lookup array */
 	kfree(psli->iocbq_lookup);
 	psli->iocbq_lookup = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 11f26582e68c..e85c911f3b6c 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -3981,6 +3981,8 @@ lpfc_update_cmf_cmd(struct lpfc_hba *phba, uint32_t size)
 			atomic_inc(&phba->cmf_busy);
 			return -EBUSY;
 		}
+		if (size > atomic_read(&phba->rx_max_read_cnt))
+			atomic_set(&phba->rx_max_read_cnt, size);
 	}
 
 	cgs = this_cpu_ptr(phba->cmf_stat);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 6d256a509ea3..3dfb90a04783 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -8066,6 +8066,21 @@ lpfc_cmf_setup(struct lpfc_hba *phba)
 	atomic64_set(&phba->cgn_latency_evt, 0);
 
 	phba->cmf_interval_rate = LPFC_CMF_INTERVAL;
+
+	/* Allocate RX Monitor Buffer */
+	if (!phba->rxtable) {
+		phba->rxtable = kmalloc_array(LPFC_MAX_RXMONITOR_ENTRY,
+					      sizeof(struct rxtable_entry),
+					      GFP_KERNEL);
+		if (!phba->rxtable) {
+			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
+					"2644 Failed to alloc memory "
+					"for RX Monitor Buffer\n");
+			return -ENOMEM;
+		}
+	}
+	atomic_set(&phba->rxtable_idx_head, 0);
+	atomic_set(&phba->rxtable_idx_tail, 0);
 	return 0;
 }
 
-- 
2.26.2

