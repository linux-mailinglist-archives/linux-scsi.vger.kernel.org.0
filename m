Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C417A364017
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Apr 2021 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbhDSLCk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 07:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDSLCf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 07:02:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B717C06174A
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 04:02:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so14108644pjb.4
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gi1ml2eB2TOn78rM8V7tTJioatk83acPhfWrnPsrXM8=;
        b=EqfQWoWbBeKYy7ueyZU5N6D6EvC8YgQl6OWQfSvI9MYyfOtgUSKDAlTWhoQwubGx/7
         TAgMW+s9pkfjnmkrMdM+AnNB9OPlkeex1O/L7sVd/iOP4RD8moYzEexfnoUX8O6ZAx+U
         LasMI6018CLeviskjCuUFBt3Y2wgER0knmd48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gi1ml2eB2TOn78rM8V7tTJioatk83acPhfWrnPsrXM8=;
        b=JEXBEDgLwhvvPQ5u0II4B2TwfQez0hOw0TwIS53aJICzKydgsEdhejGwwOYqmFbx7B
         IzwTWVTQgTe1CEMUkVyKS4C/0rSyJYcOh/Pnif8ULwn5WUJwHHCUaM1F6/X2fdfrf76a
         hFsf/myEAwvSRfaz3bBQNmXcY507523R6DuKbXmAb7SzFDc42mhUI/LTBgudlgiMrXSE
         1RgDspFKN7X/q00bWDdenWylMPVprkNu+/s31emmuTR2xRw9MVWQ04AEMLY9MrRnVOTi
         UjTXLrJpN5HYibie8UgAskJk4ZEiPye9uUf1vNx1xMMf3WQhgQWpoDriDIPQOlMKl3WY
         M2JQ==
X-Gm-Message-State: AOAM533tJrpdvLPqTzpEUu7G7PaHNdPKmlIOxEdb56dIvXn//wxEZTSR
        /TbkFh1qmgoMG5SLwdncOmTjNtDBHjccUonLKtwNz/Gy1fQ236Xu7pDLblgp4wpcrBgPcVGmG2a
        aXC/7OAYeWlTzwS8TtVOIHgmbqa3lQa6jX+6uuO17h4WB3bdFzIBEPZvqAKkwBNLrI4OU2eLgjI
        0BmGn/Y8NS
X-Google-Smtp-Source: ABdhPJylnO0WLfgI0eJzIGKl6mT7U5krS+M8Lotzl3XI476jbMaoPxhdnchKi5DrmNZKJtB8Oc8MWg==
X-Received: by 2002:a17:90a:4410:: with SMTP id s16mr23950295pjg.203.1618830124383;
        Mon, 19 Apr 2021 04:02:04 -0700 (PDT)
Received: from drv-bst-rhel8.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k13sm11825736pfc.50.2021.04.19.04.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:02:03 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        sathya.prakash@broadcom.com
Subject: [PATCH v3 03/24] mpi3mr: create operational request and reply queue pair
Date:   Mon, 19 Apr 2021 16:31:35 +0530
Message-Id: <20210419110156.1786882-4-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210419110156.1786882-1-kashyap.desai@broadcom.com>
References: <20210419110156.1786882-1-kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008cfa5805c0514246"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000008cfa5805c0514246

Create operational request and reply queue pair.

The MPI3 transport interface consists of an Administrative Request Queue,
an Administrative Reply Queue, and Operational Messaging Queues.
The Operational Messaging Queues are the primary communication mechanism
between the host and the I/O Controller (IOC).
Request messages, allocated in host memory, identify I/O operations to be
performed by the IOC. These operations are queued on an Operational
Request Queue by the host driver.
Reply descriptors track I/O operations as they complete.
The IOC queues these completions in an Operational Reply Queue.

To fulfil large contiguous memory requirement, driver creates multiple
segments and provide the list of segments. Each segment size should be 4K
which is h/w requirement. An element array is contiguous or segmented.
A contiguous element array is located in contiguous physical memory.
A contiguous element array must be aligned on an element size boundary.
An element's physical address within the array may be directly calculated
from the base address, the Producer/Consumer index, and the element size.

