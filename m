Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E97E18F
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfHAR4m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33159 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbfHAR4m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so3181817pgn.0
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zxa0T11drjh+IT3isFUxi4T/9Zx1iU/Xt06l/6t9iX4=;
        b=t2ZjbuQWUPl1hM1kKA+MC4gYnjFOV9kpV4SXUqhA80FLP6wns03ttkq2hsPc4pvLnD
         /J0E3jDC+2QZrhMWw4aqirFvs8nSF+OR92qlnthgYAgA3M5YYhrBWZDVB9Al7Yuc/3RD
         IpDrZ7PdrPVwuhXS4M5MxPJx/SaLbr/qn5wiVCxRONz5KRIF7m/gh7f9Gt42jUkgBLAR
         52ZrijUUwLBYFseEICvbSkra61tggiIVGMioHcJXPbZ65a5m/u/xF+1qbQ23KHLjB/hy
         DHf3yUBb/LritWFt4f0jO5g1364aONN7OCQobJXtbTiQZvncHwYZU3Ya185d+1A6LGKD
         Whpg==
X-Gm-Message-State: APjAAAU/zClOzwg2W6+6EIEb/leD34A5PlC+HTTlPv8RT7PF00M+7Bb7
        +zzeH/iAgY4MZN8YaMHU2os=
X-Google-Smtp-Source: APXvYqyQk4YAun4gkSRn4E/Ek8aqY0wRUgl+pDa7CXUeRnIPc6C0OjSwY8WCJmAiAeYvGNigHcqbYg==
X-Received: by 2002:a62:6d84:: with SMTP id i126mr53709158pfc.129.1564682200948;
        Thu, 01 Aug 2019 10:56:40 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 14/59] qla2xxx: Reduce the number of casts in GID list code
Date:   Thu,  1 Aug 2019 10:55:29 -0700
Message-Id: <20190801175614.73655-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch makes the code that parses the GID list easier to read
without changing the behavior of the code.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_dfs.c    |  9 +++------
 drivers/scsi/qla2xxx/qla_init.c   | 18 ++++++++----------
 drivers/scsi/qla2xxx/qla_target.c |  9 +++------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index a432caebefec..0a6fb359f4d5 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -57,10 +57,9 @@ qla2x00_dfs_tgt_port_database_show(struct seq_file *s, void *unused)
 {
 	scsi_qla_host_t *vha = s->private;
 	struct qla_hw_data *ha = vha->hw;
-	struct gid_list_info *gid_list;
+	struct gid_list_info *gid_list, *gid;
 	dma_addr_t gid_list_dma;
 	fc_port_t fc_port;
-	char *id_iter;
 	int rc, i;
 	uint16_t entries, loop_id;
 	struct qla_tgt *tgt = vha->vha_tgt.qla_tgt;
@@ -82,13 +81,11 @@ qla2x00_dfs_tgt_port_database_show(struct seq_file *s, void *unused)
 		if (rc != QLA_SUCCESS)
 			goto out_free_id_list;
 
-		id_iter = (char *)gid_list;
+		gid = gid_list;
 
 		seq_puts(s, "Port Name	Port ID 	Loop ID\n");
 
 		for (i = 0; i < entries; i++) {
-			struct gid_list_info *gid =
-			    (struct gid_list_info *)id_iter;
 			loop_id = le16_to_cpu(gid->loop_id);
 			memset(&fc_port, 0, sizeof(fc_port_t));
 
@@ -99,7 +96,7 @@ qla2x00_dfs_tgt_port_database_show(struct seq_file *s, void *unused)
 				fc_port.port_name, fc_port.d_id.b.domain,
 				fc_port.d_id.b.area, fc_port.d_id.b.al_pa,
 				fc_port.loop_id);
-			id_iter += ha->gid_list_info_size;
+			gid = (void *)gid + ha->gid_list_info_size;
 		}
 out_free_id_list:
 		dma_free_coherent(&ha->pdev->dev, qla2x00_gid_list_size(ha),
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 3585eb7b87b5..c24d7667d3c9 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5086,7 +5086,7 @@ qla2x00_configure_local_loop(scsi_qla_host_t *vha)
 
 	uint16_t	index;
 	uint16_t	entries;
-	char		*id_iter;
+	struct gid_list_info *gid;
 	uint16_t	loop_id;
 	uint8_t		domain, area, al_pa;
 	struct qla_hw_data *ha = vha->hw;
@@ -5161,18 +5161,16 @@ qla2x00_configure_local_loop(scsi_qla_host_t *vha)
 	new_fcport->flags &= ~FCF_FABRIC_DEVICE;
 
 	/* Add devices to port list. */
-	id_iter = (char *)ha->gid_list;
+	gid = ha->gid_list;
 	for (index = 0; index < entries; index++) {
-		domain = ((struct gid_list_info *)id_iter)->domain;
-		area = ((struct gid_list_info *)id_iter)->area;
-		al_pa = ((struct gid_list_info *)id_iter)->al_pa;
+		domain = gid->domain;
+		area = gid->area;
+		al_pa = gid->al_pa;
 		if (IS_QLA2100(ha) || IS_QLA2200(ha))
-			loop_id = (uint16_t)
-			    ((struct gid_list_info *)id_iter)->loop_id_2100;
+			loop_id = gid->loop_id_2100;
 		else
-			loop_id = le16_to_cpu(
-			    ((struct gid_list_info *)id_iter)->loop_id);
-		id_iter += ha->gid_list_info_size;
+			loop_id = le16_to_cpu(gid->loop_id);
+		gid = (void *)gid + ha->gid_list_info_size;
 
 		/* Bypass reserved domain fields. */
 		if ((domain & 0xf0) == 0xf0)
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index ded5f13372af..3a25536c2492 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1290,8 +1290,7 @@ static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
 {
 	struct qla_hw_data *ha = vha->hw;
 	dma_addr_t gid_list_dma;
-	struct gid_list_info *gid_list;
-	char *id_iter;
+	struct gid_list_info *gid_list, *gid;
 	int res, rc, i;
 	uint16_t entries;
 
@@ -1314,11 +1313,9 @@ static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
 		goto out_free_id_list;
 	}
 
-	id_iter = (char *)gid_list;
+	gid = gid_list;
 	res = -ENOENT;
 	for (i = 0; i < entries; i++) {
-		struct gid_list_info *gid = (struct gid_list_info *)id_iter;
-
 		if ((gid->al_pa == s_id[2]) &&
 		    (gid->area == s_id[1]) &&
 		    (gid->domain == s_id[0])) {
@@ -1326,7 +1323,7 @@ static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
 			res = 0;
 			break;
 		}
-		id_iter += ha->gid_list_info_size;
+		gid = (void *)gid + ha->gid_list_info_size;
 	}
 
 out_free_id_list:
-- 
2.22.0.770.g0f2c4a37fd-goog

