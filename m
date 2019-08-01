Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330927E1BD
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbfHAR5k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41842 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfHAR5k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so24272943pgg.8
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hc0KHc81mEQYHJMEBfdSPfBGuvvuheIPelj6hWSFKEM=;
        b=Cs8Hn2P+c5M9rU5ZBTQhQzGoHYy9DGfGDmd0IPt4k1U3JeteHfZcNi9e+EFx4ZhEcj
         36SE+htzvkc9shAJJKVrOm6l3d0ykGUgFH6Azjeywvhc3oivmqYedClylQNCisGCzA7U
         TLLqlLYGbHpMZ5z2fPWaA/bNpdin/WeEfpx26h5eCjKqWhwk7lEJYu13A0bzhRe6/Psd
         oA3ctZemdx1YT4/vLPq0YwXhT7KWyq0CtunE4HQ3miDJ6nCh4SudRmbh33pzF3ey6lBs
         ci9xAi77fZL6+xAkziZ1YwPFDtwrkJ0hBr0stLmisAxJ4k6LIOV4q3b2KZD5qK0ZwOZZ
         yliA==
X-Gm-Message-State: APjAAAVZ5oupb2jabV9ceR0unzKtmvttZCsveFWPXg82x8+46JyBuF+R
        5Gk7WtJMuFxCbVguEkHQeV4dv9z/
X-Google-Smtp-Source: APXvYqzJkTrFXiRmpkJW/4u9ukW8TeSfOZ0uFHtjBkjuElpy3y6J66EJZUxV/5SMfWSSRTdwWQNNBw==
X-Received: by 2002:a65:5b8e:: with SMTP id i14mr118926317pgr.188.1564682259930;
        Thu, 01 Aug 2019 10:57:39 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 57/59] qla2xxx: Remove two superfluous if-tests
Date:   Thu,  1 Aug 2019 10:56:12 -0700
Message-Id: <20190801175614.73655-58-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes the following Coverity complaint:

Null-checking sp->u.iocb_cmd.u.ctarg.rsp suggests that it may be null, but
it has already been dereferenced on all paths leading to the check.

See also commit e374f9f59281 ("scsi: qla2xxx: Migrate switch registration commands away from mailbox interface") # v4.16.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index bf8b30c4827c..03f94eb372b6 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3295,20 +3295,17 @@ static void qla2x00_async_gpnid_sp_done(srb_t *sp, int res)
 	e = qla2x00_alloc_work(vha, QLA_EVT_UNMAP);
 	if (!e) {
 		/* please ignore kernel warning. otherwise, we have mem leak. */
-		if (sp->u.iocb_cmd.u.ctarg.req) {
-			dma_free_coherent(&vha->hw->pdev->dev,
-				sp->u.iocb_cmd.u.ctarg.req_allocated_size,
-				sp->u.iocb_cmd.u.ctarg.req,
-				sp->u.iocb_cmd.u.ctarg.req_dma);
-			sp->u.iocb_cmd.u.ctarg.req = NULL;
-		}
-		if (sp->u.iocb_cmd.u.ctarg.rsp) {
-			dma_free_coherent(&vha->hw->pdev->dev,
-				sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
-				sp->u.iocb_cmd.u.ctarg.rsp,
-				sp->u.iocb_cmd.u.ctarg.rsp_dma);
-			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-		}
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  sp->u.iocb_cmd.u.ctarg.req_allocated_size,
+				  sp->u.iocb_cmd.u.ctarg.req,
+				  sp->u.iocb_cmd.u.ctarg.req_dma);
+		sp->u.iocb_cmd.u.ctarg.req = NULL;
+
+		dma_free_coherent(&vha->hw->pdev->dev,
+				  sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
+				  sp->u.iocb_cmd.u.ctarg.rsp,
+				  sp->u.iocb_cmd.u.ctarg.rsp_dma);
+		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
 
 		sp->free(sp);
 		return;
-- 
2.22.0.770.g0f2c4a37fd-goog

