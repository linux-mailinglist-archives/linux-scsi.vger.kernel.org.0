Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881796B086
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 22:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfGPUhU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 16:37:20 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:35122 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfGPUhU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jul 2019 16:37:20 -0400
Received: by mail-lj1-f181.google.com with SMTP id x25so21334526ljh.2
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jul 2019 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ASMXEatoSJuzNqa54cIPjbYJ8K5vE6EqZUwc2iRkNyw=;
        b=EGSfRyE1XYhdqTtaVVFjDSdSmleZeZID+4TgO8PAEdKc3mLkPZXhrVtWGdgRfBERee
         Zruk4ZFFNV2eaatH5e9Tu1YaSwP/V4JBIJk/25eZzvKRX0jPy1yrlZlBOvmBXtHsnt6P
         gcKSV/DSAm/wILtKrlEKWOQeXAy/PP81wuOyxMFW+V3IdmLLzYhEBoUWWM7nc/WaRaNN
         lqVXz7cVmmAUbvxa6PsE9Mc7KNjQFdoItKDJzxd82blwDHd85gcXc7emCFOFlesqWVCe
         2TK2Lrn+Z77bztPj+UFtYB5nxdgbDHVcg3b4kyVcYyGjnMLH0nksVEN5bK/Gt1b9Bg+i
         tstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=ASMXEatoSJuzNqa54cIPjbYJ8K5vE6EqZUwc2iRkNyw=;
        b=QttIIoy5pwa1wloIPewJ8pXHhQDjPsalsCIaZZlKijFGRQAYVPTL6IoV8FF106mj9m
         JqHV3EKpEPnCU2kg59x0Ii1YTOm78BdMXYygq7GFZ/ApyLLA5ZOLxRQUeHaWDn5lVJPj
         c/hYI8KOyLN+M63gTI+M7ceuLyvfD2cihs5DoW7EYWDY6qV/d2czZrakcSCvfM0YpaVU
         Vk/WrbL911Nhw+z/Ky+JY948enKgfu8jhKtMG8wm1aKEFDxoFfxY8J/80yT35N5wv+Ys
         sZN30vtA3rDS7Pv/3BdmG6mZ54Gcfb8lpdhbSbusOBp1zj11ZxrvN7sN2LIFqme+8H/w
         mVIg==
X-Gm-Message-State: APjAAAVDQ/MsREHUdj4nztPawxH9L2TUDwcogrUmX37nsjF/prdMMAdi
        qeSiCp3256GYE2Fy5RtwdCJ5yA==
X-Google-Smtp-Source: APXvYqxuWfN5SZdlAT8vmwxkgyqf528hDJSk4PLgMZGiZzlLXzc4/yN1Gvr4Mgn2FAyhXnnBAN3iDQ==
X-Received: by 2002:a2e:860d:: with SMTP id a13mr18825976lji.215.1563309438167;
        Tue, 16 Jul 2019 13:37:18 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48ac:efbd:ce47:8248:9f54:efe4])
        by smtp.gmail.com with ESMTPSA id e12sm2982350lfb.66.2019.07.16.13.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:37:17 -0700 (PDT)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ondrej Zary <linux@zary.sk>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 0/3] Fix more magic values in the Future Domain drivers
Organization: Cogent Embedded
Message-ID: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com>
Date:   Tue, 16 Jul 2019 23:37:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello!

Here's a set of 3 patches against the Linus' repo. The recently resurrected Future
Domain SCSI driver got a facelift by Ondrej (thank you!); however, several magic
numbers were overlooked, so I went and fixed these cases.

Future Domain's stuff isn't new to me -- I wrote a FD SCSI driver for another OS
back in '90s... I thought I might still have a real card somewhere in my flat but
none were found... :-(

[1/3] scsi: fdomain: use BCTL_RST in fdomain_reset()
[2/3] scsi: fdomain: use BSTAT_{MSG|CMD|IO} in fdomain_work()
[3/3] scsi: fdomain_isa: use CFG1_IRQ_MASK

MBR, Sergei
