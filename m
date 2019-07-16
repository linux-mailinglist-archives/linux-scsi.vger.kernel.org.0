Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB2E6B08A
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfGPUjT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 16:39:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41564 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfGPUjS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jul 2019 16:39:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so9831966lfa.8
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jul 2019 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1I8BBVYP4z5kRtg5ZU3DNAndzPRXZ8ecvy+2YxVMXl0=;
        b=wc1aKrrecdRmamoAaB3F5MGaRRnCa5uK0q63C3rWWKn14N8LRSfBjDuifb8rbd5gAZ
         e6oCgHKooyYoqiqnBq9Q3+rOjGFmwKK7R8ZUwvYYzZDWb/gnYKTlLuawYA/B29iDNfF+
         4ag5+Or5ryApepqqboq0NrCwVbRne6kp3CZjXxtQXA0uvi/M8j4on76dGd4IVAOCso0N
         IVKTIDSuvfFswMTjfKxQPtt4cgWEnqObEZ0fiO9Wv2cU3FNF5S/XlWaAjSh3YJTqJ92s
         lDjXf38Rqfjwa3tNkBBqYZXZ6CAQSaCMNxsEPj9/8t/CL55mM54bFWoiXjr1oPRjn5Sh
         ffZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1I8BBVYP4z5kRtg5ZU3DNAndzPRXZ8ecvy+2YxVMXl0=;
        b=HfhCSV9OX/z2M5rox/3F5JFHt4Ha+AxIRxReTY3rW7fyCE/lwgv7heDInDRVo9k89u
         238y1Y1G8NNmZp0+2nbWuVrJG6SFwGFkzL1EedxLt1yMTa/BwO8xDwOwdQfmp2U+MXYv
         sqSiRCQ3X5DriZHWyEflaibQiBMYqQFWgsEjcw3VoEoi2K3nBNjK+DQDxSQTDOaKge13
         zt2E6+a6jF9WqPhfy6FuIDvnFUWz/PmkuLbPCZKnqJhMaaSyUFcFjpbeA1QLTAtKuOmr
         XeuRbNKPKa1U/YHoQw/7X2G1Dw3H3293qx/z7qdVRMUWMKY0f69jKAMue1WNwUUjsgrD
         WhfQ==
X-Gm-Message-State: APjAAAV3rCYokRlnE/a2KQbKN3JjGR7uUUloF9tGHmwwdEraudP7Y3BK
        Ix4Fch4MIxYYHuvnF9+feU9e1A==
X-Google-Smtp-Source: APXvYqzs18SbEbp+glEPSiSVNJ5IrZ9vZvC1nTacWNWCrfkx8/qA/K1Dn2i5EnS1Z6hZBh7WqPnaLQ==
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr15973287lfm.120.1563309556948;
        Tue, 16 Jul 2019 13:39:16 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48ac:efbd:ce47:8248:9f54:efe4])
        by smtp.gmail.com with ESMTPSA id u15sm3960826lje.89.2019.07.16.13.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:39:16 -0700 (PDT)
Subject: [PATCH 1/3] scsi: fdomain: use BCTL_RST in fdomain_reset()
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ondrej Zary <linux@zary.sk>
References: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <2ca011ad-ece2-6481-c122-9426c4a3aa73@cogentembedded.com>
Date:   Tue, 16 Jul 2019 23:39:15 +0300
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
missed the use of BCTL_RST in fdomain_reset(), leaving the magic number
intact.  Fix this issue (with no change in the generated object file).

Fixes: 1697c6a64c49 ("scsi: fdomain: Add register definitions")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/scsi/fdomain.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/scsi/fdomain.c
===================================================================
--- linux.orig/drivers/scsi/fdomain.c
+++ linux/drivers/scsi/fdomain.c
@@ -166,7 +166,7 @@ static int fdomain_test_loopback(int bas
 
 static void fdomain_reset(int base)
 {
-	outb(1, base + REG_BCTL);
+	outb(BCTL_RST, base + REG_BCTL);
 	mdelay(20);
 	outb(0, base + REG_BCTL);
 	mdelay(1150);
