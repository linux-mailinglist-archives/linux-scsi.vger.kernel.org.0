Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6111876006F
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jul 2023 22:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjGXU0q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jul 2023 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGXU0n (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jul 2023 16:26:43 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C19F1B8
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jul 2023 13:26:42 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so2784672b3a.0
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jul 2023 13:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690230402; x=1690835202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oT6hB/5SaAbcAvfnToKA+2yv5LSyr863W5xnvqiRPU=;
        b=N0OT95aYxlSguV6G1lGc/U0n9XbNhEoQfObb6nfQNDLAaUQ7FZpxP8P6KiEXke3iiY
         RcHJPsIYOy9EQd5cJ2A1eaaFX5oYFAbj2gFbzArVHPNscrS1LzDvTMccknGzLWlf/4tZ
         k9VL37goSdFzIbS8a2M9xA38Wv5Sa/HS6+h4YmbKPJqxw9KLM9nSmfR7CgqSq4ey1zIx
         T2I4um/nFpoqNb9N9gp37sxgrVJszLsHwvsE7ANKqisLAGePO376kBZYUURVYtei3FKm
         jBsPYsIwMc5YVNhdZNT90lArQIyh+8j93kAooNIiZ8wu6+M3pY309pl5taE1/OAen/oj
         HpxQ==
X-Gm-Message-State: ABy/qLZVNUIUkVTm28NjkoQe1dvwpym3klYrzsN3uFVWbOu+eaXTMAlr
        GDrbujEbvX8cXf4OKBEiGxs=
X-Google-Smtp-Source: APBJJlFfzY4BJ4NQQKzMPFokIjtBA4Cw0R2hXfqpAlDwWMqxqu57iYyWXHAb49zUl0+YSnFaMNOZXg==
X-Received: by 2002:a05:6a00:114c:b0:680:ddd6:7d8b with SMTP id b12-20020a056a00114c00b00680ddd67d8bmr8246774pfm.15.1690230401735;
        Mon, 24 Jul 2023 13:26:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bda6:6519:2a73:345e])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7850d000000b00653fe2d527esm8185540pfn.32.2023.07.24.13.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 13:26:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Liang He <windhl@126.com>
Subject: [PATCH 02/12] scsi: ufs: Document all return values
Date:   Mon, 24 Jul 2023 13:16:37 -0700
Message-ID: <20230724202024.3379114-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230724202024.3379114-1-bvanassche@acm.org>
References: <20230724202024.3379114-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes multiple W=2 kernel-doc warnings.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs_bsg.c       |  2 ++
 drivers/ufs/core/ufshcd.c        | 38 ++++++++++++++++++++++++++++++++
 drivers/ufs/host/cdns-pltfrm.c   |  4 ++--
 drivers/ufs/host/ufshcd-pltfrm.c |  2 ++
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 0d38e7fa34cc..34e423924e06 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -232,6 +232,8 @@ static inline void ufs_bsg_node_release(struct device *dev)
  * @hba: per adapter object
  *
  * Called during initial loading of the driver, and before scsi_scan_host.
