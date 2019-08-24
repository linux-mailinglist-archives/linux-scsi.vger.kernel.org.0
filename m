Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2459BCBD
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Aug 2019 11:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfHXJXu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 24 Aug 2019 05:23:50 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52520 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbfHXJXu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 24 Aug 2019 05:23:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 560A98EE429;
        Sat, 24 Aug 2019 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1566638629;
        bh=9Anpb/QOC/a+9PHkwatJpwn5NmP0apY1aVPY7wJsqLc=;
        h=Subject:From:To:Cc:Date:From;
        b=gLw7ytGN9avku7lQDWkCfKGDaldm3Njnx/g8lEvoKmGrP2K/TrujDiZbWF1Pv6qy1
         jcwigd+95mNHpMEs1V+ud4/l2d3CM7cF/s0cBz8JBM0ksnNKrDbZYacegqz30vWLZE
         zMsv3QMXXN5XAfU9scnO+EOD9gSxaRejzfUsezHY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vMXKbkcTV_q0; Sat, 24 Aug 2019 02:23:41 -0700 (PDT)
Received: from jarvis (host86-134-253-190.range86-134.btcentralplus.com [86.134.253.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C16518EE0A4;
        Sat, 24 Aug 2019 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1566638614;
        bh=9Anpb/QOC/a+9PHkwatJpwn5NmP0apY1aVPY7wJsqLc=;
        h=Subject:From:To:Cc:Date:From;
        b=iw8fNYdbDkkXXoQ3s11YzgdpNJbmtlQ5PkYlBIbmjpD20cGw7VGYTzMyt81hWiEdm
         4w019Z9MEwe7pdiVvI+0kWPR8ex0ejc85jLy8NPL5UnnhjrIRjQ7bsEvACbirOkHdp
         7c5Xe985D+SlBPixnF6P2BOuxAXzAGmvzCY/eDew=
Message-ID: <1566638608.2975.19.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.3-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 24 Aug 2019 10:23:28 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Four fixes, three for edge conditions which don't occur very often. 
The lpfc fix mitigates memory exhaustion for some high CPU systems.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Adrian Hunter (1):
      scsi: ufs: Fix NULL pointer dereference in ufshcd_config_vreg_hpm()

Bill Kuzeja (1):
      scsi: qla2xxx: Fix gnl.l memory leak on adapter init failure

Dmitry Fomichev (1):
      scsi: target: tcmu: avoid use-after-free after command timeout

James Smart (1):
      scsi: lpfc: Mitigate high memory pre-allocation by SCSI-MQ

and the diffstat:

 drivers/scsi/lpfc/lpfc.h          |  1 +
 drivers/scsi/lpfc/lpfc_attr.c     | 15 +++++++++++++++
 drivers/scsi/lpfc/lpfc_init.c     | 10 ++++++----
 drivers/scsi/lpfc/lpfc_sli4.h     |  5 +++++
 drivers/scsi/qla2xxx/qla_attr.c   |  2 ++
 drivers/scsi/qla2xxx/qla_os.c     | 11 ++++++++++-
 drivers/scsi/ufs/ufshcd.c         |  3 +++
 drivers/target/target_core_user.c |  9 +++++++--
 8 files changed, 49 insertions(+), 7 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 2c3bb8a966e5..bade2e025ecf 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -824,6 +824,7 @@ struct lpfc_hba {
 	uint32_t cfg_cq_poll_threshold;
 	uint32_t cfg_cq_max_proc_limit;
 	uint32_t cfg_fcp_cpu_map;
+	uint32_t cfg_fcp_mq_threshold;
 	uint32_t cfg_hdw_queue;
 	uint32_t cfg_irq_chann;
 	uint32_t cfg_suppress_rsp;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index ea62322ffe2b..8d8c495b5b60 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5708,6 +5708,19 @@ LPFC_ATTR_RW(nvme_oas, 0, 0, 1,
 LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
 	     "Embed NVME Command in WQE");
 
+/*
+ * lpfc_fcp_mq_threshold: Set the maximum number of Hardware Queues
+ * the driver will advertise it supports to the SCSI layer.
+ *
+ *      0    = Set nr_hw_queues by the number of CPUs or HW queues.
+ *      1,128 = Manually specify the maximum nr_hw_queue value to be set,
+ *
+ * Value range is [0,128]. Default value is 8.
+ */
+LPFC_ATTR_R(fcp_mq_threshold, LPFC_FCP_MQ_THRESHOLD_DEF,
+	    LPFC_FCP_MQ_THRESHOLD_MIN, LPFC_FCP_MQ_THRESHOLD_MAX,
+	    "Set the number of SCSI Queues advertised");
+
 /*
  * lpfc_hdw_queue: Set the number of Hardware Queues the driver
  * will advertise it supports to the NVME and  SCSI layers. This also
@@ -6030,6 +6043,7 @@ struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_lpfc_cq_poll_threshold,
 	&dev_attr_lpfc_cq_max_proc_limit,
 	&dev_attr_lpfc_fcp_cpu_map,
+	&dev_attr_lpfc_fcp_mq_threshold,
 	&dev_attr_lpfc_hdw_queue,
 	&dev_attr_lpfc_irq_chann,
 	&dev_attr_lpfc_suppress_rsp,
@@ -7112,6 +7126,7 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	/* Initialize first burst. Target vs Initiator are different. */
 	lpfc_nvme_enable_fb_init(phba, lpfc_nvme_enable_fb);
 	lpfc_nvmet_fb_size_init(phba, lpfc_nvmet_fb_size);
+	lpfc_fcp_mq_threshold_init(phba, lpfc_fcp_mq_threshold);
 	lpfc_hdw_queue_init(phba, lpfc_hdw_queue);
 	lpfc_irq_chann_init(phba, lpfc_irq_chann);
 	lpfc_enable_bbcr_init(phba, lpfc_enable_bbcr);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index a7549ae32542..1ac98becb5ba 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4309,10 +4309,12 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	shost->max_cmd_len = 16;
 
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		if (phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ)
-			shost->nr_hw_queues = phba->cfg_hdw_queue;
-		else
-			shost->nr_hw_queues = phba->sli4_hba.num_present_cpu;
+		if (!phba->cfg_fcp_mq_threshold ||
+		    phba->cfg_fcp_mq_threshold > phba->cfg_hdw_queue)
+			phba->cfg_fcp_mq_threshold = phba->cfg_hdw_queue;
+
+		shost->nr_hw_queues = min_t(int, 2 * num_possible_nodes(),
+					    phba->cfg_fcp_mq_threshold);
 
 		shost->dma_boundary =
 			phba->sli4_hba.pc_sli4_params.sge_supp_len-1;
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index 3aeca387b22a..329f7aa7e169 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -44,6 +44,11 @@
 #define LPFC_HBA_HDWQ_MAX	128
 #define LPFC_HBA_HDWQ_DEF	0
 
+/* FCP MQ queue count limiting */
+#define LPFC_FCP_MQ_THRESHOLD_MIN	0
+#define LPFC_FCP_MQ_THRESHOLD_MAX	128
+#define LPFC_FCP_MQ_THRESHOLD_DEF	8
+
 /* Common buffer size to accomidate SCSI and NVME IO buffers */
 #define LPFC_COMMON_IO_BUF_SZ	768
 
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 8d560c562e9c..6b7b390b2e52 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2956,6 +2956,8 @@ qla24xx_vport_delete(struct fc_vport *fc_vport)
 	dma_free_coherent(&ha->pdev->dev, vha->gnl.size, vha->gnl.l,
 	    vha->gnl.ldma);
 
+	vha->gnl.l = NULL;
+
 	vfree(vha->scan.l);
 
 	if (vha->qpair && vha->qpair->vp_idx == vha->vp_idx) {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2e58cff9d200..98e60a34afd9 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3440,6 +3440,12 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 probe_failed:
+	if (base_vha->gnl.l) {
+		dma_free_coherent(&ha->pdev->dev, base_vha->gnl.size,
+				base_vha->gnl.l, base_vha->gnl.ldma);
+		base_vha->gnl.l = NULL;
+	}
+
 	if (base_vha->timer_active)
 		qla2x00_stop_timer(base_vha);
 	base_vha->flags.online = 0;
@@ -3673,7 +3679,7 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	if (!atomic_read(&pdev->enable_cnt)) {
 		dma_free_coherent(&ha->pdev->dev, base_vha->gnl.size,
 		    base_vha->gnl.l, base_vha->gnl.ldma);
-
+		base_vha->gnl.l = NULL;
 		scsi_host_put(base_vha->host);
 		kfree(ha);
 		pci_set_drvdata(pdev, NULL);
@@ -3713,6 +3719,8 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	dma_free_coherent(&ha->pdev->dev,
 		base_vha->gnl.size, base_vha->gnl.l, base_vha->gnl.ldma);
 
+	base_vha->gnl.l = NULL;
+
 	vfree(base_vha->scan.l);
 
 	if (IS_QLAFX00(ha))
@@ -4816,6 +4824,7 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 		    "Alloc failed for scan database.\n");
 		dma_free_coherent(&ha->pdev->dev, vha->gnl.size,
 		    vha->gnl.l, vha->gnl.ldma);
+		vha->gnl.l = NULL;
 		scsi_remove_host(vha->host);
 		return NULL;
 	}
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e274053109d0..029da74bb2f5 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7062,6 +7062,9 @@ static inline int ufshcd_config_vreg_lpm(struct ufs_hba *hba,
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 					 struct ufs_vreg *vreg)
 {
+	if (!vreg)
+		return 0;
+
 	return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
 }
 
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 04eda111920e..661bb9358364 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1132,14 +1132,16 @@ static void tcmu_handle_completion(struct tcmu_cmd *cmd, struct tcmu_cmd_entry *
 	struct se_cmd *se_cmd = cmd->se_cmd;
 	struct tcmu_dev *udev = cmd->tcmu_dev;
 	bool read_len_valid = false;
-	uint32_t read_len = se_cmd->data_length;
+	uint32_t read_len;
 
 	/*
 	 * cmd has been completed already from timeout, just reclaim
 	 * data area space and free cmd
 	 */
-	if (test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags))
+	if (test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags)) {
+		WARN_ON_ONCE(se_cmd);
 		goto out;
+	}
 
 	list_del_init(&cmd->queue_entry);
 
@@ -1152,6 +1154,7 @@ static void tcmu_handle_completion(struct tcmu_cmd *cmd, struct tcmu_cmd_entry *
 		goto done;
 	}
 
+	read_len = se_cmd->data_length;
 	if (se_cmd->data_direction == DMA_FROM_DEVICE &&
 	    (entry->hdr.uflags & TCMU_UFLAG_READ_LEN) && entry->rsp.read_len) {
 		read_len_valid = true;
@@ -1307,6 +1310,7 @@ static int tcmu_check_expired_cmd(int id, void *p, void *data)
 		 */
 		scsi_status = SAM_STAT_CHECK_CONDITION;
 		list_del_init(&cmd->queue_entry);
+		cmd->se_cmd = NULL;
 	} else {
 		list_del_init(&cmd->queue_entry);
 		idr_remove(&udev->commands, id);
@@ -2022,6 +2026,7 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
 
 		idr_remove(&udev->commands, i);
 		if (!test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags)) {
+			WARN_ON(!cmd->se_cmd);
 			list_del_init(&cmd->queue_entry);
 			if (err_level == 1) {
 				/*
