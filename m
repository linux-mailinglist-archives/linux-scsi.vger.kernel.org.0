Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA213EBE7B
	for <lists+linux-scsi@lfdr.de>; Sat, 14 Aug 2021 01:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhHMXB5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Aug 2021 19:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbhHMXBt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Aug 2021 19:01:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B4AC0617AD
        for <linux-scsi@vger.kernel.org>; Fri, 13 Aug 2021 16:01:21 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n12so13266488plf.4
        for <linux-scsi@vger.kernel.org>; Fri, 13 Aug 2021 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJXs/cr4D7c7bI14XoZz64UuV88spXGn83YaYb44SiU=;
        b=Y3s+sV8vPTWrEF8eoSltmgDXWgWvvLnc87l5/mZzbFA5TAYGCuX+p3iGQkWp0Lvboc
         TW3Dh6eDdy10NXTwjX1hgL+5p5z0aYuw8xymLNcOjV3+Mz1RPOCn0DSOTv1lRDk81Klt
         faec43qz+zT8+f/fMnrB8Ud0bPVYPSy9Q0+TQcywk2SfL0N4Na/P7CFztnPO48Hlq3C5
         a3C4nFL8+m20z3eJ/goOSdTylWqmql7Mw/+vICnVei0P5JYZ3h1SOvPYB1rUdWDa93+l
         9E+cjSDNjn4tBcZad73QfVGwj0t+UhoA8N2Rj6NDprc+wuQAxjZZQh+pMVOE6alSeuWN
         EvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJXs/cr4D7c7bI14XoZz64UuV88spXGn83YaYb44SiU=;
        b=mS/Tj7kW2hhTBE5YLyL/UYLl4FffqgOt7JhpF/i/VR4W3v7w3czPjScRpaT9V8a3ga
         Q72MCClloE0pxpSeT0I0UueofidSKpMs6aZRWFpBXuQ+A23LBkpuGSOiqH2gtA5d760q
         VxxYoXH0ZwUWIcpMDpl1Bck+trXCv9FWYSrM6p8i60j6UY7mokC+wXpozuLkflmYJNNO
         CIfJ7iXCdpwyuOc0+j26Imnh3GK26g178pPU4Z4Mc0R9zw8rzbns9qS8q0QEU/1n7LR8
         /l3VUKhzmuD1ckk1jL0D6TsYAgoaxW2A5dxSD4LXg/sBFNKR8Bvc7DvP+DlmRF1LiZSb
         pXNg==
X-Gm-Message-State: AOAM533ccFWr3x19v04C4ydCvIqaKECWp6XyhRDtW69G4ga2SEm8pi3C
        bmQQjCyT9hKz8M8BbVvm0MmBNWY6dHQ=
X-Google-Smtp-Source: ABdhPJwNbo/LY08Et5sRqjIezF/wwYJ1Ipx3xf34AUaaDgjB7QeBYg4dS9qqQKVi/QwCcMr1i2EUAg==
X-Received: by 2002:a62:8858:0:b029:2fb:6bb0:aba with SMTP id l85-20020a6288580000b02902fb6bb00abamr4623320pfd.32.1628895681131;
        Fri, 13 Aug 2021 16:01:21 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e8sm4001997pgg.31.2021.08.13.16.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 16:01:20 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH v2 13/16] lpfc: Add cmf_info sysfs entry
Date:   Fri, 13 Aug 2021 16:00:36 -0700
Message-Id: <20210813230039.110546-14-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210813230039.110546-1-jsmart2021@gmail.com>
References: <20210813230039.110546-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch allows abbreviated cm framework status information to be
obtained via sysfs.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |   1 +
 drivers/scsi/lpfc/lpfc_attr.c | 193 +++++++++++++++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_crtn.h |   2 +
 drivers/scsi/lpfc/lpfc_els.c  |   2 +-
 drivers/scsi/lpfc/lpfc_hw4.h  |   6 +-
 drivers/scsi/lpfc/lpfc_init.c |  38 +++++++
 drivers/scsi/lpfc/lpfc_nvme.h |   3 -
 7 files changed, 235 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index dd8cb111b199..befeb7c34290 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1600,6 +1600,7 @@ struct lpfc_hba {
 };
 
 #define LPFC_MAX_RXMONITOR_ENTRY	800
