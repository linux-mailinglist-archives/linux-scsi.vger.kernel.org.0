Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0E7E182
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfHAR4Y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42039 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so34611497pgb.9
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0gZY+2Ydl3ItKYx53gG3RB7Pc704q7hv1OfzT04KTE=;
        b=JR9bPVNepMLfJw1UOhHTiQ5fGW7fTi7JH5CGqvV/h7t3WDAORnGKX5kYAtS3ocMTbJ
         SdstULQWVfr3BRR7J8RUL/a0Hoon3+ZHyyei6YsTkvoS9lr7yXFMXiJ8Xfw+azp7Au36
         7ISd+Dct89tZ10bJhrnb1wH2ovMY5w0eDyukkyAczNwxaRQ0EHPojnpPz0pW+FaeJJMD
         csFT6pM28wY19vBGhYil/TnPJPLbiQli/HSHJp7AUDT86OmPQiQAaxXmNIF7OnAhSHrH
         Ta556SapuOesFLup3+xTC6ud9XgPciCgoDppEthhcN2UKKMMUO+NkEomoHHlqTVALLO6
         B+kQ==
X-Gm-Message-State: APjAAAWzxZz19/QJtSQUCPGyYCm7fFryDfMGPvFp30pXLMTg4mbrPEpL
        kthoedAvh/+UKvmQ/LzfH4E=
X-Google-Smtp-Source: APXvYqzJq/T7qJ6d1n8A6OJBg3Ox09mqPQmS2dJjPIJOZQkd3pOZmsAIYWyzXsOWnrQFHdRxBlA2xg==
X-Received: by 2002:a65:518a:: with SMTP id h10mr118615364pgq.117.1564682183520;
        Thu, 01 Aug 2019 10:56:23 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 01/59] qla2xxx: Make qla2x00_abort_srb() again decrease the sp reference count
Date:   Thu,  1 Aug 2019 10:55:16 -0700
Message-Id: <20190801175614.73655-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since qla2x00_abort_srb() starts with increasing the reference count of
@sp, decrease that same reference count before returning.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Fixes: 219d27d7147e ("scsi: qla2xxx: Fix race conditions in the code for aborting SCSI commands") # v5.2.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 17a3f91ba5a3..b667f13b62df 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1755,6 +1755,8 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		spin_lock_irqsave(qp->qp_lock_ptr, *flags);
 		sp->comp = NULL;
 	}
+
+	atomic_dec(&sp->ref_count);
 }
 
 static void
-- 
2.22.0.770.g0f2c4a37fd-goog

