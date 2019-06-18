Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4702749D5C
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfFRJc4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33976 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbfFRJc4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so7385985pgn.1
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMzim16g0haLFiQPV9XYI5J3leuIdfSlox5jPaNCXRY=;
        b=To3/iu9VrW88r1rTpxBtb6ofG0q+4L/2xsM1Ra3I8WJyYoBNMdQcRGCKlk6hSe3VNH
         HUv4buLKVxmdWjNcmW0+q6pQlBIBkSBbe7mNCuz++rbU5ITBg69yYZqS3L4ZuyaJGSni
         aWg8ZfArZwk36Urm9Vw7TzBW5GFhSsBUqDHPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CMzim16g0haLFiQPV9XYI5J3leuIdfSlox5jPaNCXRY=;
        b=f/5SWmMx5+huHch4F8XxyG6m0VhCj846V7zGvFPgbBFHG5ZUKitnbzIiBBPyiqsDve
         4okYb+toUz1opfOdylMm1PbbCLrUsF6FMoju+UE4cM9/EaAG65x/Ob8BIRg+HeadDnLB
         sBXXkyklhbeoXVEeiQe8CAs1DCNYMFgLEsC35SR2kJGJJCz3aY49rqvFkkDgWtSBIsig
         0rHMsHjx6MGhcJnBh587JAZgh6BRT1d+Qex6NY6DdFNaP8TFmuHKoaaItnnUHUFzAHfj
         aHjRKGI61BPCynL6FJ9JIowQoL20gemOxidnvnYLDtk+tzwEizcHRnDaXzZpDPooTx28
         7eWQ==
X-Gm-Message-State: APjAAAV5GOF1RRtTVGIstjgKDFLoyLKJbE0Wn1FNvRcFcX0hI1FEj05L
        y/tfWdeG331jL7mnoLRbK3MhA4qfI9iUArdqxIf8Bgz5SuVs/l+yC8Xve7Zkl7TLNxnbUDuKdBf
        li0GNxprXxU3MvWPoaLMkHVBJ37YWUZXqD00kTV/gtaI/UzFYsn4HpfR6FhOj6V7vh1iGt63Wdr
        5B09cJ/FIj/g==
X-Google-Smtp-Source: APXvYqwEKbTioog2Mi7jGCx7O0axjIEnTHPy/i4np9f9uswUKTUWk720NG2K81lvLEZD+CB3BSLbKQ==
X-Received: by 2002:a62:187:: with SMTP id 129mr32725097pfb.128.1560850375649;
        Tue, 18 Jun 2019 02:32:55 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:55 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 09/18] megaraid_sas: megaraid_sas: Add check for count returned by HOST_DEVICE_LIST DCMD
Date:   Tue, 18 Jun 2019 15:01:58 +0530
Message-Id: <20190618093207.9939-10-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 554ec72..a886de3e3 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4827,6 +4827,9 @@ megasas_host_device_list_query(struct megasas_instance *instance,
 		 */
 		count = le32_to_cpu(ci->count);
 
+		if (count > (MEGASAS_MAX_PD + MAX_LOGICAL_DRIVES_EXT))
+			break;
+
 		if (megasas_dbg_lvl & LD_PD_DEBUG)
 			dev_info(&instance->pdev->dev, "%s, Device count: 0x%x\n",
 				 __func__, count);
-- 
2.9.5

