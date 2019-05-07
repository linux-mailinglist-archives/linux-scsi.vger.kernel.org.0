Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D62168CB
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfEGRHT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:07:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42013 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRHS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:07:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so8604854pgh.9
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ACa/EqKVFsP5vrr7LtpumR+GacpoYOGUx7Xl18mbF94=;
        b=FG6QobRrnJU+PqgfMN9CAtupZd1ToAEyLpCXRjqJymTuxPiB3Fnd57bprujsowKwow
         BZ7YH/XmZtEupSOlUt8r7uXqfmPw8ySWW+dpntPDKE2qTrlQTiCoPufj042Vw3RCIDhF
         +ApXnYfC6ldJXut+7jVT23cmXsY0JcyIUJwbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ACa/EqKVFsP5vrr7LtpumR+GacpoYOGUx7Xl18mbF94=;
        b=WLWkYPjs/U4RxkeKIp+8pC9lljTWCCEfD0XIJ4Cfi5b8iYf76Ah6nnswekRqKhtq4W
         70KcBU5D39kIIRSwtm1oIdeg2FIzD+OHWsWqJ5N0n0s1G0kMxZL9qgIgmEYvB4z73IpF
         KkzSA4K/E+2e0OKi2YLc0btgvRQ0h9knMgqT5VEQtcdlp2D/JyWJDQbtvdLvguv29nE1
         4NSDMZV2/lXQy58uiIWx6OfHEavhAveegz5tPXeG0HKAWuikdPwYt4H6UE55c3RUIGQj
         KGjQHyjcVjfKsCLxK8/0Zt/KUh3AiIZqykY3iw+d/Gh67CMhG4XquaRz7oIV+cWP7mkK
         7rrQ==
X-Gm-Message-State: APjAAAV8NHOI/YpiY0gNi5X+eXuWT/yjAuguCcDwcXz0S5eYJjruh8i6
        BaliWVSf0vVxgk/18W7CZqyoye7/ebFLA0ZlmmL5304K4+Zz1hIK2NZIxy7pfGWHd5WC1E9mz7c
        zakB88zD/fNscg5CHGcXzf3H54M4tSWZfSiejwZ1erZPL8YGCAETsFv36oMUgcgA5nYHuqDTd6j
        8SYCSywAk1s4v2/U2JcKHq
X-Google-Smtp-Source: APXvYqykaGVUi63gNYuu0HmHgVcf7xwaRUdhFu57okiVDeB2ZaHrf6fHM+GCqFZnxLrBqmml3Jhk0g==
X-Received: by 2002:a63:5d3:: with SMTP id 202mr39595214pgf.363.1557248837696;
        Tue, 07 May 2019 10:07:17 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:07:16 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 19/21] megaraid_sas: Fix MSI-x vector print
Date:   Tue,  7 May 2019 10:05:48 -0700
Message-Id: <1557248750-4099-20-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Print FW supported MSI-x vector count only if FW supports
MSI-x.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b9893f8ccf4d..5f7842982d57 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5681,7 +5681,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	void *base_addr_phys;
 	struct megasas_ctrl_info *ctrl_info = NULL;
 	unsigned long bar_list;
-	int i, j, loop, fw_msix_count = 0;
+	int i, j, loop;
 	struct IOV_111 *iovPtr;
 	struct fusion_context *fusion;
 
@@ -5802,7 +5802,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
 				/* Thunderbolt Series*/
 				instance->msix_vectors = (scratch_pad_1
 					& MR_MAX_REPLY_QUEUES_OFFSET) + 1;
-				fw_msix_count = instance->msix_vectors;
 			} else {
 				instance->msix_vectors = ((scratch_pad_1
 					& MR_MAX_REPLY_QUEUES_EXT_OFFSET)
@@ -5837,7 +5836,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
 					instance->smp_affinity_enable = false;
 				}
 
-				fw_msix_count = instance->msix_vectors;
 				/* Save 1-15 reply post index address to local memory
 				 * Index 0 is already saved from reg offset
 				 * MPI2_REPLY_POST_HOST_INDEX_OFFSET
@@ -5850,6 +5848,10 @@ static int megasas_init_fw(struct megasas_instance *instance)
 						+ (loop * 0x10));
 				}
 			}
+
+			dev_info(&instance->pdev->dev,
+				 "firmware supports msix\t: (%d)",
+				 instance->msix_vectors);
 			if (msix_vectors)
 				instance->msix_vectors = min(msix_vectors,
 					instance->msix_vectors);
@@ -5892,8 +5894,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
 
 	megasas_setup_reply_map(instance);
 
-	dev_info(&instance->pdev->dev,
-		"firmware supports msix\t: (%d)", fw_msix_count);
 	dev_info(&instance->pdev->dev,
 		"current msix/online cpus\t: (%d/%d)\n",
 		instance->msix_vectors, (unsigned int)num_online_cpus());
-- 
2.16.1

