Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746602E61A
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfE2U2r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40650 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2U2r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so2365365pfn.7
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUq8gTCtfLT2oHjwyiYmYOiBq7PBKS03hFgmMJwiQ/g=;
        b=a+xt/N437zAjdiPQILJ6rhWXUwmkHhOsHrOWI/HcCn7DoCxagRaYH8mCC9PhvehYpl
         eV7A3pshIQBcLCTolAKyuEfV4kcnmdsWfPSMNDw9EyTYBndGDJLQPkjZXoL86TNXPg5Q
         2QOK0JY75/Ve8+pRIolmi2VHwFkSkKHaNL2xzIrX33Q67cI9nfZcmUwpRBavnXGJ7R0s
         8vXW1TFlJoS+umeQmqby36FSuR10PO9VAkwVYlHRLcmWMvVoniuWtRpafoTQ5w5RTk86
         9EsBah2CX2Pb0QX4qRzdt7ouenslHkdFJero4F2Go3g/Z2+vWjSLmATJQ3c7YNRz2enn
         dlCg==
X-Gm-Message-State: APjAAAU3ysIAV+3b/uyBcUa/ximTcUhARkWGoAYAUJkmCjoG9w5qxNp2
        z6a4Y4Nw+kfVHkVJ8wxo6V4=
X-Google-Smtp-Source: APXvYqxKZqdC/oxLxjsYD7+FxPSF/Pgazwv9RL7NeZRr85SHm/U1+IGkkBZAWMwETbCiyY8Fx5gPkQ==
X-Received: by 2002:a62:2706:: with SMTP id n6mr71762461pfn.150.1559161726331;
        Wed, 29 May 2019 13:28:46 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 07/20] qla2xxx: Reduce the scope of three local variables in qla2xxx_queuecommand()
Date:   Wed, 29 May 2019 13:28:13 -0700
Message-Id: <20190529202826.204499-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch makes it clear that the tag, hwq and qpair variables are
only needed for the mq path.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 415e12f7f9e7..0b4673eb1e43 100644
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
2.22.0.rc1

