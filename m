Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37EA63415E
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Nov 2022 17:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiKVQXO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Nov 2022 11:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiKVQXL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Nov 2022 11:23:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF28A1AF3F
        for <linux-scsi@vger.kernel.org>; Tue, 22 Nov 2022 08:23:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so14789648pjl.3
        for <linux-scsi@vger.kernel.org>; Tue, 22 Nov 2022 08:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ue9EDxh2qojVXmFN9RvpYTz/rVI4G/WOf5jkgr5avh0=;
        b=LDOUMeLUyFATDS/+DT4WyniglISnUgAwwcB3WL4mvHq14NwZpdrA+n/1ffLEnYoY+Y
         9+KkgXw5/sGDO9x63IGVWM23h3xZAy7n+AJR8tF7WCacuD1jZ0IIXawVRFre5ir6fF2w
         ERTdlAm6qmlVDiyThKyhqvE7ghrMRHPkjx6D+WDpckOtiFyZpQjQdsUWmiZ143eJ+HQQ
         k/c+mJPelDrGfF3UW0hTOl/334KdGGjuTaIdpNXFh8CKOpSHtyWvchfvxLwpTSTA8dN6
         3IIJ7BE4ZX9a3fDv1oXttKb67+an4NexOflUS2TyAMDqTYtxz6fBgw+AFRBcHT5296+L
         chNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ue9EDxh2qojVXmFN9RvpYTz/rVI4G/WOf5jkgr5avh0=;
        b=4CCw/wrvqoZpmBr/Y8dJgxP9tJREH7lWTYCm3HrsWJMohaeVJq41NVRzIYgdvof9oD
         Sgp3kCaNk2nowOK2MPn75HXirKAm+0xqzNAK/E+05ndYGDB3JegNwq/NAyhjO1DeQB/x
         d8QgnUD8lNZDv9ytyyC/YIwmJchBVVsY56eoO2PkINy3yvVFjck8O96BNq9Xgr+UAbja
         1jni2sj7eqcPWnheNz7KsuZlqWLrhbVHDVeIcT4E6Vtix5HptdE6PbmYEQnvlFSh0rN4
         16E0CNtKlnYgs3bkw9urHzThFWD+kurI2PABEYOs04PTkxGOP4fGzuBnxRgT6i1GZCfn
         klQw==
X-Gm-Message-State: ANoB5pn+cWfFO6tFWEk8x726iBUmS6ruAv/24MIxJ2dEOKcvCPH4iL46
        eSVnosuxJjQ3U0+BbTa/6EH9
X-Google-Smtp-Source: AA0mqf4XagdHN/lPKo62pTMRpEMHACHdEvJpA6tV10xR66vw+jaqfssWJR5FI1MtF5k11dO9uUcj3Q==
X-Received: by 2002:a17:902:7d89:b0:188:4ba9:79ee with SMTP id a9-20020a1709027d8900b001884ba979eemr4928697plm.83.1669134187482;
        Tue, 22 Nov 2022 08:23:07 -0800 (PST)
Received: from thinkpad ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709027c9300b0017f9db0236asm12224560pll.82.2022.11.22.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:23:06 -0800 (PST)
Date:   Tue, 22 Nov 2022 21:52:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        ahalaney@redhat.com
Subject: Re: [PATCH v2 06/15] dt-bindings: ufs: Add "max-device-gear"
 property for UFS device
Message-ID: <20221122162258.GG157542@thinkpad>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-7-manivannan.sadhasivam@linaro.org>
 <1fe8fd96-7770-0bda-c970-aa38d030ff3b@linaro.org>
 <20221103122850.GD8434@thinkpad>
 <a170e4e8-fc9d-9be1-35ba-733f24cb93e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a170e4e8-fc9d-9be1-35ba-733f24cb93e8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Nov 03, 2022 at 11:23:17AM -0400, Krzysztof Kozlowski wrote:
> On 03/11/2022 08:28, Manivannan Sadhasivam wrote:
> > On Wed, Nov 02, 2022 at 03:09:50PM -0400, Krzysztof Kozlowski wrote:
> >> On 31/10/2022 14:02, Manivannan Sadhasivam wrote:
> >>> The maximum gear supported by the UFS device can be specified using the
> >>> "max-device-gear" property. This allows the UFS controller to configure the
> >>> TX/RX gear before starting communication with the UFS device.
> >>
> >> This is confusing. The UFS PHY provides gear capability, so what is the
> >> "device" here? The attached memory? How could it report something else
> >> than phy?
> >>
> > 
> > This is the norm with any storage protocol, right? Both host and device
> > (memory) can support different speeds and the OEM can choose to put any
> > combinations (even though it might not be very efficient).
> > 
> > For instance,
> > 
> > PHY (G4) -> Device (G3)
> 
> Yes and look at MMC - no need to define "max mode" supported by eMMC.
> You define the modes supported by controller but the memory capabilities
> are being autodetected and negotiated.
> 
> > 
> > From the host perspective we know what the PHY can support but that's not the
> > same with the device until probing it. And probing requires using a minimum
> > supported gear. For sure we can use something like G2/G3 and reinit later but
> > as I learnt, that approach was rejected by the community when submitted
> > by Qualcomm earlier.
> 
> It should be then referenced somewhere as it might be a reason to accept
> the property.
> 
> > 
> >> The last sentence also suggests that you statically encode gear to avoid
> >> runtime negotiation.
> >>
> > 
> > Yes, the OEM should know what the max gear speed they want to run, so getting
> > this info from DT makes sense.
> 
> Not really if it is auto-detectable. Just because things are static is
> not the sole reason to put them into DT. The reason is - they are not
> detectable by OS/firmware thus we must have them in DT to be able to
> know it.
> 

Since I'm not able to get a link to the previous discussion, I'm gonna
implement the reinit support and post the next iteration. Let's see how it
turns up.

Thanks,
Mani

> 
> 
> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
