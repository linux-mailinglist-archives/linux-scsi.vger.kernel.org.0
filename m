Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D18E190
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Aug 2019 01:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfHNX5z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Aug 2019 19:57:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35023 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfHNX5z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Aug 2019 19:57:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so349784pfd.2
        for <linux-scsi@vger.kernel.org>; Wed, 14 Aug 2019 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Swv6zDv4oeBliZ/NT5lmFoMYq3oPyQyMeLZBmqH/cUo=;
        b=AlBy0KqZYDJ+LyXhIp8TXLkg4uqYursxuvbAaAN5n0TPVBu6BoHYDpjpiKsb5xtnfN
         Ke45wSlFiiqfcHFE0ELQFcgjDlj67Ctx31BhYg+70rOUrrzfQ1MUo741E7UXODu1NQZe
         9wD1KaqRIKm0oXV5jw5r1rdhLse8qViHxl4X8+KgwjB4I/LXdayjUvOGQIPNF1Li/L/8
         GNR55vo9QOWYPIoYeGfGVtbkz4OgD13XNtex//Dtqs//HI35G67rQIQQmfApNGWITXky
         QAlyxOsGkOEUkiDhpYN7QhGlMlxxBkV5msmua8yjeGSItSATs1Eec6FvEOlDH+CDUdCK
         U1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Swv6zDv4oeBliZ/NT5lmFoMYq3oPyQyMeLZBmqH/cUo=;
        b=nQW2d37rt5b2Bq6J7mwJlzyBVA3myx+i/+qfLJsbigvOhILtPUA01k6BCMkPrqOByz
         egOj2S1ne8BbOQBlYIEM9RGT0rmnUUpVwjHmFQfe7m3jyKOLftUy7jVFv8hVn/Qj36Aq
         WDY2K99YWzbUkF/1rhxxXH7cLO6Gs8xV5S6MsvnkIMEQniazMZgozSde6gvpKXI16sHb
         /cUEWobJ6tzDOEAkekWRQHZZRAqNWEAgdEGim7h1dG5JUdSCv5Mt/7eYT93FGkNL4jQn
         /4GNR+yNGcqEt/8aJqAPyV/MgQAbgILJ5YVSe2ZoSZHZrJn03KMowdq39RsDFDwaJTcY
         0zUg==
X-Gm-Message-State: APjAAAUUmwgv1nIpEvtQbLZZec6T+8vXbjNnYuEAHvOQdRhDHUJn8OHj
        jRnEcfCVUAoFclFhK1GUp4BVg17Z
X-Google-Smtp-Source: APXvYqy9SarULna89pMV1NX8P8ZA4aLdvnZh1OLOo4YYCMYIL7NG1KyGZouMBY72BY6CI7cc3aJerQ==
X-Received: by 2002:aa7:98da:: with SMTP id e26mr2614939pfm.34.1565827073033;
        Wed, 14 Aug 2019 16:57:53 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k22sm987299pfk.157.2019.08.14.16.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 16:57:52 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 39/42] lpfc: Support dynamic unbounded SGL lists on G7 hardware.
Date:   Wed, 14 Aug 2019 16:57:09 -0700
Message-Id: <20190814235712.4487-40-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190814235712.4487-1-jsmart2021@gmail.com>
References: <20190814235712.4487-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Typical SLI-4 hardware supports up to 2 4KB pages to be registered
per XRI to contain the exchanges Scatter/Gather List. This caps the
number of SGL elements that can be in the SGL. There are not
extensions to extend the list out of the 2 pages.

The G7 hardware adds a SGE type that allows the SGL to be vectored
to a different scatter/gather list segment. And that segment can
contain a SGE to go to another segment and so on.  The initial
segment must still be pre-registered for the XRI, but it can be
a much smaller amount (256Bytes) as it can now be dynamically grown.
This much smaller allocation can handle the SG list for most normal
I/O, and the dynamic aspect allows it to support many MB's if needed.

The implementation creates a pool which contains "segments" and which
is initially sized to hold the initial small segment per xri. If an
I/O requires additional segments, they are allocated from the pool.
If the pool has no more segments, the pool is grown based on what is
now needed. After the I/O completes, the additional segments are
returned to the pool for use by other I/Os. Once allocated, the
additional segments are not released under the assumption of
"if needed once, it will be needed again". Pools are kept on a
per-hardware queue basis, which is typically 1:1 per cpu, but may
be shared by multiple cpus.

The switch to the smaller initial allocation significantly reduces
the memory footprint of the driver (which only grows if large ios
are issued). Based on the several K of XRIs for the adapter, the
8KB->256B reduction can conserve 32MBs or more.

It has been observed with per-cpu resource pools that allocating a resource
on CPU A, may be put back on CPU B. While the get routines are distributed
evenly, only a limited subset of CPUs may be handling the put routines.
This can put a strain on the lpfc_put_cmd_rsp_buf_per_cpu routine because
all the resources are being put on a limited subset of CPUs.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |   5 +
 drivers/scsi/lpfc/lpfc_hw4.h  |  20 +++
 drivers/scsi/lpfc/lpfc_init.c | 313 +++++++++++++++++++++++--------------
 drivers/scsi/lpfc/lpfc_mem.c  |  44 ++----
 drivers/scsi/lpfc/lpfc_nvme.c |  94 ++++++++---
 drivers/scsi/lpfc/lpfc_scsi.c | 355 ++++++++++++++++++++++++++++++++----------
 drivers/scsi/lpfc/lpfc_sli.c  | 292 ++++++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_sli.h  |  11 +-
 drivers/scsi/lpfc/lpfc_sli4.h |  18 +++
 9 files changed, 904 insertions(+), 248 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index bade2e025ecf..856a468d9b7d 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -51,6 +51,8 @@ struct lpfc_sli2_slim;
 		cmnd for menlo needs nearly twice as for firmware
 		downloads using bsg */
 
+#define LPFC_DEFAULT_XPSGL_SIZE	256
+#define LPFC_MAX_SG_TABLESIZE	0xffff
 #define LPFC_MIN_SG_SLI4_BUF_SZ	0x800	/* based on LPFC_DEFAULT_SG_SEG_CNT */
 #define LPFC_MAX_BG_SLI4_SEG_CNT_DIF 128 /* sg element count for BlockGuard */
 #define LPFC_MAX_SG_SEG_CNT_DIF 512	/* sg element count per scsi cmnd  */
@@ -799,6 +801,7 @@ struct lpfc_hba {
 	/* HBA Config Parameters */
 	uint32_t cfg_ack0;
 	uint32_t cfg_xri_rebalancing;
+	uint32_t cfg_xpsgl;
 	uint32_t cfg_enable_npiv;
 	uint32_t cfg_enable_rrq;
 	uint32_t cfg_topology;
@@ -905,6 +908,7 @@ struct lpfc_hba {
 	wait_queue_head_t    work_waitq;
 	struct task_struct   *worker_thread;
 	unsigned long data_flags;
+	uint32_t border_sge_num;
 
 	uint32_t hbq_in_use;		/* HBQs in use flag */
 	uint32_t hbq_count;	        /* Count of configured HBQs */
@@ -987,6 +991,7 @@ struct lpfc_hba {
 	struct dma_pool *lpfc_nvmet_drb_pool; /* data receive buffer pool */
 	struct dma_pool *lpfc_hbq_pool;	/* SLI3 hbq buffer pool */
 	struct dma_pool *txrdy_payload_pool;
+	struct dma_pool *lpfc_cmd_rsp_buf_pool;
 	struct lpfc_dma_pool lpfc_mbuf_safety_pool;
 
 	mempool_t *mbox_mem_pool;
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index d89480b9eade..e198de8eda32 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -2050,6 +2050,23 @@ struct sli4_sge {	/* SLI-4 */
 	uint32_t sge_len;
 };
 
+struct sli4_hybrid_sgl {
+	struct list_head list_node;
+	struct sli4_sge *dma_sgl;
+	dma_addr_t dma_phys_sgl;
+};
+
+struct fcp_cmd_rsp_buf {
+	struct list_head list_node;
+
+	/* for storing cmd/rsp dma alloc'ed virt_addr */
+	struct fcp_cmnd *fcp_cmnd;
+	struct fcp_rsp *fcp_rsp;
+
+	/* for storing this cmd/rsp's dma mapped phys addr from per CPU pool */
+	dma_addr_t fcp_cmd_rsp_dma_handle;
+};
+
 struct sli4_sge_diseed {	/* SLI-4 */
 	uint32_t ref_tag;
 	uint32_t ref_tag_tran;
@@ -3449,6 +3466,9 @@ struct lpfc_sli4_parameters {
 #define cfg_xib_SHIFT				4
 #define cfg_xib_MASK				0x00000001
 #define cfg_xib_WORD				word19
+#define cfg_xpsgl_SHIFT				6
+#define cfg_xpsgl_MASK				0x00000001
+#define cfg_xpsgl_WORD				word19
 #define cfg_eqdr_SHIFT				8
 #define cfg_eqdr_MASK				0x00000001
 #define cfg_eqdr_WORD				word19
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 9cde3dc35437..35faaf915c6a 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3650,6 +3650,9 @@ lpfc_io_free(struct lpfc_hba *phba)
 			qp->put_io_bufs--;
 			dma_pool_free(phba->lpfc_sg_dma_buf_pool,
 				      lpfc_ncmd->data, lpfc_ncmd->dma_handle);
+			if (phba->cfg_xpsgl && !phba->nvmet_support)
+				lpfc_put_sgl_per_hdwq(phba, lpfc_ncmd);
+			lpfc_put_cmd_rsp_buf_per_hdwq(phba, lpfc_ncmd);
 			kfree(lpfc_ncmd);
 			qp->total_io_bufs--;
 		}
@@ -3663,6 +3666,9 @@ lpfc_io_free(struct lpfc_hba *phba)
 			qp->get_io_bufs--;
 			dma_pool_free(phba->lpfc_sg_dma_buf_pool,
 				      lpfc_ncmd->data, lpfc_ncmd->dma_handle);
+			if (phba->cfg_xpsgl && !phba->nvmet_support)
+				lpfc_put_sgl_per_hdwq(phba, lpfc_ncmd);
+			lpfc_put_cmd_rsp_buf_per_hdwq(phba, lpfc_ncmd);
 			kfree(lpfc_ncmd);
 			qp->total_io_bufs--;
 		}
@@ -4138,22 +4144,30 @@ lpfc_new_io_buf(struct lpfc_hba *phba, int num_to_alloc)
 			break;
 		}
 
-		/*
-		 * 4K Page alignment is CRITICAL to BlockGuard, double check
-		 * to be sure.
-		 */
-		if ((phba->sli3_options & LPFC_SLI3_BG_ENABLED) &&
-		    (((unsigned long)(lpfc_ncmd->data) &
-		    (unsigned long)(SLI4_PAGE_SIZE - 1)) != 0)) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
-					"3369 Memory alignment err: addr=%lx\n",
-					(unsigned long)lpfc_ncmd->data);
-			dma_pool_free(phba->lpfc_sg_dma_buf_pool,
-				      lpfc_ncmd->data, lpfc_ncmd->dma_handle);
-			kfree(lpfc_ncmd);
-			break;
+		if (phba->cfg_xpsgl && !phba->nvmet_support) {
+			INIT_LIST_HEAD(&lpfc_ncmd->dma_sgl_xtra_list);
+		} else {
+			/*
+			 * 4K Page alignment is CRITICAL to BlockGuard, double
+			 * check to be sure.
+			 */
+			if ((phba->sli3_options & LPFC_SLI3_BG_ENABLED) &&
+			    (((unsigned long)(lpfc_ncmd->data) &
+			    (unsigned long)(SLI4_PAGE_SIZE - 1)) != 0)) {
+				lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
+						"3369 Memory alignment err: "
+						"addr=%lx\n",
+						(unsigned long)lpfc_ncmd->data);
+				dma_pool_free(phba->lpfc_sg_dma_buf_pool,
+					      lpfc_ncmd->data,
+					      lpfc_ncmd->dma_handle);
+				kfree(lpfc_ncmd);
+				break;
+			}
 		}
 
