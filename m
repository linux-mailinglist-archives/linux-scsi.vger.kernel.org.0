Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CAC18EB70
	for <lists+linux-scsi@lfdr.de>; Sun, 22 Mar 2020 19:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCVSN3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 22 Mar 2020 14:13:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46565 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVSN2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 22 Mar 2020 14:13:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id r3so4865241pls.13
        for <linux-scsi@vger.kernel.org>; Sun, 22 Mar 2020 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fwQfyMKgHF9RKZHHHiEqMFe1K1blMgXsyQbhJ74yi7k=;
        b=UKqxlNzd+jOWSJVClLuBW/M1/rfCdGJQxgxAC5Iza7z90CcJiBZICcl1R101LBbL9U
         NYkl/oBKJ4Otvmohcn7o8jGdyJCX4NAnMPFcfi1rgiU7SKqMASFivOz2eF8DHF94Ak68
         5++otS88scj2XzrtQM0xUqy94amq2aYWGWj4hMfD1Y4Ea6URJqWtSrkrHvmJIm0iodi4
         FxWEUycBxWcLG+Cte/CI3EvwJ0WbmRo21VmkDHhVfRgPrPpWMqc5uB+c7l/QDOT8Yy/3
         O6rMexgBq6TCc8/k6OSOY2L3ac0tZXP2Xv2fw39XyVQn9JJ0ZB2FovKjpYQyLRlgRGig
         q/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fwQfyMKgHF9RKZHHHiEqMFe1K1blMgXsyQbhJ74yi7k=;
        b=ek8Dq4HzlW/iWVplKxZLj3IzOMerqj3xRijrGdG+tdbIWg6mVTIKptHqNOXry7PW2H
         xksf6wMvJY++cFeRj6jfjrEMQ1GUryY7+NA4s+1FCorQi01aXJ7l1k7MZFLwKR7ZGk1V
         rwmR7yafmsJ5FchyMjrQGUYvbvbGdBtg2wqfsd+17ggBY8Vwge/1bMbeCynrGqBpPwPS
         x6Mm9GuWj98bQWbEDZIW9XsFVR3aOKpKWH5DgDcfL9Z80nwsNs+mZaj55HL74Hb7zzuV
         xQiaP+siSS7w1zvIhsHex2I9GbHVzUJu2LLGwAheZHN6Y0IiAzBChjLvKK1zAjPdnuL9
         6r4g==
X-Gm-Message-State: ANhLgQ0S7ZMbAJcZJtgX/qqmRTvi1ggc9MupUk9BBQoR6uJGJvA2y3xG
        g9oeVtmmmbGT592Ia/6lRzA/m3QK
X-Google-Smtp-Source: ADFU+vuEziegu5JurSK75sn59qQp7VwS/DgGJ5xz2MzCzh/D7CDG4lKsZkRf/qQBasgyZ8VIUiA0Mw==
X-Received: by 2002:a17:902:b90c:: with SMTP id bf12mr9165826plb.152.1584900805249;
        Sun, 22 Mar 2020 11:13:25 -0700 (PDT)
Received: from localhost.localdomain.localdomain (ip68-5-146-102.oc.oc.cox.net. [68.5.146.102])
        by smtp.gmail.com with ESMTPSA id bt19sm1331657pjb.3.2020.03.22.11.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 11:13:24 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 11/12] lpfc: Remove prototype FIPS/DSS options from SLI-3
Date:   Sun, 22 Mar 2020 11:13:03 -0700
Message-Id: <20200322181304.37655-12-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200322181304.37655-1-jsmart2021@gmail.com>
References: <20200322181304.37655-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

During code review, identified dss feature that was a prototype only
and was never productized in SLI3. They shouldn't be there and prevents
reuse of the command areas.

