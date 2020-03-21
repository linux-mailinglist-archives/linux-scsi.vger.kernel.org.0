Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF718DCE5
	for <lists+linux-scsi@lfdr.de>; Sat, 21 Mar 2020 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgCUAw6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Mar 2020 20:52:58 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:59970 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgCUAw6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 20 Mar 2020 20:52:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584751976; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: To: From:
 Subject: Sender; bh=FDaASleeoGRT3mP5Kp3nbrrSPOwjgP3mpMf0hM+hMqk=; b=EDgKYb0P6cZ4+g2qS9N8bMKUTMnkoxbfRKER6ol/LtxlcVagGd1hYlmjRO7+llJVam+ejXWo
 SFz5AVWEuh3x/Pl3AWsd9Sn7EQ6HaQjA3N9+9c1ButExB0xsthsx77jWg3HeasyDcZzi7qo4
 xkoP9+2nXqjlC30624FEf3FQsf8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e756567.7f14b5649c38-smtp-out-n04;
 Sat, 21 Mar 2020 00:52:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 226A0C433BA; Sat, 21 Mar 2020 00:52:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.8.111] (cpe-70-95-153-89.san.res.rr.com [70.95.153.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EF4DC433D2;
        Sat, 21 Mar 2020 00:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EF4DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [<RFC PATCH v2> 1/3] scsi: ufs: add write booster feature support
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
To:     asutoshd@qti.qualcomm.com, linux-scsi@vger.kernel.org
References: <cover.1584750888.git.asutoshd@codeaurora.org>
 <416193874f3cef152ae4845bc2edd43b58c84a3e.1584750888.git.asutoshd@codeaurora.org>
Message-ID: <76343c02-b5cd-7688-39fe-da7197c71a1a@codeaurora.org>
Date:   Fri, 20 Mar 2020 17:52:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <416193874f3cef152ae4845bc2edd43b58c84a3e.1584750888.git.asutoshd@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 3/20/2020 5:48 PM, Asutosh Das wrote:
> The write performance of TLC NAND is considerably
> lower than SLC NAND. Using SLC NAND as a WriteBooster
> Buffer enables the write request to be processed with
> lower latency and improves the overall write performance.
> 
> Adds support for shared-buffer mode WriteBooster.
> 
> WriteBooster enable: SW enables it when clocks are
> scaled up, thus it's enabled only in high load conditions.
> 
> WriteBooster disable: SW will disable the feature,
> when clocks are scaled down. Thus writes would go as normal
> writes.
> 
> To keep the endurance of the WriteBooster Buffer at a
> maximum, this load based toggling is adopted.
> 
> Change-Id: I89c488a7641697173a296c1ebadc1f4720090cfd
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
>   drivers/scsi/ufs/ufs.h    |  31 +++++-
>   drivers/scsi/ufs/ufshcd.c | 238 +++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/scsi/ufs/ufshcd.h |   9 ++
>   3 files changed, 273 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index 990cb48..2c77b3e 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -140,6 +140,9 @@ enum flag_idn {
>   	QUERY_FLAG_IDN_BUSY_RTC				= 0x09,
>   	QUERY_FLAG_IDN_RESERVED3			= 0x0A,
>   	QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE	= 0x0B,
> +	QUERY_FLAG_IDN_WB_EN                            = 0x0E,
> +	QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN                 = 0x0F,
> +	QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8     = 0x10,
>   };
>   
>   /* Attribute idn for Query requests */
> @@ -168,6 +171,10 @@ enum attr_idn {
>   	QUERY_ATTR_IDN_PSA_STATE		= 0x15,
>   	QUERY_ATTR_IDN_PSA_DATA_SIZE		= 0x16,
>   	QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME	= 0x17,
> +	QUERY_ATTR_IDN_WB_FLUSH_STATUS	        = 0x1C,
> +	QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE       = 0x1D,
> +	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
> +	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
>   };
>   
>   /* Descriptor idn for Query requests */
> @@ -191,7 +198,7 @@ enum desc_header_offset {
>   };
>   
>   enum ufs_desc_def_size {
> -	QUERY_DESC_DEVICE_DEF_SIZE		= 0x40,
> +	QUERY_DESC_DEVICE_DEF_SIZE		= 0x59,
>   	QUERY_DESC_CONFIGURATION_DEF_SIZE	= 0x90,
>   	QUERY_DESC_UNIT_DEF_SIZE		= 0x23,
>   	QUERY_DESC_INTERCONNECT_DEF_SIZE	= 0x06,
> @@ -219,6 +226,7 @@ enum unit_desc_param {
>   	UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT	= 0x18,
>   	UNIT_DESC_PARAM_CTX_CAPABILITIES	= 0x20,
>   	UNIT_DESC_PARAM_LARGE_UNIT_SIZE_M1	= 0x22,
> +	UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS	= 0x29,
>   };
>   
>   /* Device descriptor parameters offsets in bytes*/
> @@ -258,6 +266,9 @@ enum device_desc_param {
>   	DEVICE_DESC_PARAM_PSA_MAX_DATA		= 0x25,
>   	DEVICE_DESC_PARAM_PSA_TMT		= 0x29,
>   	DEVICE_DESC_PARAM_PRDCT_REV		= 0x2A,
> +	DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP	= 0x4F,
> +	DEVICE_DESC_PARAM_WB_TYPE		= 0x54,
> +	DEVICE_DESC_PARAM_WB_SHARED_ALLOC_UNITS = 0x55,
>   };
>   
>   /* Interconnect descriptor parameters offsets in bytes*/
> @@ -333,6 +344,11 @@ enum {
>   	UFSHCD_AMP		= 3,
>   };
>   
> +/* Possible values for dExtendedUFSFeaturesSupport */
> +enum {
> +	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
> +};
> +
>   #define POWER_DESC_MAX_SIZE			0x62
>   #define POWER_DESC_MAX_ACTV_ICC_LVLS		16
>   
> @@ -447,6 +463,15 @@ enum ufs_dev_pwr_mode {
>   	UFS_POWERDOWN_PWR_MODE	= 3,
>   };
>   
> +enum ufs_dev_wb_buf_avail_size {
> +	UFS_WB_10_PERCENT_BUF_REMAIN = 0x1,
> +	UFS_WB_40_PERCENT_BUF_REMAIN = 0x4,
> +};
> +
> +enum ufs_dev_wb_buf_user_cap_config {
> +	UFS_WB_BUFF_PRESERVE_USER_SPACE = 1,
> +	UFS_WB_BUFF_USER_SPACE_RED_EN = 2,
> +};
>   /**
>    * struct utp_cmd_rsp - Response UPIU structure
>    * @residual_transfer_count: Residual transfer count DW-3
> @@ -537,6 +562,10 @@ struct ufs_dev_info {
>   	u8 *model;
>   	u16 wspecversion;
>   	u32 clk_gating_wait_us;
> +	u32 d_ext_ufs_feature_sup;
> +	u8 b_wb_buffer_type;
> +	u32 d_wb_alloc_units;
> +	bool keep_vcc_on;
>   };
>   
>   /**
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 2a2a63b..a78dcb6 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -47,6 +47,8 @@
>   #include "unipro.h"
>   #include "ufs-sysfs.h"
>   #include "ufs_bsg.h"
> +#include <linux/blkdev.h>
> +#include <asm/unaligned.h>
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/ufs.h>
> @@ -263,6 +265,13 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up);
>   static irqreturn_t ufshcd_intr(int irq, void *__hba);
>   static int ufshcd_change_power_mode(struct ufs_hba *hba,
>   			     struct ufs_pa_layer_attr *pwr_mode);
> +static bool ufshcd_wb_sup(struct ufs_hba *hba);
> +static int ufshcd_wb_buf_flush_enable(struct ufs_hba *hba);
> +static int ufshcd_wb_buf_flush_disable(struct ufs_hba *hba);
> +static int ufshcd_wb_ctrl(struct ufs_hba *hba, bool enable);
> +static int ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
> +static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
> +
>   static inline bool ufshcd_valid_tag(struct ufs_hba *hba, int tag)
>   {
>   	return tag >= 0 && tag < hba->nutrs;
> @@ -284,6 +293,25 @@ static inline void ufshcd_disable_irq(struct ufs_hba *hba)
>   	}
>   }
>   
> +static inline void ufshcd_wb_config(struct ufs_hba *hba)
> +{
> +	int ret;
> +
> +	if (!ufshcd_wb_sup(hba))
> +		return;
> +
> +	ret = ufshcd_wb_ctrl(hba, true);
> +	if (ret)
> +		dev_err(hba->dev, "%s: Enable WB failed: %d\n", __func__, ret);
> +	else
> +		dev_info(hba->dev, "%s: Write Booster Configured\n", __func__);
> +	ret = ufshcd_wb_toggle_flush_during_h8(hba, true);
> +	if (ret)
> +		dev_err(hba->dev, "%s: En WB flush during H8: failed: %d\n",
> +			__func__, ret);
> +	ufshcd_wb_toggle_flush(hba, true);
> +}
> +
>   static void ufshcd_scsi_unblock_requests(struct ufs_hba *hba)
>   {
>   	if (atomic_dec_and_test(&hba->scsi_block_reqs_cnt))
> @@ -1132,6 +1160,10 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
>   	}
>   
>   	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
> +	/* Enable Write Booster if we have scaled up else disable it */
> +	up_write(&hba->clk_scaling_lock);
> +	ufshcd_wb_ctrl(hba, scale_up);
> +	down_write(&hba->clk_scaling_lock);
>   
>   out:
>   	ufshcd_clock_scaling_unprepare(hba);
> @@ -5105,6 +5137,167 @@ static void ufshcd_bkops_exception_event_handler(struct ufs_hba *hba)
>   				__func__, err);
>   }
>   
> +static bool ufshcd_wb_sup(struct ufs_hba *hba)
> +{
> +	return ((hba->dev_info.d_ext_ufs_feature_sup &
> +		 UFS_DEV_WRITE_BOOSTER_SUP) &&
> +		hba->dev_info.b_wb_buffer_type &&
> +		hba->dev_info.d_wb_alloc_units);
> +}
> +
> +static int ufshcd_wb_ctrl(struct ufs_hba *hba, bool enable)
> +{
> +	int ret;
> +	enum query_opcode opcode;
> +
> +	if (!ufshcd_wb_sup(hba))
> +		return 0;
> +
> +	if (!(enable ^ hba->wb_enabled))
> +		return 0;
> +	if (enable)
> +		opcode = UPIU_QUERY_OPCODE_SET_FLAG;
> +	else
> +		opcode = UPIU_QUERY_OPCODE_CLEAR_FLAG;
> +
> +	ret = ufshcd_query_flag_retry(hba, opcode,
> +				      QUERY_FLAG_IDN_WB_EN, NULL);
> +	if (ret) {
> +		dev_err(hba->dev, "%s write booster %s failed %d\n",
> +			__func__, enable ? "enable" : "disable", ret);
> +		return ret;
> +	}
> +
> +	hba->wb_enabled = enable;
> +	dev_dbg(hba->dev, "%s write booster %s %d\n",
> +			__func__, enable ? "enable" : "disable", ret);
> +
> +	return ret;
> +}
> +
> +static int ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set)
> +{
> +	int val;
> +
> +	if (set)
> +		val =  UPIU_QUERY_OPCODE_SET_FLAG;
> +	else
> +		val = UPIU_QUERY_OPCODE_CLEAR_FLAG;
> +
> +	return ufshcd_query_flag_retry(hba, val,
> +			       QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8,
> +				       NULL);
> +}
> +
> +static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
> +{
> +	if (enable)
> +		ufshcd_wb_buf_flush_enable(hba);
> +	else
> +		ufshcd_wb_buf_flush_disable(hba);
> +
> +}
> +
> +static int ufshcd_wb_buf_flush_enable(struct ufs_hba *hba)
> +{
> +	int ret;
> +
> +	if (!ufshcd_wb_sup(hba) || hba->wb_buf_flush_enabled)
> +		return 0;
> +
> +	ret = ufshcd_query_flag_retry(hba, UPIU_QUERY_OPCODE_SET_FLAG,
> +				      QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN, NULL);
> +	if (ret)
> +		dev_err(hba->dev, "%s WB - buf flush enable failed %d\n",
> +			__func__, ret);
> +	else
> +		hba->wb_buf_flush_enabled = true;
> +
> +	dev_dbg(hba->dev, "WB - Flush enabled: %d\n", ret);
> +	return ret;
> +}
> +
> +static int ufshcd_wb_buf_flush_disable(struct ufs_hba *hba)
> +{
> +	int ret;
> +
> +	if (!ufshcd_wb_sup(hba) || !hba->wb_buf_flush_enabled)
> +		return 0;
> +
> +	ret = ufshcd_query_flag_retry(hba, UPIU_QUERY_OPCODE_CLEAR_FLAG,
> +				      QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN, NULL);
> +	if (ret) {
> +		dev_warn(hba->dev, "%s: WB - buf flush disable failed %d\n",
> +			 __func__, ret);
> +	} else {
> +		hba->wb_buf_flush_enabled = false;
> +		dev_dbg(hba->dev, "WB - Flush disabled: %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static bool ufshcd_wb_keep_vcc_on(struct ufs_hba *hba)
> +{
> +	int ret;
> +	u32 cur_buf, avail_buf;
> +
> +	if (!ufshcd_wb_sup(hba))
> +		return false;
> +	/*
> +	 * The ufs device needs the vcc to be ON to flush.
> +	 * With user-space reduction enabled, it's enough to enable flush
> +	 * by checking only the available buffer. The threshold
> +	 * defined here is > 90% full.
> +	 * With user-space preserved enabled, the current-buffer
> +	 * should be checked too because the wb buffer size can reduce
> +	 * when disk tends to be full. This info is provided by current
> +	 * buffer (dCurrentWriteBoosterBufferSize). There's no point in
> +	 * keeping vcc on when current buffer is empty.
> +	 */
> +	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +				      QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE,
> +				      0, 0, &avail_buf);
> +	if (ret) {
> +		dev_warn(hba->dev, "%s dAvailableWriteBoosterBufferSize read failed %d\n",
> +			 __func__, ret);
> +		return false;
> +	}
> +
> +	ret = ufshcd_vops_get_user_cap_mode(hba);
> +	if (ret <= 0) {
> +		dev_dbg(hba->dev, "Get user-cap reduction mode: failed: %d\n",
> +			ret);
> +		/* Most commonly used */
> +		ret = UFS_WB_BUFF_PRESERVE_USER_SPACE;
> +	}
> +
> +	if (ret == UFS_WB_BUFF_USER_SPACE_RED_EN) {
> +		if (avail_buf <= UFS_WB_10_PERCENT_BUF_REMAIN)
> +			return true;
> +		return false;
> +	} else if (ret == UFS_WB_BUFF_PRESERVE_USER_SPACE) {
> +		ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +					      QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE,
> +					      0, 0, &cur_buf);
> +		if (ret) {
> +			dev_err(hba->dev, "%s dCurWriteBoosterBufferSize read failed %d\n",
> +				 __func__, ret);
> +			return false;
> +		}
> +
> +		if (!cur_buf) {
> +			dev_info(hba->dev, "dCurWBBuf: %d WB disabled until free-space is available\n",
> +				 cur_buf);
> +			return false;
> +		}
> +		/* Let it continue to flush when >60% full */
> +		if (avail_buf < UFS_WB_40_PERCENT_BUF_REMAIN)
> +			return true;
> +	}
> +	return false;
> +}
> +
>   /**
>    * ufshcd_exception_event_handler - handle exceptions raised by device
>    * @work: pointer to work data
> @@ -6571,6 +6764,28 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>   				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
>   
>   	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
> +	/* Enable WB only for UFS-3.1 */
> +	if (dev_info->wspecversion >= 0x310) {
> +		hba->dev_info.d_ext_ufs_feature_sup =
> +			get_unaligned_be32(desc_buf +
> +				DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> +		/*
> +		 * WB may be supported but not configured while provisioning.
> +		 * The spec says, in dedicated wb buffer mode,
> +		 * a max of 1 lun would have wb buffer configured.
> +		 * Now only shared buffer mode is supported.
> +		 */
> +		hba->dev_info.b_wb_buffer_type =
> +			desc_buf[DEVICE_DESC_PARAM_WB_TYPE];
> +
> +		if (!hba->dev_info.b_wb_buffer_type)
> +			goto skip_alloc_unit;
> +		hba->dev_info.d_wb_alloc_units =
> +			get_unaligned_be32(desc_buf +
> +				DEVICE_DESC_PARAM_WB_SHARED_ALLOC_UNITS);
> +	}
> +
> +skip_alloc_unit:
>   	err = ufshcd_read_string_desc(hba, model_index,
>   				      &dev_info->model, SD_ASCII_STD);
>   	if (err < 0) {
> @@ -7074,6 +7289,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool async)
>   	/* set the state as operational after switching to desired gear */
>   	hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
>   
> +	ufshcd_wb_config(hba);
>   	/* Enable Auto-Hibernate if configured */
>   	ufshcd_auto_hibern8_enable(hba);
>   
> @@ -7734,12 +7950,16 @@ static void ufshcd_vreg_set_lpm(struct ufs_hba *hba)
>   	 *
>   	 * Ignore the error returned by ufshcd_toggle_vreg() as device is anyway
>   	 * in low power state which would save some power.
> +	 *
> +	 * If Write Booster is enabled and the device needs to flush the WB
> +	 * buffer OR if bkops status is urgent for WB, keep Vcc on.
>   	 */
>   	if (ufshcd_is_ufs_dev_poweroff(hba) && ufshcd_is_link_off(hba) &&
>   	    !hba->dev_info.is_lu_power_on_wp) {
>   		ufshcd_setup_vreg(hba, false);
>   	} else if (!ufshcd_is_ufs_dev_active(hba)) {
> -		ufshcd_toggle_vreg(hba->dev, hba->vreg_info.vcc, false);
> +		if (!hba->dev_info.keep_vcc_on)
> +			ufshcd_toggle_vreg(hba->dev, hba->vreg_info.vcc, false);
>   		if (!ufshcd_is_link_active(hba)) {
>   			ufshcd_config_vreg_lpm(hba, hba->vreg_info.vccq);
>   			ufshcd_config_vreg_lpm(hba, hba->vreg_info.vccq2);
> @@ -7863,12 +8083,22 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>   			/* make sure that auto bkops is disabled */
>   			ufshcd_disable_auto_bkops(hba);
>   		}
> +		/*
> +		 * With wb enabled, if the bkops is enabled or if the
> +		 * configured WB type is 70% full, keep vcc ON
> +		 * for the device to flush the wb buffer
> +		 */
> +		if ((hba->auto_bkops_enabled && ufshcd_wb_sup(hba)) ||
> +		    ufshcd_wb_keep_vcc_on(hba))
> +			hba->dev_info.keep_vcc_on = true;
> +	} else if (!ufshcd_is_runtime_pm(pm_op)) {
> +		hba->dev_info.keep_vcc_on = false;
>   	}
>   
>   	if ((req_dev_pwr_mode != hba->curr_dev_pwr_mode) &&
> -	     ((ufshcd_is_runtime_pm(pm_op) && !hba->auto_bkops_enabled) ||
> -	       !ufshcd_is_runtime_pm(pm_op))) {
> -		/* ensure that bkops is disabled */
> +	    ((ufshcd_is_runtime_pm(pm_op) && !hba->auto_bkops_enabled) ||
> +	     !ufshcd_is_runtime_pm(pm_op))) {
> +		/* ensure that bkops & wb-flush is disabled */
>   		ufshcd_disable_auto_bkops(hba);
>   		ret = ufshcd_set_dev_pwr_mode(hba, req_dev_pwr_mode);
>   		if (ret)
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index d45a044..c343781 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -327,6 +327,7 @@ struct ufs_hba_variant_ops {
>   	void	(*dbg_register_dump)(struct ufs_hba *hba);
>   	int	(*phy_initialization)(struct ufs_hba *);
>   	void	(*device_reset)(struct ufs_hba *hba);
> +	u32	(*wb_get_user_cap_mode)(struct ufs_hba *hba);
>   };
>   
>   /* clock gating state  */
> @@ -711,6 +712,8 @@ struct ufs_hba {
>   
>   	struct device		bsg_dev;
>   	struct request_queue	*bsg_queue;
> +	bool wb_buf_flush_enabled;
> +	bool wb_enabled;
>   };
>   
>   /* Returns true if clocks can be gated. Otherwise false */
> @@ -1103,4 +1106,10 @@ static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
>   int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
>   		     const char *prefix);
>   
> +static inline unsigned int ufshcd_vops_get_user_cap_mode(struct ufs_hba *hba)
> +{
> +	if (hba->vops && hba->vops->wb_get_user_cap_mode)
> +		return hba->vops->wb_get_user_cap_mode(hba);
> +	return 0;
> +}
>   #endif /* End of Header */
> 
Hi,
Please ignore this patch, I'll send the proper series.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
