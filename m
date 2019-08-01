Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6297E188
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfHAR4d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42056 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so34611693pgb.9
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REjcNzC0hs4YOAZ6fVLuSwV8KptEfncYABLVTEHl8yM=;
        b=aBWGedgxNMw0AM9SUXgt/b88cH85veN8107txwT3mOng7V35YLBDC1cGRz+bA4CGjU
         GRBmlPppTSSmwz4xNwND84ETJ6n38Y/eEw+DSw7FghhhRUr5YP8kgHZj3fsarCk0xZl+
         lRxgbvME/4KV4WaEEwOtlxZI65zOno8fKSR4aLdFHQ32h0/c3OWDQrXegyvsiBNayyZq
         NzYCD4OT0h/+AigiozwdVclkQy9W4OtbgmCiZg5Cw8kodK5er88ZYGFONSvioUb3HAoy
         iqpmW/A9qB8F0F232vWuTDAIG6J4Ha8eqQle6VloRhtQd/wP7Qg+lrtffh5Z8g5Om4ct
         d8Jg==
X-Gm-Message-State: APjAAAXgKCXLlDH8tTFJ4qZJLlyXKJA/vYDZP/4v1ULbR5XgO6324VFU
        ChrC4m9aVj6qAr4SwzkKx7k=
X-Google-Smtp-Source: APXvYqymZL710bTrj8kBZTaC+XUMcKkFhXjE7Y+Hrjudm5a3STJkQAErzEH0kLXuY7LZ9Ut/1oH9hg==
X-Received: by 2002:a17:90a:d996:: with SMTP id d22mr33088pjv.86.1564682191963;
        Thu, 01 Aug 2019 10:56:31 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 07/59] qla2xxx: Remove a superfluous forward declaration
Date:   Thu,  1 Aug 2019 10:55:22 -0700
Message-Id: <20190801175614.73655-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
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
index d0061ae1488e..4c5f9c02c379 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4106,8 +4106,6 @@ static inline int qlt_get_fcp_task_attr(struct scsi_qla_host *vha,
 	return fcp_task_attr;
 }
 
-static struct fc_port *qlt_make_local_sess(struct scsi_qla_host *,
-					uint8_t *);
 /*
  * Process context for I/O path into tcm_qla2xxx code
  */
-- 
2.22.0.770.g0f2c4a37fd-goog

