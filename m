Return-Path: <linux-scsi+bounces-840-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57980D445
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A71B21571
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C544EB29;
	Mon, 11 Dec 2023 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="MB01OxqD"
X-Original-To: linux-scsi@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC3D0;
	Mon, 11 Dec 2023 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10128; q=dns/txt;
  s=iport; t=1702316495; x=1703526095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C1Op3uVfWwQ0AGy+vXJw9fLd3TzW6SmqLiQ2mrLmgSg=;
  b=MB01OxqDoaFPGpsXxpG5PQ8FcZ4XmOQ7DE+DA+bFxBVfH7VPA+UGJ/f9
   1PlIe/FtmtakVvqUNh4HBbn0PWn4FtN0QP5bVlN7Hp1667wU5Qzg8786j
   zWegG5KdKXlzhKi2OO1wyFJS2LrEDjmUM2TjolE1ACG+NF+HQ5oXL+MAv
   Y=;
X-CSE-ConnectionGUID: NpBgdNW7TWe7KLfy3lVQcg==
X-CSE-MsgGUID: 7Hl5l11jR/Wf8tnQaeMaCw==
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="193291613"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by alln-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:41:35 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3BBHaKr4009547
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 Dec 2023 17:41:34 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 10/13] scsi: fnic: Add support for multiqueue (MQ) in fnic_main.c
Date: Mon, 11 Dec 2023 09:36:14 -0800
Message-Id: <20231211173617.932990-11-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231211173617.932990-1-kartilak@cisco.com>
References: <20231211173617.932990-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-1.cisco.com

Set map_queues in the fnic_host_template to fnic_mq_map_queues_cpus.
Define fnic_mq_map_queues_cpus to set cpu assignment to
fnic queues.
Refactor code in fnic_probe to enable vnic queues before scsi_add_host.
Modify notify set to the correct index.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v4 and v5:
    Incorporate review comments from Martin:
	Modify patch commits to include a "---" separator.

Changes between v2 and v3:
    Incorporate review comment from Hannes:
        Replace cpy_wq_base with copy_wq_base.
    Incorporate review comment from John Garry:
	Replace code in fnic_mq_map_queues_cpus
	with blk_mq_pci_map_queues.
    Replace shost_printk logs with FNIC_MAIN_DBG.
---
 drivers/scsi/fnic/fnic.h      |   4 +-
 drivers/scsi/fnic/fnic_main.c | 107 ++++++++++++++++++++++++----------
 2 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 8b3e4fe1ce92..879e0f5b9b0a 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -109,7 +109,7 @@ static inline u64 fnic_flags_and_state(struct scsi_cmnd *cmd)
 #define FNIC_ABT_TERM_DELAY_TIMEOUT  500        /* mSec */
 
 #define FNIC_MAX_FCP_TARGET     256
-
+#define FNIC_PCI_OFFSET		2
 /**
  * state_flags to identify host state along along with fnic's state
  **/
@@ -386,7 +386,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 int fnic_fw_reset_handler(struct fnic *fnic);
 void fnic_terminate_rport_io(struct fc_rport *);
 const char *fnic_state_to_str(unsigned int state);
-
+void fnic_mq_map_queues_cpus(struct Scsi_Host *host);
 void fnic_log_q_error(struct fnic *fnic);
 void fnic_handle_link_event(struct fnic *fnic);
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 5726c0fb6f0f..7fee8a024edb 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -12,9 +12,11 @@
 #include <linux/pci.h>
 #include <linux/skbuff.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/if_ether.h>
+#include <linux/blk-mq-pci.h>
 #include <scsi/fc/fc_fip.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h>
@@ -114,6 +116,7 @@ static const struct scsi_host_template fnic_host_template = {
 	.shost_groups = fnic_host_groups,
 	.track_queue_depth = 1,
 	.cmd_size = sizeof(struct fnic_cmd_priv),
+	.map_queues = fnic_mq_map_queues_cpus,
 };
 
 static void
