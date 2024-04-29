Return-Path: <linux-scsi+bounces-4810-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50278B64F7
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2024 23:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E54283590
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2024 21:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9B190690;
	Mon, 29 Apr 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjk/cwau"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DB1836E9
	for <linux-scsi@vger.kernel.org>; Mon, 29 Apr 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427894; cv=none; b=k9XZxAEbZC6Rq1jhiCnkYV9r6pGuQzpa+khFjO02IZJ7swbJN9/s+ADsJQDhdB2cE7L1ND3GA8GsT46EhESnE6zn0v6L/Q26OSFPToTlhraY4DCW7dFRocnqWXPpbi6I6zub4jNytHgUX/gtDeJFKkfRusjB8kRN+UTTXK7LRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427894; c=relaxed/simple;
	bh=9vB11ExR0bdft+3oB5BLOWVipmVR8K8yLi3Y6yA1g3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5n9zQc7Ey+IDzaoWi/gFYEPEXbSdHS7oyJnEfCvj3PuW32obNOl8RErN1a5jnLXrC5+CCqnkyAwAd4zaFBtq/MgjDrWnP78MJImRmTyXW0WWEdQVyScVKOHmVGfpFhPsZ+DBwnqK/jD72MT4BUz9FX9+lxH4Wu5ko8gZm4xDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fjk/cwau; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c73b33383aso303806b6e.3
        for <linux-scsi@vger.kernel.org>; Mon, 29 Apr 2024 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714427890; x=1715032690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeuPzkDzZvfNidaViPCVIzPfuos+bo73S8jiLn5T5Bs=;
        b=Fjk/cwauuGeZvHLUzHMovRrZx9A35Wr1TL68Z1C65ay7WUWzWeBoM+cZVoOKZPEIPU
         S76FdueQ8XMViwA/07jgMxJ/RGUrFY5phy70tDKOlHRt2lzmhhFYMXnejH/zdEA9BbPv
         pe3EkA66EvdSIGQcOLeaUZgs83A4dS6BF9Aw50sL3/qcGDx1wY146FjgXYSZjGB+Lh7E
         NF1pKB2B/oMJxBkAEywEzTKJRnG2VAhtHAQHD8u1rmIzSllIdVorc5OGoPpNPFYFCLVz
         I+mheOhj2kOhhhGD5O+NRgz8GFqEWcCGKsUMC9YNJ0a32cUMYdDEdTwYB7EPa4IjFqfe
         Dozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427890; x=1715032690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeuPzkDzZvfNidaViPCVIzPfuos+bo73S8jiLn5T5Bs=;
        b=EquzQk4z5vK8EU1WdVvYwNEZGuRjlHOOxruXH8LSUgT+5aKvhHdv5ir6xIIVZ08j5i
         kZ63Lf3tl9jekMpaK+0mNY1NQsChP9C1FL4JqvvMo8bflJeSBQ/no+UjxIxcL3mip+18
         cR7muTzyg7pzZmtGyt4hkyIbdRnyTy0qQLjP0ezGey8SvK8s4YERPtsf1vtJKETR1NEB
         zQo6e7T3RjMbFgGyF0dH9fyj47jQk/MqR5RJ7nTtyPLEVZ8yAF3brM732tQhxLiFN0yS
         lDPzsmiMOTpY4ZLDH82Y7IWfdxE+55ecOUC4uBPo4JHD+nVA4ukBt4pxQ3LCcwu/mQh3
         q5fw==
X-Gm-Message-State: AOJu0Yxs8CjuIQj6H28XHGWtgz+1xydeH25HAVBrg79dCtpxcxiePTBF
	bhYFEFmyPrV9tK5+tQUZ2BqTQqIbNRypXUQe/TuhQ3DjS7wBMVeY8jGOPg==
X-Google-Smtp-Source: AGHT+IGRU//CnUXt4K/9MZSHhB+iiX9JwX6vpQviw2+fgImdh6b8wrEYpF/3AEbNVCD+zVQAQr6ZHA==
X-Received: by 2002:a05:6808:1393:b0:3c8:4cc6:4f0c with SMTP id c19-20020a056808139300b003c84cc64f0cmr14076089oiw.5.1714427888694;
        Mon, 29 Apr 2024 14:58:08 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mh12-20020a056214564c00b006a0cc9ef675sm1528280qvb.16.2024.04.29.14.58.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2024 14:58:08 -0700 (PDT)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart2021@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH 5/8] lpfc: Change lpfc_hba hba_flag member into a bitmask
Date: Mon, 29 Apr 2024 15:15:44 -0700
Message-Id: <20240429221547.6842-6-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20240429221547.6842-1-justintee8345@gmail.com>
References: <20240429221547.6842-1-justintee8345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In attempt to reduce the amount of unnecessary phba->hbalock acquisitions
in the lpfc driver, change hba_flag into an unsigned long bitmask and use
clear_bit/test_bit bitwise atomic APIs instead of reliance on phba->hbalock
for synchronization.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
---
 drivers/scsi/lpfc/lpfc.h           |  61 +++++-----
 drivers/scsi/lpfc/lpfc_attr.c      |  31 ++---
 drivers/scsi/lpfc/lpfc_bsg.c       |   3 +-
 drivers/scsi/lpfc/lpfc_ct.c        |   8 +-
 drivers/scsi/lpfc/lpfc_els.c       |  43 ++++---
 drivers/scsi/lpfc/lpfc_hbadisc.c   | 133 ++++++++++-----------
 drivers/scsi/lpfc/lpfc_init.c      | 107 +++++++----------
 drivers/scsi/lpfc/lpfc_nportdisc.c |   2 +-
 drivers/scsi/lpfc/lpfc_nvme.c      |  27 ++---
 drivers/scsi/lpfc/lpfc_nvmet.c     |   7 +-
 drivers/scsi/lpfc/lpfc_scsi.c      |   8 +-
 drivers/scsi/lpfc/lpfc_sli.c       | 180 ++++++++++++-----------------
 12 files changed, 279 insertions(+), 331 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 44a7155daf61..7c147d6ea8a8 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -393,6 +393,37 @@ enum hba_state {
 	LPFC_HBA_ERROR       =  -1
 };
 
