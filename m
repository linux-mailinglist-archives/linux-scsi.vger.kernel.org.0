Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3816B6B090
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfGPUl6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 16:41:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42413 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGPUl6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jul 2019 16:41:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so21307699lje.9
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jul 2019 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cYfo51s5ILy5vs6fYRJI+hfI2TvTMcjRWoeuXVKm78k=;
        b=TUb6OY/x4F+xA014A8jGOnmbn1Pe0qzNm5VFXRS1HXf7s1raPHJ5GqcSz6F0dxae7b
         PlWt9qGUz/H9U5xCrF2KdVvxvfHOK/QMLkq2mFNFzIAkj7Y3pjp0Tqfi/HAdKtZpfC2U
         IzAxlmvsFHqJUg8Hpj5OnOS5qQPRMYX18LL2f3Mw737Fmv9xOyLuDxqA1BfSEEgQJfhE
         6mpeAzqGIy9gmOBhj+QQznlzV2mQtL35xDwG35Vk/WDFiayTgRygAN9GcLEBWVt/DVsR
         uBAGqZOJqTzgLCVKLj1tg/mf4ERljUB2YWS8/WTo9kIfj9AyaIZ/Ku/dxRSNrmWM5Ckf
         G9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cYfo51s5ILy5vs6fYRJI+hfI2TvTMcjRWoeuXVKm78k=;
        b=sFpjeYwBJd1bUcDfRgL4BFhDTR1MPrXOZG9mjF+xgFEwzvenQCjv8FnFXL1y6OTkCG
         VmUOy6SAawdMMP+pxwOKKxKv6ZJpqwGUE4nC5mdJDz2Q2GM8SFRjzDprfFKERiSfYk8O
         zew8er/NpDP/vd0J1x8G5eFqU+MxnRFuzhU2lTcj2X6I6sd+LUdkDAPH7nUbGag8gUa6
         q1bngCjZlUmp5ivJCQo6lqZykU2u/hm4QuXKUtmSlB3OMIyMSY8bYT7RH9iu7WkUy+vt
         PWfkjE7x0W7SnVHkgruKH591oAkbUnJSsh8Yyt7rEEYeNKNmVFOAr/GMEqN/npkje7OQ
         eKPQ==
X-Gm-Message-State: APjAAAWemS++T/zz1cb/H9XB+6jp9g4TuV1htyKdz2pzmpYazNqyW4EX
        hYS5pC0kADODRQgXlaXLX/YvgQ==
X-Google-Smtp-Source: APXvYqy88gq0RKPnnDoT4IQvXjvXXFv4M5t+3NcdGlkDa/IRUvKPgXgTaGlFZv4qRP/KrhqYw1rkNA==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr11260472ljq.184.1563309716523;
        Tue, 16 Jul 2019 13:41:56 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48ac:efbd:ce47:8248:9f54:efe4])
        by smtp.gmail.com with ESMTPSA id k8sm3935992lja.24.2019.07.16.13.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:41:56 -0700 (PDT)
Subject: [PATCH 3/3] scsi: fdomain_isa: use CFG1_IRQ_MASK
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ondrej Zary <linux@zary.sk>
References: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b99d3b36-c8ca-3d0e-0a83-d03c61a90234@cogentembedded.com>
Date:   Tue, 16 Jul 2019 23:41:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Commit 1697c6a64c49 ("scsi: fdomain: Add register definitions") somehow
missed the uses of CFG1_IRQ_MASK in the Futire Domain ISA driver, leaving
the magic numbers intact.  Fix this issue (with no change in the generated 
object file), removing an excess empty line, while at it...

Fixes: 1697c6a64c49 ("scsi: fdomain: Add register definitions")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/scsi/fdomain_isa.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux/drivers/scsi/fdomain_isa.c
===================================================================
--- linux.orig/drivers/scsi/fdomain_isa.c
+++ linux/drivers/scsi/fdomain_isa.c
@@ -131,8 +131,7 @@ static int fdomain_isa_match(struct devi
 	if (!request_region(base, FDOMAIN_REGION_SIZE, "fdomain_isa"))
 		return 0;
 
-	irq = irqs[(inb(base + REG_CFG1) & 0x0e) >> 1];
-
+	irq = irqs[(inb(base + REG_CFG1) & CFG1_IRQ_MASK) >> 1];
 
 	if (sig)
 		this_id = sig->this_id;
@@ -164,7 +163,7 @@ static int fdomain_isa_param_match(struc
 	}
 
 	if (irq_ <= 0)
-		irq_ = irqs[(inb(io[ndev] + REG_CFG1) & 0x0e) >> 1];
+		irq_ = irqs[(inb(io[ndev] + REG_CFG1) & CFG1_IRQ_MASK) >> 1];
 
 	sh = fdomain_create(io[ndev], irq_, scsi_id[ndev], dev);
 	if (!sh) {