+ *
+ * Returns: 0 (success).
  */
 int ufs_bsg_probe(struct ufs_hba *hba)
 {
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d7b83230ddbb..ca520f2b1820 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -876,6 +876,8 @@ static inline u32 ufshcd_get_dme_attr_val(struct ufs_hba *hba)
 /**
  * ufshcd_get_req_rsp - returns the TR response transaction type
  * @ucd_rsp_ptr: pointer to response UPIU
+ *
+ * Return: UPIU type.
  */
 static inline int
 ufshcd_get_req_rsp(struct utp_upiu_rsp *ucd_rsp_ptr)
@@ -2241,6 +2243,8 @@ static inline void ufshcd_copy_sense_data(struct ufshcd_lrb *lrbp)
  * descriptor
  * @hba: per adapter instance
  * @lrbp: pointer to local reference block
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static
 int ufshcd_copy_query_response(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
@@ -2713,6 +2717,8 @@ static inline void ufshcd_prepare_utp_nop_upiu(struct ufshcd_lrb *lrbp)
  *			     for Device Management Purposes
  * @hba: per adapter instance
  * @lrbp: pointer to local reference block
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
 				      struct ufshcd_lrb *lrbp)
@@ -2741,6 +2747,8 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
  *			   for SCSI Purposes
  * @hba: per adapter instance
  * @lrbp: pointer to local reference block
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 {
@@ -3018,6 +3026,8 @@ ufshcd_check_query_response(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
  * ufshcd_dev_cmd_completion() - handles device management command responses
  * @hba: per adapter instance
  * @lrbp: pointer to local reference block
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int
 ufshcd_dev_cmd_completion(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
@@ -3155,6 +3165,8 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
  * @cmd_type: specifies the type (NOP, Query...)
  * @timeout: timeout in milliseconds
  *
+ * Return: 0 upon success; < 0 upon failure.
+ *
  * NOTE: Since there is only one available tag for device management commands,
  * it is expected you hold the hba->dev_cmd.lock mutex.
  */
@@ -4387,6 +4399,8 @@ static void ufshcd_init_pwr_info(struct ufs_hba *hba)
 /**
  * ufshcd_get_max_pwr_mode - reads the max power mode negotiated with device
  * @hba: per-adapter instance
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_get_max_pwr_mode(struct ufs_hba *hba)
 {
@@ -4544,6 +4558,8 @@ static int ufshcd_change_power_mode(struct ufs_hba *hba,
  * ufshcd_config_pwr_mode - configure a new power mode
  * @hba: per-adapter instance
  * @desired_pwr_mode: desired power configuration
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 		struct ufs_pa_layer_attr *desired_pwr_mode)
@@ -4568,6 +4584,8 @@ EXPORT_SYMBOL_GPL(ufshcd_config_pwr_mode);
  * @hba: per-adapter instance
  *
  * Set fDeviceInit flag and poll until device toggles it.
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_complete_dev_init(struct ufs_hba *hba)
 {
@@ -4939,6 +4957,8 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
  * If the UTP layer at the device side is not initialized, it may
  * not respond with NOP IN UPIU within timeout of %NOP_OUT_TIMEOUT
  * and we retry sending NOP OUT for %NOP_OUT_RETRIES iterations.
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 {
@@ -5099,6 +5119,8 @@ static int ufshcd_slave_alloc(struct scsi_device *sdev)
  * @depth: required depth to set
  *
  * Change queue depth and make sure the max. limits are not crossed.
+ *
+ * Return: new queue depth.
  */
 static int ufshcd_change_queue_depth(struct scsi_device *sdev, int depth)
 {
@@ -5108,6 +5130,8 @@ static int ufshcd_change_queue_depth(struct scsi_device *sdev, int depth)
 /**
  * ufshcd_slave_configure - adjust SCSI device configurations
  * @sdev: pointer to SCSI device
+ *
+ * Return: 0 (success).
  */
 static int ufshcd_slave_configure(struct scsi_device *sdev)
 {
@@ -5824,6 +5848,8 @@ static int ufshcd_bkops_ctrl(struct ufs_hba *hba,
  *
  * If BKOPs is enabled, this function returns 0, 1 if the bkops in not enabled
  * and negative error value for any other failure.
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_urgent_bkops(struct ufs_hba *hba)
 {
@@ -7064,6 +7090,8 @@ static int ufshcd_issue_tm_cmd(struct ufs_hba *hba, int lun_id, int task_id,
  *
  * Since there is only one available tag for device management commands,
  * the caller is expected to hold the hba->dev_cmd.lock mutex.
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 					struct utp_upiu_req *req_upiu,
@@ -7165,6 +7193,8 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
  * Management requests.
  * It is up to the caller to fill the upiu conent properly, as it will
  * be copied without any further input validations.
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 			     struct utp_upiu_req *req_upiu,
@@ -8478,6 +8508,8 @@ static int ufshcd_device_params_init(struct ufs_hba *hba)
 /**
  * ufshcd_add_lus - probe and add UFS logical units
  * @hba: per-adapter instance
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_add_lus(struct ufs_hba *hba)
 {
@@ -8687,6 +8719,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
  * @init_dev_params: whether or not to call ufshcd_device_params_init().
  *
  * Execute link-startup and verify device initialization
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 {
@@ -9841,6 +9875,8 @@ static int ufshcd_wl_resume(struct device *dev)
  *
  * This function will put disable irqs, turn off clocks
  * and set vreg and hba-vreg in lpm mode.
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_suspend(struct ufs_hba *hba)
 {
@@ -10002,6 +10038,8 @@ EXPORT_SYMBOL(ufshcd_runtime_suspend);
  *
  * 1. Turn on all the controller related clocks
  * 2. Turn ON VCC rail
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 int ufshcd_runtime_resume(struct device *dev)
 {
diff --git a/drivers/ufs/host/cdns-pltfrm.c b/drivers/ufs/host/cdns-pltfrm.c
index 5b1e1e26d133..9c96aa8810ac 100644
--- a/drivers/ufs/host/cdns-pltfrm.c
+++ b/drivers/ufs/host/cdns-pltfrm.c
@@ -235,7 +235,7 @@ static int cdns_ufs_init(struct ufs_hba *hba)
  * cdns_ufs_m31_16nm_phy_initialization - performs m31 phy initialization
  * @hba: host controller instance
  *
- * Always returns 0
+ * Return: 0 (success).
  */
 static int cdns_ufs_m31_16nm_phy_initialization(struct ufs_hba *hba)
 {
@@ -308,7 +308,7 @@ static int cdns_ufs_pltfrm_probe(struct platform_device *pdev)
  * cdns_ufs_pltfrm_remove - removes the ufs driver
  * @pdev: pointer to platform device handle
  *
- * Always returns 0
+ * Return: 0 (success).
  */
 static int cdns_ufs_pltfrm_remove(struct platform_device *pdev)
 {
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 34131d36d09f..8729f45d4f83 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -166,6 +166,8 @@ EXPORT_SYMBOL_GPL(ufshcd_populate_vreg);
  * If any of the supplies are not defined it is assumed that they are always-on
  * and hence return zero. If the property is defined but parsing is failed
  * then return corresponding error.
+ *
+ * Return: 0 upon success; < 0 upon failure.
  */
 static int ufshcd_parse_regulator_info(struct ufs_hba *hba)
 {
