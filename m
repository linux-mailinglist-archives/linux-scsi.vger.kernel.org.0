Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77449168C5
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfEGRG5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36377 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRG4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so8619783pgc.3
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aflJaYHZKPIXheu2HfY3QQIzr5YPwlOTARNWhhcuNxA=;
        b=di1hRnj+4vme81LL4UwGim3WRuP7qv3aSoW4fGKtsvihxrH59NgbXd2GPtq0plXnGP
         nLbFF30niIuWbeFAIGJnhq9maVS+pq4p3mYr5xvaL4tLb1aEVbdxBowyeqSTQaEAtw9S
         wrsrHy3bFQ3Kvo6Gz66xgtTX1J16lJJFrxjRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aflJaYHZKPIXheu2HfY3QQIzr5YPwlOTARNWhhcuNxA=;
        b=Q9bZ58mr2u+eT/T6KgrsCe66ghWUGYp1kZtafd9exH7X5pQjO99k66dz0wyvknun4v
         pjXdDZZFN5CX9N1U0QpGWjO7OYLg4ivOEkZ7YLR0OmJ/bxss1iv/SULfii/Tb1OxLnHt
         4SVnBUNVw20u2Yu4PEoebBgtcM7VLs7mwak0o6DRtDVUpFFJbJkQBH9o2XKv6c7cgkBJ
         qmZYwCXW8PmBSYDJuqJ3fhYn57olF5z4+XpQRX6UmjCQOOlb5kpSabDyNlqNweA1/EdP
         2Mj/4QUC2ltXd7XHg98gC7aSOfDLeSJP6widzaCfA3XXP0Rvratfoj4GZE8TM78tS0Qx
         Hyvg==
X-Gm-Message-State: APjAAAUf9YaJnQzWNntMNrvLnczFAKgMnJlI0Y4MSpzvb9BC73JgLtxs
        p4FYQV6SCwzkpzkI3lR9VTS9RZ8Qlo99t6Mr01tny4+Fs9LPBwawLJ1y4G+uMXED0djpq5Jhgog
        Nr8y/yJlkyGDVejldwPAX/1lVyg7qqM/zlukXb9JVwrS9qVuO3aBVMeQNaUgG8bgbmyWUI9XnxQ
        R+cqnCydoZOyL7mcWMUgms
X-Google-Smtp-Source: APXvYqw0z5/ufTgvGucDE73rEAa7eDjrV563Ye3rk4X3uN1PNxYlyZdiOrzS4i2tT8m2GvX7Olb6uA==
X-Received: by 2002:a65:610a:: with SMTP id z10mr40917623pgu.54.1557248815783;
        Tue, 07 May 2019 10:06:55 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:54 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 13/21] megaraid_sas: Print BAR information from driver
Date:   Tue,  7 May 2019 10:05:42 -0700
Message-Id: <1557248750-4099-14-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add prints for BAR address information during driver load.
This helps in debugging issues with BAR address changing during
OS boot.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 905b45590c7e..18d142f2a2a2 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5625,6 +5625,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	u32 max_sectors_2, tmp_sectors, msix_enable;
 	u32 scratch_pad_1, scratch_pad_2, scratch_pad_3, status_reg;
 	resource_size_t base_addr;
+	void *base_addr_phys;
 	struct megasas_ctrl_info *ctrl_info = NULL;
 	unsigned long bar_list;
 	int i, j, loop, fw_msix_count = 0;
@@ -5650,6 +5651,11 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		goto fail_ioremap;
 	}
 
+	base_addr_phys = &base_addr;
+	dev_printk(KERN_DEBUG, &instance->pdev->dev,
+		   "BAR:0x%lx  BAR's base_addr(phys):%pa  mapped virt_addr:0x%p\n",
+		   instance->bar, base_addr_phys, instance->reg_set);
+
 	if (instance->adapter_type != MFI_SERIES)
 		instance->instancet = &megasas_instance_template_fusion;
 	else {
-- 
2.16.1