+		INIT_LIST_HEAD(&lpfc_ncmd->dma_cmd_rsp_list);
+
 		lxri = lpfc_sli4_next_xritag(phba);
 		if (lxri == NO_XRI) {
 			dma_pool_free(phba->lpfc_sg_dma_buf_pool,
@@ -4332,7 +4346,11 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 
 		shost->dma_boundary =
 			phba->sli4_hba.pc_sli4_params.sge_supp_len-1;
-		shost->sg_tablesize = phba->cfg_scsi_seg_cnt;
+
+		if (phba->cfg_xpsgl && !phba->nvmet_support)
+			shost->sg_tablesize = LPFC_MAX_SG_TABLESIZE;
+		else
+			shost->sg_tablesize = phba->cfg_scsi_seg_cnt;
 	} else
 		/* SLI-3 has a limited number of hardware queues (3),
 		 * thus there is only one for FCP processing.
@@ -6350,6 +6368,24 @@ lpfc_sli_driver_resource_setup(struct lpfc_hba *phba)
 	if (lpfc_mem_alloc(phba, BPL_ALIGN_SZ))
 		return -ENOMEM;
 
+	phba->lpfc_sg_dma_buf_pool =
+		dma_pool_create("lpfc_sg_dma_buf_pool",
+				&phba->pcidev->dev, phba->cfg_sg_dma_buf_size,
+				BPL_ALIGN_SZ, 0);
+
+	if (!phba->lpfc_sg_dma_buf_pool)
+		goto fail_free_mem;
+
+	phba->lpfc_cmd_rsp_buf_pool =
+			dma_pool_create("lpfc_cmd_rsp_buf_pool",
+					&phba->pcidev->dev,
+					sizeof(struct fcp_cmnd) +
+					sizeof(struct fcp_rsp),
+					BPL_ALIGN_SZ, 0);
+
+	if (!phba->lpfc_cmd_rsp_buf_pool)
+		goto fail_free_dma_buf_pool;
+
 	/*
 	 * Enable sr-iov virtual functions if supported and configured
 	 * through the module parameter.
@@ -6368,6 +6404,13 @@ lpfc_sli_driver_resource_setup(struct lpfc_hba *phba)
 	}
 
 	return 0;
+
+fail_free_dma_buf_pool:
+	dma_pool_destroy(phba->lpfc_sg_dma_buf_pool);
+	phba->lpfc_sg_dma_buf_pool = NULL;
+fail_free_mem:
+	lpfc_mem_free(phba);
+	return -ENOMEM;
 }
 
 /**
@@ -6467,102 +6510,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	 * The WQ create will allocate the ring.
 	 */
 
-	/*
-	 * 1 for cmd, 1 for rsp, NVME adds an extra one
-	 * for boundary conditions in its max_sgl_segment template.
-	 */
-	extra = 2;
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
-		extra++;
-
-	/*
-	 * It doesn't matter what family our adapter is in, we are
-	 * limited to 2 Pages, 512 SGEs, for our SGL.
-	 * There are going to be 2 reserved SGEs: 1 FCP cmnd + 1 FCP rsp
-	 */
-	max_buf_size = (2 * SLI4_PAGE_SIZE);
-
-	/*
-	 * Since lpfc_sg_seg_cnt is module param, the sg_dma_buf_size
-	 * used to create the sg_dma_buf_pool must be calculated.
-	 */
-	if (phba->sli3_options & LPFC_SLI3_BG_ENABLED) {
-		/*
-		 * The scsi_buf for a T10-DIF I/O holds the FCP cmnd,
-		 * the FCP rsp, and a SGE. Sice we have no control
-		 * over how many protection segments the SCSI Layer
-		 * will hand us (ie: there could be one for every block
-		 * in the IO), just allocate enough SGEs to accomidate
-		 * our max amount and we need to limit lpfc_sg_seg_cnt
-		 * to minimize the risk of running out.
-		 */
-		phba->cfg_sg_dma_buf_size = sizeof(struct fcp_cmnd) +
-				sizeof(struct fcp_rsp) + max_buf_size;
-
-		/* Total SGEs for scsi_sg_list and scsi_sg_prot_list */
-		phba->cfg_total_seg_cnt = LPFC_MAX_SGL_SEG_CNT;
-
-		/*
-		 * If supporting DIF, reduce the seg count for scsi to
-		 * allow room for the DIF sges.
-		 */
-		if (phba->cfg_enable_bg &&
-		    phba->cfg_sg_seg_cnt > LPFC_MAX_BG_SLI4_SEG_CNT_DIF)
-			phba->cfg_scsi_seg_cnt = LPFC_MAX_BG_SLI4_SEG_CNT_DIF;
-		else
-			phba->cfg_scsi_seg_cnt = phba->cfg_sg_seg_cnt;
-
-	} else {
-		/*
-		 * The scsi_buf for a regular I/O holds the FCP cmnd,
-		 * the FCP rsp, a SGE for each, and a SGE for up to
-		 * cfg_sg_seg_cnt data segments.
-		 */
-		phba->cfg_sg_dma_buf_size = sizeof(struct fcp_cmnd) +
-				sizeof(struct fcp_rsp) +
-				((phba->cfg_sg_seg_cnt + extra) *
-				sizeof(struct sli4_sge));
-
-		/* Total SGEs for scsi_sg_list */
-		phba->cfg_total_seg_cnt = phba->cfg_sg_seg_cnt + extra;
-		phba->cfg_scsi_seg_cnt = phba->cfg_sg_seg_cnt;
-
-		/*
-		 * NOTE: if (phba->cfg_sg_seg_cnt + extra) <= 256 we only
-		 * need to post 1 page for the SGL.
-		 */
-	}
-
-	/* Limit to LPFC_MAX_NVME_SEG_CNT for NVME. */
-	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
-		if (phba->cfg_sg_seg_cnt > LPFC_MAX_NVME_SEG_CNT) {
-			lpfc_printf_log(phba, KERN_INFO, LOG_NVME | LOG_INIT,
-					"6300 Reducing NVME sg segment "
-					"cnt to %d\n",
-					LPFC_MAX_NVME_SEG_CNT);
-			phba->cfg_nvme_seg_cnt = LPFC_MAX_NVME_SEG_CNT;
-		} else
-			phba->cfg_nvme_seg_cnt = phba->cfg_sg_seg_cnt;
-	}
-
-	/* Initialize the host templates with the updated values. */
-	lpfc_vport_template.sg_tablesize = phba->cfg_scsi_seg_cnt;
-	lpfc_template.sg_tablesize = phba->cfg_scsi_seg_cnt;
-	lpfc_template_no_hr.sg_tablesize = phba->cfg_scsi_seg_cnt;
-
-	if (phba->cfg_sg_dma_buf_size  <= LPFC_MIN_SG_SLI4_BUF_SZ)
-		phba->cfg_sg_dma_buf_size = LPFC_MIN_SG_SLI4_BUF_SZ;
-	else
-		phba->cfg_sg_dma_buf_size =
-			SLI4_PAGE_ALIGN(phba->cfg_sg_dma_buf_size);
-
-	lpfc_printf_log(phba, KERN_INFO, LOG_INIT | LOG_FCP,
-			"9087 sg_seg_cnt:%d dmabuf_size:%d "
-			"total:%d scsi:%d nvme:%d\n",
-			phba->cfg_sg_seg_cnt, phba->cfg_sg_dma_buf_size,
-			phba->cfg_total_seg_cnt,  phba->cfg_scsi_seg_cnt,
-			phba->cfg_nvme_seg_cnt);
-
 	/* Initialize buffer queue management fields */
 	INIT_LIST_HEAD(&phba->hbqs[LPFC_ELS_HBQ].hbq_buffer_list);
 	phba->hbqs[LPFC_ELS_HBQ].hbq_alloc_buffer = lpfc_sli4_rb_alloc;
