Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A98A349D5A
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfFRJcu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:50 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:33308 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfFRJcu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:50 -0400
Received: by mail-pg1-f179.google.com with SMTP id k187so7377223pga.0
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qEhDn6rRZThgyxo7YIFd8FLXDZvRzwuIxzQT2hhuIiM=;
        b=A4CJyG1VROxq+zvd3XogD3g2DhD5NePl69D279p0Db6sajRe4jX2XBuE+UUgB5s1/9
         ZR2BO/JJYV1bHW8t0U1BYudL7Ca2jBnn1jfShCAuK24TWlYk7EJ/UioRkGemGmWif8n5
         2xqYufkEhZWX6mmx+kI9nPZzR6+PUWKPyk2Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qEhDn6rRZThgyxo7YIFd8FLXDZvRzwuIxzQT2hhuIiM=;
        b=aM3uVV8rLneQ9kJerQ6Fr6aMcP1fe0lzuh28x3Fa7GzEqSPwl+g7r6SGuTKHONRHVa
         0Bz+vkRGCM/pOfWfCQWPZhggGlf3mHpKCAeH8WF07UiEFy2tD/AWm17aFrwASCigCO1k
         LKCV9rHRpzp6mWrOEmHwK6nGdphiMXt1V4467mxabSOjzPnP/Q3IukJ1j8v8JWp9jeLD
         x16YyI0rhiglBS5cNI82kRsvPfJgRyTHkI+2hjGpEPmQPmOJPVfentL4Tpw6kQXY4bvF
         PSvGrd9XupuAV8ymUSjNyhzJvFHESf3AEaL93SqKfqUoKQTIhjbs0REjXW7dM7w8BvGC
         bLDA==
X-Gm-Message-State: APjAAAWKudgGhPc+aboYAGrU0A/DC1iq7/dRj7CB1cmoPHrA6PqGlr+W
        Q4pK8Eh4giMCdrcIdljnWBUo9gn7uKfKhP55Rea9SgWiCVFHsuCIIoRRYBocFI9R3UI5c5sxYP6
        OhHy8720NBNh8aXNUhxYxQXWiwH9JmW+/PvExuP8TyVOA3gF3zDJjXEJqbTqkfOCWNZTC4tvVCi
        /05ur9xlfXyQ==
X-Google-Smtp-Source: APXvYqyeAdP13hALs7mog+uvO3S3zuoJnT9UxkmRgHEQiTm3/WIeCVv44SnDtEs5hVaKkSFafWOeRg==
X-Received: by 2002:a63:29c2:: with SMTP id p185mr1792257pgp.216.1560850369236;
        Tue, 18 Jun 2019 02:32:49 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:48 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 07/18] megaraid_sas: Don't send FPIO to RL Bypass queue
Date:   Tue, 18 Jun 2019 15:01:56 +0530
Message-Id: <20190618093207.9939-8-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Firmware does not expect FastPath IO sent through Region Lock Bypass queue.
Though firmware never exposes such settings when fastpath IO can be sent
to RL bypass queue but it's safer to remove dead code which directs
fastpath IO to RL Bypass queue.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 1d34609..2d72ad7 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2878,10 +2878,6 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 			(MPI2_REQ_DESCRIPT_FLAGS_FP_IO
 			 << MEGASAS_REQ_DESCRIPT_FLAGS_TYPE_SHIFT);
 		if (instance->adapter_type == INVADER_SERIES) {
-			if (rctx->reg_lock_flags == REGION_TYPE_UNUSED)
-				cmd->request_desc->SCSIIO.RequestFlags =
-					(MEGASAS_REQ_DESCRIPT_FLAGS_NO_LOCK <<
-					MEGASAS_REQ_DESCRIPT_FLAGS_TYPE_SHIFT);
 			rctx->type = MPI2_TYPE_CUDA;
 			rctx->nseg = 0x1;
 			io_request->IoFlags |= cpu_to_le16(MPI25_SAS_DEVICE0_FLAGS_ENABLED_FAST_PATH);
-- 
2.9.5

