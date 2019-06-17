Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0596349183
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfFQUjD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 16:39:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36409 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUjD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 16:39:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so3652942plt.3
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 13:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfE399HkI7oZVvmloCDG2heCyPnyUIrtCj5SN0j9qQ0=;
        b=V00PyWaTe2hUdOU9z1V3lNVyv41XOC/n8etpX/qf+BhzSxqoVO513w5i7SzN+R+hwM
         Dk4zBFKnxXUH1MYKvYOilPgkA0Mi7mDpnZsrBsoYbFvdcqOdi/Dj+i24J9SRoV06u4NU
         W9SvQzQiWzmpg1sQBA48LkruEmKrQQZ8NKgd4I+ob4eqt3zDiEQOJCIaeiBzOfiaIn4S
         X6yjYm0I7SRKtfhFmKVLD+RV75aRxTISenNMZDkrSGb2KDMs7xnki6Bwzlfd5w8G16GY
         KZhNsdXybg+DddrDcIsjm/LSOOn+O9K0DzNFHzRH95aVr8Qhv5aXnY6szNs7mtyKKeBk
         9YIQ==
X-Gm-Message-State: APjAAAXhcMCs6iUo9AaVaMLDX8p7PqUTFGBfPQoYItCaR6kyd2VXKbXN
        UlQT1U2wdoxx8QJQyau4paE=
X-Google-Smtp-Source: APXvYqw4WdAwpDDdg4LJXg49Bh0tioCQS+ec30aZahoV7nd3BL1vERDgNnYZ2e65Uy7IDj1444s/dw==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr99978907plp.18.1560803942427;
        Mon, 17 Jun 2019 13:39:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z20sm16835620pfk.72.2019.06.17.13.39.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:39:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 4/6] qla2xxx: Move the sp->ref_count initialization into qla2xxx_get_qpair_sp()
Date:   Mon, 17 Jun 2019 13:38:45 -0700
Message-Id: <20190617203847.184407-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190617203847.184407-1-bvanassche@acm.org>
References: <20190617203847.184407-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of making all qla2xxx_get_qpair_sp() callers initialize
sp->ref_count, move the initialization of that variable into
qla2xxx_get_qpair_sp(). This patch does not change any functionality.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_inline.h | 1 +
 drivers/scsi/qla2xxx/qla_nvme.c   | 2 --
 drivers/scsi/qla2xxx/qla_os.c     | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index bf063c664352..2523fbc6c666 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -168,6 +168,7 @@ qla2xxx_get_qpair_sp(scsi_qla_host_t *vha, struct qla_qpair *qpair,
 		goto done;
 
 	memset(sp, 0, sizeof(*sp));
+	atomic_set(&sp->ref_count, 1);
 	sp->fcport = fcport;
 	sp->iocbs = 1;
 	sp->vha = vha;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 01f1c2e6180f..fc0c57ecab25 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -248,7 +248,6 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	sp->type = SRB_NVME_LS;
 	sp->name = "nvme_ls";
 	sp->done = qla_nvme_sp_ls_done;
-	atomic_set(&sp->ref_count, 1);
 	nvme = &sp->u.iocb_cmd;
 	priv->sp = sp;
 	priv->fd = fd;
@@ -505,7 +504,6 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (!sp)
 		return -EBUSY;
 
-	atomic_set(&sp->ref_count, 1);
 	init_waitqueue_head(&sp->nvme_ls_waitq);
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 7768b8462942..7b9f138ad9e4 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -923,7 +923,6 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 	sp->u.scmd.cmd = cmd;
 	sp->type = SRB_SCSI_CMD;
-	atomic_set(&sp->ref_count, 1);
 	CMD_SP(cmd) = (void *)sp;
 	sp->free = qla2x00_sp_free_dma;
 	sp->done = qla2x00_sp_compl;
@@ -1009,7 +1008,6 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 
 	sp->u.scmd.cmd = cmd;
 	sp->type = SRB_SCSI_CMD;
-	atomic_set(&sp->ref_count, 1);
 	CMD_SP(cmd) = (void *)sp;
 	sp->free = qla2xxx_qpair_sp_free_dma;
 	sp->done = qla2xxx_qpair_sp_compl;
-- 
2.22.0.rc3

