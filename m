Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918D0597EE
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Jun 2019 11:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF1Jvb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 05:51:31 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44013 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF1Jvb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jun 2019 05:51:31 -0400
Received: by mail-pf1-f175.google.com with SMTP id i189so2698020pfg.10
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jun 2019 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GX5CPy6rqO1lv6QwD/x6+Dzmm0AV8dmr3hh1Og/9uF4=;
        b=ftz5C0HxkkD93oi3LiZOMMWnIVYCb5evcOyptvqG94Uc/BngQof7R25LeAzoIO8EKx
         O05WYgbZunidoq8z2p27moR2OuJEffIwknK/b68XsRee+d7+Z0zyuqX2kkzUxfG1mtzk
         5uzBfSbr3AeheJm5baLdcqm7R7SUOOYh3wz1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GX5CPy6rqO1lv6QwD/x6+Dzmm0AV8dmr3hh1Og/9uF4=;
        b=CIqYTNHE0u195OOiFBVR046N5lNIet3VmqOoSVGIjULnPZmBAPkR360kZPVlJN4iSa
         /gRCL5rFZLEIJt1zZ6cnZ/6QwW4hS3kHLS0Tf8R5vnWTIMBPR/iQEkLFKa2uGAlbptbm
         MCazUnhvKAByjRgHQemhgLpOWhzVCo5aDIV4fBHRcXDTPIufIMzmtRUVKB8KO4bWGnBT
         87FiM1ei/4pl+PwtIoAL236BTLra+pLr7Q6Vyntm8JBuiTmZvKZtFXZJ2quPS+g10IQ1
         eDKbivLoLuXZm9+x364gLl30qRehKQPpHXNdUpzEz7Rjl9tS3T427PBm4frr7AhyZCcp
         Yong==
X-Gm-Message-State: APjAAAWyt2ufGoF7UfooBPqN6X07KR/YHxZ73t6FLy7xZZBzKpGnVlqI
        oZyGOWd2GYFEjRFQp8+mrVRNc+z2fT6jiB6eQSc/QaUPVZjHq7nKVxNbbzPMTfEjKRIUZ6VdA8b
        nBSp7ALm6PZvpJ+HOzACYC6hv2G1gSCfy693+Qf8NJak1Uud+v+Boj5FP4JajcAHf9r5ehRahXE
        2f+sGTnWP/0AW/QcDOJa0hiCg=
X-Google-Smtp-Source: APXvYqxZB25yaEmqUjcIsReJ1buvvIBTKfxNyasc6Ai78llSenfP85wzcUSNDaZIZimEREy8+m8KSg==
X-Received: by 2002:a65:5c88:: with SMTP id a8mr8233232pgt.388.1561715489505;
        Fri, 28 Jun 2019 02:51:29 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q19sm2096975pfc.62.2019.06.28.02.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:51:28 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, chandrakanth.patil@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 4/4] megaraid_sas: Update driver version to 07.710.50.00
Date:   Fri, 28 Jun 2019 02:50:41 -0700
Message-Id: <1561715441-1428-5-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index dc0f71f..a6037db 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -33,8 +33,8 @@
 /*
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION				"07.710.06.00-rc1"
-#define MEGASAS_RELDATE				"June 18, 2019"
+#define MEGASAS_VERSION				"07.710.50.00-rc1"
+#define MEGASAS_RELDATE				"June 28, 2019"
 
 /*
  * Device IDs
-- 
2.9.5

