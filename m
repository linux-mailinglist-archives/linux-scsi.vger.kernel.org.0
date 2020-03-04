Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D446C178A3B
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Mar 2020 06:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgCDFaB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Mar 2020 00:30:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39826 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCDFaB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Mar 2020 00:30:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id s2so425917pgv.6
        for <linux-scsi@vger.kernel.org>; Tue, 03 Mar 2020 21:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rx7vxXWa0JIIfAMRhgtEXv88G4epYBrDkgo/NRscgBM=;
        b=ncw0ahG+ItTk1sn7nOX2sHXLjSADm5Y9UWTE5oqDEg3QAbZL7llSr9NglQZYtwNvqV
         l2ArDmM/526NY52G3WKbB3C0nZRTN0O+bifSQPzeDZvBXb4imXDzOJUVWPsLbleKre+I
         HLnSFQXjxlL47XBkvklTL8fATHMdt6M5BNobbiJjIi3YUcQDETQMLiywkzF3dfYEvMRF
         1kvnIriX6Tx1Ex2JU48lYHO/nHsPRlfOuusUHyiaJRP9yRu63UvBbcEDhdjLKYTVgRDE
         SmBQWlg7ojjwGvPPVhszGRFd9WupO1E6x2oPUaltsbzDyIB5+g6zaMxTvqHHlYtkoJ7s
         iNwg==
X-Gm-Message-State: ANhLgQ1Vta7Z8QXE6GB721RepTQZVCuj3GaO6HZd258txsOw4zwo0wx0
        EGbp3xQtuFWbb4PQgKCSXVxNKA2afkY=
X-Google-Smtp-Source: ADFU+vviuXNWHQL5rQHoSUGyDhq5ibSdbmf18yFf55eNfOvho+fND+4tISNLipXkj6shM431YgJUaQ==
X-Received: by 2002:a62:547:: with SMTP id 68mr1423505pff.217.1583299796838;
        Tue, 03 Mar 2020 21:29:56 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:a86e:343d:2eff:fb40])
        by smtp.gmail.com with ESMTPSA id p94sm972784pjp.15.2020.03.03.21.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 21:29:55 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Daniel Wagner <dwagner@suse.de>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v2 3/6] qla2xxx: Fix endianness annotations in header files
Date:   Tue,  3 Mar 2020 21:29:42 -0800
Message-Id: <20200304052945.23250-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304052945.23250-1-bvanassche@acm.org>
References: <20200304052945.23250-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Annotate members of FC protocol and firmware dump data structures as big
endian. Annotate members of RISC control structures as little endian.
Annotate mailbox registers as little endian. Annotate the mb[] arrays as
CPU-endian because communication of the mb[] values with the hardware
happens through the readw() and writew() functions. readw() converts from
__le16 to u16 and writew() converts from u16 to __le16.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Quinn Tran <qutran@marvell.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_dbg.h    | 442 +++++++++---------
 drivers/scsi/qla2xxx/qla_def.h    | 646 +++++++++++++-------------
 drivers/scsi/qla2xxx/qla_fw.h     | 738 +++++++++++++++---------------
 drivers/scsi/qla2xxx/qla_inline.h |   2 +-
 drivers/scsi/qla2xxx/qla_mr.h     |   8 +-
 drivers/scsi/qla2xxx/qla_nvme.h   |  46 +-
 drivers/scsi/qla2xxx/qla_nx.h     |  36 +-
 drivers/scsi/qla2xxx/qla_target.h | 208 ++++-----
 8 files changed, 1063 insertions(+), 1063 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index 433e95502808..8d50af935d9e 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -12,205 +12,205 @@
  */
 
 struct qla2300_fw_dump {
-	uint16_t hccr;
-	uint16_t pbiu_reg[8];
-	uint16_t risc_host_reg[8];
-	uint16_t mailbox_reg[32];
-	uint16_t resp_dma_reg[32];
-	uint16_t dma_reg[48];
-	uint16_t risc_hdw_reg[16];
-	uint16_t risc_gp0_reg[16];
-	uint16_t risc_gp1_reg[16];
-	uint16_t risc_gp2_reg[16];
-	uint16_t risc_gp3_reg[16];
-	uint16_t risc_gp4_reg[16];
-	uint16_t risc_gp5_reg[16];
-	uint16_t risc_gp6_reg[16];
-	uint16_t risc_gp7_reg[16];
-	uint16_t frame_buf_hdw_reg[64];
-	uint16_t fpm_b0_reg[64];
-	uint16_t fpm_b1_reg[64];
-	uint16_t risc_ram[0xf800];
-	uint16_t stack_ram[0x1000];
-	uint16_t data_ram[1];
+	__be16 hccr;
+	__be16 pbiu_reg[8];
+	__be16 risc_host_reg[8];
+	__be16 mailbox_reg[32];
+	__be16 resp_dma_reg[32];
+	__be16 dma_reg[48];
+	__be16 risc_hdw_reg[16];
+	__be16 risc_gp0_reg[16];
+	__be16 risc_gp1_reg[16];
+	__be16 risc_gp2_reg[16];
+	__be16 risc_gp3_reg[16];
+	__be16 risc_gp4_reg[16];
+	__be16 risc_gp5_reg[16];
+	__be16 risc_gp6_reg[16];
+	__be16 risc_gp7_reg[16];
+	__be16 frame_buf_hdw_reg[64];
+	__be16 fpm_b0_reg[64];
+	__be16 fpm_b1_reg[64];
+	__be16 risc_ram[0xf800];
+	__be16 stack_ram[0x1000];
+	__be16 data_ram[1];
 };
 
 struct qla2100_fw_dump {
-	uint16_t hccr;
-	uint16_t pbiu_reg[8];
-	uint16_t mailbox_reg[32];
-	uint16_t dma_reg[48];
-	uint16_t risc_hdw_reg[16];
-	uint16_t risc_gp0_reg[16];
-	uint16_t risc_gp1_reg[16];
-	uint16_t risc_gp2_reg[16];
-	uint16_t risc_gp3_reg[16];
-	uint16_t risc_gp4_reg[16];
-	uint16_t risc_gp5_reg[16];
-	uint16_t risc_gp6_reg[16];
-	uint16_t risc_gp7_reg[16];
-	uint16_t frame_buf_hdw_reg[16];
-	uint16_t fpm_b0_reg[64];
-	uint16_t fpm_b1_reg[64];
-	uint16_t risc_ram[0xf000];
+	__be16 hccr;
+	__be16 pbiu_reg[8];
+	__be16 mailbox_reg[32];
+	__be16 dma_reg[48];
+	__be16 risc_hdw_reg[16];
+	__be16 risc_gp0_reg[16];
+	__be16 risc_gp1_reg[16];
+	__be16 risc_gp2_reg[16];
+	__be16 risc_gp3_reg[16];
+	__be16 risc_gp4_reg[16];
+	__be16 risc_gp5_reg[16];
+	__be16 risc_gp6_reg[16];
+	__be16 risc_gp7_reg[16];
+	__be16 frame_buf_hdw_reg[16];
+	__be16 fpm_b0_reg[64];
+	__be16 fpm_b1_reg[64];
+	__be16 risc_ram[0xf000];
 };
 
 struct qla24xx_fw_dump {
-	uint32_t host_status;
-	uint32_t host_reg[32];
-	uint32_t shadow_reg[7];
-	uint16_t mailbox_reg[32];
-	uint32_t xseq_gp_reg[128];
-	uint32_t xseq_0_reg[16];
-	uint32_t xseq_1_reg[16];
-	uint32_t rseq_gp_reg[128];
-	uint32_t rseq_0_reg[16];
-	uint32_t rseq_1_reg[16];
-	uint32_t rseq_2_reg[16];
-	uint32_t cmd_dma_reg[16];
-	uint32_t req0_dma_reg[15];
-	uint32_t resp0_dma_reg[15];
-	uint32_t req1_dma_reg[15];
-	uint32_t xmt0_dma_reg[32];
-	uint32_t xmt1_dma_reg[32];
-	uint32_t xmt2_dma_reg[32];
-	uint32_t xmt3_dma_reg[32];
-	uint32_t xmt4_dma_reg[32];
-	uint32_t xmt_data_dma_reg[16];
-	uint32_t rcvt0_data_dma_reg[32];
-	uint32_t rcvt1_data_dma_reg[32];
-	uint32_t risc_gp_reg[128];
-	uint32_t lmc_reg[112];
-	uint32_t fpm_hdw_reg[192];
-	uint32_t fb_hdw_reg[176];
-	uint32_t code_ram[0x2000];
-	uint32_t ext_mem[1];
+	__be32	host_status;
+	__be32	host_reg[32];
+	__be32	shadow_reg[7];
+	__be16	mailbox_reg[32];
+	__be32	xseq_gp_reg[128];
+	__be32	xseq_0_reg[16];
+	__be32	xseq_1_reg[16];
+	__be32	rseq_gp_reg[128];
+	__be32	rseq_0_reg[16];
+	__be32	rseq_1_reg[16];
+	__be32	rseq_2_reg[16];
+	__be32	cmd_dma_reg[16];
+	__be32	req0_dma_reg[15];
+	__be32	resp0_dma_reg[15];
+	__be32	req1_dma_reg[15];
+	__be32	xmt0_dma_reg[32];
+	__be32	xmt1_dma_reg[32];
+	__be32	xmt2_dma_reg[32];
+	__be32	xmt3_dma_reg[32];
+	__be32	xmt4_dma_reg[32];
+	__be32	xmt_data_dma_reg[16];
+	__be32	rcvt0_data_dma_reg[32];
+	__be32	rcvt1_data_dma_reg[32];
+	__be32	risc_gp_reg[128];
+	__be32	lmc_reg[112];
+	__be32	fpm_hdw_reg[192];
+	__be32	fb_hdw_reg[176];
+	__be32	code_ram[0x2000];
+	__be32	ext_mem[1];
 };
 
 struct qla25xx_fw_dump {
-	uint32_t host_status;
-	uint32_t host_risc_reg[32];
-	uint32_t pcie_regs[4];
-	uint32_t host_reg[32];
-	uint32_t shadow_reg[11];
-	uint32_t risc_io_reg;
-	uint16_t mailbox_reg[32];
-	uint32_t xseq_gp_reg[128];
-	uint32_t xseq_0_reg[48];
-	uint32_t xseq_1_reg[16];
-	uint32_t rseq_gp_reg[128];
-	uint32_t rseq_0_reg[32];
-	uint32_t rseq_1_reg[16];
-	uint32_t rseq_2_reg[16];
-	uint32_t aseq_gp_reg[128];
-	uint32_t aseq_0_reg[32];
-	uint32_t aseq_1_reg[16];
-	uint32_t aseq_2_reg[16];
-	uint32_t cmd_dma_reg[16];
-	uint32_t req0_dma_reg[15];
-	uint32_t resp0_dma_reg[15];
-	uint32_t req1_dma_reg[15];
-	uint32_t xmt0_dma_reg[32];
-	uint32_t xmt1_dma_reg[32];
-	uint32_t xmt2_dma_reg[32];
-	uint32_t xmt3_dma_reg[32];
-	uint32_t xmt4_dma_reg[32];
-	uint32_t xmt_data_dma_reg[16];
-	uint32_t rcvt0_data_dma_reg[32];
-	uint32_t rcvt1_data_dma_reg[32];
-	uint32_t risc_gp_reg[128];
-	uint32_t lmc_reg[128];
-	uint32_t fpm_hdw_reg[192];
-	uint32_t fb_hdw_reg[192];
-	uint32_t code_ram[0x2000];
-	uint32_t ext_mem[1];
+	__be32	host_status;
+	__be32	host_risc_reg[32];
+	__be32	pcie_regs[4];
+	__be32	host_reg[32];
+	__be32	shadow_reg[11];
+	__be32	risc_io_reg;
+	__be16	mailbox_reg[32];
+	__be32	xseq_gp_reg[128];
+	__be32	xseq_0_reg[48];
+	__be32	xseq_1_reg[16];
+	__be32	rseq_gp_reg[128];
+	__be32	rseq_0_reg[32];
+	__be32	rseq_1_reg[16];
+	__be32	rseq_2_reg[16];
+	__be32	aseq_gp_reg[128];
+	__be32	aseq_0_reg[32];
+	__be32	aseq_1_reg[16];
+	__be32	aseq_2_reg[16];
+	__be32	cmd_dma_reg[16];
+	__be32	req0_dma_reg[15];
+	__be32	resp0_dma_reg[15];
+	__be32	req1_dma_reg[15];
+	__be32	xmt0_dma_reg[32];
+	__be32	xmt1_dma_reg[32];
+	__be32	xmt2_dma_reg[32];
+	__be32	xmt3_dma_reg[32];
+	__be32	xmt4_dma_reg[32];
+	__be32	xmt_data_dma_reg[16];
+	__be32	rcvt0_data_dma_reg[32];
+	__be32	rcvt1_data_dma_reg[32];
+	__be32	risc_gp_reg[128];
+	__be32	lmc_reg[128];
+	__be32	fpm_hdw_reg[192];
+	__be32	fb_hdw_reg[192];
+	__be32	code_ram[0x2000];
+	__be32	ext_mem[1];
 };
 
 struct qla81xx_fw_dump {
-	uint32_t host_status;
-	uint32_t host_risc_reg[32];
-	uint32_t pcie_regs[4];
-	uint32_t host_reg[32];
-	uint32_t shadow_reg[11];
-	uint32_t risc_io_reg;
-	uint16_t mailbox_reg[32];
-	uint32_t xseq_gp_reg[128];
-	uint32_t xseq_0_reg[48];
-	uint32_t xseq_1_reg[16];
-	uint32_t rseq_gp_reg[128];
-	uint32_t rseq_0_reg[32];
-	uint32_t rseq_1_reg[16];
-	uint32_t rseq_2_reg[16];
-	uint32_t aseq_gp_reg[128];
-	uint32_t aseq_0_reg[32];
-	uint32_t aseq_1_reg[16];
-	uint32_t aseq_2_reg[16];
-	uint32_t cmd_dma_reg[16];
-	uint32_t req0_dma_reg[15];
-	uint32_t resp0_dma_reg[15];
-	uint32_t req1_dma_reg[15];
-	uint32_t xmt0_dma_reg[32];
-	uint32_t xmt1_dma_reg[32];
-	uint32_t xmt2_dma_reg[32];
-	uint32_t xmt3_dma_reg[32];
-	uint32_t xmt4_dma_reg[32];
-	uint32_t xmt_data_dma_reg[16];
-	uint32_t rcvt0_data_dma_reg[32];
-	uint32_t rcvt1_data_dma_reg[32];
-	uint32_t risc_gp_reg[128];
-	uint32_t lmc_reg[128];
-	uint32_t fpm_hdw_reg[224];
-	uint32_t fb_hdw_reg[208];
-	uint32_t code_ram[0x2000];
-	uint32_t ext_mem[1];
+	__be32	host_status;
+	__be32	host_risc_reg[32];
+	__be32	pcie_regs[4];
+	__be32	host_reg[32];
+	__be32	shadow_reg[11];
+	__be32	risc_io_reg;
+	__be16	mailbox_reg[32];
+	__be32	xseq_gp_reg[128];
+	__be32	xseq_0_reg[48];
+	__be32	xseq_1_reg[16];
+	__be32	rseq_gp_reg[128];
+	__be32	rseq_0_reg[32];
+	__be32	rseq_1_reg[16];
+	__be32	rseq_2_reg[16];
+	__be32	aseq_gp_reg[128];
+	__be32	aseq_0_reg[32];
+	__be32	aseq_1_reg[16];
+	__be32	aseq_2_reg[16];
+	__be32	cmd_dma_reg[16];
+	__be32	req0_dma_reg[15];
+	__be32	resp0_dma_reg[15];
+	__be32	req1_dma_reg[15];
+	__be32	xmt0_dma_reg[32];
+	__be32	xmt1_dma_reg[32];
+	__be32	xmt2_dma_reg[32];
+	__be32	xmt3_dma_reg[32];
+	__be32	xmt4_dma_reg[32];
+	__be32	xmt_data_dma_reg[16];
+	__be32	rcvt0_data_dma_reg[32];
+	__be32	rcvt1_data_dma_reg[32];
+	__be32	risc_gp_reg[128];
+	__be32	lmc_reg[128];
+	__be32	fpm_hdw_reg[224];
+	__be32	fb_hdw_reg[208];
+	__be32	code_ram[0x2000];
+	__be32	ext_mem[1];
 };
 
 struct qla83xx_fw_dump {
-	uint32_t host_status;
-	uint32_t host_risc_reg[48];
-	uint32_t pcie_regs[4];
-	uint32_t host_reg[32];
-	uint32_t shadow_reg[11];
-	uint32_t risc_io_reg;
-	uint16_t mailbox_reg[32];
-	uint32_t xseq_gp_reg[256];
-	uint32_t xseq_0_reg[48];
-	uint32_t xseq_1_reg[16];
-	uint32_t xseq_2_reg[16];
-	uint32_t rseq_gp_reg[256];
-	uint32_t rseq_0_reg[32];
-	uint32_t rseq_1_reg[16];
-	uint32_t rseq_2_reg[16];
-	uint32_t rseq_3_reg[16];
-	uint32_t aseq_gp_reg[256];
-	uint32_t aseq_0_reg[32];
-	uint32_t aseq_1_reg[16];
-	uint32_t aseq_2_reg[16];
-	uint32_t aseq_3_reg[16];
-	uint32_t cmd_dma_reg[64];
-	uint32_t req0_dma_reg[15];
-	uint32_t resp0_dma_reg[15];
-	uint32_t req1_dma_reg[15];
-	uint32_t xmt0_dma_reg[32];
-	uint32_t xmt1_dma_reg[32];
-	uint32_t xmt2_dma_reg[32];
-	uint32_t xmt3_dma_reg[32];
-	uint32_t xmt4_dma_reg[32];
-	uint32_t xmt_data_dma_reg[16];
-	uint32_t rcvt0_data_dma_reg[32];
-	uint32_t rcvt1_data_dma_reg[32];
-	uint32_t risc_gp_reg[128];
-	uint32_t lmc_reg[128];
-	uint32_t fpm_hdw_reg[256];
-	uint32_t rq0_array_reg[256];
-	uint32_t rq1_array_reg[256];
-	uint32_t rp0_array_reg[256];
-	uint32_t rp1_array_reg[256];
-	uint32_t queue_control_reg[16];
-	uint32_t fb_hdw_reg[432];
-	uint32_t at0_array_reg[128];
-	uint32_t code_ram[0x2400];
-	uint32_t ext_mem[1];
+	__be32	host_status;
+	__be32	host_risc_reg[48];
+	__be32	pcie_regs[4];
+	__be32	host_reg[32];
+	__be32	shadow_reg[11];
+	__be32	risc_io_reg;
+	__be16	mailbox_reg[32];
+	__be32	xseq_gp_reg[256];
+	__be32	xseq_0_reg[48];
+	__be32	xseq_1_reg[16];
+	__be32	xseq_2_reg[16];
+	__be32	rseq_gp_reg[256];
+	__be32	rseq_0_reg[32];
+	__be32	rseq_1_reg[16];
+	__be32	rseq_2_reg[16];
+	__be32	rseq_3_reg[16];
+	__be32	aseq_gp_reg[256];
+	__be32	aseq_0_reg[32];
+	__be32	aseq_1_reg[16];
+	__be32	aseq_2_reg[16];
+	__be32	aseq_3_reg[16];
+	__be32	cmd_dma_reg[64];
+	__be32	req0_dma_reg[15];
+	__be32	resp0_dma_reg[15];
+	__be32	req1_dma_reg[15];
+	__be32	xmt0_dma_reg[32];
+	__be32	xmt1_dma_reg[32];
+	__be32	xmt2_dma_reg[32];
+	__be32	xmt3_dma_reg[32];
+	__be32	xmt4_dma_reg[32];
+	__be32	xmt_data_dma_reg[16];
+	__be32	rcvt0_data_dma_reg[32];
+	__be32	rcvt1_data_dma_reg[32];
+	__be32	risc_gp_reg[128];
+	__be32	lmc_reg[128];
+	__be32	fpm_hdw_reg[256];
+	__be32	rq0_array_reg[256];
+	__be32	rq1_array_reg[256];
+	__be32	rp0_array_reg[256];
+	__be32	rp1_array_reg[256];
+	__be32	queue_control_reg[16];
+	__be32	fb_hdw_reg[432];
+	__be32	at0_array_reg[128];
+	__be32	code_ram[0x2400];
+	__be32	ext_mem[1];
 };
 
 #define EFT_NUM_BUFFERS		4
