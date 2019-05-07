Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9C168CD
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfEGRH0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:07:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43143 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRH0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:07:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so3769622pfa.10
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4z2u4bzz9iAHqXSwhW/gdsQ9hBMNYvHh74EOpQ3IDEw=;
        b=f/1kVZ38I1V3jEaUJquoMGU+8VWaqHwuHYIvoPvttFGhoB8EJfsRjsalbpAGNFfhPZ
         1+aO/2umqmXWefUiUuOzGQHM029b3fijICa2DwRabRebzr8gBFGCZ9yJGK94Y+D+66Es
         5Cl8WpsszKk3kWa5OXr8aq92PIpOjfHkAkP1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4z2u4bzz9iAHqXSwhW/gdsQ9hBMNYvHh74EOpQ3IDEw=;
        b=m5Mr49Rc4NqeYaq+TIJ/PKKWQkmpKEtMkgQzHrHlnZYzXsVJa4g33SG4WO7gBJ+13q
         ErGy1T5LJe6lfbaAt6NY6SF3uVv7kJZtkcvVdGnzP1R5Ah9gDZQU2CxQeHMWeD/QtLC+
         UoZoGwE3SUNIZ6yl+/7fhyIQuJkMLEity/343tfKVc4+VFQsCgKCqgf90LU/yDbnSIH+
         IkSjC3C4xGLq9nREnURIFfMJlmxyVUug2akkJh1ZXvM70S7lXpcbYG4GDEUMl+KXVGwN
         wUSlP6BeyNOmpSJcHm5J2nFASIX/e5Cb1pooMeMsbHess022lQ4PsrNqJh2Mi+WNUwbT
         D3oQ==
X-Gm-Message-State: APjAAAWa2qnDRvTw3sQRLDrGpATeimXyTWG3Tf4PtGYW2tKKIWTG0kGA
        VcFhaV2tcNRhvAtwY9dx1WEL6XvvOk1YUc/6Kkt8QaY1XB4nBLEQQjrpbpHjJeUo4FFcn/d5OAj
        E4MG6yFha8dQp3eEGAn4wTKJ6qh/+IfaBJJD/iC5+XXN19v77koSNiWHBLzZdSEg/atf4nJDCTp
        qlwSlnFmITHNkDyReAIdjv
X-Google-Smtp-Source: APXvYqwI0pB/QQFDvD8gHjCN81aRF1xZOr/tqyoaLZfF4uGahdDE5gaZ9e+8R8tP9wfbUd8Iqr2sZg==
X-Received: by 2002:a62:f245:: with SMTP id y5mr42333584pfl.12.1557248844651;
        Tue, 07 May 2019 10:07:24 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:07:23 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 21/21] megaraid_sas: Update driver version to 07.708.03.00
Date:   Tue,  7 May 2019 10:05:50 -0700
Message-Id: <1557248750-4099-22-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 56b3204d3fc6..e138d1447e43 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -33,8 +33,8 @@
 /*
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"07.707.51.00-rc1"
-#define MEGASAS_RELDATE				"February 7, 2019"
+#define MEGASAS_VERSION				"07.708.03.00-rc1"
+#define MEGASAS_RELDATE				"March 14, 2019"
 
 /*
  * Device IDs
-- 
2.16.1

