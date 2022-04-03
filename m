Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB454F0724
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Apr 2022 05:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiDCDui (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 2 Apr 2022 23:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiDCDue (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 2 Apr 2022 23:50:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036326573
        for <linux-scsi@vger.kernel.org>; Sat,  2 Apr 2022 20:48:39 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v75so6815992oie.1
        for <linux-scsi@vger.kernel.org>; Sat, 02 Apr 2022 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dq5MZK0bxLSQiebngejurXppA92tDEbVf8t+Lt0maXg=;
        b=gff8H1gMWNcb2ztQhxIIgL89G5mQt5Z5WF+5V0hQbsxkZgkQW9/ZzMYGegbv4e5MFB
         I6zcJg1fUXHE2nMCsHSAOcr9ucr7Sq9GCs9wjYPY9Y2mD9h+IyLstVqLUl/jqKPblm6o
         PKW0OC1ex0SWOaAhPtDYfGl66RUXdSW6BWz8d+gGH/Hz4LGq/dRVMZ69wH1bQwSqnjSu
         XznwlEX9GYLTe56uVi7DnYOGYPQAF5alq+h5UYYP61HwE0/v35BTO3zGZqHvvYMqqlbP
         4LKf4Qh2HO0wzKf76kRl/RGSGUVDU2WHHJQbibAUTuNAUakB2dtNrDPG8xHNIaJd5Jsx
         T/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dq5MZK0bxLSQiebngejurXppA92tDEbVf8t+Lt0maXg=;
        b=KDXuekN1+q8gdo1IlBce0dBVvpF5IpTS3pi9TziI5oDkxTma1nxZXwCawbVl9Fa5Os
         okBFgIak2unaFXyYCZhoCPiIM5BZrKo8lakkI1tUZmAZGV0DZKKdI1xOOMen72B41Gen
         Rt0allsRdK025BTEzTth2O49ajl73JRwRJFqmOB9T0fW64cJ3cv28716COaFXnMsNuUb
         6apkgEXQIPc7iaMoqLKw9pqKCpPiljMz4xV/kMl6l0flBsqoFcdezZ7FSGUe+TF56QU0
         nbvMIA1I3iFScC/rNUi/vtcClmUaCt8wrydANw5RkTZKZiw/acEgzLH29YVGBybsdLY0
         BH8w==
X-Gm-Message-State: AOAM530d+XzNtLaePfyVmnmoOuoA6z5q0K8Vztj6HWW6uGmmiJ47edsp
        17W97XnsXCXq1gCzrGZP2dEfjg==
X-Google-Smtp-Source: ABdhPJwjfpeZ937WUtvb9DImfaTMcO0cX7jAiVNd9s1Yp+pil5RN4x1XRpCKoJ0lXCnRRjgDP1Dyaw==
X-Received: by 2002:a05:6808:1a9b:b0:2ec:9c38:185 with SMTP id bm27-20020a0568081a9b00b002ec9c380185mr7779317oib.165.1648957718751;
        Sat, 02 Apr 2022 20:48:38 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 2-20020a056870124200b000dd9ac0d61esm2769562oao.24.2022.04.02.20.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 20:48:38 -0700 (PDT)
Date:   Sat, 2 Apr 2022 20:51:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH 14/29] scsi: ufs: Make the config_scaling_param calls
 type safe
Message-ID: <YkkZqIV5GT8kbM0z@ripper>
References: <20220331223424.1054715-1-bvanassche@acm.org>
 <20220331223424.1054715-15-bvanassche@acm.org>
 <YkY9yRNJkuQtoHo1@ripper>
 <68a7497b-2eaf-2326-1e9a-ecf5546e006e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a7497b-2eaf-2326-1e9a-ecf5546e006e@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu 31 Mar 21:08 PDT 2022, Bart Van Assche wrote:

> On 3/31/22 16:48, Bjorn Andersson wrote:
> > On Thu 31 Mar 15:34 PDT 2022, Bart Van Assche wrote:
> > >   #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
> > >   static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
> > > -					  struct devfreq_dev_profile *p,
> > > -					  void *data)
> > > +		struct devfreq_dev_profile *p,
> > > +		struct devfreq_simple_ondemand_data *d)
> > 
> > This doesn't look to be properly indended to match the '('?
> > What does ./scripts/checkpatch.pl --strict say about the patch?
> > 
> > 
> > Other than that, the change looks good, so feel free to add my r-b once
> > you've double checked the indentation.
> > 
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Checkpatch doesn't verify this kind of indentation as far as I know.

I was expecting to get the "Alignment should match open parenthesis",
but apparently this case doesn't trigger that check, for some reason...

> Anyway, I will fix up the indentation when I repost this patch.

Cool, thanks!

PS. This patch is quite trivial and could definitely be merged
independent of the big shuffling later in the series.
If you send such patches on their own, or at least early in the series
its possible for the maintainer to pick it up while you continue to
iterate the more complex things at the end - and hence you won't
continue to respin 29 patches.

> Thanks for having taken a look.
> 

You're welcome,
Bjorn
