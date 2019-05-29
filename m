Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD642E625
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfE2U27 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32915 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U27 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so1551376plq.0
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TC8xKpLxyeRlD1dY6Wv+Dzk3usCyvqohrBveSK96JSU=;
        b=e+qmm2SDas2ShzYvd3MJ+YyuI3DgqioKOeNOdz/bY5eE1VZ82mdo0ky18SGSSMsfU9
         fo7YJbauCG+Nq8majgaEa+rS5X+umTpG5LBxI+nP+vUPm7EXPb8wrrwchdWALMz2XCPs
         tjtsHKA+BYvep4seqHVU0jdGrEUzZKij5xy9/OBz1uFxyQkyMaSRVLQdOQh774iZKCNo
         5iJEDrJFIT8p0X/HnC/+poCjvFjeNTGd781FjJSIZsFdzyxGu0Klx2sroJ9B+hKJBbJh
         Th/3ZjO4c8OaIKdwZ5/kFNa7P3iqvYL+6ka8FDRT8PULSGIFwJK3vMTGo41z04MlSUB2
         ZHUQ==
X-Gm-Message-State: APjAAAWxx4CeltV5fBYf+UZcrUXpUDSJUQhUHHToiBce07h5k9Q/cCbT
        20x3ZtBULgzxC7ujSyzabDI=
X-Google-Smtp-Source: APXvYqzGaKnERCyhuMaSyHxKsypOjeAAaU14B+ceSQn9aVM256S1EfVvctc85f1cKX+NpFI37FLaIQ==
X-Received: by 2002:a17:902:9b96:: with SMTP id y22mr102049328plp.124.1559161738446;
        Wed, 29 May 2019 13:28:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 17/20] qla2xxx: Remove two superfluous tests
Date:   Wed, 29 May 2019 13:28:23 -0700
Message-Id: <20190529202826.204499-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since qlt_remove_target() only calls qlt_release() if
vha->vha_tgt.qla_tgt != NULL, checking that pointer inside qlt_release()
is not necessary. This patch avoids that Coverity reports the following:

CID 188348 (#1 of 1): Dereference after null check (FORWARD_NULL)
var_deref_model: Passing null pointer &vha->vha_tgt.qla_tgt->tgt_list_entry
to list_del, which dereferences it.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 153f78aeb4b0..906e1a14b775 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1590,11 +1590,10 @@ static void qlt_release(struct qla_tgt *tgt)
 	struct qla_qpair_hint *h;
 	struct qla_hw_data *ha = vha->hw;
 
-	if ((vha->vha_tgt.qla_tgt != NULL) && !tgt->tgt_stop &&
-	    !tgt->tgt_stopped)
+	if (!tgt->tgt_stop && !tgt->tgt_stopped)
 		qlt_stop_phase1(tgt);
 
-	if ((vha->vha_tgt.qla_tgt != NULL) && !tgt->tgt_stopped)
+	if (!tgt->tgt_stopped)
 		qlt_stop_phase2(tgt);
 
 	for (i = 0; i < vha->hw->max_qpairs + 1; i++) {
-- 
2.22.0.rc1

