Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A052314F
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfETK0o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39214 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfETK0n (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so6515950plm.6
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPSJ7o4EH/iQOdrp308VXvwuA1J61/k03sdR1fSKMSc=;
        b=aNAKU6AUk8HnMnEQlM7VjRqsxs3nYjGkiR1hFrq9fnYx3V/HDquovi36/mXiW1EIMc
         tHr5Q/8D5xjzK66n7lQ+NPk1Fy0d0N2/dm57k0q9rFAUkQliq9SO1w0opK2eULgyawyE
         NPVxsBz3rhW7JKtmds0mkOHym5qUUDySCsxjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPSJ7o4EH/iQOdrp308VXvwuA1J61/k03sdR1fSKMSc=;
        b=lplbSGYWaDA+3eCo3oxjUX2qhOeLm4nk+iwk1giWnS3AjtIrrnIRD5HXXfkFfxvZ5K
         Eozx/2NfIfEVBlxNOGaW48DlXVkZ/9xNwfTJ4cj3yFtnAanrW2H21xJFFx7eT7tHu2NS
         t+ffOTD8sD5ahP5uhr5PPNPeO6lhcfBnN8HYtZfdcE5FgMZoTOHZU+oJecTm2C2upuGK
         o1ja1g2A8tR9C14hveZMj2wz9c8gDLWeJKi9Khr4+5BruKYQQJanhDbZBYtnnDzailz2
         N3He+VY6FbxJNwbEXK498WVtb3AEh/8wrcpp+HLoDd8CgRNWm8bx0g3JBfzpUKWKVP4U
         lh7A==
X-Gm-Message-State: APjAAAWWiB5DlBG7z7drO7XDj7jbXQE0d8jjnjQ5CAL5zpSR9Hmk5Xul
        zQu25V32B7f9sonbwHH2gpNFGggGEnE7O4VXU8c5oXuDFyvgsOoXOQJr57v4AWvDyod5XO4/u0B
        LYySPcmc9FqxIHDAYi1YCUbpewEWPr1y0g134+cwubqFoGUCd+elEBn7nVd7Nyv9OTGUGdzQspu
        M9OAHZIQpTfRJhtSu1nA==
X-Google-Smtp-Source: APXvYqwhn9ZqDwTKoLaZNb9aSftm4KS+33NLxp/wvGg/bEdnNnV6c/kekQiKalemV35LWbv2jIFtyg==
X-Received: by 2002:a17:902:9693:: with SMTP id n19mr74556985plp.92.1558348003123;
        Mon, 20 May 2019 03:26:43 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:42 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 10/10] mpt3sas: Update driver version to 29.100.00.00
Date:   Mon, 20 May 2019 06:26:04 -0400
Message-Id: <20190520102604.3466-11-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

Update driver version from 28.100.00.00 to 29.100.00.00
This is equivalent to Phase 10 OOB driver.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
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

