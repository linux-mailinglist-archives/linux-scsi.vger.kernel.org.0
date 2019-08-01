Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0B7E18A
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbfHAR4f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34415 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4f (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so34505345pfo.1
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tG/4QnRonC0x0+dTWs+jPTTdt3EB2vU77rljMNCZWw0=;
        b=KMe0X6Tigeq73bNt04UrdvmWYavC+weH9FWZKaIo92/AZ1QjIRKq/LVot2mK9L+2E9
         0KXwXnUvkJvbPrsR83J9x3ou9fIXohJwaYk72mBOJ9EOpXY7+pUceJ339OQzFYNvOhqZ
         s53wsl33Fxz6ugh/p+Hbkl8xYDXWRjbvfQZ17uMND4dE5HeGlwBtDgBZhlE2t1QIW5Ou
         pvTlZFQh+siEbOoMbpLim+R1v8eduRUmjha9wF6geofaxnvIKuKmUcXXsB6A+SrkiadV
         Ioq9HbhuhF39YuscyX6SzZ+hFEtnOK2WvmSbtw3QZXv/329raFby1THa1184nSlXbSmp
         ZMSA==
X-Gm-Message-State: APjAAAUlS4H9K3M90W1C4+lgJFB2lPZlNiSHk1GP33VNkGFZ3Keg/OKl
        SsYkMXMw11YweliJ30yoQbQ8aJJI
X-Google-Smtp-Source: APXvYqwPmpBby7BOdWgJj/n/fL/rWldAjm61vzSFll2FWuBrHsMvzaK4KA76dvRHpPuitkbi4kgeqA==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr58354pjc.10.1564682194441;
        Thu, 01 Aug 2019 10:56:34 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 09/59] qla2xxx: Change the return type of qla2x00_update_ms_fdmi_iocb() into void
Date:   Thu,  1 Aug 2019 10:55:24 -0700
Message-Id: <20190801175614.73655-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The value returned by this function is not used. Hence change the
return type of this function into 'void' and remove the return
statement.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 7dc9eeb0c401..5ec3c2b96f3f 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1479,7 +1479,7 @@ qla24xx_prep_ms_fdmi_iocb(scsi_qla_host_t *vha, uint32_t req_size,
 	return ct_pkt;
 }
 
-static inline ms_iocb_entry_t *
+static void
 qla2x00_update_ms_fdmi_iocb(scsi_qla_host_t *vha, uint32_t req_size)
 {
 	struct qla_hw_data *ha = vha->hw;
@@ -1493,8 +1493,6 @@ qla2x00_update_ms_fdmi_iocb(scsi_qla_host_t *vha, uint32_t req_size)
 		ms_pkt->req_bytecount = cpu_to_le32(req_size);
 		ms_pkt->req_dsd.length = ms_pkt->req_bytecount;
 	}
-
-	return ms_pkt;
 }
 
 /**
-- 
2.22.0.770.g0f2c4a37fd-goog

