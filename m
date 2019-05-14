Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB441C435
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENHyM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 03:54:12 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34986 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfENHyL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 03:54:11 -0400
Received: by mail-ua1-f66.google.com with SMTP id r7so60209ual.2
        for <linux-scsi@vger.kernel.org>; Tue, 14 May 2019 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf8IJjcdPrQOgX1z3j6gO2WdWT6UVn+L7AhNfe6yMi8=;
        b=IAsJ4EQAYOn036lV8psLdhXQfclTm/pOQHGolyhy+F/M9PN51UF1V/AzbmQ2+szdeA
         50WNp67zAeq6LM46Rm5S8gA77LBMEMw1JsVn/tpSuW3Fmn2xta1oG5hpd6oQAlItiBS0
         V7wGhDfi+6qvy0RGWnt2gDFdS1UQBmLgdXkSmdDpeafokFQHUZoUqTZIOHCETe6JfFAC
         a7PnXUppJHzhn2AVGetOalutM2jS6ypHR9488igXkCBQ8h9ghd/iSRHKRauDRdWVhy3O
         1dBuucve8gsrdUniXl3OAxGA0NC4JSN5HrSsxuOzyO7z9KI/68uSfGyLt3t1vA/hmfgL
         34qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf8IJjcdPrQOgX1z3j6gO2WdWT6UVn+L7AhNfe6yMi8=;
        b=HOkl4qnHxIwco4zZwRwxvZQSuG4yv91zv53lzOu4gzDt9zsULA82O+F8/dZxVt2JMB
         EpHYUnP2Qu8rS5Z7gDiz4R/YYrRpqAM+zwnETJED8pEbYXdquvUquBkw70eFWSFxy2Tr
         9dfv0NF4BquC1T+M96uLlE53vH5Vhsb6Tt9/NJhP8QBKyUunyBgh7WJYPvm3iVmBtVP1
         /wl4V2fpLx2uHi2JoHS0LXud9LlmZJORRXmwr7jujZDxkGanIK+7VRDXTLM/DHTNiyAK
         ilXYzz0nB9LxC6sHRSxZlHvrxRGnqjuTXYSXlCRYnC/aCvQx2Bt7nWuLdEDMHMpLZVmT
         6leg==
X-Gm-Message-State: APjAAAWS3BU35+befUHDiG4Y1hzN1EZ17t9Q9x5iq+J1Fey9xuX9yAXR
        AGeuAKMsZ9jBnNq4hYLer65CKDkiCR4Gih6T2/cCnw==
X-Google-Smtp-Source: APXvYqw26na4iAl9OES8/pXHjHR4OX/mYE4JxGMYMoMM698JgOYmYEnp2SYDxqwKYvDyL7iTIXPA7w04vcm/XFFuFFI=
X-Received: by 2002:ab0:30a1:: with SMTP id b1mr13121475uam.104.1557820450699;
 Tue, 14 May 2019 00:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190320094918.20234-1-rnayak@codeaurora.org> <20190320094918.20234-9-rnayak@codeaurora.org>
In-Reply-To: <20190320094918.20234-9-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 May 2019 09:53:34 +0200
Message-ID: <CAPDyKFppirfM7B9TB=jZzo67E=rdMnfVKEjdv0wn1zBAUoY_HA@mail.gmail.com>
Subject: Re: [RFC v2 08/11] arm64: dts: sdm845: Add ufs opps and power-domains
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 20 Mar 2019 at 10:50, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Add the additional power domain and the OPP table for ufs on sdm845
> so the driver can set the appropriate performance state of the
> power domain while setting the clock rate.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 027ffe6e93e8..a3af4a1757b4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1140,6 +1140,21 @@
>                         };
>                 };
>
> +               ufs_opp_table: ufs-opp-table {
> +                       compatible = "operating-points-v2";
> +
> +                       opp-50000000 {
> +                               opp-hz = /bits/ 64 <50000000>;
> +                               required-opps = <&rpmhpd_opp_min_svs>;
> +                       };
> +
> +                       opp-200000000 {
> +                               opp-hz = /bits/ 64 <200000000>;
> +                               required-opps = <&rpmhpd_opp_nom>;
> +
> +                       };
> +               };
> +
>                 ufs_mem_hc: ufshc@1d84000 {
>                         compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
>                                      "jedec,ufs-2.0";
> @@ -1148,7 +1163,7 @@
>                         phys = <&ufs_mem_phy_lanes>;
>                         phy-names = "ufsphy";
>                         lanes-per-direction = <2>;
> -                       power-domains = <&gcc UFS_PHY_GDSC>;
> +                       power-domains = <&gcc UFS_PHY_GDSC>, <&rpmhpd SDM845_CX>;

You probably want to use "power-domain-names" as well.

[...]

Kind regards
Uffe
