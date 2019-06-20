Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368624CC63
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFTKxf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43976 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfFTKxf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so1229360plb.10
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K1LOMhUpywtS5Uzk5w46aLkAjiUVQZ4DE25kBQbLzcQ=;
        b=JIn93A0glRmGHNfGkxllHa5E7NnP4oXYkaAS0troul5D4gGBBwAg2bK8KQCVqdjTFz
         TSQW6VrGCdeiEWO7yhoy37SQyUKsAX7dbLwqbQZgar5IBJLrBXC3DCALYC9rOqRElSuD
         k76ZZGCCcSxCZ0nkL+0x+2hv2RCzHJ2wHQ64M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K1LOMhUpywtS5Uzk5w46aLkAjiUVQZ4DE25kBQbLzcQ=;
        b=Yxek7caDFSvNUhm9L0lag7xnYDwmhljTeCtdN5hkCvzzv6X/0zbqLr+UknrVQJgXYs
         PYjvAcgVTczs/JzX02o8sytHgMbct9bNI77PtfOgJwQmgySzi53pCChoJlu7sNUtoELH
         bsiSkfaIqsZnbjRaArH3Moz8i8QORlVnVN3uJPOtCT108B0D4jdjfITFMifGy/K49Tz5
         d3+c7FXvCkd9WDXfw7sv1dm49EAy/zOWc+QjqlnKI8u6nu92a37esuvHuCkaQx9GY03E
         sJgxJjjh7qcsSdZ+VLUtPwfbGiEuixWp3as0JTbEKFjXBWQ7JQT4KM/y1eO1TcKIn0Al
         DMpg==
X-Gm-Message-State: APjAAAXwZzhtP64r0o/0atglIWoKb1iVLmKbSqOHGZjoEI34KfqzgYq3
        SbHE4vzWP6bCAJadB0EV6j2WEF6hPMyMq0QPKEESJHUR5oWtkQlX/WMbmMyatu1tAD3z9M5ZceB
        CStbtguSJUD3GswGJvilyYVcfAs4+rsiw3e62HIO1/VYf4ZbOEiXdNIpAaHJa2sxwlijxbsmlTc
        3OeBT0uOnmpoeZ
X-Google-Smtp-Source: APXvYqx0QslABCnvRAmATUgJgi7OHaJxYxmr5ftZQzULl0awy0qotE4a9rx3T7+X5paw/yjqRJBvyg==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr25441591plb.164.1561028014811;
        Thu, 20 Jun 2019 03:53:34 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.53.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:34 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 18/18] megaraid_sas: Update driver version to 07.710.06.00-rc1
Date:   Thu, 20 Jun 2019 16:22:08 +0530
Message-Id: <20190620105208.15011-19-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 0b38691..dc0f71f 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -33,8 +33,8 @@
 /*
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"07.708.03.00-rc1"
-#define MEGASAS_RELDATE				"March 14, 2019"
+#define MEGASAS_VERSION				"07.710.06.00-rc1"
+#define MEGASAS_RELDATE				"June 18, 2019"
 
 /*
  * Device IDs
-- 
2.9.5

