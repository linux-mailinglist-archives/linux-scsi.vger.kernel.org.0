Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E70336D5A
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Mar 2021 08:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCKHym (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 02:54:42 -0500
Received: from z11.mailgun.us ([104.130.96.11]:19293 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhCKHyN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Mar 2021 02:54:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615449253; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ID1KDNd+0JpNyiGIk1PSRDJhaqeYgvN/2u/f3rE4gIo=;
 b=j7EjFG+PLJdmSavMT+VND3NonKZJ5AHcZQCyc/a6wKi6fpDj6DLAh8lQdDoxW3HdOH7me3Pa
 YZRLu+mElvHRSVmUusNQYAhttT6JhNr+YJz+kqEH+9XOQVYSrJfnvJW8LQJk8P9kfdOozyvY
 ZDGMkTXyeQXabkqrVsui0VVnOQM=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6049cc91f14e98d35da71c16 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Mar 2021 07:53:53
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8AA0EC4346A; Thu, 11 Mar 2021 07:53:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DDDBC43461;
        Thu, 11 Mar 2021 07:53:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Mar 2021 15:53:51 +0800
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
Subject: Re: [PATCH v5 04/10] scsi: ufshpb: Make eviction depends on region's
 reads
In-Reply-To: <20210302132503.224670-5-avri.altman@wdc.com>
References: <20210302132503.224670-1-avri.altman@wdc.com>
 <20210302132503.224670-5-avri.altman@wdc.com>
Message-ID: <76763b655ef8ffec56123ff1ac56f474@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri,

On 2021-03-02 21:24, Avri Altman wrote:
> In host mode, eviction is considered an extreme measure.
> verify that the entering region has enough reads, and the exiting
> region has much less reads.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/scsi/ufs/ufshpb.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
> index a8f8d13af21a..6f4fd22eaf2f 100644
> --- a/drivers/scsi/ufs/ufshpb.c
> +++ b/drivers/scsi/ufs/ufshpb.c
> @@ -17,6 +17,7 @@
>  #include "../sd.h"
> 
>  #define ACTIVATION_THRESHOLD 4 /* 4 IOs */
> +#define EVICTION_THRESHOLD (ACTIVATION_THRESHOLD << 6) /* 256 IOs */

Same here, can this be added as a sysfs entry?

Thanks,
Can Guo.

> 
>  /* memory management */
>  static struct kmem_cache *ufshpb_mctx_cache;
> @@ -1050,6 +1051,13 @@ static struct ufshpb_region
> *ufshpb_victim_lru_info(struct ufshpb_lu *hpb)
>  		if (ufshpb_check_srgns_issue_state(hpb, rgn))
>  			continue;
> 
> +		/*
> +		 * in host control mode, verify that the exiting region
> +		 * has less reads
> +		 */
> +		if (hpb->is_hcm && rgn->reads > (EVICTION_THRESHOLD >> 1))
> +			continue;
> +
>  		victim_rgn = rgn;
>  		break;
>  	}
> @@ -1235,7 +1243,7 @@ static int ufshpb_issue_map_req(struct ufshpb_lu 
> *hpb,
> 
>  static int ufshpb_add_region(struct ufshpb_lu *hpb, struct 
> ufshpb_region *rgn)
>  {
> -	struct ufshpb_region *victim_rgn;
> +	struct ufshpb_region *victim_rgn = NULL;
>  	struct victim_select_info *lru_info = &hpb->lru_info;
>  	unsigned long flags;
>  	int ret = 0;
> @@ -1263,6 +1271,16 @@ static int ufshpb_add_region(struct ufshpb_lu
> *hpb, struct ufshpb_region *rgn)
>  			 * because the device could detect this region
>  			 * by not issuing HPB_READ
>  			 */
> +
> +			/*
> +			 * in host control mode, verify that the entering
> +			 * region has enough reads
> +			 */
> +			if (hpb->is_hcm && rgn->reads < EVICTION_THRESHOLD) {
> +				ret = -EACCES;
> +				goto out;
> +			}
> +
>  			victim_rgn = ufshpb_victim_lru_info(hpb);
>  			if (!victim_rgn) {
>  				dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
