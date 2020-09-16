Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE64326C1F6
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgIPK6V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Sep 2020 06:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgIPKeg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 16 Sep 2020 06:34:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E4C061797;
        Wed, 16 Sep 2020 03:34:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o8so9580121ejb.10;
        Wed, 16 Sep 2020 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5frHr5GaHOWTlO1WZeDNHTiXmR3D2Lj1pukjlnONUdQ=;
        b=ZF998Rh92pZaLx0yq3SFfj6Wv8CwwAaADizquqRJgU3jPJkxOnQ9Bpn4ZzMyM2Qmdk
         ZB9mHTbgKbPBVdtfaOBzExDfksf3SIg4Rck7plmMRh1qhICZ0beYDd4BqorWRwQE0LDF
         E/wY3ol2z3sv69HCDLZrxs8kF7RgKApFYIRkLytzfEOKOMPYedgbHTZfIdi3xBJkv0BN
         TjdnDZTUnTRecfZ89bbysSNp34lYcSINk6c46g7iApAcGgkuIBoy+uRilJByrhkNLMKz
         WL9jlusijA1vNX/oWxFPrHKURiGJTyRN4K+QES0aIWu5f7v0Un2t1ATCyoFPI7BuFuVZ
         6iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5frHr5GaHOWTlO1WZeDNHTiXmR3D2Lj1pukjlnONUdQ=;
        b=jljFYdL1/4MQmA35Z88cUO+/bBV4ZrI3pqjRHYlb7PAVRXAX1GqmyZwbSmn9Rvl1PI
         zrZtCfPjO56LxsWWR1Z3ngc7V4PuETit9EtgI7nXTy4EEOQqCh45t95C4icjPTwDwRHG
         JWFRCiFSwCmpR/IClt3u1TEzkTBwoW3yHdbD9023AVTn/neAyKipyB1cyQ95M926Rwu0
         ZQbk+UZhs7epnAXJTh3Qgt9YoyhYaZeG9oWZHLWiCK4fOsDk8U/MzDt26R22fqodR8D5
         dsrnUMdAhGpXCw03cd4N9IOjHR61rDexXbIfyfaRTs3ur1uo3Kn+jOoY0SRwqPkR1JFF
         SRCw==
X-Gm-Message-State: AOAM533F4w8zV5fi+tMzXjesSo154AyXyUsJLq3JVcN7+0ouKvaXe3DW
        p7bNUKuTxRZWjmx/bigPxQc=
X-Google-Smtp-Source: ABdhPJwjA2TsI0J+RUHNzfcNYiECiHgKCfxYsCNWlrOtld1vPZldVDeBtAuOu+S2NQ0O1nO4UoqmXw==
X-Received: by 2002:a17:906:c113:: with SMTP id do19mr24032408ejc.219.1600252464932;
        Wed, 16 Sep 2020 03:34:24 -0700 (PDT)
Received: from ubuntu-laptop ([2a01:598:b890:270b:75d6:3bdd:1167:483e])
        by smtp.googlemail.com with ESMTPSA id t10sm13858135edw.86.2020.09.16.03.34.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 03:34:24 -0700 (PDT)
Message-ID: <bdc48d03dae86abef158aa33468f6c2f8e669ce8.camel@gmail.com>
Subject: Re: [PATCH 5/6] scsi: ufs: show ufs part info in error case
From:   Bean Huo <huobean@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        Can Guo <cang@codeaurora.org>
Cc:     Jaegeuk Kim <jaegeuk@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Date:   Wed, 16 Sep 2020 12:34:23 +0200
In-Reply-To: <20200915204532.1672300-5-jaegeuk@kernel.org>
References: <20200915204532.1672300-1-jaegeuk@kernel.org>
         <20200915204532.1672300-5-jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2020-09-15 at 13:45 -0700, Jaegeuk Kim wrote:
> Cc: Avri Altman <avri.altman@wdc.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index bdc82cc3824aa..b81c116b976ff 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -500,6 +500,14 @@ static void ufshcd_print_tmrs(struct ufs_hba
> *hba, unsigned long bitmap)
>  static void ufshcd_print_host_state(struct ufs_hba *hba)
>  {
>         dev_err(hba->dev, "UFS Host state=%d\n", hba->ufshcd_state);
> +       if (hba->sdev_ufs_device) {
> +               dev_err(hba->dev, " vendor = %.8s\n",
> +                                       hba->sdev_ufs_device-
> >vendor);
> +               dev_err(hba->dev, " model = %.16s\n",
> +                                       hba->sdev_ufs_device->model);
> +               dev_err(hba->dev, " rev = %.4s\n",
> +                                       hba->sdev_ufs_device->rev);
> +       }

Hi Jaegeuk
these prints have been added since this change:

commit 3f8af6044713 ("scsi: ufs: Add some debug information to
ufshcd_print_host_state()")                

https://patchwork.kernel.org/patch/11694371/

Thanks,
Bean

