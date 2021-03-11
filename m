Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282A0336D53
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Mar 2021 08:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCKHxH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 02:53:07 -0500
Received: from z11.mailgun.us ([104.130.96.11]:19293 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhCKHws (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Mar 2021 02:52:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615449168; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=u8HlVbbWr0cJdaVgt9UG5/w6LaGsbOcuQD80fH23w0A=;
 b=n8NLzF+juCFmZWaKT40dU14V+SZYf+1dEVDN/HP4PMgSYAbJK4+sFXlEovkh/ocFlcuTFJg1
 CbNRte+vxeExm3qwoFm6/ugRZfXm1kcdjCJzQPDHlOl5y567O2PUmJlr1p0dguU4aYUCdtZl
 puyD7W3g1nBj8AICmIB/xu8m4zY=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6049cc506e1c22bc8db0934e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Mar 2021 07:52:48
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0A98C43464; Thu, 11 Mar 2021 07:52:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F2E2C433ED;
        Thu, 11 Mar 2021 07:52:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 11 Mar 2021 15:52:46 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Bart Van Assche <bvanassche@acm.org>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        alim.akhtar@samsung.com, asutoshd@codeaurora.org,
        Zang Leigang <zangleigang@hisilicon.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Bean Huo <beanhuo@micron.com>, stanley.chu@mediatek.com
Subject: Re: [PATCH v5 03/10] scsi: ufshpb: Add region's reads counter
In-Reply-To: <20210302132503.224670-4-avri.altman@wdc.com>
References: <20210302132503.224670-1-avri.altman@wdc.com>
 <20210302132503.224670-4-avri.altman@wdc.com>
Message-ID: <838c79b39bf43e2ceaac06a190ded990@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri,

On 2021-03-02 21:24, Avri Altman wrote:
> In host control mode, reads are the major source of activation trials.
> Keep track of those reads counters, for both active as well inactive
> regions.
> 
> We reset the read counter upon write - we are only interested in 
> "clean"
> reads.  less intuitive however, is that we also reset it upon region's
> deactivation.  Region deactivation is often due to the fact that
> eviction took place: a region become active on the expense of another.
> This is happening when the max-active-regions limit has crossed. If we
> don’t reset the counter, we will trigger a lot of trashing of the HPB
> database, since few reads (or even one) to the region that was
> deactivated, will trigger a re-activation trial.
> 
> Keep those counters normalized, as we are using those reads as a
> comparative score, to make various decisions.
> If during consecutive normalizations an active region has exhaust its
> reads - inactivate it.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/scsi/ufs/ufshpb.c | 102 ++++++++++++++++++++++++++++++++------
>  drivers/scsi/ufs/ufshpb.h |   5 ++
>  2 files changed, 92 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
> index 044fec9854a0..a8f8d13af21a 100644
> --- a/drivers/scsi/ufs/ufshpb.c
> +++ b/drivers/scsi/ufs/ufshpb.c
> @@ -16,6 +16,8 @@
>  #include "ufshpb.h"
>  #include "../sd.h"
> 
> +#define ACTIVATION_THRESHOLD 4 /* 4 IOs */

Can this param be added as a sysfs entry?

Thanks,
Can Guo

> +
>  /* memory management */
>  static struct kmem_cache *ufshpb_mctx_cache;
>  static mempool_t *ufshpb_mctx_pool;
> @@ -554,6 +556,21 @@ static int ufshpb_issue_pre_req(struct ufshpb_lu
> *hpb, struct scsi_cmnd *cmd,
>  	return ret;
>  }
> 
> +static void ufshpb_update_active_info(struct ufshpb_lu *hpb, int 
> rgn_idx,
> +				      int srgn_idx)
> +{
> +	struct ufshpb_region *rgn;
> +	struct ufshpb_subregion *srgn;
> +
> +	rgn = hpb->rgn_tbl + rgn_idx;
> +	srgn = rgn->srgn_tbl + srgn_idx;
> +
> +	list_del_init(&rgn->list_inact_rgn);
> +
> +	if (list_empty(&srgn->list_act_srgn))
> +		list_add_tail(&srgn->list_act_srgn, &hpb->lh_act_srgn);
> +}
> +
>  /*
>   * This function will set up HPB read command using host-side L2P map 
> data.
>   */
> @@ -600,12 +617,44 @@ int ufshpb_prep(struct ufs_hba *hba, struct
> ufshcd_lrb *lrbp)
>  		ufshpb_set_ppn_dirty(hpb, rgn_idx, srgn_idx, srgn_offset,
>  				 transfer_len);
>  		spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
> +
> +		if (hpb->is_hcm) {
> +			spin_lock_irqsave(&rgn->rgn_lock, flags);
> +			rgn->reads = 0;
> +			spin_unlock_irqrestore(&rgn->rgn_lock, flags);
> +		}
> +
>  		return 0;
>  	}
> 
>  	if (!ufshpb_is_support_chunk(hpb, transfer_len))
>  		return 0;
> 
> +	if (hpb->is_hcm) {
> +		bool activate = false;
> +		/*
> +		 * in host control mode, reads are the main source for
> +		 * activation trials.
> +		 */
> +		spin_lock_irqsave(&rgn->rgn_lock, flags);
> +		rgn->reads++;
> +		if (rgn->reads == ACTIVATION_THRESHOLD)
> +			activate = true;
> +		spin_unlock_irqrestore(&rgn->rgn_lock, flags);
> +		if (activate) {
> +			spin_lock_irqsave(&hpb->rsp_list_lock, flags);
> +			ufshpb_update_active_info(hpb, rgn_idx, srgn_idx);
> +			hpb->stats.rb_active_cnt++;
> +			spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
> +			dev_dbg(&hpb->sdev_ufs_lu->sdev_dev,
> +				"activate region %d-%d\n", rgn_idx, srgn_idx);
> +		}
> +
> +		/* keep those counters normalized */
> +		if (rgn->reads > hpb->entries_per_srgn)
> +			schedule_work(&hpb->ufshpb_normalization_work);
> +	}
> +
>  	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
>  	if (ufshpb_test_ppn_dirty(hpb, rgn_idx, srgn_idx, srgn_offset,
>  				   transfer_len)) {
> @@ -745,21 +794,6 @@ static int ufshpb_clear_dirty_bitmap(struct 
> ufshpb_lu *hpb,
>  	return 0;
>  }
> 
> -static void ufshpb_update_active_info(struct ufshpb_lu *hpb, int 
> rgn_idx,
> -				      int srgn_idx)
> -{
> -	struct ufshpb_region *rgn;
> -	struct ufshpb_subregion *srgn;
> -
> -	rgn = hpb->rgn_tbl + rgn_idx;
> -	srgn = rgn->srgn_tbl + srgn_idx;
> -
> -	list_del_init(&rgn->list_inact_rgn);
> -
> -	if (list_empty(&srgn->list_act_srgn))
> -		list_add_tail(&srgn->list_act_srgn, &hpb->lh_act_srgn);
> -}
> -
>  static void ufshpb_update_inactive_info(struct ufshpb_lu *hpb, int 
> rgn_idx)
>  {
>  	struct ufshpb_region *rgn;
> @@ -1079,6 +1113,14 @@ static void __ufshpb_evict_region(struct 
> ufshpb_lu *hpb,
> 
>  	ufshpb_cleanup_lru_info(lru_info, rgn);
> 
> +	if (hpb->is_hcm) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&rgn->rgn_lock, flags);
> +		rgn->reads = 0;
> +		spin_unlock_irqrestore(&rgn->rgn_lock, flags);
> +	}
> +
>  	for_each_sub_region(rgn, srgn_idx, srgn)
>  		ufshpb_purge_active_subregion(hpb, srgn);
>  }
> @@ -1523,6 +1565,31 @@ static void
> ufshpb_run_inactive_region_list(struct ufshpb_lu *hpb)
>  	spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
>  }
> 
> +static void ufshpb_normalization_work_handler(struct work_struct 
> *work)
> +{
> +	struct ufshpb_lu *hpb;
> +	int rgn_idx;
> +	unsigned long flags;
> +
> +	hpb = container_of(work, struct ufshpb_lu, 
> ufshpb_normalization_work);
> +
> +	for (rgn_idx = 0; rgn_idx < hpb->rgns_per_lu; rgn_idx++) {
> +		struct ufshpb_region *rgn = hpb->rgn_tbl + rgn_idx;
> +
> +		spin_lock_irqsave(&rgn->rgn_lock, flags);
> +		rgn->reads = (rgn->reads >> 1);
> +		spin_unlock_irqrestore(&rgn->rgn_lock, flags);
> +
> +		if (rgn->rgn_state != HPB_RGN_ACTIVE || rgn->reads)
> +			continue;
> +
> +		/* if region is active but has no reads - inactivate it */
> +		spin_lock(&hpb->rsp_list_lock);
> +		ufshpb_update_inactive_info(hpb, rgn->rgn_idx);
> +		spin_unlock(&hpb->rsp_list_lock);
> +	}
> +}
> +
>  static void ufshpb_map_work_handler(struct work_struct *work)
>  {
>  	struct ufshpb_lu *hpb = container_of(work, struct ufshpb_lu, 
> map_work);
> @@ -1913,6 +1980,9 @@ static int ufshpb_lu_hpb_init(struct ufs_hba
> *hba, struct ufshpb_lu *hpb)
>  	INIT_LIST_HEAD(&hpb->list_hpb_lu);
> 
>  	INIT_WORK(&hpb->map_work, ufshpb_map_work_handler);
> +	if (hpb->is_hcm)
> +		INIT_WORK(&hpb->ufshpb_normalization_work,
> +			  ufshpb_normalization_work_handler);
> 
>  	hpb->map_req_cache = kmem_cache_create("ufshpb_req_cache",
>  			  sizeof(struct ufshpb_req), 0, 0, NULL);
> @@ -2012,6 +2082,8 @@ static void ufshpb_discard_rsp_lists(struct
> ufshpb_lu *hpb)
> 
>  static void ufshpb_cancel_jobs(struct ufshpb_lu *hpb)
>  {
> +	if (hpb->is_hcm)
> +		cancel_work_sync(&hpb->ufshpb_normalization_work);
>  	cancel_work_sync(&hpb->map_work);
>  }
> 
> diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
> index 8119b1a3d1e5..bd4308010466 100644
> --- a/drivers/scsi/ufs/ufshpb.h
> +++ b/drivers/scsi/ufs/ufshpb.h
> @@ -121,6 +121,10 @@ struct ufshpb_region {
>  	struct list_head list_lru_rgn;
>  	unsigned long rgn_flags;
>  #define RGN_FLAG_DIRTY 0
> +
> +	/* region reads - for host mode */
> +	spinlock_t rgn_lock;
> +	unsigned int reads;
>  };
> 
>  #define for_each_sub_region(rgn, i, srgn)				\
> @@ -211,6 +215,7 @@ struct ufshpb_lu {
> 
>  	/* for selecting victim */
>  	struct victim_select_info lru_info;
> +	struct work_struct ufshpb_normalization_work;
> 
>  	/* pinned region information */
>  	u32 lu_pinned_start;
