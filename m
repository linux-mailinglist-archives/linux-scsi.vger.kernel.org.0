Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7D7E19D
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfHAR5A (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45497 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so34604221pgp.12
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vklE4xyDAUQeFl91CQRv+30MXvkPxHBCMG164khJbi0=;
        b=bHSt8m/51/+6kTs4vPox9KA85ZntfJmJlQtx4mb4GIzTqtytSoNgfaAFMAGp2qcVZJ
         CkmIMerVuq7iWVzSqTgd8QrV0u7W9O5fbA95pXnmcGits2kOD9dA+XgRTyJzDGsjACgw
         rZK2+pnwFr+okp3fy5vin5dxIV4yZV4gt5t6gjltOECYpxDmi8WnJFoYJlzOs7eQywGy
         h0QcWHvLn4X8a1/x3fwCARr/4xoXJxgeMs40QVr43zaPiUhxUY3KEwHYBvTezavbI3/O
         XSLnhD+9a+pQE2WgX1ajjymtBapbl7pG6j9xwtTsJLj+bPsss8ASqltkp5aV7ISk/JcN
         1rpQ==
X-Gm-Message-State: APjAAAWYOSt6YktD3FjP2TXyI2v4aB2Pql9Mj9HkFz6LnbgifUrw8IIc
        wcMmmTFGH5qMlQGmmjOJ5xc=
X-Google-Smtp-Source: APXvYqxMs4ekF/oEP6i6qjFjCQl4wjqc2mpP+iLMz1Fe5/w6omt94tWGLaFG232KPTaQfXBLAd/osA==
X-Received: by 2002:a63:7d05:: with SMTP id y5mr121821141pgc.425.1564682219357;
        Thu, 01 Aug 2019 10:56:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 28/59] qla2xxx: Remove unreachable code from qla83xx_idc_lock()
Date:   Thu,  1 Aug 2019 10:55:43 -0700
Message-Id: <20190801175614.73655-29-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This was detected by Coverity.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 13ff52339df8..5faf2d5d5060 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5712,7 +5712,6 @@ qla83xx_idc_lock_recovery(scsi_qla_host_t *base_vha)
 void
 qla83xx_idc_lock(scsi_qla_host_t *base_vha, uint16_t requester_id)
 {
-	uint16_t options = (requester_id << 15) | BIT_6;
 	uint32_t data;
 	uint32_t lock_owner;
 	struct qla_hw_data *ha = base_vha->hw;
@@ -5745,22 +5744,6 @@ qla83xx_idc_lock(scsi_qla_host_t *base_vha, uint16_t requester_id)
 	}
 
 	return;
-
-	/* XXX: IDC-lock implementation using access-control mbx */
-retry_lock2:
-	if (qla83xx_access_control(base_vha, options, 0, 0, NULL)) {
-		ql_dbg(ql_dbg_p3p, base_vha, 0xb072,
-		    "Failed to acquire IDC lock. retrying...\n");
-		/* Retry/Perform IDC-Lock recovery */
-		if (qla83xx_idc_lock_recovery(base_vha) == QLA_SUCCESS) {
-			qla83xx_wait_logic();
-			goto retry_lock2;
-		} else
-			ql_log(ql_log_warn, base_vha, 0xb076,
-			    "IDC Lock recovery FAILED.\n");
-	}
-
-	return;
 }
 
 void
-- 
2.22.0.770.g0f2c4a37fd-goog

