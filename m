Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293DD1C8B17
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEGMhD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgEGMhC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 May 2020 08:37:02 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25086C05BD43
        for <linux-scsi@vger.kernel.org>; Thu,  7 May 2020 05:37:02 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so4500329qtv.3
        for <linux-scsi@vger.kernel.org>; Thu, 07 May 2020 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=la/m9IDgYiDQ/q3IBApyXuSC1pAhYEOZPWk5FvFdljA=;
        b=Dgt2tIERZoI1Yds/292I9qQtO/9G5DUvnRc6x9O4xaF5YozIqDZv4+evdDYhnutMvn
         NMhpYfh+VJz2oNTUrh0hsriZjuqa6m+XfnsEziZHcp0mIEz0Y8dkBzpjWHMaU3UpdOBA
         Az8Y92UXCANst8aAiUwpT8v427Lq5XXvxRGi4KXzjURCoiiCa8S9j3AemzaNZtjhHxub
         JM7VGL6CiZelHlg9Xa52wvUxuHFp5hvFjbaui0eHCJK0lJ0JtcAcDqYpNJagaFG3RVv5
         UwhuBoHRp3E1nyiQEPkDxrVySxUq0uWdbrdwOSjoKzO5U9Hnc6tgOI7eYmdT6Yo9Mxqj
         4oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=la/m9IDgYiDQ/q3IBApyXuSC1pAhYEOZPWk5FvFdljA=;
        b=FL/i1O3bL/MP/WjbAcdb98wCj64/pBaLQ7jxFXz99lmc93siFb/dPuXrt185JLML4M
         9/8mEwwDLQQi8nnuN9HcIussh2Ky/ssFmJ+X3zR7cUtHVGmPBDwcEj5lqUeVoc/mWanw
         q/Avh4setw+UbEWblMjeiCD5eEzG/cMK9M0OhOiZ3y0D6i9Q2/Yy7RutwZDa88q3Avy+
         i+GC0A8tdY14xnIn3k8qwH8kShw5D6p3pBjtkCjPTivUEcsmy83RFJVkOg3ijpNBHu6Y
         w138nIx9mYYr6luYeAM1qyT4ySSEWbuhB+Kn4hneFCsW7f54bgOHyghGOEeI3rAg1FgK
         C/Mg==
X-Gm-Message-State: AGi0Puby9ViygTI8QYQZsb6Pv8j49By27YO7g6jgOXzE2rge5AR66JsA
        tjK5JsoTiUQMcbVKI5Yr1k7xqg==
X-Google-Smtp-Source: APiQypIOeHqxv/9Yfdkc5Vb7c69B0TdEVdHzI/dWGsqZejx7ebM5N/fGufHln/5YR0jdsHH+rsuRJw==
X-Received: by 2002:ac8:776f:: with SMTP id h15mr13768458qtu.36.1588855021165;
        Thu, 07 May 2020 05:37:01 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id g127sm4119173qkb.6.2020.05.07.05.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 05:37:00 -0700 (PDT)
Subject: Re: [RFC PATCH v4 4/4] scsi: ufs-qcom: add Inline Crypto Engine
 support
To:     Eric Biggers <ebiggers@kernel.org>, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Can Guo <cang@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Satya Tangirala <satyat@google.com>
References: <20200501045111.665881-1-ebiggers@kernel.org>
 <20200501045111.665881-5-ebiggers@kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <31fa95e5-7757-96ae-2e86-1f54959e3a6c@linaro.org>
Date:   Thu, 7 May 2020 08:36:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501045111.665881-5-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 5/1/20 12:51 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for Qualcomm Inline Crypto Engine (ICE) to ufs-qcom.
> 
> The standards-compliant parts, such as querying the crypto capabilities
> and enabling crypto for individual UFS requests, are already handled by
> ufshcd-crypto.c, which itself is wired into the blk-crypto framework.
> However, ICE requires vendor-specific init, enable, and resume logic,
> and it requires that keys be programmed and evicted by vendor-specific
> SMC calls.  Make the ufs-qcom driver handle these details.
> 
> I tested this on Dragonboard 845c, which is a publicly available
> development board that uses the Snapdragon 845 SoC and runs the upstream
> Linux kernel.  This is the same SoC used in the Pixel 3 and Pixel 3 XL
> phones.  This testing included (among other things) verifying that the
> expected ciphertext was produced, both manually using ext4 encryption
> and automatically using a block layer self-test I've written.
Hello Eric,

