Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37B530DF6
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEaMPp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:45 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45945 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMPp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:45 -0400
Received: by mail-ed1-f43.google.com with SMTP id f20so14200382edt.12
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WfMEUYWDc3BRyvvJr02uKpraITP8Ff//noXZ1Hhjl3M=;
        b=CQUyTFC/vN8B1QBW6dRoVJZo5tozk6D5kCjzgrk6wIWWzBe3TF4I2wEpBzpIHo/jhr
         vcZa7M4LeQGkK4kaH6aIGsnUMralTwlKEKmsddj2VGmWsHa6r0oynom/sdGVagwryUC0
         F9Q854op1rBqIQ5G/Eq/7MLKfCqUdCf714Td8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WfMEUYWDc3BRyvvJr02uKpraITP8Ff//noXZ1Hhjl3M=;
        b=pQ0GHhMCveb21Jsc8I9HFEHKGOm8EZ/yLWx26Jl+wIUxxC80V7BwmdycNQs3x04Uci
         Q7Fx2TWiMj4m9j/nnptbVFMVZM4U3pNsIwfYQ8H1j8dH7aFP2OTIwAuLyA2x8sBZtiGW
         jphys2nb9nHPqi+mNg+S/xVzDT6QVZfzYktC+qpDFfe/HIGNICWREJxvPh76vWadH5oO
         vN9qNYtpAbufLfNCmXgrmiafY2f7VTVI7GH4jfAMW4kNi3BdthBN1CZ+4mggqLnAIrk1
         F3+YVxrwVkNfzZ7p/NqdRsZe/Krxf+XPH+dTHnJUO2Bdf1sfEsQZ/R7rBezECrdy8dkt
         Z7tg==
X-Gm-Message-State: APjAAAWDc36GOz8OZXapVBmdofUKmtccoobwPAaoj9Ytvnp1SCLS78Dy
        /xu5XI8CnQEfD4Ra0waonAZP5dLAc0wftCk+JqzoMe0D1QFUEbjM4NRJ17z+7+CT6G5EAy6ehNg
        w65FQDW1f29lzOaBkWKBjplPl4VH2fivDtXBd0MJgkYADyYEGwfugUQ0igoQi2IgFfZlgicV4Cf
        DiiHHLyGopRWiQzJX9Tw==
X-Google-Smtp-Source: APXvYqxkXoaQnkY92P6MjOCAYiC5zLJ6NRTDjOy6vg6be1lwD+bcqZU8bNYnU3C9t0Acq2obtsGx+g==
X-Received: by 2002:a17:906:e9c7:: with SMTP id kb7mr8664067ejb.259.1559304943324;
        Fri, 31 May 2019 05:15:43 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:42 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 10/10] mpt3sas: Update driver version to 29.100.00.00
Date:   Fri, 31 May 2019 08:14:43 -0400
Message-Id: <20190531121443.30694-11-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update driver version from 28.100.00.00 to 29.100.00.00
This is equivalent to Phase 10 OOB driver.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index b5a2071..44b8a23 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -76,8 +76,8 @@
 #define MPT3SAS_DRIVER_NAME		"mpt3sas"
 #define MPT3SAS_AUTHOR "Avago Technologies <MPT-FusionLinux.pdl@avagotech.com>"
 #define MPT3SAS_DESCRIPTION	"LSI MPT Fusion SAS 3.0 Device Driver"
-#define MPT3SAS_DRIVER_VERSION		"28.100.00.00"
-#define MPT3SAS_MAJOR_VERSION		28
+#define MPT3SAS_DRIVER_VERSION		"29.100.00.00"
+#define MPT3SAS_MAJOR_VERSION		29
 #define MPT3SAS_MINOR_VERSION		100
 #define MPT3SAS_BUILD_VERSION		0
 #define MPT3SAS_RELEASE_VERSION	00
-- 
2.18.1

