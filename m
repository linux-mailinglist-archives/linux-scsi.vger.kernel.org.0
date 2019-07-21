Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70066F316
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jul 2019 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfGULmf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Jul 2019 07:42:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32925 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfGULmf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 21 Jul 2019 07:42:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so7102222pgj.0;
        Sun, 21 Jul 2019 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bFqUxPRe1jTgd1ktoCz7nnsrlt4+oHvvWSeHFaw4pdQ=;
        b=eXMWzT5iUsc6q2RzvrILchkAS5fW7mc2bh7cjR1saDScL2M+DWd3ObHPpQ0PeQEU4u
         XBc7PideiAylo9ccoxubFzV9ObInwRssga7vPTtsA+qPQOq5B0VDihW/+KBXN1KTSu7h
         v9HxgjXt0F7VtdXi9whnoE8o2yQ5PjaCIm8X9klgl1yAnsEbD86/5SKMRkySb8jh74/E
         RkcRCKRlBUF1XkSmkzeKy78VUFzlTG9FWDLabUkRGYCa/hPL/kOMyZMXuTIKguY/0j8M
         dRIp3oXeR63t/AORE+2PTRButskfmGDxChJ8Hd6Tc6/mkSzVkujb/I06CYGtmpDLoP2t
         dOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bFqUxPRe1jTgd1ktoCz7nnsrlt4+oHvvWSeHFaw4pdQ=;
        b=k9ifoDcMNKngGknMHllSaPxuu0/KVtnwp9dxDBu0D++1j6LZ76UbGgAtMM/VVOL38v
         P290Qw1A0lOnkKjr5NPXvpMCjo2Rf0RIdLXAhy2YOnu9JUAWfO6AxCGqhGSOnGl7G6Ez
         0Ut8g7N40eJwkEOrPU9LBEOyQySJZwreW4evKwYc7eyuzFQypAejPf6vz3OUDTripahW
         /8dI9eb0YdEUi5qyT5zckVO4aqBQr72VyOJ6Cdv0nkaSSN9o9109dvg3hdAg8o2D+dtJ
         18DWJyeKfHv/i5BkXP5Qu+gYVZwmIXXGUZPXPZ2qxoSmgcCY6EWtPWMY4V8NF04f9Hwm
         HyUw==
X-Gm-Message-State: APjAAAUXD/jhEoLrQ6/iC9Fw2G8ZnHCVd4UOMjuVnJ04HGtNAO+bG0Bp
        1CNGKGXRjSTpBxDwmCleQ8U=
X-Google-Smtp-Source: APXvYqzwttLT+sGbyYY1ifXZ+8NLE7C6ihdMFdVPGgHTeKapWtvt7kmtDZivRHrcwMePqlxxPXEwdw==
X-Received: by 2002:a17:90a:1b0c:: with SMTP id q12mr71519546pjq.76.1563709354835;
        Sun, 21 Jul 2019 04:42:34 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id 201sm44764371pfz.24.2019.07.21.04.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 04:42:34 -0700 (PDT)
Date:   Sun, 21 Jul 2019 17:12:29 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: fix "NULL check before some freeing functions is
 not needed"
Message-ID: <20190721114229.GA6886@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

As dma_pool_destroy and mempool_destroy functions has NULL check. We may
not need NULL check before calling them.

Fix below warnings reported by coccicheck
./drivers/scsi/lpfc/lpfc_mem.c:252:2-18: WARNING: NULL check before some
freeing functions is not needed.
./drivers/scsi/lpfc/lpfc_mem.c:255:2-18: WARNING: NULL check before some
freeing functions is not needed.
./drivers/scsi/lpfc/lpfc_mem.c:258:2-18: WARNING: NULL check before some
freeing functions is not needed.
./drivers/scsi/lpfc/lpfc_mem.c:261:2-18: WARNING: NULL check before some
freeing functions is not needed.
./drivers/scsi/lpfc/lpfc_mem.c:265:2-18: WARNING: NULL check before some
freeing functions is not needed.
./drivers/scsi/lpfc/lpfc_mem.c:269:2-17: WARNING: NULL check before some
freeing functions is not needed.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/scsi/lpfc/lpfc_mem.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_mem.c b/drivers/scsi/lpfc/lpfc_mem.c
index 66191fa..9bdb4a0 100644
--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -248,25 +248,22 @@ lpfc_mem_free(struct lpfc_hba *phba)
 
 	/* Free HBQ pools */
 	lpfc_sli_hbqbuf_free_all(phba);
-	if (phba->lpfc_nvmet_drb_pool)
-		dma_pool_destroy(phba->lpfc_nvmet_drb_pool);
+	dma_pool_destroy(phba->lpfc_nvmet_drb_pool);
 	phba->lpfc_nvmet_drb_pool = NULL;
-	if (phba->lpfc_drb_pool)
-		dma_pool_destroy(phba->lpfc_drb_pool);
+
+	dma_pool_destroy(phba->lpfc_drb_pool);
 	phba->lpfc_drb_pool = NULL;
-	if (phba->lpfc_hrb_pool)
-		dma_pool_destroy(phba->lpfc_hrb_pool);
+
+	dma_pool_destroy(phba->lpfc_hrb_pool);
 	phba->lpfc_hrb_pool = NULL;
-	if (phba->txrdy_payload_pool)
-		dma_pool_destroy(phba->txrdy_payload_pool);
+
+	dma_pool_destroy(phba->txrdy_payload_pool);
 	phba->txrdy_payload_pool = NULL;
 
-	if (phba->lpfc_hbq_pool)
-		dma_pool_destroy(phba->lpfc_hbq_pool);
+	dma_pool_destroy(phba->lpfc_hbq_pool);
 	phba->lpfc_hbq_pool = NULL;
 
-	if (phba->rrq_pool)
-		mempool_destroy(phba->rrq_pool);
+	mempool_destroy(phba->rrq_pool);
 	phba->rrq_pool = NULL;
 
 	/* Free NLP memory pool */
-- 
2.7.4

