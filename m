Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99417964E
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Mar 2020 18:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgCDRIj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Mar 2020 12:08:39 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54338 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgCDRIi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Mar 2020 12:08:38 -0500
Received: by mail-pj1-f68.google.com with SMTP id np16so585790pjb.4
        for <linux-scsi@vger.kernel.org>; Wed, 04 Mar 2020 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=8GdpXC83WnCwjUZvBp/s6/1q0gpiaE1ET3LFQ1vYx80=;
        b=GUJPwqExB2W8m+wmfFej1Wu0jR+PqqrCLePScvd+ZRdg7ISZyrv04lA8ojqKla2HR4
         OXxi9a/E+2lNMDcu4q1y4jtP/+Yg6bNBjIqn8+1mXHmeBiq4ROu6dcgGVofhgA9zC5Bd
         RkduMTmCkRF8RZeOmAm5CVUtKSEbIH5S20aV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=8GdpXC83WnCwjUZvBp/s6/1q0gpiaE1ET3LFQ1vYx80=;
        b=sfG6QYKfQLKUpt6WFrzEnLZeUqu/8sWNPX8YzFy+zFLF6nP8NmcSSRfal9EwJ3cHyw
         yyK59zgDthbI4qdp9A2/ysPYt8nSfl0T6Ye6GAuCc0Kgn1QpJFUBksNPQBiSNtvV1VF/
         MyI9f5QADqV9DOHMfSuixvU/s5uF47hLqg+LqBemtMeUBYBYHmasS6x87raRpN9PGgYI
         HKgkOrgrzlQ+jLtZLh/wbplMokRDjeIOEGl+f2H3+9JJ5riPQqF84REOZjf5SlU1UsEI
         sx7ggq4pbMXSQah6pIRbbtiet1CfEhTFYGX6J0CD/CUPP9smjAaemfzVOB+8+0BFB3Oa
         v8uw==
X-Gm-Message-State: ANhLgQ0Ui/vtOAJTttmP3of6UZJXKOTmmZT1PGOA/OE31r31IKPRbk9J
        r1bxAKnX+9MbDbIiyPNKhALPGQ==
X-Google-Smtp-Source: ADFU+vtszHZ6sornx7c90TueL5qrMGJwPll/DLOlPUNlKhSDATQ9GE1wQfzBIuK1624Xb/HV/K7YCw==
X-Received: by 2002:a17:902:a511:: with SMTP id s17mr3702792plq.317.1583341716406;
        Wed, 04 Mar 2020 09:08:36 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q66sm30352538pfq.27.2020.03.04.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:08:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200304064942.371978-3-ebiggers@kernel.org>
References: <20200304064942.371978-1-ebiggers@kernel.org> <20200304064942.371978-3-ebiggers@kernel.org>
Subject: Re: [RFC PATCH v2 2/4] arm64: dts: sdm845: add Inline Crypto Engine registers and clock
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Can Guo <cang@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Date:   Wed, 04 Mar 2020 09:08:34 -0800
Message-ID: <158334171487.7173.5606223900174949177@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Quoting Eric Biggers (2020-03-03 22:49:40)
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index d42302b8889b..dd6b4e596fcf 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1367,7 +1367,9 @@ system-cache-controller@1100000 {
>                 ufs_mem_hc: ufshc@1d84000 {
>                         compatible =3D "qcom,sdm845-ufshc", "qcom,ufshc",
>                                      "jedec,ufs-2.0";
> -                       reg =3D <0 0x01d84000 0 0x2500>;
> +                       reg =3D <0 0x01d84000 0 0x2500>,
> +                             <0 0 0 0>,
> +                             <0 0x01d90000 0 0x8000>;

Nothing against this patch but the binding for ufs is really awful. It
doesn't indicate what the order of registers are, doesn't list what clks
are supposed to be there, has weird microamp properties that make no
sense, and has a freq-table-hz property that is almost always full of
zeroes because the driver is written in some weird qcom specific way.

It would be great to fix this binding and convert it to YAML so that we
can drop the cruft and clearly describe why this patch needs to
introduce a reg property that is all zeroes.

>                         interrupts =3D <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>                         phys =3D <&ufs_mem_phy_lanes>;
>                         phy-names =3D "ufsphy";
> @@ -1387,7 +1389,8 @@ ufs_mem_hc: ufshc@1d84000 {
>                                 "ref_clk",
>                                 "tx_lane0_sync_clk",
>                                 "rx_lane0_sync_clk",
> -                               "rx_lane1_sync_clk";
> +                               "rx_lane1_sync_clk",
> +                               "ice_core_clk";

Would be great to drop _clk postfix on all of these.

>                         clocks =3D
>                                 <&gcc GCC_UFS_PHY_AXI_CLK>,
>                                 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> @@ -1396,7 +1399,8 @@ ufs_mem_hc: ufshc@1d84000 {
>                                 <&rpmhcc RPMH_CXO_CLK>,
>                                 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>                                 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> -                               <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +                               <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
> +                               <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>                         freq-table-hz =3D
>                                 <50000000 200000000>,
>                                 <0 0>,
> @@ -1405,7 +1409,8 @@ ufs_mem_hc: ufshc@1d84000 {
>                                 <0 0>,
>                                 <0 0>,
>                                 <0 0>,
> -                               <0 0>;
> +                               <0 0>,
> +                               <0 300000000>;

This can probably be done with assigned-clock-rates, but the driver is
bad.
