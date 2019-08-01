Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35C57E19A
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfHAR44 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44594 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR44 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so34622193pgl.11
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9jic77sQyhfzE783K8TeZ5pOFLBJEcS9vPuDVPHpQI=;
        b=Qa0T1WB4d8W3QFiJt9xpG7Zuz8t4LgWR2ypEciFOJ+Xs94PfeCyGE0WqZSWLvNOmmt
         IY6r+1bl+owTxLM2BBjqSaIvOtbb1NKB/QpKGxN8DLI/zjm9BTYkgfOaJP7eTLpx/DRq
         pIFpLwISGj+m8OzS7a6wC5qcX6m5w3+MmmXuEScUTwA9Mhb9uSDl07xtXefki+BvCerC
         adabY/qzWySfz5q+u2VRyuJagASrcyfkSHW4SL4zzu6HsC+QCdPXb7LuPZ1Gn+oAeaGR
         0hC0/DTStHmEBglaPJBPuOWo0WQ0H6y7XApjaVjwjEkGK0DdSgrWPWzrIC8CNXSRLj/5
         cXMw==
X-Gm-Message-State: APjAAAX8mlgqHakUWf6w5njfJYt4q6cSfDsmqRGNr8K+PIdmLXNCgRYz
        0sXEHbU2nWZQZDX2Rku18Nb5xRdp
X-Google-Smtp-Source: APXvYqyitjhF/pS0qE7RFDOsHKjZGdGgg37S061CqH8V1eTmAlnW+RHKRlvliPcdMX6cRL53RD98NA==
X-Received: by 2002:aa7:8f24:: with SMTP id y4mr54171932pfr.36.1564682215429;
        Thu, 01 Aug 2019 10:56:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 25/59] qla2xxx: Remove dead code
Date:   Thu,  1 Aug 2019 10:55:40 -0700
Message-Id: <20190801175614.73655-26-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since sess == NULL before 'goto out_term2' is executed, the code under
'if (sess)' cannot be reached. Hence remove that code. This was detected
by Coverity.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 9cd5e2fba8ca..ba53329e8bf9 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6249,9 +6249,6 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 out_term2:
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags2);
 
-	if (sess)
-		ha->tgt.tgt_ops->put_sess(sess);
-
 out_term:
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	qlt_24xx_send_abts_resp(ha->base_qpair, &prm->abts,
-- 
2.22.0.770.g0f2c4a37fd-goog

