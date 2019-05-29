Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950412E61C
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfE2U2s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35020 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE2U2s (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so1539109plo.2
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqGJR1lM/7fFMRGux/IJsJn9HnbRzo35ENptHSbQzyc=;
        b=IhUFDT3rkwAXX7nyUFWHz8UpXq/P2i+kuHjU7Kad1pcQql9CbtRb2UXMNHQ3iqOa4E
         6TNq35hqe+tthYeHM28X2ceKyFtjZStkcxiOhxPxWVQEZxnAHGpGcwZ4GRgGJseR3ffr
         wsPKT9DXc5hx0nFKS7q/zLNDI8JVlKCz550rBD6ha7OZ155kTh6tpshTg7XSJUMjcGZK
         b2nmVF+GmNrLKkmtqwKtPRdhhkKSecggEVsHv7AfM2frf5DW0wus0o+qb7FJjbYQmvHb
         dQP464aiDL4CaogPIfg1WANvJiwEbkCCMM4aajv0TpNWtkS1ltXpruHa/5DdSIMx+VLF
         mLzg==
X-Gm-Message-State: APjAAAWcyly29/C8fjkBHtaGP7QosSWSTH3PwUNNV6q/4prOh4k7Gcfo
        rShAxPRInIna8xMX9noOFdM=
X-Google-Smtp-Source: APXvYqxRKmX9w4y+CMdnFHz2UBzh1KwH/T9j1YrRwoOeju0C8ubUEmsm8I4lQOLQO8FTx6H8z2YAaA==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12mr122757226plr.181.1559161722898;
        Wed, 29 May 2019 13:28:42 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 04/20] qla2xxx: Remove a forward declaration
Date:   Wed, 29 May 2019 13:28:10 -0700
Message-Id: <20190529202826.204499-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since qlt_make_local_sess() is defined before it is called, remove the
forward declaration of that function.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 3eeae72793bc..d3457cea61e3 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4116,8 +4116,6 @@ static inline int qlt_get_fcp_task_attr(struct scsi_qla_host *vha,
 	return fcp_task_attr;
 }
 
-static struct fc_port *qlt_make_local_sess(struct scsi_qla_host *,
-					uint8_t *);
 /*
  * Process context for I/O path into tcm_qla2xxx code
  */
-- 
2.22.0.rc1

