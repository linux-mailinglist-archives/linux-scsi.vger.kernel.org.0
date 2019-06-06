Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7D36EC4
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfFFIeo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 04:34:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFIen (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Jun 2019 04:34:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9C688830F;
        Thu,  6 Jun 2019 08:34:41 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C275836FA;
        Thu,  6 Jun 2019 08:34:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH V3 3/3] scsi: esp: make it working on SG_CHAIN
Date:   Thu,  6 Jun 2019 16:34:10 +0800
Message-Id: <20190606083410.32243-4-ming.lei@redhat.com>
In-Reply-To: <20190606083410.32243-1-ming.lei@redhat.com>
References: <20190606083410.32243-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 06 Jun 2019 08:34:43 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver expects that SCSI SGL is a simply array of SG, and itereate
the SGL via integer index. This way is obviously wrong, because of
SG_CHAIN.

Fixes it by using sgl helper.

V2:
	- as suggested by Finn Thain, introduce .prv_sg for getting previous
	scatterlist pointer

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/esp_scsi.c | 20 +++++++++++++-------
 drivers/scsi/esp_scsi.h |  2 ++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 76e7ca864d6a..bb88995a12c7 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -371,6 +371,7 @@ static void esp_map_dma(struct esp *esp, struct scsi_cmnd *cmd)
 	struct esp_cmd_priv *spriv = ESP_CMD_PRIV(cmd);
 	struct scatterlist *sg = scsi_sglist(cmd);
 	int total = 0, i;
+	struct scatterlist *s;
 
 	if (cmd->sc_data_direction == DMA_NONE)
 		return;
@@ -381,16 +382,18 @@ static void esp_map_dma(struct esp *esp, struct scsi_cmnd *cmd)
 		 * a dma address, so perform an identity mapping.
 		 */
 		spriv->num_sg = scsi_sg_count(cmd);
-		for (i = 0; i < spriv->num_sg; i++) {
-			sg[i].dma_address = (uintptr_t)sg_virt(&sg[i]);
-			total += sg_dma_len(&sg[i]);
+
+		scsi_for_each_sg(cmd, s, spriv->num_sg, i) {
+			s->dma_address = (uintptr_t)sg_virt(s);
+			total += sg_dma_len(s);
 		}
 	} else {
 		spriv->num_sg = scsi_dma_map(cmd);
-		for (i = 0; i < spriv->num_sg; i++)
-			total += sg_dma_len(&sg[i]);
+		scsi_for_each_sg(cmd, s, spriv->num_sg, i)
+			total += sg_dma_len(s);
 	}
 	spriv->cur_residue = sg_dma_len(sg);
+	spriv->prv_sg = NULL;
 	spriv->cur_sg = sg;
 	spriv->tot_residue = total;
 }
@@ -444,7 +447,8 @@ static void esp_advance_dma(struct esp *esp, struct esp_cmd_entry *ent,
 		p->tot_residue = 0;
 	}
 	if (!p->cur_residue && p->tot_residue) {
-		p->cur_sg++;
+		p->prv_sg = p->cur_sg;
+		p->cur_sg = sg_next(p->cur_sg);
 		p->cur_residue = sg_dma_len(p->cur_sg);
 	}
 }
@@ -465,6 +469,7 @@ static void esp_save_pointers(struct esp *esp, struct esp_cmd_entry *ent)
 		return;
 	}
 	ent->saved_cur_residue = spriv->cur_residue;
+	ent->saved_prv_sg = spriv->prv_sg;
 	ent->saved_cur_sg = spriv->cur_sg;
 	ent->saved_tot_residue = spriv->tot_residue;
 }
@@ -479,6 +484,7 @@ static void esp_restore_pointers(struct esp *esp, struct esp_cmd_entry *ent)
 		return;
 	}
 	spriv->cur_residue = ent->saved_cur_residue;
+	spriv->prv_sg = ent->saved_prv_sg;
 	spriv->cur_sg = ent->saved_cur_sg;
 	spriv->tot_residue = ent->saved_tot_residue;
 }
@@ -1647,7 +1653,7 @@ static int esp_msgin_process(struct esp *esp)
 		spriv = ESP_CMD_PRIV(ent->cmd);
 
 		if (spriv->cur_residue == sg_dma_len(spriv->cur_sg)) {
-			spriv->cur_sg--;
+			spriv->cur_sg = spriv->prv_sg;
 			spriv->cur_residue = 1;
 		} else
 			spriv->cur_residue++;
diff --git a/drivers/scsi/esp_scsi.h b/drivers/scsi/esp_scsi.h
index aa87a6b72dcc..91b32f2a1a1b 100644
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -251,6 +251,7 @@
 struct esp_cmd_priv {
 	int			num_sg;
 	int			cur_residue;
+	struct scatterlist	*prv_sg;
 	struct scatterlist	*cur_sg;
 	int			tot_residue;
 };
@@ -273,6 +274,7 @@ struct esp_cmd_entry {
 	struct scsi_cmnd	*cmd;
 
 	unsigned int		saved_cur_residue;
+	struct scatterlist	*saved_prv_sg;
 	struct scatterlist	*saved_cur_sg;
 	unsigned int		saved_tot_residue;
 
-- 
2.20.1

