Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171962DF7E8
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Dec 2020 03:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgLUC6E (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 20 Dec 2020 21:58:04 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:45601 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgLUC6D (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 20 Dec 2020 21:58:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608519474; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=K6lotYWe3+EolmmnryO1r75HsQ39sFzGzr4hWJmBRJE=;
 b=sB3Sp3L63SQb9nBYvWeEJ/2qToRp/7ciSzNovkOyZp8Dhsf82c3eXjdCeg/1PGd94DPEW4VV
 jdvQCFcbcmUkie/WhZtrMSFYnjH8ZJUAKUM7whMvaC5l6WJobKcGehimlDYSf6wWY4jFmHnB
 T5OISKqePaGDhfo7psNko8pL2zw=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fe00f0d3d3433393d20e642 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 02:57:17
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD45BC43466; Mon, 21 Dec 2020 02:57:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7963AC433C6;
        Mon, 21 Dec 2020 02:57:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Dec 2020 10:57:15 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, bvanassche@acm.org,
        grant.jung@samsung.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com
Subject: Re: [RFC PATCH v1 1/2] ufs: add a vops to configure block parameter
In-Reply-To: <ecc0563a5a48e3339e59760cc8cb73a698061851.1608352548.git.kwmad.kim@samsung.com>
References: <cover.1608352548.git.kwmad.kim@samsung.com>
 <CGME20201219044916epcas2p16927b09270a3d829520af414dd64d80f@epcas2p1.samsung.com>
 <ecc0563a5a48e3339e59760cc8cb73a698061851.1608352548.git.kwmad.kim@samsung.com>
Message-ID: <d2ba958d2e4b20de0b900a9a53ed169d@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-12-19 12:38, Kiwoong Kim wrote:
> Thers could be some cases to set block paramters

s/Thers/There/g

> per host, because of its own dma structurs or whatever.

s/structurs/structure/g

> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 2 ++
>  drivers/scsi/ufs/ufshcd.h | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 92d433d..58f9cb6 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4758,6 +4758,8 @@ static int ufshcd_slave_configure(struct
> scsi_device *sdev)
> 
>  	ufshcd_crypto_setup_rq_keyslot_manager(hba, q);
> 
> +	ufshcd_vops_config_request_queue(hba, sdev);

How about make it more univeral, like ufshcd_vops_slave_configure()?

Thanks,

Can Guo.

> +
>  	return 0;
>  }
> 
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 61344c4..657bdbd 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -329,6 +329,7 @@ struct ufs_hba_variant_ops {
>  					void *data);
>  	int	(*program_key)(struct ufs_hba *hba,
>  			       const union ufs_crypto_cfg_entry *cfg, int slot);
> +	void	(*config_request_queue)(struct scsi_device *sdev);
>  };
> 
>  /* clock gating state  */
> @@ -1228,6 +1229,13 @@ static inline void
> ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
>  		hba->vops->config_scaling_param(hba, profile, data);
>  }
> 
> +static inline void ufshcd_vops_config_request_queue(struct ufs_hba 
> *hba,
> +						    struct scsi_device *sdev)
> +{
> +	if (hba->vops && hba->vops->config_request_queue)
> +		hba->vops->config_request_queue(sdev);
> +}
> +
>  extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
> 
>  /*
