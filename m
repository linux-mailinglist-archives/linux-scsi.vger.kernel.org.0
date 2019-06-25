Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1486154D29
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfFYLFV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36502 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so8806599pgi.3
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMzim16g0haLFiQPV9XYI5J3leuIdfSlox5jPaNCXRY=;
        b=eQ5hKHCr6IxIdRxUK1QQBLuJehW5uCfZ4Ulo3t7ikEUNFgqtVF9k5WLlNq9Er3JeiR
         yFd2LdqCg4T76ckM2BbKc10EHqeh1jEtAKitTZj2ZgVnMyCRJv0RrB7PRp/fYOojq5KH
         ytzXk4AiQtmA49ZpjOrb9OtZuNvDJtF1/PnSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CMzim16g0haLFiQPV9XYI5J3leuIdfSlox5jPaNCXRY=;
        b=jsn3jMAJcvYxJO5uSz+f/L/vW3h7Y4TPHbS1peabOJDnDwSq3VD7T6zzgZvgrMEEEl
         M1nAwDmp4/eJBYVxYVVscOnGs6GPLnR9SP68/tPmSINrJ4OhVv7YPDgxnmsUYFtHQEul
         kztrWj+LYiOpA5M3WCQMqhncF/7HLQlDHV5s1HSWCIsa5IODsiGradAqN4y1ar2LOTIP
         XeP1B72AicfB9xCnFMCc70vNnCAueJSfqtd1fvydJUOmJ3D7sKqv2otYOrplvvigbuWR
         6GjyWd/TZzVbeBnI29C0a1JbI6CcqkD9u1nklZROjJtyb07U9Yau/ysDSEAeA4KC+4iY
         Tgow==
X-Gm-Message-State: APjAAAVqlC7qUwoyLW7LBR/S2DX/npZN9TeMndHwkOYYhr/rEtSmO/zO
        kOCHO2x1jRnkhetkpZhrrv8HX36cPih4UEsnT4ULO2/uKx+VrkLOGZw8U/3dsNA6xMWpJ3f7JnQ
        Ec5itJgrVecQn/bTMVAUvOsU6JogaEU+NxUvoH1rYan+OscWRIZqCfoVpqgwI1a39k8R+zugLRb
        DNKqxIYNAiut+F
X-Google-Smtp-Source: APXvYqxvIrtn34p6fyS4z3QiFKutG2yGeDooCWLi2Xhfh7vi9vol+MA3ROcU/6yHCMYCy9fmsfzJ8Q==
X-Received: by 2002:a63:f746:: with SMTP id f6mr14652232pgk.56.1561460720245;
        Tue, 25 Jun 2019 04:05:20 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:19 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 09/18] megaraid_sas: megaraid_sas: Add check for count returned by HOST_DEVICE_LIST DCMD
Date:   Tue, 25 Jun 2019 16:34:27 +0530
Message-Id: <20190625110436.4703-10-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
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

