Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4F628C4ED
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Oct 2020 00:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390578AbgJLWwJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Oct 2020 18:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbgJLWwG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Oct 2020 18:52:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F042DC0613D2
        for <linux-scsi@vger.kernel.org>; Mon, 12 Oct 2020 15:52:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y14so15095268pfp.13
        for <linux-scsi@vger.kernel.org>; Mon, 12 Oct 2020 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=/KOhNM2Quz/WyKQV8MJfRStn9E5L7/m2NtQXogjQYdA=;
        b=dQPvCPX/xDX0KduSj+4H0JlW2SAoBEfxlddFZMPzL9iSHaJwNqwCVbWCTgRL/Hozvr
         4AKkK3t5HThHMYJoFCkMvs/oj5Kzx4+W7p+ls7/SMAwaEgUGv8K1V7E+iyhWt7WBIhXl
         8+hDzDDymO2im5CkezHDq+pPgP3OjsXlDDGsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=/KOhNM2Quz/WyKQV8MJfRStn9E5L7/m2NtQXogjQYdA=;
        b=Aq3HXTh/LQQxtI3wdpfsmF19jJNQWjVVitQ+Lx3CKPpe7xV2kSdj7C/Jw/exCjFUeM
         LgcOJBnjWm4Yap/0DsZRtb2Cc7/N1M18i6YSxI2p6TByJ69MLQHIExIi31NBAzo+cW37
         j9/fQcm4jI1QN6RgUdCNlvkijbT9bQIOoYuJ489Ixt6PEXfNnZNRWphsqWLMe8APScdb
         br+dYjmsJwaTXqD9RBG9g8+CpvQKIMH43vBRDcytitGu5BET/q+azywnZYMXfV7ZYXyD
         L3qqu4a63/zKtHeQH8+ba+7OnLzlHV54H2klS1w7B+vE1tTkipm1TRJw+rP3/B8da2JE
         FqlA==
X-Gm-Message-State: AOAM533oeVM2j4mo9nO/J5F+BT65mMblDEdx/MjfcNo7hsInXzg8To2d
        pHp15ATLgdq9bSLo0kEoQU4S3vulD8wQE4pjHvw4LwcZc2B4mEiCtsXcrONKZQ6BrwbDekZos+B
        wxbsjaCkC6j5mWwwkRU1Kx+RpoYsPBDzswRNCEZipLgLwPi1Ai9lYz4GKHdOMwaqBbQYmd3kGlG
        CaEV0=
X-Google-Smtp-Source: ABdhPJzRBMksl7VB6sX7Dxq19jY27e+D5FqPc5yIbZmBnpAP07GcfX7GkLE+oRW/RaQptvDh+8hMfg==
X-Received: by 2002:a17:90b:19cc:: with SMTP id nm12mr11750271pjb.203.1602543124377;
        Mon, 12 Oct 2020 15:52:04 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x5sm21222287pfr.83.2020.10.12.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:52:03 -0700 (PDT)
From:   James Smart <james.smart@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: [PATCH v4 06/31] elx: libefc_sli: bmbx routines and SLI config commands
Date:   Mon, 12 Oct 2020 15:51:22 -0700
Message-Id: <20201012225147.54404-7-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012225147.54404-1-james.smart@broadcom.com>
References: <20201012225147.54404-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b61a0d05b181253f"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000b61a0d05b181253f
Content-Transfer-Encoding: 8bit

This patch continues the libefc_sli SLI-4 library population.

This patch adds routines to create mailbox commands used during
adapter initialization and adds APIs to issue mailbox commands to the
adapter through the bootstrap mailbox register.

Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>

---
v4:
  Changed bmbx_wait and fw_ready routines to use usleep_range and
     time_before apis
  Removed size input for all the cmds as its fixed to SLI4_BMBX_SIZE.
---
 drivers/scsi/elx/libefc_sli/sli4.c | 1167 ++++++++++++++++++++++++++++
 1 file changed, 1167 insertions(+)

diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index a9126f3a2343..f907434d9117 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -2881,3 +2881,1170 @@ sli_fc_rqe_rqid_and_index(struct sli4 *sli4, u8 *cqe, u16 *rq_id, u32 *index)
 
 	return rc;
 }