@@ -6783,6 +6730,131 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 		}
 	}
 
+	/*
+	 * 1 for cmd, 1 for rsp, NVME adds an extra one
+	 * for boundary conditions in its max_sgl_segment template.
+	 */
+	extra = 2;
+	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
+		extra++;
+
+	/*
+	 * It doesn't matter what family our adapter is in, we are
+	 * limited to 2 Pages, 512 SGEs, for our SGL.
+	 * There are going to be 2 reserved SGEs: 1 FCP cmnd + 1 FCP rsp
+	 */
+	max_buf_size = (2 * SLI4_PAGE_SIZE);
+
+	/*
+	 * Since lpfc_sg_seg_cnt is module param, the sg_dma_buf_size
+	 * used to create the sg_dma_buf_pool must be calculated.
+	 */
+	if (phba->sli3_options & LPFC_SLI3_BG_ENABLED) {
+		/* Both cfg_enable_bg and cfg_external_dif code paths */
+
+		/*
+		 * The scsi_buf for a T10-DIF I/O holds the FCP cmnd,
+		 * the FCP rsp, and a SGE. Sice we have no control
+		 * over how many protection segments the SCSI Layer
+		 * will hand us (ie: there could be one for every block
+		 * in the IO), just allocate enough SGEs to accomidate
+		 * our max amount and we need to limit lpfc_sg_seg_cnt
+		 * to minimize the risk of running out.
+		 */
+		phba->cfg_sg_dma_buf_size = sizeof(struct fcp_cmnd) +
+				sizeof(struct fcp_rsp) + max_buf_size;
+
+		/* Total SGEs for scsi_sg_list and scsi_sg_prot_list */
+		phba->cfg_total_seg_cnt = LPFC_MAX_SGL_SEG_CNT;
+
+		/*
+		 * If supporting DIF, reduce the seg count for scsi to
+		 * allow room for the DIF sges.
+		 */
+		if (phba->cfg_enable_bg &&
+		    phba->cfg_sg_seg_cnt > LPFC_MAX_BG_SLI4_SEG_CNT_DIF)
+			phba->cfg_scsi_seg_cnt = LPFC_MAX_BG_SLI4_SEG_CNT_DIF;
+		else
+			phba->cfg_scsi_seg_cnt = phba->cfg_sg_seg_cnt;
+
+	} else {
+		/*
+		 * The scsi_buf for a regular I/O holds the FCP cmnd,
+		 * the FCP rsp, a SGE for each, and a SGE for up to
+		 * cfg_sg_seg_cnt data segments.
+		 */
+		phba->cfg_sg_dma_buf_size = sizeof(struct fcp_cmnd) +
+				sizeof(struct fcp_rsp) +
+				((phba->cfg_sg_seg_cnt + extra) *
+				sizeof(struct sli4_sge));
+
+		/* Total SGEs for scsi_sg_list */
+		phba->cfg_total_seg_cnt = phba->cfg_sg_seg_cnt + extra;
+		phba->cfg_scsi_seg_cnt = phba->cfg_sg_seg_cnt;
+
+		/*
+		 * NOTE: if (phba->cfg_sg_seg_cnt + extra) <= 256 we only
+		 * need to post 1 page for the SGL.
+		 */
+	}
+
+	if (phba->cfg_xpsgl && !phba->nvmet_support)
+		phba->cfg_sg_dma_buf_size = LPFC_DEFAULT_XPSGL_SIZE;
+	else if (phba->cfg_sg_dma_buf_size  <= LPFC_MIN_SG_SLI4_BUF_SZ)
+		phba->cfg_sg_dma_buf_size = LPFC_MIN_SG_SLI4_BUF_SZ;
+	else
+		phba->cfg_sg_dma_buf_size =
+				SLI4_PAGE_ALIGN(phba->cfg_sg_dma_buf_size);
+
+	phba->border_sge_num = phba->cfg_sg_dma_buf_size /
+			       sizeof(struct sli4_sge);
+
+	/* Limit to LPFC_MAX_NVME_SEG_CNT for NVME. */
+	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
+		if (phba->cfg_sg_seg_cnt > LPFC_MAX_NVME_SEG_CNT) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_NVME | LOG_INIT,
+					"6300 Reducing NVME sg segment "
+					"cnt to %d\n",
+					LPFC_MAX_NVME_SEG_CNT);
+			phba->cfg_nvme_seg_cnt = LPFC_MAX_NVME_SEG_CNT;
+		} else
+			phba->cfg_nvme_seg_cnt = phba->cfg_sg_seg_cnt;
+	}
+
+	/* Initialize the host templates with the updated values. */
+	lpfc_vport_template.sg_tablesize = phba->cfg_scsi_seg_cnt;
+	lpfc_template.sg_tablesize = phba->cfg_scsi_seg_cnt;
+	lpfc_template_no_hr.sg_tablesize = phba->cfg_scsi_seg_cnt;
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_INIT | LOG_FCP,
+			"9087 sg_seg_cnt:%d dmabuf_size:%d "
+			"total:%d scsi:%d nvme:%d\n",
+			phba->cfg_sg_seg_cnt, phba->cfg_sg_dma_buf_size,
+			phba->cfg_total_seg_cnt,  phba->cfg_scsi_seg_cnt,
+			phba->cfg_nvme_seg_cnt);
+
+	if (phba->cfg_sg_dma_buf_size < SLI4_PAGE_SIZE)
+		i = phba->cfg_sg_dma_buf_size;
+	else
+		i = SLI4_PAGE_SIZE;
+
+	phba->lpfc_sg_dma_buf_pool =
+			dma_pool_create("lpfc_sg_dma_buf_pool",
+					&phba->pcidev->dev,
+					phba->cfg_sg_dma_buf_size,
+					i, 0);
+	if (!phba->lpfc_sg_dma_buf_pool)
+		goto out_free_bsmbx;
+
+	phba->lpfc_cmd_rsp_buf_pool =
+			dma_pool_create("lpfc_cmd_rsp_buf_pool",
+					&phba->pcidev->dev,
+					sizeof(struct fcp_cmnd) +
+					sizeof(struct fcp_rsp),
+					i, 0);
+	if (!phba->lpfc_cmd_rsp_buf_pool)
+		goto out_free_sg_dma_buf;
+
 	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	/* Verify OAS is supported */
@@ -6794,12 +6866,12 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	/* Verify all the SLI4 queues */
 	rc = lpfc_sli4_queue_verify(phba);
 	if (rc)
-		goto out_free_bsmbx;
+		goto out_free_cmd_rsp_buf;
 
 	/* Create driver internal CQE event pool */
 	rc = lpfc_sli4_cq_event_pool_create(phba);
 	if (rc)
-		goto out_free_bsmbx;
+		goto out_free_cmd_rsp_buf;
 
 	/* Initialize sgl lists per host */
 	lpfc_init_sgl_list(phba);
@@ -6890,6 +6962,12 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	lpfc_free_active_sgl(phba);
 out_destroy_cq_event_pool:
 	lpfc_sli4_cq_event_pool_destroy(phba);
+out_free_cmd_rsp_buf:
+	dma_pool_destroy(phba->lpfc_cmd_rsp_buf_pool);
+	phba->lpfc_cmd_rsp_buf_pool = NULL;
+out_free_sg_dma_buf:
+	dma_pool_destroy(phba->lpfc_sg_dma_buf_pool);
+	phba->lpfc_sg_dma_buf_pool = NULL;
 out_free_bsmbx:
 	lpfc_destroy_bootstrap_mbox(phba);
 out_free_mem:
@@ -8816,6 +8894,9 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 			spin_lock_init(&qp->abts_nvme_buf_list_lock);
 			INIT_LIST_HEAD(&qp->lpfc_abts_nvme_buf_list);
 			qp->abts_nvme_io_bufs = 0;
+			INIT_LIST_HEAD(&qp->sgl_list);
+			INIT_LIST_HEAD(&qp->cmd_rsp_buf_list);
+			spin_lock_init(&qp->hdwq_lock);
 		}
 	}
 
@@ -9190,6 +9271,9 @@ lpfc_sli4_release_hdwq(struct lpfc_hba *phba)
 		hdwq[idx].nvme_cq = NULL;
 		hdwq[idx].fcp_wq = NULL;
 		hdwq[idx].nvme_wq = NULL;
