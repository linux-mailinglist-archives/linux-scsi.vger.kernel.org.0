Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C691B9549
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2020 05:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgD0DDY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 Apr 2020 23:03:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43739 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgD0DDX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 Apr 2020 23:03:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26so8020581pgc.10
        for <linux-scsi@vger.kernel.org>; Sun, 26 Apr 2020 20:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXaKEqBW/QSMkcH7+l/lLFgNdsWmt4nAUrrdiw9qFcE=;
        b=Er6lPXAZNddJTQpPhcMsAXWTSOUT4qhjXCRcw92e4PLEWasBeK/croXZyDJJwfeb4u
         Sx2m0uJ+khfYERpTbhI8NZtEeBLlj2F6PAOmWOpAZrovV6l2nO+A2y8zPQDQP8rcKAf2
         PgOE4hg4BM72hPQ+zG0eQoM0AAKDSsJJzrt83Em9B35KifwWtEkQdfVYyhE1ZhlU1NbJ
         PKB9kfvHNK1UQdAnR/WmTa0GS/Rod2o/d9y9pKZgoqBgxAqlw8ouELnb5pF+MpQgy1Gu
         0NKlmYBAyElDDUckKvwa4hi1iQSVBZSEHYFv8RMM8g97QP6176D6JYdbSF23SoVEQJ7q
         F1pg==
X-Gm-Message-State: AGi0PuZMQiowowyB6h0yJ8wv8st72OBF1ZdYXfQWhriu+VV1zb0mp5c9
        bMRYQVZa9rT8lP6KHQVryMM=
X-Google-Smtp-Source: APiQypL5iHLP/mGbS2KSmntJ0H7+vA++UbJSnde4kZyTpoeizwxB9YlifKUa01fvUrENbuAgIQ7FZg==
X-Received: by 2002:aa7:864e:: with SMTP id a14mr22263994pfo.67.1587956602497;
        Sun, 26 Apr 2020 20:03:22 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:612a:373a:aa97:7fa7])
        by smtp.gmail.com with ESMTPSA id v94sm9982617pjb.39.2020.04.26.20.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 20:03:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v4 04/11] qla2xxx: Add more BUILD_BUG_ON() statements
Date:   Sun, 26 Apr 2020 20:03:03 -0700
Message-Id: <20200427030310.19687-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427030310.19687-1-bvanassche@acm.org>
References: <20200427030310.19687-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Before fixing the endianness annotations in data structures, make the
compiler verify the size of FC protocol and firmware data structures.

Cc: Nilesh Javali <njavali@marvell.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: Quinn Tran <qutran@marvell.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_os.c      | 59 ++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 14 +++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 497544413aa0..2dd9c2a39cd5 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7815,13 +7815,19 @@ qla2x00_module_init(void)
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
+	BUILD_BUG_ON(sizeof(struct access_chip_rsp_84xx) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_bidir) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_nvme) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_type_6) != 64);
@@ -7829,17 +7835,70 @@ qla2x00_module_init(void)
 	BUILD_BUG_ON(sizeof(struct cmd_type_7_fx00) != 64);
 	BUILD_BUG_ON(sizeof(struct cmd_type_crc_2) != 64);
 	BUILD_BUG_ON(sizeof(struct ct_entry_24xx) != 64);
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
 	BUILD_BUG_ON(sizeof(struct els_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct els_sts_entry_24xx) != 64);
 	BUILD_BUG_ON(sizeof(struct fxdisc_entry_fx00) != 64);
+	BUILD_BUG_ON(sizeof(struct imm_ntfy_from_isp) != 64);
 	BUILD_BUG_ON(sizeof(struct init_cb_24xx) != 128);
 	BUILD_BUG_ON(sizeof(struct init_cb_81xx) != 128);
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
 	BUILD_BUG_ON(sizeof(struct qla_flt_region) != 16);
+	BUILD_BUG_ON(sizeof(struct qla_npiv_entry) != 24);
+	BUILD_BUG_ON(sizeof(struct qla_npiv_header) != 16);
+	BUILD_BUG_ON(sizeof(struct rdp_rsp_payload) != 336);
 	BUILD_BUG_ON(sizeof(struct sns_cmd_pkt) != 2064);
+	BUILD_BUG_ON(sizeof(struct sts_entry_24xx) != 64);
+	BUILD_BUG_ON(sizeof(struct tsk_mgmt_entry) != 64);
+	BUILD_BUG_ON(sizeof(struct tsk_mgmt_entry_fx00) != 64);
 	BUILD_BUG_ON(sizeof(struct verify_chip_entry_84xx) != 64);
+	BUILD_BUG_ON(sizeof(struct verify_chip_rsp_84xx) != 52);
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
index 1f0a185b2a95..92e1a5d3928b 100644
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
