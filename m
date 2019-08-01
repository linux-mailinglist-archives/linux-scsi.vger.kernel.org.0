Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3537E190
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbfHAR4n (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34768 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbfHAR4n (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so28397065pgc.1
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoFd7uZq2LhRDirDWseLc+inBYq+W3H9z5K7hbJBwnY=;
        b=mByTRbzzbLVBLnJwMq9FJ4ZwlvW2XC72JL3O+3c/vcpXgbPpVyrHK5SuRWyXuJmj8T
         GEvsDbBEntQvENoPFecjDTo2pl9Lct4qkterpRIX/PQ88Ul2IGN6Jugsyf47cqBicExF
         YJhnzP/J+VNEL5zQVNdz1nlxh+LajYjI1ZREHGHSbjg5qsgxiz9uS6cZbJ7kHLBCMwFL
         IA1ldUPFsZUBqBQeAGprc2wx+Ok2WE8apNEgfk6+/mLc683Y1oL7vJrsrb+xYrWe63fa
         noa0bkiLmmXid+3JkLnRJPl63Qvfy5Xty7o5uMK8HbNVIUaugzIh2oum/plk8wMMvNhK
         NFBw==
X-Gm-Message-State: APjAAAUPIZcBiM7QO7OIdVgm6zlnwWC6FivNZC0UytzfqL4h0nfWwaTE
        WPdnefr5q9gM+OkTlSdGboo=
X-Google-Smtp-Source: APXvYqxly5EKkEVJYkAHB6EEkr7TiLnIFVwlf5300nCjHLDP0D70pypw2WJkmWVP729e6Du62z2saw==
X-Received: by 2002:aa7:8b55:: with SMTP id i21mr55100933pfd.155.1564682202371;
        Thu, 01 Aug 2019 10:56:42 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 15/59] qla2xxx: Simplify qlt_lport_dump()
Date:   Thu,  1 Aug 2019 10:55:30 -0700
Message-Id: <20190801175614.73655-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Simplify the implementation of this function by using the %phC format
specifier instead of using explicit for-loops.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 3a25536c2492..221912da67c6 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6497,22 +6497,10 @@ void qlt_remove_target_resources(struct qla_hw_data *ha)
 static void qlt_lport_dump(struct scsi_qla_host *vha, u64 wwpn,
 	unsigned char *b)
 {
-	int i;
-
-	pr_debug("qla2xxx HW vha->node_name: ");
-	for (i = 0; i < WWN_SIZE; i++)
-		pr_debug("%02x ", vha->node_name[i]);
-	pr_debug("\n");
-	pr_debug("qla2xxx HW vha->port_name: ");
-	for (i = 0; i < WWN_SIZE; i++)
-		pr_debug("%02x ", vha->port_name[i]);
-	pr_debug("\n");
-
-	pr_debug("qla2xxx passed configfs WWPN: ");
+	pr_debug("qla2xxx HW vha->node_name: %8phC\n", vha->node_name);
+	pr_debug("qla2xxx HW vha->port_name: %8phC\n", vha->port_name);
 	put_unaligned_be64(wwpn, b);
-	for (i = 0; i < WWN_SIZE; i++)
-		pr_debug("%02x ", b[i]);
-	pr_debug("\n");
+	pr_debug("qla2xxx passed configfs WWPN: %8phC\n", b);
 }
 
 /**
-- 
2.22.0.770.g0f2c4a37fd-goog