Expected phased identifier bit is used to find out valid entry on reply queue.
Driver set <ephase> bit and IOC invert the value of this bit on each pass.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Cc: sathya.prakash@broadcom.com
---
 drivers/scsi/mpi3mr/mpi3mr.h    |  56 +++
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 601 ++++++++++++++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr_os.c |   4 +-
 3 files changed, 660 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index cf1cfea19826..c26105b23759 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -71,6 +71,12 @@ extern struct list_head mrioc_list;
 #define MPI3MR_ADMIN_REQ_FRAME_SZ	128
 #define MPI3MR_ADMIN_REPLY_FRAME_SZ	16
 
+/* Operational queue management definitions */
+#define MPI3MR_OP_REQ_Q_QD		512
+#define MPI3MR_OP_REP_Q_QD		4096
+#define MPI3MR_OP_REQ_Q_SEG_SIZE	4096
+#define MPI3MR_OP_REP_Q_SEG_SIZE	4096
+#define MPI3MR_MAX_SEG_LIST_SIZE	4096
 
 /* Reserved Host Tag definitions */
 #define MPI3MR_HOSTTAG_INVALID		0xFFFF
@@ -132,6 +138,9 @@ extern struct list_head mrioc_list;
 	(MPI3_SGE_FLAGS_ELEMENT_TYPE_SIMPLE | MPI3_SGE_FLAGS_DLAS_SYSTEM | \
 	MPI3_SGE_FLAGS_END_OF_LIST)
 
