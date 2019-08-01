Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93A7E18B
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbfHAR4g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36873 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so34501024pfa.4
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NStfEBJhrQJFvIR9LzC5vK/8UNKgXuM/4W4l1K4jP+k=;
        b=tSjcfXmC+BVq6lQgXgn1MbDfDLBr1lImMm3wXmV7GUwsE5kIjwx7voBeweOdLmNZN3
         2GM7UStL6Ygs6Pv8vCwR14bbuM59AyZLOGoqxaIgeoQHUDXFPEJU0u3oCxHRlyEA5qiq
         WlFfrmxUh4fcNG12i719E8FaavnZu8J8TYjNEAjdlgjXYpD6XmSbvgPYXijp9hnVBxqa
         EDg0EgiwTvoKh0PWkKtNCoTyvhu1wxIvACbsnqJBmpPGpH5YAF6t+sorHG7m7I0XlGD8
         WX+1qc4OB3R2yRIIcj4eqJU4dyseXD44PnwFg7tbL3idwYpaTG3926amgD+jrxA7KWXJ
         k7lw==
X-Gm-Message-State: APjAAAW/6IXzEZ0VyRO2d5PdXPFjgtEAbm88nOiB7BHR8pT8a754pMz8
        vKjfLMF3QsJQA+ZQpuLAEyQ=
X-Google-Smtp-Source: APXvYqy8oS7Xey2SWY0sk7C3EzVwBT3yCTMQ54vh8Nn9tOlRt43LpzCywMW+9R4UGyuYwpF3zVow7A==
X-Received: by 2002:aa7:8392:: with SMTP id u18mr55231122pfm.72.1564682195805;
        Thu, 01 Aug 2019 10:56:35 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 10/59] qla2xxx: Reduce the scope of three local variables in qla2xxx_queuecommand()
Date:   Thu,  1 Aug 2019 10:55:25 -0700
Message-Id: <20190801175614.73655-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch makes it clear that the tag, hwq and qpair variables are
only used in the mq path.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 23ca3e74770c..e8db90f1b382 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -845,9 +845,6 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	struct scsi_qla_host *base_vha = pci_get_drvdata(ha->pdev);
 	srb_t *sp;
 	int rval;
-	struct qla_qpair *qpair = NULL;
-	uint32_t tag;
-	uint16_t hwq;
 
 	if (unlikely(test_bit(UNLOADING, &base_vha->dpc_flags)) ||
 	    WARN_ON_ONCE(!rport)) {
@@ -856,6 +853,10 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	}
 
 	if (ha->mqenable) {
+		uint32_t tag;
+		uint16_t hwq;
+		struct qla_qpair *qpair = NULL;
+
 		tag = blk_mq_unique_tag(cmd->request);
 		hwq = blk_mq_unique_tag_to_hwq(tag);
 		qpair = ha->queue_pair_map[hwq];
-- 
2.22.0.770.g0f2c4a37fd-goog

