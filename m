Return-Path: <linux-scsi+bounces-10838-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18789EFFEA
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Dec 2024 00:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD142169208
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Dec 2024 23:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064401DE89B;
	Thu, 12 Dec 2024 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzZlYjUD"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EF1D7E5F
	for <linux-scsi@vger.kernel.org>; Thu, 12 Dec 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045294; cv=none; b=Vgi7ilb5dyMD6UaqLxZbIamYbiJ6bX3XAX80sj8DdAKiT9nuM5zBQzqzkTZ44kuUHPOgRSI7YvKrUN4uICKUTgI5ivHVzPEYmPPpBrCFpt62WUqIHcQzzoE7LJ9wIyUYed6L70YFqyeCtsBg+9BAs5bKTWGeLGBE3akLlLWSzlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045294; c=relaxed/simple;
	bh=jZrGVbnVSKLwNj6L+Q/es9bmcvPdY/juZgo3Ztb7M1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwyV0yDGpXEAh4LJG91trt+Broh8WR/IzDlI4juQX5lJgfSrLjB9lCaZxE96BmU6Bi4iuN1RLAi3FnbzusGuZYdqft51IfT+gckEhOgpSV4J0RUVI6Auv3TYTBOxQFdif98EIOjjKR/l8Ph8NzEt5zmsvvVVCrB/FejGpQNr4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzZlYjUD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644e6140cso10649075ad.1
        for <linux-scsi@vger.kernel.org>; Thu, 12 Dec 2024 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734045292; x=1734650092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7pPlW7/+yJaMsr49HqG0muqh53rPVm+l0M6brt3qJk=;
        b=PzZlYjUDG89bl/fO8wF1rcJC2Eo9nTqiz1BTquuhA+N/gHOPrlX4ny1kYZWBxtA0Xu
         J03h2Wvbv3/+PW6Gf7o9jGHiazH4HOriSWFj5Dml9zYRIYmKjmj4M/hzb23kJA8pxnc3
         35K0p/byIcjbR9Lnx/M4GWK0e+8xZU41SOTBDOEvedYMFRrUFXYQG4lFQqakmZ/hQrSs
         8GxMIQ8Taqynvw1qDw6X4HsglP5FS+72NrznZymhrL+glDCT8FNJn3GVPBMaKJF7QW+h
         LQ7UEPOzX48aTa/dp6Rg4M622o4g5VzSPCpCRGUKXiybC/vHR+d6JQNiVpklMormmzbr
         eegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734045292; x=1734650092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7pPlW7/+yJaMsr49HqG0muqh53rPVm+l0M6brt3qJk=;
        b=cpFVox01sWLkDJp7YCsJtFoUtMjKg7UN8TsVODAvsJpRpanGxRxqqyRseagC3GLX3x
         FS4BAeZUO8vdMpqx7HiKMX7Vx/EPO0aFpVpVR31AnZT1XJekW4mJWkU/BB2d4JLh0ESt
         44ovWIBuFP6HDH6OgnymkOv79BYMPeCcA2GGhuSj1Ty63kBB3Oz/u+DBmV9i5P0f2cZ0
         ImWmyFKEPJ/HBp0w5wDtYWyFmEfzIwNFaPaLJ+U/hckYUCd6dh9T/Hjt/uqBxP4EQeyG
         BgD+O930w1AWjIYRaFhJXuZtrmMJL5QSf9Fhb8i7K3k/SROnHcRKZRnWWlAHu9ONbE3c
         121w==
X-Gm-Message-State: AOJu0YwRXpCJL3NoAlsyoU1Eph6AM/wBAVi1ahxFmQ4C0PeS9USAp8Tz
	ffR/ZaZkQdBoxXH1W+B+aR3wygI+l9+UwjVOQWvtjjJ7BYpwGpMK/Y8q+w==