+		if (phba->cfg_xpsgl && !phba->nvmet_support)
+			lpfc_free_sgl_per_hdwq(phba, &hdwq[idx]);
+		lpfc_free_cmd_rsp_buf_per_hdwq(phba, &hdwq[idx]);
 	}
 	/* Loop thru all IRQ vectors */
 	for (idx = 0; idx < phba->cfg_irq_chann; idx++) {
@@ -11668,6 +11752,9 @@ lpfc_get_sli4_parameters(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	phba->sli4_hba.extents_in_use = bf_get(cfg_ext, mbx_sli4_parameters);
 	phba->sli4_hba.rpi_hdrs_in_use = bf_get(cfg_hdrr, mbx_sli4_parameters);
 
+	/* Check for Extended Pre-Registered SGL support */
+	phba->cfg_xpsgl = bf_get(cfg_xpsgl, mbx_sli4_parameters);
+
 	/* Check for firmware nvme support */
 	rc = (bf_get(cfg_nvme, mbx_sli4_parameters) &&
 		     bf_get(cfg_xib, mbx_sli4_parameters));
diff --git a/drivers/scsi/lpfc/lpfc_mem.c b/drivers/scsi/lpfc/lpfc_mem.c
index 66191fa35f63..84c7445b8c93 100644
--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -72,8 +72,8 @@ lpfc_mem_alloc_active_rrq_pool_s4(struct lpfc_hba *phba) {
  * lpfc_mem_alloc - create and allocate all PCI and memory pools
  * @phba: HBA to allocate pools for
  *
- * Description: Creates and allocates PCI pools lpfc_sg_dma_buf_pool,
- * lpfc_mbuf_pool, lpfc_hrb_pool.  Creates and allocates kmalloc-backed mempools
+ * Description: Creates and allocates PCI pools lpfc_mbuf_pool,
+ * lpfc_hrb_pool.  Creates and allocates kmalloc-backed mempools
  * for LPFC_MBOXQ_t and lpfc_nodelist.  Also allocates the VPI bitmask.
  *
  * Notes: Not interrupt-safe.  Must be called with no locks held.  If any
@@ -89,36 +89,12 @@ lpfc_mem_alloc(struct lpfc_hba *phba, int align)
 	struct lpfc_dma_pool *pool = &phba->lpfc_mbuf_safety_pool;
 	int i;
 
-	if (phba->sli_rev == LPFC_SLI_REV4) {
-		/* Calculate alignment */
-		if (phba->cfg_sg_dma_buf_size < SLI4_PAGE_SIZE)
-			i = phba->cfg_sg_dma_buf_size;
-		else
-			i = SLI4_PAGE_SIZE;
-
-		phba->lpfc_sg_dma_buf_pool =
-			dma_pool_create("lpfc_sg_dma_buf_pool",
-					&phba->pcidev->dev,
-					phba->cfg_sg_dma_buf_size,
-					i, 0);
-		if (!phba->lpfc_sg_dma_buf_pool)
-			goto fail;
-
-	} else {
-		phba->lpfc_sg_dma_buf_pool =
-			dma_pool_create("lpfc_sg_dma_buf_pool",
-					&phba->pcidev->dev, phba->cfg_sg_dma_buf_size,
-					align, 0);
-
-		if (!phba->lpfc_sg_dma_buf_pool)
-			goto fail;
-	}
 
 	phba->lpfc_mbuf_pool = dma_pool_create("lpfc_mbuf_pool", &phba->pcidev->dev,
 							LPFC_BPL_SIZE,
 							align, 0);
 	if (!phba->lpfc_mbuf_pool)
-		goto fail_free_dma_buf_pool;
+		goto fail;
 
 	pool->elements = kmalloc_array(LPFC_MBUF_POOL_SIZE,
 				       sizeof(struct lpfc_dmabuf),
@@ -208,9 +184,6 @@ lpfc_mem_alloc(struct lpfc_hba *phba, int align)
  fail_free_lpfc_mbuf_pool:
 	dma_pool_destroy(phba->lpfc_mbuf_pool);
 	phba->lpfc_mbuf_pool = NULL;
- fail_free_dma_buf_pool:
-	dma_pool_destroy(phba->lpfc_sg_dma_buf_pool);
-	phba->lpfc_sg_dma_buf_pool = NULL;
  fail:
 	return -ENOMEM;
 }
@@ -290,10 +263,6 @@ lpfc_mem_free(struct lpfc_hba *phba)
 	dma_pool_destroy(phba->lpfc_mbuf_pool);
 	phba->lpfc_mbuf_pool = NULL;
 
-	/* Free DMA buffer memory pool */
-	dma_pool_destroy(phba->lpfc_sg_dma_buf_pool);
-	phba->lpfc_sg_dma_buf_pool = NULL;
-
 	/* Free Device Data memory pool */
 	if (phba->device_data_mem_pool) {
 		/* Ensure all objects have been returned to the pool */
@@ -366,6 +335,13 @@ lpfc_mem_free_all(struct lpfc_hba *phba)
 	/* Free and destroy all the allocated memory pools */
 	lpfc_mem_free(phba);
 
+	/* Free DMA buffer memory pool */
+	dma_pool_destroy(phba->lpfc_sg_dma_buf_pool);
+	phba->lpfc_sg_dma_buf_pool = NULL;
+
+	dma_pool_destroy(phba->lpfc_cmd_rsp_buf_pool);
+	phba->lpfc_cmd_rsp_buf_pool = NULL;
+
 	/* Free the iocb lookup array */
 	kfree(psli->iocbq_lookup);
 	psli->iocbq_lookup = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index b599ddc40c6b..5e48318eb7a9 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1306,14 +1306,16 @@ lpfc_nvme_prep_io_dma(struct lpfc_vport *vport,
 	struct nvmefc_fcp_req *nCmd = lpfc_ncmd->nvmeCmd;
 	union lpfc_wqe128 *wqe = &lpfc_ncmd->cur_iocbq.wqe;
 	struct sli4_sge *sgl = lpfc_ncmd->dma_sgl;
+	struct sli4_hybrid_sgl *sgl_xtra = NULL;
 	struct scatterlist *data_sg;
 	struct sli4_sge *first_data_sgl;
 	struct ulp_bde64 *bde;
-	dma_addr_t physaddr;
+	dma_addr_t physaddr = 0;
 	uint32_t num_bde = 0;
-	uint32_t dma_len;
+	uint32_t dma_len = 0;
 	uint32_t dma_offset = 0;
-	int nseg, i;
+	int nseg, i, j;
+	bool lsp_just_set = false;
 
 	/* Fix up the command and response DMA stuff. */
 	lpfc_nvme_adj_fcp_sgls(vport, lpfc_ncmd, nCmd);
@@ -1350,6 +1352,9 @@ lpfc_nvme_prep_io_dma(struct lpfc_vport *vport,
 		 */
 		nseg = nCmd->sg_cnt;
 		data_sg = nCmd->first_sgl;
+
+		/* for tracking the segment boundaries */
+		j = 2;
 		for (i = 0; i < nseg; i++) {
 			if (data_sg == NULL) {
 				lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
@@ -1358,23 +1363,76 @@ lpfc_nvme_prep_io_dma(struct lpfc_vport *vport,
 				lpfc_ncmd->seg_cnt = 0;
 				return 1;
 			}
-			physaddr = data_sg->dma_address;
-			dma_len = data_sg->length;
-			sgl->addr_lo = cpu_to_le32(putPaddrLow(physaddr));
-			sgl->addr_hi = cpu_to_le32(putPaddrHigh(physaddr));
-			sgl->word2 = le32_to_cpu(sgl->word2);
-			if ((num_bde + 1) == nseg)
+
+			sgl->word2 = 0;
+			if ((num_bde + 1) == nseg) {
 				bf_set(lpfc_sli4_sge_last, sgl, 1);
-			else
+				bf_set(lpfc_sli4_sge_type, sgl,
+				       LPFC_SGE_TYPE_DATA);
+			} else {
 				bf_set(lpfc_sli4_sge_last, sgl, 0);
-			bf_set(lpfc_sli4_sge_offset, sgl, dma_offset);
-			bf_set(lpfc_sli4_sge_type, sgl, LPFC_SGE_TYPE_DATA);
-			sgl->word2 = cpu_to_le32(sgl->word2);
-			sgl->sge_len = cpu_to_le32(dma_len);
-
-			dma_offset += dma_len;
-			data_sg = sg_next(data_sg);
-			sgl++;
+
+				/* expand the segment */
+				if (!lsp_just_set &&
+				    !((j + 1) % phba->border_sge_num) &&
+				    ((nseg - 1) != i)) {
+					/* set LSP type */
+					bf_set(lpfc_sli4_sge_type, sgl,
+					       LPFC_SGE_TYPE_LSP);
+
+					sgl_xtra = lpfc_get_sgl_per_hdwq(
+							phba, lpfc_ncmd);
+
+					if (unlikely(!sgl_xtra)) {
+						lpfc_ncmd->seg_cnt = 0;
+						return 1;
+					}
+					sgl->addr_lo = cpu_to_le32(putPaddrLow(
+						       sgl_xtra->dma_phys_sgl));
+					sgl->addr_hi = cpu_to_le32(putPaddrHigh(
+						       sgl_xtra->dma_phys_sgl));
+
+				} else {
+					bf_set(lpfc_sli4_sge_type, sgl,
+					       LPFC_SGE_TYPE_DATA);
+				}
+			}
+
+			if (!(bf_get(lpfc_sli4_sge_type, sgl) &
+				     LPFC_SGE_TYPE_LSP)) {
+				if ((nseg - 1) == i)
+					bf_set(lpfc_sli4_sge_last, sgl, 1);
+
+				physaddr = data_sg->dma_address;
+				dma_len = data_sg->length;
+				sgl->addr_lo = cpu_to_le32(
+							 putPaddrLow(physaddr));
+				sgl->addr_hi = cpu_to_le32(
+							putPaddrHigh(physaddr));
+
+				bf_set(lpfc_sli4_sge_offset, sgl, dma_offset);
+				sgl->word2 = cpu_to_le32(sgl->word2);
+				sgl->sge_len = cpu_to_le32(dma_len);
+
+				dma_offset += dma_len;
+				data_sg = sg_next(data_sg);
+
+				sgl++;
+
+				lsp_just_set = false;
+			} else {
+				sgl->word2 = cpu_to_le32(sgl->word2);
+
+				sgl->sge_len = cpu_to_le32(
+						     phba->cfg_sg_dma_buf_size);
+
+				sgl = (struct sli4_sge *)sgl_xtra->dma_sgl;
+				i = i - 1;
+
+				lsp_just_set = true;
+			}
+
+			j++;
 		}
 		if (phba->cfg_enable_pbde) {
 			/* Use PBDE support for first SGL only, offset == 0 */
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 95ba5000d0ec..fb7df209c0aa 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -685,8 +685,9 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	IOCB_t *iocb;
 	dma_addr_t pdma_phys_fcp_rsp;
 	dma_addr_t pdma_phys_fcp_cmd;
-	uint32_t sgl_size, cpu, idx;
+	uint32_t cpu, idx;
 	int tag;
+	struct fcp_cmd_rsp_buf *tmp = NULL;
 
 	cpu = raw_smp_processor_id();
 	if (cmnd && phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ) {
@@ -704,9 +705,6 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 		return NULL;
 	}
 
-	sgl_size = phba->cfg_sg_dma_buf_size -
-		(sizeof(struct fcp_cmnd) + sizeof(struct fcp_rsp));
-
 	/* Setup key fields in buffer that may have been changed
 	 * if other protocols used this buffer.
 	 */
@@ -721,9 +719,12 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	lpfc_cmd->prot_data_type = 0;
 #endif
-	lpfc_cmd->fcp_cmnd = (lpfc_cmd->data + sgl_size);
-	lpfc_cmd->fcp_rsp = (struct fcp_rsp *)((uint8_t *)lpfc_cmd->fcp_cmnd +
-				sizeof(struct fcp_cmnd));
+	tmp = lpfc_get_cmd_rsp_buf_per_hdwq(phba, lpfc_cmd);
+	if (!tmp)
+		return NULL;
+
+	lpfc_cmd->fcp_cmnd = tmp->fcp_cmnd;
+	lpfc_cmd->fcp_rsp = tmp->fcp_rsp;
 
 	/*
 	 * The first two SGEs are the FCP_CMD and FCP_RSP.
@@ -731,7 +732,7 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	 * first two and leave the rest for queuecommand.
 	 */
 	sgl = (struct sli4_sge *)lpfc_cmd->dma_sgl;
-	pdma_phys_fcp_cmd = (lpfc_cmd->dma_handle + sgl_size);
+	pdma_phys_fcp_cmd = tmp->fcp_cmd_rsp_dma_handle;
 	sgl->addr_hi = cpu_to_le32(putPaddrHigh(pdma_phys_fcp_cmd));
 	sgl->addr_lo = cpu_to_le32(putPaddrLow(pdma_phys_fcp_cmd));
 	sgl->word2 = le32_to_cpu(sgl->word2);
@@ -1990,7 +1991,8 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  **/
 static int
 lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
-		struct sli4_sge *sgl, int datasegcnt)
+		struct sli4_sge *sgl, int datasegcnt,
+		struct lpfc_io_buf *lpfc_cmd)
 {
 	struct scatterlist *sgde = NULL; /* s/g data entry */
 	struct sli4_sge_diseed *diseed = NULL;
@@ -2004,6 +2006,9 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	uint32_t checking = 1;
 	uint32_t dma_len;
 	uint32_t dma_offset = 0;
+	struct sli4_hybrid_sgl *sgl_xtra = NULL;
+	int j;
+	bool lsp_just_set = false;
 
 	status  = lpfc_sc_to_bg_opcodes(phba, sc, &txop, &rxop);
 	if (status)
@@ -2063,23 +2068,64 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	sgl++;
 
 	/* assumption: caller has already run dma_map_sg on command data */
-	scsi_for_each_sg(sc, sgde, datasegcnt, i) {
-		physaddr = sg_dma_address(sgde);
-		dma_len = sg_dma_len(sgde);
-		sgl->addr_lo = cpu_to_le32(putPaddrLow(physaddr));
-		sgl->addr_hi = cpu_to_le32(putPaddrHigh(physaddr));
-		if ((i + 1) == datasegcnt)
-			bf_set(lpfc_sli4_sge_last, sgl, 1);
-		else
-			bf_set(lpfc_sli4_sge_last, sgl, 0);
-		bf_set(lpfc_sli4_sge_offset, sgl, dma_offset);
-		bf_set(lpfc_sli4_sge_type, sgl, LPFC_SGE_TYPE_DATA);
+	sgde = scsi_sglist(sc);
+	j = 3;
+	for (i = 0; i < datasegcnt; i++) {
+		/* clear it */
+		sgl->word2 = 0;
 
-		sgl->sge_len = cpu_to_le32(dma_len);
-		dma_offset += dma_len;
+		/* do we need to expand the segment */
+		if (!lsp_just_set && !((j + 1) % phba->border_sge_num) &&
+		    ((datasegcnt - 1) != i)) {
+			/* set LSP type */
+			bf_set(lpfc_sli4_sge_type, sgl, LPFC_SGE_TYPE_LSP);
+
+			sgl_xtra = lpfc_get_sgl_per_hdwq(phba, lpfc_cmd);
+
+			if (unlikely(!sgl_xtra)) {
+				lpfc_cmd->seg_cnt = 0;
+				return 0;
+			}
+			sgl->addr_lo = cpu_to_le32(putPaddrLow(
+						sgl_xtra->dma_phys_sgl));
+			sgl->addr_hi = cpu_to_le32(putPaddrHigh(
+						sgl_xtra->dma_phys_sgl));
+
+		} else {
+			bf_set(lpfc_sli4_sge_type, sgl, LPFC_SGE_TYPE_DATA);
+		}
+
+		if (!(bf_get(lpfc_sli4_sge_type, sgl) & LPFC_SGE_TYPE_LSP)) {
+			if ((datasegcnt - 1) == i)
+				bf_set(lpfc_sli4_sge_last, sgl, 1);
+			physaddr = sg_dma_address(sgde);
+			dma_len = sg_dma_len(sgde);
+			sgl->addr_lo = cpu_to_le32(putPaddrLow(physaddr));
+			sgl->addr_hi = cpu_to_le32(putPaddrHigh(physaddr));
+
+			bf_set(lpfc_sli4_sge_offset, sgl, dma_offset);
+			sgl->word2 = cpu_to_le32(sgl->word2);
+			sgl->sge_len = cpu_to_le32(dma_len);
+
+			dma_offset += dma_len;
+			sgde = sg_next(sgde);
+
+			sgl++;
+			num_sge++;
+			lsp_just_set = false;
+
+		} else {
+			sgl->word2 = cpu_to_le32(sgl->word2);
+			sgl->sge_len = cpu_to_le32(phba->cfg_sg_dma_buf_size);
+
+			sgl = (struct sli4_sge *)sgl_xtra->dma_sgl;
+			i = i - 1;
+
+			lsp_just_set = true;
+		}
+
+		j++;
 
-		sgl++;
-		num_sge++;
 	}
 
 out:
@@ -2125,7 +2171,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  **/
 static int
 lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
-		struct sli4_sge *sgl, int datacnt, int protcnt)
+		struct sli4_sge *sgl, int datacnt, int protcnt,
+		struct lpfc_io_buf *lpfc_cmd)
 {
 	struct scatterlist *sgde = NULL; /* s/g data entry */
 	struct scatterlist *sgpe = NULL; /* s/g prot entry */
@@ -2147,7 +2194,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 #endif
 	uint32_t checking = 1;
 	uint32_t dma_offset = 0;
-	int num_sge = 0;
+	int num_sge = 0, j = 2;
+	struct sli4_hybrid_sgl *sgl_xtra = NULL;
 
 	sgpe = scsi_prot_sglist(sc);
 	sgde = scsi_sglist(sc);
@@ -2180,9 +2228,37 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	split_offset = 0;
 	do {
 		/* Check to see if we ran out of space */
-		if (num_sge >= (phba->cfg_total_seg_cnt - 2))
+		if ((num_sge >= (phba->cfg_total_seg_cnt - 2)) &&
+		    !(phba->cfg_xpsgl))
 			return num_sge + 3;
 
+		/* DISEED and DIF have to be together */
+		if (!((j + 1) % phba->border_sge_num) ||
+		    !((j + 2) % phba->border_sge_num) ||
+		    !((j + 3) % phba->border_sge_num)) {
+			sgl->word2 = 0;
+
+			/* set LSP type */
+			bf_set(lpfc_sli4_sge_type, sgl, LPFC_SGE_TYPE_LSP);
+
+			sgl_xtra = lpfc_get_sgl_per_hdwq(phba, lpfc_cmd);
+
+			if (unlikely(!sgl_xtra)) {
+				goto out;
+			} else {
+				sgl->addr_lo = cpu_to_le32(putPaddrLow(
+						sgl_xtra->dma_phys_sgl));
+				sgl->addr_hi = cpu_to_le32(putPaddrHigh(
+						       sgl_xtra->dma_phys_sgl));
+			}
+
+			sgl->word2 = cpu_to_le32(sgl->word2);
+			sgl->sge_len = cpu_to_le32(phba->cfg_sg_dma_buf_size);
+
+			sgl = (struct sli4_sge *)sgl_xtra->dma_sgl;
+			j = 0;
+		}
+
 		/* setup DISEED with what we have */
 		diseed = (struct sli4_sge_diseed *) sgl;
 		memset(diseed, 0, sizeof(struct sli4_sge_diseed));
@@ -2229,7 +2305,9 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 		/* advance sgl and increment bde count */
 		num_sge++;
+
 		sgl++;
+		j++;
 
 		/* setup the first BDE that points to protection buffer */
 		protphysaddr = sg_dma_address(sgpe) + protgroup_offset;
@@ -2244,6 +2322,7 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		sgl->addr_hi = le32_to_cpu(putPaddrHigh(protphysaddr));
 		sgl->addr_lo = le32_to_cpu(putPaddrLow(protphysaddr));
 		sgl->word2 = cpu_to_le32(sgl->word2);
+		sgl->sge_len = 0;
 
 		protgrp_blks = protgroup_len / 8;
 		protgrp_bytes = protgrp_blks * blksize;
@@ -2264,9 +2343,14 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		/* setup SGE's for data blocks associated with DIF data */
 		pgdone = 0;
 		subtotal = 0; /* total bytes processed for current prot grp */
+
+		sgl++;
+		j++;
+
 		while (!pgdone) {
 			/* Check to see if we ran out of space */
-			if (num_sge >= phba->cfg_total_seg_cnt)
+			if ((num_sge >= phba->cfg_total_seg_cnt) &&
+			    !phba->cfg_xpsgl)
 				return num_sge + 1;
 
 			if (!sgde) {
@@ -2275,60 +2359,101 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 						__func__);
 				return 0;
 			}
-			sgl++;
-			dataphysaddr = sg_dma_address(sgde) + split_offset;
 
-			remainder = sg_dma_len(sgde) - split_offset;
+			if (!((j + 1) % phba->border_sge_num)) {
+				sgl->word2 = 0;
 
-			if ((subtotal + remainder) <= protgrp_bytes) {
-				/* we can use this whole buffer */
-				dma_len = remainder;
-				split_offset = 0;
+				/* set LSP type */
+				bf_set(lpfc_sli4_sge_type, sgl,
+				       LPFC_SGE_TYPE_LSP);
 
-				if ((subtotal + remainder) == protgrp_bytes)
-					pgdone = 1;
+				sgl_xtra = lpfc_get_sgl_per_hdwq(phba,
+								 lpfc_cmd);
+
+				if (unlikely(!sgl_xtra)) {
+					goto out;
+				} else {
+					sgl->addr_lo = cpu_to_le32(
+					  putPaddrLow(sgl_xtra->dma_phys_sgl));
+					sgl->addr_hi = cpu_to_le32(
+					  putPaddrHigh(sgl_xtra->dma_phys_sgl));
+				}
+
+				sgl->word2 = cpu_to_le32(sgl->word2);
+				sgl->sge_len = cpu_to_le32(
+						     phba->cfg_sg_dma_buf_size);
+
+				sgl = (struct sli4_sge *)sgl_xtra->dma_sgl;
 			} else {
-				/* must split this buffer with next prot grp */
-				dma_len = protgrp_bytes - subtotal;
-				split_offset += dma_len;
-			}
+				dataphysaddr = sg_dma_address(sgde) +
+								   split_offset;
 
-			subtotal += dma_len;
+				remainder = sg_dma_len(sgde) - split_offset;
 
-			sgl->addr_lo = cpu_to_le32(putPaddrLow(dataphysaddr));
-			sgl->addr_hi = cpu_to_le32(putPaddrHigh(dataphysaddr));
-			bf_set(lpfc_sli4_sge_last, sgl, 0);
-			bf_set(lpfc_sli4_sge_offset, sgl, dma_offset);
-			bf_set(lpfc_sli4_sge_type, sgl, LPFC_SGE_TYPE_DATA);
+				if ((subtotal + remainder) <= protgrp_bytes) {
+					/* we can use this whole buffer */
+					dma_len = remainder;
+					split_offset = 0;
 
-			sgl->sge_len = cpu_to_le32(dma_len);
-			dma_offset += dma_len;
+					if ((subtotal + remainder) ==
+								  protgrp_bytes)
+						pgdone = 1;
+				} else {
+					/* must split this buffer with next
+					 * prot grp
+					 */
+					dma_len = protgrp_bytes - subtotal;
+					split_offset += dma_len;
+				}
 
-			num_sge++;
-			curr_data++;
+				subtotal += dma_len;
 
-			if (split_offset)
-				break;
+				sgl->word2 = 0;
+				sgl->addr_lo = cpu_to_le32(putPaddrLow(
+								 dataphysaddr));
+				sgl->addr_hi = cpu_to_le32(putPaddrHigh(
+								 dataphysaddr));
+				bf_set(lpfc_sli4_sge_last, sgl, 0);
+				bf_set(lpfc_sli4_sge_offset, sgl, dma_offset);
+				bf_set(lpfc_sli4_sge_type, sgl,
+				       LPFC_SGE_TYPE_DATA);
 
-			/* Move to the next s/g segment if possible */
-			sgde = sg_next(sgde);
+				sgl->sge_len = cpu_to_le32(dma_len);
+				dma_offset += dma_len;
+
+				num_sge++;
+				curr_data++;
+
+				if (split_offset) {
+					sgl++;
+					j++;
+					break;
+				}
+
+				/* Move to the next s/g segment if possible */
+				sgde = sg_next(sgde);
+
+				sgl++;
+			}
+
+			j++;
 		}
 
 		if (protgroup_offset) {
 			/* update the reference tag */
 			reftag += protgrp_blks;
-			sgl++;
 			continue;
 		}
 
 		/* are we done ? */
 		if (curr_prot == protcnt) {
+			/* mark the last SGL */
+			sgl--;
 			bf_set(lpfc_sli4_sge_last, sgl, 1);
 			alldone = 1;
 		} else if (curr_prot < protcnt) {
 			/* advance to next prot buffer */
 			sgpe = sg_next(sgpe);
-			sgl++;
 
 			/* update the reference tag */
 			reftag += protgrp_blks;
@@ -2995,8 +3120,10 @@ lpfc_scsi_prep_dma_buf_s4(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 	uint32_t num_bde = 0;
 	uint32_t dma_len;
 	uint32_t dma_offset = 0;
-	int nseg;
+	int nseg, i, j;
 	struct ulp_bde64 *bde;
+	bool lsp_just_set = false;
+	struct sli4_hybrid_sgl *sgl_xtra = NULL;
 
 	/*
 	 * There are three possibilities here - use scatter-gather segment, use
@@ -3023,7 +3150,8 @@ lpfc_scsi_prep_dma_buf_s4(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 		sgl += 1;
 		first_data_sgl = sgl;
 		lpfc_cmd->seg_cnt = nseg;
-		if (lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt) {
+		if (!phba->cfg_xpsgl &&
+		    lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt) {
 			lpfc_printf_log(phba, KERN_ERR, LOG_BG, "9074 BLKGRD:"
 				" %s: Too many sg segments from "
 				"dma_map_sg.  Config %d, seg_cnt %d\n",
@@ -3044,22 +3172,80 @@ lpfc_scsi_prep_dma_buf_s4(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 		 * the IOCB. If it can't then the BDEs get added to a BPL as it
 		 * does for SLI-2 mode.
 		 */
-		scsi_for_each_sg(scsi_cmnd, sgel, nseg, num_bde) {
-			physaddr = sg_dma_address(sgel);
-			dma_len = sg_dma_len(sgel);
-			sgl->addr_lo = cpu_to_le32(putPaddrLow(physaddr));
-			sgl->addr_hi = cpu_to_le32(putPaddrHigh(physaddr));
-			sgl->word2 = le32_to_cpu(sgl->word2);
-			if ((num_bde + 1) == nseg)
+
+		/* for tracking segment boundaries */
+		sgel = scsi_sglist(scsi_cmnd);
+		j = 2;
+		for (i = 0; i < nseg; i++) {
+			sgl->word2 = 0;
+			if ((num_bde + 1) == nseg) {
 				bf_set(lpfc_sli4_sge_last, sgl, 1);
-			else
+				bf_set(lpfc_sli4_sge_type, sgl,
+				       LPFC_SGE_TYPE_DATA);
+			} else {
 				bf_set(lpfc_sli4_sge_last, sgl, 0);
-			bf_set(lpfc_sli4_sge_offset, sgl, dma_offset);
-			bf_set(lpfc_sli4_sge_type, sgl, LPFC_SGE_TYPE_DATA);
-			sgl->word2 = cpu_to_le32(sgl->word2);
-			sgl->sge_len = cpu_to_le32(dma_len);
-			dma_offset += dma_len;
-			sgl++;
+
+				/* do we need to expand the segment */
+				if (!lsp_just_set &&
+				    !((j + 1) % phba->border_sge_num) &&
+				    ((nseg - 1) != i)) {
+					/* set LSP type */
+					bf_set(lpfc_sli4_sge_type, sgl,
+					       LPFC_SGE_TYPE_LSP);
+
+					sgl_xtra = lpfc_get_sgl_per_hdwq(
+							phba, lpfc_cmd);
+
+					if (unlikely(!sgl_xtra)) {
+						lpfc_cmd->seg_cnt = 0;
+						scsi_dma_unmap(scsi_cmnd);
+						return 1;
+					}
+					sgl->addr_lo = cpu_to_le32(putPaddrLow(
+						       sgl_xtra->dma_phys_sgl));
+					sgl->addr_hi = cpu_to_le32(putPaddrHigh(
+						       sgl_xtra->dma_phys_sgl));
+
+				} else {
+					bf_set(lpfc_sli4_sge_type, sgl,
+					       LPFC_SGE_TYPE_DATA);
+				}
+			}
+
+			if (!(bf_get(lpfc_sli4_sge_type, sgl) &
+				     LPFC_SGE_TYPE_LSP)) {
+				if ((nseg - 1) == i)
+					bf_set(lpfc_sli4_sge_last, sgl, 1);
+
+				physaddr = sg_dma_address(sgel);
+				dma_len = sg_dma_len(sgel);
+				sgl->addr_lo = cpu_to_le32(putPaddrLow(
+							   physaddr));
+				sgl->addr_hi = cpu_to_le32(putPaddrHigh(
+							   physaddr));
+
+				bf_set(lpfc_sli4_sge_offset, sgl, dma_offset);
+				sgl->word2 = cpu_to_le32(sgl->word2);
+				sgl->sge_len = cpu_to_le32(dma_len);
+
+				dma_offset += dma_len;
+				sgel = sg_next(sgel);
+
+				sgl++;
+				lsp_just_set = false;
+
+			} else {
+				sgl->word2 = cpu_to_le32(sgl->word2);
+				sgl->sge_len = cpu_to_le32(
+						     phba->cfg_sg_dma_buf_size);
+
+				sgl = (struct sli4_sge *)sgl_xtra->dma_sgl;
+				i = i - 1;
+
+				lsp_just_set = true;
+			}
+
+			j++;
 		}
 		/*
 		 * Setup the first Payload BDE. For FCoE we just key off
@@ -3175,7 +3361,8 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 		lpfc_cmd->seg_cnt = datasegcnt;
 
 		/* First check if data segment count from SCSI Layer is good */
-		if (lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt) {
+		if (lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt &&
+		    !phba->cfg_xpsgl) {
 			WARN_ON_ONCE(lpfc_cmd->seg_cnt > phba->cfg_sg_seg_cnt);
 			ret = 2;
 			goto err;
@@ -3186,13 +3373,15 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 		switch (prot_group_type) {
 		case LPFC_PG_TYPE_NO_DIF:
 			/* Here we need to add a DISEED to the count */
-			if ((lpfc_cmd->seg_cnt + 1) > phba->cfg_total_seg_cnt) {
+			if (((lpfc_cmd->seg_cnt + 1) >
+					phba->cfg_total_seg_cnt) &&
+			    !phba->cfg_xpsgl) {
 				ret = 2;
 				goto err;
 			}
 
 			num_sge = lpfc_bg_setup_sgl(phba, scsi_cmnd, sgl,
-					datasegcnt);
+					datasegcnt, lpfc_cmd);
 
 			/* we should have 2 or more entries in buffer list */
 			if (num_sge < 2) {
@@ -3220,18 +3409,20 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 			 * There is a minimun of 3 SGEs used for every
 			 * protection data segment.
 			 */
-			if ((lpfc_cmd->prot_seg_cnt * 3) >
-			    (phba->cfg_total_seg_cnt - 2)) {
+			if (((lpfc_cmd->prot_seg_cnt * 3) >
+					(phba->cfg_total_seg_cnt - 2)) &&
+			    !phba->cfg_xpsgl) {
 				ret = 2;
 				goto err;
 			}
 
 			num_sge = lpfc_bg_setup_sgl_prot(phba, scsi_cmnd, sgl,
-					datasegcnt, protsegcnt);
+					datasegcnt, protsegcnt, lpfc_cmd);
 
 			/* we should have 3 or more entries in buffer list */
-			if ((num_sge < 3) ||
-			    (num_sge > phba->cfg_total_seg_cnt)) {
+			if (num_sge < 3 ||
+			    (num_sge > phba->cfg_total_seg_cnt &&
+			     !phba->cfg_xpsgl)) {
 				ret = 2;
 				goto err;
 			}
@@ -5913,7 +6104,7 @@ struct scsi_host_template lpfc_template_no_hr = {
 	.sg_tablesize		= LPFC_DEFAULT_SG_SEG_CNT,
 	.cmd_per_lun		= LPFC_CMD_PER_LUN,
 	.shost_attrs		= lpfc_hba_attrs,
-	.max_sectors		= 0xFFFF,
+	.max_sectors		= 0xFFFFFFFF,
 	.vendor_id		= LPFC_NL_VENDOR_ID,
 	.change_queue_depth	= scsi_change_queue_depth,
 	.track_queue_depth	= 1,
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 6e8b03f38fac..56c682be8fe7 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20234,6 +20234,13 @@ void lpfc_release_io_buf(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_ncmd,
 		spin_unlock_irqrestore(&qp->io_buf_list_put_lock,
 				       iflag);
 	}
+
+	if (phba->cfg_xpsgl && !phba->nvmet_support &&
+	    !list_empty(&lpfc_ncmd->dma_sgl_xtra_list))
+		lpfc_put_sgl_per_hdwq(phba, lpfc_ncmd);
+
+	if (!list_empty(&lpfc_ncmd->dma_cmd_rsp_list))
+		lpfc_put_cmd_rsp_buf_per_hdwq(phba, lpfc_ncmd);
 }
 
 /**
@@ -20448,3 +20455,288 @@ struct lpfc_io_buf *lpfc_get_io_buf(struct lpfc_hba *phba,
 
 	return lpfc_cmd;
 }
+
+/**
+ * lpfc_get_sgl_per_hdwq - Get one SGL chunk from hdwq's pool
+ * @phba: The HBA for which this call is being executed.
+ * @lpfc_buf: IO buf structure to append the SGL chunk
+ *
+ * This routine gets one SGL chunk buffer from hdwq's SGL chunk pool,
+ * and will allocate an SGL chunk if the pool is empty.
+ *
+ * Return codes:
+ *   NULL - Error
+ *   Pointer to sli4_hybrid_sgl - Success
+ **/
+struct sli4_hybrid_sgl *
+lpfc_get_sgl_per_hdwq(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_buf)
+{
+	struct sli4_hybrid_sgl *list_entry = NULL;
+	struct sli4_hybrid_sgl *tmp = NULL;
+	struct sli4_hybrid_sgl *allocated_sgl = NULL;
+	struct lpfc_sli4_hdw_queue *hdwq = lpfc_buf->hdwq;
+	struct list_head *buf_list = &hdwq->sgl_list;
+
+	spin_lock_irq(&hdwq->hdwq_lock);
+
+	if (likely(!list_empty(buf_list))) {
+		/* break off 1 chunk from the sgl_list */
+		list_for_each_entry_safe(list_entry, tmp,
+					 buf_list, list_node) {
+			list_move_tail(&list_entry->list_node,
+				       &lpfc_buf->dma_sgl_xtra_list);
+			break;
+		}
+	} else {
+		/* allocate more */
+		spin_unlock_irq(&hdwq->hdwq_lock);
+		tmp = kmalloc_node(sizeof(*tmp), GFP_ATOMIC,
+				   cpu_to_node(smp_processor_id()));
+		if (!tmp) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
+					"8353 error kmalloc memory for HDWQ "
+					"%d %s\n",
+					lpfc_buf->hdwq_no, __func__);
+			return NULL;
+		}
+
+		tmp->dma_sgl = dma_pool_alloc(phba->lpfc_sg_dma_buf_pool,
+					      GFP_ATOMIC, &tmp->dma_phys_sgl);
+		if (!tmp->dma_sgl) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
+					"8354 error pool_alloc memory for HDWQ "
+					"%d %s\n",
+					lpfc_buf->hdwq_no, __func__);
+			kfree(tmp);
+			return NULL;
+		}
+
+		spin_lock_irq(&hdwq->hdwq_lock);
+		list_add_tail(&tmp->list_node, &lpfc_buf->dma_sgl_xtra_list);
+	}
+
+	allocated_sgl = list_last_entry(&lpfc_buf->dma_sgl_xtra_list,
+					struct sli4_hybrid_sgl,
+					list_node);
+
+	spin_unlock_irq(&hdwq->hdwq_lock);
+
+	return allocated_sgl;
+}
+
+/**
+ * lpfc_put_sgl_per_hdwq - Put one SGL chunk into hdwq pool
+ * @phba: The HBA for which this call is being executed.
+ * @lpfc_buf: IO buf structure with the SGL chunk
+ *
+ * This routine puts one SGL chunk buffer into hdwq's SGL chunk pool.
+ *
+ * Return codes:
+ *   0 - Success
+ *   -EINVAL - Error
+ **/
+int
+lpfc_put_sgl_per_hdwq(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_buf)
+{
+	int rc = 0;
+	struct sli4_hybrid_sgl *list_entry = NULL;
+	struct sli4_hybrid_sgl *tmp = NULL;
+	struct lpfc_sli4_hdw_queue *hdwq = lpfc_buf->hdwq;
+	struct list_head *buf_list = &hdwq->sgl_list;
+
+	spin_lock_irq(&hdwq->hdwq_lock);
+
+	if (likely(!list_empty(&lpfc_buf->dma_sgl_xtra_list))) {
+		list_for_each_entry_safe(list_entry, tmp,
+					 &lpfc_buf->dma_sgl_xtra_list,
+					 list_node) {
+			list_move_tail(&list_entry->list_node,
+				       buf_list);
+		}
+	} else {
+		rc = -EINVAL;
+	}
+
+	spin_unlock_irq(&hdwq->hdwq_lock);
+	return rc;
+}
+
+/**
+ * lpfc_free_sgl_per_hdwq - Free all SGL chunks of hdwq pool
+ * @phba: phba object
+ * @hdwq: hdwq to cleanup sgl buff resources on
+ *
+ * This routine frees all SGL chunks of hdwq SGL chunk pool.
+ *
+ * Return codes:
+ *   None
+ **/
+void
+lpfc_free_sgl_per_hdwq(struct lpfc_hba *phba,
+		       struct lpfc_sli4_hdw_queue *hdwq)
+{
+	struct list_head *buf_list = &hdwq->sgl_list;
+	struct sli4_hybrid_sgl *list_entry = NULL;
+	struct sli4_hybrid_sgl *tmp = NULL;
+
+	spin_lock_irq(&hdwq->hdwq_lock);
+
+	/* Free sgl pool */
+	list_for_each_entry_safe(list_entry, tmp,
+				 buf_list, list_node) {
+		dma_pool_free(phba->lpfc_sg_dma_buf_pool,
+			      list_entry->dma_sgl,
+			      list_entry->dma_phys_sgl);
+		list_del(&list_entry->list_node);
+		kfree(list_entry);
+	}
+
+	spin_unlock_irq(&hdwq->hdwq_lock);
+}
+
+/**
+ * lpfc_get_cmd_rsp_buf_per_hdwq - Get one CMD/RSP buffer from hdwq
+ * @phba: The HBA for which this call is being executed.
+ * @lpfc_buf: IO buf structure to attach the CMD/RSP buffer
+ *
+ * This routine gets one CMD/RSP buffer from hdwq's CMD/RSP pool,
+ * and will allocate an CMD/RSP buffer if the pool is empty.
+ *
+ * Return codes:
+ *   NULL - Error
+ *   Pointer to fcp_cmd_rsp_buf - Success
+ **/
+struct fcp_cmd_rsp_buf *
+lpfc_get_cmd_rsp_buf_per_hdwq(struct lpfc_hba *phba,
+			      struct lpfc_io_buf *lpfc_buf)
+{
+	struct fcp_cmd_rsp_buf *list_entry = NULL;
+	struct fcp_cmd_rsp_buf *tmp = NULL;
+	struct fcp_cmd_rsp_buf *allocated_buf = NULL;
+	struct lpfc_sli4_hdw_queue *hdwq = lpfc_buf->hdwq;
+	struct list_head *buf_list = &hdwq->cmd_rsp_buf_list;
+
+	spin_lock_irq(&hdwq->hdwq_lock);
+
+	if (likely(!list_empty(buf_list))) {
+		/* break off 1 chunk from the list */
+		list_for_each_entry_safe(list_entry, tmp,
+					 buf_list,
+					 list_node) {
+			list_move_tail(&list_entry->list_node,
+				       &lpfc_buf->dma_cmd_rsp_list);
+			break;
+		}
+	} else {
+		/* allocate more */
+		spin_unlock_irq(&hdwq->hdwq_lock);
+		tmp = kmalloc_node(sizeof(*tmp), GFP_ATOMIC,
+				   cpu_to_node(smp_processor_id()));
+		if (!tmp) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
+					"8355 error kmalloc memory for HDWQ "
+					"%d %s\n",
+					lpfc_buf->hdwq_no, __func__);
+			return NULL;
+		}
+
+		tmp->fcp_cmnd = dma_pool_alloc(phba->lpfc_cmd_rsp_buf_pool,
+						GFP_ATOMIC,
+						&tmp->fcp_cmd_rsp_dma_handle);
+
+		if (!tmp->fcp_cmnd) {
+			lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
+					"8356 error pool_alloc memory for HDWQ "
+					"%d %s\n",
+					lpfc_buf->hdwq_no, __func__);
+			kfree(tmp);
+			return NULL;
+		}
+
+		tmp->fcp_rsp = (struct fcp_rsp *)((uint8_t *)tmp->fcp_cmnd +
+				sizeof(struct fcp_cmnd));
+
+		spin_lock_irq(&hdwq->hdwq_lock);
+		list_add_tail(&tmp->list_node, &lpfc_buf->dma_cmd_rsp_list);
+	}
+
+	allocated_buf = list_last_entry(&lpfc_buf->dma_cmd_rsp_list,
+					struct fcp_cmd_rsp_buf,
+					list_node);
+
+	spin_unlock_irq(&hdwq->hdwq_lock);
+
+	return allocated_buf;
+}
+
+/**
+ * lpfc_put_cmd_rsp_buf_per_hdwq - Put one CMD/RSP buffer into hdwq pool
+ * @phba: The HBA for which this call is being executed.
+ * @lpfc_buf: IO buf structure with the CMD/RSP buf
+ *
+ * This routine puts one CMD/RSP buffer into executing CPU's CMD/RSP pool.
+ *
+ * Return codes:
+ *   0 - Success
+ *   -EINVAL - Error
+ **/
+int
+lpfc_put_cmd_rsp_buf_per_hdwq(struct lpfc_hba *phba,
+			      struct lpfc_io_buf *lpfc_buf)
+{
+	int rc = 0;
+	struct fcp_cmd_rsp_buf *list_entry = NULL;
+	struct fcp_cmd_rsp_buf *tmp = NULL;
+	struct lpfc_sli4_hdw_queue *hdwq = lpfc_buf->hdwq;
+	struct list_head *buf_list = &hdwq->cmd_rsp_buf_list;
+
+	spin_lock_irq(&hdwq->hdwq_lock);
+
+	if (likely(!list_empty(&lpfc_buf->dma_cmd_rsp_list))) {
+		list_for_each_entry_safe(list_entry, tmp,
+					 &lpfc_buf->dma_cmd_rsp_list,
+					 list_node) {
+			list_move_tail(&list_entry->list_node,
+				       buf_list);
+		}
+	} else {
+		rc = -EINVAL;
+	}
+
+	spin_unlock_irq(&hdwq->hdwq_lock);
+	return rc;
+}
+
+/**
+ * lpfc_free_cmd_rsp_buf_per_hdwq - Free all CMD/RSP chunks of hdwq pool
+ * @phba: phba object
+ * @hdwq: hdwq to cleanup cmd rsp buff resources on
+ *
+ * This routine frees all CMD/RSP buffers of hdwq's CMD/RSP buf pool.
+ *
+ * Return codes:
+ *   None
+ **/
+void
+lpfc_free_cmd_rsp_buf_per_hdwq(struct lpfc_hba *phba,
+			       struct lpfc_sli4_hdw_queue *hdwq)
+{
+	struct list_head *buf_list = &hdwq->cmd_rsp_buf_list;
+	struct fcp_cmd_rsp_buf *list_entry = NULL;
+	struct fcp_cmd_rsp_buf *tmp = NULL;
+
+	spin_lock_irq(&hdwq->hdwq_lock);
+
+	/* Free cmd_rsp buf pool */
+	list_for_each_entry_safe(list_entry, tmp,
+				 buf_list,
+				 list_node) {
+		dma_pool_free(phba->lpfc_cmd_rsp_buf_pool,
+			      list_entry->fcp_cmnd,
+			      list_entry->fcp_cmd_rsp_dma_handle);
+		list_del(&list_entry->list_node);
+		kfree(list_entry);
+	}
+
+	spin_unlock_irq(&hdwq->hdwq_lock);
+}
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 467b8270f7fd..37fbcb46387e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -365,9 +365,18 @@ struct lpfc_io_buf {
 	/* Common fields */
 	struct list_head list;
 	void *data;
+
 	dma_addr_t dma_handle;
 	dma_addr_t dma_phys_sgl;
-	struct sli4_sge *dma_sgl;
+
+	struct sli4_sge *dma_sgl; /* initial segment chunk */
+
+	/* linked list of extra sli4_hybrid_sge */
+	struct list_head dma_sgl_xtra_list;
+
+	/* list head for fcp_cmd_rsp buf */
+	struct list_head dma_cmd_rsp_list;
+
 	struct lpfc_iocbq cur_iocbq;
 	struct lpfc_sli4_hdw_queue *hdwq;
 	uint16_t hdwq_no;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 329f7aa7e169..02275e49be6f 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -685,6 +685,13 @@ struct lpfc_sli4_hdw_queue {
 	uint32_t cpucheck_xmt_io[LPFC_CHECK_CPU_CNT];
 	uint32_t cpucheck_cmpl_io[LPFC_CHECK_CPU_CNT];
 #endif
+
+	/* Per HDWQ pool resources */
+	struct list_head sgl_list;
+	struct list_head cmd_rsp_buf_list;
+
+	/* Lock for syncing Per HDWQ pool resources */
+	spinlock_t hdwq_lock;
 };
 
 #ifdef LPFC_HDWQ_LOCK_STAT
@@ -1094,6 +1101,17 @@ int lpfc_sli4_post_status_check(struct lpfc_hba *);
 uint8_t lpfc_sli_config_mbox_subsys_get(struct lpfc_hba *, LPFC_MBOXQ_t *);
 uint8_t lpfc_sli_config_mbox_opcode_get(struct lpfc_hba *, LPFC_MBOXQ_t *);
 void lpfc_sli4_ras_dma_free(struct lpfc_hba *phba);
+struct sli4_hybrid_sgl *lpfc_get_sgl_per_hdwq(struct lpfc_hba *phba,
+					      struct lpfc_io_buf *buf);
+struct fcp_cmd_rsp_buf *lpfc_get_cmd_rsp_buf_per_hdwq(struct lpfc_hba *phba,
+						      struct lpfc_io_buf *buf);
+int lpfc_put_sgl_per_hdwq(struct lpfc_hba *phba, struct lpfc_io_buf *buf);
+int lpfc_put_cmd_rsp_buf_per_hdwq(struct lpfc_hba *phba,
+				  struct lpfc_io_buf *buf);
+void lpfc_free_sgl_per_hdwq(struct lpfc_hba *phba,
+			    struct lpfc_sli4_hdw_queue *hdwq);
+void lpfc_free_cmd_rsp_buf_per_hdwq(struct lpfc_hba *phba,
+				    struct lpfc_sli4_hdw_queue *hdwq);
 static inline void *lpfc_sli4_qe(struct lpfc_queue *q, uint16_t idx)
 {
 	return q->q_pgs[idx / q->entry_cnt_per_pg] +
-- 
2.13.7

