Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF42025AF
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Jun 2020 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgFTRmU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Jun 2020 13:42:20 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36364 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728204AbgFTRmT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 20 Jun 2020 13:42:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E49F88EE1C8;
        Sat, 20 Jun 2020 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592674939;
        bh=Wjm8HTkUVvG2MwNrMxnygBRVlJRlbjR50PXYhnA9bt8=;
        h=Subject:From:To:Cc:Date:From;
        b=XdlF+nsBpv1cZOFxQJrI701+JpaR7W4xq3acKXjekzEi87pMl5LE+VHjKtEYOflpG
         9CR5Tr67lDJ7Il+4qvP+aMiqLLQSKu0FSMjqb9mEsbo5N127Bpxj0bcIfmm8k6eUFS
         enhk/BzEzNyV6NF51Fq/wP5OR2OYFZCOrWDVhfXs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kBQV30pNcngb; Sat, 20 Jun 2020 10:42:18 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 348F68EE0DF;
        Sat, 20 Jun 2020 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592674938;
        bh=Wjm8HTkUVvG2MwNrMxnygBRVlJRlbjR50PXYhnA9bt8=;
        h=Subject:From:To:Cc:Date:From;
        b=r6smU9a2Z2COX6LQxJjxj4HzyBcEoQ7+6dlbMwXD6NmZHYQGh37UTnu3Yn78p61WH
         etmO815GJlZzrIvj5rOdO1xJOmeOKYtqdM+IAprYBBK5vt/wxLx/FIwXdlxryLmdYl
         blO48pbW0GhM4gVqVNa7wjUdXRaSnmmMOVmBxKnE=
Message-ID: <1592674936.3583.20.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.8-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 20 Jun 2020 10:42:16 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

One minor fix and two patches reworking the ata dma drain for the
!CONFIG_LIBATA case.  The latter is a regression fix for cc97923a5bcc
("block: move dma drain handling to scsi")

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Christoph Hellwig (2):
      scsi: Wire up ata_scsi_dma_need_drain for SAS HBA drivers
      scsi: libata: Provide an ata_scsi_dma_need_drain stub for !CONFIG_ATA

Dinghao Liu (1):
      scsi: ufs-bsg: Fix runtime PM imbalance on error


And the diffstat:

 drivers/scsi/aic94xx/aic94xx_init.c    | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 +
 drivers/scsi/ipr.c                     | 1 +
 drivers/scsi/isci/init.c               | 1 +
 drivers/scsi/mvsas/mv_init.c           | 1 +
 drivers/scsi/pm8001/pm8001_init.c      | 1 +
 drivers/scsi/ufs/ufs_bsg.c             | 4 +++-
 include/linux/libata.h                 | 4 ++++
 10 files changed, 15 insertions(+), 1 deletion(-)

With full diff below.

James

---

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index d022407e5645..bef47f38dd0d 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -40,6 +40,7 @@ static struct scsi_host_template aic94xx_sht = {
 	/* .name is initialized */
 	.name			= "aic94xx",
 	.queuecommand		= sas_queuecommand,
+	.dma_need_drain		= ata_scsi_dma_need_drain,
 	.target_alloc		= sas_target_alloc,
 	.slave_configure	= sas_slave_configure,
 	.scan_finished		= asd_scan_finished,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 2e1718f9ade2..09a7669dad4c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1756,6 +1756,7 @@ static struct scsi_host_template sht_v1_hw = {
 	.proc_name		= DRV_NAME,
 	.module			= THIS_MODULE,
 	.queuecommand		= sas_queuecommand,
+	.dma_need_drain		= ata_scsi_dma_need_drain,
 	.target_alloc		= sas_target_alloc,
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index e7e7849a4c14..968d38702353 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3532,6 +3532,7 @@ static struct scsi_host_template sht_v2_hw = {
 	.proc_name		= DRV_NAME,
 	.module			= THIS_MODULE,
 	.queuecommand		= sas_queuecommand,
+	.dma_need_drain		= ata_scsi_dma_need_drain,
 	.target_alloc		= sas_target_alloc,
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3e6b78a1f993..55e2321a65bc 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3075,6 +3075,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.proc_name		= DRV_NAME,
 	.module			= THIS_MODULE,
 	.queuecommand		= sas_queuecommand,
+	.dma_need_drain		= ata_scsi_dma_need_drain,
 	.target_alloc		= sas_target_alloc,
 	.slave_configure	= hisi_sas_slave_configure,
 	.scan_finished		= hisi_sas_scan_finished,
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 7d77997d26d4..7d86f4ca266c 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6731,6 +6731,7 @@ static struct scsi_host_template driver_template = {
 	.compat_ioctl = ipr_ioctl,
 #endif
 	.queuecommand = ipr_queuecommand,
+	.dma_need_drain = ata_scsi_dma_need_drain,
 	.eh_abort_handler = ipr_eh_abort,
 	.eh_device_reset_handler = ipr_eh_dev_reset,
 	.eh_host_reset_handler = ipr_eh_host_reset,
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 974c3b9116d5..085e285f427d 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -153,6 +153,7 @@ static struct scsi_host_template isci_sht = {
 	.name				= DRV_NAME,
 	.proc_name			= DRV_NAME,
 	.queuecommand			= sas_queuecommand,
+	.dma_need_drain			= ata_scsi_dma_need_drain,
 	.target_alloc			= sas_target_alloc,
 	.slave_configure		= sas_slave_configure,
 	.scan_finished			= isci_host_scan_finished,
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 5973eed94938..b0de3bdb01db 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -33,6 +33,7 @@ static struct scsi_host_template mvs_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.queuecommand		= sas_queuecommand,
+	.dma_need_drain		= ata_scsi_dma_need_drain,
 	.target_alloc		= sas_target_alloc,
 	.slave_configure	= sas_slave_configure,
 	.scan_finished		= mvs_scan_finished,
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index a8f5344fdfda..9e99262a2b9d 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -87,6 +87,7 @@ static struct scsi_host_template pm8001_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.queuecommand		= sas_queuecommand,
+	.dma_need_drain		= ata_scsi_dma_need_drain,
 	.target_alloc		= sas_target_alloc,
 	.slave_configure	= sas_slave_configure,
 	.scan_finished		= pm8001_scan_finished,
diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 53dd87628cbe..516a7f573942 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -106,8 +106,10 @@ static int ufs_bsg_request(struct bsg_job *job)
 		desc_op = bsg_request->upiu_req.qr.opcode;
 		ret = ufs_bsg_alloc_desc_buffer(hba, job, &desc_buff,
 						&desc_len, desc_op);
-		if (ret)
+		if (ret) {
+			pm_runtime_put_sync(hba->dev);
 			goto out;
+		}
 
 		/* fall through */
 	case UPIU_TRANSACTION_NOP_OUT:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index af832852e620..042e584daca7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1092,7 +1092,11 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 #define ATA_SCSI_COMPAT_IOCTL /* empty */
 #endif
 extern int ata_scsi_queuecmd(struct Scsi_Host *h, struct scsi_cmnd *cmd);
+#if IS_ENABLED(CONFIG_ATA)
 bool ata_scsi_dma_need_drain(struct request *rq);
+#else
+#define ata_scsi_dma_need_drain NULL
+#endif
 extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
 			    unsigned int cmd, void __user *arg);
 extern bool ata_link_online(struct ata_link *link);