Remove any code in the driver to deal with dss, including code to deal
with fips, which is associated with the dss feature.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |  9 ++----
 drivers/scsi/lpfc/lpfc_attr.c | 69 -------------------------------------------
 drivers/scsi/lpfc/lpfc_hw.h   | 20 ++++---------
 drivers/scsi/lpfc/lpfc_mbox.c |  2 --
 drivers/scsi/lpfc/lpfc_sli.c  | 17 -----------
 5 files changed, 8 insertions(+), 109 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 747eda6ff8a4..8e2a356911a9 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -207,8 +207,7 @@ typedef struct lpfc_vpd {
 	} rev;
 	struct {
 #ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t rsvd3  :19;  /* Reserved                             */
-		uint32_t cdss	: 1;  /* Configure Data Security SLI          */
+		uint32_t rsvd3  :20;  /* Reserved                             */
 		uint32_t rsvd2	: 3;  /* Reserved                             */
 		uint32_t cbg	: 1;  /* Configure BlockGuard                 */
 		uint32_t cmv	: 1;  /* Configure Max VPIs                   */
@@ -230,8 +229,7 @@ typedef struct lpfc_vpd {
 		uint32_t cmv	: 1;  /* Configure Max VPIs                   */
 		uint32_t cbg	: 1;  /* Configure BlockGuard                 */
 		uint32_t rsvd2	: 3;  /* Reserved                             */
-		uint32_t cdss	: 1;  /* Configure Data Security SLI          */
-		uint32_t rsvd3  :19;  /* Reserved                             */
+		uint32_t rsvd3  :20;  /* Reserved                             */
 #endif
 	} sli3Feat;
 } lpfc_vpd_t;
