Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517FD6B08F
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfGPUkv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 16:40:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45985 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGPUkv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jul 2019 16:40:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so21277317lje.12
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jul 2019 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OxpPquHr4zZ44hJo3tsqte//uLORrZw/8MCDX1QIshk=;
        b=12IiRro//mqtEOeNWSz5X++T0KfW0DhDW/VR+cr0c+1guGTs0eToZ7ea/nrPk/qsmB
         H5tzkolQlNEDSl9mHqc2KW/6Gi8VFy4tZyc/rJtXqBuCdaFv+IBxnglMvowCdmJKMMiz
         g2WbqJoIyocjTiLFKSSYEdjBMcUKf2cgT34sBbelzW2RiepsaQVxAIicQPCjKS2wXYFt
         emTeOnzjzFGoWzkqAVwq7TQudTUb+5SoVdvSOUqV6a402RD3+Uf3nhAutoh2Oy9+qOSW
         gbbaVeVJ6XxL+q1m7gwu7t/kqXV2cDkK7Wx25davsbisaPbPnLFsdYJvEtzF3khSbx7X
         f5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OxpPquHr4zZ44hJo3tsqte//uLORrZw/8MCDX1QIshk=;
        b=cMyTcvhlN7/29rz/hWJCL68mTR0N2e0rBrD9hMS5BQtUMsFcKNaCQoz4AldGESftwc
         gKqvv77uQ0Bn8jFYCGwB2EawS/PEfEvu1/7O8SPinYcodjj+TKstC+8+8q1D/d3d21vy
         RBDtLXXR0gw8D3PGK7vbxPzCaWWdyHFbduCXlMlvGbc+7M29gycvUOHEeJZKSkuOmRgn
         kmMyhoMo5YHR8Wf/5hSB5j7FI1QDOixC2k/CRMO9NMfuK7CfHH621t5gKGjsD6CEEb32
         n73ukjogqRp6qKpo7HLypV+0C3FCx//YaNrY5JGQ+YTV17yGlfr5WzBlBT7SOGRNTwsS
         ipDg==
X-Gm-Message-State: APjAAAVPM07+ljqMPfpwKZ4kLSNEZjYS84qN5otutPY39uLelZMGQbAO
        rIoqY6CbGzs/PbTlSinxFy/fCaCX7kA=
X-Google-Smtp-Source: APXvYqxuJPJzG62h1yJXet9f6Xic1a/uFElFjOXfFx7//+9pVZX72dR9EZ2mHaCeuEuuUI/1zso/dA==
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr1437260ljt.175.1563309649301;
        Tue, 16 Jul 2019 13:40:49 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48ac:efbd:ce47:8248:9f54:efe4])
        by smtp.gmail.com with ESMTPSA id b17sm3975248ljf.34.2019.07.16.13.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:40:48 -0700 (PDT)
Subject: [PATCH 2/3] scsi: fdomain: use BSTAT_{MSG|CMD|IO} in fdomain_work()
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ondrej Zary <linux@zary.sk>
References: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <984c196d-c10d-c855-51a2-feaf65f81ef5@cogentembedded.com>
Date:   Tue, 16 Jul 2019 23:40:47 +0300
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
missed the masking of the 'status' variable with the SCSI phase mask in
fdomain_work(), leaving the magic number intact. Fix this issue; while
at it, change the order of BSTAT_{MSG|CMD|IO} bits in the MESSAGE IN
phase *case* (with no change in the generated object file).

Fixes: 1697c6a64c49 ("scsi: fdomain: Add register definitions")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/scsi/fdomain.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/scsi/fdomain.c
===================================================================
--- linux.orig/drivers/scsi/fdomain.c
+++ linux/drivers/scsi/fdomain.c
@@ -306,7 +306,7 @@ static void fdomain_work(struct work_str
 	status = inb(fd->base + REG_BSTAT);
 
 	if (status & BSTAT_REQ) {
-		switch (status & 0x0e) {
+		switch (status & (BSTAT_MSG | BSTAT_CMD | BSTAT_IO)) {
 		case BSTAT_CMD:	/* COMMAND OUT */
 			outb(cmd->cmnd[cmd->SCp.sent_command++],
 			     fd->base + REG_SCSI_DATA);
@@ -331,7 +331,7 @@ static void fdomain_work(struct work_str
 		case BSTAT_MSG | BSTAT_CMD:	/* MESSAGE OUT */
 			outb(MESSAGE_REJECT, fd->base + REG_SCSI_DATA);
 			break;
-		case BSTAT_MSG | BSTAT_IO | BSTAT_CMD:	/* MESSAGE IN */
+		case BSTAT_MSG | BSTAT_CMD | BSTAT_IO:	/* MESSAGE IN */
 			cmd->SCp.Message = inb(fd->base + REG_SCSI_DATA);
 			if (!cmd->SCp.Message)
 				++done;