X-Gm-Gg: ASbGncvkX6r85QhvOo2Ixpx5jV0l36Jw9lqS2gV5HhIUXGTFaUG8O6Qf60cNDsmutx1
	WqNRpND40O2Su/zpjuQ5zCy0OScUheT1HNT2NA9SEVd5AHN9UTiakJVAChzZ/Pb+dd23BySaa/2
	jix+FOZJ8nl+v7Hvlo/105Z0XlP12/388NWclCH1/Fgy5mwHj1oL5JGeXPp2vBOfqNn5WRxh5+e
	H5OTNDvR780035umJXccWkemuYpKwqCA85QfRDWtk3osvwNCIt6v8GROl6/i+OuvhSURftSl+Y4
	e/KW0oEyN8rrqEwnMJHpdYgmgEJfF9/CzRAMWRRlHA==
X-Google-Smtp-Source: AGHT+IEU4SGCgNjhjAE64EOS5uiW9C8lwsPGjdl4iU0AiJ5tgWLnWZDWF8T7rsy6gNzZK8/xNcXvxg==
X-Received: by 2002:a17:903:234f:b0:216:643a:535a with SMTP id d9443c01a7336-21892a4383cmr5070345ad.20.1734045292282;
        Thu, 12 Dec 2024 15:14:52 -0800 (PST)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216325f51d6sm92727875ad.197.2024.12.12.15.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2024 15:14:51 -0800 (PST)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart2021@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH 07/10] lpfc: Update definition of firmware configuration mbox cmds
Date: Thu, 12 Dec 2024 15:33:06 -0800
Message-Id: <20241212233309.71356-8-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20241212233309.71356-1-justintee8345@gmail.com>
References: <20241212233309.71356-1-justintee8345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are unused fields in mailbox commands that query for firmware
configuration information.  As such, update the struct definitions by
correcting the name of certain fields and removing the unused fields.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_hw4.h  | 85 +++++++++++------------------------
 drivers/scsi/lpfc/lpfc_init.c |  7 +--
 drivers/scsi/lpfc/lpfc_sli4.h |  2 -
 3 files changed, 28 insertions(+), 66 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index 26e1313ebb21..2dedb273b091 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -1907,22 +1907,22 @@ struct lpfc_mbx_query_fw_config {
 		uint32_t asic_revision;
 		uint32_t physical_port;
 		uint32_t function_mode;
-#define LPFC_FCOE_INI_MODE	0x00000040
-#define LPFC_FCOE_TGT_MODE	0x00000080
+#define LPFC_FC_INI_MODE	0x00000040
+#define LPFC_FC_TGT_MODE	0x00000080
 #define LPFC_DUA_MODE		0x00000800
-		uint32_t ulp0_mode;
-#define LPFC_ULP_FCOE_INIT_MODE	0x00000040
-#define LPFC_ULP_FCOE_TGT_MODE	0x00000080
-		uint32_t ulp0_nap_words[12];
-		uint32_t ulp1_mode;
-		uint32_t ulp1_nap_words[12];
+		uint32_t oper_mode;
+		uint32_t rsvd9[2];
+		uint32_t wqid_base;
+		uint32_t wqid_tot;
+		uint32_t rqid_base;
+		uint32_t rqid_tot;
+		uint32_t rsvd15[19];
 		uint32_t function_capabilities;
 		uint32_t cqid_base;
 		uint32_t cqid_tot;
 		uint32_t eqid_base;
 		uint32_t eqid_tot;
-		uint32_t ulp0_nap2_words[2];
-		uint32_t ulp1_nap2_words[2];
+		uint32_t rsvd39[4];
 	} rsp;
 };
 
