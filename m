Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B695A2E61F
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfE2U2w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44303 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE2U2w (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so1527023pll.11
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tklpA7pgwGLsS9uPQvsgy5FJEOvZee0aczM292Y7Yc=;
        b=IiBih97LhngbTbEeQ6vUOzQwD9OQww6jGkjUTY07D0TlOKV22Ol39TOZEF9IGWFj8i
         BSI2yfGho5sEDBVqBmTOH6hMybO/89ieinuY923Pt1DFOI6C3guh6/IfMidBkZ4Udooe
         XFUU5vBGrMPKwo/5uWcRLsFSUyNiXLAvM+4wOgKcNA40FrEZoPcJWUgjQTK5+39VG18q
         +UwNsmL10YWERP8cFVIVks0at9hr3oQJNYpO5oHOuJMlDya6plqE194B3L+e5HWzPPhN
         e8LLov8SvOy24A8eaT9R0Xl7qCq9yoXkV91GfDdw1kWkzDXv2R2rNCGWDi/Fw55HECdG
         aXrA==
X-Gm-Message-State: APjAAAXW6d/eJB8wS++dn27KM2FqiWGRFXCER2JdpH8AmXap6TEcwFJK
        TwvCw9tSr6PR9ZGkLzENssg=
X-Google-Smtp-Source: APXvYqypcS/NqMwgVze/lL5XiLJ4gMARCkHbTiJ0JPaYHd0yfDZfrze9gwZYXVSyD8w9F2SmZltG2Q==
X-Received: by 2002:a17:902:b615:: with SMTP id b21mr80878729pls.12.1559161731123;
        Wed, 29 May 2019 13:28:51 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 11/20] qla2xxx: Reduce the number of casts in GID list code
Date:   Wed, 29 May 2019 13:28:17 -0700
Message-Id: <20190529202826.204499-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
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
index 54772d4c377f..c1a32f4f2234 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5058,7 +5058,7 @@ qla2x00_configure_local_loop(scsi_qla_host_t *vha)
 
 	uint16_t	index;
 	uint16_t	entries;
-	char		*id_iter;
+	struct gid_list_info *gid;
 	uint16_t	loop_id;
 	uint8_t		domain, area, al_pa;
 	struct qla_hw_data *ha = vha->hw;
@@ -5133,18 +5133,16 @@ qla2x00_configure_local_loop(scsi_qla_host_t *vha)
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
index d516337f5979..01c9bbbfa256 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1300,8 +1300,7 @@ static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
 {
 	struct qla_hw_data *ha = vha->hw;
 	dma_addr_t gid_list_dma;
-	struct gid_list_info *gid_list;
-	char *id_iter;
+	struct gid_list_info *gid_list, *gid;
 	int res, rc, i;
 	uint16_t entries;
 
@@ -1324,11 +1323,9 @@ static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
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
@@ -1336,7 +1333,7 @@ static int qla24xx_get_loop_id(struct scsi_qla_host *vha, const uint8_t *s_id,
 			res = 0;
 			break;
 		}
-		id_iter += ha->gid_list_info_size;
+		gid = (void *)gid + ha->gid_list_info_size;
 	}
 
 out_free_id_list:
-- 
2.22.0.rc1