+enum lpfc_hba_flag { /* hba generic flags */
+	HBA_ERATT_HANDLED	= 0, /* This flag is set when eratt handled */
+	DEFER_ERATT		= 1, /* Deferred error attn in progress */
+	HBA_FCOE_MODE		= 2, /* HBA function in FCoE Mode */
+	HBA_SP_QUEUE_EVT	= 3, /* Slow-path qevt posted to worker thread*/
+	HBA_POST_RECEIVE_BUFFER = 4, /* Rcv buffers need to be posted */
+	HBA_PERSISTENT_TOPO	= 5, /* Persistent topology support in hba */
+	ELS_XRI_ABORT_EVENT	= 6, /* ELS_XRI abort event was queued */
+	ASYNC_EVENT		= 7,
+	LINK_DISABLED		= 8, /* Link disabled by user */
+	FCF_TS_INPROG           = 9, /* FCF table scan in progress */
+	FCF_RR_INPROG           = 10, /* FCF roundrobin flogi in progress */
+	HBA_FIP_SUPPORT		= 11, /* FIP support in HBA */
+	HBA_DEVLOSS_TMO         = 13, /* HBA in devloss timeout */
+	HBA_RRQ_ACTIVE		= 14, /* process the rrq active list */
+	HBA_IOQ_FLUSH		= 15, /* I/O queues being flushed */
+	HBA_RECOVERABLE_UE	= 17, /* FW supports recoverable UE */
+	HBA_FORCED_LINK_SPEED	= 18, /*
+				       * Firmware supports Forced Link
+				       * Speed capability
+				       */
+	HBA_FLOGI_ISSUED	= 20, /* FLOGI was issued */
+	HBA_DEFER_FLOGI		= 23, /* Defer FLOGI till read_sparm cmpl */
+	HBA_SETUP		= 24, /* HBA setup completed */
+	HBA_NEEDS_CFG_PORT	= 25, /* SLI3: CONFIG_PORT mbox needed */
+	HBA_HBEAT_INP		= 26, /* mbox HBEAT is in progress */
+	HBA_HBEAT_TMO		= 27, /* HBEAT initiated after timeout */
+	HBA_FLOGI_OUTSTANDING	= 28, /* FLOGI is outstanding */
+	HBA_RHBA_CMPL		= 29, /* RHBA FDMI cmd is successful */
+};
+
 struct lpfc_trunk_link_state {
 	enum hba_state state;
 	uint8_t fault;
@@ -1007,35 +1038,7 @@ struct lpfc_hba {
 #define LS_CT_VEN_RPA         0x20	/* Vendor RPA sent to switch */
 #define LS_EXTERNAL_LOOPBACK  0x40	/* External loopback plug inserted */
 
-	uint32_t hba_flag;	/* hba generic flags */
-#define HBA_ERATT_HANDLED	0x1 /* This flag is set when eratt handled */
-#define DEFER_ERATT		0x2 /* Deferred error attention in progress */
-#define HBA_FCOE_MODE		0x4 /* HBA function in FCoE Mode */
-#define HBA_SP_QUEUE_EVT	0x8 /* Slow-path qevt posted to worker thread*/
-#define HBA_POST_RECEIVE_BUFFER 0x10 /* Rcv buffers need to be posted */
-#define HBA_PERSISTENT_TOPO	0x20 /* Persistent topology support in hba */
-#define ELS_XRI_ABORT_EVENT	0x40 /* ELS_XRI abort event was queued */
-#define ASYNC_EVENT		0x80
-#define LINK_DISABLED		0x100 /* Link disabled by user */
-#define FCF_TS_INPROG           0x200 /* FCF table scan in progress */
-#define FCF_RR_INPROG           0x400 /* FCF roundrobin flogi in progress */
-#define HBA_FIP_SUPPORT		0x800 /* FIP support in HBA */
-#define HBA_DEVLOSS_TMO         0x2000 /* HBA in devloss timeout */
-#define HBA_RRQ_ACTIVE		0x4000 /* process the rrq active list */
-#define HBA_IOQ_FLUSH		0x8000 /* FCP/NVME I/O queues being flushed */
-#define HBA_RECOVERABLE_UE	0x20000 /* Firmware supports recoverable UE */
-#define HBA_FORCED_LINK_SPEED	0x40000 /*
-					 * Firmware supports Forced Link Speed
-					 * capability
-					 */
-#define HBA_FLOGI_ISSUED	0x100000 /* FLOGI was issued */
-#define HBA_DEFER_FLOGI		0x800000 /* Defer FLOGI till read_sparm cmpl */
-#define HBA_SETUP		0x1000000 /* Signifies HBA setup is completed */
-#define HBA_NEEDS_CFG_PORT	0x2000000 /* SLI3 - needs a CONFIG_PORT mbox */
-#define HBA_HBEAT_INP		0x4000000 /* mbox HBEAT is in progress */
-#define HBA_HBEAT_TMO		0x8000000 /* HBEAT initiated after timeout */
-#define HBA_FLOGI_OUTSTANDING	0x10000000 /* FLOGI is outstanding */
-#define HBA_RHBA_CMPL		0x20000000 /* RHBA FDMI command is successful */
+	unsigned long hba_flag;	/* hba generic flags */
 
 	struct completion *fw_dump_cmpl; /* cmpl event tracker for fw_dump */
 	uint32_t fcp_ring_in_use; /* When polling test if intr-hndlr active*/
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 3c534b3cfe91..a46c73e8d7c4 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -322,7 +322,7 @@ lpfc_enable_fip_show(struct device *dev, struct device_attribute *attr,
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
 
-	if (phba->hba_flag & HBA_FIP_SUPPORT)
+	if (test_bit(HBA_FIP_SUPPORT, &phba->hba_flag))
 		return scnprintf(buf, PAGE_SIZE, "1\n");
 	else
 		return scnprintf(buf, PAGE_SIZE, "0\n");
@@ -1049,7 +1049,7 @@ lpfc_link_state_show(struct device *dev, struct device_attribute *attr,
 	case LPFC_INIT_MBX_CMDS:
 	case LPFC_LINK_DOWN:
 	case LPFC_HBA_ERROR:
-		if (phba->hba_flag & LINK_DISABLED)
+		if (test_bit(LINK_DISABLED, &phba->hba_flag))
 			len += scnprintf(buf + len, PAGE_SIZE-len,
 				"Link Down - User disabled\n");
 		else
@@ -1292,7 +1292,7 @@ lpfc_issue_lip(struct Scsi_Host *shost)
 	 * it doesn't make any sense to allow issue_lip
 	 */
 	if (test_bit(FC_OFFLINE_MODE, &vport->fc_flag) ||
-	    (phba->hba_flag & LINK_DISABLED) ||
+	    test_bit(LINK_DISABLED, &phba->hba_flag) ||
 	    (phba->sli.sli_flag & LPFC_BLOCK_MGMT_IO))
 		return -EPERM;
 
@@ -3635,7 +3635,8 @@ lpfc_pt_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct lpfc_hba   *phba = ((struct lpfc_vport *)shost->hostdata)->phba;
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 (phba->hba_flag & HBA_PERSISTENT_TOPO) ? 1 : 0);
+			 test_bit(HBA_PERSISTENT_TOPO,
+				  &phba->hba_flag) ? 1 : 0);
 }
 static DEVICE_ATTR(pt, 0444,
 			 lpfc_pt_show, NULL);
@@ -4205,8 +4206,8 @@ lpfc_topology_store(struct device *dev, struct device_attribute *attr,
 				    &phba->sli4_hba.sli_intf);
 		if_type = bf_get(lpfc_sli_intf_if_type,
 				 &phba->sli4_hba.sli_intf);
-		if ((phba->hba_flag & HBA_PERSISTENT_TOPO ||
-		    (!phba->sli4_hba.pc_sli4_params.pls &&
+		if ((test_bit(HBA_PERSISTENT_TOPO, &phba->hba_flag) ||
+		     (!phba->sli4_hba.pc_sli4_params.pls &&
 		     (sli_family == LPFC_SLI_INTF_FAMILY_G6 ||
 		      if_type == LPFC_SLI_INTF_IF_TYPE_6))) &&
 		    val == 4) {
@@ -4309,7 +4310,7 @@ lpfc_link_speed_store(struct device *dev, struct device_attribute *attr,
 
 	if_type = bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf);
 	if (if_type >= LPFC_SLI_INTF_IF_TYPE_2 &&
-	    phba->hba_flag & HBA_FORCED_LINK_SPEED)
+	    test_bit(HBA_FORCED_LINK_SPEED, &phba->hba_flag))
 		return -EPERM;
 
 	if (!strncmp(buf, "nolip ", strlen("nolip "))) {
@@ -6497,7 +6498,8 @@ lpfc_get_host_speed(struct Scsi_Host *shost)
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
 
-	if ((lpfc_is_link_up(phba)) && (!(phba->hba_flag & HBA_FCOE_MODE))) {
+	if ((lpfc_is_link_up(phba)) &&
+	    !test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		switch(phba->fc_linkspeed) {
 		case LPFC_LINK_SPEED_1GHZ:
 			fc_host_speed(shost) = FC_PORTSPEED_1GBIT;
@@ -6533,7 +6535,8 @@ lpfc_get_host_speed(struct Scsi_Host *shost)
 			fc_host_speed(shost) = FC_PORTSPEED_UNKNOWN;
 			break;
 		}
-	} else if (lpfc_is_link_up(phba) && (phba->hba_flag & HBA_FCOE_MODE)) {
+	} else if (lpfc_is_link_up(phba) &&
+		   test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		switch (phba->fc_linkspeed) {
 		case LPFC_ASYNC_LINK_SPEED_1GBPS:
 			fc_host_speed(shost) = FC_PORTSPEED_1GBIT;
@@ -6718,7 +6721,7 @@ lpfc_get_stats(struct Scsi_Host *shost)
 	hs->invalid_crc_count -= lso->invalid_crc_count;
 	hs->error_frames -= lso->error_frames;
 
-	if (phba->hba_flag & HBA_FCOE_MODE) {
+	if (test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		hs->lip_count = -1;
 		hs->nos_count = (phba->link_events >> 1);
 		hs->nos_count -= lso->link_events;
@@ -6816,7 +6819,7 @@ lpfc_reset_stats(struct Scsi_Host *shost)
 	lso->invalid_tx_word_count = pmb->un.varRdLnk.invalidXmitWord;
 	lso->invalid_crc_count = pmb->un.varRdLnk.crcCnt;
 	lso->error_frames = pmb->un.varRdLnk.crcCnt;
-	if (phba->hba_flag & HBA_FCOE_MODE)
+	if (test_bit(HBA_FCOE_MODE, &phba->hba_flag))
 		lso->link_events = (phba->link_events >> 1);
 	else
 		lso->link_events = (phba->fc_eventTag >> 1);
@@ -7161,11 +7164,11 @@ lpfc_get_hba_function_mode(struct lpfc_hba *phba)
 	case PCI_DEVICE_ID_ZEPHYR_DCSP:
 	case PCI_DEVICE_ID_TIGERSHARK:
 	case PCI_DEVICE_ID_TOMCAT:
-		phba->hba_flag |= HBA_FCOE_MODE;
+		set_bit(HBA_FCOE_MODE, &phba->hba_flag);
 		break;
 	default:
 	/* for others, clear the flag */
-		phba->hba_flag &= ~HBA_FCOE_MODE;
+		clear_bit(HBA_FCOE_MODE, &phba->hba_flag);
 	}
 }
 
@@ -7236,7 +7239,7 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	lpfc_get_hba_function_mode(phba);
 
 	/* BlockGuard allowed for FC only. */
-	if (phba->cfg_enable_bg && phba->hba_flag & HBA_FCOE_MODE) {
+	if (phba->cfg_enable_bg && test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0581 BlockGuard feature not supported\n");
 		/* If set, clear the BlockGuard support param */
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 529df1768fa8..4156419c52c7 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -5002,7 +5002,8 @@ lpfc_forced_link_speed(struct bsg_job *job)
 		goto job_error;
 	}
 
-	forced_reply->supported = (phba->hba_flag & HBA_FORCED_LINK_SPEED)
+	forced_reply->supported = test_bit(HBA_FORCED_LINK_SPEED,
+					   &phba->hba_flag)
 				   ? LPFC_FORCED_LINK_SPEED_SUPPORTED
 				   : LPFC_FORCED_LINK_SPEED_NOT_SUPPORTED;
 job_error:
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 878e3fffdcea..376d0f958b72 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2173,7 +2173,7 @@ lpfc_fdmi_rprt_defer(struct lpfc_hba *phba, uint32_t mask)
 	struct lpfc_nodelist *ndlp;
 	int i;
 
-	phba->hba_flag |= HBA_RHBA_CMPL;
+	set_bit(HBA_RHBA_CMPL, &phba->hba_flag);
 	vports = lpfc_create_vport_work_array(phba);
 	if (vports) {
 		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
@@ -2368,7 +2368,7 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 * for the physical port completes successfully.
 			 * We may have to defer the RPRT accordingly.
 			 */
-			if (phba->hba_flag & HBA_RHBA_CMPL) {
+			if (test_bit(HBA_RHBA_CMPL, &phba->hba_flag)) {
 				lpfc_fdmi_cmd(vport, ndlp, SLI_MGMT_RPRT, 0);
 			} else {
 				lpfc_printf_vlog(vport, KERN_INFO,
@@ -2785,7 +2785,7 @@ lpfc_fdmi_port_attr_support_speed(struct lpfc_vport *vport, void *attr)
 	u32 tcfg;
 	u8 i, cnt;
 
-	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		cnt = 0;
 		if (phba->sli_rev == LPFC_SLI_REV4) {
 			tcfg = phba->sli4_hba.conf_trunk;
@@ -2859,7 +2859,7 @@ lpfc_fdmi_port_attr_speed(struct lpfc_vport *vport, void *attr)
 	struct lpfc_hba   *phba = vport->phba;
 	u32 speeds = 0;
 
-	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		switch (phba->fc_linkspeed) {
 		case LPFC_LINK_SPEED_1GHZ:
 			speeds = HBA_PORTSPEED_1GFC;
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index f7c28dc73bf6..c32bc773ab29 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -189,11 +189,11 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, u8 expect_rsp,
 	 * If this command is for fabric controller and HBA running
 	 * in FIP mode send FLOGI, FDISC and LOGO as FIP frames.
 	 */
-	if ((did == Fabric_DID) &&
-	    (phba->hba_flag & HBA_FIP_SUPPORT) &&
-	    ((elscmd == ELS_CMD_FLOGI) ||
-	     (elscmd == ELS_CMD_FDISC) ||
-	     (elscmd == ELS_CMD_LOGO)))
+	if (did == Fabric_DID &&
+	    test_bit(HBA_FIP_SUPPORT, &phba->hba_flag) &&
+	    (elscmd == ELS_CMD_FLOGI ||
+	     elscmd == ELS_CMD_FDISC ||
+	     elscmd == ELS_CMD_LOGO))
 		switch (elscmd) {
 		case ELS_CMD_FLOGI:
 			elsiocb->cmd_flag |=
@@ -965,7 +965,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * In case of FIP mode, perform roundrobin FCF failover
 		 * due to new FCF discovery
 		 */
-		if ((phba->hba_flag & HBA_FIP_SUPPORT) &&
+		if (test_bit(HBA_FIP_SUPPORT, &phba->hba_flag) &&
 		    (phba->fcf.fcf_flag & FCF_DISCOVERY)) {
 			if (phba->link_state < LPFC_LINK_UP)
 				goto stop_rr_fcf_flogi;
@@ -999,7 +999,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					IOERR_LOOP_OPEN_FAILURE)))
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "2858 FLOGI failure Status:x%x/x%x TMO"
-					 ":x%x Data x%x x%x\n",
+					 ":x%x Data x%lx x%x\n",
 					 ulp_status, ulp_word4, tmo,
 					 phba->hba_flag, phba->fcf.fcf_flag);
 
@@ -1119,7 +1119,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if (sp->cmn.fPort)
 			rc = lpfc_cmpl_els_flogi_fabric(vport, ndlp, sp,
 							ulp_word4);
-		else if (!(phba->hba_flag & HBA_FCOE_MODE))
+		else if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag))
 			rc = lpfc_cmpl_els_flogi_nport(vport, ndlp, sp);
 		else {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
@@ -1149,14 +1149,15 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			lpfc_nlp_put(ndlp);
 			spin_lock_irq(&phba->hbalock);
 			phba->fcf.fcf_flag &= ~FCF_DISCOVERY;
-			phba->hba_flag &= ~(FCF_RR_INPROG | HBA_DEVLOSS_TMO);
 			spin_unlock_irq(&phba->hbalock);
+			clear_bit(FCF_RR_INPROG, &phba->hba_flag);
+			clear_bit(HBA_DEVLOSS_TMO, &phba->hba_flag);
 			phba->fcf.fcf_redisc_attempted = 0; /* reset */
 			goto out;
 		}
 		if (!rc) {
 			/* Mark the FCF discovery process done */
-			if (phba->hba_flag & HBA_FIP_SUPPORT)
+			if (test_bit(HBA_FIP_SUPPORT, &phba->hba_flag))
 				lpfc_printf_vlog(vport, KERN_INFO, LOG_FIP |
 						LOG_ELS,
 						"2769 FLOGI to FCF (x%x) "
@@ -1164,8 +1165,9 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 						phba->fcf.current_rec.fcf_indx);
 			spin_lock_irq(&phba->hbalock);
 			phba->fcf.fcf_flag &= ~FCF_DISCOVERY;
-			phba->hba_flag &= ~(FCF_RR_INPROG | HBA_DEVLOSS_TMO);
 			spin_unlock_irq(&phba->hbalock);
+			clear_bit(FCF_RR_INPROG, &phba->hba_flag);
+			clear_bit(HBA_DEVLOSS_TMO, &phba->hba_flag);
 			phba->fcf.fcf_redisc_attempted = 0; /* reset */
 			goto out;
 		}
@@ -1202,7 +1204,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 out:
 	if (!flogi_in_retry)
-		phba->hba_flag &= ~HBA_FLOGI_OUTSTANDING;
+		clear_bit(HBA_FLOGI_OUTSTANDING, &phba->hba_flag);
 
 	lpfc_els_free_iocb(phba, cmdiocb);
 	lpfc_nlp_put(ndlp);
@@ -1372,11 +1374,13 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	}
 
 	/* Avoid race with FLOGI completion and hba_flags. */
-	phba->hba_flag |= (HBA_FLOGI_ISSUED | HBA_FLOGI_OUTSTANDING);
+	set_bit(HBA_FLOGI_ISSUED, &phba->hba_flag);
+	set_bit(HBA_FLOGI_OUTSTANDING, &phba->hba_flag);
 
 	rc = lpfc_issue_fabric_iocb(phba, elsiocb);
 	if (rc == IOCB_ERROR) {
-		phba->hba_flag &= ~(HBA_FLOGI_ISSUED | HBA_FLOGI_OUTSTANDING);
+		clear_bit(HBA_FLOGI_ISSUED, &phba->hba_flag);
+		clear_bit(HBA_FLOGI_OUTSTANDING, &phba->hba_flag);
 		lpfc_els_free_iocb(phba, elsiocb);
 		lpfc_nlp_put(ndlp);
 		return 1;
@@ -1413,7 +1417,7 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "3354 Xmit deferred FLOGI ACC: rx_id: x%x,"
-				 " ox_id: x%x, hba_flag x%x\n",
+				 " ox_id: x%x, hba_flag x%lx\n",
 				 phba->defer_flogi_acc_rx_id,
 				 phba->defer_flogi_acc_ox_id, phba->hba_flag);
 
@@ -7415,7 +7419,8 @@ lpfc_els_rcv_rdp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		goto error;
 	}
 
-	if (phba->sli_rev < LPFC_SLI_REV4 || (phba->hba_flag & HBA_FCOE_MODE)) {
+	if (phba->sli_rev < LPFC_SLI_REV4 ||
+	    test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		rjt_err = LSRJT_UNABLE_TPC;
 		rjt_expl = LSEXP_REQ_UNSUPPORTED;
 		goto error;
@@ -7738,7 +7743,7 @@ lpfc_els_rcv_lcb(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	}
 
 	if (phba->sli_rev < LPFC_SLI_REV4  ||
-	    phba->hba_flag & HBA_FCOE_MODE ||
+	    test_bit(HBA_FCOE_MODE, &phba->hba_flag) ||
 	    (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) <
 	    LPFC_SLI_INTF_IF_TYPE_2)) {
 		rjt_err = LSRJT_CMD_UNSUPPORTED;
@@ -8443,7 +8448,7 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	memcpy(&phba->fc_fabparam, sp, sizeof(struct serv_parm));
 
 	/* Defer ACC response until AFTER we issue a FLOGI */
-	if (!(phba->hba_flag & HBA_FLOGI_ISSUED)) {
+	if (!test_bit(HBA_FLOGI_ISSUED, &phba->hba_flag)) {
 		phba->defer_flogi_acc_rx_id = bf_get(wqe_ctxt_tag,
 						     &wqe->xmit_els_rsp.wqe_com);
 		phba->defer_flogi_acc_ox_id = bf_get(wqe_rcvoxid,
@@ -8453,7 +8458,7 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "3344 Deferring FLOGI ACC: rx_id: x%x,"
-				 " ox_id: x%x, hba_flag x%x\n",
+				 " ox_id: x%x, hba_flag x%lx\n",
 				 phba->defer_flogi_acc_rx_id,
 				 phba->defer_flogi_acc_ox_id, phba->hba_flag);
 
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index e42fa9c822b5..153770bdc56a 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -487,7 +487,8 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 					recovering = true;
 			} else {
 				/* Physical port path. */
-				if (phba->hba_flag & HBA_FLOGI_OUTSTANDING)
+				if (test_bit(HBA_FLOGI_OUTSTANDING,
+					     &phba->hba_flag))
 					recovering = true;
 			}
 			break;
@@ -652,14 +653,15 @@ lpfc_sli4_post_dev_loss_tmo_handler(struct lpfc_hba *phba, int fcf_inuse,
 	if (!fcf_inuse)
 		return;
 
-	if ((phba->hba_flag & HBA_FIP_SUPPORT) && !lpfc_fcf_inuse(phba)) {
+	if (test_bit(HBA_FIP_SUPPORT, &phba->hba_flag) &&
+	    !lpfc_fcf_inuse(phba)) {
 		spin_lock_irq(&phba->hbalock);
 		if (phba->fcf.fcf_flag & FCF_DISCOVERY) {
-			if (phba->hba_flag & HBA_DEVLOSS_TMO) {
+			if (test_and_set_bit(HBA_DEVLOSS_TMO,
+					     &phba->hba_flag)) {
 				spin_unlock_irq(&phba->hbalock);
 				return;
 			}
-			phba->hba_flag |= HBA_DEVLOSS_TMO;
 			lpfc_printf_log(phba, KERN_INFO, LOG_FIP,
 					"2847 Last remote node (x%x) using "
 					"FCF devloss tmo\n", nlp_did);
@@ -671,8 +673,9 @@ lpfc_sli4_post_dev_loss_tmo_handler(struct lpfc_hba *phba, int fcf_inuse,
 					"in progress\n");
 			return;
 		}
-		if (!(phba->hba_flag & (FCF_TS_INPROG | FCF_RR_INPROG))) {
-			spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->hbalock);
+		if (!test_bit(FCF_TS_INPROG, &phba->hba_flag) &&
+		    !test_bit(FCF_RR_INPROG, &phba->hba_flag)) {
 			lpfc_printf_log(phba, KERN_INFO, LOG_FIP,
 					"2869 Devloss tmo to idle FIP engine, "
 					"unreg in-use FCF and rescan.\n");
@@ -680,11 +683,10 @@ lpfc_sli4_post_dev_loss_tmo_handler(struct lpfc_hba *phba, int fcf_inuse,
 			lpfc_unregister_fcf_rescan(phba);
 			return;
 		}
-		spin_unlock_irq(&phba->hbalock);
-		if (phba->hba_flag & FCF_TS_INPROG)
+		if (test_bit(FCF_TS_INPROG, &phba->hba_flag))
 			lpfc_printf_log(phba, KERN_INFO, LOG_FIP,
 					"2870 FCF table scan in progress\n");
-		if (phba->hba_flag & FCF_RR_INPROG)
+		if (test_bit(FCF_RR_INPROG, &phba->hba_flag))
 			lpfc_printf_log(phba, KERN_INFO, LOG_FIP,
 					"2871 FLOGI roundrobin FCF failover "
 					"in progress\n");
@@ -978,18 +980,15 @@ lpfc_work_done(struct lpfc_hba *phba)
 
 	/* Process SLI4 events */
 	if (phba->pci_dev_grp == LPFC_PCI_DEV_OC) {
-		if (phba->hba_flag & HBA_RRQ_ACTIVE)
+		if (test_bit(HBA_RRQ_ACTIVE, &phba->hba_flag))
 			lpfc_handle_rrq_active(phba);
-		if (phba->hba_flag & ELS_XRI_ABORT_EVENT)
+		if (test_bit(ELS_XRI_ABORT_EVENT, &phba->hba_flag))
 			lpfc_sli4_els_xri_abort_event_proc(phba);
-		if (phba->hba_flag & ASYNC_EVENT)
+		if (test_bit(ASYNC_EVENT, &phba->hba_flag))
 			lpfc_sli4_async_event_proc(phba);
-		if (phba->hba_flag & HBA_POST_RECEIVE_BUFFER) {
-			spin_lock_irq(&phba->hbalock);
-			phba->hba_flag &= ~HBA_POST_RECEIVE_BUFFER;
-			spin_unlock_irq(&phba->hbalock);
+		if (test_and_clear_bit(HBA_POST_RECEIVE_BUFFER,
+				       &phba->hba_flag))
 			lpfc_sli_hbqbuf_add_hbqs(phba, LPFC_ELS_HBQ);
-		}
 		if (phba->fcf.fcf_flag & FCF_REDISC_EVT)
 			lpfc_sli4_fcf_redisc_event_proc(phba);
 	}
@@ -1035,11 +1034,11 @@ lpfc_work_done(struct lpfc_hba *phba)
 	status >>= (4*LPFC_ELS_RING);
 	if (pring && (status & HA_RXMASK ||
 		      pring->flag & LPFC_DEFERRED_RING_EVENT ||
-		      phba->hba_flag & HBA_SP_QUEUE_EVT)) {
+		      test_bit(HBA_SP_QUEUE_EVT, &phba->hba_flag))) {
 		if (pring->flag & LPFC_STOP_IOCB_EVENT) {
 			pring->flag |= LPFC_DEFERRED_RING_EVENT;
 			/* Preserve legacy behavior. */
-			if (!(phba->hba_flag & HBA_SP_QUEUE_EVT))
+			if (!test_bit(HBA_SP_QUEUE_EVT, &phba->hba_flag))
 				set_bit(LPFC_DATA_READY, &phba->data_flags);
 		} else {
 			/* Driver could have abort request completed in queue
@@ -1420,7 +1419,8 @@ lpfc_linkup(struct lpfc_hba *phba)
 	spin_unlock_irq(shost->host_lock);
 
 	/* reinitialize initial HBA flag */
-	phba->hba_flag &= ~(HBA_FLOGI_ISSUED | HBA_RHBA_CMPL);
+	clear_bit(HBA_FLOGI_ISSUED, &phba->hba_flag);
+	clear_bit(HBA_RHBA_CMPL, &phba->hba_flag);
 
 	return 0;
 }
@@ -1505,7 +1505,7 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	/* don't perform discovery for SLI4 loopback diagnostic test */
 	if ((phba->sli_rev == LPFC_SLI_REV4) &&
-	    !(phba->hba_flag & HBA_FCOE_MODE) &&
+	    !test_bit(HBA_FCOE_MODE, &phba->hba_flag) &&
 	    (phba->link_flag & LS_LOOPBACK_MODE))
 		return;
 
@@ -1548,7 +1548,7 @@ lpfc_mbx_cmpl_local_config_link(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 				goto sparam_out;
 			}
 
-			phba->hba_flag |= HBA_DEFER_FLOGI;
+			set_bit(HBA_DEFER_FLOGI, &phba->hba_flag);
 		}  else {
 			lpfc_initial_flogi(vport);
 		}
@@ -1617,27 +1617,23 @@ lpfc_mbx_cmpl_reg_fcfi(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	spin_unlock_irq(&phba->hbalock);
 
 	/* If there is a pending FCoE event, restart FCF table scan. */
-	if ((!(phba->hba_flag & FCF_RR_INPROG)) &&
-		lpfc_check_pending_fcoe_event(phba, LPFC_UNREG_FCF))
+	if (!test_bit(FCF_RR_INPROG, &phba->hba_flag) &&
+	    lpfc_check_pending_fcoe_event(phba, LPFC_UNREG_FCF))
 		goto fail_out;
 
 	/* Mark successful completion of FCF table scan */
 	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag |= (FCF_SCAN_DONE | FCF_IN_USE);
-	phba->hba_flag &= ~FCF_TS_INPROG;
+	spin_unlock_irq(&phba->hbalock);
+	clear_bit(FCF_TS_INPROG, &phba->hba_flag);
 	if (vport->port_state != LPFC_FLOGI) {
-		phba->hba_flag |= FCF_RR_INPROG;
-		spin_unlock_irq(&phba->hbalock);
+		set_bit(FCF_RR_INPROG, &phba->hba_flag);
 		lpfc_issue_init_vfi(vport);
-		goto out;
 	}
-	spin_unlock_irq(&phba->hbalock);
 	goto out;
 
 fail_out:
-	spin_lock_irq(&phba->hbalock);
-	phba->hba_flag &= ~FCF_RR_INPROG;
-	spin_unlock_irq(&phba->hbalock);
+	clear_bit(FCF_RR_INPROG, &phba->hba_flag);
 out:
 	mempool_free(mboxq, phba->mbox_mem_pool);
 }
@@ -1867,32 +1863,31 @@ lpfc_register_fcf(struct lpfc_hba *phba)
 	spin_lock_irq(&phba->hbalock);
 	/* If the FCF is not available do nothing. */
 	if (!(phba->fcf.fcf_flag & FCF_AVAILABLE)) {
-		phba->hba_flag &= ~(FCF_TS_INPROG | FCF_RR_INPROG);
 		spin_unlock_irq(&phba->hbalock);
+		clear_bit(FCF_TS_INPROG, &phba->hba_flag);
+		clear_bit(FCF_RR_INPROG, &phba->hba_flag);
 		return;
 	}
 
 	/* The FCF is already registered, start discovery */
 	if (phba->fcf.fcf_flag & FCF_REGISTERED) {
 		phba->fcf.fcf_flag |= (FCF_SCAN_DONE | FCF_IN_USE);
-		phba->hba_flag &= ~FCF_TS_INPROG;
+		spin_unlock_irq(&phba->hbalock);
+		clear_bit(FCF_TS_INPROG, &phba->hba_flag);
 		if (phba->pport->port_state != LPFC_FLOGI &&
 		    test_bit(FC_FABRIC, &phba->pport->fc_flag)) {
-			phba->hba_flag |= FCF_RR_INPROG;
-			spin_unlock_irq(&phba->hbalock);
+			set_bit(FCF_RR_INPROG, &phba->hba_flag);
 			lpfc_initial_flogi(phba->pport);
 			return;
 		}
-		spin_unlock_irq(&phba->hbalock);
 		return;
 	}
 	spin_unlock_irq(&phba->hbalock);
 
 	fcf_mbxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!fcf_mbxq) {
-		spin_lock_irq(&phba->hbalock);
-		phba->hba_flag &= ~(FCF_TS_INPROG | FCF_RR_INPROG);
-		spin_unlock_irq(&phba->hbalock);
+		clear_bit(FCF_TS_INPROG, &phba->hba_flag);
+		clear_bit(FCF_RR_INPROG, &phba->hba_flag);
 		return;
 	}
 
@@ -1901,9 +1896,8 @@ lpfc_register_fcf(struct lpfc_hba *phba)
 	fcf_mbxq->mbox_cmpl = lpfc_mbx_cmpl_reg_fcfi;
 	rc = lpfc_sli_issue_mbox(phba, fcf_mbxq, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED) {
-		spin_lock_irq(&phba->hbalock);
-		phba->hba_flag &= ~(FCF_TS_INPROG | FCF_RR_INPROG);
-		spin_unlock_irq(&phba->hbalock);
+		clear_bit(FCF_TS_INPROG, &phba->hba_flag);
+		clear_bit(FCF_RR_INPROG, &phba->hba_flag);
 		mempool_free(fcf_mbxq, phba->mbox_mem_pool);
 	}
 
@@ -1956,7 +1950,7 @@ lpfc_match_fcf_conn_list(struct lpfc_hba *phba,
 	    bf_get(lpfc_fcf_record_fcf_sol, new_fcf_record))
 		return 0;
 
-	if (!(phba->hba_flag & HBA_FIP_SUPPORT)) {
+	if (!test_bit(HBA_FIP_SUPPORT, &phba->hba_flag)) {
 		*boot_flag = 0;
 		*addr_mode = bf_get(lpfc_fcf_record_mac_addr_prov,
 				new_fcf_record);
@@ -2151,8 +2145,9 @@ lpfc_check_pending_fcoe_event(struct lpfc_hba *phba, uint8_t unreg_fcf)
 		lpfc_printf_log(phba, KERN_INFO, LOG_FIP | LOG_DISCOVERY,
 				"2833 Stop FCF discovery process due to link "
 				"state change (x%x)\n", phba->link_state);
+		clear_bit(FCF_TS_INPROG, &phba->hba_flag);
+		clear_bit(FCF_RR_INPROG, &phba->hba_flag);
 		spin_lock_irq(&phba->hbalock);
-		phba->hba_flag &= ~(FCF_TS_INPROG | FCF_RR_INPROG);
 		phba->fcf.fcf_flag &= ~(FCF_REDISC_FOV | FCF_DISCOVERY);
 		spin_unlock_irq(&phba->hbalock);
 	}
@@ -2380,9 +2375,7 @@ int lpfc_sli4_fcf_rr_next_proc(struct lpfc_vport *vport, uint16_t fcf_index)
 	int rc;
 
 	if (fcf_index == LPFC_FCOE_FCF_NEXT_NONE) {
-		spin_lock_irq(&phba->hbalock);
-		if (phba->hba_flag & HBA_DEVLOSS_TMO) {
-			spin_unlock_irq(&phba->hbalock);
+		if (test_bit(HBA_DEVLOSS_TMO, &phba->hba_flag)) {
 			lpfc_printf_log(phba, KERN_INFO, LOG_FIP,
 					"2872 Devloss tmo with no eligible "
 					"FCF, unregister in-use FCF (x%x) "
@@ -2392,8 +2385,9 @@ int lpfc_sli4_fcf_rr_next_proc(struct lpfc_vport *vport, uint16_t fcf_index)
 			goto stop_flogi_current_fcf;
 		}
 		/* Mark the end to FLOGI roundrobin failover */
-		phba->hba_flag &= ~FCF_RR_INPROG;
+		clear_bit(FCF_RR_INPROG, &phba->hba_flag);
 		/* Allow action to new fcf asynchronous event */
+		spin_lock_irq(&phba->hbalock);
 		phba->fcf.fcf_flag &= ~(FCF_AVAILABLE | FCF_SCAN_DONE);
 		spin_unlock_irq(&phba->hbalock);
 		lpfc_printf_log(phba, KERN_INFO, LOG_FIP,
@@ -2630,9 +2624,7 @@ lpfc_mbx_cmpl_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 				"2765 Mailbox command READ_FCF_RECORD "
 				"failed to retrieve a FCF record.\n");
 		/* Let next new FCF event trigger fast failover */
-		spin_lock_irq(&phba->hbalock);
-		phba->hba_flag &= ~FCF_TS_INPROG;
-		spin_unlock_irq(&phba->hbalock);
+		clear_bit(FCF_TS_INPROG, &phba->hba_flag);
 		lpfc_sli4_mbox_cmd_free(phba, mboxq);
 		return;
 	}
@@ -2873,10 +2865,10 @@ lpfc_mbx_cmpl_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 					       phba->fcoe_eventtag_at_fcf_scan,
 					       bf_get(lpfc_fcf_record_fcf_index,
 						      new_fcf_record));
-				spin_lock_irq(&phba->hbalock);
-				if (phba->hba_flag & HBA_DEVLOSS_TMO) {
-					phba->hba_flag &= ~FCF_TS_INPROG;
-					spin_unlock_irq(&phba->hbalock);
+				if (test_bit(HBA_DEVLOSS_TMO,
+					     &phba->hba_flag)) {
+					clear_bit(FCF_TS_INPROG,
+						  &phba->hba_flag);
 					/* Unregister in-use FCF and rescan */
 					lpfc_printf_log(phba, KERN_INFO,
 							LOG_FIP,
@@ -2889,8 +2881,7 @@ lpfc_mbx_cmpl_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 				/*
 				 * Let next new FCF event trigger fast failover
 				 */
-				phba->hba_flag &= ~FCF_TS_INPROG;
-				spin_unlock_irq(&phba->hbalock);
+				clear_bit(FCF_TS_INPROG, &phba->hba_flag);
 				return;
 			}
 			/*
@@ -2996,8 +2987,8 @@ lpfc_mbx_cmpl_fcf_rr_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 	if (phba->link_state < LPFC_LINK_UP) {
 		spin_lock_irq(&phba->hbalock);
 		phba->fcf.fcf_flag &= ~FCF_DISCOVERY;
-		phba->hba_flag &= ~FCF_RR_INPROG;
 		spin_unlock_irq(&phba->hbalock);
+		clear_bit(FCF_RR_INPROG, &phba->hba_flag);
 		goto out;
 	}
 
@@ -3008,7 +2999,7 @@ lpfc_mbx_cmpl_fcf_rr_read_fcf_rec(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 		lpfc_printf_log(phba, KERN_WARNING, LOG_FIP,
 				"2766 Mailbox command READ_FCF_RECORD "
 				"failed to retrieve a FCF record. "
-				"hba_flg x%x fcf_flg x%x\n", phba->hba_flag,
+				"hba_flg x%lx fcf_flg x%x\n", phba->hba_flag,
 				phba->fcf.fcf_flag);
 		lpfc_unregister_fcf_rescan(phba);
 		goto out;
@@ -3471,9 +3462,9 @@ lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	/* Check if sending the FLOGI is being deferred to after we get
 	 * up to date CSPs from MBX_READ_SPARAM.
 	 */
-	if (phba->hba_flag & HBA_DEFER_FLOGI) {
+	if (test_bit(HBA_DEFER_FLOGI, &phba->hba_flag)) {
 		lpfc_initial_flogi(vport);
-		phba->hba_flag &= ~HBA_DEFER_FLOGI;
+		clear_bit(HBA_DEFER_FLOGI, &phba->hba_flag);
 	}
 	return;
 
@@ -3495,7 +3486,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	phba->fc_linkspeed = bf_get(lpfc_mbx_read_top_link_spd, la);
 
-	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		switch (bf_get(lpfc_mbx_read_top_link_spd, la)) {
 		case LPFC_LINK_SPEED_1GHZ:
 		case LPFC_LINK_SPEED_2GHZ:
@@ -3611,7 +3602,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 		goto out;
 	}
 
-	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		cfglink_mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 		if (!cfglink_mbox)
 			goto out;
@@ -3631,7 +3622,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 		 * is phase 1 implementation that support FCF index 0 and driver
 		 * defaults.
 		 */
-		if (!(phba->hba_flag & HBA_FIP_SUPPORT)) {
+		if (!test_bit(HBA_FIP_SUPPORT, &phba->hba_flag)) {
 			fcf_record = kzalloc(sizeof(struct fcf_record),
 					GFP_KERNEL);
 			if (unlikely(!fcf_record)) {
@@ -3661,12 +3652,10 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 		 * The driver is expected to do FIP/FCF. Call the port
 		 * and get the FCF Table.
 		 */
-		spin_lock_irqsave(&phba->hbalock, iflags);
-		if (phba->hba_flag & FCF_TS_INPROG) {
-			spin_unlock_irqrestore(&phba->hbalock, iflags);
+		if (test_bit(FCF_TS_INPROG, &phba->hba_flag))
 			return;
-		}
 		/* This is the initial FCF discovery scan */
+		spin_lock_irqsave(&phba->hbalock, iflags);
 		phba->fcf.fcf_flag |= FCF_INIT_DISC;
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 		lpfc_printf_log(phba, KERN_INFO, LOG_FIP | LOG_DISCOVERY,
@@ -6997,11 +6986,11 @@ lpfc_unregister_unused_fcf(struct lpfc_hba *phba)
 	 * registered, do nothing.
 	 */
 	spin_lock_irq(&phba->hbalock);
-	if (!(phba->hba_flag & HBA_FCOE_MODE) ||
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag) ||
 	    !(phba->fcf.fcf_flag & FCF_REGISTERED) ||
-	    !(phba->hba_flag & HBA_FIP_SUPPORT) ||
+	    !test_bit(HBA_FIP_SUPPORT, &phba->hba_flag) ||
 	    (phba->fcf.fcf_flag & FCF_DISCOVERY) ||
-	    (phba->pport->port_state == LPFC_FLOGI)) {
+	    phba->pport->port_state == LPFC_FLOGI) {
 		spin_unlock_irq(&phba->hbalock);
 		return;
 	}
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index bd8f97cab2c6..10e8b8479ad9 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -567,7 +567,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 
 	spin_lock_irq(&phba->hbalock);
 	/* Initialize ERATT handling flag */
-	phba->hba_flag &= ~HBA_ERATT_HANDLED;
+	clear_bit(HBA_ERATT_HANDLED, &phba->hba_flag);
 
 	/* Enable appropriate host interrupts */
 	if (lpfc_readl(phba->HCregaddr, &status)) {
@@ -599,13 +599,14 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 	/* Set up heart beat (HB) timer */
 	mod_timer(&phba->hb_tmofunc,
 		  jiffies + msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
-	phba->hba_flag &= ~(HBA_HBEAT_INP | HBA_HBEAT_TMO);
+	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
+	clear_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 	phba->last_completion_time = jiffies;
 	/* Set up error attention (ERATT) polling timer */
 	mod_timer(&phba->eratt_poll,
 		  jiffies + msecs_to_jiffies(1000 * phba->eratt_poll_interval));
 
-	if (phba->hba_flag & LINK_DISABLED) {
+	if (test_bit(LINK_DISABLED, &phba->hba_flag)) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"2598 Adapter Link is disabled.\n");
 		lpfc_down_link(phba, pmb);
@@ -925,9 +926,7 @@ lpfc_sli4_free_sp_events(struct lpfc_hba *phba)
 	struct hbq_dmabuf *dmabuf;
 	struct lpfc_cq_event *cq_event;
 
-	spin_lock_irq(&phba->hbalock);
-	phba->hba_flag &= ~HBA_SP_QUEUE_EVT;
-	spin_unlock_irq(&phba->hbalock);
+	clear_bit(HBA_SP_QUEUE_EVT, &phba->hba_flag);
 
 	while (!list_empty(&phba->sli4_hba.sp_queue_event)) {
 		/* Get the response iocb from the head of work queue */
@@ -1228,18 +1227,15 @@ static void
 lpfc_rrq_timeout(struct timer_list *t)
 {
 	struct lpfc_hba *phba;
-	unsigned long iflag;
 
 	phba = from_timer(phba, t, rrq_tmr);
-	spin_lock_irqsave(&phba->pport->work_port_lock, iflag);
-	if (!test_bit(FC_UNLOADING, &phba->pport->load_flag))
-		phba->hba_flag |= HBA_RRQ_ACTIVE;
-	else
-		phba->hba_flag &= ~HBA_RRQ_ACTIVE;
-	spin_unlock_irqrestore(&phba->pport->work_port_lock, iflag);
+	if (test_bit(FC_UNLOADING, &phba->pport->load_flag)) {
+		clear_bit(HBA_RRQ_ACTIVE, &phba->hba_flag);
+		return;
+	}
 
-	if (!test_bit(FC_UNLOADING, &phba->pport->load_flag))
-		lpfc_worker_wake_up(phba);
+	set_bit(HBA_RRQ_ACTIVE, &phba->hba_flag);
+	lpfc_worker_wake_up(phba);
 }
 
 /**
@@ -1261,11 +1257,8 @@ lpfc_rrq_timeout(struct timer_list *t)
 static void
 lpfc_hb_mbox_cmpl(struct lpfc_hba * phba, LPFC_MBOXQ_t * pmboxq)
 {
-	unsigned long drvr_flag;
-
-	spin_lock_irqsave(&phba->hbalock, drvr_flag);
-	phba->hba_flag &= ~(HBA_HBEAT_INP | HBA_HBEAT_TMO);
-	spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
+	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
+	clear_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 
 	/* Check and reset heart-beat timer if necessary */
 	mempool_free(pmboxq, phba->mbox_mem_pool);
@@ -1457,7 +1450,7 @@ lpfc_issue_hb_mbox(struct lpfc_hba *phba)
 	int retval;
 
 	/* Is a Heartbeat mbox already in progress */
-	if (phba->hba_flag & HBA_HBEAT_INP)
+	if (test_bit(HBA_HBEAT_INP, &phba->hba_flag))
 		return 0;
 
 	pmboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
@@ -1473,7 +1466,7 @@ lpfc_issue_hb_mbox(struct lpfc_hba *phba)
 		mempool_free(pmboxq, phba->mbox_mem_pool);
 		return -ENXIO;
 	}
-	phba->hba_flag |= HBA_HBEAT_INP;
+	set_bit(HBA_HBEAT_INP, &phba->hba_flag);
 
 	return 0;
 }
@@ -1493,7 +1486,7 @@ lpfc_issue_hb_tmo(struct lpfc_hba *phba)
 {
 	if (phba->cfg_enable_hba_heartbeat)
 		return;
-	phba->hba_flag |= HBA_HBEAT_TMO;
+	set_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 }
 
 /**
@@ -1565,7 +1558,7 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 				msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL),
 				jiffies)) {
 			spin_unlock_irq(&phba->pport->work_port_lock);
-			if (phba->hba_flag & HBA_HBEAT_INP)
+			if (test_bit(HBA_HBEAT_INP, &phba->hba_flag))
 				tmo = (1000 * LPFC_HB_MBOX_TIMEOUT);
 			else
 				tmo = (1000 * LPFC_HB_MBOX_INTERVAL);
@@ -1574,7 +1567,7 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 		spin_unlock_irq(&phba->pport->work_port_lock);
 
 		/* Check if a MBX_HEARTBEAT is already in progress */
-		if (phba->hba_flag & HBA_HBEAT_INP) {
+		if (test_bit(HBA_HBEAT_INP, &phba->hba_flag)) {
 			/*
 			 * If heart beat timeout called with HBA_HBEAT_INP set
 			 * we need to give the hb mailbox cmd a chance to
@@ -1611,7 +1604,7 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 		}
 	} else {
 		/* Check to see if we want to force a MBX_HEARTBEAT */
-		if (phba->hba_flag & HBA_HBEAT_TMO) {
+		if (test_bit(HBA_HBEAT_TMO, &phba->hba_flag)) {
 			retval = lpfc_issue_hb_mbox(phba);
 			if (retval)
 				tmo = (1000 * LPFC_HB_MBOX_INTERVAL);
@@ -1699,9 +1692,7 @@ lpfc_handle_deferred_eratt(struct lpfc_hba *phba)
 	 * since we cannot communicate with the pci card anyway.
 	 */
 	if (pci_channel_offline(phba->pcidev)) {
-		spin_lock_irq(&phba->hbalock);
-		phba->hba_flag &= ~DEFER_ERATT;
-		spin_unlock_irq(&phba->hbalock);
+		clear_bit(DEFER_ERATT, &phba->hba_flag);
 		return;
 	}
 
@@ -1752,9 +1743,7 @@ lpfc_handle_deferred_eratt(struct lpfc_hba *phba)
 	if (!phba->work_hs && !test_bit(FC_UNLOADING, &phba->pport->load_flag))
 		phba->work_hs = old_host_status & ~HS_FFER1;
 
-	spin_lock_irq(&phba->hbalock);
-	phba->hba_flag &= ~DEFER_ERATT;
-	spin_unlock_irq(&phba->hbalock);
+	clear_bit(DEFER_ERATT, &phba->hba_flag);
 	phba->work_status[0] = readl(phba->MBslimaddr + 0xa8);
 	phba->work_status[1] = readl(phba->MBslimaddr + 0xac);
 }
@@ -1798,9 +1787,7 @@ lpfc_handle_eratt_s3(struct lpfc_hba *phba)
 	 * since we cannot communicate with the pci card anyway.
 	 */
 	if (pci_channel_offline(phba->pcidev)) {
-		spin_lock_irq(&phba->hbalock);
-		phba->hba_flag &= ~DEFER_ERATT;
-		spin_unlock_irq(&phba->hbalock);
+		clear_bit(DEFER_ERATT, &phba->hba_flag);
 		return;
 	}
 
@@ -1811,7 +1798,7 @@ lpfc_handle_eratt_s3(struct lpfc_hba *phba)
 	/* Send an internal error event to mgmt application */
 	lpfc_board_errevt_to_mgmt(phba);
 
-	if (phba->hba_flag & DEFER_ERATT)
+	if (test_bit(DEFER_ERATT, &phba->hba_flag))
 		lpfc_handle_deferred_eratt(phba);
 
 	if ((phba->work_hs & HS_FFER6) || (phba->work_hs & HS_FFER8)) {
@@ -2026,7 +2013,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 		/* consider PCI bus read error as pci_channel_offline */
 		if (pci_rd_rc1 == -EIO && pci_rd_rc2 == -EIO)
 			return;
-		if (!(phba->hba_flag & HBA_RECOVERABLE_UE)) {
+		if (!test_bit(HBA_RECOVERABLE_UE, &phba->hba_flag)) {
 			lpfc_sli4_offline_eratt(phba);
 			return;
 		}
@@ -3319,9 +3306,10 @@ lpfc_stop_hba_timers(struct lpfc_hba *phba)
 	del_timer_sync(&phba->hb_tmofunc);
 	if (phba->sli_rev == LPFC_SLI_REV4) {
 		del_timer_sync(&phba->rrq_tmr);
-		phba->hba_flag &= ~HBA_RRQ_ACTIVE;
+		clear_bit(HBA_RRQ_ACTIVE, &phba->hba_flag);
 	}
-	phba->hba_flag &= ~(HBA_HBEAT_INP | HBA_HBEAT_TMO);
+	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
+	clear_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 
 	switch (phba->pci_dev_grp) {
 	case LPFC_PCI_DEV_LP:
@@ -4976,7 +4964,7 @@ static void lpfc_host_supported_speeds_set(struct Scsi_Host *shost)
 	 * Avoid reporting supported link speed for FCoE as it can't be
 	 * controlled via FCoE.
 	 */
-	if (phba->hba_flag & HBA_FCOE_MODE)
+	if (test_bit(HBA_FCOE_MODE, &phba->hba_flag))
 		return;
 
 	if (phba->lmt & LMT_256Gb)
@@ -5490,7 +5478,7 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 	 * For FC Mode: issue the READ_TOPOLOGY mailbox command to fetch
 	 * topology info. Note: Optional for non FC-AL ports.
 	 */
-	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
 		if (rc == MBX_NOT_FINISHED)
 			goto out_free_pmb;
@@ -6025,7 +6013,7 @@ lpfc_cmf_timer(struct hrtimer *timer)
 	 */
 	if (phba->cmf_active_mode == LPFC_CFG_MANAGED &&
 	    phba->link_state != LPFC_LINK_DOWN &&
-	    phba->hba_flag & HBA_SETUP) {
+	    test_bit(HBA_SETUP, &phba->hba_flag)) {
 		mbpi = phba->cmf_last_sync_bw;
 		phba->cmf_last_sync_bw = 0;
 		extra = 0;
@@ -6778,11 +6766,9 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 		}
 
 		/* If the FCF discovery is in progress, do nothing. */
-		spin_lock_irq(&phba->hbalock);
-		if (phba->hba_flag & FCF_TS_INPROG) {
-			spin_unlock_irq(&phba->hbalock);
+		if (test_bit(FCF_TS_INPROG, &phba->hba_flag))
 			break;
-		}
+		spin_lock_irq(&phba->hbalock);
 		/* If fast FCF failover rescan event is pending, do nothing */
 		if (phba->fcf.fcf_flag & (FCF_REDISC_EVT | FCF_REDISC_PEND)) {
 			spin_unlock_irq(&phba->hbalock);
@@ -7321,9 +7307,7 @@ void lpfc_sli4_async_event_proc(struct lpfc_hba *phba)
 	unsigned long iflags;
 
 	/* First, declare the async event has been handled */
-	spin_lock_irqsave(&phba->hbalock, iflags);
-	phba->hba_flag &= ~ASYNC_EVENT;
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
+	clear_bit(ASYNC_EVENT, &phba->hba_flag);
 
 	/* Now, handle all the async events */
 	spin_lock_irqsave(&phba->sli4_hba.asynce_list_lock, iflags);
@@ -9869,41 +9853,38 @@ lpfc_map_topology(struct lpfc_hba *phba, struct lpfc_mbx_read_config *rd_config)
 		return;
 	}
 	/* FW supports persistent topology - override module parameter value */
-	phba->hba_flag |= HBA_PERSISTENT_TOPO;
+	set_bit(HBA_PERSISTENT_TOPO, &phba->hba_flag);
 
 	/* if ASIC_GEN_NUM >= 0xC) */
 	if ((bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) ==
 		    LPFC_SLI_INTF_IF_TYPE_6) ||
 	    (bf_get(lpfc_sli_intf_sli_family, &phba->sli4_hba.sli_intf) ==
 		    LPFC_SLI_INTF_FAMILY_G6)) {
-		if (!tf) {
+		if (!tf)
 			phba->cfg_topology = ((pt == LINK_FLAGS_LOOP)
 					? FLAGS_TOPOLOGY_MODE_LOOP
 					: FLAGS_TOPOLOGY_MODE_PT_PT);
-		} else {
-			phba->hba_flag &= ~HBA_PERSISTENT_TOPO;
-		}
+		else
+			clear_bit(HBA_PERSISTENT_TOPO, &phba->hba_flag);
 	} else { /* G5 */
-		if (tf) {
+		if (tf)
 			/* If topology failover set - pt is '0' or '1' */
 			phba->cfg_topology = (pt ? FLAGS_TOPOLOGY_MODE_PT_LOOP :
 					      FLAGS_TOPOLOGY_MODE_LOOP_PT);
-		} else {
+		else
 			phba->cfg_topology = ((pt == LINK_FLAGS_P2P)
 					? FLAGS_TOPOLOGY_MODE_PT_PT
 					: FLAGS_TOPOLOGY_MODE_LOOP);
-		}
 	}
-	if (phba->hba_flag & HBA_PERSISTENT_TOPO) {
+	if (test_bit(HBA_PERSISTENT_TOPO, &phba->hba_flag))
 		lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 				"2020 Using persistent topology value [%s]",
 				lpfc_topo_to_str[phba->cfg_topology]);
-	} else {
+	else
 		lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
 				"2021 Invalid topology values from FW "
 				"Using driver parameter defined value [%s]",
 				lpfc_topo_to_str[phba->cfg_topology]);
-	}
 }
 
 /**
@@ -10146,7 +10127,7 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 		forced_link_speed =
 			bf_get(lpfc_mbx_rd_conf_link_speed, rd_config);
 		if (forced_link_speed) {
-			phba->hba_flag |= HBA_FORCED_LINK_SPEED;
+			set_bit(HBA_FORCED_LINK_SPEED, &phba->hba_flag);
 
 			switch (forced_link_speed) {
 			case LINK_SPEED_1G:
@@ -12241,7 +12222,7 @@ lpfc_sli_enable_intr(struct lpfc_hba *phba, uint32_t cfg_mode)
 	retval = lpfc_sli_config_port(phba, LPFC_SLI_REV3);
 	if (retval)
 		return intr_mode;
-	phba->hba_flag &= ~HBA_NEEDS_CFG_PORT;
+	clear_bit(HBA_NEEDS_CFG_PORT, &phba->hba_flag);
 
 	if (cfg_mode == 2) {
 		/* Now, try to enable MSI-X interrupt mode */
@@ -15529,7 +15510,7 @@ lpfc_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 	pci_ers_result_t rc = PCI_ERS_RESULT_DISCONNECT;
 
 	if (phba->link_state == LPFC_HBA_ERROR &&
-	    phba->hba_flag & HBA_IOQ_FLUSH)
+	    test_bit(HBA_IOQ_FLUSH, &phba->hba_flag))
 		return PCI_ERS_RESULT_NEED_RESET;
 
 	switch (phba->pci_dev_grp) {
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index b24fabbf20c4..f6a53446e57f 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -504,7 +504,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		 * must have ACCed the remote NPorts FLOGI to us
 		 * to make it here.
 		 */
-		if (phba->hba_flag & HBA_FLOGI_OUTSTANDING)
+		if (test_bit(HBA_FLOGI_OUTSTANDING, &phba->hba_flag))
 			lpfc_els_abort_flogi(phba);
 
 		ed_tov = be32_to_cpu(sp->cmn.e_d_tov);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index c5792eaf3f64..d70da2736c94 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -95,7 +95,7 @@ lpfc_nvme_create_queue(struct nvme_fc_local_port *pnvme_lport,
 	vport = lport->vport;
 
 	if (!vport || test_bit(FC_UNLOADING, &vport->load_flag) ||
-	    vport->phba->hba_flag & HBA_IOQ_FLUSH)
+	    test_bit(HBA_IOQ_FLUSH, &vport->phba->hba_flag))
 		return -ENODEV;
 
 	qhandle = kzalloc(sizeof(struct lpfc_nvme_qhandle), GFP_KERNEL);
@@ -272,7 +272,7 @@ lpfc_nvme_handle_lsreq(struct lpfc_hba *phba,
 
 	remoteport = lpfc_rport->remoteport;
 	if (!vport->localport ||
-	    vport->phba->hba_flag & HBA_IOQ_FLUSH)
+	    test_bit(HBA_IOQ_FLUSH, &vport->phba->hba_flag))
 		return -EINVAL;
 
 	lport = vport->localport->private;
@@ -569,7 +569,7 @@ __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				 ndlp->nlp_DID, ntype, nstate);
 		return -ENODEV;
 	}
-	if (vport->phba->hba_flag & HBA_IOQ_FLUSH)
+	if (test_bit(HBA_IOQ_FLUSH, &vport->phba->hba_flag))
 		return -ENODEV;
 
 	if (!vport->phba->sli4_hba.nvmels_wq)
@@ -675,7 +675,7 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
 
 	vport = lport->vport;
 	if (test_bit(FC_UNLOADING, &vport->load_flag) ||
-	    vport->phba->hba_flag & HBA_IOQ_FLUSH)
+	    test_bit(HBA_IOQ_FLUSH, &vport->phba->hba_flag))
 		return -ENODEV;
 
 	atomic_inc(&lport->fc4NvmeLsRequests);
@@ -1568,7 +1568,7 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 	phba = vport->phba;
 
 	if ((unlikely(test_bit(FC_UNLOADING, &vport->load_flag))) ||
-	    phba->hba_flag & HBA_IOQ_FLUSH) {
+	    test_bit(HBA_IOQ_FLUSH, &phba->hba_flag)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_IOERR,
 				 "6124 Fail IO, Driver unload\n");
 		atomic_inc(&lport->xmt_fcp_err);
@@ -1909,24 +1909,19 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 		return;
 	}
 
-	/* Guard against IO completion being called at same time */
-	spin_lock_irqsave(&lpfc_nbuf->buf_lock, flags);
-
-	/* If the hba is getting reset, this flag is set.  It is
-	 * cleared when the reset is complete and rings reestablished.
-	 */
-	spin_lock(&phba->hbalock);
 	/* driver queued commands are in process of being flushed */
-	if (phba->hba_flag & HBA_IOQ_FLUSH) {
-		spin_unlock(&phba->hbalock);
-		spin_unlock_irqrestore(&lpfc_nbuf->buf_lock, flags);
+	if (test_bit(HBA_IOQ_FLUSH, &phba->hba_flag)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "6139 Driver in reset cleanup - flushing "
-				 "NVME Req now.  hba_flag x%x\n",
+				 "NVME Req now.  hba_flag x%lx\n",
 				 phba->hba_flag);
 		return;
 	}
 
+	/* Guard against IO completion being called at same time */
+	spin_lock_irqsave(&lpfc_nbuf->buf_lock, flags);
+	spin_lock(&phba->hbalock);
+
 	nvmereq_wqe = &lpfc_nbuf->cur_iocbq;
 
 	/*
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 0b91de86d845..5297cacc8beb 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -3395,14 +3395,12 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 	/* If the hba is getting reset, this flag is set.  It is
 	 * cleared when the reset is complete and rings reestablished.
 	 */
-	spin_lock_irqsave(&phba->hbalock, flags);
 	/* driver queued commands are in process of being flushed */
-	if (phba->hba_flag & HBA_IOQ_FLUSH) {
-		spin_unlock_irqrestore(&phba->hbalock, flags);
+	if (test_bit(HBA_IOQ_FLUSH, &phba->hba_flag)) {
 		atomic_inc(&tgtp->xmt_abort_rsp_error);
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"6163 Driver in reset cleanup - flushing "
-				"NVME Req now. hba_flag x%x oxid x%x\n",
+				"NVME Req now. hba_flag x%lx oxid x%x\n",
 				phba->hba_flag, ctxp->oxid);
 		lpfc_sli_release_iocbq(phba, abts_wqeq);
 		spin_lock_irqsave(&ctxp->ctxlock, flags);
@@ -3411,6 +3409,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 		return 0;
 	}
 
+	spin_lock_irqsave(&phba->hbalock, flags);
 	/* Outstanding abort is in progress */
 	if (abts_wqeq->cmd_flag & LPFC_DRIVER_ABORTED) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 8ff39cd9c7e2..f1255e7c0445 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -3227,7 +3227,7 @@ lpfc_scsi_prep_dma_buf_s4(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 	 */
 	fcp_cmnd->fcpDl = cpu_to_be32(scsi_bufflen(scsi_cmnd));
 	/* Set first-burst provided it was successfully negotiated */
-	if (!(phba->hba_flag & HBA_FCOE_MODE) &&
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag) &&
 	    vport->cfg_first_burst_size &&
 	    scsi_cmnd->sc_data_direction == DMA_TO_DEVICE) {
 		u32 init_len, total_len;
@@ -3423,7 +3423,7 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 	fcp_cmnd->fcpDl = be32_to_cpu(fcpdl);
 
 	/* Set first-burst provided it was successfully negotiated */
-	if (!(phba->hba_flag & HBA_FCOE_MODE) &&
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag) &&
 	    vport->cfg_first_burst_size &&
 	    scsi_cmnd->sc_data_direction == DMA_TO_DEVICE) {
 		u32 init_len, total_len;
@@ -5043,7 +5043,7 @@ lpfc_check_pci_resettable(struct lpfc_hba *phba)
 
 		/* Check for valid Emulex Device ID */
 		if (phba->sli_rev != LPFC_SLI_REV4 ||
-		    phba->hba_flag & HBA_FCOE_MODE) {
+		    test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 					"8347 Incapable PCI reset device: "
 					"0x%04x\n", ptr->device);
@@ -5520,7 +5520,7 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 
 	spin_lock(&phba->hbalock);
 	/* driver queued commands are in process of being flushed */
-	if (phba->hba_flag & HBA_IOQ_FLUSH) {
+	if (test_bit(HBA_IOQ_FLUSH, &phba->hba_flag)) {
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_FCP,
 			"3168 SCSI Layer abort requested I/O has been "
 			"flushed by LLD.\n");
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index c64151cd205e..7f373c0b7eb5 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1024,10 +1024,7 @@ lpfc_handle_rrq_active(struct lpfc_hba *phba)
 	unsigned long iflags;
 	LIST_HEAD(send_rrq);
 
-	spin_lock_irqsave(&phba->hbalock, iflags);
-	phba->hba_flag &= ~HBA_RRQ_ACTIVE;
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
-
+	clear_bit(HBA_RRQ_ACTIVE, &phba->hba_flag);
 	next_time = jiffies + msecs_to_jiffies(1000 * (phba->fc_ratov + 1));
 	spin_lock_irqsave(&phba->rrq_list_lock, iflags);
 	list_for_each_entry_safe(rrq, nextrrq,
@@ -1182,12 +1179,12 @@ lpfc_set_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	if (!phba->cfg_enable_rrq)
 		return -EINVAL;
 
-	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (test_bit(FC_UNLOADING, &phba->pport->load_flag)) {
-		phba->hba_flag &= ~HBA_RRQ_ACTIVE;
-		goto out;
+		clear_bit(HBA_RRQ_ACTIVE, &phba->hba_flag);
+		goto outnl;
 	}
 
+	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (ndlp->vport && test_bit(FC_UNLOADING, &ndlp->vport->load_flag))
 		goto out;
 
@@ -1221,16 +1218,13 @@ lpfc_set_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	empty = list_empty(&phba->active_rrq_list);
 	list_add_tail(&rrq->list, &phba->active_rrq_list);
 	spin_unlock_irqrestore(&phba->rrq_list_lock, iflags);
-
-	spin_lock_irqsave(&phba->hbalock, iflags);
-	phba->hba_flag |= HBA_RRQ_ACTIVE;
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
-
+	set_bit(HBA_RRQ_ACTIVE, &phba->hba_flag);
 	if (empty)
 		lpfc_worker_wake_up(phba);
 	return 0;
 out:
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
+outnl:
 	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
 			"2921 Can't set rrq active xri:0x%x rxid:0x%x"
 			" DID:0x%x Send:%d\n",
@@ -3945,7 +3939,7 @@ void lpfc_poll_eratt(struct timer_list *t)
 	uint64_t sli_intr, cnt;
 
 	phba = from_timer(phba, t, eratt_poll);
-	if (!(phba->hba_flag & HBA_SETUP))
+	if (!test_bit(HBA_SETUP, &phba->hba_flag))
 		return;
 
 	if (test_bit(FC_UNLOADING, &phba->pport->load_flag))
@@ -4530,9 +4524,7 @@ lpfc_sli_handle_slow_ring_event_s4(struct lpfc_hba *phba,
 	unsigned long iflag;
 	int count = 0;
 
-	spin_lock_irqsave(&phba->hbalock, iflag);
-	phba->hba_flag &= ~HBA_SP_QUEUE_EVT;
-	spin_unlock_irqrestore(&phba->hbalock, iflag);
+	clear_bit(HBA_SP_QUEUE_EVT, &phba->hba_flag);
 	while (!list_empty(&phba->sli4_hba.sp_queue_event)) {
 		/* Get the response iocb from the head of work queue */
 		spin_lock_irqsave(&phba->hbalock, iflag);
@@ -4689,10 +4681,8 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
 	uint32_t i;
 	struct lpfc_iocbq *piocb, *next_iocb;
 
-	spin_lock_irq(&phba->hbalock);
 	/* Indicate the I/O queues are flushed */
-	phba->hba_flag |= HBA_IOQ_FLUSH;
-	spin_unlock_irq(&phba->hbalock);
+	set_bit(HBA_IOQ_FLUSH, &phba->hba_flag);
 
 	/* Look on all the FCP Rings for the iotag */
 	if (phba->sli_rev >= LPFC_SLI_REV4) {
@@ -4770,7 +4760,7 @@ lpfc_sli_brdready_s3(struct lpfc_hba *phba, uint32_t mask)
 	if (lpfc_readl(phba->HSregaddr, &status))
 		return 1;
 
-	phba->hba_flag |= HBA_NEEDS_CFG_PORT;
+	set_bit(HBA_NEEDS_CFG_PORT, &phba->hba_flag);
 
 	/*
 	 * Check status register every 100ms for 5 retries, then every
@@ -4849,7 +4839,7 @@ lpfc_sli_brdready_s4(struct lpfc_hba *phba, uint32_t mask)
 	} else
 		phba->sli4_hba.intr_enable = 0;
 
-	phba->hba_flag &= ~HBA_SETUP;
+	clear_bit(HBA_SETUP, &phba->hba_flag);
 	return retval;
 }
 
@@ -5101,7 +5091,7 @@ lpfc_sli_brdreset(struct lpfc_hba *phba)
 	/* perform board reset */
 	phba->fc_eventTag = 0;
 	phba->link_events = 0;
-	phba->hba_flag |= HBA_NEEDS_CFG_PORT;
+	set_bit(HBA_NEEDS_CFG_PORT, &phba->hba_flag);
 	if (phba->pport) {
 		phba->pport->fc_myDID = 0;
 		phba->pport->fc_prevDID = 0;
@@ -5161,7 +5151,7 @@ lpfc_sli4_brdreset(struct lpfc_hba *phba)
 
 	/* Reset HBA */
 	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
-			"0295 Reset HBA Data: x%x x%x x%x\n",
+			"0295 Reset HBA Data: x%x x%x x%lx\n",
 			phba->pport->port_state, psli->sli_flag,
 			phba->hba_flag);
 
@@ -5170,7 +5160,7 @@ lpfc_sli4_brdreset(struct lpfc_hba *phba)
 	phba->link_events = 0;
 	phba->pport->fc_myDID = 0;
 	phba->pport->fc_prevDID = 0;
-	phba->hba_flag &= ~HBA_SETUP;
+	clear_bit(HBA_SETUP, &phba->hba_flag);
 
 	spin_lock_irq(&phba->hbalock);
 	psli->sli_flag &= ~(LPFC_PROCESS_LA);
@@ -5414,7 +5404,7 @@ lpfc_sli_chipset_init(struct lpfc_hba *phba)
 		return -EIO;
 	}
 
-	phba->hba_flag |= HBA_NEEDS_CFG_PORT;
+	set_bit(HBA_NEEDS_CFG_PORT, &phba->hba_flag);
 
 	/* Clear all interrupt enable conditions */
 	writel(0, phba->HCregaddr);
@@ -5716,11 +5706,11 @@ lpfc_sli_hba_setup(struct lpfc_hba *phba)
 	int longs;
 
 	/* Enable ISR already does config_port because of config_msi mbx */
-	if (phba->hba_flag & HBA_NEEDS_CFG_PORT) {
+	if (test_bit(HBA_NEEDS_CFG_PORT, &phba->hba_flag)) {
 		rc = lpfc_sli_config_port(phba, LPFC_SLI_REV3);
 		if (rc)
 			return -EIO;
-		phba->hba_flag &= ~HBA_NEEDS_CFG_PORT;
+		clear_bit(HBA_NEEDS_CFG_PORT, &phba->hba_flag);
 	}
 	phba->fcp_embed_io = 0;	/* SLI4 FC support only */
 
@@ -7767,7 +7757,7 @@ lpfc_set_host_data(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
 	snprintf(mbox->u.mqe.un.set_host_data.un.data,
 		 LPFC_HOST_OS_DRIVER_VERSION_SIZE,
 		 "Linux %s v"LPFC_DRIVER_VERSION,
-		 (phba->hba_flag & HBA_FCOE_MODE) ? "FCoE" : "FC");
+		 test_bit(HBA_FCOE_MODE, &phba->hba_flag) ? "FCoE" : "FC");
 }
 
 int
@@ -8495,7 +8485,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 			spin_unlock_irq(&phba->hbalock);
 		}
 	}
-	phba->hba_flag &= ~HBA_SETUP;
+	clear_bit(HBA_SETUP, &phba->hba_flag);
 
 	lpfc_sli4_dip(phba);
 
@@ -8524,25 +8514,26 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	mqe = &mboxq->u.mqe;
 	phba->sli_rev = bf_get(lpfc_mbx_rd_rev_sli_lvl, &mqe->un.read_rev);
 	if (bf_get(lpfc_mbx_rd_rev_fcoe, &mqe->un.read_rev)) {
-		phba->hba_flag |= HBA_FCOE_MODE;
+		set_bit(HBA_FCOE_MODE, &phba->hba_flag);
 		phba->fcp_embed_io = 0;	/* SLI4 FC support only */
 	} else {
-		phba->hba_flag &= ~HBA_FCOE_MODE;
+		clear_bit(HBA_FCOE_MODE, &phba->hba_flag);
 	}
 
 	if (bf_get(lpfc_mbx_rd_rev_cee_ver, &mqe->un.read_rev) ==
 		LPFC_DCBX_CEE_MODE)
-		phba->hba_flag |= HBA_FIP_SUPPORT;
+		set_bit(HBA_FIP_SUPPORT, &phba->hba_flag);
 	else
-		phba->hba_flag &= ~HBA_FIP_SUPPORT;
+		clear_bit(HBA_FIP_SUPPORT, &phba->hba_flag);
 
-	phba->hba_flag &= ~HBA_IOQ_FLUSH;
+	clear_bit(HBA_IOQ_FLUSH, &phba->hba_flag);
 
 	if (phba->sli_rev != LPFC_SLI_REV4) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"0376 READ_REV Error. SLI Level %d "
 			"FCoE enabled %d\n",
-			phba->sli_rev, phba->hba_flag & HBA_FCOE_MODE);
+			phba->sli_rev,
+			test_bit(HBA_FCOE_MODE, &phba->hba_flag) ? 1 : 0);
 		rc = -EIO;
 		kfree(vpd);
 		goto out_free_mbox;
@@ -8557,7 +8548,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	 * to read FCoE param config regions, only read parameters if the
 	 * board is FCoE
 	 */
-	if (phba->hba_flag & HBA_FCOE_MODE &&
+	if (test_bit(HBA_FCOE_MODE, &phba->hba_flag) &&
 	    lpfc_sli4_read_fcoe_params(phba))
 		lpfc_printf_log(phba, KERN_WARNING, LOG_MBOX | LOG_INIT,
 			"2570 Failed to read FCoE parameters\n");
@@ -8634,7 +8625,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 		lpfc_set_features(phba, mboxq, LPFC_SET_UE_RECOVERY);
 		rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
 		if (rc == MBX_SUCCESS) {
-			phba->hba_flag |= HBA_RECOVERABLE_UE;
+			set_bit(HBA_RECOVERABLE_UE, &phba->hba_flag);
 			/* Set 1Sec interval to detect UE */
 			phba->eratt_poll_interval = 1;
 			phba->sli4_hba.ue_to_sr = bf_get(
@@ -8685,7 +8676,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	}
 
 	/* Performance Hints are ONLY for FCoE */
-	if (phba->hba_flag & HBA_FCOE_MODE) {
+	if (test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		if (bf_get(lpfc_mbx_rq_ftr_rsp_perfh, &mqe->un.req_ftrs))
 			phba->sli3_options |= LPFC_SLI4_PERFH_ENABLED;
 		else
@@ -8944,7 +8935,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	}
 	lpfc_sli4_node_prep(phba);
 
-	if (!(phba->hba_flag & HBA_FCOE_MODE)) {
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		if ((phba->nvmet_support == 0) || (phba->cfg_nvmet_mrq == 1)) {
 			/*
 			 * The FC Port needs to register FCFI (index 0)
@@ -9020,7 +9011,8 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* Start heart beat timer */
 	mod_timer(&phba->hb_tmofunc,
 		  jiffies + msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
-	phba->hba_flag &= ~(HBA_HBEAT_INP | HBA_HBEAT_TMO);
+	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
+	clear_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 	phba->last_completion_time = jiffies;
 
 	/* start eq_delay heartbeat */
@@ -9062,8 +9054,8 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* Setup CMF after HBA is initialized */
 	lpfc_cmf_setup(phba);
 
-	if (!(phba->hba_flag & HBA_FCOE_MODE) &&
-	    (phba->hba_flag & LINK_DISABLED)) {
+	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag) &&
+	    test_bit(LINK_DISABLED, &phba->hba_flag)) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 				"3103 Adapter Link is disabled.\n");
 		lpfc_down_link(phba, mboxq);
@@ -9087,7 +9079,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 	/* Enable RAS FW log support */
 	lpfc_sli4_ras_setup(phba);
 
-	phba->hba_flag |= HBA_SETUP;
+	set_bit(HBA_SETUP, &phba->hba_flag);
 	return rc;
 
 out_io_buff_free:
@@ -9391,7 +9383,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 	}
 
 	/* If HBA has a deferred error attention, fail the iocb. */
-	if (unlikely(phba->hba_flag & DEFER_ERATT)) {
+	if (unlikely(test_bit(DEFER_ERATT, &phba->hba_flag))) {
 		spin_unlock_irqrestore(&phba->hbalock, drvr_flag);
 		goto out_not_finished;
 	}
@@ -10455,7 +10447,7 @@ __lpfc_sli_issue_iocb_s3(struct lpfc_hba *phba, uint32_t ring_number,
 		return IOCB_ERROR;
 
 	/* If HBA has a deferred error attention, fail the iocb. */
-	if (unlikely(phba->hba_flag & DEFER_ERATT))
+	if (unlikely(test_bit(DEFER_ERATT, &phba->hba_flag)))
 		return IOCB_ERROR;
 
 	/*
@@ -12785,7 +12777,7 @@ lpfc_sli_abort_iocb(struct lpfc_vport *vport, u16 tgt_id, u64 lun_id,
 	int i;
 
 	/* all I/Os are in process of being flushed */
-	if (phba->hba_flag & HBA_IOQ_FLUSH)
+	if (test_bit(HBA_IOQ_FLUSH, &phba->hba_flag))
 		return errcnt;
 
 	for (i = 1; i <= phba->sli.last_iotag; i++) {
@@ -12855,15 +12847,13 @@ lpfc_sli_abort_taskmgmt(struct lpfc_vport *vport, struct lpfc_sli_ring *pring,
 	u16 ulp_context, iotag, cqid = LPFC_WQE_CQ_ID_DEFAULT;
 	bool ia;
 
-	spin_lock_irqsave(&phba->hbalock, iflags);
-
 	/* all I/Os are in process of being flushed */
-	if (phba->hba_flag & HBA_IOQ_FLUSH) {
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
+	if (test_bit(HBA_IOQ_FLUSH, &phba->hba_flag))
 		return 0;
-	}
+
 	sum = 0;
 
+	spin_lock_irqsave(&phba->hbalock, iflags);
 	for (i = 1; i <= phba->sli.last_iotag; i++) {
 		iocbq = phba->sli.iocbq_lookup[i];
 
@@ -13395,7 +13385,7 @@ lpfc_sli_eratt_read(struct lpfc_hba *phba)
 		if ((HS_FFER1 & phba->work_hs) &&
 		    ((HS_FFER2 | HS_FFER3 | HS_FFER4 | HS_FFER5 |
 		      HS_FFER6 | HS_FFER7 | HS_FFER8) & phba->work_hs)) {
-			phba->hba_flag |= DEFER_ERATT;
+			set_bit(DEFER_ERATT, &phba->hba_flag);
 			/* Clear all interrupt enable conditions */
 			writel(0, phba->HCregaddr);
 			readl(phba->HCregaddr);
@@ -13404,7 +13394,7 @@ lpfc_sli_eratt_read(struct lpfc_hba *phba)
 		/* Set the driver HA work bitmap */
 		phba->work_ha |= HA_ERATT;
 		/* Indicate polling handles this ERATT */
-		phba->hba_flag |= HBA_ERATT_HANDLED;
+		set_bit(HBA_ERATT_HANDLED, &phba->hba_flag);
 		return 1;
 	}
 	return 0;
@@ -13415,7 +13405,7 @@ lpfc_sli_eratt_read(struct lpfc_hba *phba)
 	/* Set the driver HA work bitmap */
 	phba->work_ha |= HA_ERATT;
 	/* Indicate polling handles this ERATT */
-	phba->hba_flag |= HBA_ERATT_HANDLED;
+	set_bit(HBA_ERATT_HANDLED, &phba->hba_flag);
 	return 1;
 }
 
@@ -13451,7 +13441,7 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 			&uerr_sta_hi)) {
 			phba->work_hs |= UNPLUG_ERR;
 			phba->work_ha |= HA_ERATT;
-			phba->hba_flag |= HBA_ERATT_HANDLED;
+			set_bit(HBA_ERATT_HANDLED, &phba->hba_flag);
 			return 1;
 		}
 		if ((~phba->sli4_hba.ue_mask_lo & uerr_sta_lo) ||
@@ -13467,7 +13457,7 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 			phba->work_status[0] = uerr_sta_lo;
 			phba->work_status[1] = uerr_sta_hi;
 			phba->work_ha |= HA_ERATT;
-			phba->hba_flag |= HBA_ERATT_HANDLED;
+			set_bit(HBA_ERATT_HANDLED, &phba->hba_flag);
 			return 1;
 		}
 		break;
@@ -13479,7 +13469,7 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 			&portsmphr)){
 			phba->work_hs |= UNPLUG_ERR;
 			phba->work_ha |= HA_ERATT;
-			phba->hba_flag |= HBA_ERATT_HANDLED;
+			set_bit(HBA_ERATT_HANDLED, &phba->hba_flag);
 			return 1;
 		}
 		if (bf_get(lpfc_sliport_status_err, &portstat_reg)) {
@@ -13502,7 +13492,7 @@ lpfc_sli4_eratt_read(struct lpfc_hba *phba)
 					phba->work_status[0],
 					phba->work_status[1]);
 			phba->work_ha |= HA_ERATT;
-			phba->hba_flag |= HBA_ERATT_HANDLED;
+			set_bit(HBA_ERATT_HANDLED, &phba->hba_flag);
 			return 1;
 		}
 		break;
@@ -13539,22 +13529,18 @@ lpfc_sli_check_eratt(struct lpfc_hba *phba)
 		return 0;
 
 	/* Check if interrupt handler handles this ERATT */
-	spin_lock_irq(&phba->hbalock);
-	if (phba->hba_flag & HBA_ERATT_HANDLED) {
+	if (test_bit(HBA_ERATT_HANDLED, &phba->hba_flag))
 		/* Interrupt handler has handled ERATT */
-		spin_unlock_irq(&phba->hbalock);
 		return 0;
-	}
 
 	/*
 	 * If there is deferred error attention, do not check for error
 	 * attention
 	 */
-	if (unlikely(phba->hba_flag & DEFER_ERATT)) {
-		spin_unlock_irq(&phba->hbalock);
+	if (unlikely(test_bit(DEFER_ERATT, &phba->hba_flag)))
 		return 0;
-	}
 
+	spin_lock_irq(&phba->hbalock);
 	/* If PCI channel is offline, don't process it */
 	if (unlikely(pci_channel_offline(phba->pcidev))) {
 		spin_unlock_irq(&phba->hbalock);
@@ -13676,19 +13662,17 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 			ha_copy &= ~HA_ERATT;
 		/* Check the need for handling ERATT in interrupt handler */
 		if (ha_copy & HA_ERATT) {
-			if (phba->hba_flag & HBA_ERATT_HANDLED)
+			if (test_and_set_bit(HBA_ERATT_HANDLED,
+					     &phba->hba_flag))
 				/* ERATT polling has handled ERATT */
 				ha_copy &= ~HA_ERATT;
-			else
-				/* Indicate interrupt handler handles ERATT */
-				phba->hba_flag |= HBA_ERATT_HANDLED;
 		}
 
 		/*
 		 * If there is deferred error attention, do not check for any
 		 * interrupt.
 		 */
-		if (unlikely(phba->hba_flag & DEFER_ERATT)) {
+		if (unlikely(test_bit(DEFER_ERATT, &phba->hba_flag))) {
 			spin_unlock_irqrestore(&phba->hbalock, iflag);
 			return IRQ_NONE;
 		}
@@ -13784,7 +13768,7 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 				((HS_FFER2 | HS_FFER3 | HS_FFER4 | HS_FFER5 |
 				  HS_FFER6 | HS_FFER7 | HS_FFER8) &
 				  phba->work_hs)) {
-				phba->hba_flag |= DEFER_ERATT;
+				set_bit(DEFER_ERATT, &phba->hba_flag);
 				/* Clear all interrupt enable conditions */
 				writel(0, phba->HCregaddr);
 				readl(phba->HCregaddr);
@@ -13971,16 +13955,16 @@ lpfc_sli_fp_intr_handler(int irq, void *dev_id)
 		/* Need to read HA REG for FCP ring and other ring events */
 		if (lpfc_readl(phba->HAregaddr, &ha_copy))
 			return IRQ_HANDLED;
-		/* Clear up only attention source related to fast-path */
-		spin_lock_irqsave(&phba->hbalock, iflag);
+
 		/*
 		 * If there is deferred error attention, do not check for
 		 * any interrupt.
 		 */
-		if (unlikely(phba->hba_flag & DEFER_ERATT)) {
-			spin_unlock_irqrestore(&phba->hbalock, iflag);
+		if (unlikely(test_bit(DEFER_ERATT, &phba->hba_flag)))
 			return IRQ_NONE;
-		}
+
+		/* Clear up only attention source related to fast-path */
+		spin_lock_irqsave(&phba->hbalock, iflag);
 		writel((ha_copy & (HA_R0_CLR_MSK | HA_R1_CLR_MSK)),
 			phba->HAregaddr);
 		readl(phba->HAregaddr); /* flush */
@@ -14063,18 +14047,15 @@ lpfc_sli_intr_handler(int irq, void *dev_id)
 		spin_unlock(&phba->hbalock);
 		return IRQ_NONE;
 	} else if (phba->ha_copy & HA_ERATT) {
-		if (phba->hba_flag & HBA_ERATT_HANDLED)
+		if (test_and_set_bit(HBA_ERATT_HANDLED, &phba->hba_flag))
 			/* ERATT polling has handled ERATT */
 			phba->ha_copy &= ~HA_ERATT;
-		else
-			/* Indicate interrupt handler handles ERATT */
-			phba->hba_flag |= HBA_ERATT_HANDLED;
 	}
 
 	/*
 	 * If there is deferred error attention, do not check for any interrupt.
 	 */
-	if (unlikely(phba->hba_flag & DEFER_ERATT)) {
+	if (unlikely(test_bit(DEFER_ERATT, &phba->hba_flag))) {
 		spin_unlock(&phba->hbalock);
 		return IRQ_NONE;
 	}
@@ -14145,9 +14126,7 @@ void lpfc_sli4_els_xri_abort_event_proc(struct lpfc_hba *phba)
 	unsigned long iflags;
 
 	/* First, declare the els xri abort event has been handled */
-	spin_lock_irqsave(&phba->hbalock, iflags);
-	phba->hba_flag &= ~ELS_XRI_ABORT_EVENT;
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
+	clear_bit(ELS_XRI_ABORT_EVENT, &phba->hba_flag);
 
 	/* Now, handle all the els xri abort events */
 	spin_lock_irqsave(&phba->sli4_hba.els_xri_abrt_list_lock, iflags);
@@ -14273,9 +14252,7 @@ lpfc_sli4_sp_handle_async_event(struct lpfc_hba *phba, struct lpfc_mcqe *mcqe)
 	spin_unlock_irqrestore(&phba->sli4_hba.asynce_list_lock, iflags);
 
 	/* Set the async event flag */
-	spin_lock_irqsave(&phba->hbalock, iflags);
-	phba->hba_flag |= ASYNC_EVENT;
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
+	set_bit(ASYNC_EVENT, &phba->hba_flag);
 
 	return true;
 }
@@ -14515,8 +14492,8 @@ lpfc_sli4_sp_handle_els_wcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	list_add_tail(&irspiocbq->cq_event.list,
 		      &phba->sli4_hba.sp_queue_event);
-	phba->hba_flag |= HBA_SP_QUEUE_EVT;
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
+	set_bit(HBA_SP_QUEUE_EVT, &phba->hba_flag);
 
 	return true;
 }
@@ -14590,7 +14567,7 @@ lpfc_sli4_sp_handle_abort_xri_wcqe(struct lpfc_hba *phba,
 		list_add_tail(&cq_event->list,
 			      &phba->sli4_hba.sp_els_xri_aborted_work_queue);
 		/* Set the els xri abort event flag */
-		phba->hba_flag |= ELS_XRI_ABORT_EVENT;
+		set_bit(ELS_XRI_ABORT_EVENT, &phba->hba_flag);
 		spin_unlock_irqrestore(&phba->sli4_hba.els_xri_abrt_list_lock,
 				       iflags);
 		workposted = true;
@@ -14677,9 +14654,9 @@ lpfc_sli4_sp_handle_rcqe(struct lpfc_hba *phba, struct lpfc_rcqe *rcqe)
 		/* save off the frame for the work thread to process */
 		list_add_tail(&dma_buf->cq_event.list,
 			      &phba->sli4_hba.sp_queue_event);
-		/* Frame received */
-		phba->hba_flag |= HBA_SP_QUEUE_EVT;
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
+		/* Frame received */
+		set_bit(HBA_SP_QUEUE_EVT, &phba->hba_flag);
 		workposted = true;
 		break;
 	case FC_STATUS_INSUFF_BUF_FRM_DISC:
@@ -14699,9 +14676,7 @@ lpfc_sli4_sp_handle_rcqe(struct lpfc_hba *phba, struct lpfc_rcqe *rcqe)
 	case FC_STATUS_INSUFF_BUF_NEED_BUF:
 		hrq->RQ_no_posted_buf++;
 		/* Post more buffers if possible */
-		spin_lock_irqsave(&phba->hbalock, iflags);
-		phba->hba_flag |= HBA_POST_RECEIVE_BUFFER;
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
+		set_bit(HBA_POST_RECEIVE_BUFFER, &phba->hba_flag);
 		workposted = true;
 		break;
 	case FC_STATUS_RQ_DMA_FAILURE:
@@ -19359,8 +19334,8 @@ lpfc_sli4_handle_mds_loopback(struct lpfc_vport *vport,
 		spin_lock_irqsave(&phba->hbalock, iflags);
 		list_add_tail(&dmabuf->cq_event.list,
 			      &phba->sli4_hba.sp_queue_event);
-		phba->hba_flag |= HBA_SP_QUEUE_EVT;
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
+		set_bit(HBA_SP_QUEUE_EVT, &phba->hba_flag);
 		lpfc_worker_wake_up(phba);
 		return;
 	}
@@ -20112,9 +20087,7 @@ lpfc_sli4_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, uint16_t fcf_index)
 	mboxq->vport = phba->pport;
 	mboxq->mbox_cmpl = lpfc_mbx_cmpl_fcf_scan_read_fcf_rec;
 
-	spin_lock_irq(&phba->hbalock);
-	phba->hba_flag |= FCF_TS_INPROG;
-	spin_unlock_irq(&phba->hbalock);
+	set_bit(FCF_TS_INPROG, &phba->hba_flag);
 
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_NOWAIT);
 	if (rc == MBX_NOT_FINISHED)
@@ -20130,9 +20103,7 @@ lpfc_sli4_fcf_scan_read_fcf_rec(struct lpfc_hba *phba, uint16_t fcf_index)
 		if (mboxq)
 			lpfc_sli4_mbox_cmd_free(phba, mboxq);
 		/* FCF scan failed, clear FCF_TS_INPROG flag */
-		spin_lock_irq(&phba->hbalock);
-		phba->hba_flag &= ~FCF_TS_INPROG;
-		spin_unlock_irq(&phba->hbalock);
+		clear_bit(FCF_TS_INPROG, &phba->hba_flag);
 	}
 	return error;
 }
@@ -20789,7 +20760,7 @@ lpfc_sli_read_link_ste(struct lpfc_hba *phba)
 
 			/* This HBA contains PORT_STE configured */
 			if (!rgn23_data[offset + 2])
-				phba->hba_flag |= LINK_DISABLED;
+				set_bit(LINK_DISABLED, &phba->hba_flag);
 
 			goto out;
 		}
@@ -22603,12 +22574,13 @@ lpfc_sli_prep_wqe(struct lpfc_hba *phba, struct lpfc_iocbq *job)
 	u8 cmnd;
 	u32 *pcmd;
 	u32 if_type = 0;
-	u32 fip, abort_tag;
+	u32 abort_tag;
+	bool fip;
 	struct lpfc_nodelist *ndlp = NULL;
 	union lpfc_wqe128 *wqe = &job->wqe;
 	u8 command_type = ELS_COMMAND_NON_FIP;
 
-	fip = phba->hba_flag & HBA_FIP_SUPPORT;
+	fip = test_bit(HBA_FIP_SUPPORT, &phba->hba_flag);
 	/* The fcp commands will set command type */
 	if (job->cmd_flag &  LPFC_IO_FCP)
 		command_type = FCP_COMMAND;
-- 
2.38.0


