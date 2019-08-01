Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC687E1B5
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbfHAR5b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38549 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732802AbfHAR53 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so34515526pfn.5
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSQ+yBy1kHF68ISVyJt4oIvpOevm5PoC0wJngPXOZZM=;
        b=YTQwoXSzrAmi8aQ3scUQLJSPUDfV9K0fUU7Ehoc766hzMuU9rPCftZYtwoxNcH7UAp
         iIQk+995dHc/dNg27SanJtc2BJXJ0t2s2ityzMPNTGHSWsqtVOVaTAiMoLXBg6EIQdqq
         y7/BfbbJ2gAZFEQIZr1sWn8vBy+JYCkinvkXUn/K3G1JXvzdAZRZZVEEVnySM3083wWh
         2H0idx4wDMFXQFP3F/fMyzyVosJzF0TBTHOfsnqdyyudrvhohmuEkd+U/Adrgfn3Lhay
         hyXnNPwxQJ2VKtbH3IIHJo1o2ZyqYrQqEjG6ip9OxWPHMpyyCJoNymjW3+VoRpBPK8Ru
         SECA==
X-Gm-Message-State: APjAAAX1iZzWiRvvxzHA3RPRXljPka6tzpxNGLPjQGkAaR91giHqTAcp
        fEAgs+8a4p9xEqeOC14ysl0=
X-Google-Smtp-Source: APXvYqzrsML+L0ocX/SQOzWi6+eINrQtwuWZSjFhwU7lXp++VH1LU8XOuPIul2HTtLlRAPgWRryYwg==
X-Received: by 2002:a17:90a:d14a:: with SMTP id t10mr2765pjw.85.1564682248548;
        Thu, 01 Aug 2019 10:57:28 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 49/59] qla2xxx: Introduce qla2xxx_get_next_handle()
Date:   Thu,  1 Aug 2019 10:56:04 -0700
Message-Id: <20190801175614.73655-50-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch reduces code duplication.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gbl.h  |   1 +
 drivers/scsi/qla2xxx/qla_iocb.c | 128 +++++++++-----------------------
 drivers/scsi/qla2xxx/qla_mr.c   |  13 +---
 drivers/scsi/qla2xxx/qla_nvme.c |  14 +---
 4 files changed, 42 insertions(+), 114 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 047d92a01d4a..1d4b9cbdb6ce 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -272,6 +272,7 @@ extern void qla2x00_build_scsi_iocbs_32(srb_t *, cmd_entry_t *, uint16_t);
 extern void qla2x00_build_scsi_iocbs_64(srb_t *, cmd_entry_t *, uint16_t);
 extern void qla24xx_build_scsi_iocbs(srb_t *, struct cmd_type_7 *,
 	uint16_t, struct req_que *);
+extern uint32_t qla2xxx_get_next_handle(struct req_que *req);
 extern int qla2x00_start_scsi(srb_t *sp);
 extern int qla24xx_start_scsi(srb_t *sp);
 int qla2x00_marker(struct scsi_qla_host *, struct qla_qpair *,
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 59a0a778d31c..22d875222321 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -292,6 +292,26 @@ void qla2x00_build_scsi_iocbs_64(srb_t *sp, cmd_entry_t *cmd_pkt,
 	}
 }
 
+/*
+ * Find the first handle that is not in use, starting from
+ * req->current_outstanding_cmd + 1. The caller must hold the lock that is
+ * associated with @req.
+ */
+uint32_t qla2xxx_get_next_handle(struct req_que *req)
+{
+	uint32_t index, handle = req->current_outstanding_cmd;
+
+	for (index = 1; index < req->num_outstanding_cmds; index++) {
+		handle++;
+		if (handle == req->num_outstanding_cmds)
+			handle = 1;
+		if (!req->outstanding_cmds[handle])
+			return handle;
+	}
+
+	return 0;
+}
+
 /**
  * qla2x00_start_scsi() - Send a SCSI command to the ISP
  * @sp: command to send to the ISP
@@ -306,7 +326,6 @@ qla2x00_start_scsi(srb_t *sp)
 	scsi_qla_host_t	*vha;
 	struct scsi_cmnd *cmd;
 	uint32_t	*clr_ptr;
-	uint32_t        index;
 	uint32_t	handle;
 	cmd_entry_t	*cmd_pkt;
 	uint16_t	cnt;
@@ -339,16 +358,8 @@ qla2x00_start_scsi(srb_t *sp)
 	/* Acquire ring specific lock */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-	if (index == req->num_outstanding_cmds)
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0)
 		goto queuing_error;
 
 	/* Map the sg table so we have an accurate count of sg entries needed */
@@ -1584,7 +1595,6 @@ qla24xx_start_scsi(srb_t *sp)
 	int		nseg;
 	unsigned long   flags;
 	uint32_t	*clr_ptr;
-	uint32_t        index;
 	uint32_t	handle;
 	struct cmd_type_7 *cmd_pkt;
 	uint16_t	cnt;
@@ -1612,16 +1622,8 @@ qla24xx_start_scsi(srb_t *sp)
 	/* Acquire ring specific lock */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-	if (index == req->num_outstanding_cmds)
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0)
 		goto queuing_error;
 
 	/* Map the sg table so we have an accurate count of sg entries needed */
@@ -1724,7 +1726,6 @@ qla24xx_dif_start_scsi(srb_t *sp)
 	int			nseg;
 	unsigned long		flags;
 	uint32_t		*clr_ptr;
-	uint32_t		index;
 	uint32_t		handle;
 	uint16_t		cnt;
 	uint16_t		req_cnt = 0;
