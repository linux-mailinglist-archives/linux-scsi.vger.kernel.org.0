Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96097E194
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfHAR4s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41751 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR4s (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so24271784pgg.8
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n56A+S0GJfQRXtZQxBXinzxMXs9JIFCI/MzB4azduTs=;
        b=tXwAed2/ozugrM8qzgCjrrNVgBSRwmgF/n/Ay/D+KerhymZwyFuZoRulXFTk2ufV5l
         dzqMLm8DvGi8+mMr0s1q4yquccuoIy2/+TNYsMRI23MD1k0tTgmcJOx33BvC15zjqtQ+
         WNlVvaEaUSk9O9JsN0BqRbcW0aGA5eZMaddqmIY/3ylNAbAaNCgulnkHYk5D5ZSYJS23
         lkE3GUM0vIS438Ked+1gdOIsPNmRzkg3VTPXyvJaKMlJEBGleX2bbLh/mPc9izbsylVB
         /5tvHOA3zbVsKA3oA+/KNFXXG9jZYSbHFrn4/DjpRe1PRsEDq1azQ9mDE+h9OLzTJuj9
         0nBQ==
X-Gm-Message-State: APjAAAWCRr5W8n7Qy8E9/QsFZvwIBR3Cpp/obESAqAdgrt4G6XHNfCqk
        r5bZw4OlLtoFixfse1cUH4c=
X-Google-Smtp-Source: APXvYqzthEuOxM5Xk2cilw65G+TI7HvtAvmM4O4xD96RV8/cX+OzEFiRJzBgXaynejZrFQkrohNzrA==
X-Received: by 2002:a63:1f50:: with SMTP id q16mr9690125pgm.274.1564682207375;
        Thu, 01 Aug 2019 10:56:47 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 19/59] qla2xxx: Fix session lookup in qlt_abort_work()
Date:   Thu,  1 Aug 2019 10:55:34 -0700
Message-Id: <20190801175614.73655-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Pass the correct session ID to find_sess_by_s_id() instead of passing
an uninitialized variable.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Fixes: 2d70c103fd2a ("[SCSI] qla2xxx: Add LLD target-mode infrastructure for >= 24xx series") # v3.5.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 12a3e77e0d02..ea22e62257cb 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6198,7 +6198,6 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess = NULL;
 	unsigned long flags = 0, flags2 = 0;
-	uint32_t be_s_id;
 	uint8_t s_id[3];
 	int rc;
 
@@ -6211,8 +6210,7 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	s_id[1] = prm->abts.fcp_hdr_le.s_id[1];
 	s_id[2] = prm->abts.fcp_hdr_le.s_id[0];
 
-	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha,
-	    (unsigned char *)&be_s_id);
+	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha, s_id);
 	if (!sess) {
 		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags2);
 
-- 
2.22.0.770.g0f2c4a37fd-goog