@@ -223,44 +223,44 @@ struct qla83xx_fw_dump {
 #define fce_calc_size(b)	((FCE_BYTES_PER_BUFFER) * (b))
 
 struct qla2xxx_fce_chain {
-	uint32_t type;
-	uint32_t chain_size;
+	__be32	type;
+	__be32	chain_size;
 
-	uint32_t size;
-	uint32_t addr_l;
-	uint32_t addr_h;
-	uint32_t eregs[8];
+	__be32	size;
+	__be32	addr_l;
+	__be32	addr_h;
+	__be32	eregs[8];
 };
 
 /* used by exchange off load and extended login offload */
 struct qla2xxx_offld_chain {
-	uint32_t type;
-	uint32_t chain_size;
+	__be32	type;
+	__be32	chain_size;
 
-	uint32_t size;
-	u64	 addr;
+	__be32	size;
+	__be64	addr;
 };
 
 struct qla2xxx_mq_chain {
-	uint32_t type;
-	uint32_t chain_size;
+	__be32	type;
+	__be32	chain_size;
 
-	uint32_t count;
-	uint32_t qregs[4 * QLA_MQ_SIZE];
+	__be32	count;
+	__be32	qregs[4 * QLA_MQ_SIZE];
 };
 
 struct qla2xxx_mqueue_header {
-	uint32_t queue;
+	__be32	queue;
 #define TYPE_REQUEST_QUEUE	0x1
 #define TYPE_RESPONSE_QUEUE	0x2
 #define TYPE_ATIO_QUEUE		0x3
-	uint32_t number;
-	uint32_t size;
+	__be32	number;
+	__be32	size;
 };
 
 struct qla2xxx_mqueue_chain {
-	uint32_t type;
-	uint32_t chain_size;
+	__be32	type;
+	__be32	chain_size;
 };
 
 #define DUMP_CHAIN_VARIANT	0x80000000
@@ -273,28 +273,28 @@ struct qla2xxx_mqueue_chain {
 
 struct qla2xxx_fw_dump {
 	uint8_t signature[4];
-	uint32_t version;
+	__be32	version;
 
-	uint32_t fw_major_version;
-	uint32_t fw_minor_version;
-	uint32_t fw_subminor_version;
-	uint32_t fw_attributes;
+	__be32 fw_major_version;
+	__be32 fw_minor_version;
+	__be32 fw_subminor_version;
+	__be32 fw_attributes;
 
-	uint32_t vendor;
-	uint32_t device;
-	uint32_t subsystem_vendor;
-	uint32_t subsystem_device;
+	__be32 vendor;
+	__be32 device;
+	__be32 subsystem_vendor;
+	__be32 subsystem_device;
 
-	uint32_t fixed_size;
-	uint32_t mem_size;
-	uint32_t req_q_size;
-	uint32_t rsp_q_size;
+	__be32	fixed_size;
+	__be32	mem_size;
+	__be32	req_q_size;
+	__be32	rsp_q_size;
 
-	uint32_t eft_size;
-	uint32_t eft_addr_l;
-	uint32_t eft_addr_h;
+	__be32	eft_size;
+	__be32	eft_addr_l;
+	__be32	eft_addr_h;
 
-	uint32_t header_size;
+	__be32	header_size;
 
 	union {
 		struct qla2100_fw_dump isp21;
@@ -369,7 +369,7 @@ ql_log_qp(uint32_t, struct qla_qpair *, int32_t, const char *fmt, ...);
 
 extern int qla27xx_dump_mpi_ram(struct qla_hw_data *, uint32_t, uint32_t *,
 	uint32_t, void **);
-extern int qla24xx_dump_ram(struct qla_hw_data *, uint32_t, uint32_t *,
+extern int qla24xx_dump_ram(struct qla_hw_data *, uint32_t, __be32 *,
 	uint32_t, void **);
 extern void qla24xx_pause_risc(struct device_reg_24xx __iomem *,
 	struct qla_hw_data *);
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 47c7a56438b5..ebb22c1a9df7 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -520,8 +520,8 @@ struct srb_iocb {
 #define MAX_IOCB_MB_REG 28
 #define SIZEOF_IOCB_MB_REG (MAX_IOCB_MB_REG * sizeof(uint16_t))
 		struct {
-			__le16 in_mb[MAX_IOCB_MB_REG];	/* from FW */
-			__le16 out_mb[MAX_IOCB_MB_REG];	/* to FW */
+			u16 in_mb[MAX_IOCB_MB_REG];	/* from FW */
+			u16 out_mb[MAX_IOCB_MB_REG];	/* to FW */
 			void *out, *in;
 			dma_addr_t out_dma, in_dma;
 			struct completion comp;
@@ -532,7 +532,7 @@ struct srb_iocb {
 		} nack;
 		struct {
 			__le16 comp_status;
-			uint16_t rsp_pyld_len;
+			__le16 rsp_pyld_len;
 			uint8_t	aen_op;
 			void *desc;
 
@@ -663,23 +663,23 @@ struct msg_echo_lb {
  * ISP I/O Register Set structure definitions.
  */
 struct device_reg_2xxx {
-	uint16_t flash_address; 	/* Flash BIOS address */
-	uint16_t flash_data;		/* Flash BIOS data */
-	uint16_t unused_1[1];		/* Gap */
-	uint16_t ctrl_status;		/* Control/Status */
+	__le16	flash_address; 	/* Flash BIOS address */
+	__le16	flash_data;		/* Flash BIOS data */
+	__le16	unused_1[1];		/* Gap */
+	__le16	ctrl_status;		/* Control/Status */
 #define CSR_FLASH_64K_BANK	BIT_3	/* Flash upper 64K bank select */
 #define CSR_FLASH_ENABLE	BIT_1	/* Flash BIOS Read/Write enable */
 #define CSR_ISP_SOFT_RESET	BIT_0	/* ISP soft reset */
 
-	uint16_t ictrl;			/* Interrupt control */
+	__le16	ictrl;			/* Interrupt control */
 #define ICR_EN_INT		BIT_15	/* ISP enable interrupts. */
 #define ICR_EN_RISC		BIT_3	/* ISP enable RISC interrupts. */
 
-	uint16_t istatus;		/* Interrupt status */
+	__le16	istatus;		/* Interrupt status */
 #define ISR_RISC_INT		BIT_3	/* RISC interrupt */
 
-	uint16_t semaphore;		/* Semaphore */
-	uint16_t nvram;			/* NVRAM register. */
+	__le16	semaphore;		/* Semaphore */
+	__le16	nvram;			/* NVRAM register. */
 #define NVR_DESELECT		0
 #define NVR_BUSY		BIT_15
 #define NVR_WRT_ENABLE		BIT_14	/* Write enable */
@@ -693,80 +693,80 @@ struct device_reg_2xxx {
 
 	union {
 		struct {
-			uint16_t mailbox0;
-			uint16_t mailbox1;
-			uint16_t mailbox2;
-			uint16_t mailbox3;
-			uint16_t mailbox4;
-			uint16_t mailbox5;
-			uint16_t mailbox6;
-			uint16_t mailbox7;
-			uint16_t unused_2[59];	/* Gap */
+			__le16	mailbox0;
+			__le16	mailbox1;
+			__le16	mailbox2;
+			__le16	mailbox3;
+			__le16	mailbox4;
+			__le16	mailbox5;
+			__le16	mailbox6;
+			__le16	mailbox7;
+			__le16	unused_2[59];	/* Gap */
 		} __attribute__((packed)) isp2100;
 		struct {
 						/* Request Queue */
-			uint16_t req_q_in;	/*  In-Pointer */
-			uint16_t req_q_out;	/*  Out-Pointer */
+			__le16	req_q_in;	/*  In-Pointer */
+			__le16	req_q_out;	/*  Out-Pointer */
 						/* Response Queue */
-			uint16_t rsp_q_in;	/*  In-Pointer */
-			uint16_t rsp_q_out;	/*  Out-Pointer */
+			__le16	rsp_q_in;	/*  In-Pointer */
+			__le16	rsp_q_out;	/*  Out-Pointer */
 
 						/* RISC to Host Status */
-			uint32_t host_status;
+			__le32	host_status;
 #define HSR_RISC_INT		BIT_15	/* RISC interrupt */
 #define HSR_RISC_PAUSED		BIT_8	/* RISC Paused */
 
 					/* Host to Host Semaphore */
-			uint16_t host_semaphore;
-			uint16_t unused_3[17];	/* Gap */
-			uint16_t mailbox0;
-			uint16_t mailbox1;
-			uint16_t mailbox2;
-			uint16_t mailbox3;
-			uint16_t mailbox4;
-			uint16_t mailbox5;
-			uint16_t mailbox6;
-			uint16_t mailbox7;
-			uint16_t mailbox8;
-			uint16_t mailbox9;
-			uint16_t mailbox10;
-			uint16_t mailbox11;
-			uint16_t mailbox12;
-			uint16_t mailbox13;
-			uint16_t mailbox14;
-			uint16_t mailbox15;
-			uint16_t mailbox16;
-			uint16_t mailbox17;
-			uint16_t mailbox18;
-			uint16_t mailbox19;
-			uint16_t mailbox20;
-			uint16_t mailbox21;
-			uint16_t mailbox22;
-			uint16_t mailbox23;
-			uint16_t mailbox24;
-			uint16_t mailbox25;
-			uint16_t mailbox26;
-			uint16_t mailbox27;
-			uint16_t mailbox28;
-			uint16_t mailbox29;
-			uint16_t mailbox30;
-			uint16_t mailbox31;
-			uint16_t fb_cmd;
-			uint16_t unused_4[10];	/* Gap */
+			__le16	host_semaphore;
+			__le16	unused_3[17];	/* Gap */
+			__le16	mailbox0;
+			__le16	mailbox1;
+			__le16	mailbox2;
+			__le16	mailbox3;
+			__le16	mailbox4;
+			__le16	mailbox5;
+			__le16	mailbox6;
+			__le16	mailbox7;
+			__le16	mailbox8;
+			__le16	mailbox9;
+			__le16	mailbox10;
+			__le16	mailbox11;
+			__le16	mailbox12;
+			__le16	mailbox13;
+			__le16	mailbox14;
+			__le16	mailbox15;
+			__le16	mailbox16;
+			__le16	mailbox17;
+			__le16	mailbox18;
+			__le16	mailbox19;
+			__le16	mailbox20;
+			__le16	mailbox21;
+			__le16	mailbox22;
+			__le16	mailbox23;
+			__le16	mailbox24;
+			__le16	mailbox25;
+			__le16	mailbox26;
+			__le16	mailbox27;
+			__le16	mailbox28;
+			__le16	mailbox29;
+			__le16	mailbox30;
+			__le16	mailbox31;
+			__le16	fb_cmd;
+			__le16	unused_4[10];	/* Gap */
 		} __attribute__((packed)) isp2300;
 	} u;
 
-	uint16_t fpm_diag_config;
-	uint16_t unused_5[0x4];		/* Gap */
-	uint16_t risc_hw;
-	uint16_t unused_5_1;		/* Gap */
-	uint16_t pcr;			/* Processor Control Register. */
-	uint16_t unused_6[0x5];		/* Gap */
-	uint16_t mctr;			/* Memory Configuration and Timing. */
-	uint16_t unused_7[0x3];		/* Gap */
-	uint16_t fb_cmd_2100;		/* Unused on 23XX */
-	uint16_t unused_8[0x3];		/* Gap */
-	uint16_t hccr;			/* Host command & control register. */
+	__le16	fpm_diag_config;
+	__le16	unused_5[0x4];		/* Gap */
+	__le16	risc_hw;
+	__le16	unused_5_1;		/* Gap */
+	__le16	pcr;			/* Processor Control Register. */
+	__le16	unused_6[0x5];		/* Gap */
+	__le16	mctr;			/* Memory Configuration and Timing. */
+	__le16	unused_7[0x3];		/* Gap */
+	__le16	fb_cmd_2100;		/* Unused on 23XX */
+	__le16	unused_8[0x3];		/* Gap */
+	__le16	hccr;			/* Host command & control register. */
 #define HCCR_HOST_INT		BIT_7	/* Host interrupt bit */
 #define HCCR_RISC_PAUSE		BIT_5	/* Pause mode bit */
 					/* HCCR commands */
@@ -779,9 +779,9 @@ struct device_reg_2xxx {
 #define	HCCR_DISABLE_PARITY_PAUSE 0x4001 /* Disable parity error RISC pause. */
 #define HCCR_ENABLE_PARITY	0xA000	/* Enable PARITY interrupt */
 
-	uint16_t unused_9[5];		/* Gap */
-	uint16_t gpiod;			/* GPIO Data register. */
-	uint16_t gpioe;			/* GPIO Enable register. */
+	__le16	unused_9[5];		/* Gap */
+	__le16	gpiod;			/* GPIO Data register. */
+	__le16	gpioe;			/* GPIO Enable register. */
 #define GPIO_LED_MASK			0x00C0
 #define GPIO_LED_GREEN_OFF_AMBER_OFF	0x0000
 #define GPIO_LED_GREEN_ON_AMBER_OFF	0x0040
@@ -793,95 +793,95 @@ struct device_reg_2xxx {
 
 	union {
 		struct {
-			uint16_t unused_10[8];	/* Gap */
-			uint16_t mailbox8;
-			uint16_t mailbox9;
-			uint16_t mailbox10;
-			uint16_t mailbox11;
-			uint16_t mailbox12;
-			uint16_t mailbox13;
-			uint16_t mailbox14;
-			uint16_t mailbox15;
-			uint16_t mailbox16;
-			uint16_t mailbox17;
-			uint16_t mailbox18;
-			uint16_t mailbox19;
-			uint16_t mailbox20;
-			uint16_t mailbox21;
-			uint16_t mailbox22;
-			uint16_t mailbox23;	/* Also probe reg. */
+			__le16	unused_10[8];	/* Gap */
+			__le16	mailbox8;
+			__le16	mailbox9;
+			__le16	mailbox10;
+			__le16	mailbox11;
+			__le16	mailbox12;
+			__le16	mailbox13;
+			__le16	mailbox14;
+			__le16	mailbox15;
+			__le16	mailbox16;
+			__le16	mailbox17;
+			__le16	mailbox18;
+			__le16	mailbox19;
+			__le16	mailbox20;
+			__le16	mailbox21;
+			__le16	mailbox22;
+			__le16	mailbox23;	/* Also probe reg. */
 		} __attribute__((packed)) isp2200;
 	} u_end;
 };
 
 struct device_reg_25xxmq {
-	uint32_t req_q_in;
-	uint32_t req_q_out;
-	uint32_t rsp_q_in;
-	uint32_t rsp_q_out;
-	uint32_t atio_q_in;
-	uint32_t atio_q_out;
+	__le32	req_q_in;
+	__le32	req_q_out;
+	__le32	rsp_q_in;
+	__le32	rsp_q_out;
+	__le32	atio_q_in;
+	__le32	atio_q_out;
 };
 
 
 struct device_reg_fx00 {
-	uint32_t mailbox0;		/* 00 */
-	uint32_t mailbox1;		/* 04 */
-	uint32_t mailbox2;		/* 08 */
-	uint32_t mailbox3;		/* 0C */
-	uint32_t mailbox4;		/* 10 */
-	uint32_t mailbox5;		/* 14 */
-	uint32_t mailbox6;		/* 18 */
-	uint32_t mailbox7;		/* 1C */
-	uint32_t mailbox8;		/* 20 */
-	uint32_t mailbox9;		/* 24 */
-	uint32_t mailbox10;		/* 28 */
-	uint32_t mailbox11;
-	uint32_t mailbox12;
-	uint32_t mailbox13;
-	uint32_t mailbox14;
-	uint32_t mailbox15;
-	uint32_t mailbox16;
-	uint32_t mailbox17;
-	uint32_t mailbox18;
-	uint32_t mailbox19;
-	uint32_t mailbox20;
-	uint32_t mailbox21;
-	uint32_t mailbox22;
-	uint32_t mailbox23;
-	uint32_t mailbox24;
-	uint32_t mailbox25;
-	uint32_t mailbox26;
-	uint32_t mailbox27;
-	uint32_t mailbox28;
-	uint32_t mailbox29;
-	uint32_t mailbox30;
-	uint32_t mailbox31;
-	uint32_t aenmailbox0;
-	uint32_t aenmailbox1;
-	uint32_t aenmailbox2;
-	uint32_t aenmailbox3;
-	uint32_t aenmailbox4;
-	uint32_t aenmailbox5;
-	uint32_t aenmailbox6;
-	uint32_t aenmailbox7;
+	__le32	mailbox0;		/* 00 */
+	__le32	mailbox1;		/* 04 */
+	__le32	mailbox2;		/* 08 */
+	__le32	mailbox3;		/* 0C */
+	__le32	mailbox4;		/* 10 */
+	__le32	mailbox5;		/* 14 */
+	__le32	mailbox6;		/* 18 */
+	__le32	mailbox7;		/* 1C */
+	__le32	mailbox8;		/* 20 */
+	__le32	mailbox9;		/* 24 */
+	__le32	mailbox10;		/* 28 */
+	__le32	mailbox11;
+	__le32	mailbox12;
+	__le32	mailbox13;
+	__le32	mailbox14;
+	__le32	mailbox15;
+	__le32	mailbox16;
+	__le32	mailbox17;
+	__le32	mailbox18;
+	__le32	mailbox19;
+	__le32	mailbox20;
+	__le32	mailbox21;
+	__le32	mailbox22;
+	__le32	mailbox23;
+	__le32	mailbox24;
+	__le32	mailbox25;
+	__le32	mailbox26;
+	__le32	mailbox27;
+	__le32	mailbox28;
+	__le32	mailbox29;
+	__le32	mailbox30;
+	__le32	mailbox31;
+	__le32	aenmailbox0;
+	__le32	aenmailbox1;
+	__le32	aenmailbox2;
+	__le32	aenmailbox3;
+	__le32	aenmailbox4;
+	__le32	aenmailbox5;
+	__le32	aenmailbox6;
+	__le32	aenmailbox7;
 	/* Request Queue. */
-	uint32_t req_q_in;		/* A0 - Request Queue In-Pointer */
-	uint32_t req_q_out;		/* A4 - Request Queue Out-Pointer */
+	__le32	req_q_in;		/* A0 - Request Queue In-Pointer */
+	__le32	req_q_out;		/* A4 - Request Queue Out-Pointer */
 	/* Response Queue. */
-	uint32_t rsp_q_in;		/* A8 - Response Queue In-Pointer */
-	uint32_t rsp_q_out;		/* AC - Response Queue Out-Pointer */
+	__le32	rsp_q_in;		/* A8 - Response Queue In-Pointer */
+	__le32	rsp_q_out;		/* AC - Response Queue Out-Pointer */
 	/* Init values shadowed on FW Up Event */
-	uint32_t initval0;		/* B0 */
-	uint32_t initval1;		/* B4 */
-	uint32_t initval2;		/* B8 */
-	uint32_t initval3;		/* BC */
-	uint32_t initval4;		/* C0 */
-	uint32_t initval5;		/* C4 */
-	uint32_t initval6;		/* C8 */
-	uint32_t initval7;		/* CC */
-	uint32_t fwheartbeat;		/* D0 */
-	uint32_t pseudoaen;		/* D4 */
+	__le32	initval0;		/* B0 */
+	__le32	initval1;		/* B4 */
+	__le32	initval2;		/* B8 */
+	__le32	initval3;		/* BC */
+	__le32	initval4;		/* C0 */
+	__le32	initval5;		/* C4 */
+	__le32	initval6;		/* C8 */
+	__le32	initval7;		/* CC */
+	__le32	fwheartbeat;		/* D0 */
+	__le32	pseudoaen;		/* D4 */
 };
 
 
@@ -1316,7 +1316,7 @@ typedef struct {
 	uint8_t port_id[4];
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
-	uint16_t execution_throttle;
+	__le16	execution_throttle;
 	uint16_t execution_count;
 	uint8_t reset_count;
 	uint8_t reserved_2;
@@ -1402,9 +1402,9 @@ typedef struct {
 	 */
 	uint8_t  firmware_options[2];
 
-	uint16_t frame_payload_size;
-	uint16_t max_iocb_allocation;
-	uint16_t execution_throttle;
+	__le16	frame_payload_size;
+	__le16	max_iocb_allocation;
+	__le16	execution_throttle;
 	uint8_t  retry_count;
 	uint8_t	 retry_delay;			/* unused */
 	uint8_t	 port_name[WWN_SIZE];		/* Big endian. */
@@ -1413,17 +1413,17 @@ typedef struct {
 	uint8_t	 login_timeout;
 	uint8_t	 node_name[WWN_SIZE];		/* Big endian. */
 
-	uint16_t request_q_outpointer;
-	uint16_t response_q_inpointer;
-	uint16_t request_q_length;
-	uint16_t response_q_length;
-	__le64   request_q_address __packed;
-	__le64   response_q_address __packed;
+	__le16	request_q_outpointer;
+	__le16	response_q_inpointer;
+	__le16	request_q_length;
+	__le16	response_q_length;
+	__le64  request_q_address __packed;
+	__le64  response_q_address __packed;
 
-	uint16_t lun_enables;
+	__le16	lun_enables;
 	uint8_t  command_resource_count;
 	uint8_t  immediate_notify_resource_count;
-	uint16_t timeout;
+	__le16	timeout;
 	uint8_t  reserved_2[2];
 
 	/*
@@ -1571,8 +1571,8 @@ typedef struct {
 	uint8_t	 firmware_options[2];
 
 	uint16_t frame_payload_size;
-	uint16_t max_iocb_allocation;
-	uint16_t execution_throttle;
+	__le16	max_iocb_allocation;
+	__le16	execution_throttle;
 	uint8_t	 retry_count;
 	uint8_t	 retry_delay;			/* unused */
 	uint8_t	 port_name[WWN_SIZE];		/* Big endian. */
@@ -1696,7 +1696,7 @@ typedef struct {
 	uint8_t reset_delay;
 	uint8_t port_down_retry_count;
 	uint8_t boot_id_number;
-	uint16_t max_luns_per_target;
+	__le16	max_luns_per_target;
 	uint8_t fcode_boot_port_name[WWN_SIZE];
 	uint8_t alternate_port_name[WWN_SIZE];
 	uint8_t alternate_node_name[WWN_SIZE];
@@ -1802,7 +1802,7 @@ struct atio {
 };
 
 typedef union {
-	uint16_t extended;
+	__le16	extended;
 	struct {
 		uint8_t reserved;
 		uint8_t standard;
@@ -1828,18 +1828,18 @@ typedef struct {
 	uint8_t entry_status;		/* Entry Status. */
 	uint32_t handle;		/* System handle. */
 	target_id_t target;		/* SCSI ID */
-	uint16_t lun;			/* SCSI LUN */
-	uint16_t control_flags;		/* Control flags. */
+	__le16	lun;			/* SCSI LUN */
+	__le16	control_flags;		/* Control flags. */
 #define CF_WRITE	BIT_6
 #define CF_READ		BIT_5
 #define CF_SIMPLE_TAG	BIT_3
 #define CF_ORDERED_TAG	BIT_2
 #define CF_HEAD_TAG	BIT_1
 	uint16_t reserved_1;
-	uint16_t timeout;		/* Command timeout. */
-	uint16_t dseg_count;		/* Data segment count. */
+	__le16	timeout;		/* Command timeout. */
+	__le16	dseg_count;		/* Data segment count. */
 	uint8_t scsi_cdb[MAX_CMDSZ]; 	/* SCSI command words. */
-	uint32_t byte_count;		/* Total byte count. */
+	__le32	byte_count;		/* Total byte count. */
 	union {
 		struct dsd32 dsd32[3];
 		struct dsd64 dsd64[2];
@@ -1857,11 +1857,11 @@ typedef struct {
 	uint8_t entry_status;		/* Entry Status. */
 	uint32_t handle;		/* System handle. */
 	target_id_t target;		/* SCSI ID */
-	uint16_t lun;			/* SCSI LUN */
-	uint16_t control_flags;		/* Control flags. */
+	__le16	lun;			/* SCSI LUN */
+	__le16	control_flags;		/* Control flags. */
 	uint16_t reserved_1;
-	uint16_t timeout;		/* Command timeout. */
-	uint16_t dseg_count;		/* Data segment count. */
+	__le16	timeout;		/* Command timeout. */
+	__le16	dseg_count;		/* Data segment count. */
 	uint8_t scsi_cdb[MAX_CMDSZ];	/* SCSI command words. */
 	uint32_t byte_count;		/* Total byte count. */
 	struct dsd64 dsd[2];
@@ -1923,7 +1923,7 @@ struct crc_context {
 	__le16 guard_seed;		/* Initial Guard Seed */
 	__le16 prot_opts;		/* Requested Data Protection Mode */
 	__le16 blk_size;		/* Data size in bytes */
-	uint16_t runt_blk_guard;	/* Guard value for runt block (tape
+	__le16	runt_blk_guard;	/* Guard value for runt block (tape
 					 * only) */
 	__le32 byte_count;		/* Total byte count/ total data
 					 * transfer count */
@@ -1976,13 +1976,13 @@ typedef struct {
 	uint8_t sys_define;		/* System defined. */
 	uint8_t entry_status;		/* Entry Status. */
 	uint32_t handle;		/* System handle. */
-	uint16_t scsi_status;		/* SCSI status. */
-	uint16_t comp_status;		/* Completion status. */
-	uint16_t state_flags;		/* State flags. */
-	uint16_t status_flags;		/* Status flags. */
-	uint16_t rsp_info_len;		/* Response Info Length. */
-	uint16_t req_sense_length;	/* Request sense data length. */
-	uint32_t residual_length;	/* Residual transfer length. */
+	__le16	scsi_status;		/* SCSI status. */
+	__le16	comp_status;		/* Completion status. */
+	__le16	state_flags;		/* State flags. */
+	__le16	status_flags;		/* Status flags. */
+	__le16	rsp_info_len;		/* Response Info Length. */
+	__le16	req_sense_length;	/* Request sense data length. */
+	__le32	residual_length;	/* Residual transfer length. */
 	uint8_t rsp_info[8];		/* FCP response information. */
 	uint8_t req_sense_data[32];	/* Request sense data. */
 } sts_entry_t;
@@ -2114,8 +2114,8 @@ typedef struct {
 					/* clear port changed, */
 					/* use sequence number. */
 	uint8_t reserved_1;
-	uint16_t sequence_number;	/* Sequence number of event */
-	uint16_t lun;			/* SCSI LUN */
+	__le16	sequence_number;	/* Sequence number of event */
+	__le16	lun;			/* SCSI LUN */
 	uint8_t reserved_2[48];
 } mrk_entry_t;
 
@@ -2130,19 +2130,19 @@ typedef struct {
 	uint8_t entry_status;		/* Entry Status. */
 	uint32_t handle1;		/* System handle. */
 	target_id_t loop_id;
-	uint16_t status;
-	uint16_t control_flags;		/* Control flags. */
+	__le16	status;
+	__le16	control_flags;		/* Control flags. */
 	uint16_t reserved2;
-	uint16_t timeout;
-	uint16_t cmd_dsd_count;
-	uint16_t total_dsd_count;
+	__le16	timeout;
+	__le16	cmd_dsd_count;
+	__le16	total_dsd_count;
 	uint8_t type;
 	uint8_t r_ctl;
-	uint16_t rx_id;
+	__le16	rx_id;
 	uint16_t reserved3;
 	uint32_t handle2;
-	uint32_t rsp_bytecount;
-	uint32_t req_bytecount;
+	__le32	rsp_bytecount;
+	__le32	req_bytecount;
 	struct dsd64 req_dsd;
 	struct dsd64 rsp_dsd;
 } ms_iocb_entry_t;
@@ -2170,20 +2170,20 @@ struct mbx_entry {
 	uint32_t handle;
 	target_id_t loop_id;
 
-	uint16_t status;
-	uint16_t state_flags;
-	uint16_t status_flags;
+	__le16	status;
+	__le16	state_flags;
+	__le16	status_flags;
 
 	uint32_t sys_define2[2];
 
-	uint16_t mb0;
-	uint16_t mb1;
-	uint16_t mb2;
-	uint16_t mb3;
-	uint16_t mb6;
-	uint16_t mb7;
-	uint16_t mb9;
-	uint16_t mb10;
+	__le16	mb0;
+	__le16	mb1;
+	__le16	mb2;
+	__le16	mb3;
+	__le16	mb6;
+	__le16	mb7;
+	__le16	mb9;
+	__le16	mb10;
 	uint32_t reserved_2[2];
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
@@ -2205,52 +2205,52 @@ struct imm_ntfy_from_isp {
 	uint8_t	 entry_status;		    /* Entry Status. */
 	union {
 		struct {
-			uint32_t sys_define_2; /* System defined. */
+			__le32	sys_define_2; /* System defined. */
 			target_id_t target;
-			uint16_t lun;
+			__le16	lun;
 			uint8_t  target_id;
 			uint8_t  reserved_1;
-			uint16_t status_modifier;
-			uint16_t status;
-			uint16_t task_flags;
-			uint16_t seq_id;
-			uint16_t srr_rx_id;
-			uint32_t srr_rel_offs;
-			uint16_t srr_ui;
+			__le16	status_modifier;
+			__le16	status;
+			__le16	task_flags;
+			__le16	seq_id;
+			__le16	srr_rx_id;
+			__le32	srr_rel_offs;
+			__le16	srr_ui;
 #define SRR_IU_DATA_IN	0x1
 #define SRR_IU_DATA_OUT	0x5
 #define SRR_IU_STATUS	0x7
-			uint16_t srr_ox_id;
+			__le16	srr_ox_id;
 			uint8_t reserved_2[28];
 		} isp2x;
 		struct {
 			uint32_t reserved;
-			uint16_t nport_handle;
+			__le16	nport_handle;
 			uint16_t reserved_2;
-			uint16_t flags;
+			__le16	flags;
 #define NOTIFY24XX_FLAGS_GLOBAL_TPRLO   BIT_1
 #define NOTIFY24XX_FLAGS_PUREX_IOCB     BIT_0
-			uint16_t srr_rx_id;
-			uint16_t status;
+			__le16	srr_rx_id;
+			__le16	status;
 			uint8_t  status_subcode;
 			uint8_t  fw_handle;
 			uint32_t exchange_address;
-			uint32_t srr_rel_offs;
-			uint16_t srr_ui;
-			uint16_t srr_ox_id;
+			__le32	srr_rel_offs;
+			__le16	srr_ui;
+			__le16	srr_ox_id;
 			union {
 				struct {
 					uint8_t node_name[8];
 				} plogi; /* PLOGI/ADISC/PDISC */
 				struct {
 					/* PRLI word 3 bit 0-15 */
-					uint16_t wd3_lo;
+					__le16	wd3_lo;
 					uint8_t resv0[6];
 				} prli;
 				struct {
 					uint8_t port_id[3];
 					uint8_t resv1;
-					uint16_t nport_handle;
+					__le16	nport_handle;
 					uint16_t resv2;
 				} req_els;
 			} u;
@@ -2263,7 +2263,7 @@ struct imm_ntfy_from_isp {
 		} isp24;
 	} u;
 	uint16_t reserved_7;
-	uint16_t ox_id;
+	__le16	ox_id;
 } __packed;
 #endif
 
@@ -2653,8 +2653,8 @@ static const char * const port_dstate_str[] = {
 #define FDMI_HBA_VENDOR_IDENTIFIER		0xe0
 
 struct ct_fdmi_hba_attr {
-	uint16_t type;
-	uint16_t len;
+	__be16	type;
+	__be16	len;
 	union {
 		uint8_t node_name[WWN_SIZE];
 		uint8_t manufacturer[64];
@@ -2666,11 +2666,11 @@ struct ct_fdmi_hba_attr {
 		uint8_t orom_version[16];
 		uint8_t fw_version[32];
 		uint8_t os_version[128];
-		uint32_t max_ct_len;
+		__be32	 max_ct_len;
 
 		uint8_t sym_name[256];
-		uint32_t vendor_specific_info;
-		uint32_t num_ports;
+		__be32	 vendor_specific_info;
+		__be32	 num_ports;
 		uint8_t fabric_name[WWN_SIZE];
 		uint8_t bios_name[32];
 		uint8_t vendor_identifier[8];
@@ -2678,12 +2678,12 @@ struct ct_fdmi_hba_attr {
 };
 
 struct ct_fdmi1_hba_attributes {
-	uint32_t count;
+	__be32	count;
 	struct ct_fdmi_hba_attr entry[FDMI1_HBA_ATTR_COUNT];
 };
 
 struct ct_fdmi2_hba_attributes {
-	uint32_t count;
+	__be32	count;
 	struct ct_fdmi_hba_attr entry[FDMI2_HBA_ATTR_COUNT];
 };
 
@@ -2735,44 +2735,44 @@ struct ct_fdmi2_hba_attributes {
 #define FC_CLASS_2_3	0x0C
 
 struct ct_fdmi_port_attr {
-	uint16_t type;
-	uint16_t len;
+	__be16	type;
+	__be16	len;
 	union {
 		uint8_t fc4_types[32];
-		uint32_t sup_speed;
-		uint32_t cur_speed;
-		uint32_t max_frame_size;
+		__be32	sup_speed;
+		__be32	cur_speed;
+		__be32	max_frame_size;
 		uint8_t os_dev_name[32];
 		uint8_t host_name[256];
 
 		uint8_t node_name[WWN_SIZE];
 		uint8_t port_name[WWN_SIZE];
 		uint8_t port_sym_name[128];
-		uint32_t port_type;
-		uint32_t port_supported_cos;
+		__be32	port_type;
+		__be32	port_supported_cos;
 		uint8_t fabric_name[WWN_SIZE];
 		uint8_t port_fc4_type[32];
-		uint32_t port_state;
-		uint32_t num_ports;
-		uint32_t port_id;
+		__be32	 port_state;
+		__be32	 num_ports;
+		__be32	 port_id;
 
 		uint8_t smartsan_service[24];
 		uint8_t smartsan_guid[16];
 		uint8_t smartsan_version[24];
 		uint8_t smartsan_prod_name[16];
-		uint32_t smartsan_port_info;
-		uint32_t smartsan_qos_support;
-		uint32_t smartsan_security_support;
+		__be32	 smartsan_port_info;
+		__be32	 smartsan_qos_support;
+		__be32	 smartsan_security_support;
 	} a;
 };
 
 struct ct_fdmi1_port_attributes {
-	uint32_t count;
+	__be32	 count;
 	struct ct_fdmi_port_attr entry[FDMI1_PORT_ATTR_COUNT];
 };
 
 struct ct_fdmi2_port_attributes {
-	uint32_t count;
+	__be32	count;
 	struct ct_fdmi_port_attr entry[FDMI2_PORT_ATTR_COUNT];
 };
 
@@ -2826,8 +2826,8 @@ struct ct_cmd_hdr {
 /* CT command request */
 struct ct_sns_req {
 	struct ct_cmd_hdr header;
-	uint16_t command;
-	uint16_t max_rsp_size;
+	__be16	command;
+	__be16	max_rsp_size;
 	uint8_t fragment_id;
 	uint8_t reserved[3];
 
@@ -2884,7 +2884,7 @@ struct ct_sns_req {
 
 		struct {
 			uint8_t hba_identifier[8];
-			uint32_t entry_count;
+			__be32	entry_count;
 			uint8_t port_name[8];
 			struct ct_fdmi2_hba_attributes attrs;
 		} rhba;
@@ -2939,7 +2939,7 @@ struct ct_sns_req {
 /* CT command response header */
 struct ct_rsp_hdr {
 	struct ct_cmd_hdr header;
-	uint16_t response;
+	__be16	response;
 	uint16_t residual;
 	uint8_t fragment_id;
 	uint8_t reason_code;
@@ -3025,8 +3025,8 @@ struct ct_sns_rsp {
 		} gfpn_id;
 
 		struct {
-			uint16_t speeds;
-			uint16_t speed;
+			__be16	speeds;
+			__be16	speed;
 		} gpsc;
 
 #define GFF_FCP_SCSI_OFFSET	7
@@ -3116,13 +3116,13 @@ struct fab_scan {
 struct sns_cmd_pkt {
 	union {
 		struct {
-			uint16_t buffer_length;
-			uint16_t reserved_1;
-			__le64	 buffer_address __packed;
-			uint16_t subcommand_length;
-			uint16_t reserved_2;
-			uint16_t subcommand;
-			uint16_t size;
+			__le16	buffer_length;
+			__le16	reserved_1;
+			__le64	buffer_address __packed;
+			__le16	subcommand_length;
+			__le16	reserved_2;
+			__le16	subcommand;
+			__le16	size;
 			uint32_t reserved_3;
 			uint8_t param[36];
 		} cmd;
@@ -3148,7 +3148,7 @@ struct gid_list_info {
 	uint8_t	area;
 	uint8_t	domain;
 	uint8_t	loop_id_2100;	/* ISP2100/ISP2200 -- 4 bytes. */
-	uint16_t loop_id;	/* ISP23XX         -- 6 bytes. */
+	__le16	loop_id;	/* ISP23XX         -- 6 bytes. */
 	uint16_t reserved_1;	/* ISP24XX         -- 8 bytes. */
 };
 
@@ -3456,8 +3456,8 @@ struct rsp_que {
 	dma_addr_t  dma;
 	response_t *ring;
 	response_t *ring_ptr;
-	uint32_t __iomem *rsp_q_in;	/* FWI2-capable only. */
-	uint32_t __iomem *rsp_q_out;
+	__le32	__iomem *rsp_q_in;	/* FWI2-capable only. */
+	__le32	__iomem *rsp_q_out;
 	uint16_t  ring_index;
 	uint16_t  out_ptr;
 	uint16_t  *in_ptr;		/* queue shadow in index */
@@ -3483,8 +3483,8 @@ struct req_que {
 	dma_addr_t  dma;
 	request_t *ring;
 	request_t *ring_ptr;
-	uint32_t __iomem *req_q_in;	/* FWI2-capable only. */
-	uint32_t __iomem *req_q_out;
+	__le32	__iomem *req_q_in;	/* FWI2-capable only. */
+	__le32	__iomem *req_q_out;
 	uint16_t  ring_index;
 	uint16_t  in_ptr;
 	uint16_t  *out_ptr;		/* queue shadow out index */
@@ -3579,98 +3579,98 @@ struct rdp_req_payload {
 
 struct rdp_rsp_payload {
 	struct {
-		uint32_t cmd;
-		uint32_t len;
+		__be32	cmd;
+		__be32	len;
 	} hdr;
 
 	/* LS Request Info descriptor */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
-		uint32_t req_payload_word_0;
+		__be32	desc_tag;
+		__be32	desc_len;
+		__be32	req_payload_word_0;
 	} ls_req_info_desc;
 
 	/* LS Request Info descriptor */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
-		uint32_t req_payload_word_0;
+		__be32	desc_tag;
+		__be32	desc_len;
+		__be32	req_payload_word_0;
 	} ls_req_info_desc2;
 
 	/* SFP diagnostic param descriptor */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
-		uint16_t temperature;
-		uint16_t vcc;
-		uint16_t tx_bias;
-		uint16_t tx_power;
-		uint16_t rx_power;
-		uint16_t sfp_flags;
+		__be32	desc_tag;
+		__be32	desc_len;
+		__be16	temperature;
+		__be16	vcc;
+		__be16	tx_bias;
+		__be16	tx_power;
+		__be16	rx_power;
+		__be16	sfp_flags;
 	} sfp_diag_desc;
 
 	/* Port Speed Descriptor */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
-		uint16_t speed_capab;
-		uint16_t operating_speed;
+		__be32	desc_tag;
+		__be32	desc_len;
+		__be16	speed_capab;
+		__be16	operating_speed;
 	} port_speed_desc;
 
 	/* Link Error Status Descriptor */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
-		uint32_t link_fail_cnt;
-		uint32_t loss_sync_cnt;
-		uint32_t loss_sig_cnt;
-		uint32_t prim_seq_err_cnt;
-		uint32_t inval_xmit_word_cnt;
-		uint32_t inval_crc_cnt;
+		__be32	desc_tag;
+		__be32	desc_len;
+		__be32	link_fail_cnt;
+		__be32	loss_sync_cnt;
+		__be32	loss_sig_cnt;
+		__be32	prim_seq_err_cnt;
+		__be32	inval_xmit_word_cnt;
+		__be32	inval_crc_cnt;
 		uint8_t  pn_port_phy_type;
 		uint8_t  reserved[3];
 	} ls_err_desc;
 
 	/* Port name description with diag param */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
+		__be32	desc_tag;
+		__be32	desc_len;
 		uint8_t WWNN[WWN_SIZE];
 		uint8_t WWPN[WWN_SIZE];
 	} port_name_diag_desc;
 
 	/* Port Name desc for Direct attached Fx_Port or Nx_Port */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
+		__be32	desc_tag;
+		__be32	desc_len;
 		uint8_t WWNN[WWN_SIZE];
 		uint8_t WWPN[WWN_SIZE];
 	} port_name_direct_desc;
 
 	/* Buffer Credit descriptor */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
-		uint32_t fcport_b2b;
-		uint32_t attached_fcport_b2b;
-		uint32_t fcport_rtt;
+		__be32	desc_tag;
+		__be32	desc_len;
+		__be32	fcport_b2b;
+		__be32	attached_fcport_b2b;
+		__be32	fcport_rtt;
 	} buffer_credit_desc;
 
 	/* Optical Element Data Descriptor */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
-		uint16_t high_alarm;
-		uint16_t low_alarm;
-		uint16_t high_warn;
-		uint16_t low_warn;
-		uint32_t element_flags;
+		__be32	desc_tag;
+		__be32	desc_len;
+		__be16	high_alarm;
+		__be16	low_alarm;
+		__be16	high_warn;
+		__be16	low_warn;
+		__be32	element_flags;
 	} optical_elmt_desc[5];
 
 	/* Optical Product Data Descriptor */
 	struct {
-		uint32_t desc_tag;
-		uint32_t desc_len;
+		__be32	desc_tag;
+		__be32	desc_len;
 		uint8_t  vendor_name[16];
 		uint8_t  part_number[16];
 		uint8_t  serial_number[16];
@@ -3708,17 +3708,17 @@ struct qlt_hw_data {
 	struct atio *atio_ring_ptr;	/* Current address. */
 	uint16_t atio_ring_index; /* Current index. */
 	uint16_t atio_q_length;
-	uint32_t __iomem *atio_q_in;
-	uint32_t __iomem *atio_q_out;
+	__le32 __iomem *atio_q_in;
+	__le32 __iomem *atio_q_out;
 
 	struct qla_tgt_func_tmpl *tgt_ops;
 	struct qla_tgt_vp_map *tgt_vp_map;
 
 	int saved_set;
-	uint16_t saved_exchange_count;
-	uint32_t saved_firmware_options_1;
-	uint32_t saved_firmware_options_2;
-	uint32_t saved_firmware_options_3;
+	__le16	saved_exchange_count;
+	__le32	saved_firmware_options_1;
+	__le32	saved_firmware_options_2;
+	__le32	saved_firmware_options_3;
 	uint8_t saved_firmware_options[2];
 	uint8_t saved_add_firmware_options[2];
 
@@ -4212,7 +4212,7 @@ struct qla_hw_data {
 
 	uint16_t	fw_options[16];         /* slots: 1,2,3,10,11 */
 	uint8_t		fw_seriallink_options[4];
-	uint16_t	fw_seriallink_options24[4];
+	__le16		fw_seriallink_options24[4];
 
 	uint8_t		serdes_version[3];
 	uint8_t		mpi_version[3];
@@ -4392,7 +4392,7 @@ struct qla_hw_data {
 #define NUM_DSD_CHAIN 4096
 
 	uint8_t fw_type;
-	__le32 file_prd_off;	/* File firmware product offset */
+	uint32_t file_prd_off;	/* File firmware product offset */
 
 	uint32_t	md_template_size;
 	void		*md_tmplt_hdr;
@@ -4698,13 +4698,13 @@ typedef struct scsi_qla_host {
 
 struct qla27xx_image_status {
 	uint8_t image_status_mask;
-	uint16_t generation;
+	__le16	generation;
 	uint8_t ver_major;
 	uint8_t ver_minor;
 	uint8_t bitmap;		/* 28xx only */
 	uint8_t reserved[2];
-	uint32_t checksum;
-	uint32_t signature;
+	__le32	checksum;
+	__le32	signature;
 } __packed;
 
 /* 28xx aux image status bimap values */
diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index f9bad5bd7198..4c7577b1c9fd 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -134,28 +134,28 @@ struct vp_database_24xx {
 struct nvram_24xx {
 	/* NVRAM header. */
 	uint8_t id[4];
-	uint16_t nvram_version;
+	__le16	nvram_version;
 	uint16_t reserved_0;
 
 	/* Firmware Initialization Control Block. */
-	uint16_t version;
+	__le16	version;
 	uint16_t reserved_1;
-	__le16 frame_payload_size;
-	uint16_t execution_throttle;
-	uint16_t exchange_count;
-	uint16_t hard_address;
+	__le16	frame_payload_size;
+	__le16	execution_throttle;
+	__le16	exchange_count;
+	__le16	hard_address;
 
 	uint8_t port_name[WWN_SIZE];
 	uint8_t node_name[WWN_SIZE];
 
-	uint16_t login_retry_count;
-	uint16_t link_down_on_nos;
-	uint16_t interrupt_delay_timer;
-	uint16_t login_timeout;
+	__le16	login_retry_count;
+	__le16	link_down_on_nos;
+	__le16	interrupt_delay_timer;
+	__le16	login_timeout;
 
-	uint32_t firmware_options_1;
-	uint32_t firmware_options_2;
-	uint32_t firmware_options_3;
+	__le32	firmware_options_1;
+	__le32	firmware_options_2;
+	__le32	firmware_options_3;
 
 	/* Offset 56. */
 
@@ -178,7 +178,7 @@ struct nvram_24xx {
 	 * BIT 11-13 = Output Emphasis 4G
 	 * BIT 14-15 = Reserved
 	 */
-	uint16_t seriallink_options[4];
+	__le16	seriallink_options[4];
 
 	uint16_t reserved_2[16];
 
@@ -218,25 +218,25 @@ struct nvram_24xx {
 	 *
 	 * BIT 16-31 =
 	 */
-	uint32_t host_p;
+	__le32	host_p;
 
 	uint8_t alternate_port_name[WWN_SIZE];
 	uint8_t alternate_node_name[WWN_SIZE];
 
 	uint8_t boot_port_name[WWN_SIZE];
-	uint16_t boot_lun_number;
+	__le16	boot_lun_number;
 	uint16_t reserved_8;
 
 	uint8_t alt1_boot_port_name[WWN_SIZE];
-	uint16_t alt1_boot_lun_number;
+	__le16	alt1_boot_lun_number;
 	uint16_t reserved_9;
 
 	uint8_t alt2_boot_port_name[WWN_SIZE];
-	uint16_t alt2_boot_lun_number;
+	__le16	alt2_boot_lun_number;
 	uint16_t reserved_10;
 
 	uint8_t alt3_boot_port_name[WWN_SIZE];
-	uint16_t alt3_boot_lun_number;
+	__le16	alt3_boot_lun_number;
 	uint16_t reserved_11;
 
 	/*
@@ -249,23 +249,23 @@ struct nvram_24xx {
 	 * BIT 6 = Reserved
 	 * BIT 7-31 =
 	 */
-	uint32_t efi_parameters;
+	__le32	efi_parameters;
 
 	uint8_t reset_delay;
 	uint8_t reserved_12;
 	uint16_t reserved_13;
 
-	uint16_t boot_id_number;
+	__le16	boot_id_number;
 	uint16_t reserved_14;
 
-	uint16_t max_luns_per_target;
+	__le16	max_luns_per_target;
 	uint16_t reserved_15;
 
-	uint16_t port_down_retry_count;
-	uint16_t link_down_timeout;
+	__le16	port_down_retry_count;
+	__le16	link_down_timeout;
 
 	/* FCode parameters. */
-	uint16_t fcode_parameter;
+	__le16	fcode_parameter;
 
 	uint16_t reserved_16[3];
 
@@ -275,13 +275,13 @@ struct nvram_24xx {
 	uint8_t prev_drv_ver_minor;
 	uint8_t prev_drv_ver_subminor;
 
-	uint16_t prev_bios_ver_major;
-	uint16_t prev_bios_ver_minor;
+	__le16	prev_bios_ver_major;
+	__le16	prev_bios_ver_minor;
 
-	uint16_t prev_efi_ver_major;
-	uint16_t prev_efi_ver_minor;
+	__le16	prev_efi_ver_major;
+	__le16	prev_efi_ver_minor;
 
-	uint16_t prev_fw_ver_major;
+	__le16	prev_fw_ver_major;
 	uint8_t prev_fw_ver_minor;
 	uint8_t prev_fw_ver_subminor;
 
@@ -309,7 +309,7 @@ struct nvram_24xx {
 	uint16_t subsystem_vendor_id;
 	uint16_t subsystem_device_id;
 
-	uint32_t checksum;
+	__le32	checksum;
 };
 
 /*
@@ -318,46 +318,46 @@ struct nvram_24xx {
  */
 #define	ICB_VERSION 1
 struct init_cb_24xx {
-	uint16_t version;
+	__le16	version;
 	uint16_t reserved_1;
 
-	uint16_t frame_payload_size;
-	uint16_t execution_throttle;
-	uint16_t exchange_count;
+	__le16	frame_payload_size;
+	__le16	execution_throttle;
+	__le16	exchange_count;
 
-	uint16_t hard_address;
+	__le16	hard_address;
 
 	uint8_t port_name[WWN_SIZE];		/* Big endian. */
 	uint8_t node_name[WWN_SIZE];		/* Big endian. */
 
-	uint16_t response_q_inpointer;
-	uint16_t request_q_outpointer;
+	__le16	response_q_inpointer;
+	__le16	request_q_outpointer;
 
-	uint16_t login_retry_count;
+	__le16	login_retry_count;
 
-	uint16_t prio_request_q_outpointer;
+	__le16	prio_request_q_outpointer;
 
-	uint16_t response_q_length;
-	uint16_t request_q_length;
+	__le16	response_q_length;
+	__le16	request_q_length;
 
-	uint16_t link_down_on_nos;		/* Milliseconds. */
+	__le16	link_down_on_nos;		/* Milliseconds. */
 
-	uint16_t prio_request_q_length;
+	__le16	prio_request_q_length;
 
 	__le64	 request_q_address __packed;
 	__le64	 response_q_address __packed;
 	__le64	 prio_request_q_address __packed;
 
-	uint16_t msix;
-	uint16_t msix_atio;
+	__le16	msix;
+	__le16	msix_atio;
 	uint8_t reserved_2[4];
 
-	uint16_t atio_q_inpointer;
-	uint16_t atio_q_length;
-	__le64	 atio_q_address __packed;
+	__le16	atio_q_inpointer;
+	__le16	atio_q_length;
+	__le64	atio_q_address __packed;
 
-	uint16_t interrupt_delay_timer;		/* 100us increments. */
-	uint16_t login_timeout;
+	__le16	interrupt_delay_timer;		/* 100us increments. */
+	__le16	login_timeout;
 
 	/*
 	 * BIT 0  = Enable Hard Loop Id
@@ -378,7 +378,7 @@ struct init_cb_24xx {
 	 * BIT 14 = Node Name Option
 	 * BIT 15-31 = Reserved
 	 */
-	uint32_t firmware_options_1;
+	__le32	firmware_options_1;
 
 	/*
 	 * BIT 0  = Operation Mode bit 0
@@ -399,7 +399,7 @@ struct init_cb_24xx {
 	 * BIT 14 = Enable Target PRLI Control
 	 * BIT 15-31 = Reserved
 	 */
-	uint32_t firmware_options_2;
+	__le32	firmware_options_2;
 
 	/*
 	 * BIT 0  = Reserved
@@ -425,9 +425,9 @@ struct init_cb_24xx {
 	 * BIT 30 = Enable request queue 0 out index shadowing
 	 * BIT 31 = Reserved
 	 */
-	uint32_t firmware_options_3;
-	uint16_t qos;
-	uint16_t rid;
+	__le32	firmware_options_3;
+	__le16	 qos;
+	__le16	 rid;
 	uint8_t  reserved_3[20];
 };
 
@@ -443,27 +443,27 @@ struct cmd_bidir {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t nport_handle;		/* N_PORT hanlde. */
+	__le16	nport_handle;		/* N_PORT hanlde. */
 
-	uint16_t timeout;		/* Commnad timeout. */
+	__le16	timeout;		/* Command timeout. */
 
-	uint16_t wr_dseg_count;		/* Write Data segment count. */
-	uint16_t rd_dseg_count;		/* Read Data segment count. */
+	__le16	wr_dseg_count;		/* Write Data segment count. */
+	__le16	rd_dseg_count;		/* Read Data segment count. */
 
 	struct scsi_lun lun;		/* FCP LUN (BE). */
 
-	uint16_t control_flags;		/* Control flags. */
+	__le16	control_flags;		/* Control flags. */
 #define BD_WRAP_BACK			BIT_3
 #define BD_READ_DATA			BIT_1
 #define BD_WRITE_DATA			BIT_0
 
-	uint16_t fcp_cmnd_dseg_len;		/* Data segment length. */
+	__le16	fcp_cmnd_dseg_len;		/* Data segment length. */
 	__le64	 fcp_cmnd_dseg_address __packed;/* Data segment address. */
 
 	uint16_t reserved[2];			/* Reserved */
 
-	uint32_t rd_byte_count;			/* Total Byte count Read. */
-	uint32_t wr_byte_count;			/* Total Byte count write. */
+	__le32	rd_byte_count;			/* Total Byte count Read. */
+	__le32	wr_byte_count;			/* Total Byte count write. */
 
 	uint8_t port_id[3];			/* PortID of destination port.*/
 	uint8_t vp_index;
@@ -480,28 +480,28 @@ struct cmd_type_6 {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t nport_handle;		/* N_PORT handle. */
-	uint16_t timeout;		/* Command timeout. */
+	__le16	nport_handle;		/* N_PORT handle. */
+	__le16	timeout;		/* Command timeout. */
 
-	uint16_t dseg_count;		/* Data segment count. */
+	__le16	dseg_count;		/* Data segment count. */
 
-	uint16_t fcp_rsp_dsd_len;	/* FCP_RSP DSD length. */
+	__le16	fcp_rsp_dsd_len;	/* FCP_RSP DSD length. */
 
 	struct scsi_lun lun;		/* FCP LUN (BE). */
 
-	uint16_t control_flags;		/* Control flags. */
+	__le16	control_flags;		/* Control flags. */
 #define CF_DIF_SEG_DESCR_ENABLE		BIT_3
 #define CF_DATA_SEG_DESCR_ENABLE	BIT_2
 #define CF_READ_DATA			BIT_1
 #define CF_WRITE_DATA			BIT_0
 
-	uint16_t fcp_cmnd_dseg_len;	/* Data segment length. */
+	__le16	fcp_cmnd_dseg_len;	/* Data segment length. */
 					/* Data segment address. */
 	__le64	 fcp_cmnd_dseg_address __packed;
 					/* Data segment address. */
 	__le64	 fcp_rsp_dseg_address __packed;
 
-	uint32_t byte_count;		/* Total byte count. */
+	__le32	byte_count;		/* Total byte count. */
 
 	uint8_t port_id[3];		/* PortID of destination port. */
 	uint8_t vp_index;
@@ -518,16 +518,16 @@ struct cmd_type_7 {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t nport_handle;		/* N_PORT handle. */
-	uint16_t timeout;		/* Command timeout. */
+	__le16	nport_handle;		/* N_PORT handle. */
+	__le16	timeout;		/* Command timeout. */
 #define FW_MAX_TIMEOUT		0x1999
 
-	uint16_t dseg_count;		/* Data segment count. */
+	__le16	dseg_count;		/* Data segment count. */
 	uint16_t reserved_1;
 
 	struct scsi_lun lun;		/* FCP LUN (BE). */
 
-	uint16_t task_mgmt_flags;	/* Task management flags. */
+	__le16	task_mgmt_flags;	/* Task management flags. */
 #define TMF_CLEAR_ACA		BIT_14
 #define TMF_TARGET_RESET	BIT_13
 #define TMF_LUN_RESET		BIT_12
@@ -547,7 +547,7 @@ struct cmd_type_7 {
 	uint8_t crn;
 
 	uint8_t fcp_cdb[MAX_CMDSZ]; 	/* SCSI command words. */
-	uint32_t byte_count;		/* Total byte count. */
+	__le32	byte_count;		/* Total byte count. */
 
 	uint8_t port_id[3];		/* PortID of destination port. */
 	uint8_t vp_index;
@@ -565,29 +565,29 @@ struct cmd_type_crc_2 {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t nport_handle;		/* N_PORT handle. */
-	uint16_t timeout;		/* Command timeout. */
+	__le16	nport_handle;		/* N_PORT handle. */
+	__le16	timeout;		/* Command timeout. */
 
-	uint16_t dseg_count;		/* Data segment count. */
+	__le16	dseg_count;		/* Data segment count. */
 
-	uint16_t fcp_rsp_dseg_len;	/* FCP_RSP DSD length. */
+	__le16	fcp_rsp_dseg_len;	/* FCP_RSP DSD length. */
 
 	struct scsi_lun lun;		/* FCP LUN (BE). */
 
-	uint16_t control_flags;		/* Control flags. */
+	__le16	control_flags;		/* Control flags. */
 
-	uint16_t fcp_cmnd_dseg_len;	/* Data segment length. */
+	__le16	fcp_cmnd_dseg_len;	/* Data segment length. */
 	__le64	 fcp_cmnd_dseg_address __packed;
 					/* Data segment address. */
 	__le64	 fcp_rsp_dseg_address __packed;
 
-	uint32_t byte_count;		/* Total byte count. */
+	__le32	byte_count;		/* Total byte count. */
 
 	uint8_t port_id[3];		/* PortID of destination port. */
 	uint8_t vp_index;
 
 	__le64	 crc_context_address __packed;	/* Data segment address. */
-	uint16_t crc_context_len;		/* Data segment length. */
+	__le16	crc_context_len;		/* Data segment length. */
 	uint16_t reserved_1;			/* MUST be set to 0. */
 };
 
@@ -604,32 +604,32 @@ struct sts_entry_24xx {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t comp_status;		/* Completion status. */
-	uint16_t ox_id;			/* OX_ID used by the firmware. */
+	__le16	comp_status;		/* Completion status. */
+	__le16	ox_id;			/* OX_ID used by the firmware. */
 
-	uint32_t residual_len;		/* FW calc residual transfer length. */
+	__le32	residual_len;		/* FW calc residual transfer length. */
 
 	union {
 		uint16_t reserved_1;
-		uint16_t nvme_rsp_pyld_len;
+		__le16	nvme_rsp_pyld_len;
 	};
 
-	uint16_t state_flags;		/* State flags. */
+	__le16	state_flags;		/* State flags. */
 #define SF_TRANSFERRED_DATA	BIT_11
 #define SF_NVME_ERSP            BIT_6
 #define SF_FCP_RSP_DMA		BIT_0
 
-	uint16_t retry_delay;
-	uint16_t scsi_status;		/* SCSI status. */
+	__le16	retry_delay;
+	__le16	scsi_status;		/* SCSI status. */
 #define SS_CONFIRMATION_REQ		BIT_12
 
-	uint32_t rsp_residual_count;	/* FCP RSP residual count. */
+	__le32	rsp_residual_count;	/* FCP RSP residual count. */
 
-	uint32_t sense_len;		/* FCP SENSE length. */
+	__le32	sense_len;		/* FCP SENSE length. */
 
 	union {
 		struct {
-			uint32_t rsp_data_len;	/* FCP response data length  */
+			__le32	rsp_data_len;	/* FCP response data length  */
 			uint8_t data[28];	/* FCP rsp/sense information */
 		};
 		struct nvme_fc_ersp_iu nvme_ersp;
@@ -672,7 +672,7 @@ struct mrk_entry_24xx {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t nport_handle;		/* N_PORT handle. */
+	__le16	nport_handle;		/* N_PORT handle. */
 
 	uint8_t modifier;		/* Modifier (7-0). */
 #define MK_SYNC_ID_LUN	0		/* Synchronize ID/LUN */
@@ -701,24 +701,24 @@ struct ct_entry_24xx {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t comp_status;		/* Completion status. */
+	__le16	comp_status;		/* Completion status. */
 
-	uint16_t nport_handle;		/* N_PORT handle. */
+	__le16	nport_handle;		/* N_PORT handle. */
 
-	uint16_t cmd_dsd_count;
+	__le16	cmd_dsd_count;
 
 	uint8_t vp_index;
 	uint8_t reserved_1;
 
-	uint16_t timeout;		/* Command timeout. */
+	__le16	timeout;		/* Command timeout. */
 	uint16_t reserved_2;
 
-	uint16_t rsp_dsd_count;
+	__le16	rsp_dsd_count;
 
 	uint8_t reserved_3[10];
 
-	uint32_t rsp_byte_count;
-	uint32_t cmd_byte_count;
+	__le32	rsp_byte_count;
+	__le32	cmd_byte_count;
 
 	struct dsd64 dsd[2];
 };
@@ -733,17 +733,17 @@ struct purex_entry_24xx {
 	uint8_t sys_define;		/* System defined. */
 	uint8_t entry_status;		/* Entry Status. */
 
-	uint16_t reserved1;
+	__le16	reserved1;
 	uint8_t vp_idx;
 	uint8_t reserved2;
 
-	uint16_t status_flags;
+	__le16	status_flags;
 	uint16_t nport_handle;
 
-	uint16_t frame_size;
-	uint16_t trunc_frame_size;
+	__le16	frame_size;
+	__le16	trunc_frame_size;
 
-	uint32_t rx_xchg_addr;
+	__le32	rx_xchg_addr;
 
 	uint8_t d_id[3];
 	uint8_t r_ctl;
@@ -754,13 +754,13 @@ struct purex_entry_24xx {
 	uint8_t f_ctl[3];
 	uint8_t type;
 
-	uint16_t seq_cnt;
+	__le16	seq_cnt;
 	uint8_t df_ctl;
 	uint8_t seq_id;
 
-	uint16_t rx_id;
-	uint16_t ox_id;
-	uint32_t param;
+	__le16	rx_id;
+	__le16	ox_id;
+	__le32	param;
 
 	uint8_t els_frame_payload[20];
 };
@@ -780,15 +780,15 @@ struct els_entry_24xx {
 	uint16_t comp_status;		/* response only */
 	uint16_t nport_handle;
 
-	uint16_t tx_dsd_count;
+	__le16	tx_dsd_count;
 
 	uint8_t vp_index;
 	uint8_t sof_type;
 #define EST_SOFI3		(1 << 4)
 #define EST_SOFI2		(3 << 4)
 
-	uint32_t rx_xchg_address;	/* Receive exchange address. */
-	uint16_t rx_dsd_count;
+	__le32	rx_xchg_address;	/* Receive exchange address. */
+	__le16	rx_dsd_count;
 
 	uint8_t opcode;
 	uint8_t reserved_2;
@@ -796,7 +796,7 @@ struct els_entry_24xx {
 	uint8_t d_id[3];
 	uint8_t s_id[3];
 
-	uint16_t control_flags;		/* Control flags. */
+	__le16	control_flags;		/* Control flags. */
 #define ECF_PAYLOAD_DESCR_MASK	(BIT_15|BIT_14|BIT_13)
 #define EPD_ELS_COMMAND		(0 << 13)
 #define EPD_ELS_ACC		(1 << 13)
@@ -817,10 +817,10 @@ struct els_entry_24xx {
 			__le32	 rx_len;		/* DSD 1 length. */
 		};
 		struct {
-			uint32_t total_byte_count;
-			uint32_t error_subcode_1;
-			uint32_t error_subcode_2;
-			uint32_t error_subcode_3;
+			__le32	total_byte_count;
+			__le32	error_subcode_1;
+			__le32	error_subcode_2;
+			__le32	error_subcode_3;
 		};
 	};
 };
@@ -831,19 +831,19 @@ struct els_sts_entry_24xx {
 	uint8_t sys_define;		/* System Defined. */
 	uint8_t entry_status;		/* Entry Status. */
 
-	uint32_t handle;		/* System handle. */
+	__le32	handle;		/* System handle. */
 
-	uint16_t comp_status;
+	__le16	comp_status;
 
-	uint16_t nport_handle;		/* N_PORT handle. */
+	__le16	nport_handle;		/* N_PORT handle. */
 
-	uint16_t reserved_1;
+	__le16	reserved_1;
 
 	uint8_t vp_index;
 	uint8_t sof_type;
 
-	uint32_t rx_xchg_address;	/* Receive exchange address. */
-	uint16_t reserved_2;
+	__le32	rx_xchg_address;	/* Receive exchange address. */
+	__le16	reserved_2;
 
 	uint8_t opcode;
 	uint8_t reserved_3;
@@ -851,13 +851,13 @@ struct els_sts_entry_24xx {
 	uint8_t d_id[3];
 	uint8_t s_id[3];
 
-	uint16_t control_flags;		/* Control flags. */
-	uint32_t total_byte_count;
-	uint32_t error_subcode_1;
-	uint32_t error_subcode_2;
-	uint32_t error_subcode_3;
+	__le16	control_flags;		/* Control flags. */
+	__le32	total_byte_count;
+	__le32	error_subcode_1;
+	__le32	error_subcode_2;
+	__le32	error_subcode_3;
 
-	uint32_t reserved_4[4];
+	__le32	reserved_4[4];
 };
 /*
  * ISP queue - Mailbox Command entry structure definition.
@@ -884,12 +884,12 @@ struct logio_entry_24xx {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t comp_status;		/* Completion status. */
+	__le16	comp_status;		/* Completion status. */
 #define CS_LOGIO_ERROR		0x31	/* Login/Logout IOCB error. */
 
-	uint16_t nport_handle;		/* N_PORT handle. */
+	__le16	nport_handle;		/* N_PORT handle. */
 
-	uint16_t control_flags;		/* Control flags. */
+	__le16	control_flags;		/* Control flags. */
 					/* Modifiers. */
 #define LCF_INCLUDE_SNS		BIT_10	/* Include SNS (FFFFFC) during LOGO. */
 #define LCF_FCP2_OVERRIDE	BIT_9	/* Set/Reset word 3 of PRLI. */
@@ -918,7 +918,7 @@ struct logio_entry_24xx {
 
 	uint8_t rsp_size;		/* Response size in 32bit words. */
 
-	uint32_t io_parameter[11];	/* General I/O parameters. */
+	__le32	io_parameter[11];	/* General I/O parameters. */
 #define LSC_SCODE_NOLINK	0x01
 #define LSC_SCODE_NOIOCB	0x02
 #define LSC_SCODE_NOXCB		0x03
@@ -946,17 +946,17 @@ struct tsk_mgmt_entry {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t nport_handle;		/* N_PORT handle. */
+	__le16	nport_handle;		/* N_PORT handle. */
 
 	uint16_t reserved_1;
 
-	uint16_t delay;			/* Activity delay in seconds. */
+	__le16	delay;			/* Activity delay in seconds. */
 
-	uint16_t timeout;		/* Command timeout. */
+	__le16	timeout;		/* Command timeout. */
 
 	struct scsi_lun lun;		/* FCP LUN (BE). */
 
-	uint32_t control_flags;		/* Control Flags. */
+	__le32	control_flags;		/* Control Flags. */
 #define TCF_NOTMCMD_TO_TARGET	BIT_31
 #define TCF_LUN_RESET		BIT_4
 #define TCF_ABORT_TASK_SET	BIT_3
@@ -981,15 +981,15 @@ struct abort_entry_24xx {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t nport_handle;		/* N_PORT handle. */
+	__le16	nport_handle;		/* N_PORT handle. */
 					/* or Completion status. */
 
-	uint16_t options;		/* Options. */
+	__le16	options;		/* Options. */
 #define AOF_NO_ABTS		BIT_0	/* Do not send any ABTS. */
 
 	uint32_t handle_to_abort;	/* System handle to abort. */
 
-	uint16_t req_que_no;
+	__le16	req_que_no;
 	uint8_t reserved_1[30];
 
 	uint8_t port_id[3];		/* PortID of destination port. */
@@ -1006,16 +1006,16 @@ struct abts_entry_24xx {
 	uint8_t handle_count;
 	uint8_t entry_status;
 
-	uint32_t handle;		/* type 0x55 only */
+	__le32	handle;		/* type 0x55 only */
 
-	uint16_t comp_status;		/* type 0x55 only */
-	uint16_t nport_handle;		/* type 0x54 only */
+	__le16	comp_status;		/* type 0x55 only */
+	__le16	nport_handle;		/* type 0x54 only */
 
-	uint16_t control_flags;		/* type 0x55 only */
+	__le16	control_flags;		/* type 0x55 only */
 	uint8_t vp_idx;
 	uint8_t sof_type;		/* sof_type is upper nibble */
 
-	uint32_t rx_xch_addr;
+	__le32	rx_xch_addr;
 
 	uint8_t d_id[3];
 	uint8_t r_ctl;
@@ -1026,30 +1026,30 @@ struct abts_entry_24xx {
 	uint8_t f_ctl[3];
 	uint8_t type;
 
-	uint16_t seq_cnt;
+	__le16	seq_cnt;
 	uint8_t df_ctl;
 	uint8_t seq_id;
 
-	uint16_t rx_id;
-	uint16_t ox_id;
+	__le16	rx_id;
+	__le16	ox_id;
 
-	uint32_t param;
+	__le32	param;
 
 	union {
 		struct {
-			uint32_t subcode3;
-			uint32_t rsvd;
-			uint32_t subcode1;
-			uint32_t subcode2;
+			__le32	subcode3;
+			__le32	rsvd;
+			__le32	subcode1;
+			__le32	subcode2;
 		} error;
 		struct {
-			uint16_t rsrvd1;
+			__le16	rsrvd1;
 			uint8_t last_seq_id;
 			uint8_t seq_id_valid;
-			uint16_t aborted_rx_id;
-			uint16_t aborted_ox_id;
-			uint16_t high_seq_cnt;
-			uint16_t low_seq_cnt;
+			__le16	aborted_rx_id;
+			__le16	aborted_ox_id;
+			__le16	high_seq_cnt;
+			__le16	low_seq_cnt;
 		} ba_acc;
 		struct {
 			uint8_t vendor_unique;
@@ -1058,7 +1058,7 @@ struct abts_entry_24xx {
 		} ba_rjt;
 	} payload;
 
-	uint32_t rx_xch_addr_to_abort;
+	__le32	rx_xch_addr_to_abort;
 } __packed;
 
 /* ABTS payload explanation values */
@@ -1087,7 +1087,7 @@ struct abts_entry_24xx {
  * ISP I/O Register Set structure definitions.
  */
 struct device_reg_24xx {
-	uint32_t flash_addr;		/* Flash/NVRAM BIOS address. */
+	__le32	flash_addr;		/* Flash/NVRAM BIOS address. */
 #define FARX_DATA_FLAG	BIT_31
 #define FARX_ACCESS_FLASH_CONF	0x7FFD0000
 #define FARX_ACCESS_FLASH_DATA	0x7FF00000
@@ -1138,9 +1138,9 @@ struct device_reg_24xx {
 #define HW_EVENT_NVRAM_CHKSUM_ERR	0xF023
 #define HW_EVENT_FLASH_FW_ERR	0xF024
 
-	uint32_t flash_data;		/* Flash/NVRAM BIOS data. */
+	__le32	flash_data;		/* Flash/NVRAM BIOS data. */
 
-	uint32_t ctrl_status;		/* Control/Status. */
+	__le32	ctrl_status;		/* Control/Status. */
 #define CSRX_FLASH_ACCESS_ERROR	BIT_18	/* Flash/NVRAM Access Error. */
 #define CSRX_DMA_ACTIVE		BIT_17	/* DMA Active status. */
 #define CSRX_DMA_SHUTDOWN	BIT_16	/* DMA Shutdown control status. */
@@ -1166,35 +1166,35 @@ struct device_reg_24xx {
 #define CSRX_FLASH_ENABLE	BIT_1	/* Flash BIOS Read/Write enable. */
 #define CSRX_ISP_SOFT_RESET	BIT_0	/* ISP soft reset. */
 
-	uint32_t ictrl;			/* Interrupt control. */
+	__le32	ictrl;			/* Interrupt control. */
 #define ICRX_EN_RISC_INT	BIT_3	/* Enable RISC interrupts on PCI. */
 
-	uint32_t istatus;		/* Interrupt status. */
+	__le32	istatus;		/* Interrupt status. */
 #define ISRX_RISC_INT		BIT_3	/* RISC interrupt. */
 
-	uint32_t unused_1[2];		/* Gap. */
+	__le32	unused_1[2];		/* Gap. */
 
 					/* Request Queue. */
-	uint32_t req_q_in;		/*  In-Pointer. */
-	uint32_t req_q_out;		/*  Out-Pointer. */
+	__le32	req_q_in;		/*  In-Pointer. */
+	__le32	req_q_out;		/*  Out-Pointer. */
 					/* Response Queue. */
-	uint32_t rsp_q_in;		/*  In-Pointer. */
-	uint32_t rsp_q_out;		/*  Out-Pointer. */
+	__le32	rsp_q_in;		/*  In-Pointer. */
+	__le32	rsp_q_out;		/*  Out-Pointer. */
 					/* Priority Request Queue. */
-	uint32_t preq_q_in;		/*  In-Pointer. */
-	uint32_t preq_q_out;		/*  Out-Pointer. */
+	__le32	preq_q_in;		/*  In-Pointer. */
+	__le32	preq_q_out;		/*  Out-Pointer. */
 
-	uint32_t unused_2[2];		/* Gap. */
+	__le32	unused_2[2];		/* Gap. */
 
 					/* ATIO Queue. */
-	uint32_t atio_q_in;		/*  In-Pointer. */
-	uint32_t atio_q_out;		/*  Out-Pointer. */
+	__le32	atio_q_in;		/*  In-Pointer. */
+	__le32	atio_q_out;		/*  Out-Pointer. */
 
-	uint32_t host_status;
+	__le32	host_status;
 #define HSRX_RISC_INT		BIT_15	/* RISC to Host interrupt. */
 #define HSRX_RISC_PAUSED	BIT_8	/* RISC Paused. */
 
-	uint32_t hccr;			/* Host command & control register. */
+	__le32	hccr;			/* Host command & control register. */
 					/* HCCR statuses. */
 #define HCCRX_HOST_INT		BIT_6	/* Host to RISC interrupt bit. */
 #define HCCRX_RISC_RESET	BIT_5	/* RISC Reset mode bit. */
@@ -1216,7 +1216,7 @@ struct device_reg_24xx {
 					/* Clear RISC to PCI interrupt. */
 #define HCCRX_CLR_RISC_INT	0xA0000000
 
-	uint32_t gpiod;			/* GPIO Data register. */
+	__le32	gpiod;			/* GPIO Data register. */
 
 					/* LED update mask. */
 #define GPDX_LED_UPDATE_MASK	(BIT_20|BIT_19|BIT_18)
@@ -1235,7 +1235,7 @@ struct device_reg_24xx {
 					/* Data in/out. */
 #define GPDX_DATA_INOUT		(BIT_1|BIT_0)
 
-	uint32_t gpioe;			/* GPIO Enable register. */
+	__le32	gpioe;			/* GPIO Enable register. */
 					/* Enable update mask. */
 #define GPEX_ENABLE_UPDATE_MASK	(BIT_17|BIT_16)
 					/* Enable update mask. */
@@ -1243,52 +1243,52 @@ struct device_reg_24xx {
 					/* Enable. */
 #define GPEX_ENABLE		(BIT_1|BIT_0)
 
-	uint32_t iobase_addr;		/* I/O Bus Base Address register. */
-
-	uint32_t unused_3[10];		/* Gap. */
-
-	uint16_t mailbox0;
-	uint16_t mailbox1;
-	uint16_t mailbox2;
-	uint16_t mailbox3;
-	uint16_t mailbox4;
-	uint16_t mailbox5;
-	uint16_t mailbox6;
-	uint16_t mailbox7;
-	uint16_t mailbox8;
-	uint16_t mailbox9;
-	uint16_t mailbox10;
-	uint16_t mailbox11;
-	uint16_t mailbox12;
-	uint16_t mailbox13;
-	uint16_t mailbox14;
-	uint16_t mailbox15;
-	uint16_t mailbox16;
-	uint16_t mailbox17;
-	uint16_t mailbox18;
-	uint16_t mailbox19;
-	uint16_t mailbox20;
-	uint16_t mailbox21;
-	uint16_t mailbox22;
-	uint16_t mailbox23;
-	uint16_t mailbox24;
-	uint16_t mailbox25;
-	uint16_t mailbox26;
-	uint16_t mailbox27;
-	uint16_t mailbox28;
-	uint16_t mailbox29;
-	uint16_t mailbox30;
-	uint16_t mailbox31;
-
-	uint32_t iobase_window;
-	uint32_t iobase_c4;
-	uint32_t iobase_c8;
-	uint32_t unused_4_1[6];		/* Gap. */
-	uint32_t iobase_q;
-	uint32_t unused_5[2];		/* Gap. */
-	uint32_t iobase_select;
-	uint32_t unused_6[2];		/* Gap. */
-	uint32_t iobase_sdata;
+	__le32	iobase_addr;		/* I/O Bus Base Address register. */
+
+	__le32	unused_3[10];		/* Gap. */
+
+	__le16	mailbox0;
+	__le16	mailbox1;
+	__le16	mailbox2;
+	__le16	mailbox3;
+	__le16	mailbox4;
+	__le16	mailbox5;
+	__le16	mailbox6;
+	__le16	mailbox7;
+	__le16	mailbox8;
+	__le16	mailbox9;
+	__le16	mailbox10;
+	__le16	mailbox11;
+	__le16	mailbox12;
+	__le16	mailbox13;
+	__le16	mailbox14;
+	__le16	mailbox15;
+	__le16	mailbox16;
+	__le16	mailbox17;
+	__le16	mailbox18;
+	__le16	mailbox19;
+	__le16	mailbox20;
+	__le16	mailbox21;
+	__le16	mailbox22;
+	__le16	mailbox23;
+	__le16	mailbox24;
+	__le16	mailbox25;
+	__le16	mailbox26;
+	__le16	mailbox27;
+	__le16	mailbox28;
+	__le16	mailbox29;
+	__le16	mailbox30;
+	__le16	mailbox31;
+
+	__le32	iobase_window;
+	__le32	iobase_c4;
+	__le32	iobase_c8;
+	__le32	unused_4_1[6];		/* Gap. */
+	__le32	iobase_q;
+	__le32	unused_5[2];		/* Gap. */
+	__le32	iobase_select;
+	__le32	unused_6[2];		/* Gap. */
+	__le32	iobase_sdata;
 };
 /* RISC-RISC semaphore register PCI offet */
 #define RISC_REGISTER_BASE_OFFSET	0x7010
@@ -1354,8 +1354,8 @@ struct mid_conf_entry_24xx {
 struct mid_init_cb_24xx {
 	struct init_cb_24xx init_cb;
 
-	uint16_t count;
-	uint16_t options;
+	__le16	count;
+	__le16	options;
 
 	struct mid_conf_entry_24xx entries[MAX_MULTI_ID_FABRIC];
 };
@@ -1389,27 +1389,27 @@ struct vp_ctrl_entry_24xx {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t vp_idx_failed;
+	__le16	vp_idx_failed;
 
-	uint16_t comp_status;		/* Completion status. */
+	__le16	comp_status;		/* Completion status. */
 #define CS_VCE_IOCB_ERROR       0x01    /* Error processing IOCB */
 #define CS_VCE_ACQ_ID_ERROR	0x02	/* Error while acquireing ID. */
 #define CS_VCE_BUSY		0x05	/* Firmware not ready to accept cmd. */
 
-	uint16_t command;
+	__le16	command;
 #define VCE_COMMAND_ENABLE_VPS	0x00	/* Enable VPs. */
 #define VCE_COMMAND_DISABLE_VPS	0x08	/* Disable VPs. */
 #define VCE_COMMAND_DISABLE_VPS_REINIT	0x09 /* Disable VPs and reinit link. */
 #define VCE_COMMAND_DISABLE_VPS_LOGO	0x0a /* Disable VPs and LOGO ports. */
 #define VCE_COMMAND_DISABLE_VPS_LOGO_ALL        0x0b /* Disable VPs and LOGO ports. */
 
-	uint16_t vp_count;
+	__le16	vp_count;
 
 	uint8_t vp_idx_map[16];
-	uint16_t flags;
-	uint16_t id;
+	__le16	flags;
+	__le16	id;
 	uint16_t reserved_4;
-	uint16_t hopct;
+	__le16	hopct;
 	uint8_t reserved_5[24];
 };
 
@@ -1425,12 +1425,12 @@ struct vp_config_entry_24xx {
 
 	uint32_t handle;		/* System handle. */
 
-	uint16_t flags;
+	__le16	flags;
 #define CS_VF_BIND_VPORTS_TO_VF         BIT_0
 #define CS_VF_SET_QOS_OF_VPORTS         BIT_1
 #define CS_VF_SET_HOPS_OF_VPORTS        BIT_2
 
-	uint16_t comp_status;		/* Completion status. */
+	__le16	comp_status;		/* Completion status. */
 #define CS_VCT_STS_ERROR	0x01	/* Specified VPs were not disabled. */
 #define CS_VCT_CNT_ERROR	0x02	/* Invalid VP count. */
 #define CS_VCT_ERROR		0x03	/* Unknown error. */
@@ -1457,9 +1457,9 @@ struct vp_config_entry_24xx {
 	uint16_t reserved_vp2;
 	uint8_t port_name_idx2[WWN_SIZE];
 	uint8_t node_name_idx2[WWN_SIZE];
-	uint16_t id;
+	__le16	id;
 	uint16_t reserved_4;
-	uint16_t hopct;
+	__le16	hopct;
 	uint8_t reserved_5[2];
 };
 
@@ -1486,7 +1486,7 @@ struct vp_rpt_id_entry_24xx {
 	uint8_t entry_count;		/* Entry count. */
 	uint8_t sys_define;		/* System defined. */
 	uint8_t entry_status;		/* Entry Status. */
-	uint32_t resv1;
+	__le32 resv1;
 	uint8_t vp_acquired;
 	uint8_t vp_setup;
 	uint8_t vp_idx;		/* Format 0=reserved */
@@ -1573,13 +1573,13 @@ struct vf_evfp_entry_24xx {
 
 struct qla_fdt_layout {
 	uint8_t sig[4];
-	uint16_t version;
-	uint16_t len;
-	uint16_t checksum;
+	__le16	version;
+	__le16	len;
+	__le16	checksum;
 	uint8_t unused1[2];
 	uint8_t model[16];
-	uint16_t man_id;
-	uint16_t id;
+	__le16	man_id;
+	__le16	id;
 	uint8_t flags;
 	uint8_t erase_cmd;
 	uint8_t alt_erase_cmd;
@@ -1588,15 +1588,15 @@ struct qla_fdt_layout {
 	uint8_t wrt_sts_reg_cmd;
 	uint8_t unprotect_sec_cmd;
 	uint8_t read_man_id_cmd;
-	uint32_t block_size;
-	uint32_t alt_block_size;
-	uint32_t flash_size;
-	uint32_t wrt_enable_data;
+	__le32 block_size;
+	__le32 alt_block_size;
+	__le32 flash_size;
+	__le32 wrt_enable_data;
 	uint8_t read_id_addr_len;
 	uint8_t wrt_disable_bits;
 	uint8_t read_dev_id_len;
 	uint8_t chip_erase_cmd;
-	uint16_t read_timeout;
+	__le16	read_timeout;
 	uint8_t protect_sec_cmd;
 	uint8_t unused2[65];
 };
@@ -1605,11 +1605,11 @@ struct qla_fdt_layout {
 
 struct qla_flt_location {
 	uint8_t sig[4];
-	uint16_t start_lo;
-	uint16_t start_hi;
+	__le16	start_lo;
+	__le16	start_hi;
 	uint8_t version;
 	uint8_t unused[5];
-	uint16_t checksum;
+	__le16	checksum;
 };
 
 #define FLT_REG_FW		0x01
@@ -1664,19 +1664,19 @@ struct qla_flt_location {
 #define FLT_REG_PEP_SEC_28XX		0xF1
 
 struct qla_flt_region {
-	uint16_t code;
+	__le16	code;
 	uint8_t attribute;
 	uint8_t reserved;
-	uint32_t size;
-	uint32_t start;
-	uint32_t end;
+	__le32 size;
+	__le32 start;
+	__le32 end;
 };
 
 struct qla_flt_header {
-	uint16_t version;
-	uint16_t length;
-	uint16_t checksum;
-	uint16_t unused;
+	__le16	version;
+	__le16	length;
+	__le16	checksum;
+	__le16	unused;
 	struct qla_flt_region region[0];
 };
 
@@ -1688,18 +1688,18 @@ struct qla_flt_header {
 
 struct qla_npiv_header {
 	uint8_t sig[2];
-	uint16_t version;
-	uint16_t entries;
-	uint16_t unused[4];
-	uint16_t checksum;
+	__le16	version;
+	__le16	entries;
+	__le16	unused[4];
+	__le16	checksum;
 };
 
 struct qla_npiv_entry {
-	uint16_t flags;
-	uint16_t vf_id;
+	__le16	flags;
+	__le16	vf_id;
 	uint8_t q_qos;
 	uint8_t f_qos;
-	uint16_t unused1;
+	__le16	unused1;
 	uint8_t port_name[WWN_SIZE];
 	uint8_t node_name[WWN_SIZE];
 };
@@ -1729,7 +1729,7 @@ struct verify_chip_entry_84xx {
 
 	uint32_t handle;
 
-	uint16_t options;
+	__le16	options;
 #define VCO_DONT_UPDATE_FW	BIT_0
 #define VCO_FORCE_UPDATE	BIT_1
 #define VCO_DONT_RESET_UPDATE	BIT_2
@@ -1737,18 +1737,18 @@ struct verify_chip_entry_84xx {
 #define VCO_END_OF_DATA		BIT_14
 #define VCO_ENABLE_DSD		BIT_15
 
-	uint16_t reserved_1;
+	__le16	reserved_1;
 
-	uint16_t data_seg_cnt;
-	uint16_t reserved_2[3];
+	__le16	data_seg_cnt;
+	__le16	reserved_2[3];
 
-	uint32_t fw_ver;
+	__le32	fw_ver;
 	uint32_t exchange_address;
 
-	uint32_t reserved_3[3];
-	uint32_t fw_size;
-	uint32_t fw_seq_size;
-	uint32_t relative_offset;
+	__le32 reserved_3[3];
+	__le32	fw_size;
+	__le32	fw_seq_size;
+	__le32	relative_offset;
 
 	struct dsd64 dsd;
 };
@@ -1761,22 +1761,22 @@ struct verify_chip_rsp_84xx {
 
 	uint32_t handle;
 
-	uint16_t comp_status;
+	__le16	comp_status;
 #define CS_VCS_CHIP_FAILURE	0x3
 #define CS_VCS_BAD_EXCHANGE	0x8
 #define CS_VCS_SEQ_COMPLETEi	0x40
 
-	uint16_t failure_code;
+	__le16	failure_code;
 #define VFC_CHECKSUM_ERROR	0x1
 #define VFC_INVALID_LEN		0x2
 #define VFC_ALREADY_IN_PROGRESS	0x8
 
-	uint16_t reserved_1[4];
+	__le16	reserved_1[4];
 
-	uint32_t fw_ver;
+	__le32	fw_ver;
 	uint32_t exchange_address;
 
-	uint32_t reserved_2[6];
+	__le32 reserved_2[6];
 };
 
 #define ACCESS_CHIP_IOCB_TYPE	0x2B
@@ -1788,24 +1788,24 @@ struct access_chip_84xx {
 
 	uint32_t handle;
 
-	uint16_t options;
+	__le16	options;
 #define ACO_DUMP_MEMORY		0x0
 #define ACO_LOAD_MEMORY		0x1
 #define ACO_CHANGE_CONFIG_PARAM	0x2
 #define ACO_REQUEST_INFO	0x3
 
-	uint16_t reserved1;
+	__le16	reserved1;
 
-	uint16_t dseg_count;
-	uint16_t reserved2[3];
+	__le16	dseg_count;
+	__le16	reserved2[3];
 
-	uint32_t parameter1;
-	uint32_t parameter2;
-	uint32_t parameter3;
+	__le32	parameter1;
+	__le32	parameter2;
+	__le32	parameter3;
 
-	uint32_t reserved3[3];
-	uint32_t total_byte_cnt;
-	uint32_t reserved4;
+	__le32	reserved3[3];
+	__le32	total_byte_cnt;
+	__le32	reserved4;
 
 	struct dsd64 dsd;
 };
@@ -1818,11 +1818,11 @@ struct access_chip_rsp_84xx {
 
 	uint32_t handle;
 
-	uint16_t comp_status;
-	uint16_t failure_code;
-	uint32_t residual_count;
+	__le16	comp_status;
+	__le16	failure_code;
+	__le32	residual_count;
 
-	uint32_t reserved[12];
+	__le32	reserved[12];
 };
 
 /* 81XX Support **************************************************************/
@@ -1877,52 +1877,52 @@ struct access_chip_rsp_84xx {
 struct nvram_81xx {
 	/* NVRAM header. */
 	uint8_t id[4];
-	uint16_t nvram_version;
-	uint16_t reserved_0;
+	__le16	nvram_version;
+	__le16	reserved_0;
 
 	/* Firmware Initialization Control Block. */
-	uint16_t version;
-	uint16_t reserved_1;
-	uint16_t frame_payload_size;
-	uint16_t execution_throttle;
-	uint16_t exchange_count;
-	uint16_t reserved_2;
+	__le16	version;
+	__le16	reserved_1;
+	__le16	frame_payload_size;
+	__le16	execution_throttle;
+	__le16	exchange_count;
+	__le16	reserved_2;
 
 	uint8_t port_name[WWN_SIZE];
 	uint8_t node_name[WWN_SIZE];
 
-	uint16_t login_retry_count;
-	uint16_t reserved_3;
-	uint16_t interrupt_delay_timer;
-	uint16_t login_timeout;
+	__le16	login_retry_count;
+	__le16	reserved_3;
+	__le16	interrupt_delay_timer;
+	__le16	login_timeout;
 
-	uint32_t firmware_options_1;
-	uint32_t firmware_options_2;
-	uint32_t firmware_options_3;
+	__le32	firmware_options_1;
+	__le32	firmware_options_2;
+	__le32	firmware_options_3;
 
-	uint16_t reserved_4[4];
+	__le16	reserved_4[4];
 
 	/* Offset 64. */
 	uint8_t enode_mac[6];
-	uint16_t reserved_5[5];
+	__le16	reserved_5[5];
 
 	/* Offset 80. */
-	uint16_t reserved_6[24];
+	__le16	reserved_6[24];
 
 	/* Offset 128. */
-	uint16_t ex_version;
+	__le16	ex_version;
 	uint8_t prio_fcf_matching_flags;
 	uint8_t reserved_6_1[3];
-	uint16_t pri_fcf_vlan_id;
+	__le16	pri_fcf_vlan_id;
 	uint8_t pri_fcf_fabric_name[8];
-	uint16_t reserved_6_2[7];
+	__le16	reserved_6_2[7];
 	uint8_t spma_mac_addr[6];
-	uint16_t reserved_6_3[14];
+	__le16	reserved_6_3[14];
 
 	/* Offset 192. */
 	uint8_t min_supported_speed;
 	uint8_t reserved_7_0;
-	uint16_t reserved_7[31];
+	__le16	reserved_7[31];
 
 	/*
 	 * BIT 0  = Enable spinup delay
@@ -1955,26 +1955,26 @@ struct nvram_81xx {
 	 * BIT 25 = Temp WWPN
 	 * BIT 26-31 =
 	 */
-	uint32_t host_p;
+	__le32	host_p;
 
 	uint8_t alternate_port_name[WWN_SIZE];
 	uint8_t alternate_node_name[WWN_SIZE];
 
 	uint8_t boot_port_name[WWN_SIZE];
-	uint16_t boot_lun_number;
-	uint16_t reserved_8;
+	__le16	boot_lun_number;
+	__le16	reserved_8;
 
 	uint8_t alt1_boot_port_name[WWN_SIZE];
-	uint16_t alt1_boot_lun_number;
-	uint16_t reserved_9;
+	__le16	alt1_boot_lun_number;
+	__le16	reserved_9;
 
 	uint8_t alt2_boot_port_name[WWN_SIZE];
-	uint16_t alt2_boot_lun_number;
-	uint16_t reserved_10;
+	__le16	alt2_boot_lun_number;
+	__le16	reserved_10;
 
 	uint8_t alt3_boot_port_name[WWN_SIZE];
-	uint16_t alt3_boot_lun_number;
-	uint16_t reserved_11;
+	__le16	alt3_boot_lun_number;
+	__le16	reserved_11;
 
 	/*
 	 * BIT 0 = Selective Login
@@ -1986,35 +1986,35 @@ struct nvram_81xx {
 	 * BIT 6 = Reserved
 	 * BIT 7-31 =
 	 */
-	uint32_t efi_parameters;
+	__le32	efi_parameters;
 
 	uint8_t reset_delay;
 	uint8_t reserved_12;
-	uint16_t reserved_13;
+	__le16	reserved_13;
 
-	uint16_t boot_id_number;
-	uint16_t reserved_14;
+	__le16	boot_id_number;
+	__le16	reserved_14;
 
-	uint16_t max_luns_per_target;
-	uint16_t reserved_15;
+	__le16	max_luns_per_target;
+	__le16	reserved_15;
 
-	uint16_t port_down_retry_count;
-	uint16_t link_down_timeout;
+	__le16	port_down_retry_count;
+	__le16	link_down_timeout;
 
 	/* FCode parameters. */
-	uint16_t fcode_parameter;
+	__le16	fcode_parameter;
 
-	uint16_t reserved_16[3];
+	__le16	reserved_16[3];
 
 	/* Offset 352. */
 	uint8_t reserved_17[4];
-	uint16_t reserved_18[5];
+	__le16	reserved_18[5];
 	uint8_t reserved_19[2];
-	uint16_t reserved_20[8];
+	__le16	reserved_20[8];
 
 	/* Offset 384. */
 	uint8_t reserved_21[16];
-	uint16_t reserved_22[3];
+	__le16	reserved_22[3];
 
 	/* Offset 406 (0x196) Enhanced Features
 	 * BIT 0    = Extended BB credits for LR
@@ -2027,20 +2027,20 @@ struct nvram_81xx {
 	uint16_t reserved_24[4];
 
 	/* Offset 416. */
-	uint16_t reserved_25[32];
+	__le16	reserved_25[32];
 
 	/* Offset 480. */
 	uint8_t model_name[16];
 
 	/* Offset 496. */
-	uint16_t feature_mask_l;
-	uint16_t feature_mask_h;
-	uint16_t reserved_26[2];
+	__le16	feature_mask_l;
+	__le16	feature_mask_h;
+	__le16	reserved_26[2];
 
-	uint16_t subsystem_vendor_id;
-	uint16_t subsystem_device_id;
+	__le16	subsystem_vendor_id;
+	__le16	subsystem_device_id;
 
-	uint32_t checksum;
+	__le32	checksum;
 };
 
 /*
@@ -2049,31 +2049,31 @@ struct nvram_81xx {
  */
 #define	ICB_VERSION 1
 struct init_cb_81xx {
-	uint16_t version;
-	uint16_t reserved_1;
+	__le16	version;
+	__le16	reserved_1;
 
-	uint16_t frame_payload_size;
-	uint16_t execution_throttle;
-	uint16_t exchange_count;
+	__le16	frame_payload_size;
+	__le16	execution_throttle;
+	__le16	exchange_count;
 
-	uint16_t reserved_2;
+	__le16	reserved_2;
 
 	uint8_t port_name[WWN_SIZE];		/* Big endian. */
 	uint8_t node_name[WWN_SIZE];		/* Big endian. */
 
-	uint16_t response_q_inpointer;
-	uint16_t request_q_outpointer;
+	__le16	response_q_inpointer;
+	__le16	request_q_outpointer;
 
-	uint16_t login_retry_count;
+	__le16	login_retry_count;
 
-	uint16_t prio_request_q_outpointer;
+	__le16	prio_request_q_outpointer;
 
-	uint16_t response_q_length;
-	uint16_t request_q_length;
+	__le16	response_q_length;
+	__le16	request_q_length;
 
-	uint16_t reserved_3;
+	__le16	reserved_3;
 
-	uint16_t prio_request_q_length;
+	__le16	prio_request_q_length;
 
 	__le64	 request_q_address __packed;
 	__le64	 response_q_address __packed;
@@ -2081,12 +2081,12 @@ struct init_cb_81xx {
 
 	uint8_t reserved_4[8];
 
-	uint16_t atio_q_inpointer;
-	uint16_t atio_q_length;
+	__le16	atio_q_inpointer;
+	__le16	atio_q_length;
 	__le64	 atio_q_address __packed;
 
-	uint16_t interrupt_delay_timer;		/* 100us increments. */
-	uint16_t login_timeout;
+	__le16	interrupt_delay_timer;		/* 100us increments. */
+	__le16	login_timeout;
 
 	/*
 	 * BIT 0-3 = Reserved
@@ -2099,7 +2099,7 @@ struct init_cb_81xx {
 	 * BIT 14 = Node Name Option
 	 * BIT 15-31 = Reserved
 	 */
-	uint32_t firmware_options_1;
+	__le32	firmware_options_1;
 
 	/*
 	 * BIT 0  = Operation Mode bit 0
@@ -2117,7 +2117,7 @@ struct init_cb_81xx {
 	 * BIT 14 = Enable Target PRLI Control
 	 * BIT 15-31 = Reserved
 	 */
-	uint32_t firmware_options_2;
+	__le32	firmware_options_2;
 
 	/*
 	 * BIT 0-3 = Reserved
@@ -2138,7 +2138,7 @@ struct init_cb_81xx {
 	 * BIT 28 = SPMA selection bit 1
 	 * BIT 30-31 = Reserved
 	 */
-	uint32_t firmware_options_3;
+	__le32	firmware_options_3;
 
 	uint8_t  reserved_5[8];
 
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 364b3db8b2dc..77f97552fe74 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -40,7 +40,7 @@ qla24xx_calc_iocbs(scsi_qla_host_t *vha, uint16_t dsds)
  *      register value.
  */
 static __inline__ uint16_t
-qla2x00_debounce_register(volatile uint16_t __iomem *addr)
+qla2x00_debounce_register(volatile __le16 __iomem *addr)
 {
 	volatile uint16_t first;
 	volatile uint16_t second;
diff --git a/drivers/scsi/qla2xxx/qla_mr.h b/drivers/scsi/qla2xxx/qla_mr.h
index 4567f0c42486..2b335d86f174 100644
--- a/drivers/scsi/qla2xxx/qla_mr.h
+++ b/drivers/scsi/qla2xxx/qla_mr.h
@@ -96,7 +96,7 @@ struct tsk_mgmt_entry_fx00 {
 	uint8_t sys_define;
 	uint8_t entry_status;		/* Entry Status. */
 
-	__le32 handle;		/* System handle. */
+	uint32_t handle;		/* System handle. */
 
 	uint32_t reserved_0;
 
@@ -121,13 +121,13 @@ struct abort_iocb_entry_fx00 {
 	uint8_t sys_define;		/* System defined. */
 	uint8_t entry_status;		/* Entry Status. */
 
-	__le32 handle;		/* System handle. */
+	uint32_t handle;		/* System handle. */
 	__le32 reserved_0;
 
 	__le16 tgt_id_sts;		/* Completion status. */
 	__le16 options;
 
-	__le32 abort_handle;		/* System handle. */
+	uint32_t abort_handle;		/* System handle. */
 	__le32 reserved_2;
 
 	__le16 req_que_no;
@@ -166,7 +166,7 @@ struct fxdisc_entry_fx00 {
 	uint8_t sys_define;		/* System Defined. */
 	uint8_t entry_status;		/* Entry Status. */
 
-	__le32 handle;		/* System handle. */
+	uint32_t handle;		/* System handle. */
 	__le32 reserved_0;		/* System handle. */
 
 	__le16 func_num;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index ef912902d4e5..d7f0df93ab36 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -48,26 +48,26 @@ struct cmd_nvme {
 	uint8_t entry_status;           /* Entry Status. */
 
 	uint32_t handle;                /* System handle. */
-	uint16_t nport_handle;          /* N_PORT handle. */
-	uint16_t timeout;               /* Command timeout. */
+	__le16	nport_handle;		/* N_PORT handle. */
+	__le16	timeout;		/* Command timeout. */
 
-	uint16_t dseg_count;            /* Data segment count. */
-	uint16_t nvme_rsp_dsd_len;      /* NVMe RSP DSD length */
+	__le16	dseg_count;		/* Data segment count. */
+	__le16	nvme_rsp_dsd_len;	/* NVMe RSP DSD length */
 
 	uint64_t rsvd;
 
-	uint16_t control_flags;         /* Control Flags */
+	__le16	control_flags;		/* Control Flags */
 #define CF_NVME_FIRST_BURST_ENABLE	BIT_11
 #define CF_DIF_SEG_DESCR_ENABLE         BIT_3
 #define CF_DATA_SEG_DESCR_ENABLE        BIT_2
 #define CF_READ_DATA                    BIT_1
 #define CF_WRITE_DATA                   BIT_0
 
-	uint16_t nvme_cmnd_dseg_len;             /* Data segment length. */
+	__le16	nvme_cmnd_dseg_len;             /* Data segment length. */
 	__le64	 nvme_cmnd_dseg_address __packed;/* Data segment address. */
 	__le64	 nvme_rsp_dseg_address __packed; /* Data segment address. */
 
-	uint32_t byte_count;            /* Total byte count. */
+	__le32	byte_count;		/* Total byte count. */
 
 	uint8_t port_id[3];             /* PortID of destination port. */
 	uint8_t vp_index;
@@ -82,24 +82,24 @@ struct pt_ls4_request {
 	uint8_t sys_define;
 	uint8_t entry_status;
 	uint32_t handle;
-	uint16_t status;
-	uint16_t nport_handle;
-	uint16_t tx_dseg_count;
+	__le16	status;
+	__le16	nport_handle;
+	__le16	tx_dseg_count;
 	uint8_t  vp_index;
 	uint8_t  rsvd;
-	uint16_t timeout;
-	uint16_t control_flags;
+	__le16	timeout;
+	__le16	control_flags;
 #define CF_LS4_SHIFT		13
 #define CF_LS4_ORIGINATOR	0
 #define CF_LS4_RESPONDER	1
 #define CF_LS4_RESPONDER_TERM	2
 
-	uint16_t rx_dseg_count;
+	__le16	rx_dseg_count;
 	uint16_t rsvd2;
 	uint32_t exchange_address;
 	uint32_t rsvd3;
-	uint32_t rx_byte_count;
-	uint32_t tx_byte_count;
+	__le32	rx_byte_count;
+	__le32	tx_byte_count;
 	struct dsd64 dsd[2];
 };
 
@@ -112,8 +112,8 @@ struct pt_ls4_rx_unsol {
 	uint8_t vp_index;
 	uint8_t rsvd2;
 	uint16_t rsvd3;
-	uint16_t nport_handle;
-	uint16_t frame_size;
+	__le16	nport_handle;
+	__le16	frame_size;
 	uint16_t rsvd4;
 	uint32_t exchange_address;
 	uint8_t d_id[3];
@@ -122,16 +122,16 @@ struct pt_ls4_rx_unsol {
 	uint8_t cs_ctl;
 	uint8_t f_ctl[3];
 	uint8_t type;
-	uint16_t seq_cnt;
+	__le16	seq_cnt;
 	uint8_t df_ctl;
 	uint8_t seq_id;
-	uint16_t rx_id;
-	uint16_t ox_id;
-	uint32_t param;
-	uint32_t desc0;
+	__le16	rx_id;
+	__le16	ox_id;
+	__le32	param;
+	__le32	desc0;
 #define PT_LS4_PAYLOAD_OFFSET 0x2c
 #define PT_LS4_FIRST_PACKET_LEN 20
-	uint32_t desc_len;
+	__le32	desc_len;
 	uint32_t payload[3];
 };
 
diff --git a/drivers/scsi/qla2xxx/qla_nx.h b/drivers/scsi/qla2xxx/qla_nx.h
index 230abee10598..93344a05910a 100644
--- a/drivers/scsi/qla2xxx/qla_nx.h
+++ b/drivers/scsi/qla2xxx/qla_nx.h
@@ -800,16 +800,16 @@ struct qla82xx_legacy_intr_set {
 #define QLA82XX_URI_FIRMWARE_IDX_OFF	29
 
 struct qla82xx_uri_table_desc{
-	uint32_t	findex;
-	uint32_t	num_entries;
-	uint32_t	entry_size;
-	uint32_t	reserved[5];
+	__le32	findex;
+	__le32	num_entries;
+	__le32	entry_size;
+	__le32	reserved[5];
 };
 
 struct qla82xx_uri_data_desc{
-	uint32_t	findex;
-	uint32_t	size;
-	uint32_t	reserved[5];
+	__le32	findex;
+	__le32	size;
+	__le32	reserved[5];
 };
 
 /* UNIFIED ROMIMAGE END */
@@ -829,22 +829,22 @@ struct qla82xx_uri_data_desc{
  * ISP 8021 I/O Register Set structure definitions.
  */
 struct device_reg_82xx {
-	uint32_t req_q_out[64];		/* Request Queue out-Pointer (64 * 4) */
-	uint32_t rsp_q_in[64];		/* Response Queue In-Pointer. */
-	uint32_t rsp_q_out[64];		/* Response Queue Out-Pointer. */
+	__le32	req_q_out[64];		/* Request Queue out-Pointer (64 * 4) */
+	__le32	rsp_q_in[64];		/* Response Queue In-Pointer. */
+	__le32	rsp_q_out[64];		/* Response Queue Out-Pointer. */
 
-	uint16_t mailbox_in[32];	/* Mail box In registers */
-	uint16_t unused_1[32];
-	uint32_t hint;			/* Host interrupt register */
+	__le16	mailbox_in[32];		/* Mailbox In registers */
+	__le16	unused_1[32];
+	__le32	hint;			/* Host interrupt register */
 #define	HINT_MBX_INT_PENDING	BIT_0
-	uint16_t unused_2[62];
-	uint16_t mailbox_out[32];	/* Mail box Out registers */
-	uint32_t unused_3[48];
+	__le16	unused_2[62];
+	__le16	mailbox_out[32];	/* Mailbox Out registers */
+	__le32	unused_3[48];
 
-	uint32_t host_status;		/* host status */
+	__le32	host_status;		/* host status */
 #define HSRX_RISC_INT		BIT_15	/* RISC to Host interrupt. */
 #define HSRX_RISC_PAUSED	BIT_8	/* RISC Paused. */
-	uint32_t host_int;		/* Interrupt status. */
+	__le32	host_int;		/* Interrupt status. */
 #define ISRX_NX_RISC_INT	BIT_0	/* RISC interrupt. */
 };
 
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 3cf8590feeac..eb176fd9c105 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -135,37 +135,37 @@ struct nack_to_isp {
 	uint8_t	 entry_status;		    /* Entry Status. */
 	union {
 		struct {
-			uint32_t sys_define_2; /* System defined. */
+			__le32	sys_define_2; /* System defined. */
 			target_id_t target;
 			uint8_t	 target_id;
 			uint8_t	 reserved_1;
-			uint16_t flags;
-			uint16_t resp_code;
-			uint16_t status;
-			uint16_t task_flags;
-			uint16_t seq_id;
-			uint16_t srr_rx_id;
-			uint32_t srr_rel_offs;
-			uint16_t srr_ui;
-			uint16_t srr_flags;
-			uint16_t srr_reject_code;
+			__le16	flags;
+			__le16	resp_code;
+			__le16	status;
+			__le16	task_flags;
+			__le16	seq_id;
+			__le16	srr_rx_id;
+			__le32	srr_rel_offs;
+			__le16	srr_ui;
+			__le16	srr_flags;
+			__le16	srr_reject_code;
 			uint8_t  srr_reject_vendor_uniq;
 			uint8_t  srr_reject_code_expl;
 			uint8_t  reserved_2[24];
 		} isp2x;
 		struct {
 			uint32_t handle;
-			uint16_t nport_handle;
+			__le16	nport_handle;
 			uint16_t reserved_1;
-			uint16_t flags;
-			uint16_t srr_rx_id;
-			uint16_t status;
+			__le16	flags;
+			__le16	srr_rx_id;
+			__le16	status;
 			uint8_t  status_subcode;
 			uint8_t  fw_handle;
 			uint32_t exchange_address;
-			uint32_t srr_rel_offs;
-			uint16_t srr_ui;
-			uint16_t srr_flags;
+			__le32	srr_rel_offs;
+			__le16	srr_ui;
+			__le16	srr_flags;
 			uint8_t  reserved_4[19];
 			uint8_t  vp_index;
 			uint8_t  srr_reject_vendor_uniq;
@@ -175,7 +175,7 @@ struct nack_to_isp {
 		} isp24;
 	} u;
 	uint8_t  reserved[2];
-	uint16_t ox_id;
+	__le16	ox_id;
 } __packed;
 #define NOTIFY_ACK_FLAGS_TERMINATE	BIT_3
 #define NOTIFY_ACK_SRR_FLAGS_ACCEPT	0
@@ -206,16 +206,16 @@ struct ctio_to_2xxx {
 	uint8_t	 entry_status;		/* Entry Status. */
 	uint32_t handle;		/* System defined handle */
 	target_id_t target;
-	uint16_t rx_id;
-	uint16_t flags;
-	uint16_t status;
-	uint16_t timeout;		/* 0 = 30 seconds, 0xFFFF = disable */
-	uint16_t dseg_count;		/* Data segment count. */
-	uint32_t relative_offset;
-	uint32_t residual;
-	uint16_t reserved_1[3];
-	uint16_t scsi_status;
-	uint32_t transfer_length;
+	__le16	rx_id;
+	__le16	flags;
+	__le16	status;
+	__le16	timeout;		/* 0 = 30 seconds, 0xFFFF = disable */
+	__le16	dseg_count;		/* Data segment count. */
+	__le32	relative_offset;
+	__le32	residual;
+	__le16	reserved_1[3];
+	__le16	scsi_status;
+	__le32	transfer_length;
 	struct dsd32 dsd[3];
 } __packed;
 #define ATIO_PATH_INVALID       0x07
@@ -257,7 +257,7 @@ struct fcp_hdr {
 	uint16_t seq_cnt;
 	__be16   ox_id;
 	uint16_t rx_id;
-	uint32_t parameter;
+	__le32	parameter;
 } __packed;
 
 struct fcp_hdr_le {
@@ -267,12 +267,12 @@ struct fcp_hdr_le {
 	uint8_t  cs_ctl;
 	uint8_t  f_ctl[3];
 	uint8_t  type;
-	uint16_t seq_cnt;
+	__le16	seq_cnt;
 	uint8_t  df_ctl;
 	uint8_t  seq_id;
-	uint16_t rx_id;
-	uint16_t ox_id;
-	uint32_t parameter;
+	__le16	rx_id;
+	__le16	ox_id;
+	__le32	parameter;
 } __packed;
 
 #define F_CTL_EXCH_CONTEXT_RESP	BIT_23
@@ -306,7 +306,7 @@ struct atio7_fcp_cmnd {
 	 * BUILD_BUG_ON in qlt_init().
 	 */
 	uint8_t  add_cdb[4];
-	/* uint32_t data_length; */
+	/* __le32	data_length; */
 } __packed;
 
 /*
@@ -316,27 +316,27 @@ struct atio7_fcp_cmnd {
 struct atio_from_isp {
 	union {
 		struct {
-			uint16_t entry_hdr;
+			__le16	entry_hdr;
 			uint8_t  sys_define;   /* System defined. */
 			uint8_t  entry_status; /* Entry Status.   */
-			uint32_t sys_define_2; /* System defined. */
+			__le32	sys_define_2; /* System defined. */
 			target_id_t target;
-			uint16_t rx_id;
-			uint16_t flags;
-			uint16_t status;
+			__le16	rx_id;
+			__le16	flags;
+			__le16	status;
 			uint8_t  command_ref;
 			uint8_t  task_codes;
 			uint8_t  task_flags;
 			uint8_t  execution_codes;
 			uint8_t  cdb[MAX_CMDSZ];
-			uint32_t data_length;
-			uint16_t lun;
+			__le32	data_length;
+			__le16	lun;
 			uint8_t  initiator_port_name[WWN_SIZE]; /* on qla23xx */
-			uint16_t reserved_32[6];
-			uint16_t ox_id;
+			__le16	reserved_32[6];
+			__le16	ox_id;
 		} isp2x;
 		struct {
-			uint16_t entry_hdr;
+			__le16	entry_hdr;
 			uint8_t  fcp_cmnd_len_low;
 			uint8_t  fcp_cmnd_len_high:4;
 			uint8_t  attr:4;
@@ -352,7 +352,7 @@ struct atio_from_isp {
 #define FCP_CMD_LENGTH_MASK 0x0fff
 #define FCP_CMD_LENGTH_MIN  0x38
 			uint8_t  data[56];
-			uint32_t signature;
+			__le32	signature;
 #define ATIO_PROCESSED 0xDEADDEAD		/* Signature */
 		} raw;
 	} u;
@@ -395,10 +395,10 @@ struct ctio7_to_24xx {
 	uint8_t	 sys_define;		    /* System defined. */
 	uint8_t	 entry_status;		    /* Entry Status. */
 	uint32_t handle;		    /* System defined handle */
-	uint16_t nport_handle;
+	__le16	nport_handle;
 #define CTIO7_NHANDLE_UNRECOGNIZED	0xFFFF
-	uint16_t timeout;
-	uint16_t dseg_count;		    /* Data segment count. */
+	__le16	timeout;
+	__le16	dseg_count;		    /* Data segment count. */
 	uint8_t  vp_index;
 	uint8_t  add_flags;
 	le_id_t  initiator_id;
@@ -406,25 +406,25 @@ struct ctio7_to_24xx {
 	uint32_t exchange_addr;
 	union {
 		struct {
-			uint16_t reserved1;
+			__le16	reserved1;
 			__le16 flags;
-			uint32_t residual;
+			__le32	residual;
 			__le16 ox_id;
-			uint16_t scsi_status;
-			uint32_t relative_offset;
-			uint32_t reserved2;
-			uint32_t transfer_length;
-			uint32_t reserved3;
+			__le16	scsi_status;
+			__le32	relative_offset;
+			__le32	reserved2;
+			__le32	transfer_length;
+			__le32	reserved3;
 			struct dsd64 dsd;
 		} status0;
 		struct {
-			uint16_t sense_length;
+			__le16	sense_length;
 			__le16 flags;
-			uint32_t residual;
+			__le32	residual;
 			__le16 ox_id;
-			uint16_t scsi_status;
-			uint16_t response_len;
-			uint16_t reserved;
+			__le16	scsi_status;
+			__le16	response_len;
+			__le16	reserved;
 			uint8_t sense_data[24];
 		} status1;
 	} u;
@@ -440,18 +440,18 @@ struct ctio7_from_24xx {
 	uint8_t	 sys_define;		    /* System defined. */
 	uint8_t	 entry_status;		    /* Entry Status. */
 	uint32_t handle;		    /* System defined handle */
-	uint16_t status;
-	uint16_t timeout;
-	uint16_t dseg_count;		    /* Data segment count. */
+	__le16	status;
+	__le16	timeout;
+	__le16	dseg_count;		    /* Data segment count. */
 	uint8_t  vp_index;
 	uint8_t  reserved1[5];
 	uint32_t exchange_address;
-	uint16_t reserved2;
-	uint16_t flags;
-	uint32_t residual;
-	uint16_t ox_id;
-	uint16_t reserved3;
-	uint32_t relative_offset;
+	__le16	reserved2;
+	__le16	flags;
+	__le32	residual;
+	__le16	ox_id;
+	__le16	reserved3;
+	__le32	relative_offset;
 	uint8_t  reserved4[24];
 } __packed;
 
@@ -489,10 +489,10 @@ struct ctio_crc2_to_fw {
 	uint8_t entry_status;		/* Entry Status. */
 
 	uint32_t handle;		/* System handle. */
-	uint16_t nport_handle;		/* N_PORT handle. */
+	__le16	nport_handle;		/* N_PORT handle. */
 	__le16 timeout;		/* Command timeout. */
 
-	uint16_t dseg_count;		/* Data segment count. */
+	__le16	dseg_count;		/* Data segment count. */
 	uint8_t  vp_index;
 	uint8_t  add_flags;		/* additional flags */
 #define CTIO_CRC2_AF_DIF_DSD_ENA BIT_3
@@ -500,18 +500,18 @@ struct ctio_crc2_to_fw {
 	le_id_t  initiator_id;		/* initiator ID */
 	uint8_t  reserved1;
 	uint32_t exchange_addr;		/* rcv exchange address */
-	uint16_t reserved2;
+	__le16	reserved2;
 	__le16 flags;			/* refer to CTIO7 flags values */
-	uint32_t residual;
+	__le32	residual;
 	__le16 ox_id;
-	uint16_t scsi_status;
+	__le16	scsi_status;
 	__le32 relative_offset;
-	uint32_t reserved5;
+	__le32	reserved5;
 	__le32 transfer_length;		/* total fc transfer length */
-	uint32_t reserved6;
+	__le32	reserved6;
 	__le64	 crc_context_address __packed; /* Data segment address. */
-	uint16_t crc_context_len;	/* Data segment length. */
-	uint16_t reserved_1;		/* MUST be set to 0. */
+	__le16	crc_context_len;	/* Data segment length. */
+	__le16	reserved_1;		/* MUST be set to 0. */
 };
 
 /* CTIO Type CRC_x Status IOCB */
@@ -522,20 +522,20 @@ struct ctio_crc_from_fw {
 	uint8_t entry_status;		/* Entry Status. */
 
 	uint32_t handle;		/* System handle. */
-	uint16_t status;
-	uint16_t timeout;		/* Command timeout. */
-	uint16_t dseg_count;		/* Data segment count. */
-	uint32_t reserved1;
-	uint16_t state_flags;
+	__le16	status;
+	__le16	timeout;		/* Command timeout. */
+	__le16	dseg_count;		/* Data segment count. */
+	__le32	reserved1;
+	__le16	state_flags;
 #define CTIO_CRC_SF_DIF_CHOPPED BIT_4
 
 	uint32_t exchange_address;	/* rcv exchange address */
-	uint16_t reserved2;
-	uint16_t flags;
-	uint32_t resid_xfer_length;
-	uint16_t ox_id;
+	__le16	reserved2;
+	__le16	flags;
+	__le32	resid_xfer_length;
+	__le16	ox_id;
 	uint8_t  reserved3[12];
-	uint16_t runt_guard;		/* reported runt blk guard */
+	__le16	runt_guard;		/* reported runt blk guard */
 	uint8_t  actual_dif[8];
 	uint8_t  expected_dif[8];
 } __packed;
@@ -558,7 +558,7 @@ struct abts_recv_from_24xx {
 	uint8_t	 sys_define;		    /* System defined. */
 	uint8_t	 entry_status;		    /* Entry Status. */
 	uint8_t  reserved_1[6];
-	uint16_t nport_handle;
+	__le16	nport_handle;
 	uint8_t  reserved_2[2];
 	uint8_t  vp_index;
 	uint8_t  reserved_3:4;
@@ -572,15 +572,15 @@ struct abts_recv_from_24xx {
 #define ABTS_PARAM_ABORT_SEQ		BIT_0
 
 struct ba_acc_le {
-	uint16_t reserved;
+	__le16	reserved;
 	uint8_t  seq_id_last;
 	uint8_t  seq_id_valid;
 #define SEQ_ID_VALID	0x80
 #define SEQ_ID_INVALID	0x00
-	uint16_t rx_id;
-	uint16_t ox_id;
-	uint16_t high_seq_cnt;
-	uint16_t low_seq_cnt;
+	__le16	rx_id;
+	__le16	ox_id;
+	__le16	high_seq_cnt;
+	__le16	low_seq_cnt;
 } __packed;
 
 struct ba_rjt_le {
@@ -604,9 +604,9 @@ struct abts_resp_to_24xx {
 	uint8_t	 sys_define;		    /* System defined. */
 	uint8_t	 entry_status;		    /* Entry Status. */
 	uint32_t handle;
-	uint16_t reserved_1;
-	uint16_t nport_handle;
-	uint16_t control_flags;
+	__le16	reserved_1;
+	__le16	nport_handle;
+	__le16	control_flags;
 #define ABTS_CONTR_FLG_TERM_EXCHG	BIT_0
 	uint8_t  vp_index;
 	uint8_t  reserved_3:4;
@@ -617,7 +617,7 @@ struct abts_resp_to_24xx {
 		struct ba_acc_le ba_acct;
 		struct ba_rjt_le ba_rjt;
 	} __packed payload;
-	uint32_t reserved_4;
+	__le32	reserved_4;
 	uint32_t exchange_addr_to_abort;
 } __packed;
 
@@ -634,20 +634,20 @@ struct abts_resp_from_24xx_fw {
 	uint8_t	 sys_define;		    /* System defined. */
 	uint8_t	 entry_status;		    /* Entry Status. */
 	uint32_t handle;
-	uint16_t compl_status;
+	__le16	compl_status;
 #define ABTS_RESP_COMPL_SUCCESS		0
 #define ABTS_RESP_COMPL_SUBCODE_ERROR	0x31
-	uint16_t nport_handle;
-	uint16_t reserved_1;
+	__le16	nport_handle;
+	__le16	reserved_1;
 	uint8_t  reserved_2;
 	uint8_t  reserved_3:4;
 	uint8_t  sof_type:4;
 	uint32_t exchange_address;
 	struct fcp_hdr_le fcp_hdr_le;
 	uint8_t reserved_4[8];
-	uint32_t error_subcode1;
+	__le32	error_subcode1;
 #define ABTS_RESP_SUBCODE_ERR_ABORTED_EXCH_NOT_TERM	0x1E
-	uint32_t error_subcode2;
+	__le32	error_subcode2;
 	uint32_t exchange_addr_to_abort;
 } __packed;
 