@@ -390,7 +393,7 @@ static int fnic_notify_set(struct fnic *fnic)
 		err = vnic_dev_notify_set(fnic->vdev, -1);
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX:
-		err = vnic_dev_notify_set(fnic->vdev, FNIC_MSIX_ERR_NOTIFY);
+		err = vnic_dev_notify_set(fnic->vdev, fnic->wq_copy_count + fnic->copy_wq_base);
 		break;
 	default:
 		shost_printk(KERN_ERR, fnic->lport->host,
@@ -563,11 +566,6 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 	host->max_cmd_len = FCOE_MAX_CMD_LEN;
 
 	host->nr_hw_queues = fnic->wq_copy_count;
-	if (host->nr_hw_queues > 1)
-		shost_printk(KERN_ERR, host,
-				"fnic: blk-mq is not supported");
-
-	host->nr_hw_queues = fnic->wq_copy_count = 1;
 
 	shost_printk(KERN_INFO, host,
 			"fnic: can_queue: %d max_lun: %llu",
@@ -580,6 +578,32 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 	return 0;
 }
 
+void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
+{
+	struct fc_lport *lp = shost_priv(host);
+	struct fnic *fnic = lport_priv(lp);
+	struct pci_dev *l_pdev = fnic->pdev;
+	int intr_mode = fnic->config.intr_mode;
+	struct blk_mq_queue_map *qmap = &host->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	if (intr_mode == VNIC_DEV_INTR_MODE_MSI || intr_mode == VNIC_DEV_INTR_MODE_INTX) {
+		FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"intr_mode is not msix\n");
+		return;
+	}
+
+	FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"qmap->nr_queues: %d\n", qmap->nr_queues);
+
+	if (l_pdev == NULL) {
+		FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+						"l_pdev is null\n");
+		return;
+	}
+
+	blk_mq_pci_map_queues(qmap, l_pdev, FNIC_PCI_OFFSET);
+}
+
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct Scsi_Host *host;
@@ -590,6 +614,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int fnic_id = 0;
 	int i;
 	unsigned long flags;
+	int hwq;
 
 	/*
 	 * Allocate SCSI Host and set up association between host,
@@ -613,8 +638,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	fnic->lport = lp;
 	fnic->ctlr.lp = lp;
-
 	fnic->link_events = 0;
+	fnic->pdev = pdev;
 
 	snprintf(fnic->name, sizeof(fnic->name) - 1, "%s%d", DRV_NAME,
 		 host->host_no);
@@ -623,11 +648,6 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fnic->fnic_num = fnic_id;
 	fnic_stats_debugfs_init(fnic);
 
-	/* Setup PCI resources */
-	pci_set_drvdata(pdev, fnic);
-
-	fnic->pdev = pdev;
-
 	err = pci_enable_device(pdev);
 	if (err) {
 		shost_printk(KERN_ERR, fnic->lport->host,
@@ -729,7 +749,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev_close;
 	}
 
-	fnic_scsi_drv_init(fnic);
+	/* Setup PCI resources */
+	pci_set_drvdata(pdev, fnic);
 
 	fnic_get_res_counts(fnic);
 
@@ -749,6 +770,16 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_clear_intr;
 	}
 
+	fnic_scsi_drv_init(fnic);
+
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++) {
+		fnic->sw_copy_wq[hwq].ioreq_table_size = fnic->fnic_max_tag_id;
+		fnic->sw_copy_wq[hwq].io_req_table =
+					kzalloc((fnic->sw_copy_wq[hwq].ioreq_table_size + 1) *
+					sizeof(struct fnic_io_req *), GFP_KERNEL);
+	}
+	shost_printk(KERN_INFO, fnic->lport->host, "fnic copy wqs: %d, Q0 ioreq table size: %d\n",
+			fnic->wq_copy_count, fnic->sw_copy_wq[0].ioreq_table_size);
 
 	/* initialize all fnic locks */
 	spin_lock_init(&fnic->fnic_lock);
@@ -835,16 +866,32 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* allocate RQ buffers and post them to RQ*/
 	for (i = 0; i < fnic->rq_count; i++) {
-		vnic_rq_enable(&fnic->rq[i]);
 		err = vnic_rq_fill(&fnic->rq[i], fnic_alloc_rq_frame);
 		if (err) {
 			shost_printk(KERN_ERR, fnic->lport->host,
 				     "fnic_alloc_rq_frame can't alloc "
 				     "frame\n");
-			goto err_out_free_rq_buf;
+			goto err_out_rq_buf;
 		}
 	}
 
