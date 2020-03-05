Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F3179EC3
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Mar 2020 05:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgCEEyn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Mar 2020 23:54:43 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34818 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgCEEym (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Mar 2020 23:54:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id s8so1969746pjq.0
        for <linux-scsi@vger.kernel.org>; Wed, 04 Mar 2020 20:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHbez3nLyGi1HUoXkRuEo8SDIHjcyF4LC8GS7NztVuk=;
        b=c2atgn6tzakScHiE/yRVeLhm6qQ8FNIVDAo4oJWmR0D4EH13hKOoQLSMDk8EV6Vo61
         73OLFyl9bPqXaVJlzE7C93SRDF5p632tWWR3sM3GI6vKYZ6CDnGMQ8xnV1aYFXKovv0o
         ABqn9ufQ5WSx3+7z6yz0DCzShkwQKLJ1ryBqzyGmt3Sjl2caRGwYAQNOOEE9Uy8jYuES
         rE288tlYLE6rGsn/eFMUBT6lJTOcRsCMeaVqXudE/9KfEJEM7HXzV2sQ1/QLrTCxMwSP
         S+ZMHdtdqHOu7HVFZiYAonf9swB3FusrTxeQMABVQU8PgB5maJPCb4YdSvWX39a/lc1+
         FJhQ==
X-Gm-Message-State: ANhLgQ2NGo0al01YkaOXK8luSstqWluav3m325ZigWJ/bgPr/WljJdbX
        +Sy7ia2sniaNjGqP85romuU=
X-Google-Smtp-Source: ADFU+vvRS+ox+T7WGT5dJjNCoJEI0E84vLJ6AIj4EuQSLYMCZBQF7x4J9vvDw1vP6UDZEm5L6KMGxw==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr6604166plp.323.1583384081288;
        Wed, 04 Mar 2020 20:54:41 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:ec16:4fc:3bb2:cb4a])
        by smtp.gmail.com with ESMTPSA id y14sm313721pfp.59.2020.03.04.20.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 20:54:40 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v3 2/6] qla2xxx: Add more BUILD_BUG_ON() statements
Date:   Wed,  4 Mar 2020 20:54:27 -0800
Message-Id: <20200305045431.30061-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200305045431.30061-1-bvanassche@acm.org>
References: <20200305045431.30061-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Before fixing the endianness annotations in data structures, make the
compiler verify the size of FC protocol and firmware data structures.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Quinn Tran <qutran@marvell.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c      | 74 ++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 14 ++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 17d85c4d1e3e..28d8fa6b1f6e 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7838,31 +7838,105 @@ qla2x00_module_init(void)
 {
 	int ret = 0;
 
+	BUILD_BUG_ON(sizeof(cmd_a64_entry_t) != 64);
 	BUILD_BUG_ON(sizeof(cmd_entry_t) != 64);
 	BUILD_BUG_ON(sizeof(cont_a64_entry_t) != 64);
 	BUILD_BUG_ON(sizeof(cont_entry_t) != 64);
 	BUILD_BUG_ON(sizeof(init_cb_t) != 96);
+	BUILD_BUG_ON(sizeof(mrk_entry_t) != 64);
 	BUILD_BUG_ON(sizeof(ms_iocb_entry_t) != 64);
 	BUILD_BUG_ON(sizeof(request_t) != 64);
+	BUILD_BUG_ON(sizeof(struct abort_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct abort_iocb_entry_fx00) != 64);
+	BUILD_BUG_ON(sizeof(struct abts_entry_24xx) != 64);
 	BUILD_BUG_ON(sizeof(struct access_chip_84xx) != 64);
+	BUILD_BUG_ON(sizeof(struct access_chip_84xx) != 64);
+	BUILD_BUG_ON(sizeof(struct access_chip_rsp_84xx) != 64);
+	BUILD_BUG_ON(sizeof(struct cmd_bidir) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_bidir) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_nvme) != 64);
+	BUILD_BUG_ON(sizeof(struct cmd_nvme) != 64);
+	BUILD_BUG_ON(sizeof(struct cmd_type_6) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_type_6) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_type_7) != 64);
+	BUILD_BUG_ON(sizeof(struct cmd_type_7) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_type_7_fx00) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_type_crc_2) != 64);
+	BUILD_BUG_ON(sizeof(struct cmd_type_crc_2) != 64);
 	BUILD_BUG_ON(sizeof(struct ct_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct ct_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct ct_fdmi1_hba_attributes) != 2344);