I am interested in testing out this series on 845, 855 and if possile on 
865 platforms. Can you give me some more details about your testing please.

> 
> This driver also works nearly as-is on Snapdragon 765 and Snapdragon
> 865, which are very recent SoCs, having just been announced in Dec 2019
> (though these newer SoCs currently lack upstream kernel support).
> 
> This is based very loosely on the vendor-provided driver in the kernel
> source code for the Pixel 3, but I've greatly simplified it.  Also, for
> now I've only included support for major version 3 of ICE, since that's
> all I have the hardware to test with the mainline kernel.  Plus it
> appears that version 3 is easier to use than older versions of ICE.
> 
> For now, only allow using AES-256-XTS.  The hardware also declares
> support for AES-128-XTS, AES-{128,256}-ECB, and AES-{128,256}-CBC
> (BitLocker variant).  But none of these others are really useful, and
> they'd need to be individually tested to be sure they worked properly.
> 
> This commit also changes the name of the loadable module from "ufs-qcom"
> to "ufs_qcom", as this is necessary to compile it from multiple source
> files (unless we were to rename ufs-qcom.c).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   MAINTAINERS                     |   2 +-
>   drivers/scsi/ufs/Kconfig        |   1 +
>   drivers/scsi/ufs/Makefile       |   4 +-
>   drivers/scsi/ufs/ufs-qcom-ice.c | 245 ++++++++++++++++++++++++++++++++
>   drivers/scsi/ufs/ufs-qcom.c     |  12 +-
>   drivers/scsi/ufs/ufs-qcom.h     |  27 ++++
>   6 files changed, 288 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/scsi/ufs/ufs-qcom-ice.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26f281d9f32a4a..cab5fe76784592 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2236,7 +2236,7 @@ F:	drivers/pci/controller/dwc/pcie-qcom.c
>   F:	drivers/phy/qualcomm/
>   F:	drivers/power/*/msm*
>   F:	drivers/reset/reset-qcom-*
> -F:	drivers/scsi/ufs/ufs-qcom.*
> +F:	drivers/scsi/ufs/ufs-qcom*
>   F:	drivers/spi/spi-geni-qcom.c
>   F:	drivers/spi/spi-qcom-qspi.c
>   F:	drivers/spi/spi-qup.c
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index 5ed3f209f88100..c1a94d99e161ee 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -99,6 +99,7 @@ config SCSI_UFS_DWC_TC_PLATFORM
>   config SCSI_UFS_QCOM
>   	tristate "QCOM specific hooks to UFS controller platform driver"
>   	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
> +	select QCOM_SCM
>   	select RESET_CONTROLLER
>   	help
>   	  This selects the QCOM specific additions to UFSHCD platform driver.
> diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
> index 197e178f44bce3..13fda1b697b2a2 100644
> --- a/drivers/scsi/ufs/Makefile
> +++ b/drivers/scsi/ufs/Makefile
> @@ -3,7 +3,9 @@
>   obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) += tc-dwc-g210-pci.o ufshcd-dwc.o tc-dwc-g210.o
>   obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-dwc-g210.o
>   obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
> -obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
> +obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
> +ufs_qcom-y += ufs-qcom.o
> +ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
>   obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
>   ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
>   ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
> diff --git a/drivers/scsi/ufs/ufs-qcom-ice.c b/drivers/scsi/ufs/ufs-qcom-ice.c
> new file mode 100644
> index 00000000000000..9e837fdcb0ac2b
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufs-qcom-ice.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Qualcomm ICE (Inline Crypto Engine) support.
> + *
> + * Copyright (c) 2014-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2019 Google LLC
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/qcom_scm.h>
> +
> +#include "ufshcd-crypto.h"
> +#include "ufs-qcom.h"
> +
> +#define AES_256_XTS_KEY_SIZE			64
> +
> +/* QCOM ICE registers */
> +
> +#define QCOM_ICE_REG_CONTROL			0x0000
> +#define QCOM_ICE_REG_RESET			0x0004
> +#define QCOM_ICE_REG_VERSION			0x0008
> +#define QCOM_ICE_REG_FUSE_SETTING		0x0010
> +#define QCOM_ICE_REG_PARAMETERS_1		0x0014
> +#define QCOM_ICE_REG_PARAMETERS_2		0x0018
> +#define QCOM_ICE_REG_PARAMETERS_3		0x001C
> +#define QCOM_ICE_REG_PARAMETERS_4		0x0020
> +#define QCOM_ICE_REG_PARAMETERS_5		0x0024
> +
> +/* QCOM ICE v3.X only */
> +#define QCOM_ICE_GENERAL_ERR_STTS		0x0040
> +#define QCOM_ICE_INVALID_CCFG_ERR_STTS		0x0030
> +#define QCOM_ICE_GENERAL_ERR_MASK		0x0044
> +
> +/* QCOM ICE v2.X only */
> +#define QCOM_ICE_REG_NON_SEC_IRQ_STTS		0x0040
> +#define QCOM_ICE_REG_NON_SEC_IRQ_MASK		0x0044
> +
> +#define QCOM_ICE_REG_NON_SEC_IRQ_CLR		0x0048
> +#define QCOM_ICE_REG_STREAM1_ERROR_SYNDROME1	0x0050
> +#define QCOM_ICE_REG_STREAM1_ERROR_SYNDROME2	0x0054
> +#define QCOM_ICE_REG_STREAM2_ERROR_SYNDROME1	0x0058
> +#define QCOM_ICE_REG_STREAM2_ERROR_SYNDROME2	0x005C
> +#define QCOM_ICE_REG_STREAM1_BIST_ERROR_VEC	0x0060
> +#define QCOM_ICE_REG_STREAM2_BIST_ERROR_VEC	0x0064
> +#define QCOM_ICE_REG_STREAM1_BIST_FINISH_VEC	0x0068
> +#define QCOM_ICE_REG_STREAM2_BIST_FINISH_VEC	0x006C
> +#define QCOM_ICE_REG_BIST_STATUS		0x0070
> +#define QCOM_ICE_REG_BYPASS_STATUS		0x0074
> +#define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
> +#define QCOM_ICE_REG_ENDIAN_SWAP		0x1004
> +#define QCOM_ICE_REG_TEST_BUS_CONTROL		0x1010
> +#define QCOM_ICE_REG_TEST_BUS_REG		0x1014
> +
> +/* BIST ("built-in self-test"?) status flags */
> +#define QCOM_ICE_BIST_STATUS_MASK		0xF0000000
> +
> +#define QCOM_ICE_FUSE_SETTING_MASK		0x1
> +#define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
> +#define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
> +
> +#define qcom_ice_writel(host, val, reg)	\
> +	writel((val), (host)->ice_mmio + (reg))
> +#define qcom_ice_readl(host, reg)	\
> +	readl((host)->ice_mmio + (reg))
> +
> +static bool qcom_ice_supported(struct ufs_qcom_host *host)
> +{
> +	struct device *dev = host->hba->dev;
> +	u32 regval = qcom_ice_readl(host, QCOM_ICE_REG_VERSION);
> +	int major = regval >> 24;
> +	int minor = (regval >> 16) & 0xFF;
> +	int step = regval & 0xFFFF;
> +
> +	/* For now this driver only supports ICE version 3. */
> +	if (major != 3) {
> +		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
> +			 major, minor, step);
> +		return false;
> +	}
> +
> +	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
> +		 major, minor, step);
> +
> +	/* If fuses are blown, ICE might not work in the standard way. */
> +	regval = qcom_ice_readl(host, QCOM_ICE_REG_FUSE_SETTING);
> +	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
> +		      QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
> +		      QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
> +		dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
> +		return false;
> +	}
> +	return true;
> +}
> +
> +int ufs_qcom_ice_init(struct ufs_qcom_host *host)
> +{
> +	struct ufs_hba *hba = host->hba;
> +	struct device *dev = hba->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +	int err;
> +
> +	if (!(ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES) &
> +	      MASK_CRYPTO_SUPPORT))
> +		return 0;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	if (!res) {
> +		dev_warn(dev, "ICE registers not found\n");
> +		goto disable;
> +	}
> +
> +	if (!qcom_scm_ice_available()) {
> +		dev_warn(dev, "ICE SCM interface not found\n");
> +		goto disable;
> +	}
> +
> +	host->ice_mmio = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(host->ice_mmio)) {
> +		err = PTR_ERR(host->ice_mmio);
> +		dev_err(dev, "Failed to map ICE registers; err=%d\n", err);
> +		return err;
> +	}
> +
> +	if (!qcom_ice_supported(host))
> +		goto disable;
> +
> +	return 0;
> +
> +disable:
> +	dev_warn(dev, "Disabling inline encryption support\n");
> +	hba->caps &= ~UFSHCD_CAP_CRYPTO;
> +	return 0;
> +}
> +
> +static void qcom_ice_low_power_mode_enable(struct ufs_qcom_host *host)
> +{
> +	u32 regval;
> +
> +	regval = qcom_ice_readl(host, QCOM_ICE_REG_ADVANCED_CONTROL);
> +	/*
> +	 * Enable low power mode sequence
> +	 * [0]-0, [1]-0, [2]-0, [3]-E, [4]-0, [5]-0, [6]-0, [7]-0
> +	 */
> +	regval |= 0x7000;
> +	qcom_ice_writel(host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
> +}
> +
> +static void qcom_ice_optimization_enable(struct ufs_qcom_host *host)
> +{
> +	u32 regval;
> +
> +	/* ICE Optimizations Enable Sequence */
> +	regval = qcom_ice_readl(host, QCOM_ICE_REG_ADVANCED_CONTROL);
> +	regval |= 0xD807100;
> +	/* ICE HPG requires delay before writing */
> +	udelay(5);
> +	qcom_ice_writel(host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
> +	udelay(5);
> +}
> +
> +int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
> +{
> +	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
> +		return 0;
> +	qcom_ice_low_power_mode_enable(host);
> +	qcom_ice_optimization_enable(host);
> +	return ufs_qcom_ice_resume(host);
> +}
> +
> +/* Poll until all BIST bits are reset */
> +static int qcom_ice_wait_bist_status(struct ufs_qcom_host *host)
> +{
> +	int count;
> +	u32 reg;
> +
> +	for (count = 0; count < 100; count++) {
> +		reg = qcom_ice_readl(host, QCOM_ICE_REG_BIST_STATUS);
> +		if (!(reg & QCOM_ICE_BIST_STATUS_MASK))
> +			break;
> +		udelay(50);
> +	}
> +	if (reg)
> +		return -ETIMEDOUT;
> +	return 0;
> +}
> +
> +int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
> +{
> +	int err;
> +
> +	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
> +		return 0;
> +
> +	err = qcom_ice_wait_bist_status(host);
> +	if (err) {
> +		dev_err(host->hba->dev, "BIST status error (%d)\n", err);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
> + * vendor-specific SCM calls for this; it doesn't support the standard way.
> + */
> +int ufs_qcom_ice_program_key(struct ufs_hba *hba,
> +			     const union ufs_crypto_cfg_entry *cfg, int slot)
> +{
> +	union ufs_crypto_cap_entry cap;
> +	union {
> +		u8 bytes[AES_256_XTS_KEY_SIZE];
> +		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> +	} key;
> +	int i;
> +	int err;
Should there not be a check for here ?
	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
		return 0;


-- 
Warm Regards
Thara
