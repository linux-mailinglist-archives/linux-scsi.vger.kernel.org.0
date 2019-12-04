Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1728A112DEA
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Dec 2019 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfLDO7c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Dec 2019 09:59:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:36328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728117AbfLDO71 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 4 Dec 2019 09:59:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 969EDAF10;
        Wed,  4 Dec 2019 14:59:25 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        Balsundar P <balsundar.p@microchip.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH 12/13] aacraid: use scsi_host_busy_iter() in get_num_of_incomplete_fibs()
Date:   Wed,  4 Dec 2019 15:59:17 +0100
Message-Id: <20191204145918.143134-13-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191204145918.143134-1-hare@suse.de>
References: <20191204145918.143134-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scsi midlayer helper to traverse the number of outstanding
commands. This also eliminates the last usage for the cmd_list
functionality so we can drop it.

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Acked-by: Balsundar P <balsundar.p@microchip.com>
---
 drivers/scsi/aacraid/linit.c | 81 ++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 877464e9d520..d0d1f3072c0c 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -622,54 +622,56 @@ static int aac_ioctl(struct scsi_device *sdev, unsigned int cmd,
 	return aac_do_ioctl(dev, cmd, arg);
 }
 
-static int get_num_of_incomplete_fibs(struct aac_dev *aac)
+struct fib_count_data {
+	int mlcnt;
+	int llcnt;
+	int ehcnt;
+	int fwcnt;
+	int krlcnt;
+};
+
+static bool fib_count_iter(struct scsi_cmnd *scmnd, void *data, bool reserved)
 {
+	struct fib_count_data *fib_count = data;
+
+	switch (scmnd->SCp.phase) {
+	case AAC_OWNER_FIRMWARE:
+		fib_count->fwcnt++;
+		break;
+	case AAC_OWNER_ERROR_HANDLER:
+		fib_count->ehcnt++;
+		break;
+	case AAC_OWNER_LOWLEVEL:
+		fib_count->llcnt++;
+		break;
+	case AAC_OWNER_MIDLEVEL:
+		fib_count->mlcnt++;
+		break;
+	default:
+		fib_count->krlcnt++;
+		break;
+	}
+	return true;
+}
 
-	unsigned long flags;
-	struct scsi_device *sdev = NULL;
+/* Called during SCSI EH, so we don't need to block requests */
+static int get_num_of_incomplete_fibs(struct aac_dev *aac)
+{
 	struct Scsi_Host *shost = aac->scsi_host_ptr;
-	struct scsi_cmnd *scmnd = NULL;
 	struct device *ctrl_dev;
+	struct fib_count_data fcnt = { };
 
-	int mlcnt  = 0;
-	int llcnt  = 0;
-	int ehcnt  = 0;
-	int fwcnt  = 0;
-	int krlcnt = 0;
-
-	__shost_for_each_device(sdev, shost) {
-		spin_lock_irqsave(&sdev->list_lock, flags);
-		list_for_each_entry(scmnd, &sdev->cmd_list, list) {
-			switch (scmnd->SCp.phase) {
-			case AAC_OWNER_FIRMWARE:
-				fwcnt++;
-				break;
-			case AAC_OWNER_ERROR_HANDLER:
-				ehcnt++;
-				break;
-			case AAC_OWNER_LOWLEVEL:
-				llcnt++;
-				break;
-			case AAC_OWNER_MIDLEVEL:
-				mlcnt++;
-				break;
-			default:
-				krlcnt++;
-				break;
-			}
-		}
-		spin_unlock_irqrestore(&sdev->list_lock, flags);
-	}
+	scsi_host_busy_iter(shost, fib_count_iter, &fcnt);
 
 	ctrl_dev = &aac->pdev->dev;
 
-	dev_info(ctrl_dev, "outstanding cmd: midlevel-%d\n", mlcnt);
-	dev_info(ctrl_dev, "outstanding cmd: lowlevel-%d\n", llcnt);
-	dev_info(ctrl_dev, "outstanding cmd: error handler-%d\n", ehcnt);
-	dev_info(ctrl_dev, "outstanding cmd: firmware-%d\n", fwcnt);
-	dev_info(ctrl_dev, "outstanding cmd: kernel-%d\n", krlcnt);
+	dev_info(ctrl_dev, "outstanding cmd: midlevel-%d\n", fcnt.mlcnt);
+	dev_info(ctrl_dev, "outstanding cmd: lowlevel-%d\n", fcnt.llcnt);
+	dev_info(ctrl_dev, "outstanding cmd: error handler-%d\n", fcnt.ehcnt);
+	dev_info(ctrl_dev, "outstanding cmd: firmware-%d\n", fcnt.fwcnt);
+	dev_info(ctrl_dev, "outstanding cmd: kernel-%d\n", fcnt.krlcnt);
 
-	return mlcnt + llcnt + ehcnt + fwcnt;
+	return fcnt.mlcnt + fcnt.llcnt + fcnt.ehcnt + fcnt.fwcnt;
 }
 
 static int aac_eh_abort(struct scsi_cmnd* cmd)
@@ -1675,7 +1677,6 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->irq = pdev->irq;
 	shost->unique_id = unique_id;
 	shost->max_cmd_len = 16;
-	shost->use_cmd_list = 1;
 
 	if (aac_cfg_major == AAC_CHARDEV_NEEDS_REINIT)
 		aac_init_char();
-- 
2.16.4

