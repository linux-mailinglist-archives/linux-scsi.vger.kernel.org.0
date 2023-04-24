Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A016D1697
	for <lists+linux-scsi@lfdr.de>; Fri, 31 Mar 2023 07:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCaFEf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 Mar 2023 01:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCaFEe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 Mar 2023 01:04:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D8CA38
        for <linux-scsi@vger.kernel.org>; Thu, 30 Mar 2023 22:04:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v6-20020a05600c470600b003f034269c96so2852149wmo.4
        for <linux-scsi@vger.kernel.org>; Thu, 30 Mar 2023 22:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680239070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5ccYAgCHqzoTzDLyYRXu9bNF8OBZM7zuIk64ThIB8w=;
        b=w7dxeaw13Pvvh/aR2lls6vrUJvKsgZIC6P8inBBkdbrsYhT6gs0/NP8DnzgdGlpHmy
         MkMFMp4jmIHeti3D+PlKantwSS2iXnP5+CGxuWo0P2c9jKgFjF/0Uck65uYuvz8AXLlu
         TGPyay8pr/t+bTMTAvgXtsS07sK7uL2u6aHuRQM4sGLXOuso9bhOXj1JhbPe/g6UBvde
         CI0aS9dhZS2lzpWXAP1FYT5DEsivzMRyHVaWZ39+gQh7WqsvepLDU2O8z8hGAGtNcN9E
         SYi7kW/5VRtT5dD1pgkgzbIlz8G0R5K6Na8TpBMKSCBS3fBuf61LlJI+W/nrUALYiURb
         f6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680239070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5ccYAgCHqzoTzDLyYRXu9bNF8OBZM7zuIk64ThIB8w=;
        b=M8GjKctPPRjE95/ZlTuk7oLrBYEn2u0sTAV1ZZ5aS9vfGaIwDWP+HNFFpcnDy1G9WG
         XoDCKy50sPOwc8dj37CDNGYC44z9PrH9Sdr/8X4v+gxVZtwMfccrw64UK3khLz1WH2rS
         Y1hTLG0U8DMCBhI+yXzMtWlgOe+qzWs8BAOxNrn6MWetTT2nvxKkibpULPPIh6Y6fGPd
         IsLFGJ/qCVtqDn7wlRF05SgTx3R4C5C7gqr2UJSRMV6NPudB8IKJ27L1xQzldJ/YtgRO
         OtNOkmRWnvXf/SNZJAqJ9BE3k8uYCnA3t0x8jYwyO+t1Sl0+Kxy3WUrJvrnuuJ06SAbN
         BBSw==
X-Gm-Message-State: AO0yUKXxPYgSXMItFIcbe3ol1pnsoZp4/4w37PCHAt9EQRmLoyXJ1OHy
        NBmeNwM5vcU3oJish+GcTy7PVg==
X-Google-Smtp-Source: AK7set8ILq3t3Dt+i5j/HiwaDpQU1K0nc5rBKWTsLwIjY/vVE+V8n2spz1lJ0CsHhhzXIpJYc+u/8A==
X-Received: by 2002:a05:600c:3655:b0:3eb:2da4:f304 with SMTP id y21-20020a05600c365500b003eb2da4f304mr18180760wmq.17.1680239070261;
        Thu, 30 Mar 2023 22:04:30 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002c5691f13eesm1090651wrx.50.2023.03.30.22.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 22:04:29 -0700 (PDT)
Date:   Fri, 31 Mar 2023 08:04:28 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 6/7] mmc: sdhci-msm: Switch to the new ICE API
Message-ID: <ZCZp3Kx2IJVHxrMM@linaro.org>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-7-abel.vesa@linaro.org>
 <20230327183211.GA73752@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327183211.GA73752@sol.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 23-03-27 11:32:11, Eric Biggers wrote:
