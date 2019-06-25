Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2754D32
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfFYLFu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41818 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so9293484pff.8
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K1LOMhUpywtS5Uzk5w46aLkAjiUVQZ4DE25kBQbLzcQ=;
        b=bz/1A3KqupgBmHx3Tt2rIoq9vLuE8zg6QNSkNpU5X0KdWs0vWM3fyv3ImgvF3ySEKu
         XsAx8zM1T3EiSkxl6EdWB7kgu4xQisEPdq76rZ0m+ki4oKmtQ4GMWggp0Hnn/V8tvIm2
         wCH3YZrQCC6o8Oi9Pj7R0YxMVTJhZgRx+5l4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K1LOMhUpywtS5Uzk5w46aLkAjiUVQZ4DE25kBQbLzcQ=;
        b=kH6UTo65o4kX4R5bkFKzvKXHQuzT2vzjFe4g2xjPtc0uRNugJAMNlRP3WjITt05Ynx
         /WZ0Dm0/1d3v5oeol+ocCcRUpvi474SVYDtvQR0tJNp0Jpga8qrRYW6gQpu0RbIwCy+g
         PguYXofV9GY+iC2BdJykecbxzB0ohdbK68UhbtZfKF0Cvp4QMGqcz/dlLdY4lGM9oELq
         sHAFfgrcoSYW3x9ADrmnzosyrdYmDftscrZGuE4mYv+LiBkINmv4ZGc5Y6wWmJRIPkr9
         l2qw3555KvM8irAdoTj6DCCIiLh07OmKC/ZF7v/jYWcZOVNKq5HNi1casdE70UwAJpdV
         2T9A==
X-Gm-Message-State: APjAAAW22HUp3qFsZftqRMYNzsTLAC1EVuvwaWd4Kset7KUZz5HZ9SZt
        fmfUq82l8IRRSImurBxT2eC8FDXF3jYWfRj+ta1fqTdYMamH3R7oQEM/RhvTQ4NLSAFD+eOBS6H
        BhQVUG+C8UIN1NmZulfzBS2srx4D01fYCWjJjsra16pkxDSdHN9XdW26iqXhiHxgDH5E5XCTpKg
        zdmv4HXFRUcQ==
X-Google-Smtp-Source: APXvYqxcuKFvv2AhnakMIxqPH7iA87X4O2xX1LVxRYuO4gmQHiW7+XyK2va0CtRIq0LFbr+zrR9o7Q==
X-Received: by 2002:a63:2326:: with SMTP id j38mr16699886pgj.134.1561460749343;
        Tue, 25 Jun 2019 04:05:49 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:48 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 18/18] megaraid_sas: Update driver version to 07.710.06.00-rc1
Date:   Tue, 25 Jun 2019 16:34:36 +0530
Message-Id: <20190625110436.4703-19-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
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

