Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8255B21A30
	for <lists+linux-scsi@lfdr.de>; Fri, 17 May 2019 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfEQO7p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 May 2019 10:59:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43947 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfEQO7p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 May 2019 10:59:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so3455397plp.10
        for <linux-scsi@vger.kernel.org>; Fri, 17 May 2019 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q5latLAajZALgA6oo9UvZvxAugfG9ZTrXL4uheL6msU=;
        b=HQwT7Mh9int4cw/RCxiegp5b+Q96vbBK4NSLS+aVMS8t8QIOZFILPkJZSglAUEY1IQ
         1ldB7p/r+4ygnqoymdRH4aZ5b1xWUkdisi3HhhJoA6WMm216IecZtkwaYigRt7uWRYu9
         wS1RAIBoP9f4C/8+FNfJ1KqM+ZYZHyPbOfraI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q5latLAajZALgA6oo9UvZvxAugfG9ZTrXL4uheL6msU=;
        b=rCMberZW156ElWtrJWjlAL3te37nADiyullR/LOBdqTlPaPhRgv+s4sLtddU7jUUOf
         1JDOUMXni2TklgrYCsmQuSR1VsCd54XYizjsMgHDAbENNj4QXn5eYD6r1BqxGrRZh7Az
         ZQCOjjevO/UHszIxDmfPLZhWsRjsroVNMDTjxjRBDvXBTMzrIrY74gHmVY7MoTYOiskt
         AcwXB9gwiX/ugqN3KUeHZGP310yWfQcHowhgx2CQfofY4Gy2xswpBjB8vHA57YT+bffx
         xcOSm35jw0dpOuDJ8tSR9wPWbmY3yVOVQ8oeOhd+jquYwh4g6Vk1SQcaBZM5V88gVBBc
         qlxQ==
X-Gm-Message-State: APjAAAXEkP9KbqWvhlm+9E+/Ldh19EcklOOQAxVjvk25wfyFQ6wFl7Wb
        WfmZfv2uvNI6QTjCB+NEoUxhfgFK3OHICUy2hLHO/B/mvgJcZYPeTssR2w0ncpWsY3RvFqr6VoV
        JIeV94QdclhFhKONwFMRkrrB97Jq3ptq24JHcDTjlH0hT6KKVVIh2UuDr/MO4oUlh2d3ckFEmhC
        8ZxNMp7RHIknkJy4zj+Q==
X-Google-Smtp-Source: APXvYqzAhKJayW1lnZecZnikQ3HXLVuvuJyKmht3d9uyhfNgkLyat1umWzpU9pk1mDyOSb7CDyn6kA==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr13711347pls.201.1558105184099;
        Fri, 17 May 2019 07:59:44 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c189sm20739195pfg.46.2019.05.17.07.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 07:59:43 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 10/10] mpt3sas: Update driver version to 29.100.00.00
Date:   Fri, 17 May 2019 10:59:05 -0400
Message-Id: <20190517145905.4765-11-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190517145905.4765-1-suganath-prabu.subramani@broadcom.com>
References: <20190517145905.4765-1-suganath-prabu.subramani@broadcom.com>
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
1.8.3.1