@@ -1765,17 +1766,8 @@ qla24xx_dif_start_scsi(srb_t *sp)
 	/* Acquire ring specific lock */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-
-	if (index == req->num_outstanding_cmds)
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0)
 		goto queuing_error;
 
 	/* Compute number of required data segments */
@@ -1920,7 +1912,6 @@ qla2xxx_start_scsi_mq(srb_t *sp)
 	int		nseg;
 	unsigned long   flags;
 	uint32_t	*clr_ptr;
-	uint32_t        index;
 	uint32_t	handle;
 	struct cmd_type_7 *cmd_pkt;
 	uint16_t	cnt;
@@ -1951,16 +1942,8 @@ qla2xxx_start_scsi_mq(srb_t *sp)
 		vha->marker_needed = 0;
 	}
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-	if (index == req->num_outstanding_cmds)
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0)
 		goto queuing_error;
 
 	/* Map the sg table so we have an accurate count of sg entries needed */
@@ -2064,7 +2047,6 @@ qla2xxx_dif_start_scsi_mq(srb_t *sp)
 	int			nseg;
 	unsigned long		flags;
 	uint32_t		*clr_ptr;
-	uint32_t		index;
 	uint32_t		handle;
 	uint16_t		cnt;
 	uint16_t		req_cnt = 0;
@@ -2119,17 +2101,8 @@ qla2xxx_dif_start_scsi_mq(srb_t *sp)
 		vha->marker_needed = 0;
 	}
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-
-	if (index == req->num_outstanding_cmds)
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0)
 		goto queuing_error;
 
 	/* Compute number of required data segments */
@@ -2276,7 +2249,7 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	struct qla_hw_data *ha = vha->hw;
 	struct req_que *req = qpair->req;
 	device_reg_t *reg = ISP_QUE_REG(ha, req->id);
-	uint32_t index, handle;
+	uint32_t handle;
 	request_t *pkt;
 	uint16_t cnt, req_cnt;
 
@@ -2316,16 +2289,8 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 		goto queuing_error;
 
 	if (sp) {
-		/* Check for room in outstanding command list. */
-		handle = req->current_outstanding_cmd;
-		for (index = 1; index < req->num_outstanding_cmds; index++) {
-			handle++;
-			if (handle == req->num_outstanding_cmds)
-				handle = 1;
-			if (!req->outstanding_cmds[handle])
-				break;
-		}
-		if (index == req->num_outstanding_cmds) {
+		handle = qla2xxx_get_next_handle(req);
+		if (handle == 0) {
 			ql_log(ql_log_warn, vha, 0x700b,
 			    "No room on outstanding cmd array.\n");
 			goto queuing_error;
@@ -3112,7 +3077,6 @@ qla82xx_start_scsi(srb_t *sp)
 	unsigned long   flags;
 	struct scsi_cmnd *cmd;
 	uint32_t	*clr_ptr;
-	uint32_t        index;
 	uint32_t	handle;
 	uint16_t	cnt;
 	uint16_t	req_cnt;
@@ -3152,16 +3116,8 @@ qla82xx_start_scsi(srb_t *sp)
 	/* Acquire ring specific lock */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-	if (index == req->num_outstanding_cmds)
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0)
 		goto queuing_error;
 
 	/* Map the sg table so we have an accurate count of sg entries needed */
@@ -3769,7 +3725,6 @@ qla2x00_start_bidir(srb_t *sp, struct scsi_qla_host *vha, uint32_t tot_dsds)
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
 	uint32_t handle;
-	uint32_t index;
 	uint16_t req_cnt;
 	uint16_t cnt;
 	uint32_t *clr_ptr;
@@ -3794,17 +3749,8 @@ qla2x00_start_bidir(srb_t *sp, struct scsi_qla_host *vha, uint32_t tot_dsds)
 	/* Acquire ring specific lock */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-
-	if (index == req->num_outstanding_cmds) {
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0) {
 		rval = EXT_STATUS_BUSY;
 		goto queuing_error;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index e8da3ec4db2c..06985b2d48eb 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -3071,7 +3071,6 @@ qlafx00_start_scsi(srb_t *sp)
 {
 	int		nseg;
 	unsigned long   flags;
-	uint32_t        index;
 	uint32_t	handle;
 	uint16_t	cnt;
 	uint16_t	req_cnt;
@@ -3095,16 +3094,8 @@ qlafx00_start_scsi(srb_t *sp)
 	/* Acquire ring specific lock */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-	if (index == req->num_outstanding_cmds)
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0)
 		goto queuing_error;
 
 	/* Map the sg table so we have an accurate count of sg entries needed */
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index af6b46777602..6cc19e060afc 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -353,7 +353,6 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 {
 	unsigned long   flags;
 	uint32_t        *clr_ptr;
-	uint32_t        index;
 	uint32_t        handle;
 	struct cmd_nvme *cmd_pkt;
 	uint16_t        cnt, i;
@@ -377,17 +376,8 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 	/* Acquire qpair specific lock */
 	spin_lock_irqsave(&qpair->qp_lock, flags);
 
-	/* Check for room in outstanding command list. */
-	handle = req->current_outstanding_cmd;
-	for (index = 1; index < req->num_outstanding_cmds; index++) {
-		handle++;
-		if (handle == req->num_outstanding_cmds)
-			handle = 1;
-		if (!req->outstanding_cmds[handle])
-			break;
-	}
-
-	if (index == req->num_outstanding_cmds) {
+	handle = qla2xxx_get_next_handle(req);
+	if (handle == 0) {
 		rval = -EBUSY;
 		goto queuing_error;
 	}
-- 
2.22.0.770.g0f2c4a37fd-goog

