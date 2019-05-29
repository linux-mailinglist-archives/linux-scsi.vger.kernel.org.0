Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A562E623
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfE2U25 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39564 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U24 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so2367887pfe.6
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bAFTUp46R3V7CJG4R+vKsdUuDmfxTjWeGEx7WClVdA=;
        b=W7zh9NsjWjZpd4wsv38c+lUllmiZls0bGVARtvj5GkHen6QRHJQ6bbeC6hSyTAFFBM
         7o3jTi78/1LwUYpTaaEMPGb4CrZbv44qfeGEwwVsqtzYTcAUulseb8Y9MytaGxLqgfT3
         K2Ivei1nG42zvsrHjrE4lxWG5BzKF+CRhaJ+lN/dayz5XVtr8MJGQLtdGPz01xyFZ3d4
         XEbYryCDTfqzwV3F4nVgDS3A2U/+3rvFoU74zuZZgAC/KMn9K4a7V2PWKW6McswK1LMK
         3pzvV6EwwWkAOnv5diXNMmy8y01S0UHrA2ZV9UVuW7LrWYgwf6eA1A8L2pYffS4t6uwv
         isUA==
X-Gm-Message-State: APjAAAXhKOt1psHk4jHLliFw5BQE1N3r3MRJUwECPXWSeMo56EU+3qyD
        GRh+gjhzFQpRNjDcBzF4E4dn4e8i
X-Google-Smtp-Source: APXvYqyvNyHYRDqXGnt7M3kwG6jV94uEUi42J+/VkoWIxQ2CGSLTYsGj//nOJ2ZqfxJzK/jQf7uzsA==
X-Received: by 2002:a63:191b:: with SMTP id z27mr140779028pgl.327.1559161735974;
        Wed, 29 May 2019 13:28:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 15/20] qla2xxx: Introduce qla2x00_els_dcmd2_free()
Date:   Wed, 29 May 2019 13:28:21 -0700
Message-Id: <20190529202826.204499-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reduce code duplication by introducing a function that frees the
memory used for PLOGIN.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |  2 +-
 drivers/scsi/qla2xxx/qla_gbl.h  |  2 ++
 drivers/scsi/qla2xxx/qla_gs.c   | 12 +---------
 drivers/scsi/qla2xxx/qla_iocb.c | 40 ++++++++++++++-------------------
 4 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index c787304347d7..8edca0a00586 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -395,7 +395,7 @@ struct srb_iocb {
 			struct els_logo_payload *els_logo_pyld;
 			dma_addr_t els_logo_pyld_dma;
 		} els_logo;
-		struct {
+		struct els_plogi {
 #define ELS_DCMD_PLOGI 0x3
 			uint32_t flags;
 			uint32_t els_cmd;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index a16c00b4773c..b2fb76cc1fef 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -45,6 +45,8 @@ extern int qla2x00_local_device_login(scsi_qla_host_t *, fc_port_t *);
 
 extern int qla24xx_els_dcmd_iocb(scsi_qla_host_t *, int, port_id_t);
 extern int qla24xx_els_dcmd2_iocb(scsi_qla_host_t *, int, fc_port_t *, bool);
+extern void qla2x00_els_dcmd2_free(scsi_qla_host_t *vha,
+				   struct els_plogi *els_plogi);
 
 extern void qla2x00_update_fcports(scsi_qla_host_t *);
 
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 68f445dd0cde..24a80ab53db2 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3142,17 +3142,7 @@ void qla24xx_sp_unmap(scsi_qla_host_t *vha, srb_t *sp)
 
 	switch (sp->type) {
 	case SRB_ELS_DCMD:
-		if (c->u.els_plogi.els_plogi_pyld)
-			dma_free_coherent(&vha->hw->pdev->dev,
-			    c->u.els_plogi.tx_size,
-			    c->u.els_plogi.els_plogi_pyld,
-			    c->u.els_plogi.els_plogi_pyld_dma);
-
-		if (c->u.els_plogi.els_resp_pyld)
-			dma_free_coherent(&vha->hw->pdev->dev,
-			    c->u.els_plogi.rx_size,
-			    c->u.els_plogi.els_resp_pyld,
-			    c->u.els_plogi.els_resp_pyld_dma);
+		qla2x00_els_dcmd2_free(vha, &c->u.els_plogi);
 		break;
 	case SRB_CT_PTHRU_CMD:
 	default:
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index b6161dfc7527..14f58fb91814 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2755,6 +2755,21 @@ qla2x00_els_dcmd2_iocb_timeout(void *data)
 	sp->done(sp, QLA_FUNCTION_TIMEOUT);
 }
 
+void qla2x00_els_dcmd2_free(scsi_qla_host_t *vha, struct els_plogi *els_plogi)
+{
+	if (els_plogi->els_plogi_pyld)
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  els_plogi->tx_size,
+				  els_plogi->els_plogi_pyld,
+				  els_plogi->els_plogi_pyld_dma);
+
+	if (els_plogi->els_resp_pyld)
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  els_plogi->rx_size,
+				  els_plogi->els_resp_pyld,
+				  els_plogi->els_resp_pyld_dma);
+}
+
 static void
 qla2x00_els_dcmd2_sp_done(void *ptr, int res)
 {
@@ -2789,17 +2804,7 @@ qla2x00_els_dcmd2_sp_done(void *ptr, int res)
 		if (!e) {
 			struct srb_iocb *elsio = &sp->u.iocb_cmd;
 
-			if (elsio->u.els_plogi.els_plogi_pyld)
-				dma_free_coherent(&sp->vha->hw->pdev->dev,
-				    elsio->u.els_plogi.tx_size,
-				    elsio->u.els_plogi.els_plogi_pyld,
-				    elsio->u.els_plogi.els_plogi_pyld_dma);
-
-			if (elsio->u.els_plogi.els_resp_pyld)
-				dma_free_coherent(&sp->vha->hw->pdev->dev,
-				    elsio->u.els_plogi.rx_size,
-				    elsio->u.els_plogi.els_resp_pyld,
-				    elsio->u.els_plogi.els_resp_pyld_dma);
+			qla2x00_els_dcmd2_free(vha, &elsio->u.els_plogi);
 			sp->free(sp);
 			return;
 		}
@@ -2899,18 +2904,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 out:
 	fcport->flags &= ~(FCF_ASYNC_SENT);
-	if (elsio->u.els_plogi.els_plogi_pyld)
-		dma_free_coherent(&sp->vha->hw->pdev->dev,
-		    elsio->u.els_plogi.tx_size,
-		    elsio->u.els_plogi.els_plogi_pyld,
-		    elsio->u.els_plogi.els_plogi_pyld_dma);
-
-	if (elsio->u.els_plogi.els_resp_pyld)
-		dma_free_coherent(&sp->vha->hw->pdev->dev,
-		    elsio->u.els_plogi.rx_size,
-		    elsio->u.els_plogi.els_resp_pyld,
-		    elsio->u.els_plogi.els_resp_pyld_dma);
-
+	qla2x00_els_dcmd2_free(vha, &elsio->u.els_plogi);
 	sp->free(sp);
 done:
 	return rval;
-- 
2.22.0.rc1

