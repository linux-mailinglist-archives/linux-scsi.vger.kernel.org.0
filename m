Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE817E1AD
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfHAR5W (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45533 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbfHAR5W (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so34604722pgp.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=muZgJqV2Qd9nn85/gUvtw4XFh2Syuv3PiUjl+lMFl40=;
        b=js4WR2QG4w09S5BVj4hsnognRcCCjdMc7IsBiHtvz0p6RuYauz50+KoX6b2FsP8BWJ
         QfnrQQ+qI8RUJFNs6+8d6oNVNApvMt+xeVapX11CrvGIhhytddCLD7n7/0xaCIhRVm9Q
         kJh8wBlgP9uxBPnFhuG42D1xAaKEK0n3OVhNqtkIzOj2krftMSKpqVy2koY/b4PFlMwY
         3Kg74OgjlNHPBeBLwUNH4Qr/ScDWVIlXHNAYvXuJUTiHBCOu16VpXu0gnA0MVTDwallx
         MV67s6V9eyXBrnWS3vaPJuqn0m9UnNWjaO0tJm/VKxeSzAHVQNpLUWBbjiNgUNki5HAY
         5cLg==
X-Gm-Message-State: APjAAAVKgsUuULXq7aO7Ht+Jxom2kmHcl+C2Ljv4B64dArdJoo91oGJu
        sTv8zV5UapPZGhIyuHDSDss=
X-Google-Smtp-Source: APXvYqwF0rQ0K2RaAHWeSVzvQ8sFc0aehx5+mU5g6B5q65PwRKgvb0cJ81tjNAqV5N3ObhIFlTEJRg==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr15896pjb.51.1564682241466;
        Thu, 01 Aug 2019 10:57:21 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 44/59] qla2xxx: Introduce the function qla2xxx_init_sp()
Date:   Thu,  1 Aug 2019 10:55:59 -0700
Message-Id: <20190801175614.73655-45-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch does not change any functionality but makes the next patch
easier to read.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_inline.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index bf063c664352..0c3d907af769 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -152,6 +152,18 @@ qla2x00_chip_is_down(scsi_qla_host_t *vha)
 	return (qla2x00_reset_active(vha) || !vha->hw->flags.fw_started);
 }
 
+static void qla2xxx_init_sp(srb_t *sp, scsi_qla_host_t *vha,
+			    struct qla_qpair *qpair, fc_port_t *fcport)
+{
+	memset(sp, 0, sizeof(*sp));
+	sp->fcport = fcport;
+	sp->iocbs = 1;
+	sp->vha = vha;
+	sp->qpair = qpair;
+	sp->cmd_type = TYPE_SRB;
+	INIT_LIST_HEAD(&sp->elem);
+}
+
 static inline srb_t *
 qla2xxx_get_qpair_sp(scsi_qla_host_t *vha, struct qla_qpair *qpair,
     fc_port_t *fcport, gfp_t flag)
@@ -164,19 +176,9 @@ qla2xxx_get_qpair_sp(scsi_qla_host_t *vha, struct qla_qpair *qpair,
 		return NULL;
 
 	sp = mempool_alloc(qpair->srb_mempool, flag);
-	if (!sp)
-		goto done;
-
-	memset(sp, 0, sizeof(*sp));
-	sp->fcport = fcport;
-	sp->iocbs = 1;
-	sp->vha = vha;
-	sp->qpair = qpair;
-	sp->cmd_type = TYPE_SRB;
-	INIT_LIST_HEAD(&sp->elem);
-
-done:
-	if (!sp)
+	if (sp)
+		qla2xxx_init_sp(sp, vha, qpair, fcport);
+	else
 		QLA_QPAIR_MARK_NOT_BUSY(qpair);
 	return sp;
 }
-- 
2.22.0.770.g0f2c4a37fd-goog

