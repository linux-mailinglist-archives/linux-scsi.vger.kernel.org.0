Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA750EDC
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfFXOnM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 10:43:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35367 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfFXOnM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 10:43:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so7248544pgl.2
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=urA4pdWuWd6tf9IQ2Z5lWYjHQew0QaOk1+ndmni+EOE=;
        b=HPOC5OVy+mxVENgqavAlzWuiFuwqRRro+l0NjraqjlnwN8Zvb9cNGvw5boW+v+Zpan
         Zto6U1ClJUY3cEwp3lQqXQLw0TWHTLD2GpPy6H0Nicz76s/3tBkFkBujljbSTG/eyJSo
         MAiQZTOSoA57ZTjxLi7fs1isJN8SSltKi+kiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=urA4pdWuWd6tf9IQ2Z5lWYjHQew0QaOk1+ndmni+EOE=;
        b=aNM1qrN471zf0RfUVkJ2CcKf+7b0cwGVpDrGQxfnyvIKMw+aRf6oa0KJjjbkIAEB/g
         jK7AJzJ8/ODU7lVz/M0VQWYZP3CcGyEAQhqL7C+Mbheam5nGJTTxmF+OUpCs4us4k2cm
         zewFC/p3Yt0D6VH4UxWMG+ACxw7IOj0J7+sKffwYUTuiQtRVv+i5RBGBz8bO96ic657T
         a36w4y3Q7SfFClag4xD8W26dpWeMRNahpWvgy8PAxV4sskbO1OkaRmFC3I/KV3ykteJf
         fPYN1WrEj/FLwJUA8dYM8cItYXsBXXdl2pp7Yxzi1r6SiomegX2ktCsD3bPXFtFui75Z
         aFdw==
X-Gm-Message-State: APjAAAU2z1727PIStrdYB1oeSZQVOLRXAe4w5L9wt/TWzoCWWx1l5Td5
        zwinL9G466cScfbpvM1phzDRNg==
X-Google-Smtp-Source: APXvYqyNcNl1HsJQpfGHp6gn51hQmovZnp4CvA0iz3lV5hXVIc97Ee4PhLyBHJ0fs/WKxPI9+y1mXA==
X-Received: by 2002:a17:90a:350c:: with SMTP id q12mr25431859pjb.46.1561387391367;
        Mon, 24 Jun 2019 07:43:11 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k197sm12991799pgc.22.2019.06.24.07.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:43:10 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, suganath-prabu.subramani@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 1/4] mpt3sas: Remove CPU arch check to determine perf_mode
Date:   Mon, 24 Jun 2019 10:42:53 -0400
Message-Id: <1561387376-28323-2-git-send-email-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
References: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently default perf_mode is set to 'balanced' on Intel architecture
machines and on other machines default perf_mode is set to 'latency'
mode.

Now this CPU architecture check is removed while determining the
perf_mode. And default perf_mode mode is set to 'balanced' mode on
all machines.

User can choose the required performance mode using perf_mode
module parameter.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index cae7441..d55f134 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -113,8 +113,7 @@ MODULE_PARM_DESC(perf_mode,
 	"interrupt coalescing is enabled on all queues,\n\t\t"
 	"2 - latency: high iops mode is disabled &\n\t\t"
 	"interrupt coalescing is enabled on all queues with timeout value 0xA,\n"
-	"\t\tdefault - on Intel architecture, default perf_mode is\n\t\t"
-	" 'balanced' and in others architectures the default mode is 'latency'"
+	"\t\tdefault - default perf_mode is 'balanced'"
 	);
 
 enum mpt3sas_perf_mode {
@@ -2990,19 +2989,6 @@ _base_check_and_enable_high_iops_queues(struct MPT3SAS_ADAPTER *ioc,
 
 	if (perf_mode == MPT_PERF_MODE_DEFAULT) {
 
-#if defined(CONFIG_X86)
-		/*
-		 * Use global variable boot_cpu_data.x86_vendor to
-		 * determine whether the architecture is Intel or not.
-		 */
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-			ioc->high_iops_queues = 0;
-			return;
-		}
-#else
-		ioc->high_iops_queues = 0;
-		return;
-#endif
 		speed = pcie_get_speed_cap(ioc->pdev);
 		dev_info(&ioc->pdev->dev, "PCIe device speed is %s\n",
 		     speed == PCIE_SPEED_2_5GT ? "2.5GHz" :
-- 
1.8.3.1

