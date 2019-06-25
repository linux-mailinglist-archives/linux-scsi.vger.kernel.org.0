Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0D54D2E
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfFYLFh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:37 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:35508 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:37 -0400
Received: by mail-pl1-f170.google.com with SMTP id w24so785475plp.2
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QT4tQX6YeIvXgliqgWDFrZYwJqIGjTRFovye1EtSvM=;
        b=L/C4oBt2uTruu3VeHMREOtQrokUTdAvACtRW0EKa9vuxY6BbpUHmyARvZdX+5ZCZzh
         j6iy7GmhQjMMg4SyCJ8JHyN3kjokc9w2fhHgV0+85U/ZDk9P2er3Na8t2RvI+Yi02yJr
         yzxaqVxqVgk6KIt7iWetoochJkD+qSQI4qzBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QT4tQX6YeIvXgliqgWDFrZYwJqIGjTRFovye1EtSvM=;
        b=dtGA42ezFq1uQv5McCvIhgHHvB24rFhLEPhLRXw/Q5q/wJfU1HuUVdNZfRibYk6ZJE
         ugbRkJNtWsykV/TxzM58eCEG979DnzdYEK/f9u5TJ0oKRpZmfr0P6y/96JcA160WT2M6
         ZkTqswzascdR+c/OHqSvfe4vsOBoh6hZGCN77HCicGdzoZ9JBIpsOYsagDOPZzVTIT2U
         630cYFTJzfMTcTCsac4zjKAKBBxffqaQM6TYDN3mQZhmC1Oqp1rgzndIIUAKQJQskQnC
         3Bzk2KAFQy2ihY8AouoAOjmL9Bna1N1uTUsY7FWKWwxMhDnFJn0kg6NJpo5Nv+VnHSU+
         vqNQ==
X-Gm-Message-State: APjAAAXg8nbTDsENi5rc1dgYop5EFL3dLwaYzywAglUuodxEz7Q9tAml
        GW6Ef9RDHb/Xf/JXB6nJv1PALUCnUnOZgVAAEHkYjm9zFh7UjT4k61lk1HV6ZMRq0r4Rh4kw3FY
        9ZwNOlJ+S6WhqFdkaJXXPQR9Bw+mKy+zWr4vX9m3vhD/g8+tHtX01uajOfUYQZuU9LUumdfyoxX
        eCSCtNKtg5Ig==
X-Google-Smtp-Source: APXvYqwnAsxDeXpju+2/NdwNwOdKinkQHkRcV4n3i1rlB/70NgA3oDicBK7GsTKILcHmWs+PDKU7rQ==
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr29001319plz.48.1561460736127;
        Tue, 25 Jun 2019 04:05:36 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:35 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 14/18] megaraid_sas: Enable coalescing for high IOPs queues
Date:   Tue, 25 Jun 2019 16:34:32 +0530
Message-Id: <20190625110436.4703-15-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
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
index 44bfbe8..845ca2f 100644
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

