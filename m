Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB549D65
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfFRJdM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:33:12 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40995 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfFRJdM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:33:12 -0400
Received: by mail-pl1-f174.google.com with SMTP id m7so1872394pls.8
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=srfz79jPE/l6aIm6oRk8LIx8lvHaCR3PE8kt1+0Rx+s=;
        b=hTKVEA003csg85mME8abln2fxwo4BQaNb6w4UB9AztV59tDB3nKWh+R6VdGsLOHwtn
         aXq0u9ExBsGocNrm8hFYWdbKcRH7LSH37qWMedy4ostQcQnlB6oc01rNehAXhw+VO0en
         NrvKsXzNBosjLdk02XSaoUD4i3zXQT7xEhGFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=srfz79jPE/l6aIm6oRk8LIx8lvHaCR3PE8kt1+0Rx+s=;
        b=P8LvRccuMdtZ1xv4sJqGKO7bS7jhSOTQxwvUiFYS1QnCc54VELkXPXwO855GmrhxKT
         GvjcIbA2JNIhBO54XBIFb7829Fh/zzVsE5IsF2rbYD663iRIJBqtBnPLFLjiHz4bFtLX
         5D+inUF6x7Kg+fsi8Nm5CJWqwKy8ZWvjfGEeru8PnEb2eg+c7nMH6uRAvXrUxS8oycbw
         fUsveTeYLoaDhsovIbTziLclmN5ZltO0Y3eFelbr9+ARGUNd7rYbYt0Eb+6NgJVLQb1C
         yUsbYZtd69e4v30sti478AsmhbUeKzfTLWu5ppRYjuzwEGsBG85NK0eONg3SRSOm45hr
         jH2w==
X-Gm-Message-State: APjAAAV9xJMHaV7t6A8Bd7axDnnS3A/WBbqyBG6d8dntKTWim8lcE8Rl
        SiG10fmmi0ojJYsy/0Oa1JKKv05ip36MGVRtiIBwbm6pFn5bkxFeZdgkpzRWxpfEbhihjlHBmpK
        2Yv4g8oqGUY8fikGv0GIgLHcQKeEuc4jaKWvnIeKrxqmnVEursn2Frsztn1hlWi6HDRhf5vqCaS
        YBlkuwuH6fgw==
X-Google-Smtp-Source: APXvYqxIEi0AuWX0v8dlK231gsvn/TEYk2EBbSQjRYoJJ0kS2OL8Q1MIPaDG9CUAXcfI1ttacucwow==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr60823785pls.261.1560850391232;
        Tue, 18 Jun 2019 02:33:11 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.33.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:33:10 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 14/18] megaraid_sas: Enable coalescing for high IOPs queues
Date:   Tue, 18 Jun 2019 15:02:03 +0530
Message-Id: <20190618093207.9939-15-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Driver should enable interrupt coalescing(during driver load and after
Controller Reset) for High IOPs queues by masking  appropriate bits in
IOC INIT frame.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 5b17d0f..02e6e15 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -1819,7 +1819,7 @@ struct megasas_init_frame {
 	__le32 pad_0;		/*0Ch */
 
 	__le16 flags;		/*10h */
-	__le16 reserved_3;		/*12h */
+	__le16 replyqueue_mask;		/*12h */
 	__le32 data_xfer_len;	/*14h */
 
 	__le32 queue_info_new_phys_addr_lo;	/*18h */
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 4ebcb11..e08b3ff 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1186,6 +1186,14 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 		cpu_to_le32(lower_32_bits(ioc_init_handle));
 	init_frame->data_xfer_len = cpu_to_le32(sizeof(struct MPI2_IOC_INIT_REQUEST));
 
+	/*
+	 * Each bit in replyqueue_mask represents one group of MSI-x vectors
+	 * (each group has 8 vectors)
+	 */
+	if (instance->balanced_mode)
+		init_frame->replyqueue_mask =
+		       cpu_to_le16(~(~0 << instance->low_latency_index_start / 8));
+
 	req_desc.u.low = cpu_to_le32(lower_32_bits(cmd->frame_phys_addr));
 	req_desc.u.high = cpu_to_le32(upper_32_bits(cmd->frame_phys_addr));
 	req_desc.MFAIo.RequestFlags =
-- 
2.9.5

