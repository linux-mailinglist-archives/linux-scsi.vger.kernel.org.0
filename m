Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C797E187
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfHAR4b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43152 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id r22so7017451pgk.10
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSyrUPCu9oxrgNWWQcEYQeFmNc2QamvroWhcLTeDZ74=;
        b=rL+QVffqSYsMMFRWXLG/iCBioYiMwA5ATMb8f5uYJgY0xXj31hIJIn2rFZ/4MVH4Nr
         ztKNl2iAS+t7wbSQ1F2FabsD45/+h3Aon6yDzHQSi4ok8uOlRMnisFKv7jRpLyEALiqh
         6+L07MKf4EQVZsYGyScbqOD+3iDRP8esxtqbX9bZeJxsAxWt2DZw/tFqVZTFFpAx7aMI
         9lshoCmB1ilFATU4JOgP4yWdyZLpyJBBVAEQnw9x0V0XPOF83wo+pirA4FKpw7OKEluK
         wp6J6WajQdGU8Y/Gvt4NZK3PCOjlQoAAtzI8D/1+w0h8+EqP/odfoXyyfePEEkBiP/sQ
         pLNQ==
X-Gm-Message-State: APjAAAW/VLa/axotuja0zimnRJ7827S+/6nw8YDMcX2Clped6lV+2GlN
        UH8A+xqNIQLWxxuWh3r9uWg=
X-Google-Smtp-Source: APXvYqxHQrM9S6twLR/vwhnb0lJV8oi1/pzX6V+e2YG6IhiguGE+h/Pxw/o8Fuom/ThWORDM/kyu+A==
X-Received: by 2002:aa7:8dd2:: with SMTP id j18mr54159954pfr.88.1564682190625;
        Thu, 01 Aug 2019 10:56:30 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:29 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 06/59] qla2xxx: Remove an include directive from qla_mr.c
Date:   Thu,  1 Aug 2019 10:55:21 -0700
Message-Id: <20190801175614.73655-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is no bsg code in the qla_mr.c source file. Hence do not include
the <linux/bsg-lib.h> header file from qla_mr.c.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 942ee13b96a4..cd892edec4dc 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -10,7 +10,6 @@
 #include <linux/pci.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
-#include <linux/bsg-lib.h>
 #include <scsi/scsi_tcq.h>
 #include <linux/utsname.h>
 
-- 
2.22.0.770.g0f2c4a37fd-goog

