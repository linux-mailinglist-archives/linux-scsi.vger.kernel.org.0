Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6197E4A76E
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfFRQqm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 12:46:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42990 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfFRQqm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 12:46:42 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so31326527ior.9
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwFihAPGP6wzOK+kBPKAQVi7liUgqZUIPSL5DDnHSPo=;
        b=m+AzwmOJvaqda0PA4A3kH50zB/aKuXYTJXIq2ncP7kss8pwIRCHarGkn0vn0qekVXg
         DMvb6pe/4kCyyxBZ0fX6xNUPYpe8TkJznF4Xt5mjwezAwrKDdVHPHi+iGXsTVh1P0fVZ
         Vqxp87twM29o0lYzD1QiCTokXsk0tq1+P/Gw/KhCbI2C3EuwnBd8nWLPjfxOimKybbu5
         EBdlMIp+hKFR9yU3ccN5od4zBL16bzc3l8xbpURoquyppmDLUFjdHZbKNucs4GoVV3eS
         RwEdZXgKKJ8mrz//9UiPKQTRkBIeWaeNORJngOoJEynz57Wh/WpkxK8md8YA59mWm5ok
         dELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwFihAPGP6wzOK+kBPKAQVi7liUgqZUIPSL5DDnHSPo=;
        b=FbnevKN7NdsuK4ivx9lS4OMSdZNFS+4Tvz8j6tuxYPu411MOPSpmP1s3lwwQfWpgE0
         NTCK0FCcwy6C/HVxz5Rre7c6f6TskwuobHQzrLgQKO0QSsjNJh+A86WyC3WXUcbZq8VI
         QwpbuvHqYigk7SkNHWRzie667zCdkQUphF82fLx2vM3jkIqa0U8fDNb0hGM/sUHu48Oi
         oQZ0PK3a7/iAkWp9U1ml3FdkNS9V2J6btQ0HnR050yPMVXnD7BIBGaktgx6/9YZku7NX
         DNiKiMIjFbsZqn4MwC5r0OzlzX8ieEOHWc7+GeUYnVgRb5Pg+xn7PS+VI1B3rE2CJe/p
         tRAg==
X-Gm-Message-State: APjAAAV9XJE4W9snb6tkWJUtbjsUtgC8RSq6yJdT2c+TaiSl4XgEfE43
        8J6m1XxgFQS2Kwj3XH3Pz8JSWPm3Rtx7vHv5zAW1wA==
X-Google-Smtp-Source: APXvYqwfP4H5Qtjk8/J7nRjXv99FeQJa7fltAX57cFgZoswJDUwAV1Fen3fMy8Mm2DooyBSWOFHO5G5QFo8XfTvex1M=
X-Received: by 2002:a02:1a86:: with SMTP id 128mr91068852jai.95.1560876401463;
 Tue, 18 Jun 2019 09:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190617115454.3226-1-lee.jones@linaro.org>
In-Reply-To: <20190617115454.3226-1-lee.jones@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 18 Jun 2019 18:46:29 +0200
Message-ID: <CAKv+Gu_qd9KrXHVSVHCoM42D8ACjU5onzFGJPTTBGOsVJpeayg@mail.gmail.com>
Subject: Re: [PATCH 1/1] scsi: ufs-qcom: Add support for platforms booting ACPI
To:     Lee Jones <lee.jones@linaro.org>
Cc:     agross@kernel.org, David Brown <david.brown@linaro.org>,
        alim.akhtar@samsung.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 17 Jun 2019 at 13:55, Lee Jones <lee.jones@linaro.org> wrote:
>
> New Qualcomm AArch64 based laptops are now available which use UFS
> as their primary data storage medium.  These devices are supplied
> with ACPI support out of the box.  This patch ensures the Qualcomm
> UFS driver will be bound when the "QCOM24A5" H/W device is
> advertised as present.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/scsi/ufs/ufs-qcom.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 3aeadb14aae1..364af6a63e35 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -12,6 +12,7 @@
>   *
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/time.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -164,6 +165,9 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>         int err = 0;
>         struct device *dev = host->hba->dev;
>
> +       if (has_acpi_companion(dev))
> +               return 0;
> +
>         err = ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
>                                         &host->rx_l0_sync_clk, false);
>         if (err)
> @@ -1208,9 +1212,13 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>                         __func__, err);
>                 goto out_variant_clear;
>         } else if (IS_ERR(host->generic_phy)) {
> -               err = PTR_ERR(host->generic_phy);
> -               dev_err(dev, "%s: PHY get failed %d\n", __func__, err);
> -               goto out_variant_clear;
> +               if (has_acpi_companion(dev)) {
> +                       host->generic_phy = NULL;
> +               } else {
> +                       err = PTR_ERR(host->generic_phy);
> +                       dev_err(dev, "%s: PHY get failed %d\n", __func__, err);
> +                       goto out_variant_clear;
> +               }
>         }
>
>         err = ufs_qcom_bus_register(host);
> @@ -1680,6 +1688,14 @@ static const struct of_device_id ufs_qcom_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ufs_qcom_of_match);
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id ufs_qcom_acpi_match[] = {
> +       { "QCOM24A5" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, ufs_qcom_acpi_match);
> +#endif
> +
>  static const struct dev_pm_ops ufs_qcom_pm_ops = {
>         .suspend        = ufshcd_pltfrm_suspend,
>         .resume         = ufshcd_pltfrm_resume,
> @@ -1696,6 +1712,7 @@ static struct platform_driver ufs_qcom_pltform = {
>                 .name   = "ufshcd-qcom",
>                 .pm     = &ufs_qcom_pm_ops,
>                 .of_match_table = of_match_ptr(ufs_qcom_of_match),
> +               .acpi_match_table = ACPI_PTR(ufs_qcom_acpi_match),
>         },
>  };
>  module_platform_driver(ufs_qcom_pltform);
> --
> 2.17.1
>
