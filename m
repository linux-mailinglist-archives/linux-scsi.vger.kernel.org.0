Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652A67E196
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbfHAR4v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40385 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR4u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so34498913pfp.7
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7w0PandZ6WXT5OX55W+cVI42h18p03KROPaZGrq21M=;
        b=jiHR/6e+oJIRy//3c/iEELJzuG41ha0VpZRB/Net7Pc+BG1251aRa4sMyhqIPhMyvj
         VBOo6ur9CCKyPNvnT54ZdPMz65tMjIPl7vIjN5fA5T7dQf6gMgyyvNc9nOIJWOMYUKQZ
         CPQa3il6EImHNDcgI5RqZocfcTKZkwDESkec4xmfrJzc2Ox7tGSsGUiVAdLra5Rgw07i
         gNHS7W4oixHQ6OKxm4ua6Ycu+tKYvXbQN93YeODqIKQZv0hvtco3flXYmeX9T0QlGBCf
         7pJNRWJ/KSbg1FJvNvveKIGhFrsl1+F/3uamzO6zjl0gUWTjL1zbA9YgTYlJgam3OwWv
         HjAw==
X-Gm-Message-State: APjAAAU+l/m+lcVB2KSbfON3xUR9JSu/yeeNI+wwfcdofVfSOLW4HKFS
        wEzZqz/mBVE2+I/wFaAUiXFR0WIQ
X-Google-Smtp-Source: APXvYqwiACouKKnVKmuvzO9SicSuS/+nZEY919EA3CvcZeXPphHbomm+gUKxHI3b6rq2QTGGQ2RrMA==
X-Received: by 2002:a63:3046:: with SMTP id w67mr83534184pgw.37.1564682210037;
        Thu, 01 Aug 2019 10:56:50 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 21/59] qla2xxx: Do not corrupt vha->plogi_ack_list
Date:   Thu,  1 Aug 2019 10:55:36 -0700
Message-Id: <20190801175614.73655-22-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Delete the PLOGIN ACK data structure from the vha->plogi_ack_list before
freeing that data structure to avoid that that list gets corrupted.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c     | 8 ++++++--
 drivers/scsi/qla2xxx/qla_target.c | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index e8db90f1b382..13ff52339df8 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5075,8 +5075,10 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
 				   "%s %8phC mem alloc fail.\n",
 				   __func__, e->u.new_sess.port_name);
 
-			if (pla)
+			if (pla) {
+				list_del(&pla->list);
 				kmem_cache_free(qla_tgt_plogi_cachep, pla);
+			}
 			return;
 		}
 
@@ -5187,8 +5189,10 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
 
 	if (free_fcport) {
 		qla2x00_free_fcport(fcport);
-		if (pla)
+		if (pla) {
+			list_del(&pla->list);
 			kmem_cache_free(qla_tgt_plogi_cachep, pla);
+		}
 	}
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index ea22e62257cb..9cd5e2fba8ca 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4796,8 +4796,10 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 			    __func__, sess->port_name, sec);
 		}
 
-		if (!conflict_sess)
+		if (!conflict_sess) {
+			list_del(&pla->list);
 			kmem_cache_free(qla_tgt_plogi_cachep, pla);
+		}
 
 		qlt_send_term_imm_notif(vha, iocb, 1);
 		goto out;
-- 
2.22.0.770.g0f2c4a37fd-goog

