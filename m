Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC14CC5B
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbfFTKxM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33343 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKxL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so786762pgk.0
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TUNP3/GEs4BdPR5S0pmQLB6jVYGQK1gtCSlVf7s5jwk=;
        b=L8wXcK4spjKbkBS6EuJ1gH53SgsbJviQzR2xz2+ONYfewN66GFX+4VN++KT+RIqijH
         Z1tkXwgqEdVegjfdhgjVt7bNqnsZRpTNMUloZ+61HEHq/uGhhNbVCGuB8Fj85lnpWZH1
         zI7GZwsFzvwA8d0pnjmMBd6MSa1FH6IbGQ2oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TUNP3/GEs4BdPR5S0pmQLB6jVYGQK1gtCSlVf7s5jwk=;
        b=sHxgmAWR4moTuNHJ6fLW3ZSVaQSm94MTv0GxI4YIoGeu9pFyhoEBKRl/BOIMOok/36
         ZlvFBK6mq2cfMgeaxY00eT6fif9J1hVLpFeOTWwmZzP4993sUktc/aO0oGjxieQy/ykb
         tJxr6ERieobb5RMFiLbRmMDUnJfMnL7uofJ6pN9DxPibQ46UJ9joXV07ch32Dgnb+0C/
         cvwQ24guJixFesp9Af3bPBCmTXwrtDJsVYUOwbsohQAe/NK1IH9zusYWDcl84fkahSc/
         c8I8MA9z6VXf8YqzQe3byFEW1FzHTZyeB5uc/tv3o4FFCvwnLViQ89FlCxTPNwL7fjUK
         /Tow==
X-Gm-Message-State: APjAAAWHpaWRY32li6lHC+AjllKA5IbKKpqO+aduxFOUCHrePmKQjWos
        zb1bZGT797fri30vaD/j5qGHoHZCIqquk/AXRzNaa3MsBo9jFzL3YttOYUNhG7u3uBnADJzsU5Z
        6m+PR8R8K4PhLWq7BjnrYD8phSQCVgkFXqXBYR4gubeRBId2fTsIwuWwKRMhM09cfcost25N2z+
        xCF5QnX3OweTr+
X-Google-Smtp-Source: APXvYqxGVRm84487gyp4KDNC63Wt0FQyG1nfPljdo6CfipvRmnbs1aZjvszKflA6hrW2aUPWbB+Fig==
X-Received: by 2002:a17:90a:3590:: with SMTP id r16mr2501128pjb.44.1561027990509;
        Thu, 20 Jun 2019 03:53:10 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.53.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:09 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 10/18] megaraid_sas: RAID1 PCI bandwidth limit algorithm is applicable for only Ventura
Date:   Thu, 20 Jun 2019 16:22:00 +0530
Message-Id: <20190620105208.15011-11-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

RAID1 PCI bandwidth limit algorithm is not applicable to Aero as
it's PCIe Gen4 adapter.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c   |  3 +++
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 24 +++++++++++++-----------
 drivers/scsi/megaraid/megaraid_sas_fusion.h |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index a886de3e3..5244b6e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5777,6 +5777,9 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			MR_MAX_RAID_MAP_SIZE_MASK);
 	}
 
+	if (instance->adapter_type == VENTURA_SERIES)
+		fusion->pcie_bw_limitation = true;
+
 	/* Check if MSI-X is supported while in ready state */
 	msix_enable = (instance->instancet->read_fw_status_reg(instance) &
 		       0x4000000) >> 0x1a;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 5121d4c..ad18474 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2621,9 +2621,10 @@ static void megasas_stream_detect(struct megasas_instance *instance,
  *
  */
 static void
-megasas_set_raidflag_cpu_affinity(union RAID_CONTEXT_UNION *praid_context,
-				  struct MR_LD_RAID *raid, bool fp_possible,
-				  u8 is_read, u32 scsi_buff_len)
+megasas_set_raidflag_cpu_affinity(struct fusion_context *fusion,
+				union RAID_CONTEXT_UNION *praid_context,
+				struct MR_LD_RAID *raid, bool fp_possible,
+				u8 is_read, u32 scsi_buff_len)
 {
 	u8 cpu_sel = MR_RAID_CTX_CPUSEL_0;
 	struct RAID_CONTEXT_G35 *rctx_g35;
@@ -2681,11 +2682,11 @@ megasas_set_raidflag_cpu_affinity(union RAID_CONTEXT_UNION *praid_context,
 	 * vs MR_RAID_FLAGS_IO_SUB_TYPE_CACHE_BYPASS.
 	 * IO Subtype is not bitmap.
 	 */
-	if ((raid->level == 1) && (!is_read)) {
-		if (scsi_buff_len > MR_LARGE_IO_MIN_SIZE)
-			praid_context->raid_context_g35.raid_flags =
-				(MR_RAID_FLAGS_IO_SUB_TYPE_LDIO_BW_LIMIT
-				<< MR_RAID_CTX_RAID_FLAGS_IO_SUB_TYPE_SHIFT);
+	if ((fusion->pcie_bw_limitation) && (raid->level == 1) && (!is_read) &&
+			(scsi_buff_len > MR_LARGE_IO_MIN_SIZE)) {
+		praid_context->raid_context_g35.raid_flags =
+			(MR_RAID_FLAGS_IO_SUB_TYPE_LDIO_BW_LIMIT
+			<< MR_RAID_CTX_RAID_FLAGS_IO_SUB_TYPE_SHIFT);
 	}
 }
 
@@ -2834,8 +2835,9 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 				(instance->host->can_queue)) {
 				fp_possible = false;
 				atomic_dec(&instance->fw_outstanding);
-			} else if ((scsi_buff_len > MR_LARGE_IO_MIN_SIZE) ||
-				   (atomic_dec_if_positive(&mrdev_priv->r1_ldio_hint) > 0)) {
+			} else if (fusion->pcie_bw_limitation &&
+				((scsi_buff_len > MR_LARGE_IO_MIN_SIZE) ||
+				   (atomic_dec_if_positive(&mrdev_priv->r1_ldio_hint) > 0))) {
 				fp_possible = false;
 				atomic_dec(&instance->fw_outstanding);
 				if (scsi_buff_len > MR_LARGE_IO_MIN_SIZE)
@@ -2860,7 +2862,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 
 		/* If raid is NULL, set CPU affinity to default CPU0 */
 		if (raid)
-			megasas_set_raidflag_cpu_affinity(&io_request->RaidContext,
+			megasas_set_raidflag_cpu_affinity(fusion, &io_request->RaidContext,
 				raid, fp_possible, io_info.isRead,
 				scsi_buff_len);
 		else
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index 9873829..b50da38 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -1335,7 +1335,7 @@ struct fusion_context {
 	dma_addr_t ioc_init_request_phys;
 	struct MPI2_IOC_INIT_REQUEST *ioc_init_request;
 	struct megasas_cmd *ioc_init_cmd;
-
+	bool pcie_bw_limitation;
 };
 
 union desc_value {
-- 
2.9.5

