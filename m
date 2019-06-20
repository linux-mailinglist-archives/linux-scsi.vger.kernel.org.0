Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF684CC5F
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfFTKxY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:24 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:42900 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTKxY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:24 -0400
Received: by mail-pg1-f175.google.com with SMTP id l19so1377492pgh.9
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QT4tQX6YeIvXgliqgWDFrZYwJqIGjTRFovye1EtSvM=;
        b=GsCtzm1QMETr1/7PD6NH/xmWSMbQb2EwJ6aG2O6cyP1WrZtv74auo8AEomsfkexMfC
         nuD+F5j3xGUM9rgDLM/TjkfepW37GICDa2/D6U3YPZupdH3AA+/mu/bvZ7+zPvSB0+Iw
         LpqXgCljdCeQz3DWuYwg6y0nU8jTmtq2yqOU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QT4tQX6YeIvXgliqgWDFrZYwJqIGjTRFovye1EtSvM=;
        b=NGaEf+LRicUjzmXJOmhSl6e9QLTQftAP1FY/QIyog0YkKWbkzwdNXSuLr0hxZDv6uV
         cPpxydUvmHDWr9jZyehz5aqhXDz+aN/kxyZ6tH03BSI4iIWlDtiMmcjhfQ99Sn3BVb/8
         5YeKsOHfG4s2SAU/InrwQO4+bk2vhF08CEqQDVSwTu9aQ5oEIMlXDqFKryGQvmsFSEGa
         5d3KiOWqG+hRtbHvjMT/DVHDfnK1Gcw19djGAg1iM43J0duzmm4LAJ1yY1qYGq72hld5
         /8ZeQ9G1xno+agu/zphnO+jYpqCX3ErScxIXJOlq8EGJA51X47VlbeU6V5PHuKXRKh7x
         eUow==
X-Gm-Message-State: APjAAAXuUNB+Cn3oLggKoiOrk2veoVhlAVUM2PIQLbGr69zGpjQddlfr
        QRA743cn4kgUiVjT7MjYB7tMELqiUnl2y9z8Zu/u2AKaqdT0h6V8sX0rrZyLqs9CWje5Fdhe5IA
        aiI/dvx1WoehZGhtm8YT7NuLWZP/xJ4UAzFI5ec9PPMR9bTMBOGk4ei1bU1aL79Y1dn+f3qIL3F
        CfuMEKksyeR6mO
X-Google-Smtp-Source: APXvYqx40UHxQJvmmjUSwSi/JeiYNQ4g+U6dqORDTjfr72G1lJzF/Z9W0TSk4TnbDm4duGk84b6xGw==
X-Received: by 2002:a65:5787:: with SMTP id b7mr12493802pgr.148.1561028002985;
        Thu, 20 Jun 2019 03:53:22 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.53.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:22 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 14/18] megaraid_sas: Enable coalescing for high IOPs queues
Date:   Thu, 20 Jun 2019 16:22:04 +0530
Message-Id: <20190620105208.15011-15-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

