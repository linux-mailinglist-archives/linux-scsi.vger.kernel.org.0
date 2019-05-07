Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD92168B8
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfEGRGO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38650 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id a59so8482075pla.5
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1l5cQcHT4dT5TKu+rRmWN9++CuA6N+bsfsSSqBnqWYs=;
        b=MHsu7eXM5jPjUun55VTtEv0evMbsRVcpc157OizaP7mk+ZsNxtZZpzOJqLb+iKUGO/
         6K40Q/48liJe7idYKcPfutdTaLHP/DwSe2Ax2/T8A30OB/3SaUrSTAw6qDu6V9GXK4zU
         CURpNvbz2/SciyhCH5xyTKhaOCi6fpy0MBOqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1l5cQcHT4dT5TKu+rRmWN9++CuA6N+bsfsSSqBnqWYs=;
        b=eL3ulLYj1/W1oO2N/c+pkrYWxmxEykLhTa7u4f6bp6Uxrnofva1gPVSh1nYxQ+j0Ir
         Fkg7Bpl5zqThyjgmSQQZP+i4nuka8lcDWC8GXIe8w5uyZldQc6nfxidJPq95k2CXWJq4
         fTDcMq0whJS+6ju2N4amgn7e45S+dyEoWqeADFwp26Abo9OTlwejFbJir6FGFPgi3n27
         AQiB4ELjOMd6OmD4awPzVQxANS2WvHr8Kv5FPTuzx6/K04Jr1Jwo4f90ZD+MRrzU6X4w
         kwtXq6Gqx7RhzWB6VRWj6IBHcQ4BJJkNyxAis+coMM189JqENGc1JKykQ4jBEvRuR7HV
         cNNQ==
X-Gm-Message-State: APjAAAWG/zMsZ1KcWnj4UNcuRcqj+cVcE1Vss+JRRj932ppk0LnCNgFq
        0doKorKnUtIo7Pcx6pI/11nHvnQhYGyXVIwhFDeIIbPN9OjWNdMr9Fun4M5KhW0Kp9RhxLVkV2H
        NA8WgCxv3lvGh1+zLPXjvlC67W8yFoei99eBF3UH3aaoBE18dYNIfCIgWZfOdrY/0EdyW5igmvt
        isCb3lEIp21/Hhi485XAvT
X-Google-Smtp-Source: APXvYqwybA95Td+rt8vrwFi0kKHK6lxnJLLb/9Crt51Quw8v1S1j6HnRUltSCH9vt3RjocZQy63cmw==
X-Received: by 2002:a17:902:d917:: with SMTP id c23mr39357997plz.14.1557248772385;
        Tue, 07 May 2019 10:06:12 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:11 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 01/21] megaraid_sas: remove unused variable target_index
Date:   Tue,  7 May 2019 10:05:30 -0700
Message-Id: <1557248750-4099-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

No functional change.
Remove set but unused variable in megasas_set_static_target_properties.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index bbe6972f3477..f677a84f6bc8 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -1931,7 +1931,6 @@ megasas_set_nvme_device_properties(struct scsi_device *sdev, u32 max_io_size)
 static void megasas_set_static_target_properties(struct scsi_device *sdev,
 						 bool is_target_prop)
 {
-	u16	target_index = 0;
 	u8 interface_type;
 	u32 device_qd = MEGASAS_DEFAULT_CMD_PER_LUN;
 	u32 max_io_size_kb = MR_DEFAULT_NVME_MDTS_KB;
@@ -1948,8 +1947,6 @@ static void megasas_set_static_target_properties(struct scsi_device *sdev,
 	 */
 	blk_queue_rq_timeout(sdev->request_queue, scmd_timeout * HZ);
 
-	target_index = (sdev->channel * MEGASAS_MAX_DEV_PER_CHANNEL) + sdev->id;
-
 	switch (interface_type) {
 	case SAS_PD:
 		device_qd = MEGASAS_SAS_QD;
-- 
2.16.1

