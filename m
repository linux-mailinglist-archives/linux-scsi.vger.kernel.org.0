Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6476C7E1BC
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbfHAR5j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45993 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfHAR5j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so34496212pfq.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhFQNj283ds4+ZGrKCdh7tPisaHbmzrJm6/C8COrbh8=;
        b=q5wjY+wbuwFDR6Rij3hX31WGPBppwaZKpLWkQznV1iZ25V7IYwOZFYD+EkQ5l8ZJ/5
         fMfhByMQGbQMiNphwRohJ0j3qPtwya1KwjKWYLzGxA7vqDMC4+FIj5n5EuAh2yNno6xK
         bmv0/VbljlRRmg8gnfiGY/sJ1Esvz08Q9gfRjzwLatlF1LF5I3roNDlDx+jZ7OAl0P8m
         rqJJPRM4MdOD871/0D4qcDZB8DXsrhDCgUNN7m95vzQO03Xq36+SGM5ijpj9SNvoFYXP
         uPLjrXPi6vfxp/VSLLvXWOhL5svV7LVKzyrnM+AzsYeNX7ZWbslrOF/2kefEY8FCKnRS
         Romw==
X-Gm-Message-State: APjAAAVUtshEIbcgImS8L/gI/eSpE9f1HomK42lDzfE/CZ2sEw8XPFFw
        y+NsdE2Bbx6Q+Bx6FoiDJl4=
X-Google-Smtp-Source: APXvYqzxFOlLOs4EkVzihhX1zEXNtur0K9RgWMXnTqh7yOyhyUsk9vYaAfW63vk3QQoE+sklMzkWlg==
X-Received: by 2002:a63:7709:: with SMTP id s9mr4490536pgc.296.1564682258337;
        Thu, 01 Aug 2019 10:57:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 56/59] qla2xxx: Introduce qla2x00_els_dcmd2_free()
Date:   Thu,  1 Aug 2019 10:56:11 -0700
Message-Id: <20190801175614.73655-57-bvanassche@acm.org>
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
 drivers/scsi/qla2xxx/qla_def.h  |  2 +-
 drivers/scsi/qla2xxx/qla_gbl.h  |  2 ++
 drivers/scsi/qla2xxx/qla_gs.c   | 12 +---------
 drivers/scsi/qla2xxx/qla_iocb.c | 40 ++++++++++++++-------------------
 4 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index a971d4245d89..873a6aef1c5c 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -455,7 +455,7 @@ struct srb_iocb {
 			struct els_logo_payload *els_logo_pyld;
 			dma_addr_t els_logo_pyld_dma;
 		} els_logo;
-		struct {
+		struct els_plogi {
 #define ELS_DCMD_PLOGI 0x3
 			uint32_t flags;
 			uint32_t els_cmd;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 9fb6f589602b..0dced8eff5f3 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -45,6 +45,8 @@ extern int qla2x00_local_device_login(scsi_qla_host_t *, fc_port_t *);
 
 extern int qla24xx_els_dcmd_iocb(scsi_qla_host_t *, int, port_id_t);
 extern int qla24xx_els_dcmd2_iocb(scsi_qla_host_t *, int, fc_port_t *, bool);
+extern void qla2x00_els_dcmd2_free(scsi_qla_host_t *vha,
+				   struct els_plogi *els_plogi);
 
 extern void qla2x00_update_fcports(scsi_qla_host_t *);
 
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 0e1df8232c75..bf8b30c4827c 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3119,17 +3119,7 @@ void qla24xx_sp_unmap(scsi_qla_host_t *vha, srb_t *sp)
 
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
index 39c7738c0a55..7021fbeb6d23 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2717,6 +2717,21 @@ qla2x00_els_dcmd2_iocb_timeout(void *data)
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
 static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 {
 	fc_port_t *fcport = sp->fcport;
@@ -2748,17 +2763,7 @@ static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
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
@@ -2858,18 +2863,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
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
2.22.0.770.g0f2c4a37fd-goog

