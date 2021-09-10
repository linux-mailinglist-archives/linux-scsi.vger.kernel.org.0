Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BED40616C
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Sep 2021 02:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbhIJAmv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Sep 2021 20:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbhIJATk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Sep 2021 20:19:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EA96610A3;
        Fri, 10 Sep 2021 00:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631233110;
        bh=zyzEVQXdaMoC8vQjHwTr54HgzDKQpevIa+rTXhKwChY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4t2NWEg1CI7avYWt/1J2wp8iikJTlQizYCizqkzdBCYZ5ad/ZN8gJhqFtN1Dp0tP
         sljr3MbhTg1V4VXPTlOs16sVs+3xP8mAev206wFcmDCC8FOoMpLvr/M1gesQ/NF8mP
         5HoF45xs5f82VYcjPMHz/EkanrJCYjaNRGjIUo7TOeNH7JNj354cx5lkEyKjtfio6w
         kJHMTcHUWFBIy8FBrSUGR1qj1R8ZpoD3e0cB/CLq2WSZ1vRFomDMigYF1bArfxQTo7
         vvVWm1dMMWlgWZTA10uEy3cZfDjxzF7L43OOzzpuaV9LHC/biQJrQp+ToToG/HCgAs
         DEB78TWO/ulLw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 06/88] scsi: lpfc: Fix NVMe support reporting in log message
Date:   Thu,  9 Sep 2021 20:16:58 -0400
Message-Id: <20210910001820.174272-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001820.174272-1-sashal@kernel.org>
References: <20210910001820.174272-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit ae463b60235e7a5decffbb0bd7209952ccda78eb ]

The NVMe support indicator in log message 6422 is displaying a field that
was initialized but never set to indicate NVMe support.  Remove obsolete
nvme_support element from the lpfc_hba structure and change log message to
display NVMe support status as reported in SLI4 Config Parameters mailbox
command.

Link: https://lore.kernel.org/r/20210707184351.67872-2-jsmart2021@gmail.com
Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h      | 1 -
 drivers/scsi/lpfc/lpfc_init.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index f8de0d10620b..491a519a28cb 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -831,7 +831,6 @@ struct lpfc_hba {
 	uint8_t  wwpn[8];
 	uint32_t RandomData[7];
 	uint8_t  fcp_embed_io;
-	uint8_t  nvme_support;	/* Firmware supports NVME */
 	uint8_t  nvmet_support;	/* driver supports NVMET */
 #define LPFC_NVMET_MAX_PORTS	32
 	uint8_t  mds_diags_support;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 35a75b89bb64..697053aa2771 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12139,7 +12139,6 @@ lpfc_get_sli4_parameters(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 					bf_get(cfg_xib, mbx_sli4_parameters),
 					phba->cfg_enable_fc4_type);
 fcponly:
-			phba->nvme_support = 0;
 			phba->nvmet_support = 0;
 			phba->cfg_nvmet_mrq = 0;
 			phba->cfg_nvme_seg_cnt = 0;
@@ -12197,7 +12196,7 @@ lpfc_get_sli4_parameters(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 			"6422 XIB %d PBDE %d: FCP %d NVME %d %d %d\n",
 			bf_get(cfg_xib, mbx_sli4_parameters),
 			phba->cfg_enable_pbde,
-			phba->fcp_embed_io, phba->nvme_support,
+			phba->fcp_embed_io, sli4_params->nvme,
 			phba->cfg_nvme_embed_cmd, phba->cfg_suppress_rsp);
 
 	if ((bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) ==
-- 
2.30.2

