Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE582E621
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfE2U2y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41411 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U2y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so1405489plr.8
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NH8GiG7/CKVsi2dW8qRHbgw8qsp5OCvlhbCFud2IsuI=;
        b=TJqGru354UtWNuXl93Bq2JgLDv8G2pVQJo4RsCF3LGLe/MxrQe15fEz+Id4TNSiHbB
         +fzPwK3mGKnSQ41r9AjNYM2sn94VR5VzXzE8TGTC02TD8pHshTYFPXoctSAJI7j3ob1d
         k4VjCdiwaBfl7lXVOw/hH86dg+JGBsFBp60JCWCjXn1Nmdo2w9qSz8qLW4VIle3cMYwW
         6WDyhR4mRB2eiev9qV1X4+5Xn2zvEF/660f0qJk69uVvePEyk0MGjI6A63dRIUwWrLXL
         cPj/b/nskf4B0hvZeUGvpNCviLmOpR20/IK5CXOsl34ly+pdGgmP854y1qcGk6sWzqr2
         cicA==
X-Gm-Message-State: APjAAAVO/KACVXHWbwlhoCZojKcB1HBS6S78cVSyiKqzlSRjQGiwLo17
        2Xaq15DpuuiWn1WKp8cRH1I=
X-Google-Smtp-Source: APXvYqz9iyYRWgQ0R07Prl+HCq+ch1/rLLaVHPLVdnQP3fV4jfGvpfLfpW5eeA9MqrAms9iDwl1FUQ==
X-Received: by 2002:a17:902:728a:: with SMTP id d10mr40946474pll.90.1559161733618;
        Wed, 29 May 2019 13:28:53 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 13/20] qla2xxx: Remove two superfluous if-tests
Date:   Wed, 29 May 2019 13:28:19 -0700
Message-Id: <20190529202826.204499-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch avoids that Coverity reports the following:

Null-checking sp->u.iocb_cmd.u.ctarg.rsp suggests that it may be null, but
it has already been dereferenced on all paths leading to the check.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index f0dbd2169a4e..68f445dd0cde 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3332,20 +3332,17 @@ static void qla2x00_async_gpnid_sp_done(void *s, int res)
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
2.22.0.rc1