> On Mon, Mar 27, 2023 at 04:47:33PM +0300, Abel Vesa wrote:
> > Now that there is a new dedicated ICE driver, drop the sdhci-msm ICE
> > implementation and use the new ICE api provided by the Qualcomm soc
> > driver ice. The platforms that already have ICE support will use the
> > API as library since there will not be a devicetree node, but instead
> > they have reg range. In this case, the of_qcom_ice_get will return an
> > ICE instance created for the consumer's device. But if there are
> > platforms that do not have ice reg in the consumer devicetree node
> > and instead provide a dedicated ICE devicetree node, theof_qcom_ice_get
> > will look up the device based on qcom,ice property and will get the ICE
> > instance registered by the probe function of the ice driver.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > 
> > The v3 (RFC) is here:
> > https://lore.kernel.org/all/20230313115202.3960700-7-abel.vesa@linaro.org/
> > 
> > Changes since v3:
> >  * added back the checks for and the setting of MMC_CAP2_CRYPTO 
> >  * added enable/resume/suspend implementation for !CONFIG_MMC_CRYPTO
> >  * dropped cfg->crypto_cap_idx argument from qcom_ice_program_key
> > 
> > Changes since v2:
> >  * added the suspend API call for ICE
> >  * kept old wrappers over ICE API in
> > 
> > Changes since v1:
> >  * Added a check for supported algorithm and key size
> >    and passed the ICE defined values for algorithm and key size
> >  * Added call to evict function
> > 
> >  drivers/mmc/host/Kconfig     |   2 +-
> >  drivers/mmc/host/sdhci-msm.c | 220 +++++++----------------------------
> >  2 files changed, 46 insertions(+), 176 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 4745fe217ade..09f837df5435 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -549,7 +549,7 @@ config MMC_SDHCI_MSM
> >  	depends on MMC_SDHCI_PLTFM
> >  	select MMC_SDHCI_IO_ACCESSORS
> >  	select MMC_CQHCI
> > -	select QCOM_SCM if MMC_CRYPTO
> > +	select QCOM_INLINE_CRYPTO_ENGINE if MMC_CRYPTO
> >  	help
> >  	  This selects the Secure Digital Host Controller Interface (SDHCI)
> >  	  support present in Qualcomm SOCs. The controller supports
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index 8ac81d57a3df..1a6e63b7af12 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -19,6 +19,8 @@
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/reset.h>
> >  
> > +#include <soc/qcom/ice.h>
> > +
> >  #include "sdhci-cqhci.h"
> >  #include "sdhci-pltfm.h"
> >  #include "cqhci.h"
> > @@ -258,12 +260,14 @@ struct sdhci_msm_variant_info {
> >  struct sdhci_msm_host {
> >  	struct platform_device *pdev;
> >  	void __iomem *core_mem;	/* MSM SDCC mapped address */
> > -	void __iomem *ice_mem;	/* MSM ICE mapped address (if available) */
> >  	int pwr_irq;		/* power irq */
> >  	struct clk *bus_clk;	/* SDHC bus voter clock */
> >  	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
> > -	/* core, iface, cal, sleep, and ice clocks */
> > -	struct clk_bulk_data bulk_clks[5];
> > +	/* core, iface, cal and sleep clocks */
> > +	struct clk_bulk_data bulk_clks[4];
> > +#ifdef CONFIG_MMC_CRYPTO
> > +	struct qcom_ice *ice;
> > +#endif
> 
> Similarly to the UFS patch, it is not clear that the calls to
> clk_prepare_enable() and clk_disable_unprepare() on the ICE clock are paired up
> anymore, with qcom_ice_enable() in particular seeming to be unpaired.  Perhaps
> it should continue to be enabled / disabled at the same time as the other host
> controller clocks are enabled / disabled?
> 
> Also, are you sure that the ICE clock is actually being found?
> drivers/soc/qcom/ice.c does:
> 
>         engine->core_clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(engine->core_clk))
>                 return ERR_CAST(engine->core_clk);
> 
> It is not clear how that can get the clock named "ice" from the device tree.

I guess here we need to do something like this:

	/* legacy consumers use different clk names, so try those first */
	engine->core_clk = devm_clk_get_optional_enabled(dev, "ice_core_clk");
	if (!engine->core_clk)
        	engine->core_clk = devm_clk_get_optional_enabled(dev, "ice");
	if (!engine->core_clk)
        	engine->core_clk = devm_clk_get_enabled(dev, NULL);

	if (IS_ERR(engine->core_clk))
        	return ERR_CAST(engine->core_clk);

This is because we have two different clock names in sdhc and ufs legacy
devicetree nodes.

> 
> - Eric
