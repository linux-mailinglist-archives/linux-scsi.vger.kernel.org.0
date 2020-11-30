Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A22C91EE
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Dec 2020 00:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgK3XDj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Nov 2020 18:03:39 -0500
Received: from z5.mailgun.us ([104.130.96.5]:50748 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgK3XDi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 30 Nov 2020 18:03:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606777392; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=EISVAw61BH5Re+I7UyxCOWU0E6/dUFfyNJ18uYJF/MU=; b=kMI8KtDM2tGMmrCHnnseS4463iW/UCDZP9s89+kpz8DKvSiOt5m05fgV3MPvOzGny+nkt/uh
 7pP7qxtrI7SOmcXcyMbbPp5Q6VPs/6eF7S2RTI6uFnasi64ARc5cckteJftCnOVMF5LkC9sH
 lt0KYGDmEYkDK//yrqe9CiOiv5g=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fc579eaf653ea0cd82ac183 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Nov 2020 23:02:02
 GMT
Sender: asutoshd=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5C570C43469; Mon, 30 Nov 2020 23:02:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.8.168] (cpe-70-95-149-85.san.res.rr.com [70.95.149.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 542FCC433ED;
        Mon, 30 Nov 2020 23:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 542FCC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v3 1/2] scsi: ufs: Refactor ufshcd_setup_clocks() to
 remove skip_ref_clk
To:     Can Guo <cang@codeaurora.org>, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <1606356063-38380-1-git-send-email-cang@codeaurora.org>
 <1606356063-38380-2-git-send-email-cang@codeaurora.org>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <f99ee6cd-6e09-4160-f9e8-2d8b04cbfa1e@codeaurora.org>
Date:   Mon, 30 Nov 2020 15:01:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1606356063-38380-2-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/25/2020 6:01 PM, Can Guo wrote:
> Remove the param skip_ref_clk from __ufshcd_setup_clocks(), but keep a flag
> in struct ufs_clk_info to tell whether a clock can be disabled or not while
> the link is active.
> 
> Reviewed-by: Hongwu Su<hongwus@codeaurora.org>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>   drivers/scsi/ufs/ufshcd-pltfrm.c |  2 ++
>   drivers/scsi/ufs/ufshcd.c        | 29 +++++++++--------------------
>   drivers/scsi/ufs/ufshcd.h        |  3 +++
>   3 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index 3db0af6..873ef14 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -92,6 +92,8 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>   		clki->min_freq = clkfreq[i];
>   		clki->max_freq = clkfreq[i+1];
>   		clki->name = kstrdup(name, GFP_KERNEL);
> +		if (!strcmp(name, "ref_clk"))
> +			clki->keep_link_active = true;
>   		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table-hz",
>   				clki->min_freq, clki->max_freq, clki->name);
>   		list_add_tail(&clki->list, &hba->clk_list_head);
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index a7857f6..44254c9 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -221,8 +221,6 @@ static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd);
>   static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag);
>   static void ufshcd_hba_exit(struct ufs_hba *hba);
>   static int ufshcd_probe_hba(struct ufs_hba *hba, bool async);
> -static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
> -				 bool skip_ref_clk);
>   static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
>   static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba);
>   static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
> @@ -1707,11 +1705,7 @@ static void ufshcd_gate_work(struct work_struct *work)
>   
>   	ufshcd_disable_irq(hba);
>   
> -	if (!ufshcd_is_link_active(hba))
> -		ufshcd_setup_clocks(hba, false);
> -	else
> -		/* If link is active, device ref_clk can't be switched off */
> -		__ufshcd_setup_clocks(hba, false, true);
> +	ufshcd_setup_clocks(hba, false);
>   
>   	/*
>   	 * In case you are here to cancel this work the gating state
> @@ -7990,8 +7984,7 @@ static int ufshcd_init_hba_vreg(struct ufs_hba *hba)
>   	return 0;
>   }
>   
> -static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
> -					bool skip_ref_clk)
> +static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
>   {
>   	int ret = 0;
>   	struct ufs_clk_info *clki;
> @@ -8009,7 +8002,12 @@ static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
>   
>   	list_for_each_entry(clki, head, list) {
>   		if (!IS_ERR_OR_NULL(clki->clk)) {
> -			if (skip_ref_clk && !strcmp(clki->name, "ref_clk"))
> +			/*
> +			 * Don't disable clocks which are needed
> +			 * to keep the link active.
> +			 */
> +			if (ufshcd_is_link_active(hba) &&
> +			    clki->keep_link_active)
>   				continue;
>   
>   			clk_state_changed = on ^ clki->enabled;
> @@ -8054,11 +8052,6 @@ static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
>   	return ret;
>   }
>   
> -static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
> -{
> -	return  __ufshcd_setup_clocks(hba, on, false);
> -}
> -
>   static int ufshcd_init_clocks(struct ufs_hba *hba)
>   {
>   	int ret = 0;
> @@ -8577,11 +8570,7 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>   	 */
>   	ufshcd_disable_irq(hba);
>   
> -	if (!ufshcd_is_link_active(hba))
> -		ufshcd_setup_clocks(hba, false);
> -	else
> -		/* If link is active, device ref_clk can't be switched off */
> -		__ufshcd_setup_clocks(hba, false, true);
> +	ufshcd_setup_clocks(hba, false);
>   
>   	if (ufshcd_is_clkgating_allowed(hba)) {
>   		hba->clk_gating.state = CLKS_OFF;
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 66e5338..6f0f2d4 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -229,6 +229,8 @@ struct ufs_dev_cmd {
>    * @max_freq: maximum frequency supported by the clock
>    * @min_freq: min frequency that can be used for clock scaling
>    * @curr_freq: indicates the current frequency that it is set to
> + * @keep_link_active: indicates that the clk should not be disabled if
> +		      link is active
>    * @enabled: variable to check against multiple enable/disable
>    */
>   struct ufs_clk_info {
> @@ -238,6 +240,7 @@ struct ufs_clk_info {
>   	u32 max_freq;
>   	u32 min_freq;
>   	u32 curr_freq;
> +	bool keep_link_active;

Nitpick - How about 'always-on' instead of 'keep_link_active'?
>   	bool enabled;
>   };
>   
> 


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