+	BUILD_BUG_ON(sizeof(struct ct_fdmi2_hba_attributes) != 4424);
+	BUILD_BUG_ON(sizeof(struct ct_fdmi2_port_attributes) != 4164);
+	BUILD_BUG_ON(sizeof(struct ct_fdmi_hba_attr) != 260);
+	BUILD_BUG_ON(sizeof(struct ct_fdmi_port_attr) != 260);
+	BUILD_BUG_ON(sizeof(struct ct_rsp_hdr) != 16);
+	BUILD_BUG_ON(sizeof(struct ct_sns_req) != 4460);
 	BUILD_BUG_ON(sizeof(struct ctio_crc2_to_fw) != 64);
+	BUILD_BUG_ON(sizeof(struct device_reg_24xx) != 256);
+	BUILD_BUG_ON(sizeof(struct device_reg_25xxmq) != 24);
+	BUILD_BUG_ON(sizeof(struct device_reg_2xxx) != 256);
+	BUILD_BUG_ON(sizeof(struct device_reg_82xx) != 1288);
+	BUILD_BUG_ON(sizeof(struct device_reg_fx00) != 216);
+	BUILD_BUG_ON(sizeof(struct els_entry_24xx) != 64);
 	BUILD_BUG_ON(sizeof(struct els_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct els_sts_entry_24xx) != 64);
 	BUILD_BUG_ON(sizeof(struct fxdisc_entry_fx00) != 64);
+	BUILD_BUG_ON(sizeof(struct fxdisc_entry_fx00) != 64);
+	BUILD_BUG_ON(sizeof(struct imm_ntfy_from_isp) != 64);
 	BUILD_BUG_ON(sizeof(struct init_cb_24xx) != 128);
 	BUILD_BUG_ON(sizeof(struct init_cb_81xx) != 128);
+	BUILD_BUG_ON(sizeof(struct init_cb_81xx) != 128);
+	BUILD_BUG_ON(sizeof(struct logio_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct mbx_entry) != 64);
+	BUILD_BUG_ON(sizeof(struct mid_init_cb_24xx) != 5252);
+	BUILD_BUG_ON(sizeof(struct mrk_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct nvram_24xx) != 512);
+	BUILD_BUG_ON(sizeof(struct nvram_81xx) != 512);
 	BUILD_BUG_ON(sizeof(struct pt_ls4_request) != 64);
+	BUILD_BUG_ON(sizeof(struct pt_ls4_rx_unsol) != 64);
+	BUILD_BUG_ON(sizeof(struct purex_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct qla2100_fw_dump) != 123634);
+	BUILD_BUG_ON(sizeof(struct qla2300_fw_dump) != 136100);
+	BUILD_BUG_ON(sizeof(struct qla24xx_fw_dump) != 37976);
+	BUILD_BUG_ON(sizeof(struct qla25xx_fw_dump) != 39228);
+	BUILD_BUG_ON(sizeof(struct qla2xxx_fce_chain) != 52);
+	BUILD_BUG_ON(sizeof(struct qla2xxx_fw_dump) != 136172);
+	BUILD_BUG_ON(sizeof(struct qla2xxx_mq_chain) != 524);
+	BUILD_BUG_ON(sizeof(struct qla2xxx_mqueue_chain) != 8);
+	BUILD_BUG_ON(sizeof(struct qla2xxx_mqueue_header) != 12);
+	BUILD_BUG_ON(sizeof(struct qla2xxx_offld_chain) != 24);
+	BUILD_BUG_ON(sizeof(struct qla81xx_fw_dump) != 39420);
+	BUILD_BUG_ON(sizeof(struct qla82xx_uri_data_desc) != 28);
+	BUILD_BUG_ON(sizeof(struct qla82xx_uri_table_desc) != 32);
+	BUILD_BUG_ON(sizeof(struct qla83xx_fw_dump) != 51196);
+	BUILD_BUG_ON(sizeof(struct qla_fdt_layout) != 128);
 	BUILD_BUG_ON(sizeof(struct qla_flt_header) != 8);