+
+static int
+sli_bmbx_wait(struct sli4 *sli4, u32 msec)
+{
+	u32 val;
+	unsigned long end;
+
+	/* Wait for the bootstrap mailbox to report "ready" */
+	end = jiffies + msecs_to_jiffies(msec);
+	do {
+		val = readl(sli4->reg[0] + SLI4_BMBX_REG);
+		if (val & SLI4_BMBX_RDY)
+			return EFC_SUCCESS;
+
+		usleep_range(1000, 2000);
+	} while (time_before(jiffies, end));
+
+	return EFC_FAIL;
+}
+
+static int
+sli_bmbx_write(struct sli4 *sli4)
+{
+	u32 val;
+
+	/* write buffer location to bootstrap mailbox register */
+	val = SLI4_BMBX_WRITE_HI(sli4->bmbx.phys);
+	writel(val, (sli4->reg[0] + SLI4_BMBX_REG));
+
+	if (sli_bmbx_wait(sli4, SLI4_BMBX_DELAY_US)) {
+		efc_log_crit(sli4, "BMBX WRITE_HI failed\n");
+		return EFC_FAIL;
+	}
+	val = SLI4_BMBX_WRITE_LO(sli4->bmbx.phys);
+	writel(val, (sli4->reg[0] + SLI4_BMBX_REG));
+
+	/* wait for SLI Port to set ready bit */
+	return sli_bmbx_wait(sli4, SLI4_BMBX_TIMEOUT_MSEC);
+}
+
+int
+sli_bmbx_command(struct sli4 *sli4)
+{
+	void *cqe = (u8 *)sli4->bmbx.virt + SLI4_BMBX_SIZE;
+
+	if (sli_fw_error_status(sli4) > 0) {
+		efc_log_crit(sli4, "Chip is in an error state -Mailbox command rejected");
+		efc_log_crit(sli4, " status=%#x error1=%#x error2=%#x\n",
+			sli_reg_read_status(sli4),
+			sli_reg_read_err1(sli4),
+			sli_reg_read_err2(sli4));
+		return EFC_FAIL;
+	}
+
+	/* Submit a command to the bootstrap mailbox and check the status */
+	if (sli_bmbx_write(sli4)) {
+		efc_log_crit(sli4, "bootstrap mailbox write fail phys=%p reg=%#x\n",
+			(void *)sli4->bmbx.phys,
+			readl(sli4->reg[0] + SLI4_BMBX_REG));
+		return EFC_FAIL;
+	}
+
+	/* check completion queue entry status */
+	if (le32_to_cpu(((struct sli4_mcqe *)cqe)->dw3_flags) &
+	    SLI4_MCQE_VALID) {
+		return sli_cqe_mq(sli4, cqe);
+	}
+	efc_log_crit(sli4, "invalid or wrong type\n");
+	return EFC_FAIL;
+}
+
+int
+sli_cmd_config_link(struct sli4 *sli4, void *buf)
+{
+	struct sli4_cmd_config_link *config_link = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	config_link->hdr.command = SLI4_MBX_CMD_CONFIG_LINK;
+
+	/* Port interprets zero in a field as "use default value" */
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_down_link(struct sli4 *sli4, void *buf)
+{
+	struct sli4_mbox_command_header *hdr = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	hdr->command = SLI4_MBX_CMD_DOWN_LINK;
+
+	/* Port interprets zero in a field as "use default value" */
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_dump_type4(struct sli4 *sli4, void *buf, u16 wki)
+{
+	struct sli4_cmd_dump4 *cmd = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	cmd->hdr.command = SLI4_MBX_CMD_DUMP;
+	cmd->type_dword = cpu_to_le32(0x4);
+	cmd->wki_selection = cpu_to_le16(wki);
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_read_transceiver_data(struct sli4 *sli4, void *buf, u32 page_num,
+				     struct efc_dma *dma)
+{
+	struct sli4_rqst_cmn_read_transceiver_data *req = NULL;
+	u32 psize;
+
+	if (!dma)
+		psize = SLI4_CFG_PYLD_LENGTH(cmn_read_transceiver_data);
+	else
+		psize = dma->size;
+
+	req = sli_config_cmd_init(sli4, buf, psize, dma);
+	if (!req)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&req->hdr, SLI4_CMN_READ_TRANS_DATA,
+			 SLI4_SUBSYSTEM_COMMON, CMD_V0,
+			 SLI4_RQST_PYLD_LEN(cmn_read_transceiver_data));
+
+	req->page_number = cpu_to_le32(page_num);
+	req->port = cpu_to_le32(sli4->port_number);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_read_link_stats(struct sli4 *sli4, void *buf, u8 req_ext_counters,
+			u8 clear_overflow_flags,
+			u8 clear_all_counters)
+{
+	struct sli4_cmd_read_link_stats *cmd = buf;
+	u32 flags;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	cmd->hdr.command = SLI4_MBX_CMD_READ_LNK_STAT;
+
+	flags = 0;
+	if (req_ext_counters)
+		flags |= SLI4_READ_LNKSTAT_REC;
+	if (clear_all_counters)
+		flags |= SLI4_READ_LNKSTAT_CLRC;
+	if (clear_overflow_flags)
+		flags |= SLI4_READ_LNKSTAT_CLOF;
+
+	cmd->dw1_flags = cpu_to_le32(flags);
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_read_status(struct sli4 *sli4, void *buf, u8 clear_counters)
+{
+	struct sli4_cmd_read_status *cmd = buf;
+	u32 flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	cmd->hdr.command = SLI4_MBX_CMD_READ_STATUS;
+	if (clear_counters)
+		flags |= SLI4_READSTATUS_CLEAR_COUNTERS;
+	else
+		flags &= ~SLI4_READSTATUS_CLEAR_COUNTERS;
+
+	cmd->dw1_flags = cpu_to_le32(flags);
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_init_link(struct sli4 *sli4, void *buf, u32 speed, u8 reset_alpa)
+{
+	struct sli4_cmd_init_link *init_link = buf;
+	u32 flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	init_link->hdr.command = SLI4_MBX_CMD_INIT_LINK;
+
+	init_link->sel_reset_al_pa_dword =
+				cpu_to_le32(reset_alpa);
+	flags &= ~SLI4_INIT_LINK_F_LOOPBACK;
+
+	init_link->link_speed_sel_code = cpu_to_le32(speed);
+	switch (speed) {
+	case SLI4_LINK_SPEED_1G:
+	case SLI4_LINK_SPEED_2G:
+	case SLI4_LINK_SPEED_4G:
+	case SLI4_LINK_SPEED_8G:
+	case SLI4_LINK_SPEED_16G:
+	case SLI4_LINK_SPEED_32G:
+	case SLI4_LINK_SPEED_64G:
+		flags |= SLI4_INIT_LINK_F_FIXED_SPEED;
+		break;
+	case SLI4_LINK_SPEED_10G:
+		efc_log_info(sli4, "unsupported FC speed %d\n", speed);
+		init_link->flags0 = cpu_to_le32(flags);
+		return EFC_FAIL;
+	}
+
+	switch (sli4->topology) {
+	case SLI4_READ_CFG_TOPO_FC:
+		/* Attempt P2P but failover to FC-AL */
+		flags |= SLI4_INIT_LINK_F_FAIL_OVER;
+		flags |= SLI4_INIT_LINK_F_P2P_FAIL_OVER;
+		break;
+	case SLI4_READ_CFG_TOPO_FC_AL:
+		flags |= SLI4_INIT_LINK_F_FCAL_ONLY;
+		if (speed == SLI4_LINK_SPEED_16G ||
+		    speed == SLI4_LINK_SPEED_32G) {
+			efc_log_info(sli4, "unsupported FC-AL speed %d\n",
+				     speed);
+			init_link->flags0 = cpu_to_le32(flags);
+			return EFC_FAIL;
+		}
+		break;
+	case SLI4_READ_CFG_TOPO_FC_DA:
+		flags |= SLI4_INIT_LINK_F_P2P_ONLY;
+		break;
+	default:
+
+		efc_log_info(sli4, "unsupported topology %#x\n",
+			sli4->topology);
+
+		init_link->flags0 = cpu_to_le32(flags);
+		return EFC_FAIL;
+	}
+
+	flags &= ~SLI4_INIT_LINK_F_UNFAIR;
+	flags &= ~SLI4_INIT_LINK_F_NO_LIRP;
+	flags &= ~SLI4_INIT_LINK_F_LOOP_VALID_CHK;
+	flags &= ~SLI4_INIT_LINK_F_NO_LISA;
+	flags &= ~SLI4_INIT_LINK_F_PICK_HI_ALPA;
+	init_link->flags0 = cpu_to_le32(flags);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_init_vfi(struct sli4 *sli4, void *buf, u16 vfi, u16 fcfi, u16 vpi)
+{
+	struct sli4_cmd_init_vfi *init_vfi = buf;
+	u16 flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	init_vfi->hdr.command = SLI4_MBX_CMD_INIT_VFI;
+	init_vfi->vfi = cpu_to_le16(vfi);
+	init_vfi->fcfi = cpu_to_le16(fcfi);
+
+	/*
+	 * If the VPI is valid, initialize it at the same time as
+	 * the VFI
+	 */
+	if (vpi != U16_MAX) {
+		flags |= SLI4_INIT_VFI_FLAG_VP;
+		init_vfi->flags0_word = cpu_to_le16(flags);
+		init_vfi->vpi = cpu_to_le16(vpi);
+	}
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_init_vpi(struct sli4 *sli4, void *buf, u16 vpi, u16 vfi)
+{
+	struct sli4_cmd_init_vpi *init_vpi = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	init_vpi->hdr.command = SLI4_MBX_CMD_INIT_VPI;
+	init_vpi->vpi = cpu_to_le16(vpi);
+	init_vpi->vfi = cpu_to_le16(vfi);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_post_xri(struct sli4 *sli4, void *buf, u16 xri_base, u16 xri_count)
+{
+	struct sli4_cmd_post_xri *post_xri = buf;
+	u16 xri_count_flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	post_xri->hdr.command = SLI4_MBX_CMD_POST_XRI;
+	post_xri->xri_base = cpu_to_le16(xri_base);
+	xri_count_flags = xri_count & SLI4_POST_XRI_COUNT;
+	xri_count_flags |= SLI4_POST_XRI_FLAG_ENX;
+	xri_count_flags |= SLI4_POST_XRI_FLAG_VAL;
+	post_xri->xri_count_flags = cpu_to_le16(xri_count_flags);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_release_xri(struct sli4 *sli4, void *buf, u8 num_xri)
+{
+	struct sli4_cmd_release_xri *release_xri = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	release_xri->hdr.command = SLI4_MBX_CMD_RELEASE_XRI;
+	release_xri->xri_count_word = cpu_to_le16(num_xri &
+					SLI4_RELEASE_XRI_COUNT);
+
+	return EFC_SUCCESS;
+}
+
+static int
+sli_cmd_read_config(struct sli4 *sli4, void *buf)
+{
+	struct sli4_cmd_read_config *read_config = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	read_config->hdr.command = SLI4_MBX_CMD_READ_CONFIG;
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_read_nvparms(struct sli4 *sli4, void *buf)
+{
+	struct sli4_cmd_read_nvparms *read_nvparms = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	read_nvparms->hdr.command = SLI4_MBX_CMD_READ_NVPARMS;
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_write_nvparms(struct sli4 *sli4, void *buf, u8 *wwpn, u8 *wwnn,
+			u8 hard_alpa, u32 preferred_d_id)
+{
+	struct sli4_cmd_write_nvparms *write_nvparms = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	write_nvparms->hdr.command = SLI4_MBX_CMD_WRITE_NVPARMS;
+	memcpy(write_nvparms->wwpn, wwpn, 8);
+	memcpy(write_nvparms->wwnn, wwnn, 8);
+
+	write_nvparms->hard_alpa_d_id =
+			cpu_to_le32((preferred_d_id << 8) | hard_alpa);
+	return EFC_SUCCESS;
+}
+
+static int
+sli_cmd_read_rev(struct sli4 *sli4, void *buf, struct efc_dma *vpd)
+{
+	struct sli4_cmd_read_rev *read_rev = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	read_rev->hdr.command = SLI4_MBX_CMD_READ_REV;
+
+	if (vpd && vpd->size) {
+		read_rev->flags0_word |= cpu_to_le16(SLI4_READ_REV_FLAG_VPD);
+
+		read_rev->available_length_dword =
+			cpu_to_le32(vpd->size &
+				    SLI4_READ_REV_AVAILABLE_LENGTH);
+
+		read_rev->hostbuf.low =
+				cpu_to_le32(lower_32_bits(vpd->phys));
+		read_rev->hostbuf.high =
+				cpu_to_le32(upper_32_bits(vpd->phys));
+	}
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_read_sparm64(struct sli4 *sli4, void *buf, struct efc_dma *dma, u16 vpi)
+{
+	struct sli4_cmd_read_sparm64 *read_sparm64 = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	if (vpi == U16_MAX) {
+		efc_log_err(sli4, "special VPI not supported!!!\n");
+		return EFC_FAIL;
+	}
+
+	if (!dma || !dma->phys) {
+		efc_log_err(sli4, "bad DMA buffer\n");
+		return EFC_FAIL;
+	}
+
+	read_sparm64->hdr.command = SLI4_MBX_CMD_READ_SPARM64;
+
+	read_sparm64->bde_64.bde_type_buflen =
+			cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+				    (dma->size & SLI4_BDE_LEN_MASK));
+	read_sparm64->bde_64.u.data.low =
+			cpu_to_le32(lower_32_bits(dma->phys));
+	read_sparm64->bde_64.u.data.high =
+			cpu_to_le32(upper_32_bits(dma->phys));
+
+	read_sparm64->vpi = cpu_to_le16(vpi);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_read_topology(struct sli4 *sli4, void *buf, struct efc_dma *dma)
+{
+	struct sli4_cmd_read_topology *read_topo = buf;
+
+	if (!dma || !dma->size)
+		return EFC_FAIL;
+
+	if (dma->size < SLI4_MIN_LOOP_MAP_BYTES) {
+		efc_log_err(sli4, "loop map buffer too small %zx\n", dma->size);
+		return EFC_FAIL;
+	}
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	read_topo->hdr.command = SLI4_MBX_CMD_READ_TOPOLOGY;
+
+	memset(dma->virt, 0, dma->size);
+
+	read_topo->bde_loop_map.bde_type_buflen =
+					cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+					(dma->size & SLI4_BDE_LEN_MASK));
+	read_topo->bde_loop_map.u.data.low  =
+				cpu_to_le32(lower_32_bits(dma->phys));
+	read_topo->bde_loop_map.u.data.high =
+				cpu_to_le32(upper_32_bits(dma->phys));
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_reg_fcfi(struct sli4 *sli4, void *buf, u16 index,
+		 struct sli4_cmd_rq_cfg rq_cfg[SLI4_CMD_REG_FCFI_NUM_RQ_CFG])
+{
+	struct sli4_cmd_reg_fcfi *reg_fcfi = buf;
+	u32 i;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	reg_fcfi->hdr.command = SLI4_MBX_CMD_REG_FCFI;
+
+	reg_fcfi->fcf_index = cpu_to_le16(index);
+
+	for (i = 0; i < SLI4_CMD_REG_FCFI_NUM_RQ_CFG; i++) {
+		switch (i) {
+		case 0:
+			reg_fcfi->rqid0 = rq_cfg[0].rq_id;
+			break;
+		case 1:
+			reg_fcfi->rqid1 = rq_cfg[1].rq_id;
+			break;
+		case 2:
+			reg_fcfi->rqid2 = rq_cfg[2].rq_id;
+			break;
+		case 3:
+			reg_fcfi->rqid3 = rq_cfg[3].rq_id;
+			break;
+		}
+		reg_fcfi->rq_cfg[i].r_ctl_mask = rq_cfg[i].r_ctl_mask;
+		reg_fcfi->rq_cfg[i].r_ctl_match = rq_cfg[i].r_ctl_match;
+		reg_fcfi->rq_cfg[i].type_mask = rq_cfg[i].type_mask;
+		reg_fcfi->rq_cfg[i].type_match = rq_cfg[i].type_match;
+	}
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_reg_fcfi_mrq(struct sli4 *sli4, void *buf, u8 mode, u16 fcf_index,
+		     u8 rq_selection_policy, u8 mrq_bit_mask, u16 num_mrqs,
+		struct sli4_cmd_rq_cfg rq_cfg[SLI4_CMD_REG_FCFI_NUM_RQ_CFG])
+{
+	struct sli4_cmd_reg_fcfi_mrq *reg_fcfi_mrq = buf;
+	u32 i;
+	u32 mrq_flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	reg_fcfi_mrq->hdr.command = SLI4_MBX_CMD_REG_FCFI_MRQ;
+	if (mode == SLI4_CMD_REG_FCFI_SET_FCFI_MODE) {
+		reg_fcfi_mrq->fcf_index = cpu_to_le16(fcf_index);
+		goto done;
+	}
+
+	reg_fcfi_mrq->dw8_vlan = cpu_to_le32(SLI4_REGFCFI_MRQ_MODE);
+
+	for (i = 0; i < SLI4_CMD_REG_FCFI_NUM_RQ_CFG; i++) {
+		reg_fcfi_mrq->rq_cfg[i].r_ctl_mask = rq_cfg[i].r_ctl_mask;
+		reg_fcfi_mrq->rq_cfg[i].r_ctl_match = rq_cfg[i].r_ctl_match;
+		reg_fcfi_mrq->rq_cfg[i].type_mask = rq_cfg[i].type_mask;
+		reg_fcfi_mrq->rq_cfg[i].type_match = rq_cfg[i].type_match;
+
+		switch (i) {
+		case 3:
+			reg_fcfi_mrq->rqid3 = rq_cfg[i].rq_id;
+			break;
+		case 2:
+			reg_fcfi_mrq->rqid2 = rq_cfg[i].rq_id;
+			break;
+		case 1:
+			reg_fcfi_mrq->rqid1 = rq_cfg[i].rq_id;
+			break;
+		case 0:
+			reg_fcfi_mrq->rqid0 = rq_cfg[i].rq_id;
+			break;
+		}
+	}
+
+	mrq_flags = num_mrqs & SLI4_REGFCFI_MRQ_MASK_NUM_PAIRS;
+	mrq_flags |= (mrq_bit_mask << 8);
+	mrq_flags |= (rq_selection_policy << 12);
+	reg_fcfi_mrq->dw9_mrqflags = cpu_to_le32(mrq_flags);
+done:
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_reg_rpi(struct sli4 *sli4, void *buf, u32 rpi, u32 vpi, u32 fc_id,
+		struct efc_dma *dma, u8 update, u8 enable_t10_pi)
+{
+	struct sli4_cmd_reg_rpi *reg_rpi = buf;
+	u32 rportid_flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	reg_rpi->hdr.command = SLI4_MBX_CMD_REG_RPI;
+
+	reg_rpi->rpi = cpu_to_le16(rpi);
+
+	rportid_flags = fc_id & SLI4_REGRPI_REMOTE_N_PORTID;
+
+	if (update)
+		rportid_flags |= SLI4_REGRPI_UPD;
+	else
+		rportid_flags &= ~SLI4_REGRPI_UPD;
+
+	if (enable_t10_pi)
+		rportid_flags |= SLI4_REGRPI_ETOW;
+	else
+		rportid_flags &= ~SLI4_REGRPI_ETOW;
+
+	reg_rpi->dw2_rportid_flags = cpu_to_le32(rportid_flags);
+
+	reg_rpi->bde_64.bde_type_buflen =
+		cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			    (SLI4_REG_RPI_BUF_LEN & SLI4_BDE_LEN_MASK));
+	reg_rpi->bde_64.u.data.low  =
+		cpu_to_le32(lower_32_bits(dma->phys));
+	reg_rpi->bde_64.u.data.high =
+		cpu_to_le32(upper_32_bits(dma->phys));
+
+	reg_rpi->vpi = cpu_to_le16(vpi);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_reg_vfi(struct sli4 *sli4, void *buf, size_t size,
+		u16 vfi, u16 fcfi, struct efc_dma dma,
+		u16 vpi, __be64 sli_wwpn, u32 fc_id)
+{
+	struct sli4_cmd_reg_vfi *reg_vfi = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	reg_vfi->hdr.command = SLI4_MBX_CMD_REG_VFI;
+
+	reg_vfi->vfi = cpu_to_le16(vfi);
+
+	reg_vfi->fcfi = cpu_to_le16(fcfi);
+
+	reg_vfi->sparm.bde_type_buflen =
+		cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			    (SLI4_REG_RPI_BUF_LEN & SLI4_BDE_LEN_MASK));
+	reg_vfi->sparm.u.data.low  =
+		cpu_to_le32(lower_32_bits(dma.phys));
+	reg_vfi->sparm.u.data.high =
+		cpu_to_le32(upper_32_bits(dma.phys));
+
+	reg_vfi->e_d_tov = cpu_to_le32(sli4->e_d_tov);
+	reg_vfi->r_a_tov = cpu_to_le32(sli4->r_a_tov);
+
+	reg_vfi->dw0w1_flags |= cpu_to_le16(SLI4_REGVFI_VP);
+	reg_vfi->vpi = cpu_to_le16(vpi);
+	memcpy(reg_vfi->wwpn, &sli_wwpn, sizeof(reg_vfi->wwpn));
+	reg_vfi->dw10_lportid_flags = cpu_to_le32(fc_id);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_reg_vpi(struct sli4 *sli4, void *buf, u32 fc_id, __be64 sli_wwpn,
+		u16 vpi, u16 vfi, bool update)
+{
+	struct sli4_cmd_reg_vpi *reg_vpi = buf;
+	u32 flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	reg_vpi->hdr.command = SLI4_MBX_CMD_REG_VPI;
+
+	flags = (fc_id & SLI4_REGVPI_LOCAL_N_PORTID);
+	if (update)
+		flags |= SLI4_REGVPI_UPD;
+	else
+		flags &= ~SLI4_REGVPI_UPD;
+
+	reg_vpi->dw2_lportid_flags = cpu_to_le32(flags);
+	memcpy(reg_vpi->wwpn, &sli_wwpn, sizeof(reg_vpi->wwpn));
+	reg_vpi->vpi = cpu_to_le16(vpi);
+	reg_vpi->vfi = cpu_to_le16(vfi);
+
+	return EFC_SUCCESS;
+}
+
+static int
+sli_cmd_request_features(struct sli4 *sli4, void *buf, u32 features_mask,
+			 bool query)
+{
+	struct sli4_cmd_request_features *req_features = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	req_features->hdr.command = SLI4_MBX_CMD_RQST_FEATURES;
+
+	if (query)
+		req_features->dw1_qry = cpu_to_le32(SLI4_REQFEAT_QRY);
+
+	req_features->cmd = cpu_to_le32(features_mask);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_unreg_fcfi(struct sli4 *sli4, void *buf, u16 indicator)
+{
+	struct sli4_cmd_unreg_fcfi *unreg_fcfi = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	unreg_fcfi->hdr.command = SLI4_MBX_CMD_UNREG_FCFI;
+	unreg_fcfi->fcfi = cpu_to_le16(indicator);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_unreg_rpi(struct sli4 *sli4, void *buf, u16 indicator,
+		  enum sli4_resource which, u32 fc_id)
+{
+	struct sli4_cmd_unreg_rpi *unreg_rpi = buf;
+	u32 flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	unreg_rpi->hdr.command = SLI4_MBX_CMD_UNREG_RPI;
+	switch (which) {
+	case SLI4_RSRC_RPI:
+		flags |= SLI4_UNREG_RPI_II_RPI;
+		if (fc_id == U32_MAX)
+			break;
+
+		flags |= SLI4_UNREG_RPI_DP;
+		unreg_rpi->dw2_dest_n_portid =
+			cpu_to_le32(fc_id & SLI4_UNREG_RPI_DEST_N_PORTID_MASK);
+		break;
+	case SLI4_RSRC_VPI:
+		flags |= SLI4_UNREG_RPI_II_VPI;
+		break;
+	case SLI4_RSRC_VFI:
+		flags |= SLI4_UNREG_RPI_II_VFI;
+		break;
+	case SLI4_RSRC_FCFI:
+		flags |= SLI4_UNREG_RPI_II_FCFI;
+		break;
+	default:
+		efc_log_info(sli4, "unknown type %#x\n", which);
+		return EFC_FAIL;
+	}
+
+	unreg_rpi->dw1w1_flags = cpu_to_le16(flags);
+	unreg_rpi->index = cpu_to_le16(indicator);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_unreg_vfi(struct sli4 *sli4, void *buf, u16 index, u32 which)
+{
+	struct sli4_cmd_unreg_vfi *unreg_vfi = buf;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	unreg_vfi->hdr.command = SLI4_MBX_CMD_UNREG_VFI;
+	switch (which) {
+	case SLI4_UNREG_TYPE_DOMAIN:
+		unreg_vfi->index = cpu_to_le16(index);
+		break;
+	case SLI4_UNREG_TYPE_FCF:
+		unreg_vfi->index = cpu_to_le16(index);
+		break;
+	case SLI4_UNREG_TYPE_ALL:
+		unreg_vfi->index = cpu_to_le16(U32_MAX);
+		break;
+	default:
+		return EFC_FAIL;
+	}
+
+	if (which != SLI4_UNREG_TYPE_DOMAIN)
+		unreg_vfi->dw2_flags = cpu_to_le16(SLI4_UNREG_VFI_II_FCFI);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_unreg_vpi(struct sli4 *sli4, void *buf, u16 indicator, u32 which)
+{
+	struct sli4_cmd_unreg_vpi *unreg_vpi = buf;
+	u32 flags = 0;
+
+	memset(buf, 0, SLI4_BMBX_SIZE);
+
+	unreg_vpi->hdr.command = SLI4_MBX_CMD_UNREG_VPI;
+	unreg_vpi->index = cpu_to_le16(indicator);
+	switch (which) {
+	case SLI4_UNREG_TYPE_PORT:
+		flags |= SLI4_UNREG_VPI_II_VPI;
+		break;
+	case SLI4_UNREG_TYPE_DOMAIN:
+		flags |= SLI4_UNREG_VPI_II_VFI;
+		break;
+	case SLI4_UNREG_TYPE_FCF:
+		flags |= SLI4_UNREG_VPI_II_FCFI;
+		break;
+	case SLI4_UNREG_TYPE_ALL:
+		/* override indicator */
+		unreg_vpi->index = cpu_to_le16(U32_MAX);
+		flags |= SLI4_UNREG_VPI_II_FCFI;
+		break;
+	default:
+		return EFC_FAIL;
+	}
+
+	unreg_vpi->dw2w0_flags = cpu_to_le16(flags);
+	return EFC_SUCCESS;
+}
+
+static int
+sli_cmd_common_modify_eq_delay(struct sli4 *sli4, void *buf,
+			       struct sli4_queue *q, int num_q, u32 shift,
+			       u32 delay_mult)
+{
+	struct sli4_rqst_cmn_modify_eq_delay *req = NULL;
+	int i;
+
+	req = sli_config_cmd_init(sli4, buf,
+			SLI4_CFG_PYLD_LENGTH(cmn_modify_eq_delay), NULL);
+	if (!req)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&req->hdr, SLI4_CMN_MODIFY_EQ_DELAY,
+			 SLI4_SUBSYSTEM_COMMON, CMD_V0,
+			 SLI4_RQST_PYLD_LEN(cmn_modify_eq_delay));
+	req->num_eq = cpu_to_le32(num_q);
+
+	for (i = 0; i < num_q; i++) {
+		req->eq_delay_record[i].eq_id = cpu_to_le32(q[i].id);
+		req->eq_delay_record[i].phase = cpu_to_le32(shift);
+		req->eq_delay_record[i].delay_multiplier =
+			cpu_to_le32(delay_mult);
+	}
+
+	return EFC_SUCCESS;
+}
+
+void
+sli4_cmd_lowlevel_set_watchdog(struct sli4 *sli4, void *buf,
+			       size_t size, u16 timeout)
+{
+	struct sli4_rqst_lowlevel_set_watchdog *req = NULL;
+
+	req = sli_config_cmd_init(sli4, buf,
+			SLI4_CFG_PYLD_LENGTH(lowlevel_set_watchdog), NULL);
+	if (!req)
+		return;
+
+	sli_cmd_fill_hdr(&req->hdr, SLI4_OPC_LOWLEVEL_SET_WATCHDOG,
+			 SLI4_SUBSYSTEM_LOWLEVEL, CMD_V0,
+			 SLI4_RQST_PYLD_LEN(lowlevel_set_watchdog));
+	req->watchdog_timeout = cpu_to_le16(timeout);
+}
+
+static int
+sli_cmd_common_get_cntl_attributes(struct sli4 *sli4, void *buf,
+				   struct efc_dma *dma)
+{
+	struct sli4_rqst_hdr *hdr = NULL;
+
+	hdr = sli_config_cmd_init(sli4, buf, SLI4_RQST_CMDSZ(hdr), dma);
+	if (!hdr)
+		return EFC_FAIL;
+
+	hdr->opcode = SLI4_CMN_GET_CNTL_ATTRIBUTES;
+	hdr->subsystem = SLI4_SUBSYSTEM_COMMON;
+	hdr->request_length = cpu_to_le32(dma->size);
+
+	return EFC_SUCCESS;
+}
+
+static int
+sli_cmd_common_get_cntl_addl_attributes(struct sli4 *sli4, void *buf,
+					struct efc_dma *dma)
+{
+	struct sli4_rqst_hdr *hdr = NULL;
+
+	hdr = sli_config_cmd_init(sli4, buf, SLI4_RQST_CMDSZ(hdr), dma);
+	if (!hdr)
+		return EFC_FAIL;
+
+	hdr->opcode = SLI4_CMN_GET_CNTL_ADDL_ATTRS;
+	hdr->subsystem = SLI4_SUBSYSTEM_COMMON;
+	hdr->request_length = cpu_to_le32(dma->size);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_nop(struct sli4 *sli4, void *buf, uint64_t context)
+{
+	struct sli4_rqst_cmn_nop *nop = NULL;
+
+	nop = sli_config_cmd_init(sli4, buf, SLI4_CFG_PYLD_LENGTH(cmn_nop),
+				  NULL);
+	if (!nop)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&nop->hdr, SLI4_CMN_NOP, SLI4_SUBSYSTEM_COMMON,
+			 CMD_V0, SLI4_RQST_PYLD_LEN(cmn_nop));
+
+	memcpy(&nop->context, &context, sizeof(context));
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_get_resource_extent_info(struct sli4 *sli4, void *buf, u16 rtype)
+{
+	struct sli4_rqst_cmn_get_resource_extent_info *ext = NULL;
+
+	ext = sli_config_cmd_init(sli4, buf,
+			SLI4_RQST_CMDSZ(cmn_get_resource_extent_info), NULL);
+	if (!ext)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&ext->hdr, SLI4_CMN_GET_RSC_EXTENT_INFO,
+			 SLI4_SUBSYSTEM_COMMON, CMD_V0,
+			 SLI4_RQST_PYLD_LEN(cmn_get_resource_extent_info));
+
+	ext->resource_type = cpu_to_le16(rtype);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_get_sli4_parameters(struct sli4 *sli4, void *buf)
+{
+	struct sli4_rqst_hdr *hdr = NULL;
+
+	hdr = sli_config_cmd_init(sli4, buf,
+			SLI4_CFG_PYLD_LENGTH(cmn_get_sli4_params), NULL);
+	if (!hdr)
+		return EFC_FAIL;
+
+	hdr->opcode = SLI4_CMN_GET_SLI4_PARAMS;
+	hdr->subsystem = SLI4_SUBSYSTEM_COMMON;
+	hdr->request_length = SLI4_RQST_PYLD_LEN(cmn_get_sli4_params);
+
+	return EFC_SUCCESS;
+}
+
+static int
+sli_cmd_common_get_port_name(struct sli4 *sli4, void *buf)
+{
+	struct sli4_rqst_cmn_get_port_name *pname;
+
+	pname = sli_config_cmd_init(sli4, buf,
+			SLI4_CFG_PYLD_LENGTH(cmn_get_port_name), NULL);
+	if (!pname)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&pname->hdr, SLI4_CMN_GET_PORT_NAME,
+			 SLI4_SUBSYSTEM_COMMON, CMD_V1,
+			 SLI4_RQST_PYLD_LEN(cmn_get_port_name));
+
+	/* Set the port type value (ethernet=0, FC=1) for V1 commands */
+	pname->port_type = SLI4_PORT_TYPE_FC;
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_write_object(struct sli4 *sli4, void *buf, u16 noc,
+			    u16 eof, u32 desired_write_length,
+			    u32 offset, char *object_name,
+			    struct efc_dma *dma)
+{
+	struct sli4_rqst_cmn_write_object *wr_obj = NULL;
+	struct sli4_bde *bde;
+	u32 dwflags = 0;
+
+	wr_obj = sli_config_cmd_init(sli4, buf,
+			SLI4_RQST_CMDSZ(cmn_write_object) + sizeof(*bde), NULL);
+	if (!wr_obj)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&wr_obj->hdr, SLI4_CMN_WRITE_OBJECT,
+		SLI4_SUBSYSTEM_COMMON, CMD_V0,
+		SLI4_RQST_PYLD_LEN_VAR(cmn_write_object, sizeof(*bde)));
+
+	if (noc)
+		dwflags |= SLI4_RQ_DES_WRITE_LEN_NOC;
+	if (eof)
+		dwflags |= SLI4_RQ_DES_WRITE_LEN_EOF;
+	dwflags |= (desired_write_length & SLI4_RQ_DES_WRITE_LEN);
+
+	wr_obj->desired_write_len_dword = cpu_to_le32(dwflags);
+
+	wr_obj->write_offset = cpu_to_le32(offset);
+	strncpy(wr_obj->object_name, object_name, sizeof(wr_obj->object_name));
+	wr_obj->host_buffer_descriptor_count = cpu_to_le32(1);
+
+	bde = (struct sli4_bde *)wr_obj->host_buffer_descriptor;
+
+	/* Setup to transfer xfer_size bytes to device */
+	bde->bde_type_buflen =
+		cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			    (desired_write_length & SLI4_BDE_LEN_MASK));
+	bde->u.data.low = cpu_to_le32(lower_32_bits(dma->phys));
+	bde->u.data.high = cpu_to_le32(upper_32_bits(dma->phys));
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_delete_object(struct sli4 *sli4, void *buf, char *object_name)
+{
+	struct sli4_rqst_cmn_delete_object *req = NULL;
+
+	req = sli_config_cmd_init(sli4, buf,
+				  SLI4_RQST_CMDSZ(cmn_delete_object), NULL);
+	if (!req)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&req->hdr, SLI4_CMN_DELETE_OBJECT,
+			 SLI4_SUBSYSTEM_COMMON, CMD_V0,
+			 SLI4_RQST_PYLD_LEN(cmn_delete_object));
+
+	strncpy(req->object_name, object_name, sizeof(req->object_name));
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_read_object(struct sli4 *sli4, void *buf, u32 desired_read_len,
+			   u32 offset, char *object_name, struct efc_dma *dma)
+{
+	struct sli4_rqst_cmn_read_object *rd_obj = NULL;
+	struct sli4_bde *bde;
+
+	rd_obj = sli_config_cmd_init(sli4, buf,
+			SLI4_RQST_CMDSZ(cmn_read_object) + sizeof(*bde), NULL);
+	if (!rd_obj)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&rd_obj->hdr, SLI4_CMN_READ_OBJECT,
+		SLI4_SUBSYSTEM_COMMON, CMD_V0,
+		SLI4_RQST_PYLD_LEN_VAR(cmn_read_object, sizeof(*bde)));
+	rd_obj->desired_read_length_dword =
+		cpu_to_le32(desired_read_len & SLI4_REQ_DESIRE_READLEN);
+
+	rd_obj->read_offset = cpu_to_le32(offset);
+	strncpy(rd_obj->object_name, object_name, sizeof(rd_obj->object_name));
+	rd_obj->host_buffer_descriptor_count = cpu_to_le32(1);
+
+	bde = (struct sli4_bde *)rd_obj->host_buffer_descriptor;
+
+	/* Setup to transfer xfer_size bytes to device */
+	bde->bde_type_buflen =
+		cpu_to_le32((SLI4_BDE_TYPE_VAL(64)) |
+			    (desired_read_len & SLI4_BDE_LEN_MASK));
+	if (dma) {
+		bde->u.data.low = cpu_to_le32(lower_32_bits(dma->phys));
+		bde->u.data.high = cpu_to_le32(upper_32_bits(dma->phys));
+	} else {
+		bde->u.data.low = 0;
+		bde->u.data.high = 0;
+	}
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_dmtf_exec_clp_cmd(struct sli4 *sli4, void *buf, struct efc_dma *cmd,
+			  struct efc_dma *resp)
+{
+	struct sli4_rqst_dmtf_exec_clp_cmd *clp_cmd = NULL;
+
+	clp_cmd = sli_config_cmd_init(sli4, buf,
+				SLI4_RQST_CMDSZ(dmtf_exec_clp_cmd), NULL);
+	if (!clp_cmd)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&clp_cmd->hdr, DMTF_EXEC_CLP_CMD, SLI4_SUBSYSTEM_DMTF,
+			 CMD_V0, SLI4_RQST_PYLD_LEN(dmtf_exec_clp_cmd));
+
+	clp_cmd->cmd_buf_length = cpu_to_le32(cmd->size);
+	clp_cmd->cmd_buf_addr_low =  cpu_to_le32(lower_32_bits(cmd->phys));
+	clp_cmd->cmd_buf_addr_high =  cpu_to_le32(upper_32_bits(cmd->phys));
+	clp_cmd->resp_buf_length = cpu_to_le32(resp->size);
+	clp_cmd->resp_buf_addr_low =  cpu_to_le32(lower_32_bits(resp->phys));
+	clp_cmd->resp_buf_addr_high =  cpu_to_le32(upper_32_bits(resp->phys));
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_set_dump_location(struct sli4 *sli4, void *buf, bool query,
+				 bool is_buffer_list,
+				 struct efc_dma *buffer, u8 fdb)
+{
+	struct sli4_rqst_cmn_set_dump_location *set_dump_loc = NULL;
+	u32 buffer_length_flag = 0;
+
+	set_dump_loc = sli_config_cmd_init(sli4, buf,
+				SLI4_RQST_CMDSZ(cmn_set_dump_location), NULL);
+	if (!set_dump_loc)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&set_dump_loc->hdr, SLI4_CMN_SET_DUMP_LOCATION,
+			 SLI4_SUBSYSTEM_COMMON, CMD_V0,
+			 SLI4_RQST_PYLD_LEN(cmn_set_dump_location));
+
+	if (is_buffer_list)
+		buffer_length_flag |= SLI4_CMN_SET_DUMP_BLP;
+
+	if (query)
+		buffer_length_flag |= SLI4_CMN_SET_DUMP_QRY;
+
+	if (fdb)
+		buffer_length_flag |= SLI4_CMN_SET_DUMP_FDB;
+
+	if (buffer) {
+		set_dump_loc->buf_addr_low =
+			cpu_to_le32(lower_32_bits(buffer->phys));
+		set_dump_loc->buf_addr_high =
+			cpu_to_le32(upper_32_bits(buffer->phys));
+
+		buffer_length_flag |=
+			buffer->len & SLI4_CMN_SET_DUMP_BUFFER_LEN;
+	} else {
+		set_dump_loc->buf_addr_low = 0;
+		set_dump_loc->buf_addr_high = 0;
+		set_dump_loc->buffer_length_dword = 0;
+	}
+	set_dump_loc->buffer_length_dword = cpu_to_le32(buffer_length_flag);
+	return EFC_SUCCESS;
+}
+
+int
+sli_cmd_common_set_features(struct sli4 *sli4, void *buf, u32 feature,
+			    u32 param_len, void *parameter)
+{
+	struct sli4_rqst_cmn_set_features *cmd = NULL;
+
+	cmd = sli_config_cmd_init(sli4, buf,
+				  SLI4_RQST_CMDSZ(cmn_set_features), NULL);
+	if (!cmd)
+		return EFC_FAIL;
+
+	sli_cmd_fill_hdr(&cmd->hdr, SLI4_CMN_SET_FEATURES,
+			 SLI4_SUBSYSTEM_COMMON, CMD_V0,
+			 SLI4_RQST_PYLD_LEN(cmn_set_features));
+
+	cmd->feature = cpu_to_le32(feature);
+	cmd->param_len = cpu_to_le32(param_len);
+	memcpy(cmd->params, parameter, param_len);
+
+	return EFC_SUCCESS;
+}
+
+int
+sli_cqe_mq(struct sli4 *sli4, void *buf)
+{
+	struct sli4_mcqe *mcqe = buf;
+	u32 dwflags = le32_to_cpu(mcqe->dw3_flags);
+	/*
+	 * Firmware can split mbx completions into two MCQEs: first with only
+	 * the "consumed" bit set and a second with the "complete" bit set.
+	 * Thus, ignore MCQE unless "complete" is set.
+	 */
+	if (!(dwflags & SLI4_MCQE_COMPLETED))
+		return SLI4_MCQE_STATUS_NOT_COMPLETED;
+
+	if (le16_to_cpu(mcqe->completion_status)) {
+		efc_log_info(sli4, "status(st=%#x ext=%#x con=%d cmp=%d ae=%d val=%d)\n",
+			le16_to_cpu(mcqe->completion_status),
+			      le16_to_cpu(mcqe->extended_status),
+			      (dwflags & SLI4_MCQE_CONSUMED),
+			      (dwflags & SLI4_MCQE_COMPLETED),
+			      (dwflags & SLI4_MCQE_AE),
+			      (dwflags & SLI4_MCQE_VALID));
+	}
+
+	return le16_to_cpu(mcqe->completion_status);
+}
+
+int
+sli_cqe_async(struct sli4 *sli4, void *buf)
+{
+	struct sli4_acqe *acqe = buf;
+	int rc = EFC_FAIL;
+
+	if (!buf) {
+		efc_log_err(sli4, "bad parameter sli4=%p buf=%p\n", sli4, buf);
+		return EFC_FAIL;
+	}
+
+	switch (acqe->event_code) {
+	case SLI4_ACQE_EVENT_CODE_LINK_STATE:
+		efc_log_info(sli4, "Unsupported by FC link, evt code:%#x\n",
+			     acqe->event_code);
+		break;
+	case SLI4_ACQE_EVENT_CODE_GRP_5:
+		efc_log_info(sli4, "ACQE GRP5\n");
+		break;
+	case SLI4_ACQE_EVENT_CODE_SLI_PORT_EVENT:
+		efc_log_info(sli4, "ACQE SLI Port, type=0x%x, data1,2=0x%08x,0x%08x\n",
+			acqe->event_type,
+			le32_to_cpu(acqe->event_data[0]),
+			le32_to_cpu(acqe->event_data[1]));
+		break;
+	case SLI4_ACQE_EVENT_CODE_FC_LINK_EVENT:
+		rc = sli_fc_process_link_attention(sli4, buf);
+		break;
+	default:
+		efc_log_info(sli4, "ACQE unknown=%#x\n",
+			acqe->event_code);
+	}
+
+	return rc;
+}
-- 
2.26.2


--000000000000b61a0d05b181253f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQPwYJKoZIhvcNAQcCoIIQMDCCECwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2UMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFQTCCBCmgAwIBAgIMfmKtsn6cI8G7HjzCMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTE3MDU0
NjI0WhcNMjIwOTE4MDU0NjI0WjCBjDELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMRQwEgYDVQQDEwtKYW1l
cyBTbWFydDEnMCUGCSqGSIb3DQEJARYYamFtZXMuc21hcnRAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0B4Ym0dby5rc/1eyTwvNzsepN0S9eBGyF45ltfEmEmoe
sY3NAmThxJaLBzoPYjCpfPWh65cxrVIOw9R3a9TrkDN+aISE1NPyyHOabU57I8bKvfS8WMpCQKSJ
pDWUbzanP3MMP4C2qbJgQW+xh9UDzBi8u69f40kP+cLEPNJWbz0KxNNp7H/4zWNyTouJRtO6QKVh
XqR+mg0QW4TJlH5sJ7NIbVGZKzs0PEbUJJJw0zJsp3m0iS6AzNFtTGHWVO1me58DIYR/VDSiY9Sh
AanDaJF6fE9TEzbfn5AWgVgHkbqS3VY3Gq05xkLhRugDQ60IGwT29K1B+wGfcujKSaalhQIDAQAB
o4IBzzCCAcswDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZB
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmcz
b2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNv
bmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0w
OzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMu
Y3JsMCMGA1UdEQQcMBqBGGphbWVzLnNtYXJ0QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUUXCHNA1n5KXj
CXL1nHkJ8oKX5wYwDQYJKoZIhvcNAQELBQADggEBAGQDKmIdULu06w+bE15XZJOwlarihiP2PHos
/4bNU3NRgy/tCQbTpJJr3L7LU9ldcPam9qQsErGZKmb5ypUjVdmS5n5M7KN42mnfLs/p7+lOOY5q
ZwPZfsjYiUuaCWDGMvVpuBgJtdADOE1v24vgyyLZjtCbvSUzsgKKda3/Z/iwLFCRrIogixS1L6Vg
2JU2wwirL0Sy5S1DREQmTMAuHL+M9Qwbl+uh/AprkVqaSYuvUzWFwBVgafOl2XgGdn8r6ubxSZhX
9SybOi1fAXGcISX8GzOd85ygu/3dFqvMyCBpNke4vdweIll52KZIMyWji3y2PKJYfgqO+bxo7BAa
ROYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDH5i
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgnqGVFt4ER5SP/9te
P+fd4Z3aZED+C8Z7iM2/wzJzLdkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDEyMjI1MjA1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFViOaNYTOBWHIPL6k8+stLaMZXQEMvQaYzD
hww22YjsOghmpRUr4R1dByDb2MZS3EC08DUq0ThapY9Qk/ZUyWJg6VxMS26BA06iULtgzxBXO1aC
3NN495jaR+LZZPO3+xaPnTR53Cpri47z5nCOwPj0rPdD0nTMJo+IuoJEeZeG9Ys9Vky/QVKkY00n
PIHIMOqH6YWM17j5Sfm1RDAwd9Yu0YtOA/bUo7Ey59ELOdZUFq3s6MQ1U6pQvE7zH/fDpodXLobU
RJe3Qv2zJ13pFfoorLaHR3sSFVF6O1s+h12/by6N54z+ztMgKkPI81xL5ayYz2znIC/IDXcvNSgd
JWY=
--000000000000b61a0d05b181253f--