+/* MSI Index from Reply Queue Index */
+#define REPLY_QUEUE_IDX_TO_MSIX_IDX(qidx, offset)	(qidx + offset)
+
 /* IOC State definitions */
 enum mpi3mr_iocstate {
 	MRIOC_STATE_READY = 1,
@@ -222,15 +231,45 @@ struct mpi3mr_ioc_facts {
 	u8 sge_mod_shift;
 };
 
+/**
+ * struct segments - memory descriptor structure to store
+ * virtual and dma addresses for operational queue segments.
+ *
+ * @segment: virtual address
+ * @segment_dma: dma address
+ */
+struct segments {
+	void *segment;
+	dma_addr_t segment_dma;
+};
+
 /**
  * struct op_req_qinfo -  Operational Request Queue Information
  *
  * @ci: consumer index
  * @pi: producer index
+ * @num_request: Maximum number of entries in the queue
+ * @qid: Queue Id starting from 1
+ * @reply_qid: Associated reply queue Id
+ * @num_segments: Number of discontiguous memory segments
+ * @segment_qd: Depth of each segments
+ * @q_lock: Concurrent queue access lock
+ * @q_segments: Segment descriptor pointer
+ * @q_segment_list: Segment list base virtual address
+ * @q_segment_list_dma: Segment list base DMA address
  */
 struct op_req_qinfo {
 	u16 ci;
 	u16 pi;
+	u16 num_requests;
+	u16 qid;
+	u16 reply_qid;
+	u16 num_segments;
+	u16 segment_qd;
+	spinlock_t q_lock;
+	struct segments *q_segments;
+	void *q_segment_list;
+	dma_addr_t q_segment_list_dma;
 };
 
 /**
@@ -238,10 +277,24 @@ struct op_req_qinfo {
  *
  * @ci: consumer index
  * @qid: Queue Id starting from 1
+ * @num_replies: Maximum number of entries in the queue
+ * @num_segments: Number of discontiguous memory segments
+ * @segment_qd: Depth of each segments
+ * @q_segments: Segment descriptor pointer
+ * @q_segment_list: Segment list base virtual address
+ * @q_segment_list_dma: Segment list base DMA address
+ * @ephase: Expected phased identifier for the reply queue
  */
 struct op_reply_qinfo {
 	u16 ci;
 	u16 qid;
+	u16 num_replies;
+	u16 num_segments;
+	u16 segment_qd;
+	struct segments *q_segments;
+	void *q_segment_list;
+	dma_addr_t q_segment_list_dma;
+	u8 ephase;
 };
 
 /**
@@ -401,6 +454,7 @@ struct scmd_priv {
  * @current_event: Firmware event currently in process
  * @driver_info: Driver, Kernel, OS information to firmware
  * @change_count: Topology change count
+ * @op_reply_q_offset: Operational reply queue offset with MSIx
  */
 struct mpi3mr_ioc {
 	struct list_head list;
@@ -408,6 +462,7 @@ struct mpi3mr_ioc {
 	struct Scsi_Host *shost;
 	u8 id;
 	int cpu_count;
+	bool enable_segqueue;
 
 	char name[MPI3MR_NAME_LENGTH];
 	char driver_name[MPI3MR_NAME_LENGTH];
@@ -494,6 +549,7 @@ struct mpi3mr_ioc {
 	struct mpi3mr_fwevt *current_event;
 	Mpi3DriverInfoLayout_t driver_info;
 	u16 change_count;
+	u16 op_reply_q_offset;
 };
 
 int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 330f675444e9..694e54bbb07c 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -405,6 +405,8 @@ static int mpi3mr_setup_isr(struct mpi3mr_ioc *mrioc, u8 setup_one)
 
 	irq_flags |= PCI_IRQ_AFFINITY | PCI_IRQ_ALL_TYPES;
 
+	mrioc->op_reply_q_offset = (max_vectors > 1) ? 1 : 0;
+
 	i = pci_alloc_irq_vectors_affinity(mrioc->pdev,
 	    1, max_vectors, irq_flags, &desc);
 	if (i <= 0) {
@@ -415,6 +417,12 @@ static int mpi3mr_setup_isr(struct mpi3mr_ioc *mrioc, u8 setup_one)
 		ioc_info(mrioc,
 		    "allocated vectors (%d) are less than configured (%d)\n",
 		    i, max_vectors);
+		/*
+		 * If only one MSI-x is allocated, then MSI-x 0 will be shared
+		 * between Admin queue and operational queue
+		 */
+		if (i == 1)
+			mrioc->op_reply_q_offset = 0;
 
 		max_vectors = i;
 	}
@@ -723,6 +731,586 @@ int mpi3mr_admin_request_post(struct mpi3mr_ioc *mrioc, void *admin_req,
 	return retval;
 }
 
+/**
+ * mpi3mr_free_op_req_q_segments - free request memory segments
+ * @mrioc: Adapter instance reference
+ * @q_idx: operational request queue index
+ *
+ * Free memory segments allocated for operational request queue
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_free_op_req_q_segments(struct mpi3mr_ioc *mrioc, u16 q_idx)
+{
+	u16 j;
+	int size;
+	struct segments *segments;
+
+	segments = mrioc->req_qinfo[q_idx].q_segments;
+	if (!segments)
+		return;
+
+	if (mrioc->enable_segqueue) {
+		size = MPI3MR_OP_REQ_Q_SEG_SIZE;
+		if (mrioc->req_qinfo[q_idx].q_segment_list) {
+			dma_free_coherent(&mrioc->pdev->dev,
+			    MPI3MR_MAX_SEG_LIST_SIZE,
+			    mrioc->req_qinfo[q_idx].q_segment_list,
+			    mrioc->req_qinfo[q_idx].q_segment_list_dma);
+			mrioc->op_reply_qinfo[q_idx].q_segment_list = NULL;
+		}
+	} else
+		size = mrioc->req_qinfo[q_idx].num_requests *
+		    mrioc->facts.op_req_sz;
+
+	for (j = 0; j < mrioc->req_qinfo[q_idx].num_segments; j++) {
+		if (!segments[j].segment)
+			continue;
+		dma_free_coherent(&mrioc->pdev->dev,
+		    size, segments[j].segment, segments[j].segment_dma);
+		segments[j].segment = NULL;
+	}
+	kfree(mrioc->req_qinfo[q_idx].q_segments);
+	mrioc->req_qinfo[q_idx].q_segments = NULL;
+	mrioc->req_qinfo[q_idx].qid = 0;
+}
+
+/**
+ * mpi3mr_free_op_reply_q_segments - free reply memory segments
+ * @mrioc: Adapter instance reference
+ * @q_idx: operational reply queue index
+ *
+ * Free memory segments allocated for operational reply queue
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_free_op_reply_q_segments(struct mpi3mr_ioc *mrioc, u16 q_idx)
+{
+	u16 j;
+	int size;
+	struct segments *segments;
+
+	segments = mrioc->op_reply_qinfo[q_idx].q_segments;
+	if (!segments)
+		return;
+
+	if (mrioc->enable_segqueue) {
+		size = MPI3MR_OP_REP_Q_SEG_SIZE;
+		if (mrioc->op_reply_qinfo[q_idx].q_segment_list) {
+			dma_free_coherent(&mrioc->pdev->dev,
+			    MPI3MR_MAX_SEG_LIST_SIZE,
+			    mrioc->op_reply_qinfo[q_idx].q_segment_list,
+			    mrioc->op_reply_qinfo[q_idx].q_segment_list_dma);
+			mrioc->op_reply_qinfo[q_idx].q_segment_list = NULL;
+		}
+	} else
+		size = mrioc->op_reply_qinfo[q_idx].segment_qd *
+		    mrioc->op_reply_desc_sz;
+
+	for (j = 0; j < mrioc->op_reply_qinfo[q_idx].num_segments; j++) {
+		if (!segments[j].segment)
+			continue;
+		dma_free_coherent(&mrioc->pdev->dev,
+		    size, segments[j].segment, segments[j].segment_dma);
+		segments[j].segment = NULL;
+	}
+
+	kfree(mrioc->op_reply_qinfo[q_idx].q_segments);
+	mrioc->op_reply_qinfo[q_idx].q_segments = NULL;
+	mrioc->op_reply_qinfo[q_idx].qid = 0;
+}
+
+/**
+ * mpi3mr_delete_op_reply_q - delete operational reply queue
+ * @mrioc: Adapter instance reference
+ * @qidx: operational reply queue index
+ *
+ * Delete operatinal reply queue by issuing MPI request
+ * through admin queue.
+ *
+ * Return:  0 on success, non-zero on failure.
+ */
+static int mpi3mr_delete_op_reply_q(struct mpi3mr_ioc *mrioc, u16 qidx)
+{
+	Mpi3DeleteReplyQueueRequest_t delq_req;
+	int retval = 0;
+	u16 reply_qid = 0, midx;
+
+	reply_qid = mrioc->op_reply_qinfo[qidx].qid;
+
+	midx = REPLY_QUEUE_IDX_TO_MSIX_IDX(qidx, mrioc->op_reply_q_offset);
+
+	if (!reply_qid)	{
+		retval = -1;
+		ioc_err(mrioc, "Issue DelRepQ: called with invalid ReqQID\n");
+		goto out;
+	}
+
+	memset(&delq_req, 0, sizeof(delq_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		retval = -1;
+		ioc_err(mrioc, "Issue DelRepQ: Init command is in use\n");
+		mutex_unlock(&mrioc->init_cmds.mutex);
+		goto out;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	delq_req.HostTag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	delq_req.Function = MPI3_FUNCTION_DELETE_REPLY_QUEUE;
+	delq_req.QueueID = cpu_to_le16(reply_qid);
+
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &delq_req, sizeof(delq_req),
+	    1);
+	if (retval) {
+		ioc_err(mrioc, "Issue DelRepQ: Admin Post failed\n");
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		ioc_err(mrioc, "Issue DelRepQ: command timed out\n");
+		mpi3mr_set_diagsave(mrioc);
+		mpi3mr_issue_reset(mrioc,
+		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT,
+		    MPI3MR_RESET_FROM_DELREPQ_TIMEOUT);
+		mrioc->unrecoverable = 1;
+
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc,
+		    "Issue DelRepQ: Failed IOCStatus(0x%04x) Loginfo(0x%08x)\n",
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+	mrioc->intr_info[midx].op_reply_q = NULL;
+
+	mpi3mr_free_op_reply_q_segments(mrioc, qidx);
+out_unlock:
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+out:
+
+	return retval;
+}
+
+/**
+ * mpi3mr_alloc_op_reply_q_segments -Alloc segmented reply pool
+ * @mrioc: Adapter instance reference
+ * @qidx: request queue index
+ *
+ * Allocate segmented memory pools for operational reply
+ * queue.
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+static int mpi3mr_alloc_op_reply_q_segments(struct mpi3mr_ioc *mrioc, u16 qidx)
+{
+	struct op_reply_qinfo *op_reply_q = mrioc->op_reply_qinfo + qidx;
+	int i, size;
+	u64 *q_segment_list_entry = NULL;
+	struct segments *segments;
+
+	if (mrioc->enable_segqueue) {
+		op_reply_q->segment_qd =
+		    MPI3MR_OP_REP_Q_SEG_SIZE / mrioc->op_reply_desc_sz;
+
+		size = MPI3MR_OP_REP_Q_SEG_SIZE;
+
+		op_reply_q->q_segment_list = dma_alloc_coherent(&mrioc->pdev->dev,
+		    MPI3MR_MAX_SEG_LIST_SIZE, &op_reply_q->q_segment_list_dma,
+		    GFP_KERNEL);
+		if (!op_reply_q->q_segment_list)
+			return -ENOMEM;
+		q_segment_list_entry = (u64 *)op_reply_q->q_segment_list;
+	} else {
+		op_reply_q->segment_qd = op_reply_q->num_replies;
+		size = op_reply_q->num_replies * mrioc->op_reply_desc_sz;
+	}
+
+	op_reply_q->num_segments = DIV_ROUND_UP(op_reply_q->num_replies,
+	    op_reply_q->segment_qd);
+
+	op_reply_q->q_segments = kcalloc(op_reply_q->num_segments,
+	    sizeof(struct segments), GFP_KERNEL);
+	if (!op_reply_q->q_segments)
+		return -ENOMEM;
+
+	segments = op_reply_q->q_segments;
+	for (i = 0; i < op_reply_q->num_segments; i++) {
+		segments[i].segment =
+		    dma_alloc_coherent(&mrioc->pdev->dev,
+		    size, &segments[i].segment_dma, GFP_KERNEL);
+		if (!segments[i].segment)
+			return -ENOMEM;
+		if (mrioc->enable_segqueue)
+			q_segment_list_entry[i] =
+			    (unsigned long)segments[i].segment_dma;
+	}
+
+	return 0;
+}
+
+/**
+ * mpi3mr_alloc_op_req_q_segments - Alloc segmented req pool.
+ * @mrioc: Adapter instance reference
+ * @qidx: request queue index
+ *
+ * Allocate segmented memory pools for operational request
+ * queue.
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+static int mpi3mr_alloc_op_req_q_segments(struct mpi3mr_ioc *mrioc, u16 qidx)
+{
+	struct op_req_qinfo *op_req_q = mrioc->req_qinfo + qidx;
+	int i, size;
+	u64 *q_segment_list_entry = NULL;
+	struct segments *segments;
+
+	if (mrioc->enable_segqueue) {
+		op_req_q->segment_qd =
+		    MPI3MR_OP_REQ_Q_SEG_SIZE / mrioc->facts.op_req_sz;
+
+		size = MPI3MR_OP_REQ_Q_SEG_SIZE;
+
+		op_req_q->q_segment_list = dma_alloc_coherent(&mrioc->pdev->dev,
+		    MPI3MR_MAX_SEG_LIST_SIZE, &op_req_q->q_segment_list_dma,
+		    GFP_KERNEL);
+		if (!op_req_q->q_segment_list)
+			return -ENOMEM;
+		q_segment_list_entry = (u64 *)op_req_q->q_segment_list;
+
+	} else {
+		op_req_q->segment_qd = op_req_q->num_requests;
+		size = op_req_q->num_requests * mrioc->facts.op_req_sz;
+	}
+
+	op_req_q->num_segments = DIV_ROUND_UP(op_req_q->num_requests,
+	    op_req_q->segment_qd);
+
+	op_req_q->q_segments = kcalloc(op_req_q->num_segments,
+	    sizeof(struct segments), GFP_KERNEL);
+	if (!op_req_q->q_segments)
+		return -ENOMEM;
+
+	segments = op_req_q->q_segments;
+	for (i = 0; i < op_req_q->num_segments; i++) {
+		segments[i].segment =
+		    dma_alloc_coherent(&mrioc->pdev->dev,
+		    size, &segments[i].segment_dma, GFP_KERNEL);
+		if (!segments[i].segment)
+			return -ENOMEM;
+		if (mrioc->enable_segqueue)
+			q_segment_list_entry[i] =
+			    (unsigned long)segments[i].segment_dma;
+	}
+
+	return 0;
+}
+
+/**
+ * mpi3mr_create_op_reply_q - create operational reply queue
+ * @mrioc: Adapter instance reference
+ * @qidx: operational reply queue index
+ *
+ * Create operatinal reply queue by issuing MPI request
+ * through admin queue.
+ *
+ * Return:  0 on success, non-zero on failure.
+ */
+static int mpi3mr_create_op_reply_q(struct mpi3mr_ioc *mrioc, u16 qidx)
+{
+	Mpi3CreateReplyQueueRequest_t create_req;
+	struct op_reply_qinfo *op_reply_q = mrioc->op_reply_qinfo + qidx;
+	int retval = 0;
+	u16 reply_qid = 0, midx;
+
+
+	reply_qid = op_reply_q->qid;
+
+	midx = REPLY_QUEUE_IDX_TO_MSIX_IDX(qidx, mrioc->op_reply_q_offset);
+
+	if (reply_qid) {
+		retval = -1;
+		ioc_err(mrioc, "CreateRepQ: called for duplicate qid %d\n",
+		    reply_qid);
+
+		return retval;
+	}
+
+	reply_qid = qidx + 1;
+	op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD;
+	op_reply_q->ci = 0;
+	op_reply_q->ephase = 1;
+
+	if (!op_reply_q->q_segments) {
+		retval = mpi3mr_alloc_op_reply_q_segments(mrioc, qidx);
+		if (retval) {
+			mpi3mr_free_op_reply_q_segments(mrioc, qidx);
+			goto out;
+		}
+	}
+
+	memset(&create_req, 0, sizeof(create_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		retval = -1;
+		ioc_err(mrioc, "CreateRepQ: Init command is in use\n");
+		goto out;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	create_req.HostTag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	create_req.Function = MPI3_FUNCTION_CREATE_REPLY_QUEUE;
+	create_req.QueueID = cpu_to_le16(reply_qid);
+	create_req.Flags = MPI3_CREATE_REPLY_QUEUE_FLAGS_INT_ENABLE_ENABLE;
+	create_req.MSIxIndex = cpu_to_le16(mrioc->intr_info[midx].msix_index);
+	if (mrioc->enable_segqueue) {
+		create_req.Flags |=
+		    MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_SEGMENTED;
+		create_req.BaseAddress = cpu_to_le64(
+		    op_reply_q->q_segment_list_dma);
+	} else
+		create_req.BaseAddress = cpu_to_le64(
+		    op_reply_q->q_segments[0].segment_dma);
+
+	create_req.Size = cpu_to_le16(op_reply_q->num_replies);
+
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &create_req,
+	    sizeof(create_req), 1);
+	if (retval) {
+		ioc_err(mrioc, "CreateRepQ: Admin Post failed\n");
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		ioc_err(mrioc, "CreateRepQ: command timed out\n");
+		mpi3mr_set_diagsave(mrioc);
+		mpi3mr_issue_reset(mrioc,
+		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT,
+		    MPI3MR_RESET_FROM_CREATEREPQ_TIMEOUT);
+		mrioc->unrecoverable = 1;
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc,
+		    "CreateRepQ: Failed IOCStatus(0x%04x) Loginfo(0x%08x)\n",
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+	op_reply_q->qid = reply_qid;
+	mrioc->intr_info[midx].op_reply_q = op_reply_q;
+
+out_unlock:
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+out:
+
+	return retval;
+}
+
+/**
+ * mpi3mr_create_op_req_q - create operational request queue
+ * @mrioc: Adapter instance reference
+ * @idx: operational request queue index
+ * @reply_qid: Reply queue ID
+ *
+ * Create operatinal request queue by issuing MPI request
+ * through admin queue.
+ *
+ * Return:  0 on success, non-zero on failure.
+ */
+static int mpi3mr_create_op_req_q(struct mpi3mr_ioc *mrioc, u16 idx,
+	u16 reply_qid)
+{
+	Mpi3CreateRequestQueueRequest_t create_req;
+	struct op_req_qinfo *op_req_q = mrioc->req_qinfo + idx;
+	int retval = 0;
+	u16 req_qid = 0;
+
+
+	req_qid = op_req_q->qid;
+
+	if (req_qid) {
+		retval = -1;
+		ioc_err(mrioc, "CreateReqQ: called for duplicate qid %d\n",
+		    req_qid);
+
+		return retval;
+	}
+	req_qid = idx + 1;
+
+	op_req_q->num_requests = MPI3MR_OP_REQ_Q_QD;
+	op_req_q->ci = 0;
+	op_req_q->pi = 0;
+	op_req_q->reply_qid = reply_qid;
+	spin_lock_init(&op_req_q->q_lock);
+
+	if (!op_req_q->q_segments) {
+		retval = mpi3mr_alloc_op_req_q_segments(mrioc, idx);
+		if (retval) {
+			mpi3mr_free_op_req_q_segments(mrioc, idx);
+			goto out;
+		}
+	}
+
+	memset(&create_req, 0, sizeof(create_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		retval = -1;
+		ioc_err(mrioc, "CreateReqQ: Init command is in use\n");
+		goto out;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	create_req.HostTag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	create_req.Function = MPI3_FUNCTION_CREATE_REQUEST_QUEUE;
+	create_req.QueueID = cpu_to_le16(req_qid);
+	if (mrioc->enable_segqueue) {
+		create_req.Flags =
+		    MPI3_CREATE_REQUEST_QUEUE_FLAGS_SEGMENTED_SEGMENTED;
+		create_req.BaseAddress = cpu_to_le64(
+		    op_req_q->q_segment_list_dma);
+	} else
+		create_req.BaseAddress = cpu_to_le64(
+		    op_req_q->q_segments[0].segment_dma);
+	create_req.ReplyQueueID = cpu_to_le16(reply_qid);
+	create_req.Size = cpu_to_le16(op_req_q->num_requests);
+
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &create_req,
+	    sizeof(create_req), 1);
+	if (retval) {
+		ioc_err(mrioc, "CreateReqQ: Admin Post failed\n");
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		ioc_err(mrioc, "CreateReqQ: command timed out\n");
+		mpi3mr_set_diagsave(mrioc);
+		if (mpi3mr_issue_reset(mrioc,
+		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT,
+		    MPI3MR_RESET_FROM_CREATEREQQ_TIMEOUT))
+			mrioc->unrecoverable = 1;
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc,
+		    "CreateReqQ: Failed IOCStatus(0x%04x) Loginfo(0x%08x)\n",
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+	op_req_q->qid = req_qid;
+
+out_unlock:
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+out:
+
+	return retval;
+}
+
+/**
+ * mpi3mr_create_op_queues - create operational queue pairs
+ * @mrioc: Adapter instance reference
+ *
+ * Allocate memory for operational queue meta data and call
+ * create request and reply queue functions.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+static int mpi3mr_create_op_queues(struct mpi3mr_ioc *mrioc)
+{
+	int retval = 0;
+	u16 num_queues = 0, i = 0, msix_count_op_q = 1;
+
+	num_queues = min_t(int, mrioc->facts.max_op_reply_q,
+	    mrioc->facts.max_op_req_q);
+
+	msix_count_op_q =
+	    mrioc->intr_info_count - mrioc->op_reply_q_offset;
+	if (!mrioc->num_queues)
+		mrioc->num_queues = min_t(int, num_queues, msix_count_op_q);
+	num_queues = mrioc->num_queues;
+	ioc_info(mrioc, "Trying to create %d Operational Q pairs\n",
+	    num_queues);
+
+	if (!mrioc->req_qinfo) {
+		mrioc->req_qinfo = kcalloc(num_queues,
+		    sizeof(struct op_req_qinfo), GFP_KERNEL);
+		if (!mrioc->req_qinfo) {
+			retval = -1;
+			goto out_failed;
+		}
+
+		mrioc->op_reply_qinfo = kzalloc(sizeof(struct op_reply_qinfo) *
+		    num_queues, GFP_KERNEL);
+		if (!mrioc->op_reply_qinfo) {
+			retval = -1;
+			goto out_failed;
+		}
+	}
+
+	if (mrioc->enable_segqueue)
+		ioc_info(mrioc,
+		    "allocating operational queues through segmented queues\n");
+
+	for (i = 0; i < num_queues; i++) {
+		if (mpi3mr_create_op_reply_q(mrioc, i)) {
+			ioc_err(mrioc, "Cannot create OP RepQ %d\n", i);
+			break;
+		}
+		if (mpi3mr_create_op_req_q(mrioc, i,
+		    mrioc->op_reply_qinfo[i].qid)) {
+			ioc_err(mrioc, "Cannot create OP ReqQ %d\n", i);
+			mpi3mr_delete_op_reply_q(mrioc, i);
+			break;
+		}
+	}
+
+	if (i == 0) {
+		/* Not even one queue is created successfully*/
+		retval = -1;
+		goto out_failed;
+	}
+	mrioc->num_op_reply_q = mrioc->num_op_req_q = i;
+	ioc_info(mrioc, "Successfully created %d Operational Q pairs\n",
+	    mrioc->num_op_reply_q);
+
+
+	return retval;
+out_failed:
+	kfree(mrioc->req_qinfo);
+	mrioc->req_qinfo = NULL;
+
+	kfree(mrioc->op_reply_qinfo);
+	mrioc->op_reply_qinfo = NULL;
+
+
+	return retval;
+}
+
 
 /**
  * mpi3mr_setup_admin_qpair - Setup admin queue pair
@@ -1598,6 +2186,13 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 		goto out_failed;
 	}
 
+	retval = mpi3mr_create_op_queues(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Failed to create OpQueues error %d\n",
+		    retval);
+		goto out_failed;
+	}
+
 	return retval;
 
 out_failed:
@@ -1654,6 +2249,12 @@ static void mpi3mr_free_mem(struct mpi3mr_ioc *mrioc)
 		mrioc->reply_free_q_pool = NULL;
 	}
 
+	for (i = 0; i < mrioc->num_op_req_q; i++)
+		mpi3mr_free_op_req_q_segments(mrioc, i);
+
+	for (i = 0; i < mrioc->num_op_reply_q; i++)
+		mpi3mr_free_op_reply_q_segments(mrioc, i);
+
 	for (i = 0; i < mrioc->intr_info_count; i++) {
 		intr_info = mrioc->intr_info + i;
 		if (intr_info)
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index c31ec9883152..3cf0be63842f 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -41,7 +41,7 @@ static int mpi3mr_map_queues(struct Scsi_Host *shost)
 	struct mpi3mr_ioc *mrioc = shost_priv(shost);
 
 	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-	    mrioc->pdev, 0);
+	    mrioc->pdev, mrioc->op_reply_q_offset);
 }
 
 /**
@@ -220,6 +220,8 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&mrioc->sbq_lock);
 
 	mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
+	if (pdev->revision)
+		mrioc->enable_segqueue = true;
 
 	mrioc->logging_level = logging_level;
 	mrioc->shost = shost;
-- 
2.18.1


--0000000000008cfa5805c0514246
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFX7OXUzV4fpEPrEsRFOZY1P+CSq
J4/78cTLSbyBHTCwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQxOTExMDIwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAfDyqNKkd8b7hrB78QRmrP2Lh+O6PfJxCkQXogrjHb0vzp
QumTpiTLWn+8Y0NsDeUcQ0XTs528aURZHCriT68BcA0lzb15HMYwk1q3kfGUW5FCuQ5aHvQ03zh7
F7FGEBxokUzL0af7bDidXW7Rt6cMCFMnVjWM3Wr2gSbzrTQQ91L9uBvSvr+iC8DJ9iFI8gENkCQK
AV1ZlOa1rFf66e3Dc6Gzexbj5zmv+kXKeNynvN4th4izlPNJiy5roqw23Wa1y8wNS1xwr1Rdmkt5
d3iUKj7fxuYT+RZKvjNgHjqKunNwQFQgO6j5pAgE/H9WE/9fA+/6SEjhdxpK8Gl/XJNT
--0000000000008cfa5805c0514246--
