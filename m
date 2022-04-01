Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61BA4EE441
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Apr 2022 00:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiCaWkJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Mar 2022 18:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbiCaWkH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 31 Mar 2022 18:40:07 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866B624B0BB
        for <linux-scsi@vger.kernel.org>; Thu, 31 Mar 2022 15:38:14 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id z16so949140pfh.3
        for <linux-scsi@vger.kernel.org>; Thu, 31 Mar 2022 15:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6JP+Mf98R7u/yHJCdM6A5neSiyQyXl/rkfWVTqtC9g=;
        b=c/atJnobQKqlVoSAXzjVsZWVSEq0NidMGCWGYYyVLm1s1AW78U2FA+/VktBWaDnwhT
         mDpC1IHYzwgPRs9ieW28ETI+r7Q2wKmSaGVqfr3GWBk048X8hLyFOz/SptPL73BLCMtB
         ppuLV9JKjt3kEZdOM2P+7j9nOZrA1DhCW9YszXRoAovUQT7936LockbmGskvkjMVq+mL
         HfGFPNNu+5KO5rfjZqB7ZoNuO5KjV0YUyOBS+Jcfr40uoKuela8dx+nK5QA+7zlZVpUF
         bX776piYE9jvDqma3+vsWuVk1rfWMiXXTednkCjpMm6s7TVYwWTXkN1AvJ4ASRo//CXi
         O/Hw==
X-Gm-Message-State: AOAM5328n/CQU3mwmCFaHI2FaUdQfODIduKNeBn1671/NMtY1+uhJ+NG
        pUIzSF36vwkWxJVK0e8R9Lg=
X-Google-Smtp-Source: ABdhPJzYeUeKzBM1oGxst8DoInMBXqwUjTiBcYdp/6Dm6x48K2AuaAtlBSScLHkHBC2f3SCUqAnJQQ==
X-Received: by 2002:a63:381:0:b0:385:f8e6:bea1 with SMTP id 123-20020a630381000000b00385f8e6bea1mr12701332pgd.120.1648766293918;
        Thu, 31 Mar 2022 15:38:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6375:fa54:efe8:6c8f])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b004faee36ea56sm483481pfo.155.2022.03.31.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:38:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: [PATCH 24/29] scsi: ufs: Fix kernel-doc syntax in ufshcd.h
Date:   Thu, 31 Mar 2022 15:34:19 -0700
Message-Id: <20220331223424.1054715-25-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220331223424.1054715-1-bvanassche@acm.org>
References: <20220331223424.1054715-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes all the warnings and errors reported by the following
command:

scripts/kernel-doc -none drivers/scsi/ufs/ufshcd.h

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ufs/ufshcd.h | 89 ++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 3eb5d2c17e39..412fe43cd763 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -236,6 +236,7 @@ struct ufs_query {
  * @type: device management command type - Query, NOP OUT
  * @lock: lock to allow one command at a time
  * @complete: internal commands completion
+ * @query: Device management query information
  */
 struct ufs_dev_cmd {
 	enum dev_cmd_type type;
@@ -253,7 +254,7 @@ struct ufs_dev_cmd {
  * @min_freq: min frequency that can be used for clock scaling
  * @curr_freq: indicates the current frequency that it is set to
  * @keep_link_active: indicates that the clk should not be disabled if
-		      link is active
+ *		      link is active
  * @enabled: variable to check against multiple enable/disable
  */
 struct ufs_clk_info {
@@ -308,11 +309,13 @@ struct ufs_pwr_mode_info {
  *                  to set some things
  * @hibern8_notify: called around hibern8 enter/exit
  * @apply_dev_quirks: called to apply device specific quirks
+ * @fixup_dev_quirks: called to modify device specific quirks
  * @suspend: called during host controller PM callback
  * @resume: called during host controller PM callback
  * @dbg_register_dump: used to dump controller debug information
  * @phy_initialization: used to initialize phys
  * @device_reset: called to issue a reset pulse on the UFS device
+ * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
  */
@@ -379,6 +382,7 @@ enum clk_gating_state {
  * @is_initialized: Indicates whether clock gating is initialized or not
  * @active_reqs: number of requests that are pending and should be waited for
  * completion before gating clocks.
+ * @clk_gating_workq: workqueue for clock gating work.
  */
 struct ufs_clk_gating {
 	struct delayed_work gate_work;
@@ -415,9 +419,9 @@ struct ufs_saved_pwr_info {
  * @resume_work: worker to resume devfreq
  * @min_gear: lowest HS gear to scale down to
  * @is_enabled: tracks if scaling is currently enabled or not, controlled by
-		clkscale_enable sysfs node
+ *		clkscale_enable sysfs node
  * @is_allowed: tracks if scaling is currently allowed or not, used to block
-		clock scaling which is not invoked from devfreq governor
+ *		clock scaling which is not invoked from devfreq governor
  * @is_initialized: Indicates whether clock scaling is initialized or not
  * @is_busy_started: tracks if busy period has started or not
  * @is_suspended: tracks if devfreq is suspended or not
@@ -444,7 +448,7 @@ struct ufs_clk_scaling {
 /**
  * struct ufs_event_hist - keeps history of errors
  * @pos: index to indicate cyclic buffer position
- * @reg: cyclic buffer for registers value
+ * @val: cyclic buffer for registers value
  * @tstamp: cyclic buffer for time stamp
  * @cnt: error counter
  */
@@ -463,6 +467,7 @@ struct ufs_event_hist {
  *		reset this after link-startup.
  * @last_hibern8_exit_tstamp: Set time after the hibern8 exit.
  *		Clear after the first successful command completion.
+ * @event: array with event history.
  */
 struct ufs_stats {
 	u32 last_intr_status;
@@ -733,6 +738,13 @@ struct ufs_hba_monitor {
  * @host: Scsi_Host instance of the driver
  * @dev: device handle
  * @ufs_device_wlun: WLUN that controls the entire UFS device.
+ * @hwmon_device: device instance registered with the hwmon core.
+ * @curr_dev_pwr_mode: active UFS device power mode.
+ * @uic_link_state: active state of the link to the UFS device.
+ * @rpm_lvl: desired UFS power management level during runtime PM.
+ * @spm_lvl: desired UFS power management level during system PM.
+ * @pm_op_in_progress: whether or not a PM operation is in progress.
+ * @ahit: value of Auto-Hibernate Idle Timer register.
  * @lrb: local reference block
  * @outstanding_tasks: Bits representing outstanding task requests
  * @outstanding_lock: Protects @outstanding_reqs.
@@ -743,17 +755,26 @@ struct ufs_hba_monitor {
  * @reserved_slot: Used to submit device commands. Protected by @dev_cmd.lock.
  * @ufs_version: UFS Version to which controller complies
  * @vops: pointer to variant specific operations
+ * @vps: pointer to variant specific parameters
  * @priv: pointer to variant specific private data
  * @irq: Irq number of the controller
- * @active_uic_cmd: handle of active UIC command
- * @uic_cmd_mutex: mutex for UIC command
+ * @is_irq_enabled: whether or not the UFS controller interrupt is enabled.
+ * @dev_ref_clk_freq: reference clock frequency
+ * @quirks: bitmask with information about deviations from the UFSHCI standard.
+ * @dev_quirks: bitmask with information about deviations from the UFS standard.
  * @tmf_tag_set: TMF tag set.
  * @tmf_queue: Used to allocate TMF tags.
- * @pwr_done: completion for power mode change
+ * @tmf_rqs: array with pointers to TMF requests while these are in progress.
+ * @active_uic_cmd: handle of active UIC command
+ * @uic_cmd_mutex: mutex for UIC command
+ * @uic_async_done: completion used during UIC processing
  * @ufshcd_state: UFSHCD state
  * @eh_flags: Error handling flags
  * @intr_mask: Interrupt Mask Bits
  * @ee_ctrl_mask: Exception event control mask
+ * @ee_drv_mask: Exception event mask for driver
+ * @ee_usr_mask: Exception event mask for user (set via debugfs)
+ * @ee_ctrl_mutex: Used to serialize exception event information.
  * @is_powered: flag to check if HBA is powered
  * @shutting_down: flag to check if shutdown has been invoked
  * @host_sem: semaphore used to serialize concurrent contexts
@@ -764,26 +785,52 @@ struct ufs_hba_monitor {
  * @uic_error: UFS interconnect layer error status
  * @saved_err: sticky error mask
  * @saved_uic_err: sticky UIC error mask
+ * @ufs_stats: various error counters
  * @force_reset: flag to force eh_work perform a full reset
  * @force_pmc: flag to force a power mode change
  * @silence_err_logs: flag to silence error logs
  * @dev_cmd: ufs device management command information
  * @last_dme_cmd_tstamp: time stamp of the last completed DME command
+ * @nop_out_timeout: NOP OUT timeout value
+ * @dev_info: information about the UFS device
  * @auto_bkops_enabled: to track whether bkops is enabled in device
  * @vreg_info: UFS device voltage regulator information
  * @clk_list_head: UFS host controller clocks list node head
+ * @req_abort_count: number of times ufshcd_abort() has been called
+ * @lanes_per_direction: number of lanes per data direction between the UFS
+ *	controller and the UFS device.
  * @pwr_info: holds current power mode
  * @max_pwr_info: keeps the device max valid pwm
- * @clk_scaling_lock: used to serialize device commands and clock scaling
- * @desc_size: descriptor sizes reported by device
+ * @clk_gating: information related to clock gating
+ * @caps: bitmask with information about UFS controller capabilities
+ * @devfreq: frequency scaling information owned by the devfreq core
+ * @clk_scaling: frequency scaling information owned by the UFS driver
+ * @is_sys_suspended: whether or not the entire system has been suspended
  * @urgent_bkops_lvl: keeps track of urgent bkops level for device
  * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
  *  device is known or not.
+ * @clk_scaling_lock: used to serialize device commands and clock scaling
+ * @desc_size: descriptor sizes reported by device
  * @scsi_block_reqs_cnt: reference counting for scsi block requests
+ * @bsg_dev: struct device associated with the BSG queue
+ * @bsg_queue: BSG queue associated with the UFS controller
+ * @rpm_dev_flush_recheck_work: used to suspend from RPM (runtime power
+ *	management) after the UFS device has finished a WriteBooster buffer
+ *	flush or auto BKOP.
+ * @ufshpb_dev: information related to HPB (Host Performance Booster).
+ * @monitor: statistics about UFS commands
  * @crypto_capabilities: Content of crypto capabilities register (0x100)
  * @crypto_cap_array: Array of crypto capabilities
  * @crypto_cfg_register: Start of the crypto cfg array
  * @crypto_profile: the crypto profile of this hba (if applicable)
+ * @debugfs_root: UFS controller debugfs root directory
+ * @debugfs_ee_work: used to restore ee_ctrl_mask after a delay
+ * @debugfs_ee_rate_limit_ms: user configurable delay after which to restore
+ *	ee_ctrl_mask
+ * @luns_avail: number of regular and well known LUNs supported by the UFS
+ *	device
+ * @complete_put: whether or not to call ufshcd_rpm_put() from inside
+ *	ufshcd_resume_complete()
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -853,9 +900,9 @@ struct ufs_hba {
 	enum ufshcd_state ufshcd_state;
 	u32 eh_flags;
 	u32 intr_mask;
-	u16 ee_ctrl_mask; /* Exception event mask */
-	u16 ee_drv_mask;  /* Exception event mask for driver */
-	u16 ee_usr_mask;  /* Exception event mask for user (via debugfs) */
+	u16 ee_ctrl_mask;
+	u16 ee_drv_mask;
+	u16 ee_usr_mask;
 	struct mutex ee_ctrl_mutex;
 	bool is_powered;
 	bool shutting_down;
@@ -996,11 +1043,11 @@ static inline bool ufshcd_is_user_access_allowed(struct ufs_hba *hba)
 	readl((hba)->mmio_base + (reg))
 
 /**
- * ufshcd_rmwl - read modify write into a register
- * @hba - per adapter instance
- * @mask - mask to apply on read value
- * @val - actual value to write
- * @reg - register address
+ * ufshcd_rmwl - perform read/modify/write for a controller register
+ * @hba: per adapter instance
+ * @mask: mask to apply on read value
+ * @val: actual value to write
+ * @reg: register address
  */
 static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 {
@@ -1035,8 +1082,8 @@ static inline void check_upiu_size(void)
 
 /**
  * ufshcd_set_variant - set variant specific data to the hba
- * @hba - per adapter instance
- * @variant - pointer to variant specific data
+ * @hba: per adapter instance
+ * @variant: pointer to variant specific data
  */
 static inline void ufshcd_set_variant(struct ufs_hba *hba, void *variant)
 {
@@ -1046,7 +1093,7 @@ static inline void ufshcd_set_variant(struct ufs_hba *hba, void *variant)
 
 /**
  * ufshcd_get_variant - get variant specific data from the hba
- * @hba - per adapter instance
+ * @hba: per adapter instance
  */
 static inline void *ufshcd_get_variant(struct ufs_hba *hba)
 {
@@ -1367,7 +1414,7 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 
 extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
-/*
+/**
  * ufshcd_scsi_to_upiu_lun - maps scsi LUN to UPIU LUN
  * @scsi_lun: scsi LUN id
  *