@@ -887,7 +885,6 @@ struct lpfc_hba {
 #define LPFC_INITIALIZE_LINK              0	/* do normal init_link mbox */
 #define LPFC_DELAY_INIT_LINK              1	/* layered driver hold off */
 #define LPFC_DELAY_INIT_LINK_INDEFINITELY 2	/* wait, manual intervention */
-	uint32_t cfg_enable_dss;
 	uint32_t cfg_fdmi_on;
 #define LPFC_FDMI_NO_SUPPORT	0	/* FDMI not supported */
 #define LPFC_FDMI_SUPPORT	1	/* FDMI supported? */
@@ -1156,8 +1153,6 @@ struct lpfc_hba {
 	uint32_t iocb_cnt;
 	uint32_t iocb_max;
 	atomic_t sdev_cnt;
-	uint8_t fips_spec_rev;
-	uint8_t fips_level;
 	spinlock_t devicelock;	/* lock for luns list */
 	mempool_t *device_data_mem_pool;
 	struct list_head luns;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index ba786d08de01..4901ebdd561d 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2230,66 +2230,6 @@ lpfc_poll_store(struct device *dev, struct device_attribute *attr,
 	return strlen(buf);
 }
 
-/**
- * lpfc_fips_level_show - Return the current FIPS level for the HBA
- * @dev: class unused variable.
- * @attr: device attribute, not used.
- * @buf: on return contains the module description text.
- *
- * Returns: size of formatted string.
- **/
-static ssize_t
-lpfc_fips_level_show(struct device *dev,  struct device_attribute *attr,
-		     char *buf)
-{
-	struct Scsi_Host  *shost = class_to_shost(dev);
-	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
-	struct lpfc_hba   *phba = vport->phba;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", phba->fips_level);
-}
-
-/**
- * lpfc_fips_rev_show - Return the FIPS Spec revision for the HBA
- * @dev: class unused variable.
- * @attr: device attribute, not used.
- * @buf: on return contains the module description text.
- *
- * Returns: size of formatted string.
- **/
-static ssize_t
-lpfc_fips_rev_show(struct device *dev,  struct device_attribute *attr,
-		   char *buf)
-{
-	struct Scsi_Host  *shost = class_to_shost(dev);
-	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
-	struct lpfc_hba   *phba = vport->phba;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", phba->fips_spec_rev);
-}
-
-/**
- * lpfc_dss_show - Return the current state of dss and the configured state
- * @dev: class converted to a Scsi_host structure.
- * @attr: device attribute, not used.
- * @buf: on return contains the formatted text.
- *
- * Returns: size of formatted string.
- **/
-static ssize_t
-lpfc_dss_show(struct device *dev, struct device_attribute *attr,
-	      char *buf)
-{
-	struct Scsi_Host *shost = class_to_shost(dev);
-	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
-	struct lpfc_hba   *phba = vport->phba;
-
-	return scnprintf(buf, PAGE_SIZE, "%s - %sOperational\n",
-			(phba->cfg_enable_dss) ? "Enabled" : "Disabled",
-			(phba->sli3_options & LPFC_SLI3_DSS_ENABLED) ?
-				"" : "Not ");
-}
-
 /**
  * lpfc_sriov_hw_max_virtfn_show - Return maximum number of virtual functions
  * @dev: class converted to a Scsi_host structure.
@@ -2705,9 +2645,6 @@ static DEVICE_ATTR(max_xri, S_IRUGO, lpfc_max_xri_show, NULL);
 static DEVICE_ATTR(used_xri, S_IRUGO, lpfc_used_xri_show, NULL);
 static DEVICE_ATTR(npiv_info, S_IRUGO, lpfc_npiv_info_show, NULL);
 static DEVICE_ATTR_RO(lpfc_temp_sensor);
-static DEVICE_ATTR_RO(lpfc_fips_level);
-static DEVICE_ATTR_RO(lpfc_fips_rev);
-static DEVICE_ATTR_RO(lpfc_dss);
 static DEVICE_ATTR_RO(lpfc_sriov_hw_max_virtfn);
 static DEVICE_ATTR(protocol, S_IRUGO, lpfc_sli4_protocol_show, NULL);
 static DEVICE_ATTR(lpfc_xlane_supported, S_IRUGO, lpfc_oas_supported_show,
@@ -6251,9 +6188,6 @@ struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_pt,
 	&dev_attr_txq_hw,
 	&dev_attr_txcmplq_hw,
-	&dev_attr_lpfc_fips_level,
-	&dev_attr_lpfc_fips_rev,
-	&dev_attr_lpfc_dss,
 	&dev_attr_lpfc_sriov_hw_max_virtfn,
 	&dev_attr_protocol,
 	&dev_attr_lpfc_xlane_supported,
@@ -6289,8 +6223,6 @@ struct device_attribute *lpfc_vport_attrs[] = {
 	&dev_attr_lpfc_max_scsicmpl_time,
 	&dev_attr_lpfc_stat_data_ctrl,
 	&dev_attr_lpfc_static_vport,
-	&dev_attr_lpfc_fips_level,
-	&dev_attr_lpfc_fips_rev,
 	NULL,
 };
 
@@ -7399,7 +7331,6 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	lpfc_suppress_link_up_init(phba, lpfc_suppress_link_up);
 	lpfc_delay_discovery_init(phba, lpfc_delay_discovery);
 	lpfc_sli_mode_init(phba, lpfc_sli_mode);
-	phba->cfg_enable_dss = 1;
 	lpfc_enable_mds_diags_init(phba, lpfc_enable_mds_diags);
 	lpfc_ras_fwlog_buffsize_init(phba, lpfc_ras_fwlog_buffsize);
 	lpfc_ras_fwlog_level_init(phba, lpfc_ras_fwlog_level);
diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index ae51c0dbba0a..c20034b3101c 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -3262,8 +3262,7 @@ typedef struct {
 #endif
 
 #ifdef __BIG_ENDIAN_BITFIELD
-	uint32_t rsvd1     : 19;  /* Reserved                             */
-	uint32_t cdss      :  1;  /* Configure Data Security SLI          */
+	uint32_t rsvd1     : 20;  /* Reserved                             */
 	uint32_t casabt    :  1;  /* Configure async abts status notice   */
 	uint32_t rsvd2     :  2;  /* Reserved                             */
 	uint32_t cbg       :  1;  /* Configure BlockGuard                 */
@@ -3287,12 +3286,10 @@ typedef struct {
 	uint32_t cbg       :  1;  /* Configure BlockGuard                 */
 	uint32_t rsvd2     :  2;  /* Reserved                             */
 	uint32_t casabt    :  1;  /* Configure async abts status notice   */
-	uint32_t cdss      :  1;  /* Configure Data Security SLI          */
-	uint32_t rsvd1     : 19;  /* Reserved                             */
+	uint32_t rsvd1     : 20;  /* Reserved                             */
 #endif
 #ifdef __BIG_ENDIAN_BITFIELD
-	uint32_t rsvd3     : 19;  /* Reserved                             */
-	uint32_t gdss      :  1;  /* Configure Data Security SLI          */
+	uint32_t rsvd3     : 20;  /* Reserved                             */
 	uint32_t gasabt    :  1;  /* Grant async abts status notice       */
 	uint32_t rsvd4     :  2;  /* Reserved                             */
 	uint32_t gbg       :  1;  /* Grant BlockGuard                     */
@@ -3316,8 +3313,7 @@ typedef struct {
 	uint32_t gbg       :  1;  /* Grant BlockGuard                     */
 	uint32_t rsvd4     :  2;  /* Reserved                             */
 	uint32_t gasabt    :  1;  /* Grant async abts status notice       */
-	uint32_t gdss      :  1;  /* Configure Data Security SLI          */
-	uint32_t rsvd3     : 19;  /* Reserved                             */
+	uint32_t rsvd3     : 20;  /* Reserved                             */
 #endif
 
 #ifdef __BIG_ENDIAN_BITFIELD
@@ -3339,15 +3335,11 @@ typedef struct {
 	uint32_t rsvd6;           /* Reserved                             */
 
 #ifdef __BIG_ENDIAN_BITFIELD
-	uint32_t fips_rev   : 3;   /* FIPS Spec Revision                   */
-	uint32_t fips_level : 4;   /* FIPS Level                           */
-	uint32_t sec_err    : 9;   /* security crypto error                */
+	uint32_t rsvd7      : 16;
 	uint32_t max_vpi    : 16;  /* Max number of virt N-Ports           */
 #else	/*  __LITTLE_ENDIAN */
 	uint32_t max_vpi    : 16;  /* Max number of virt N-Ports           */
-	uint32_t sec_err    : 9;   /* security crypto error                */
-	uint32_t fips_level : 4;   /* FIPS Level                           */
-	uint32_t fips_rev   : 3;   /* FIPS Spec Revision                   */
+	uint32_t rsvd7      : 16;
 #endif
 
 } CONFIG_PORT_VAR;
diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index d1773c01d2b3..e35b52b66d6c 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -1299,8 +1299,6 @@ lpfc_config_port(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	if (phba->sli_rev == LPFC_SLI_REV3 && phba->vpd.sli3Feat.cerbm) {
 		if (phba->cfg_enable_bg)
 			mb->un.varCfgPort.cbg = 1; /* configure BlockGuard */
-		if (phba->cfg_enable_dss)
-			mb->un.varCfgPort.cdss = 1; /* Configure Security */
 		mb->un.varCfgPort.cerbm = 1; /* Request HBQs */
 		mb->un.varCfgPort.ccrp = 1; /* Command Ring Polling */
 		mb->un.varCfgPort.max_hbq = lpfc_sli_hbq_count();
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 52ccaebd6f2c..b6fb665e6ec4 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -5032,23 +5032,6 @@ lpfc_sli_config_port(struct lpfc_hba *phba, int sli_mode)
 
 		} else
 			phba->max_vpi = 0;
-		phba->fips_level = 0;
-		phba->fips_spec_rev = 0;
-		if (pmb->u.mb.un.varCfgPort.gdss) {
-			phba->sli3_options |= LPFC_SLI3_DSS_ENABLED;
-			phba->fips_level = pmb->u.mb.un.varCfgPort.fips_level;
-			phba->fips_spec_rev = pmb->u.mb.un.varCfgPort.fips_rev;
-			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-					"2850 Security Crypto Active. FIPS x%d "
-					"(Spec Rev: x%d)",
-					phba->fips_level, phba->fips_spec_rev);
-		}
-		if (pmb->u.mb.un.varCfgPort.sec_err) {
-			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
-					"2856 Config Port Security Crypto "
-					"Error: x%x ",
-					pmb->u.mb.un.varCfgPort.sec_err);
-		}
 		if (pmb->u.mb.un.varCfgPort.gerbm)
 			phba->sli3_options |= LPFC_SLI3_HBQ_ENABLED;
 		if (pmb->u.mb.un.varCfgPort.gcrp)
-- 
2.16.4

