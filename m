Return-Path: <linux-scsi+bounces-990-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E466A813A68
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 19:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE7D282BC4
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Dec 2023 18:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7D68B99;
	Thu, 14 Dec 2023 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3qRxIIH"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8226D10F
	for <linux-scsi@vger.kernel.org>; Thu, 14 Dec 2023 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702580254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl3HqjIcCyU6c5THUJl64ri1en3ap6gGnuAwV6P1ius=;
	b=I3qRxIIHJyubkoodoOrCRlVuBFC3OzjyO8AhHeNu5HdOgWt/T1L4zYXUDtF8yXw/GrtSXh
	GmtozC9lVGbJdhpGCf4DiriflRxJl1byn6VeoBnx1QA++FnhMbDGfAd+79sLPPvGpXaffb
	jCbaqaIlrFVlMnQkev4AjbTm1Li2NfY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-hGZ4KBzrPkeX3MsRfa77HA-1; Thu, 14 Dec 2023 13:57:33 -0500
X-MC-Unique: hGZ4KBzrPkeX3MsRfa77HA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9e358994fso11615179b6e.0
        for <linux-scsi@vger.kernel.org>; Thu, 14 Dec 2023 10:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702580252; x=1703185052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl3HqjIcCyU6c5THUJl64ri1en3ap6gGnuAwV6P1ius=;
        b=GQiTHNo5Yg9dVypWYb2Zfb1STx3buSoRTq+n1iFJzRIpgdwnoEs57H5kleenXJ0TNl
         EU+mk0QM5y4W5rMFn0gAKSJZjZBIf+Dr0bxs+YHprSv4HILt0s9aTDPZjX5wFOTP+Lb/
         vA0ig6m1nzQB8EElWqAN85d09ZH+W4HAnYGwhmleEjtXv0VgltkR9dxu7CTAkdOHeUXc
         AlUA8s/Rjerd+tsKCgPaBz1musZjDaIUkYYJoOwAhoBLqqcU7d+4PYBc4uzag8b1NgWO
         fir/r5kwT/4r17iuDEien8ExSg4qqfPXObGZIzApZkhU4Rqgfd3ALJFhufVxRahCFNlj
         wX8Q==
X-Gm-Message-State: AOJu0Yza7jSZz+08wcuTRmnLfkZ2hiPUX0cMiP9Sg8XzDTY1HYjRSeKg
	IRe96J5R3Yhv/Clzhuup2KFEWYvqRdALfivEKauWVWsyZwbfDj3JHIet8wVobBsZXnhLvAQXXBF
	ue7NqHuWAsg+Cb05b5pEB4lvjQKXFkg==
X-Received: by 2002:a05:6808:4182:b0:3b9:dcb8:2ad1 with SMTP id dj2-20020a056808418200b003b9dcb82ad1mr11604260oib.112.1702580252373;
        Thu, 14 Dec 2023 10:57:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIc/zQX7LU/xm/BRS3QmT0M8wjT9iAR291mFBSuyPsGWBGKLM7TSjmQtN7SWzeOZ/FV26rkw==
X-Received: by 2002:a05:6808:4182:b0:3b9:dcb8:2ad1 with SMTP id dj2-20020a056808418200b003b9dcb82ad1mr11604248oib.112.1702580252180;
        Thu, 14 Dec 2023 10:57:32 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id dg1-20020a056214084100b0067ed87e51edsm3466800qvb.36.2023.12.14.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:57:31 -0800 (PST)
Date: Thu, 14 Dec 2023 12:57:29 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mani@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, grant.jung@samsung.com, jt77.jang@samsung.com, 
	dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: Re: [PATCH v2] scsi: ufs: qcom: Re-fix for error handling
Message-ID: <rrp3umto2jhti5n6iwhhj2vwub7uh4q2jsbqmlfmvzn6fyp2nr@nzzr4ah4gdd5>
References: <CGME20231214021405epcas1p3cef80b85df56b7bead7f2f2ebd52f4ac@epcas1p3.samsung.com>
 <20231214021401.26474-1-cw9316.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214021401.26474-1-cw9316.lee@samsung.com>

On Thu, Dec 14, 2023 at 11:14:01AM +0900, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> I modified the code to handle errors.
> 
> The error handling code has been changed from the patch below.
> -'commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")'
> 
> This is the case I checked.
> * ufs_qcom_clk_scale_notify -> 'ufs_qcom_clk_scale_up_/down_pre_change' error -> return 0;
> 
> It is unknown whether the above commit was intended to change error handling.
> However, if it is not an intended fix, a patch may be needed.

Can you be a bit specific about what you fixed here in the commit?
Both the subject and the description is vague and sounds like you're
still unsure if this change is a good idea. The review on the prior
patch and this one is indicating that this change is necessary and a
fix, so let's be more confident in the description for future readers.

Write as you please, but something like:

    scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in ufs_qcom_clk_scale_notify()

    In commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")
    the error handling was accidentally changed, resulting in the error of
    ufs_qcom_clk_scale_*() calls not being returned.

    Let's make sure those errors are properly returned.

> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

This deserves a Fixes: tag (I see Mani mentioned that)

> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

I did not provide a Reviewed-by tag in v1, this is not accurate:

    https://lore.kernel.org/linux-arm-msm/m5wjp3yb3qpheyzgipekeagycboifqdpw54nquzqsftufap3yc@kxjwi4y63adj/

Outside of that this looks good, thanks!

> ---
> v1->v2: Remove things already in progress
>  1) ufs_qcom_host_reset -> 'reset_control_deassert' error -> return 0;
>    -> https://lore.kernel.org/linux-arm-msm/20231208065902.11006-8-manivannan.sadhasivam@linaro.org/#t
>  2) ufs_qcom_init_lane_clks -> 'ufs_qcom_host_clk_get(tx_lane1_sync_clk)' error -> return 0;
>    -> https://lore.kernel.org/linux-arm-msm/20231208065902.11006-2-manivannan.sadhasivam@linaro.org/
> ---
> ---
>  drivers/ufs/host/ufs-qcom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 96cb8b5b4e66..17e24270477d 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1516,9 +1516,11 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  			err = ufs_qcom_clk_scale_up_pre_change(hba);
>  		else
>  			err = ufs_qcom_clk_scale_down_pre_change(hba);
> -		if (err)
> -			ufshcd_uic_hibern8_exit(hba);
>  
> +		if (err) {
> +			ufshcd_uic_hibern8_exit(hba);
> +			return err;
> +		}
>  	} else {
>  		if (scale_up)
>  			err = ufs_qcom_clk_scale_up_post_change(hba);
> -- 
> 2.29.0
> 