+#define LPFC_MAX_RXMONITOR_DUMP		32
 struct rxtable_entry {
 	uint64_t total_bytes;   /* Total no of read bytes requested */
 	uint64_t rcv_bytes;     /* Total no of read bytes completed */
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b41891aefa64..b35bf70a8c0d 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -57,6 +57,8 @@
 #define LPFC_MIN_DEVLOSS_TMO	1
 #define LPFC_MAX_DEVLOSS_TMO	255
 
+#define LPFC_MAX_INFO_TMP_LEN	100
+#define LPFC_INFO_MORE_STR	"\nCould be more info...\n"
 /*
  * Write key size should be multiple of 4. If write key is changed
  * make sure that library write key is also changed.
@@ -112,6 +114,186 @@ lpfc_jedec_to_ascii(int incr, char hdw[])
 	return;
 }
 
+static ssize_t
+lpfc_cmf_info_show(struct device *dev, struct device_attribute *attr,
+		   char *buf)
+{
+	struct Scsi_Host  *shost = class_to_shost(dev);
+	struct lpfc_vport *vport = (struct lpfc_vport *)shost->hostdata;
+	struct lpfc_hba   *phba = vport->phba;
+	struct lpfc_cgn_info *cp = NULL;
+	struct lpfc_cgn_stat *cgs;
+	int  len = 0;
+	int cpu;
+	u64 rcv, total;
+	char tmp[LPFC_MAX_INFO_TMP_LEN] = {0};
+
+	if (phba->cgn_i)
+		cp = (struct lpfc_cgn_info *)phba->cgn_i->virt;
+
+	scnprintf(tmp, sizeof(tmp),
+		  "Congestion Mgmt Info: E2Eattr %d Ver %d "
+		  "CMF %d cnt %d\n",
+		  phba->sli4_hba.pc_sli4_params.mi_ver,
+		  cp ? cp->cgn_info_version : 0,
+		  phba->sli4_hba.pc_sli4_params.cmf, phba->cmf_timer_cnt);
+
+	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
+		goto buffer_done;
+
+	if (!phba->sli4_hba.pc_sli4_params.cmf)
+		goto buffer_done;
+
+	switch (phba->cgn_init_reg_signal) {
+	case EDC_CG_SIG_WARN_ONLY:
+		scnprintf(tmp, sizeof(tmp),
+			  "Register: Init:  Signal:WARN  ");
+		break;
+	case EDC_CG_SIG_WARN_ALARM:
+		scnprintf(tmp, sizeof(tmp),
+			  "Register: Init:  Signal:WARN|ALARM  ");
+		break;
+	default:
+		scnprintf(tmp, sizeof(tmp),
+			  "Register: Init:  Signal:NONE  ");
+		break;
+	}
+	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
+		goto buffer_done;
+
+	switch (phba->cgn_init_reg_fpin) {
+	case LPFC_CGN_FPIN_WARN:
+		scnprintf(tmp, sizeof(tmp),
+			  "FPIN:WARN\n");
+		break;
+	case LPFC_CGN_FPIN_ALARM:
+		scnprintf(tmp, sizeof(tmp),
+			  "FPIN:ALARM\n");
+		break;
+	case LPFC_CGN_FPIN_BOTH:
+		scnprintf(tmp, sizeof(tmp),
+			  "FPIN:WARN|ALARM\n");
+		break;
+	default:
+		scnprintf(tmp, sizeof(tmp),
+			  "FPIN:NONE\n");
+		break;
+	}
+	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
+		goto buffer_done;
+
+	switch (phba->cgn_reg_signal) {
+	case EDC_CG_SIG_WARN_ONLY:
+		scnprintf(tmp, sizeof(tmp),
+			  "       Current:  Signal:WARN  ");
+		break;
+	case EDC_CG_SIG_WARN_ALARM:
+		scnprintf(tmp, sizeof(tmp),
+			  "       Current:  Signal:WARN|ALARM  ");
+		break;
+	default:
+		scnprintf(tmp, sizeof(tmp),
+			  "       Current:  Signal:NONE  ");
+		break;
+	}
+	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
+		goto buffer_done;
+
+	switch (phba->cgn_reg_fpin) {
+	case LPFC_CGN_FPIN_WARN:
+		scnprintf(tmp, sizeof(tmp),
+			  "FPIN:WARN  ACQEcnt:%d\n", phba->cgn_acqe_cnt);
+		break;
+	case LPFC_CGN_FPIN_ALARM:
+		scnprintf(tmp, sizeof(tmp),
+			  "FPIN:ALARM  ACQEcnt:%d\n", phba->cgn_acqe_cnt);
+		break;
+	case LPFC_CGN_FPIN_BOTH:
+		scnprintf(tmp, sizeof(tmp),
+			  "FPIN:WARN|ALARM  ACQEcnt:%d\n", phba->cgn_acqe_cnt);
+		break;
+	default:
+		scnprintf(tmp, sizeof(tmp),
+			  "FPIN:NONE  ACQEcnt:%d\n", phba->cgn_acqe_cnt);
+		break;
+	}
+	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
+		goto buffer_done;
+
+	if (phba->cmf_active_mode != phba->cgn_p.cgn_param_mode) {
+		switch (phba->cmf_active_mode) {
+		case LPFC_CFG_OFF:
+			scnprintf(tmp, sizeof(tmp), "Active: Mode:Off\n");
+			break;
+		case LPFC_CFG_MANAGED:
+			scnprintf(tmp, sizeof(tmp), "Active: Mode:Managed\n");
+			break;
+		case LPFC_CFG_MONITOR:
+			scnprintf(tmp, sizeof(tmp), "Active: Mode:Monitor\n");
+			break;
+		default:
+			scnprintf(tmp, sizeof(tmp), "Active: Mode:Unknown\n");
+		}
+		if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
+			goto buffer_done;
+	}
+
+	switch (phba->cgn_p.cgn_param_mode) {
+	case LPFC_CFG_OFF:
+		scnprintf(tmp, sizeof(tmp), "Config: Mode:Off  ");
+		break;
+	case LPFC_CFG_MANAGED:
+		scnprintf(tmp, sizeof(tmp), "Config: Mode:Managed ");
+		break;
+	case LPFC_CFG_MONITOR:
+		scnprintf(tmp, sizeof(tmp), "Config: Mode:Monitor ");
+		break;
+	default:
+		scnprintf(tmp, sizeof(tmp), "Config: Mode:Unknown ");
+	}
+	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
+		goto buffer_done;
+
+	total = 0;
+	rcv = 0;
+	for_each_present_cpu(cpu) {
+		cgs = per_cpu_ptr(phba->cmf_stat, cpu);
+		total += atomic64_read(&cgs->total_bytes);
+		rcv += atomic64_read(&cgs->rcv_bytes);
+	}
+
+	scnprintf(tmp, sizeof(tmp),
+		  "IObusy:%d Info:%d Bytes: Rcv:x%llx Total:x%llx\n",
+		  atomic_read(&phba->cmf_busy),
+		  phba->cmf_active_info, rcv, total);
+	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
+		goto buffer_done;
+
+	scnprintf(tmp, sizeof(tmp),
+		  "Port_speed:%d  Link_byte_cnt:%ld  "
+		  "Max_byte_per_interval:%ld\n",
+		  lpfc_sli_port_speed_get(phba),
+		  (unsigned long)phba->cmf_link_byte_count,
+		  (unsigned long)phba->cmf_max_bytes_per_interval);
+	strlcat(buf, tmp, PAGE_SIZE);
+
+buffer_done:
+	len = strnlen(buf, PAGE_SIZE);
+
+	if (unlikely(len >= (PAGE_SIZE - 1))) {
+		lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+				"6312 Catching potential buffer "
+				"overflow > PAGE_SIZE = %lu bytes\n",
+				PAGE_SIZE);
+		strscpy(buf + PAGE_SIZE - 1 -
+			strnlen(LPFC_INFO_MORE_STR, PAGE_SIZE - 1),
+			LPFC_INFO_MORE_STR,
+			strnlen(LPFC_INFO_MORE_STR, PAGE_SIZE - 1)
+			+ 1);
+	}
+	return len;
+}
+
 /**
  * lpfc_drvr_version_show - Return the Emulex driver string with version number
  * @dev: class unused variable.
@@ -168,7 +350,7 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 	char *statep;
 	int i;
 	int len = 0;
-	char tmp[LPFC_MAX_NVME_INFO_TMP_LEN] = {0};
+	char tmp[LPFC_MAX_INFO_TMP_LEN] = {0};
 
 	if (!(vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME)) {
 		len = scnprintf(buf, PAGE_SIZE, "NVME Disabled\n");
@@ -512,9 +694,9 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 				"6314 Catching potential buffer "
 				"overflow > PAGE_SIZE = %lu bytes\n",
 				PAGE_SIZE);
-		strlcpy(buf + PAGE_SIZE - 1 - sizeof(LPFC_NVME_INFO_MORE_STR),
-			LPFC_NVME_INFO_MORE_STR,
-			sizeof(LPFC_NVME_INFO_MORE_STR) + 1);
+		strscpy(buf + PAGE_SIZE - 1 - sizeof(LPFC_INFO_MORE_STR),
+			LPFC_INFO_MORE_STR,
+			sizeof(LPFC_INFO_MORE_STR) + 1);
 	}
 
 	return len;
@@ -2636,6 +2818,7 @@ static DEVICE_ATTR_RO(lpfc_sriov_hw_max_virtfn);
 static DEVICE_ATTR(protocol, S_IRUGO, lpfc_sli4_protocol_show, NULL);
 static DEVICE_ATTR(lpfc_xlane_supported, S_IRUGO, lpfc_oas_supported_show,
 		   NULL);
+static DEVICE_ATTR(cmf_info, 0444, lpfc_cmf_info_show, NULL);
 
 static char *lpfc_soft_wwn_key = "C99G71SL8032A";
 #define WWN_SZ 8
@@ -6332,6 +6515,7 @@ struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_lpfc_enable_bbcr,
 	&dev_attr_lpfc_enable_dpp,
 	&dev_attr_lpfc_enable_mi,
+	&dev_attr_cmf_info,
 	&dev_attr_lpfc_max_vmid,
 	&dev_attr_lpfc_vmid_inactivity_timeout,
 	&dev_attr_lpfc_vmid_app_header,
@@ -6362,6 +6546,7 @@ struct device_attribute *lpfc_vport_attrs[] = {
 	&dev_attr_lpfc_max_scsicmpl_time,
 	&dev_attr_lpfc_stat_data_ctrl,
 	&dev_attr_lpfc_static_vport,
+	&dev_attr_cmf_info,
 	NULL,
 };
 
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 252670a14d13..c512f4199142 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -86,6 +86,7 @@ int lpfc_sli4_cgn_params_read(struct lpfc_hba *phba);
 uint32_t lpfc_cgn_calc_crc32(void *bufp, uint32_t sz, uint32_t seed);
 int lpfc_config_cgn_signal(struct lpfc_hba *phba);
 int lpfc_issue_cmf_sync_wqe(struct lpfc_hba *phba, u32 ms, u64 total);
+void lpfc_cgn_dump_rxmonitor(struct lpfc_hba *phba);
 void lpfc_cgn_update_stat(struct lpfc_hba *phba, uint32_t dtag);
 void lpfc_unblock_requests(struct lpfc_hba *phba);
 void lpfc_block_requests(struct lpfc_hba *phba);
@@ -159,6 +160,7 @@ int lpfc_issue_els_rscn(struct lpfc_vport *vport, uint8_t retry);
 int lpfc_issue_fabric_reglogin(struct lpfc_vport *);
 int lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry);
 int lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry);
+void lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length);
 int lpfc_els_free_iocb(struct lpfc_hba *, struct lpfc_iocbq *);
 int lpfc_ct_free_iocb(struct lpfc_hba *, struct lpfc_iocbq *);
 int lpfc_els_rsp_acc(struct lpfc_vport *, uint32_t, struct lpfc_iocbq *,
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 0ebe5d7a7697..1254a575fd47 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -9632,7 +9632,7 @@ lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 	return rc;
 }
 
-static void
+void
 lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 {
 	struct lpfc_hba *phba = vport->phba;
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index 73b249d0d964..79a4872c2edb 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -1157,6 +1157,7 @@ struct lpfc_mbx_nembed_sge_virt {
 	void *addr[LPFC_SLI4_MBX_SGE_MAX_PAGES];
 };
 
+#define LPFC_MBX_OBJECT_NAME_LEN_DW	26
 struct lpfc_mbx_read_object {  /* Version 0 */
 	struct mbox_header header;
 	union {
@@ -1166,7 +1167,7 @@ struct lpfc_mbx_read_object {  /* Version 0 */
 #define lpfc_mbx_rd_object_rlen_MASK	0x00FFFFFF
 #define lpfc_mbx_rd_object_rlen_WORD	word0
 			uint32_t rd_object_offset;
-			uint32_t rd_object_name[26];
+			uint32_t rd_object_name[LPFC_MBX_OBJECT_NAME_LEN_DW];
 #define LPFC_OBJ_NAME_SZ 104   /* 26 x sizeof(uint32_t) is 104. */
 			uint32_t rd_object_cnt;
 			struct lpfc_mbx_host_buf rd_object_hbuf[4];
@@ -3871,6 +3872,7 @@ struct lpfc_mbx_get_port_name {
 #define MB_CEQ_STATUS_QUEUE_FLUSHING		0x4
 #define MB_CQE_STATUS_DMA_FAILED		0x5
 
+
 #define LPFC_MBX_WR_CONFIG_MAX_BDE		1
 struct lpfc_mbx_wr_object {
 	struct mbox_header header;
@@ -3887,7 +3889,7 @@ struct lpfc_mbx_wr_object {
 #define lpfc_wr_object_write_length_MASK	0x00FFFFFF
 #define lpfc_wr_object_write_length_WORD	word4
 			uint32_t write_offset;
-			uint32_t object_name[26];
+			uint32_t object_name[LPFC_MBX_OBJECT_NAME_LEN_DW];
 			uint32_t bde_count;
 			struct ulp_bde64 bde[LPFC_MBX_WR_CONFIG_MAX_BDE];
 		} request;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index c5b26878b40a..ae2168f8a3da 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -5404,6 +5404,44 @@ lpfc_async_link_speed_to_read_top(struct lpfc_hba *phba, uint8_t speed_code)
 	return port_speed;
 }
 
+void
+lpfc_cgn_dump_rxmonitor(struct lpfc_hba *phba)
+{
+	struct rxtable_entry *entry;
+	int cnt = 0, head, tail, last, start;
+
+	head = atomic_read(&phba->rxtable_idx_head);
+	tail = atomic_read(&phba->rxtable_idx_tail);
+	if (!phba->rxtable || head == tail) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_CGN_MGMT,
+				"4411 Rxtable is empty\n");
+		return;
+	}
+	last = tail;
+	start = head;
+
+	/* Display the last LPFC_MAX_RXMONITOR_DUMP entries from the rxtable */
+	while (start != last) {
+		if (start)
+			start--;
+		else
+			start = LPFC_MAX_RXMONITOR_ENTRY - 1;
+		entry = &phba->rxtable[start];
+		lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+				"4410 %02d: MBPI %lld Xmit %lld Cmpl %lld "
+				"Lat %lld ASz %lld Info %02d BWUtil %d "
+				"Int %d slot %d\n",
+				cnt, entry->max_bytes_per_interval,
+				entry->total_bytes, entry->rcv_bytes,
+				entry->avg_io_latency, entry->avg_io_size,
+				entry->cmf_info, entry->timer_utilization,
+				entry->timer_interval, start);
+		cnt++;
+		if (cnt >= LPFC_MAX_RXMONITOR_DUMP)
+			return;
+	}
+}
+
 /**
  * lpfc_cgn_update_stat - Save data into congestion stats buffer
  * @phba: pointer to lpfc hba data structure.
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index f61223fbe644..cc54ffb5c205 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -34,9 +34,6 @@
 #define LPFC_NVME_FB_SHIFT		9
 #define LPFC_NVME_MAX_FB		(1 << 20)	/* 1M */
 
-#define LPFC_MAX_NVME_INFO_TMP_LEN	100
-#define LPFC_NVME_INFO_MORE_STR		"\nCould be more info...\n"
-
 #define lpfc_ndlp_get_nrport(ndlp)				\
 	((!ndlp->nrport || (ndlp->fc4_xpt_flags & NVME_XPT_UNREG_WAIT))\
 	? NULL : ndlp->nrport)
-- 
2.26.2