+	BUILD_BUG_ON(sizeof(struct qla_flt_header) != 8);
+	BUILD_BUG_ON(sizeof(struct qla_flt_region) != 16);
 	BUILD_BUG_ON(sizeof(struct qla_flt_region) != 16);
+	BUILD_BUG_ON(sizeof(struct qla_npiv_entry) != 24);
+	BUILD_BUG_ON(sizeof(struct qla_npiv_header) != 16);
+	BUILD_BUG_ON(sizeof(struct rdp_rsp_payload) != 336);
 	BUILD_BUG_ON(sizeof(struct sns_cmd_pkt) != 2064);
+	BUILD_BUG_ON(sizeof(struct sns_cmd_pkt) != 2064);
+	BUILD_BUG_ON(sizeof(struct sts_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct tsk_mgmt_entry) != 64);
+	BUILD_BUG_ON(sizeof(struct tsk_mgmt_entry_fx00) != 64);
+	BUILD_BUG_ON(sizeof(struct verify_chip_entry_84xx) != 64);
 	BUILD_BUG_ON(sizeof(struct verify_chip_entry_84xx) != 64);
+	BUILD_BUG_ON(sizeof(struct verify_chip_rsp_84xx) != 52);
+	BUILD_BUG_ON(sizeof(struct vf_evfp_entry_24xx) != 56);
 	BUILD_BUG_ON(sizeof(struct vf_evfp_entry_24xx) != 56);
+	BUILD_BUG_ON(sizeof(struct vp_config_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct vp_ctrl_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct vp_rpt_id_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(sts21_entry_t) != 64);
+	BUILD_BUG_ON(sizeof(sts22_entry_t) != 64);
+	BUILD_BUG_ON(sizeof(sts_cont_entry_t) != 64);
+	BUILD_BUG_ON(sizeof(sts_entry_t) != 64);
+	BUILD_BUG_ON(sizeof(sw_info_t) != 32);
+	BUILD_BUG_ON(sizeof(target_id_t) != 2);
 
 	/* Allocate cache for SRBs. */
 	srb_cachep = kmem_cache_create("qla2xxx_srbs", sizeof(srb_t), 0,
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 9f7a79aff1ee..9ff9625661e1 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -1958,6 +1958,20 @@ static int __init tcm_qla2xxx_init(void)
 {
 	int ret;
 
+	BUILD_BUG_ON(sizeof(struct abts_recv_from_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct abts_resp_from_24xx_fw) != 64);
+	BUILD_BUG_ON(sizeof(struct atio7_fcp_cmnd) != 32);
+	BUILD_BUG_ON(sizeof(struct atio_from_isp) != 64);
+	BUILD_BUG_ON(sizeof(struct ba_acc_le) != 12);
+	BUILD_BUG_ON(sizeof(struct ba_rjt_le) != 4);
+	BUILD_BUG_ON(sizeof(struct ctio7_from_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct ctio7_to_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct ctio_crc2_to_fw) != 64);
+	BUILD_BUG_ON(sizeof(struct ctio_crc_from_fw) != 64);
+	BUILD_BUG_ON(sizeof(struct ctio_to_2xxx) != 64);
+	BUILD_BUG_ON(sizeof(struct fcp_hdr_le) != 24);
+	BUILD_BUG_ON(sizeof(struct nack_to_isp) != 64);
+
 	ret = tcm_qla2xxx_register_configfs();
 	if (ret < 0)
 		return ret;
