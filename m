Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8649D5F
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfFRJdB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:33:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37030 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfFRJdA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:33:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so5470436plb.4
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g6MA4hymsOLeSXn9FlIo1NB5Oupt/CaenMxRtJtGF4A=;
        b=P2pf95tbBsQzJ7ZbKTJhwuT3tY+rUF49VRgKVZ0cqwmLBBxCFrH2O2ApSxVLKKKkyn
         EX9WM/ZALq3FwwKVwS5LdZqcMnWs/RyThURkX4OPcEbDPSAggg/E38BTnZBv1pCRKQUh
         /H6cO+ZDtR7rc8Sos13NHvXmRGu/nm4aniPBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6MA4hymsOLeSXn9FlIo1NB5Oupt/CaenMxRtJtGF4A=;
        b=YusZjhC9U0UWvju65emCw9iSg9Jp5f2vJYncpDzyadfPdiNMw2fnWJhnSRIBE6lJ/F
         8jQ5o+WisDKrnLsbnuCy2HBXNjaK73D+oQgG6VZP7xhqg5CJz5CunPbaVHqdwJ9aFg8C
         9TcbdisXA8+ICiG90crdBEOJZAgGMdfKArtRbf4z6xhgNKDSV4IQHUZGTorkq3JIKVks
         lVJKDs1tPMOrfvMIquuSrhInrtUCHUdYv2CnH39Sa26nTB6ma5Qd8qZRqMPvxXWqZyXl
         ERDXYsBUbCygWBpHVctwBzWNlGzCyNOh+stmEtukKpNw9Zmt3FWsu2bU1odppEIx+HcL
         iLNQ==
X-Gm-Message-State: APjAAAXvYaJq0kViB59amDZjwqmsOTN3gcMN5u8kcXiRxQgCkcwZA8zv
        xgqv1LkD0SOLJntyzzr/qvssSVsJ3l+jHLqWDqUzdsZqRgiXBRF2vVBg7vZwSW1zZxXuz3KK4H0
        jz8F9dR55ZXuVX6fkBg87RIE1ytbRUe6OGzJnxZhiaitBBNgZ3o0V1Gkpnuhy6edEz8I9hw/mkz
        TVxT+1fRaFiA==
X-Google-Smtp-Source: APXvYqxcw0uPgC4l3l89JTnQn9QTVM1dpaFRjRHIwhzPV+YmHU/o32cdQ5FALbfKls+xQHBlVf7pEg==
X-Received: by 2002:a17:902:294a:: with SMTP id g68mr115245558plb.169.1560850378685;
        Tue, 18 Jun 2019 02:32:58 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:58 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 10/18] megaraid_sas: RAID1 PCI bandwidth limit algorithm is applicable for only Ventura
Date:   Tue, 18 Jun 2019 15:01:59 +0530
Message-Id: <20190618093207.9939-11-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
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
index 15cda83..9e7d9e4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2623,9 +2623,10 @@ static void megasas_stream_detect(struct megasas_instance *instance,
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
@@ -2683,11 +2684,11 @@ megasas_set_raidflag_cpu_affinity(union RAID_CONTEXT_UNION *praid_context,
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
 
@@ -2836,8 +2837,9 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
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
@@ -2862,7 +2864,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 
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

