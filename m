Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AFD76006E
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jul 2023 22:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGXU0V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jul 2023 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGXU0U (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jul 2023 16:26:20 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124FDA4
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jul 2023 13:26:17 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-66f5faba829so3015427b3a.3
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jul 2023 13:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690230376; x=1690835176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWQcNkslr514BhjYsSUYrr1kPe6+aS3aI4PN6oMNBLg=;
        b=kbFvkF9uHAPaFqkwdqkUl/0AoR6KPvFjc3Xrpn/uJ17llMEjrTMporBECiFAecoJVh
         9nErjgTkQYXDvcdYCVcYK4R/IvazcUSiOF887YAgvruNXOSlQNg9MH0oDJJxyOJ5VN1q
         bFkCvP1hNNtChxNSdJwIzZ2NczOdSCUhAg7eB7RUHfmYHQUHwmtZQB2tkbOvg66kUysR
         cn9HRyUoxdGdRF59fafcbYbZ1FaoDiaH6LfESbO+VU0ro9fzWuQgxLWldLQlxcHBFcUj
         VGQOJKa1BihocfdPznoDhPG8LYhKFMsiM4bxBEgbzN97KQjyTlrSoc26mY7n6A+Kio0y
         7Y0w==
X-Gm-Message-State: ABy/qLbDu3xuO/BwzPHOHqvez2Nr02NcaFIP5rqyHAy5FLt65NdV7Kyz
        GMDz1UnKszO1DHCFq4qwN8U=
X-Google-Smtp-Source: APBJJlFFzNlDg2dqWIJyjnp7iAUOjg4OxOrelKoZR/QJtRMjYc7pseFiTUxXDO1TuJLNnV45ATu78g==
X-Received: by 2002:a05:6a00:2d01:b0:66f:7076:a5b8 with SMTP id fa1-20020a056a002d0100b0066f7076a5b8mr11141185pfb.29.1690230375883;
        Mon, 24 Jul 2023 13:26:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bda6:6519:2a73:345e])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7850d000000b00653fe2d527esm8185540pfn.32.2023.07.24.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 13:26:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        zhanghui <zhanghui31@xiaomi.com>,
        Daniil Lunev <dlunev@chromium.org>, Liang He <windhl@126.com>
Subject: [PATCH 01/12] scsi: ufs: Follow the kernel-doc syntax for documenting return values
Date:   Mon, 24 Jul 2023 13:16:36 -0700
Message-ID: <20230724202024.3379114-2-bvanassche@acm.org>
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

Use 'Return:' to document the return value instead of 'Returns' as
required by the kernel-doc documentation.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs-mcq.c         |  10 +-
 drivers/ufs/core/ufshcd-priv.h     |   2 +-
 drivers/ufs/core/ufshcd.c          | 186 +++++++++++++++--------------
 drivers/ufs/host/cdns-pltfrm.c     |  10 +-
 drivers/ufs/host/tc-dwc-g210-pci.c |   2 +-
 drivers/ufs/host/tc-dwc-g210.c     |  12 +-
 drivers/ufs/host/ufs-mediatek.c    |   6 +-
 drivers/ufs/host/ufs-qcom.c        |   8 +-
 drivers/ufs/host/ufshcd-dwc.c      |   6 +-
 drivers/ufs/host/ufshcd-pci.c      |   2 +-
 drivers/ufs/host/ufshcd-pltfrm.c   |   4 +-
 11 files changed, 126 insertions(+), 122 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 1e23ba3e2bdf..a3d4ef8aa3b9 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -105,7 +105,7 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
  * @hba: per adapter instance
  * @req: pointer to the request to be issued
  *
- * Returns the hardware queue instance on which the request would
+ * Return: the hardware queue instance on which the request would
  * be queued.
  */
 struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
@@ -121,7 +121,7 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
  * ufshcd_mcq_decide_queue_depth - decide the queue depth
  * @hba: per adapter instance
  *
- * Returns queue-depth on success, non-zero on error
+ * Return: queue-depth on success, non-zero on error
  *
  * MAC - Max. Active Command of the Host Controller (HC)
  * HC wouldn't send more than this commands to the device.
