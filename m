Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83580677
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391120AbfHCOAl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41133 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391038AbfHCOAl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so27124091pgg.8
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8WNRGffXg/AxN0DaURiktnqcuFFQbQVClioQk+0sbEs=;
        b=Otli1NVaeBoK/+VgX2qk6S7unWMD4gT0aw2aIBXeAu9Sa3dO8jOpOuqE95eLp1Fina
         6j8YzlNlf3rpkr868E3X1EUSDdRljl5F00x5+0O8OZHfHdB6tUAaZVpmsKsafgPBt4b/
         qkQqC9calpxDwpGEdWHT39rhv7UNnz4UGlYT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8WNRGffXg/AxN0DaURiktnqcuFFQbQVClioQk+0sbEs=;
        b=h84TtFF5hars0fR0eKJ/pqDnRDlkDkZw1JnUEesx89ru3DCs1iQQ+fez9l4BJ6/bRw
         7akKB/Ca8BxY+0FL9LaO3zCtscpVmmx1BJog/buyMAq0XiMQqmb/vhRVfjGRC//+3RRF
         vABMU0P2imIvTJkdo0FAIH7R/S25fWyFDJHHYzJdCZnw/CuQitUJeuh8IXbs74j8gRQD
         HzP6bqdCvhyNcrbr2XKXIYOqv6P7T6qXJIqDYkrEJF7TfSNw9DhcxW/LlNjPrFsJHjtf
         9cTBf1izpN5sy4OwKkdqiE0bBWIXejtlWgi5iLztCC2SsyGoH+isREuFo1l/SXKDgdIC
         1LTA==
X-Gm-Message-State: APjAAAVvl9RUA7Br50lpHjNGogAMuk0Bx/3mCm241Kqf2d9cILySf+rj
        bUxNtdCL8CGtRKywU/bcDkdbw/vCtG4UwY2W20HIuCZQq/9bV+NBl+t/IIy3FPoT2/FeHPSVXt5
        2auPCVFPtkYJONKfqgWdR8iXGTTU4QWKWLiidzjlh3BbJq+bnwlBRQR4b9vW5hGegfI/eZ0Mieu
        cMgwomHMNuQVUR3jXQ4A==
X-Google-Smtp-Source: APXvYqy2M/8TP2QsliJiLmvL5XC737gW7PCZOJ+EaS4FrC9dpozSJQbHYrk7eq/R4iL3UfW6eYrA2w==
X-Received: by 2002:a63:2b8e:: with SMTP id r136mr95082977pgr.216.1564840839902;
        Sat, 03 Aug 2019 07:00:39 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:38 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 12/12] mpt3sas: Update driver version to 31.100.00.00
Date:   Sat,  3 Aug 2019 09:59:57 -0400
Message-Id: <1564840797-5876-13-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Updated driver version from 29.100.00.00 to 31.100.00.00
which is equivalent to Phase 12 OOB.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index fa5f1a6..b156d72 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -76,8 +76,8 @@
 #define MPT3SAS_DRIVER_NAME		"mpt3sas"
 #define MPT3SAS_AUTHOR "Avago Technologies <MPT-FusionLinux.pdl@avagotech.com>"
 #define MPT3SAS_DESCRIPTION	"LSI MPT Fusion SAS 3.0 Device Driver"
-#define MPT3SAS_DRIVER_VERSION		"29.100.00.00"
-#define MPT3SAS_MAJOR_VERSION		29
+#define MPT3SAS_DRIVER_VERSION		"31.100.00.00"
+#define MPT3SAS_MAJOR_VERSION		31
 #define MPT3SAS_MINOR_VERSION		100
 #define MPT3SAS_BUILD_VERSION		0
 #define MPT3SAS_RELEASE_VERSION	00
-- 
1.8.3.1

