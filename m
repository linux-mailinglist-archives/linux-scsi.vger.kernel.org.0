Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20D66A7BD0
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Mar 2023 08:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCBH0q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Mar 2023 02:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCBH0p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Mar 2023 02:26:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D1298E2
        for <linux-scsi@vger.kernel.org>; Wed,  1 Mar 2023 23:26:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so2002750pjh.0
        for <linux-scsi@vger.kernel.org>; Wed, 01 Mar 2023 23:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3u3LErDLxQpcTw9IoCPajtVtH7Wl04gCGhYoZubMP8=;
        b=zkjvhExvYB0B4Qs2sggCbs2HJYow4AZ9zqt/ddPcN68B/NhRqd/fHYIc05vyHqguXZ
         rdItaGWqa2IRY4+HxOiaNJoPqQr+6IqEhaMmPndYTDYXW9VMkwjn0kmI5LdH77EKpMR7
         bls32mHRPKTxAe5TWE5VR6SGKlVuHGgWzzexA6cIudfbgNAeNe1Sfc2WAyeeW6dZqqtN
         C/TLFHEjXVGMOfeXm/HDP20KbV6bCY6ZxPfGCznWckEW5ywTk0vro+Yf8qYRdT0M+Nlw
         L2xESFFyZ0BLBoYIhuLNiooS9uUP1M62M6ciAntjR+44Nmigwk5ZuiGwJKWA5LzhYYXh
         T6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3u3LErDLxQpcTw9IoCPajtVtH7Wl04gCGhYoZubMP8=;
        b=YyKPgar1FJIrITldw9PGM/RWDakXIvswILecTsvxhRDaHbeVGmPMNkTlCZszelwgu+
         U1XcT9COpV4xpOOg9hr3sNks6KIL42UF52PkdGzPRqN2R3pigQz1Rk6P6gh91PUN87Lq
         Gd56JLsSaGv/aiigpMfQb2XRyt+5l8oV4IbHQZVY+7DU+gno75A4SX4ZTKpz4KCoZchy
         fhbuLyIBdEkehJsC+Fbl3OGpH/evqd8mWCoyqilSbqWE9RJhbP/Iq/KNZPBOrgxLfuHI
         5ytnnnPAgDYop7F7u4Mt77fSRBwyu8yDomO0Pa/8NwmDcVdllIYQydiCB42bkE23AsSz
         tnNQ==
X-Gm-Message-State: AO0yUKW0knO0Qgj0RpwsB2caX2oSbL1CWXapwePVXTQBHgZmjrarzPnZ
        PxKHwvMnMqYGdIo0CKkYMUJt
X-Google-Smtp-Source: AK7set+b5+DA7dn3dFlxWvnkmJ1pb3iQAsilUo7zXfjPyk+R+gXDelIQToIayCVkVSQPhcP2Tu7/Kg==
X-Received: by 2002:a05:6a20:4c16:b0:cc:d44a:beaf with SMTP id fm22-20020a056a204c1600b000ccd44abeafmr8583578pzb.13.1677741995997;
        Wed, 01 Mar 2023 23:26:35 -0800 (PST)
Received: from thinkpad ([59.97.53.52])
        by smtp.gmail.com with ESMTPSA id e18-20020a62aa12000000b00593cd0f37dcsm9077738pff.169.2023.03.01.23.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 23:26:35 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:56:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_asutoshd@quicinc.com
Subject: Re: [PATCH] ufs: host: ufs-qcom: Return directly if MCQ resource is
 provided in DT
Message-ID: <20230302072631.GA2890@thinkpad>
References: <20230301073110.9083-1-manivannan.sadhasivam@linaro.org>
 <a3c08b5f-b8cb-fdd9-eb60-b1adc2879fff@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3c08b5f-b8cb-fdd9-eb60-b1adc2879fff@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Mar 01, 2023 at 10:07:41AM -0800, Bart Van Assche wrote:
> On 2/28/23 23:31, Manivannan Sadhasivam wrote:
> > Instead of using a goto label to return, let's return directly in the
> > "if" condition after setting mcq_base.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/ufs/host/ufs-qcom.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index 34fc453f3eb1..d90f963eed02 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -1460,8 +1460,10 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
> >   	/* MCQ resource provided in DT */
> >   	res = &hba->res[RES_MCQ];
> >   	/* Bail if MCQ resource is provided */
> > -	if (res->base)
> > -		goto out;
> > +	if (res->base) {
> > +		hba->mcq_base = res->base;
> > +		return 0;
> > +	}
> >   	/* Explicitly allocate MCQ resource from ufs_mem */
> >   	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
> > @@ -1489,9 +1491,6 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
> >   		goto ioremap_err;
> >   	}
> > -out:
> > -	hba->mcq_base = res->base;
> > -	return 0;
> >   ioremap_err:
> >   	res->base = NULL;
> >   	remove_resource(res_mcq);
> 
> This patch changes the behavior for the success case without mentioning this
> in the patch description. So I assume that the behavior change is
> unintentional and hence that this patch should be dropped?
> 

Sorry, my bad here :( Please ignore this patch.

Thanks,
Mani

> Bart.

-- 
மணிவண்ணன் சதாசிவம்