@@ -493,7 +493,7 @@ static int ufshcd_mcq_sq_start(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
  * @hba: per adapter instance.
  * @task_tag: The command's task tag.
  *
- * Returns 0 for success; error code otherwise.
+ * Return: 0 for success; error code otherwise.
  */
 int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
 {
@@ -575,7 +575,7 @@ static void ufshcd_mcq_nullify_sqe(struct utp_transfer_req_desc *utrd)
  * @hwq: Hardware Queue to be searched.
  * @task_tag: The command's task tag.
  *
- * Returns true if the SQE containing the command is present in the SQ
+ * Return: true if the SQE containing the command is present in the SQ
  * (not fetched by the controller); returns false if the SQE is not in the SQ.
  */
 static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
@@ -624,7 +624,7 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
  * ufshcd_mcq_abort - Abort the command in MCQ.
  * @cmd: The command to be aborted.
  *
- * Returns SUCCESS or FAILED error codes
+ * Return: SUCCESS or FAILED error codes
  */
 int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 {
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 0f3bd943b58b..4feccd5c1ba2 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -294,7 +294,7 @@ extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
  * ufshcd_scsi_to_upiu_lun - maps scsi LUN to UPIU LUN
  * @scsi_lun: scsi LUN id
  *
- * Returns UPIU LUN id
+ * Return: UPIU LUN id
  */
 static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
 {
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 27e1a4914837..d7b83230ddbb 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -701,8 +701,7 @@ EXPORT_SYMBOL_GPL(ufshcd_delay_us);
  * @interval_us: polling interval in microseconds
  * @timeout_ms: timeout in milliseconds
  *
- * Return:
- * -ETIMEDOUT on error, zero on success.
+ * Return: -ETIMEDOUT on error, zero on success.
  */
 static int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
 				u32 val, unsigned long interval_us,
@@ -730,7 +729,7 @@ static int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
  * ufshcd_get_intr_mask - Get the interrupt bit mask
  * @hba: Pointer to adapter instance
  *
- * Returns interrupt bit mask per version
+ * Return: interrupt bit mask per version
  */
 static inline u32 ufshcd_get_intr_mask(struct ufs_hba *hba)
 {
@@ -746,7 +745,7 @@ static inline u32 ufshcd_get_intr_mask(struct ufs_hba *hba)
  * ufshcd_get_ufs_version - Get the UFS version supported by the HBA
  * @hba: Pointer to adapter instance
  *
- * Returns UFSHCI version supported by the controller
+ * Return: UFSHCI version supported by the controller
  */
 static inline u32 ufshcd_get_ufs_version(struct ufs_hba *hba)
 {
@@ -773,7 +772,7 @@ static inline u32 ufshcd_get_ufs_version(struct ufs_hba *hba)
  *			      the host controller
  * @hba: pointer to adapter instance
  *
- * Returns true if device present, false if no device detected
+ * Return: true if device present, false if no device detected
  */
 static inline bool ufshcd_is_device_present(struct ufs_hba *hba)
 {
@@ -786,7 +785,8 @@ static inline bool ufshcd_is_device_present(struct ufs_hba *hba)
  * @cqe: pointer to the completion queue entry
  *
  * This function is used to get the OCS field from UTRD
- * Returns the OCS field in the UTRD
+ *
+ * Return: the OCS field in the UTRD.
  */
 static enum utp_ocs ufshcd_get_tr_ocs(struct ufshcd_lrb *lrbp,
 				      struct cq_entry *cqe)
@@ -839,7 +839,7 @@ static inline void ufshcd_utmrl_clear(struct ufs_hba *hba, u32 pos)
  * ufshcd_get_lists_status - Check UCRDY, UTRLRDY and UTMRLRDY
  * @reg: Register value of host controller status
  *
- * Returns integer, 0 on Success and positive value if failed
+ * Return: 0 on success; a positive value if failed.
  */
 static inline int ufshcd_get_lists_status(u32 reg)
 {
@@ -851,7 +851,8 @@ static inline int ufshcd_get_lists_status(u32 reg)
  * @hba: Pointer to adapter instance
  *
  * This function gets the result of UIC command completion
- * Returns 0 on success, non zero value on error
+ *
+ * Return: 0 on success; non-zero value on error.
  */
 static inline int ufshcd_get_uic_cmd_result(struct ufs_hba *hba)
 {
@@ -864,7 +865,8 @@ static inline int ufshcd_get_uic_cmd_result(struct ufs_hba *hba)
  * @hba: Pointer to adapter instance
  *
  * This function gets UIC command argument3
- * Returns 0 on success, non zero value on error
+ *
+ * Return: 0 on success; non-zero value on error.
  */
 static inline u32 ufshcd_get_dme_attr_val(struct ufs_hba *hba)
 {
@@ -886,7 +888,8 @@ ufshcd_get_req_rsp(struct utp_upiu_rsp *ucd_rsp_ptr)
  * @ucd_rsp_ptr: pointer to response UPIU
  *
  * This function gets the response status and scsi_status from response UPIU
- * Returns the response result code.
+ *
+ * Return: the response result code.
  */
 static inline int
 ufshcd_get_rsp_upiu_result(struct utp_upiu_rsp *ucd_rsp_ptr)
@@ -899,7 +902,7 @@ ufshcd_get_rsp_upiu_result(struct utp_upiu_rsp *ucd_rsp_ptr)
  *				from response UPIU
  * @ucd_rsp_ptr: pointer to response UPIU
  *
- * Return the data segment length.
+ * Return: the data segment length.
  */
 static inline unsigned int
 ufshcd_get_rsp_upiu_data_seg_len(struct utp_upiu_rsp *ucd_rsp_ptr)
@@ -915,7 +918,7 @@ ufshcd_get_rsp_upiu_data_seg_len(struct utp_upiu_rsp *ucd_rsp_ptr)
  * The function checks if the device raised an exception event indicated in
  * the Device Information field of response UPIU.
  *
- * Returns true if exception is raised, false otherwise.
+ * Return: true if exception is raised, false otherwise.
  */
 static inline bool ufshcd_is_exception_event(struct utp_upiu_rsp *ucd_rsp_ptr)
 {
@@ -991,7 +994,7 @@ static inline void ufshcd_hba_start(struct ufs_hba *hba)
  * ufshcd_is_hba_active - Get controller state
  * @hba: per adapter instance
  *
- * Returns true if and only if the controller is active.
+ * Return: true if and only if the controller is active.
  */
 static inline bool ufshcd_is_hba_active(struct ufs_hba *hba)
 {
@@ -1027,8 +1030,7 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
  * @hba: per adapter instance
  * @scale_up: If True, set max possible frequency othewise set low frequency
  *
- * Returns 0 if successful
- * Returns < 0 for any other errors
+ * Return: 0 if successful; < 0 upon failure.
  */
 static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
 {
@@ -1090,8 +1092,7 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
  * @hba: per adapter instance
  * @scale_up: True if scaling up and false if scaling down
  *
- * Returns 0 if successful
- * Returns < 0 for any other errors
+ * Return: 0 if successful; < 0 upon failure.
  */
 static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 {
@@ -1122,7 +1123,7 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
  * @hba: per adapter instance
  * @scale_up: True if scaling up and false if scaling down
  *
- * Returns true if scaling is required, false otherwise.
+ * Return: true if scaling is required, false otherwise.
  */
 static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
 					       bool scale_up)
@@ -1239,9 +1240,8 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
  * @hba: per adapter instance
  * @scale_up: True for scaling up gear and false for scaling down
  *
- * Returns 0 for success,
- * Returns -EBUSY if scaling can't happen at this time
- * Returns non-zero for any other errors
+ * Return: 0 for success; -EBUSY if scaling can't happen at this time;
+ * non-zero for any other errors.
  */
 static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
 {
@@ -1331,9 +1331,8 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, int err, bool sc
  * @hba: per adapter instance
  * @scale_up: True for scaling up and false for scalin down
  *
- * Returns 0 for success,
- * Returns -EBUSY if scaling can't happen at this time
- * Returns non-zero for any other errors
+ * Return: 0 for success; -EBUSY if scaling can't happen at this time; non-zero
+ * for any other errors.
  */
 static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 {
@@ -2318,7 +2317,8 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
  * ufshcd_ready_for_uic_cmd - Check if controller is ready
  *                            to accept UIC commands
  * @hba: per adapter instance
- * Return true on success, else false
+ *
+ * Return: true on success, else false.
  */
 static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
 {
@@ -2330,7 +2330,8 @@ static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
  * @hba: Pointer to adapter instance
  *
  * This function gets the UPMCRS field of HCS register
- * Returns value of UPMCRS field
+ *
+ * Return: value of UPMCRS field.
  */
 static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
 {
@@ -2368,7 +2369,7 @@ ufshcd_dispatch_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
  * @hba: per adapter instance
  * @uic_cmd: UIC command
  *
- * Returns 0 only if success.
+ * Return: 0 only if success.
  */
 static int
 ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
@@ -2407,7 +2408,7 @@ ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
  * @uic_cmd: UIC command
  * @completion: initialize the completion only if this is set to true
  *
- * Returns 0 only if success.
+ * Return: 0 only if success.
  */
 static int
 __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
@@ -2436,7 +2437,7 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
  * @hba: per adapter instance
  * @uic_cmd: UIC command
  *
- * Returns 0 only if success.
+ * Return: 0 only if success.
  */
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 {
@@ -2513,7 +2514,7 @@ static void ufshcd_sgl_to_prdt(struct ufs_hba *hba, struct ufshcd_lrb *lrbp, int
  * @hba: per adapter instance
  * @lrbp: pointer to local reference block
  *
- * Returns 0 in case of success, non-zero value in case of failure
+ * Return: 0 in case of success, non-zero value in case of failure.
  */
 static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 {
@@ -2765,7 +2766,7 @@ static int ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
  * ufshcd_upiu_wlun_to_scsi_wlun - maps UPIU W-LUN id to SCSI W-LUN ID
  * @upiu_wlun_id: UPIU W-LUN id
  *
- * Returns SCSI W-LUN id
+ * Return: SCSI W-LUN id.
  */
 static inline u16 ufshcd_upiu_wlun_to_scsi_wlun(u8 upiu_wlun_id)
 {
@@ -2836,7 +2837,7 @@ static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
  * @host: SCSI host pointer
  * @cmd: command from SCSI Midlayer
  *
- * Returns 0 for success, non-zero in case of failure
+ * Return: 0 for success, non-zero in case of failure.
  */
 static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 {
@@ -2947,7 +2948,7 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
  * Check with the block layer if the command is inflight
  * @cmd: command to check.
  *
- * Returns true if command is inflight; false if not.
+ * Return: true if command is inflight; false if not.
  */
 bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
 {
@@ -3245,7 +3246,7 @@ static int ufshcd_query_flag_retry(struct ufs_hba *hba,
  * @index: flag index to access
  * @flag_res: the flag value after the query request completes
  *
- * Returns 0 for success, non-zero in case of failure
+ * Return: 0 for success, non-zero in case of failure.
  */
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 			enum flag_idn idn, u8 index, bool *flag_res)
@@ -3314,7 +3315,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
  * @selector: selector field
  * @attr_val: the attribute value after the query request completes
  *
- * Returns 0 for success, non-zero in case of failure
+ * Return: 0 for success, non-zero in case of failure.
 */
 int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val)
@@ -3379,7 +3380,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
  * @attr_val: the attribute value after the query request
  * completes
  *
- * Returns 0 for success, non-zero in case of failure
+ * Return: 0 for success, non-zero in case of failure.
 */
 int ufshcd_query_attr_retry(struct ufs_hba *hba,
 	enum query_opcode opcode, enum attr_idn idn, u8 index, u8 selector,
@@ -3477,9 +3478,10 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
  * @desc_buf: the buffer that contains the descriptor
  * @buf_len: length parameter passed to the device
  *
- * Returns 0 for success, non-zero in case of failure.
  * The buf_len parameter will contain, on return, the length parameter
  * received on the response.
+ *
+ * Return: 0 for success, non-zero in case of failure.
  */
 int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
 				  enum query_opcode opcode,
@@ -3509,7 +3511,7 @@ int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
  * @param_read_buf: pointer to buffer where parameter would be read
  * @param_size: sizeof(param_read_buf)
  *
- * Return 0 in case of success, non-zero otherwise
+ * Return: 0 in case of success, non-zero otherwise.
  */
 int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   enum desc_idn desc_id,
@@ -3689,7 +3691,7 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
  * @param_read_buf: pointer to buffer where parameter would be read
  * @param_size: sizeof(param_read_buf)
  *
- * Return 0 in case of success, non-zero otherwise
+ * Return: 0 in case of success, non-zero otherwise.
  */
 static inline int ufshcd_read_unit_desc_param(struct ufs_hba *hba,
 					      int lun,
@@ -3744,7 +3746,7 @@ static int ufshcd_get_ref_clk_gating_wait(struct ufs_hba *hba)
  *	(UTMRDL)
  * 4. Allocate memory for local reference block(lrb).
  *
- * Returns 0 for success, non-zero in case of failure
+ * Return: 0 for success, non-zero in case of failure.
  */
 static int ufshcd_memory_alloc(struct ufs_hba *hba)
 {
@@ -3891,7 +3893,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
  * Once the Unipro links are up, the device connected to the controller
  * is detected.
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 static int ufshcd_dme_link_startup(struct ufs_hba *hba)
 {
@@ -3913,7 +3915,7 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
  * DME_RESET command is issued in order to reset UniPro stack.
  * This function now deals with cold reset.
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 static int ufshcd_dme_reset(struct ufs_hba *hba)
 {
@@ -3952,7 +3954,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_configure_adapt);
  *
  * DME_ENABLE command is issued in order to enable UniPro stack.
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 static int ufshcd_dme_enable(struct ufs_hba *hba)
 {
@@ -4008,7 +4010,7 @@ static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
  * @mib_val: setting value as uic command argument3
  * @peer: indicate whether peer or local
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
 			u8 attr_set, u32 mib_val, u8 peer)
@@ -4052,7 +4054,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_set_attr);
  * @mib_val: the value of the attribute as returned by the UIC command
  * @peer: indicate whether peer or local
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 			u32 *mib_val, u8 peer)
@@ -4133,7 +4135,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_get_attr);
  * addition to normal UIC command completion Status (UCCS). This function only
  * returns after the relevant status bits indicate the completion.
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 {
@@ -4223,7 +4225,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
  * @hba: per adapter instance
  * @mode: powr mode value
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
 {
@@ -4616,7 +4618,7 @@ static int ufshcd_complete_dev_init(struct ufs_hba *hba)
  * 3. Program UTRL and UTMRL base address
  * 4. Configure run-stop-registers
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_make_hba_operational(struct ufs_hba *hba)
 {
@@ -4697,7 +4699,7 @@ EXPORT_SYMBOL_GPL(ufshcd_hba_stop);
  * sequence kicks off. When controller is ready it will set
  * the Host Controller Enable bit to 1.
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
 {
@@ -4842,7 +4844,7 @@ EXPORT_SYMBOL_GPL(ufshcd_update_evt_hist);
  * ufshcd_link_startup - Initialize unipro link startup
  * @hba: per adapter instance
  *
- * Returns 0 for success, non-zero in case of failure
+ * Return: 0 for success, non-zero in case of failure.
  */
 static int ufshcd_link_startup(struct ufs_hba *hba)
 {
@@ -5061,7 +5063,7 @@ static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
  * ufshcd_slave_alloc - handle initial SCSI device configurations
  * @sdev: pointer to SCSI device
  *
- * Returns success
+ * Return: success.
  */
 static int ufshcd_slave_alloc(struct scsi_device *sdev)
 {
@@ -5179,7 +5181,7 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
  * @lrbp: pointer to local reference block of completed command
  * @scsi_status: SCSI command status
  *
- * Returns value base on SCSI command status
+ * Return: value base on SCSI command status.
  */
 static inline int
 ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
@@ -5213,7 +5215,7 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
  * @lrbp: pointer to local reference block of completed command
  * @cqe: pointer to the completion queue entry
  *
- * Returns result of the command to notify SCSI midlayer
+ * Return: result of the command to notify SCSI midlayer.
  */
 static inline int
 ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
@@ -5348,7 +5350,7 @@ static bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
  * @hba: per adapter instance
  * @intr_status: interrupt status generated by the controller
  *
- * Returns
+ * Return:
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
@@ -5468,7 +5470,7 @@ static void ufshcd_clear_polled(struct ufs_hba *hba,
 }
 
 /*
- * Returns > 0 if one or more commands have been completed or 0 if no
+ * Return: > 0 if one or more commands have been completed or 0 if no
  * requests have been completed.
  */
 static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
@@ -5558,7 +5560,7 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
  * ufshcd_transfer_req_compl - handle SCSI and query command completion
  * @hba: per adapter instance
  *
- * Returns
+ * Return:
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
@@ -5635,7 +5637,7 @@ int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask,
  * Disables exception event in the device so that the EVENT_ALERT
  * bit is not set.
  *
- * Returns zero on success, non-zero error value on failure.
+ * Return: zero on success, non-zero error value on failure.
  */
 static inline int ufshcd_disable_ee(struct ufs_hba *hba, u16 mask)
 {
@@ -5650,7 +5652,7 @@ static inline int ufshcd_disable_ee(struct ufs_hba *hba, u16 mask)
  * Enable corresponding exception event in the device to allow
  * device to alert host in critical scenarios.
  *
- * Returns zero on success, non-zero error value on failure.
+ * Return: zero on success, non-zero error value on failure.
  */
 static inline int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
 {
@@ -5666,7 +5668,7 @@ static inline int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
  * as the device is allowed to manage its own way of handling background
  * operations.
  *
- * Returns zero on success, non-zero on failure.
+ * Return: zero on success, non-zero on failure.
  */
 static int ufshcd_enable_auto_bkops(struct ufs_hba *hba)
 {
@@ -5705,7 +5707,7 @@ static int ufshcd_enable_auto_bkops(struct ufs_hba *hba)
  * host is idle so that BKOPS are managed effectively without any negative
  * impacts.
  *
- * Returns zero on success, non-zero on failure.
+ * Return: zero on success, non-zero on failure.
  */
 static int ufshcd_disable_auto_bkops(struct ufs_hba *hba)
 {
@@ -5781,7 +5783,7 @@ static inline int ufshcd_get_bkops_status(struct ufs_hba *hba, u32 *status)
  * bkops_status is greater than or equal to "status" argument passed to
  * this function, disable otherwise.
  *
- * Returns 0 for success, non-zero in case of failure.
+ * Return: 0 for success, non-zero in case of failure.
  *
  * NOTE: Caller of this function can check the "hba->auto_bkops_enabled" flag
  * to know whether auto bkops is enabled or disabled after this function
@@ -6133,7 +6135,7 @@ static void ufshcd_complete_requests(struct ufs_hba *hba, bool force_compl)
  *				to recover from the DL NAC errors or not.
  * @hba: per-adapter instance
  *
- * Returns true if error handling is required, false otherwise
+ * Return: true if error handling is required, false otherwise.
  */
 static bool ufshcd_quirk_dl_nac_errors(struct ufs_hba *hba)
 {
@@ -6594,7 +6596,7 @@ static void ufshcd_err_handler(struct work_struct *work)
  * ufshcd_update_uic_error - check and set fatal UIC error flags.
  * @hba: per-adapter instance
  *
- * Returns
+ * Return:
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
@@ -6687,7 +6689,7 @@ static irqreturn_t ufshcd_update_uic_error(struct ufs_hba *hba)
  * @hba: per-adapter instance
  * @intr_status: interrupt status generated by the controller
  *
- * Returns
+ * Return:
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
@@ -6763,7 +6765,7 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
  * ufshcd_tmc_handler - handle task management function completion
  * @hba: per adapter instance
  *
- * Returns
+ * Return:
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
@@ -6792,7 +6794,7 @@ static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
  * ufshcd_handle_mcq_cq_events - handle MCQ completion queue events
  * @hba: per adapter instance
  *
- * Returns IRQ_HANDLED if interrupt is handled
+ * Return: IRQ_HANDLED if interrupt is handled.
  */
 static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
 {
@@ -6827,7 +6829,7 @@ static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
  * @hba: per adapter instance
  * @intr_status: contains interrupts generated by the controller
  *
- * Returns
+ * Return:
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
@@ -6858,7 +6860,7 @@ static irqreturn_t ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
  * @irq: irq number
  * @__hba: pointer to adapter instance
  *
- * Returns
+ * Return:
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
@@ -7007,7 +7009,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
  * @tm_function: task management function opcode
  * @tm_response: task management service response return value
  *
- * Returns non-zero value on error, zero on success.
+ * Return: non-zero value on error, zero on success.
  */
 static int ufshcd_issue_tm_cmd(struct ufs_hba *hba, int lun_id, int task_id,
 		u8 tm_function, u8 *tm_response)
@@ -7231,7 +7233,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
  * @sg_list:	Pointer to SG list when DATA IN/OUT UPIU is required in ARPMB operation
  * @dir:	DMA direction
  *
- * Returns zero on success, non-zero on failure
+ * Return: zero on success, non-zero on failure.
  */
 int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *req_upiu,
 			 struct utp_upiu_req *rsp_upiu, struct ufs_ehs *req_ehs,
@@ -7317,7 +7319,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
  * ufshcd_eh_device_reset_handler() - Reset a single logical unit.
  * @cmd: SCSI command pointer
  *
- * Returns SUCCESS/FAILED
+ * Return: SUCCESS or FAILED.
  */
 static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 {
@@ -7412,7 +7414,7 @@ static void ufshcd_set_req_abort_skip(struct ufs_hba *hba, unsigned long bitmap)
  * issued. To avoid that, first issue UFS_QUERY_TASK to check if the command is
  * really issued and then try to abort it.
  *
- * Returns zero on success, non-zero on failure
+ * Return: zero on success, non-zero on failure.
  */
 int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 {
@@ -7500,7 +7502,7 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
  * ufshcd_abort - scsi host template eh_abort_handler callback
  * @cmd: SCSI command pointer
  *
- * Returns SUCCESS/FAILED
+ * Return: SUCCESS or FAILED.
  */
 static int ufshcd_abort(struct scsi_cmnd *cmd)
 {
@@ -7625,7 +7627,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
  * local and remote (device) Uni-Pro stack and the attributes
  * are reset to default state.
  *
- * Returns zero on success, non-zero on failure
+ * Return: zero on success, non-zero on failure.
  */
 static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 {
@@ -7662,7 +7664,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
  * Reset and recover device, host and re-establish link. This
  * is helpful to recover the communication in fatal error conditions.
  *
- * Returns zero on success, non-zero on failure
+ * Return: zero on success, non-zero on failure.
  */
 static int ufshcd_reset_and_restore(struct ufs_hba *hba)
 {
@@ -7720,7 +7722,7 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba)
  * ufshcd_eh_host_reset_handler - host reset handler registered to scsi layer
  * @cmd: SCSI command pointer
  *
- * Returns SUCCESS/FAILED
+ * Return: SUCCESS or FAILED.
  */
 static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd)
 {
@@ -7752,7 +7754,7 @@ static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd)
  * @start_scan: row at the desc table to start scan from
  * @buff: power descriptor buffer
  *
- * Returns calculated max ICC level for specific regulator
+ * Return: calculated max ICC level for specific regulator.
  */
 static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
 				    const char *buff)
@@ -7798,7 +7800,7 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan,
  * @hba: per-adapter instance
  * @desc_buf: power descriptor buffer to extract ICC levels from.
  *
- * Returns calculated ICC level
+ * Return: calculated ICC level.
  */
 static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
 						const u8 *desc_buf)
@@ -7907,7 +7909,7 @@ static inline void ufshcd_blk_pm_runtime_init(struct scsi_device *sdev)
  * This function adds scsi device instances for each of all well known LUs
  * (except "REPORT LUNS" LU).
  *
- * Returns zero on success (all required W-LUs are added successfully),
+ * Return: zero on success (all required W-LUs are added successfully),
  * non-zero error value on failure (if failed to add any of the required W-LU).
  */
 static int ufshcd_scsi_add_wlus(struct ufs_hba *hba)
@@ -8176,7 +8178,7 @@ static void ufs_put_device_desc(struct ufs_hba *hba)
  * RX_MIN_ACTIVATETIME_CAPABILITY attribute. This optimal value can help reduce
  * the hibern8 exit latency.
  *
- * Returns zero on success, non-zero error value on failure.
+ * Return: zero on success, non-zero error value on failure.
  */
 static int ufshcd_tune_pa_tactivate(struct ufs_hba *hba)
 {
@@ -8211,7 +8213,7 @@ static int ufshcd_tune_pa_tactivate(struct ufs_hba *hba)
  * TX_HIBERN8TIME_CAPABILITY & peer M-PHY's RX_HIBERN8TIME_CAPABILITY.
  * This optimal value can help reduce the hibern8 exit latency.
  *
- * Returns zero on success, non-zero error value on failure.
+ * Return: zero on success, non-zero error value on failure.
  */
 static int ufshcd_tune_pa_hibern8time(struct ufs_hba *hba)
 {
@@ -8253,7 +8255,7 @@ static int ufshcd_tune_pa_hibern8time(struct ufs_hba *hba)
  * PA_TACTIVATE, we need to enable UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE quirk
  * for such devices.
  *
- * Returns zero on success, non-zero error value on failure.
+ * Return: zero on success, non-zero error value on failure.
  */
 static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 {
@@ -9255,8 +9257,8 @@ static int ufshcd_execute_start_stop(struct scsi_device *sdev,
  * @hba: per adapter instance
  * @pwr_mode: device power mode to set
  *
- * Returns 0 if requested power mode is set successfully
- * Returns < 0 if failed to set the requested power mode
+ * Return: 0 if requested power mode is set successfully;
+ *         < 0 if failed to set the requested power mode.
  */
 static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 				     enum ufs_dev_pwr_mode pwr_mode)
@@ -9876,7 +9878,7 @@ static int ufshcd_suspend(struct ufs_hba *hba)
  * This function basically turns on the regulators, clocks and
  * irqs of the hba.
  *
- * Returns 0 for success and non-zero for failure
+ * Return: 0 for success and non-zero for failure.
  */
 static int ufshcd_resume(struct ufs_hba *hba)
 {
@@ -9917,7 +9919,7 @@ static int ufshcd_resume(struct ufs_hba *hba)
  * Executed before putting the system into a sleep state in which the contents
  * of main memory are preserved.
  *
- * Returns 0 for success and non-zero for failure
+ * Return: 0 for success and non-zero for failure.
  */
 int ufshcd_system_suspend(struct device *dev)
 {
@@ -9944,7 +9946,7 @@ EXPORT_SYMBOL(ufshcd_system_suspend);
  * Executed after waking the system up from a sleep state in which the contents
  * of main memory were preserved.
  *
- * Returns 0 for success and non-zero for failure
+ * Return: 0 for success and non-zero for failure.
  */
 int ufshcd_system_resume(struct device *dev)
 {
@@ -9974,7 +9976,7 @@ EXPORT_SYMBOL(ufshcd_system_resume);
  *
  * Check the description of ufshcd_suspend() function for more details.
  *
- * Returns 0 for success and non-zero for failure
+ * Return: 0 for success and non-zero for failure.
  */
 int ufshcd_runtime_suspend(struct device *dev)
 {
@@ -10134,7 +10136,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
  *			 addressing capability
  * @hba: per adapter instance
  *
- * Returns 0 for success, non-zero for failure
+ * Return: 0 for success, non-zero for failure.
  */
 static int ufshcd_set_dma_mask(struct ufs_hba *hba)
 {
@@ -10149,7 +10151,8 @@ static int ufshcd_set_dma_mask(struct ufs_hba *hba)
  * ufshcd_alloc_host - allocate Host Bus Adapter (HBA)
  * @dev: pointer to device handle
  * @hba_handle: driver private handle
- * Returns 0 on success, non-zero value on failure
+ *
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 {
@@ -10205,7 +10208,8 @@ static const struct blk_mq_ops ufshcd_tmf_ops = {
  * @hba: per-adapter instance
  * @mmio_base: base register address
  * @irq: Interrupt line of device
- * Returns 0 on success, non-zero value on failure
+ *
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 {
diff --git a/drivers/ufs/host/cdns-pltfrm.c b/drivers/ufs/host/cdns-pltfrm.c
index 26761425a76c..5b1e1e26d133 100644
--- a/drivers/ufs/host/cdns-pltfrm.c
+++ b/drivers/ufs/host/cdns-pltfrm.c
@@ -105,7 +105,7 @@ static void cdns_ufs_set_l4_attr(struct ufs_hba *hba)
  * Sets HCLKDIV register value based on the core_clk
  * @hba: host controller instance
  *
- * Return zero for success and non-zero for failure
+ * Return: zero for success and non-zero for failure.
  */
 static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
 {
@@ -148,7 +148,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
  * @hba: host controller instance
  * @status: notify stage (pre, post change)
  *
- * Return zero for success and non-zero for failure
+ * Return: zero for success and non-zero for failure.
  */
 static int cdns_ufs_hce_enable_notify(struct ufs_hba *hba,
 				      enum ufs_notify_change_status status)
@@ -182,7 +182,7 @@ static void cdns_ufs_hibern8_notify(struct ufs_hba *hba, enum uic_cmd_dme cmd,
  * @hba: host controller instance
  * @status: notify stage (pre, post change)
  *
- * Return zero for success and non-zero for failure
+ * Return: zero for success and non-zero for failure.
  */
 static int cdns_ufs_link_startup_notify(struct ufs_hba *hba,
 					enum ufs_notify_change_status status)
@@ -212,7 +212,7 @@ static int cdns_ufs_link_startup_notify(struct ufs_hba *hba,
  * cdns_ufs_init - performs additional ufs initialization
  * @hba: host controller instance
  *
- * Returns status of initialization
+ * Return: status of initialization.
  */
 static int cdns_ufs_init(struct ufs_hba *hba)
 {
@@ -284,7 +284,7 @@ MODULE_DEVICE_TABLE(of, cdns_ufs_of_match);
  * cdns_ufs_pltfrm_probe - probe routine of the driver
  * @pdev: pointer to platform device handle
  *
- * Return zero for success and non-zero for failure
+ * Return: zero for success and non-zero for failure.
  */
 static int cdns_ufs_pltfrm_probe(struct platform_device *pdev)
 {
diff --git a/drivers/ufs/host/tc-dwc-g210-pci.c b/drivers/ufs/host/tc-dwc-g210-pci.c
index f96fe5855841..876781fd6861 100644
--- a/drivers/ufs/host/tc-dwc-g210-pci.c
+++ b/drivers/ufs/host/tc-dwc-g210-pci.c
@@ -51,7 +51,7 @@ static void tc_dwc_g210_pci_remove(struct pci_dev *pdev)
  * @pdev: pointer to PCI device handle
  * @id: PCI device id
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 static int
 tc_dwc_g210_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/ufs/host/tc-dwc-g210.c b/drivers/ufs/host/tc-dwc-g210.c
index deb93dbd83a4..84a8b915b745 100644
--- a/drivers/ufs/host/tc-dwc-g210.c
+++ b/drivers/ufs/host/tc-dwc-g210.c
@@ -21,7 +21,7 @@
  * This function configures Synopsys TC specific atributes (40-bit RMMI)
  * @hba: Pointer to drivers structure
  *
- * Returns 0 on success or non-zero value on failure
+ * Return: 0 on success or non-zero value on failure.
  */
 static int tc_dwc_g210_setup_40bit_rmmi(struct ufs_hba *hba)
 {
@@ -85,7 +85,7 @@ static int tc_dwc_g210_setup_40bit_rmmi(struct ufs_hba *hba)
  * This function configures Synopsys TC 20-bit RMMI Lane 0
  * @hba: Pointer to drivers structure
  *
- * Returns 0 on success or non-zero value on failure
+ * Return: 0 on success or non-zero value on failure.
  */
 static int tc_dwc_g210_setup_20bit_rmmi_lane0(struct ufs_hba *hba)
 {
@@ -138,7 +138,7 @@ static int tc_dwc_g210_setup_20bit_rmmi_lane0(struct ufs_hba *hba)
  * This function configures Synopsys TC 20-bit RMMI Lane 1
  * @hba: Pointer to drivers structure
  *
- * Returns 0 on success or non-zero value on failure
+ * Return: 0 on success or non-zero value on failure.
  */
 static int tc_dwc_g210_setup_20bit_rmmi_lane1(struct ufs_hba *hba)
 {
@@ -215,7 +215,7 @@ static int tc_dwc_g210_setup_20bit_rmmi_lane1(struct ufs_hba *hba)
  * This function configures Synopsys TC specific atributes (20-bit RMMI)
  * @hba: Pointer to drivers structure
  *
- * Returns 0 on success or non-zero value on failure
+ * Return: 0 on success or non-zero value on failure.
  */
 static int tc_dwc_g210_setup_20bit_rmmi(struct ufs_hba *hba)
 {
@@ -256,7 +256,7 @@ static int tc_dwc_g210_setup_20bit_rmmi(struct ufs_hba *hba)
  *
  * @hba: Pointer to drivers structure
  *
- * Returns 0 on success non-zero value on failure
+ * Return: 0 on success non-zero value on failure.
  */
 int tc_dwc_g210_config_40_bit(struct ufs_hba *hba)
 {
@@ -288,7 +288,7 @@ EXPORT_SYMBOL(tc_dwc_g210_config_40_bit);
  *
  * @hba: Pointer to drivers structure
  *
- * Returns 0 on success non-zero value on failure
+ * Return: 0 on success non-zero value on failure.
  */
 int tc_dwc_g210_config_20_bit(struct ufs_hba *hba)
 {
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 10a28079c8bb..2383ecd88f1c 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -666,7 +666,7 @@ static void ufs_mtk_pwr_ctrl(struct ufs_hba *hba, bool on)
  * @on: If true, enable clocks else disable them.
  * @status: PRE_CHANGE or POST_CHANGE notify
  *
- * Returns 0 on success, non-zero on failure.
+ * Return: 0 on success, non-zero on failure.
  */
 static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
 				enum ufs_notify_change_status status)
@@ -885,7 +885,7 @@ static void ufs_mtk_init_mcq_irq(struct ufs_hba *hba)
  * Binds PHY with controller and powers up PHY enabling clocks
  * and regulators.
  *
- * Returns -EPROBE_DEFER if binding fails, returns negative error
+ * Return: -EPROBE_DEFER if binding fails, returns negative error
  * on phy power up failure and returns zero on success.
  */
 static int ufs_mtk_init(struct ufs_hba *hba)
@@ -1696,7 +1696,7 @@ static const struct ufs_hba_variant_ops ufs_hba_mtk_vops = {
  * ufs_mtk_probe - probe routine of the driver
  * @pdev: pointer to Platform device handle
  *
- * Return zero for success and non-zero for failure
+ * Return: zero for success and non-zero for failure.
  */
 static int ufs_mtk_probe(struct platform_device *pdev)
 {
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 3ee5ff905f9a..ecd2272f1ec8 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -485,7 +485,7 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 }
 
 /*
- * Returns zero for success and non-zero in case of a failure
+ * Return: zero for success and non-zero in case of a failure.
  */
 static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 			       u32 hs, u32 rate, bool update_link_startup_timer)
@@ -964,7 +964,7 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
  * @on: If true, enable clocks else disable them.
  * @status: PRE_CHANGE or POST_CHANGE notify
  *
- * Returns 0 on success, non-zero on failure.
+ * Return: 0 on success, non-zero on failure.
  */
 static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				 enum ufs_notify_change_status status)
@@ -1038,7 +1038,7 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
  * Binds PHY with controller and powers up PHY enabling clocks
  * and regulators.
  *
- * Returns -EPROBE_DEFER if binding fails, returns negative error
+ * Return: -EPROBE_DEFER if binding fails, returns negative error
  * on phy power up failure and returns zero on success.
  */
 static int ufs_qcom_init(struct ufs_hba *hba)
@@ -1757,7 +1757,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
  * ufs_qcom_probe - probe routine of the driver
  * @pdev: pointer to Platform device handle
  *
- * Return zero for success and non-zero for failure
+ * Return: zero for success and non-zero for failure.
  */
 static int ufs_qcom_probe(struct platform_device *pdev)
 {
diff --git a/drivers/ufs/host/ufshcd-dwc.c b/drivers/ufs/host/ufshcd-dwc.c
index e28a67e1e314..b547df05a2b9 100644
--- a/drivers/ufs/host/ufshcd-dwc.c
+++ b/drivers/ufs/host/ufshcd-dwc.c
@@ -51,7 +51,7 @@ static void ufshcd_dwc_program_clk_div(struct ufs_hba *hba, u32 divider_val)
  * Check if link is up
  * @hba: private structure pointer
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 static int ufshcd_dwc_link_is_up(struct ufs_hba *hba)
 {
@@ -78,7 +78,7 @@ static int ufshcd_dwc_link_is_up(struct ufs_hba *hba)
  *
  * @hba: pointer to drivers private data
  *
- * Returns 0 on success non-zero value on failure
+ * Return: 0 on success non-zero value on failure.
  */
 static int ufshcd_dwc_connection_setup(struct ufs_hba *hba)
 {
@@ -112,7 +112,7 @@ static int ufshcd_dwc_connection_setup(struct ufs_hba *hba)
  * @hba: private structure pointer
  * @status: Callback notify status
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_dwc_link_startup_notify(struct ufs_hba *hba,
 					enum ufs_notify_change_status status)
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index cf3987773051..95df8105265a 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -524,7 +524,7 @@ static void ufshcd_pci_remove(struct pci_dev *pdev)
  * @pdev: pointer to PCI device handle
  * @id: PCI device id
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 static int
 ufshcd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 0b7430033047..34131d36d09f 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -212,7 +212,7 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
  * @dev_max: pointer to device attributes
  * @agreed_pwr: returned agreed attributes
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *pltfrm_param,
 			     const struct ufs_pa_layer_attr *dev_max,
@@ -326,7 +326,7 @@ EXPORT_SYMBOL_GPL(ufshcd_init_pwr_dev_param);
  * @pdev: pointer to Platform device handle
  * @vops: pointer to variant ops
  *
- * Returns 0 on success, non-zero value on failure
+ * Return: 0 on success, non-zero value on failure.
  */
 int ufshcd_pltfrm_init(struct platform_device *pdev,
 		       const struct ufs_hba_variant_ops *vops)
