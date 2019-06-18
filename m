Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB649D69
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfFRJdZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:33:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35050 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFRJdY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:33:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so7329558pfd.2
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K1LOMhUpywtS5Uzk5w46aLkAjiUVQZ4DE25kBQbLzcQ=;
        b=GQ9qAlIX/9Y8ONTNPAvLl0WcNn7swioYU/AkSoXXFPOqu0LPEwzmhRqOXMJC9nV5r2
         ASnDDmsnHxsqLzBKVA/+PHRfj12SLCdRqRv47MqzsOPNsri7Nhst1rOBWm/dB1MDxGce
         WZVWmnVpglf9czhP+xrDbN0fIMJOQuAzdeF4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K1LOMhUpywtS5Uzk5w46aLkAjiUVQZ4DE25kBQbLzcQ=;
        b=AAZxThVhyXOMiU48CVxV1TnxE0J3AZtjkRcS7Dh3+WVSZRRp8oOsNTOtdfZMDAnJDK
         0Egl3mKH5mTKe8MPUiogg+v8IZLvlwDjvuiytIlnbexzalDDQ0bOMMe4p3po6dfItDjP
         itpwXhK3K0lHSB8qcbMqwYV5CjGyLdWO6Qu1N4ov/kF0H67L7TnfadUnUrzeNh6D/rk1
         EYUdh0JscOGREvU68523TuNliyRidSyf4IXPkBL9rZJTT5/Qh9P7pn7nbtOZzVPyFDi1
         DYsDISCiRbcLgMuc4OCwe+p1r6olKGV+WhcamYr1DLHCdZNnIYlikAp8TsMRHUBmohaS
         VgsA==
X-Gm-Message-State: APjAAAWYeK7wKyrGvhA7T9EM6F0OKD1bXLpr3xB/amiAnz9XYuHH7QmB
        zWt7OBetc3ssxDiUgSahes957vKX9H6bhr6h59XdS5XwqYnrYsxpqr2tkZj8lF+pk4/5TuXkyoY
        iybJKEQfWkEQAxT7T7iN6uar8sJ+kcECALMBZgjqR8XmaSKG+1saF0mO1XgfLEuwnPZshlrWQoc
        GkS6KGML+ShA==
X-Google-Smtp-Source: APXvYqzxXmKnAH7gK98URoSrh2C51yZyDwSXKDaD9GF9wESw9EvLFJewSEZ/s7zh7ydWbJuUChOndQ==
X-Received: by 2002:a17:90a:77c4:: with SMTP id e4mr4167757pjs.86.1560850403948;
        Tue, 18 Jun 2019 02:33:23 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.33.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:33:23 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 18/18] megaraid_sas: Update driver version to 07.710.06.00-rc1
Date:   Tue, 18 Jun 2019 15:02:07 +0530
Message-Id: <20190618093207.9939-19-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
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