@@ -3778,25 +3778,22 @@ struct lpfc_mbx_get_prof_cfg {
 struct lpfc_controller_attribute {
 	uint32_t version_string[8];
 	uint32_t manufacturer_name[8];
-	uint32_t supported_modes;
+	uint32_t rsvd16;
 	uint32_t word17;
-#define lpfc_cntl_attr_eprom_ver_lo_SHIFT	0
-#define lpfc_cntl_attr_eprom_ver_lo_MASK	0x000000ff
-#define lpfc_cntl_attr_eprom_ver_lo_WORD	word17
-#define lpfc_cntl_attr_eprom_ver_hi_SHIFT	8
-#define lpfc_cntl_attr_eprom_ver_hi_MASK	0x000000ff
-#define lpfc_cntl_attr_eprom_ver_hi_WORD	word17
 #define lpfc_cntl_attr_flash_id_SHIFT		16
 #define lpfc_cntl_attr_flash_id_MASK		0x000000ff
 #define lpfc_cntl_attr_flash_id_WORD		word17
-	uint32_t mbx_da_struct_ver;
-	uint32_t ep_fw_da_struct_ver;
+#define lpfc_cntl_attr_boot_enable_SHIFT	24
+#define lpfc_cntl_attr_boot_enable_MASK		0x00000001
+#define lpfc_cntl_attr_boot_enable_WORD		word17
+	uint32_t rsvd18[2];
 	uint32_t ncsi_ver_str[3];
-	uint32_t dflt_ext_timeout;
+	uint32_t rsvd23;
 	uint32_t model_number[8];
 	uint32_t description[16];
 	uint32_t serial_number[8];
-	uint32_t ip_ver_str[8];
+	uint32_t ipl_name[5];
+	uint32_t rsvd61[3];
 	uint32_t fw_ver_str[8];
 	uint32_t bios_ver_str[8];
 	uint32_t redboot_ver_str[8];
@@ -3804,53 +3801,31 @@ struct lpfc_controller_attribute {
 	uint32_t flash_fw_ver_str[8];
 	uint32_t functionality;
 	uint32_t word105;
-#define lpfc_cntl_attr_max_cbd_len_SHIFT	0
-#define lpfc_cntl_attr_max_cbd_len_MASK		0x0000ffff
-#define lpfc_cntl_attr_max_cbd_len_WORD		word105
 #define lpfc_cntl_attr_asic_rev_SHIFT		16
 #define lpfc_cntl_attr_asic_rev_MASK		0x000000ff
 #define lpfc_cntl_attr_asic_rev_WORD		word105
-#define lpfc_cntl_attr_gen_guid0_SHIFT		24
-#define lpfc_cntl_attr_gen_guid0_MASK		0x000000ff
-#define lpfc_cntl_attr_gen_guid0_WORD		word105
-	uint32_t gen_guid1_12[3];
+	uint32_t rsvd106[3];
 	uint32_t word109;
-#define lpfc_cntl_attr_gen_guid13_14_SHIFT	0
-#define lpfc_cntl_attr_gen_guid13_14_MASK	0x0000ffff
-#define lpfc_cntl_attr_gen_guid13_14_WORD	word109
-#define lpfc_cntl_attr_gen_guid15_SHIFT		16
-#define lpfc_cntl_attr_gen_guid15_MASK		0x000000ff
-#define lpfc_cntl_attr_gen_guid15_WORD		word109
 #define lpfc_cntl_attr_hba_port_cnt_SHIFT	24
 #define lpfc_cntl_attr_hba_port_cnt_MASK	0x000000ff
 #define lpfc_cntl_attr_hba_port_cnt_WORD	word109
-	uint32_t word110;
-#define lpfc_cntl_attr_dflt_lnk_tmo_SHIFT	0
-#define lpfc_cntl_attr_dflt_lnk_tmo_MASK	0x0000ffff
-#define lpfc_cntl_attr_dflt_lnk_tmo_WORD	word110
-#define lpfc_cntl_attr_multi_func_dev_SHIFT	24
-#define lpfc_cntl_attr_multi_func_dev_MASK	0x000000ff
-#define lpfc_cntl_attr_multi_func_dev_WORD	word110
+	uint32_t rsvd110;
 	uint32_t word111;
-#define lpfc_cntl_attr_cache_valid_SHIFT	0
-#define lpfc_cntl_attr_cache_valid_MASK		0x000000ff
-#define lpfc_cntl_attr_cache_valid_WORD		word111
 #define lpfc_cntl_attr_hba_status_SHIFT		8
 #define lpfc_cntl_attr_hba_status_MASK		0x000000ff
 #define lpfc_cntl_attr_hba_status_WORD		word111
-#define lpfc_cntl_attr_max_domain_SHIFT		16
-#define lpfc_cntl_attr_max_domain_MASK		0x000000ff
-#define lpfc_cntl_attr_max_domain_WORD		word111
 #define lpfc_cntl_attr_lnk_numb_SHIFT		24
 #define lpfc_cntl_attr_lnk_numb_MASK		0x0000003f
 #define lpfc_cntl_attr_lnk_numb_WORD		word111
 #define lpfc_cntl_attr_lnk_type_SHIFT		30
 #define lpfc_cntl_attr_lnk_type_MASK		0x00000003
 #define lpfc_cntl_attr_lnk_type_WORD		word111
-	uint32_t fw_post_status;
-	uint32_t hba_mtu[8];
+	uint32_t rsvd112[9];
 	uint32_t word121;
-	uint32_t reserved1[3];
+#define lpfc_cntl_attr_asic_gen_SHIFT		8
+#define lpfc_cntl_attr_asic_gen_MASK		0x000000ff
+#define lpfc_cntl_attr_asic_gen_WORD		word121
+	uint32_t rsvd122[3];
 	uint32_t word125;
 #define lpfc_cntl_attr_pci_vendor_id_SHIFT	0
 #define lpfc_cntl_attr_pci_vendor_id_MASK	0x0000ffff
@@ -3875,15 +3850,7 @@ struct lpfc_controller_attribute {
 #define lpfc_cntl_attr_pci_fnc_num_SHIFT	16
 #define lpfc_cntl_attr_pci_fnc_num_MASK		0x000000ff
 #define lpfc_cntl_attr_pci_fnc_num_WORD		word127
-#define lpfc_cntl_attr_inf_type_SHIFT		24
-#define lpfc_cntl_attr_inf_type_MASK		0x000000ff
-#define lpfc_cntl_attr_inf_type_WORD		word127
-	uint32_t unique_id[2];
-	uint32_t word130;
-#define lpfc_cntl_attr_num_netfil_SHIFT		0
-#define lpfc_cntl_attr_num_netfil_MASK		0x000000ff
-#define lpfc_cntl_attr_num_netfil_WORD		word130
-	uint32_t reserved2[4];
+	uint32_t rsvd128[7];
 };
 
 struct lpfc_mbx_get_cntl_attributes {
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 44ddecb3909d..b94624789771 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11109,14 +11109,11 @@ lpfc_sli4_queue_setup(struct lpfc_hba *phba)
 
 	phba->sli4_hba.fw_func_mode =
 			mboxq->u.mqe.un.query_fw_cfg.rsp.function_mode;
-	phba->sli4_hba.ulp0_mode = mboxq->u.mqe.un.query_fw_cfg.rsp.ulp0_mode;
-	phba->sli4_hba.ulp1_mode = mboxq->u.mqe.un.query_fw_cfg.rsp.ulp1_mode;
 	phba->sli4_hba.physical_port =
 			mboxq->u.mqe.un.query_fw_cfg.rsp.physical_port;
 	lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-			"3251 QUERY_FW_CFG: func_mode:x%x, ulp0_mode:x%x, "
-			"ulp1_mode:x%x\n", phba->sli4_hba.fw_func_mode,
-			phba->sli4_hba.ulp0_mode, phba->sli4_hba.ulp1_mode);
+			"3251 QUERY_FW_CFG: func_mode:x%x\n",
+			phba->sli4_hba.fw_func_mode);
 
 	mempool_free(mboxq, phba->mbox_mem_pool);
 
diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index c1e9ec0243ba..9be3da91c923 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -865,8 +865,6 @@ struct lpfc_sli4_hba {
 	struct lpfc_name wwpn;
 
 	uint32_t fw_func_mode;	/* FW function protocol mode */
-	uint32_t ulp0_mode;	/* ULP0 protocol mode */
-	uint32_t ulp1_mode;	/* ULP1 protocol mode */
 
 	/* Optimized Access Storage specific queues/structures */
 	uint64_t oas_next_lun;
-- 
2.38.0


