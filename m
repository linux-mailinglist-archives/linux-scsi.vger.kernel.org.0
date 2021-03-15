Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E98233AA31
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Mar 2021 05:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhCOEDC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 15 Mar 2021 00:03:02 -0400
Received: from z11.mailgun.us ([104.130.96.11]:18587 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhCOECt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 15 Mar 2021 00:02:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615780969; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=FzkGtEiCs3DhjQCop3ose1gcyTSL0b8LhPOWRcnCDB8=;
 b=k6PKndnKfHAZDk+hSQ0I17lIz1Y4YZjv/ELl23Q8Qs1pRr8fQkSMa6cTzsakSyLRfnXWlXmn
 ZgAY6mHbJdEjLWYbBO1NcSfb+DdsAXi61UBFydU9Nlk27q0qRRDmGtSWcXr57fbw9O2v9Gxe
 f3Y/D7NlQfjSf8DMsclUmdwVqnY=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 604edc5de3fca7d0a6fca6af (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Mar 2021 04:02:37
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21FC7C43466; Mon, 15 Mar 2021 04:02:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F062DC433CA;
        Mon, 15 Mar 2021 04:02:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 12:02:34 +0800
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
Subject: Re: [PATCH v5 05/10] scsi: ufshpb: Region inactivation in host mode
In-Reply-To: <20210302132503.224670-6-avri.altman@wdc.com>
References: <20210302132503.224670-1-avri.altman@wdc.com>
 <20210302132503.224670-6-avri.altman@wdc.com>
Message-ID: <25da7378d5bf4c52443ae9b47f3fd778@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-03-02 21:24, Avri Altman wrote:
> I host mode, the host is expected to send HPB-WRITE-BUFFER with
> buffer-id = 0x1 when it inactivates a region.
> 
> Use the map-requests pool as there is no point in assigning a
> designated cache for umap-requests.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/scsi/ufs/ufshpb.c | 14 ++++++++++++++
>  drivers/scsi/ufs/ufshpb.h |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
> index 6f4fd22eaf2f..0744feb4d484 100644
> --- a/drivers/scsi/ufs/ufshpb.c
> +++ b/drivers/scsi/ufs/ufshpb.c
> @@ -907,6 +907,7 @@ static int ufshpb_execute_umap_req(struct ufshpb_lu 
> *hpb,
> 
>  	blk_execute_rq_nowait(q, NULL, req, 1, ufshpb_umap_req_compl_fn);
> 
> +	hpb->stats.umap_req_cnt++;
>  	return 0;
>  }
> 
> @@ -1103,6 +1104,12 @@ static int ufshpb_issue_umap_req(struct 
> ufshpb_lu *hpb,
>  	return -EAGAIN;
>  }
> 
> +static int ufshpb_issue_umap_single_req(struct ufshpb_lu *hpb,
> +					struct ufshpb_region *rgn)
> +{
> +	return ufshpb_issue_umap_req(hpb, rgn);
> +}
> +
>  static int ufshpb_issue_umap_all_req(struct ufshpb_lu *hpb)
>  {
>  	return ufshpb_issue_umap_req(hpb, NULL);
> @@ -1115,6 +1122,10 @@ static void __ufshpb_evict_region(struct 
> ufshpb_lu *hpb,
>  	struct ufshpb_subregion *srgn;
>  	int srgn_idx;
> 
> +
> +	if (hpb->is_hcm && ufshpb_issue_umap_single_req(hpb, rgn))

__ufshpb_evict_region() is called with rgn_state_lock held and IRQ 
disabled,
when ufshpb_issue_umap_single_req() invokes blk_execute_rq_nowait(), 
below
warning shall pop up every time, fix it?

void blk_execute_rq_nowait(struct request_queue *q, struct gendisk 
*bd_disk,
		   struct request *rq, int at_head,
			   rq_end_io_fn *done)
{
	WARN_ON(irqs_disabled());
...

Thanks.
Can Guo.

> +		return;
> +
>  	lru_info = &hpb->lru_info;
> 
>  	dev_dbg(&hpb->sdev_ufs_lu->sdev_dev, "evict region %d\n", 
> rgn->rgn_idx);
> @@ -1855,6 +1866,7 @@ ufshpb_sysfs_attr_show_func(rb_noti_cnt);
>  ufshpb_sysfs_attr_show_func(rb_active_cnt);
>  ufshpb_sysfs_attr_show_func(rb_inactive_cnt);
>  ufshpb_sysfs_attr_show_func(map_req_cnt);
> +ufshpb_sysfs_attr_show_func(umap_req_cnt);
> 
>  static struct attribute *hpb_dev_stat_attrs[] = {
>  	&dev_attr_hit_cnt.attr,
> @@ -1863,6 +1875,7 @@ static struct attribute *hpb_dev_stat_attrs[] = {
>  	&dev_attr_rb_active_cnt.attr,
>  	&dev_attr_rb_inactive_cnt.attr,
>  	&dev_attr_map_req_cnt.attr,
> +	&dev_attr_umap_req_cnt.attr,
>  	NULL,
>  };
> 
> @@ -1978,6 +1991,7 @@ static void ufshpb_stat_init(struct ufshpb_lu 
> *hpb)
>  	hpb->stats.rb_active_cnt = 0;
>  	hpb->stats.rb_inactive_cnt = 0;
>  	hpb->stats.map_req_cnt = 0;
> +	hpb->stats.umap_req_cnt = 0;
>  }
> 
>  static void ufshpb_param_init(struct ufshpb_lu *hpb)
> diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
> index bd4308010466..84598a317897 100644
> --- a/drivers/scsi/ufs/ufshpb.h
> +++ b/drivers/scsi/ufs/ufshpb.h
> @@ -186,6 +186,7 @@ struct ufshpb_stats {
>  	u64 rb_inactive_cnt;
>  	u64 map_req_cnt;
>  	u64 pre_req_cnt;
> +	u64 umap_req_cnt;
>  };
> 
>  struct ufshpb_lu {