+	/* Enable all queues */
+	for (i = 0; i < fnic->raw_wq_count; i++)
+		vnic_wq_enable(&fnic->wq[i]);
+	for (i = 0; i < fnic->rq_count; i++) {
+		if (!ioread32(&fnic->rq[i].ctrl->enable))
+			vnic_rq_enable(&fnic->rq[i]);
+	}
+	for (i = 0; i < fnic->wq_copy_count; i++)
+		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
+
+	err = fnic_request_intr(fnic);
+	if (err) {
+		shost_printk(KERN_ERR, fnic->lport->host,
+			     "Unable to request irq.\n");
+		goto err_out_request_intr;
+	}
+
 	/*
 	 * Initialization done with PCI system, hardware, firmware.
 	 * Add host to SCSI
@@ -853,9 +900,10 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		shost_printk(KERN_ERR, fnic->lport->host,
 			     "fnic: scsi_add_host failed...exiting\n");
-		goto err_out_free_rq_buf;
+		goto err_out_scsi_add_host;
 	}
 
+
 	/* Start local port initiatialization */
 
 	lp->link_up = 0;
@@ -879,7 +927,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!fc_exch_mgr_alloc(lp, FC_CLASS_3, FCPIO_HOST_EXCH_RANGE_START,
 			       FCPIO_HOST_EXCH_RANGE_END, NULL)) {
 		err = -ENOMEM;
-		goto err_out_remove_scsi_host;
+		goto err_out_fc_exch_mgr_alloc;
 	}
 
 	fc_lport_init_stats(lp);
@@ -907,21 +955,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	skb_queue_head_init(&fnic->frame_queue);
 	skb_queue_head_init(&fnic->tx_queue);
 
-	/* Enable all queues */
-	for (i = 0; i < fnic->raw_wq_count; i++)
-		vnic_wq_enable(&fnic->wq[i]);
-	for (i = 0; i < fnic->wq_copy_count; i++)
-		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
-
 	fc_fabric_login(lp);
 
-	err = fnic_request_intr(fnic);
-	if (err) {
-		shost_printk(KERN_ERR, fnic->lport->host,
-			     "Unable to request irq.\n");
-		goto err_out_free_exch_mgr;
-	}
-
 	vnic_dev_enable(fnic->vdev);
 
 	for (i = 0; i < fnic->intr_count; i++)
@@ -933,12 +968,15 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_out_free_exch_mgr:
 	fc_exch_mgr_free(lp);
-err_out_remove_scsi_host:
+err_out_fc_exch_mgr_alloc:
 	fc_remove_host(lp->host);
 	scsi_remove_host(lp->host);
-err_out_free_rq_buf:
+err_out_scsi_add_host:
+	fnic_free_intr(fnic);
+err_out_request_intr:
 	for (i = 0; i < fnic->rq_count; i++)
 		vnic_rq_clean(&fnic->rq[i], fnic_free_rq_buf);
+err_out_rq_buf:
 	vnic_dev_notify_unset(fnic->vdev);
 err_out_free_max_pool:
 	mempool_destroy(fnic->io_sgl_pool[FNIC_SGL_CACHE_MAX]);
@@ -947,6 +985,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_free_ioreq_pool:
 	mempool_destroy(fnic->io_req_pool);
 err_out_free_resources:
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
+		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 	fnic_free_vnic_resources(fnic);
 err_out_clear_intr:
 	fnic_clear_intr_mode(fnic);
@@ -975,6 +1015,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	struct fnic *fnic = pci_get_drvdata(pdev);
 	struct fc_lport *lp = fnic->lport;
 	unsigned long flags;
+	int hwq;
 
 	/*
 	 * Mark state so that the workqueue thread stops forwarding
@@ -1035,6 +1076,8 @@ static void fnic_remove(struct pci_dev *pdev)
 
 	fc_remove_host(fnic->lport->host);
 	scsi_remove_host(fnic->lport->host);
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
+		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 	fc_exch_mgr_free(fnic->lport);
 	vnic_dev_notify_unset(fnic->vdev);
 	fnic_free_intr(fnic);
-- 
2.31.1


