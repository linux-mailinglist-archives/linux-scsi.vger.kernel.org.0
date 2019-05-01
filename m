Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7710C86
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 19:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEAR7p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 13:59:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34309 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAR7n (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 13:59:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck18so4209280plb.1
        for <linux-scsi@vger.kernel.org>; Wed, 01 May 2019 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6QT8G8Zvh34sZtJ9zx6eJf4Ww53EBYqzs/fzj6BGQU=;
        b=gfQg0I2gTO4YE0cPAtdqPgub1ed7fhDUGNsBQRlTWwMzQvYr5aFJsGcdugw/bhKuxY
         aRd6D9WxiA6mmnqwHovfoN/Um83Evr4KogjFRrxT65v1AyrLfd6q1mecN2IW7AyTISwR
         K2idiegYeag34ovsDya94Lo2J3L8VddloRxKi2jBuewn9XEp54TRRydRaRAPmvGlTkkj
         UvT6/F4J74j6GZfP2WsuxnHPei5bckKjI2tF2arKEG5PzvRhOOpKyUraMAyvfv9y4rPy
         vQan3S/iQUBKa3e+RCqLwFjA+/RVY7PAzWydfy1bBp4yuWRNCn5gi9/VkYrPc6rSRm89
         kBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6QT8G8Zvh34sZtJ9zx6eJf4Ww53EBYqzs/fzj6BGQU=;
        b=FwbEMyI26EvDfr11TTMbN2YRZwizLYW62/oUjrhMAcbrwWbH9YUiha3uuImwYbp0k6
         pxMoT1mM5sovtv22rx04R0MPTuhaUYNKEnjufSYtiKrBaM3NfaEUCcZoQJNyLttK+7eM
         xLp7B7ZsB0rCEEcxkdZC4F2nT3wdWJP8Wiyn4uatcxoO2J7a6cPgIW4K8DuFJPRuqDX4
         9r5XlWWR+Eefk4nfntSQnKMVPc5+mp1nQwpmZmwI4bFPlyAp1hN8LvZ09tp7MvBVvM4w
         vUOlW1LpXM2822ni10+L4JfvdOMwcbpFvEAtvm1M5KnO7DOjx7+SIOSGnrNoEikoEUTE
         azvQ==
X-Gm-Message-State: APjAAAXA9TM/xjUaK/mG9Nc4QBjdbnUm71gW24Gotv2BF04nfWY/x2Dv
        r8ZGyPkIInwejnyYelK4Xy4byEMI
X-Google-Smtp-Source: APXvYqyYWgaP4DetX8m+EtpyhyWqb4doveP69qd2aqoFQORyQIj9CFqT5qK/OJxqoAS1uTyCED4tNQ==
X-Received: by 2002:a17:902:294b:: with SMTP id g69mr32396489plb.57.1556733582484;
        Wed, 01 May 2019 10:59:42 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z7sm72906679pgh.81.2019.05.01.10.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 10:59:42 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 4/4] lpfc: Update lpfc version to 12.2.0.2
Date:   Wed,  1 May 2019 10:59:26 -0700
Message-Id: <20190501175926.4551-5-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190501175926.4551-1-jsmart2021@gmail.com>
References: <20190501175926.4551-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Due to the couple of bug fixes, update lpfc version to 12.2.0.2

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index f7d9ef428417..220a932fe943 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "12.2.0.1"
+#define LPFC_DRIVER_VERSION "12.2.0.2"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.13.7

