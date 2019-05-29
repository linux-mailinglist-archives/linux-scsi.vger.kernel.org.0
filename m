Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44602E617
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfE2U2o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33748 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2U2o (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so2383309pfk.0
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXqTQ3QTWQR8pjqK36/gUmlkVy3JfdatamcmTzmc6WQ=;
        b=VkpUPT90Q2aYyRMACOOl1+6zWndxx+t5M3s7NvM6USipVa9k7qM78f8+L3hEsFmp67
         r0h6bwCn3Uj8js5N3PDA8bjW2VnhNFDN45fcGZuGjgO9p2MHU4NOo140lpTOmWUM0m7D
         RUduduTVnSR9lAbzMXSpQ8MZJirMbdllE/19IR81YFfh0fW8nzQypeXBnZPpPwwlQSAX
         c+WPYmS7TS4QGMWKmkFqlkTmzHfYexdE99EqrKDn+/0EXVGD62PESkAxFAAvFNjwB1mU
         Mhu7BTQNEKS3OJia9kCtO9R7Oq5uj8hAtn2iI4gyGRoxk9gNgabNPUxjWvMUuNeD5WF/
         RNdw==
X-Gm-Message-State: APjAAAVRqt+0uLMonOcVACueAdRBNa9sa0T/RJ0+O2GmihbkNvt/XyXc
        t8i1s6ZnHFVLuFbeT7hnRLk=
X-Google-Smtp-Source: APXvYqz+k1X2yx8Tutbn60+1wIPP7K+rSOiOi36XPUAMUFuDzZyRW9pJgC5wkrx+pys+xhUiKxu1Zw==
X-Received: by 2002:a63:1854:: with SMTP id 20mr137765496pgy.366.1559161724022;
        Wed, 29 May 2019 13:28:44 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 05/20] qla2xxx: Declare the fourth ql_dump_buffer() argument const
Date:   Wed, 29 May 2019 13:28:11 -0700
Message-Id: <20190529202826.204499-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch makes it clear to humans and also to the compiler that
ql_dump_buffer() does not modify the memory the @buf argument points at.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_dbg.c | 3 ++-
 drivers/scsi/qla2xxx/qla_gbl.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 9e80646722e2..30afc59c1870 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -2743,7 +2743,8 @@ ql_dump_regs(uint level, scsi_qla_host_t *vha, uint id)
 
 
 void
-ql_dump_buffer(uint level, scsi_qla_host_t *vha, uint id, void *buf, uint size)
+ql_dump_buffer(uint level, scsi_qla_host_t *vha, uint id, const void *buf,
+	       uint size)
 {
 	uint cnt;
 
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index bbe69ab5cf3f..a16c00b4773c 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -630,7 +630,7 @@ extern ulong qla27xx_fwdt_template_size(void *);
 
 extern void qla2xxx_dump_post_process(scsi_qla_host_t *, int);
 extern void ql_dump_regs(uint, scsi_qla_host_t *, uint);
-extern void ql_dump_buffer(uint, scsi_qla_host_t *, uint, void *, uint);
+extern void ql_dump_buffer(uint, scsi_qla_host_t *, uint, const void *, uint);
 /*
  * Global Function Prototypes in qla_gs.c source file.
  */
-- 
2.22.0.rc1

