Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3CE7E192
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbfHAR4p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37973 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR4p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so25801619pgu.5
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeUYd2fmiLGPmTH07cY0JlR5pRizbRYi6TDw03G1UfU=;
        b=sHms2L0VZCrlNr+SCzh0pIYB5ivJrSvrNZ/pWfOmI9gT2p1asyeG96NFK13myt+Qgv
         l69E+JurcrWDu6SDCRlJHqGFX5RLGRqK1/woiSFlwvVwmxgZDUzHwebM2WsYPEc2UB7F
         CJPkloSCuHgVtC71xwkJqRf7fqH5dCMUCAB13k9G3s7Q0pg5bo7ypsjTe/an/Tavr5mG
         9hUD/xjAIf0QGMCWYFdDmGU+ZFkjWnMTnCLD68fBiY3YrhaaWVXnVPVsO2tigfDfTTe1
         lCdbknLCUF/8JklL6L74A8EcMmcFb6HzFwAJ4OOYFvvaGu1lEBvoVarWlOVq1HKZl/v4
         bQWA==
X-Gm-Message-State: APjAAAV5XDdPhd9fY0pyAvb/ENroULNMjDxyL6tqib3h/Mtijj7RX5Ky
        nfOoODU//4VCdTG+1MV8opA=
X-Google-Smtp-Source: APXvYqyI3a3Idetbet2dJXkOx0AzBF8r+RwSAL9/0h8gaDX/EvViASuFZMawaZHnDmnsB9h1ckFR3A==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr119861767pgj.4.1564682204707;
        Thu, 01 Aug 2019 10:56:44 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 17/59] qla2xxx: Remove two superfluous tests
Date:   Thu,  1 Aug 2019 10:55:32 -0700
Message-Id: <20190801175614.73655-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since qlt_remove_target() only calls qlt_release() if
vha->vha_tgt.qla_tgt != NULL, checking that pointer inside qlt_release()
is not necessary. This patch fixes the following Coverity complaint:

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
index 221912da67c6..12a3e77e0d02 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1580,11 +1580,10 @@ static void qlt_release(struct qla_tgt *tgt)
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
2.22.0.770.g0f2c4a37fd-goog

