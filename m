Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED94B7191
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Feb 2022 17:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiBOPbh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Feb 2022 10:31:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbiBOPbR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Feb 2022 10:31:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE8C3C23;
        Tue, 15 Feb 2022 07:29:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C10B0B81AF1;
        Tue, 15 Feb 2022 15:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD4AC340EB;
        Tue, 15 Feb 2022 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644938948;
        bh=SdNN4jzl4yvhBLhVKk+K87AN0l17ZYIZAN236uiFEDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWlq7mBAo2uEvYvKSsGApn6J2S/Vl8X7lm7GxCO96E3uJoRX0piwNXGCqIvCBA/qt
         b7Dt01EtSo9ieiy2RePDq5EPufZD4zG4WdtBiaXLAfMmhOfabk5gZoVwfrXUkox0iH
         IZ8plQFfVO+gjm3+pXEcHeuQ39p7pOsr7YFc0PC+FeO9IGCosHS0n75+Le5BrUBFAe
         iXkJu1h26NARjEfJQbhd04NBKNACMfPU2yRdmEtqLYyQkN/vflUWnYPo762UjQiUp+
         IYiqLzQbXSTGbk22S7vw90ERq9lDvEO/Yk1i2O8N2G0c2XVCMpXiy+k2/B5br56YPY
         ZWQ/iE7pGiScw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 20/33] scsi: lpfc: Remove NVMe support if kernel has NVME_FC disabled
Date:   Tue, 15 Feb 2022 10:28:18 -0500
Message-Id: <20220215152831.580780-20-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215152831.580780-1-sashal@kernel.org>
References: <20220215152831.580780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit c80b27cfd93ba9f5161383f798414609e84729f3 ]

The driver is initiating NVMe PRLIs to determine device NVMe support.  This
should not be occurring if CONFIG_NVME_FC support is disabled.

Correct this by changing the default value for FC4 support. Currently it
defaults to FCP and NVMe. With change, when NVME_FC support is not enabled
in the kernel, the default value is just FCP.

Link: https://lore.kernel.org/r/20220207180516.73052-1-jsmart2021@gmail.com
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h      | 13 ++++++++++---
 drivers/scsi/lpfc/lpfc_attr.c |  4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 19fd9d263f47f..f66ba64080a31 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1163,6 +1163,16 @@ struct lpfc_hba {
 	uint32_t cfg_hostmem_hgp;
 	uint32_t cfg_log_verbose;
 	uint32_t cfg_enable_fc4_type;
+#define LPFC_ENABLE_FCP  1
+#define LPFC_ENABLE_NVME 2
+#define LPFC_ENABLE_BOTH 3
+#if (IS_ENABLED(CONFIG_NVME_FC))
+#define LPFC_MAX_ENBL_FC4_TYPE LPFC_ENABLE_BOTH
+#define LPFC_DEF_ENBL_FC4_TYPE LPFC_ENABLE_BOTH
+#else
+#define LPFC_MAX_ENBL_FC4_TYPE LPFC_ENABLE_FCP
+#define LPFC_DEF_ENBL_FC4_TYPE LPFC_ENABLE_FCP
+#endif
 	uint32_t cfg_aer_support;
 	uint32_t cfg_sriov_nr_virtfn;
 	uint32_t cfg_request_firmware_upgrade;
@@ -1184,9 +1194,6 @@ struct lpfc_hba {
 	uint32_t cfg_ras_fwlog_func;
 	uint32_t cfg_enable_bbcr;	/* Enable BB Credit Recovery */
 	uint32_t cfg_enable_dpp;	/* Enable Direct Packet Push */
-#define LPFC_ENABLE_FCP  1
-#define LPFC_ENABLE_NVME 2
-#define LPFC_ENABLE_BOTH 3
 	uint32_t cfg_enable_pbde;
 	uint32_t cfg_enable_mi;
 	struct nvmet_fc_target_port *targetport;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index f20c4fe1fb8b9..632b9cdabd14e 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -3978,8 +3978,8 @@ LPFC_ATTR_R(nvmet_mrq_post,
  *                    3 - register both FCP and NVME
  * Supported values are [1,3]. Default value is 3
  */
-LPFC_ATTR_R(enable_fc4_type, LPFC_ENABLE_BOTH,
-	    LPFC_ENABLE_FCP, LPFC_ENABLE_BOTH,
+LPFC_ATTR_R(enable_fc4_type, LPFC_DEF_ENBL_FC4_TYPE,
+	    LPFC_ENABLE_FCP, LPFC_MAX_ENBL_FC4_TYPE,
 	    "Enable FC4 Protocol support - FCP / NVME");
 
 /*
-- 
2.34.1

