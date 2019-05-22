Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967A025B56
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfEVAtl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36545 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfEVAti (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so180522plr.3
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1gozswPOHnJaHYUH69o0H90nCpLdM+EdT9uH9W6Ys7c=;
        b=VVU8TWSK5AXDLpuJe9JlLMchE1RBfOjCLpdE38e8dUmautVoRKSrWcAnV82DQRGZM5
         5gAA5wTGgN1wmeUlDxgEnqLLaCGTbZXDc2yUV0DgRJu8tkfSqyLY5A0zQa60IYti+A/3
         4SKKdl3ypASqPEpzBFFB4SY1NXE1lR6oBfuoelrIu+oiyRttqeH7ZHd2fLhHJaNrqUat
         r0Eon78VwJRgWS3vQKyIu1zmZiUKvRPdERiItH+WN/RO7ck5y3CNQRSnYKmS7j6AbAhd
         Rz/dE0GDOukHIDQ2Dy2GeGTb4x2ZkSIJl4jaUS+B8sAmK6SREEGpOcC+UPYsHU+rqkZt
         LE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1gozswPOHnJaHYUH69o0H90nCpLdM+EdT9uH9W6Ys7c=;
        b=huhq7NLrpfkVDFgEnByzKE8s0oeVPOA0k/yoomvK3S/gqfq9oC3TpAc58+vuKSQcT7
         uXlzldVUw/hGFUjwGTAH9yTRH0jYShzTqKrEmeNED4Z2qN2W1Vp0WaoSP9vZr4RSTwyp
         NwcR7LGJdQmmRzupbRyZlvxHEFqENCjTYO09l4LIMQ3pX/YmoG6SetAXlM1HrPhkJsc/
         jlif1orSwjRPETbWd1ELm+pEGIMQgixwV29a2V2EWXLbVq6E76T0OXKGiC5fUXoMMf2a
         D5ObtqQPK1d51ZbYsL/le5703LhYnRR0Kho7X9YGvh8uFPA0B14LRMb7gFGyOt5snw+q
         Sl7w==
X-Gm-Message-State: APjAAAUtqFMK/MxyUAhFXVVg3YdhLl3DEdyaQwxJvZke9TJn9xnVhWCQ
        tsnDKkeZjPvb46XAfmnuhUb9ES1M
X-Google-Smtp-Source: APXvYqwRHNJpPmygllDmbKFZDOBtTYGNUy0/9zstLIP8P6MyXHboPtR5OV1dv01TQbJ8wZZahXCH4w==
X-Received: by 2002:a17:902:5983:: with SMTP id p3mr84498929pli.224.1558486177784;
        Tue, 21 May 2019 17:49:37 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:37 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 20/21] lpfc: Fix kernel warnings related to smp_processor_id()
Date:   Tue, 21 May 2019 17:49:10 -0700
Message-Id: <20190522004911.573-21-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Kernel warnings may be seen with preempt debugging enabled.

Replace smp_processor_id calls with raw_smp_processor_id or
cpu information stored in hdwq structures.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 36e8d842d973..eb93189f4544 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1642,7 +1642,7 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 
 		lpfc_nvmeio_data(phba,
 				 "NVMET ABTS RCV: xri x%x CPU %02x rjt %d\n",
-				 xri, smp_processor_id(), 0);
+				 xri, raw_smp_processor_id(), 0);
 
 		req = &ctxp->ctx.fcp_req;
 		if (req)
-- 
2.13.7

