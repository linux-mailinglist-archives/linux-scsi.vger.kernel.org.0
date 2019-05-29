Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39D2E626
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE2U3A (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:29:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37852 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U3A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:29:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so2379539pff.4
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfurDbua3Kri3wFQthpYsb9yTBa0raah6UPFijqz1Dg=;
        b=TYWYly+tQPVqezigxOnp3Lvs40igbqo4NOVdHT+f+oOaGKaNk7Dkm9FAAbJue60BzF
         spEsh7CWbT0Ozh/2pVCZiSmYkKCZxPlOUQ5+CMMNpWa1bVR0sw9q9o7/f/RCJd/a8YTN
         y3QZmfRfUe+bwN5XXQtlN3TtAGujJe/EXoCjIwSVl6B69aD5ykhR/1Lgq+wQTLNJqxt/
         vAanfHok5J3ldKoXluPnLEO7zBORqdyf8jRm55kTKoGE/samgTfG3V6E92BfbAhtWKPW
         Ssh05G/eqyiYv2pc2bfWhObGE0klmA4Cig1k9c17xUkghP8EWnOn1JyvlyM1760o87Xc
         D7jg==
X-Gm-Message-State: APjAAAXKTVxAHwPLD3MuN5F8T1VSgu4sDio45Ffi9vIH6TsU5Bs5Ond+
        jRyVTmPUaYolD6bBjUEv+IU9KsVd
X-Google-Smtp-Source: APXvYqzz4ClVciP24dQveV8o0T/PQPLAo+7GLDXOAeXRMWjpnvMqPJW2s5v/PXCJrmlHcCcz0KZavg==
X-Received: by 2002:a17:90a:2e87:: with SMTP id r7mr14627998pjd.121.1559161739495;
        Wed, 29 May 2019 13:28:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 18/20] qla2xxx: Fix session lookup in qlt_abort_work()
Date:   Wed, 29 May 2019 13:28:24 -0700
Message-Id: <20190529202826.204499-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
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
index 906e1a14b775..4c922ca33f60 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6208,7 +6208,6 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess = NULL;
 	unsigned long flags = 0, flags2 = 0;
-	uint32_t be_s_id;
 	uint8_t s_id[3];
 	int rc;
 
@@ -6221,8 +6220,7 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 	s_id[1] = prm->abts.fcp_hdr_le.s_id[1];
 	s_id[2] = prm->abts.fcp_hdr_le.s_id[0];
 
-	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha,
-	    (unsigned char *)&be_s_id);
+	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha, s_id);
 	if (!sess) {
 		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags2);
 
-- 
2.22.0.rc1

