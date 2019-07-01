Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D82D362
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 03:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfE2Bfs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 May 2019 21:35:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33583 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2Bfr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 May 2019 21:35:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so323920pgv.0;
        Tue, 28 May 2019 18:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f+EkUBeXFScCCzheqKBe16U/rvHBs3nQTNc8yUaeiYo=;
        b=XJgtbmuk3AHBSVrUw4iIzFk0SaH0ontf6JTdQ7ho6kElQc0w1WH4Im58Lp0MAqik+5
         AlmEXhFpXWBw3i8YGyzu3qOwvv/hWUIVejWeJgIHWYDNI9jC+iTtbCbv2jx+WeWs0Z9k
         vy1NDK6E2jADnVDwZcqqIGz4A+OP33fKqun3FgJ8i6VhT1Dwyho5kb7F6eYvyl3+NAeu
         FrNq2Zx8+os678dRHXIuulalcgJ6tm6r3gr0Sz6W7k9jSq32FhbBctrzK7faocoxrS9U
         nSngKH7U1Q72E5gx+07wmdZD6m5DL1jXGnjttbyLWrY8JOClZDYaNRZYk/wxXM6S+WMh
         QtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f+EkUBeXFScCCzheqKBe16U/rvHBs3nQTNc8yUaeiYo=;
        b=I0hsUKnSNyKIojl/EjztLcN35Frz+3EfcVTibBlU/iFLAfGljMuRJljf5L+dC0PaGA
         ow4DJsIRet8wRmpr1G1AkpEcK6YspRr7gqX9cjLOSa/K9GTg4CwNQI8RGAykEwqzEmTl
         Wt+y2Wy7wAq7i2UQgMPQs6mWhDz0vEkwh8hRFgWN7KcUZ8Rf+ky+V3AxKROy/NABXYtD
         ZyGzh385wftgS7ZHuy2Dxa/rVXkX9AlOxL2OBwvRtE/hopwylakI9QCVym6xXgYwkJpG
         SjlVCK/btWVIpd6auLylWkjtcU2Dxv9VSKBdtTvIy5fMzVYUVoNZgh4hQngnXBoIQMf8
         AT0Q==
X-Gm-Message-State: APjAAAVtF2yLTg9ssdU81BnTwEPfYpgT3F3fvXGfKAjMsbkdi/IM9+ia
        ZrsO83w1ZpJCasxrDUqrptA=
X-Google-Smtp-Source: APXvYqzmh1oRFAdToWQ6eeHDf18fD866btuuSBlG3ktn4tFmKAJyxWUa2m5Vwut0We8lUkfhriMwpA==
X-Received: by 2002:a17:90a:cb8a:: with SMTP id a10mr9280349pju.87.1559093747211;
        Tue, 28 May 2019 18:35:47 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id l12sm4886538pgq.26.2019.05.28.18.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 18:35:46 -0700 (PDT)
Date:   Wed, 29 May 2019 07:05:40 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL
Message-ID: <20190529013540.GA20273@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

wd719x_chip_init is getting called in interrupt disabled
mode(spin_lock_irqsave) , so we need to GFP_ATOMIC instead
of GFP_KERNEL.

Issue identified by coccicheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/scsi/wd719x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index c2f4006..f300fd7 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -319,7 +319,7 @@ static int wd719x_chip_init(struct wd719x *wd)
 
 	if (!wd->fw_virt)
 		wd->fw_virt = dma_alloc_coherent(&wd->pdev->dev, wd->fw_size,
-						 &wd->fw_phys, GFP_KERNEL);
+						 &wd->fw_phys, GFP_ATOMIC);
 	if (!wd->fw_virt) {
 		ret = -ENOMEM;
 		goto wd719x_init_end;
-- 
2.7.4

