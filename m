Return-Path: <linux-scsi+bounces-101-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF37F5F32
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Nov 2023 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05BF281BDB
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Nov 2023 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2624A04
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Nov 2023 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8uSfDY9"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCC1D40
	for <linux-scsi@vger.kernel.org>; Thu, 23 Nov 2023 04:35:20 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cd81e76164so3283197b3.1
        for <linux-scsi@vger.kernel.org>; Thu, 23 Nov 2023 04:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700742920; x=1701347720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=arHyqDfyH7KFMD6czCTV+62FcJUm4QhPqwne2MS4bko=;
        b=l8uSfDY9uLF5Y7DeN5ZYrDc34K9tQuhWdOj6FiyNs9bH/jr0wjSTR5W3Pt7gQspFDK
         rFC9gbxJnAkDlUPs0EfDa9QCKXBuZJR4HIvXS0CRgo2SkmpiuWdCWx4o6SEiz0sdVAeL
         wVSE4iRXOpGfQoMEkjr9eYJPfvWHK634nYK7v5/pkZlSNbL1WyToxrP9QEagv0pFabJA
         XrS+tV2K0BsiZp1V/mhRxYlSRE1wwTbdHeaMfDlgudJTb+fwH8YQnRuu94BPIeWybhya
         /Qf3W8A3FzUxfjFwyOguFpwdNHZyjupLQvYRHhA6QQ7w8ItQ29+UZ94/pKi+AT04swQ3
         7Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700742920; x=1701347720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arHyqDfyH7KFMD6czCTV+62FcJUm4QhPqwne2MS4bko=;
        b=vkQQGGJqsv9r3uU/JCtIhXRahCdUj1gDaKLpfUHs+tYFyETDamcem3Y7Z2E3ouH/+A
         XiCWg3BPp+kH/5aOH6wmBcKETUvxOX5CRkVX9MyMFDOLgMsb1twbwV6dnsdF347JgBFW
         XkrFFrq7ZD+zIFBR+oFtuMauKnq5Il+qIojTaHYGr+jRBYzrMW0UGcAbiWu+YucfF7EO
         1op41lz4HAZ1SDGqAx/iahGBFtDuluFSLt9DdV7Q3OTsB9EtOt9FNMwn8onJMbhus6J/
         02HiR8bOWwLxh+uEkuMgt06+ly6PL4acfr+TO/YZQfSkCHoOgK9WI1p0O0nt/6G1jpKN
         1nTQ==
X-Gm-Message-State: AOJu0YzhIPmpDUqMvCKsBOaUSrOa9oFMvN3aypdTs4QH6NoZQYHei9y4
	1bapSgx2fjomeI9wOw68od7H/cexcwVzV9zfe03fyw==
X-Google-Smtp-Source: AGHT+IFfMqLYiJyHVbn/1hxWzSJv2rk6JxytcY8QE2rE+CQ4ckPMdfnLCaDN2Y7lp9Ydga986j3xdBr6XbsSGmo7NxQ=
X-Received: by 2002:a05:690c:338c:b0:5cc:d0bc:fc2b with SMTP id
 fl12-20020a05690c338c00b005ccd0bcfc2bmr3768759ywb.17.1700742920018; Thu, 23
 Nov 2023 04:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com> <1700729190-17268-10-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1700729190-17268-10-git-send-email-quic_cang@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 23 Nov 2023 14:35:08 +0200
Message-ID: <CAA8EJpouw-tu+Kz7ExQo+x1p5+fxqRzj=8fZY8GCM6fxB_USYw@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
To: Can Guo <quic_cang@quicinc.com>
Cc: bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com, 
	beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com, 
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 10:47, Can Guo <quic_cang@quicinc.com> wrote:
>
> On SM8550, two sets of UFS PHY settings are provided, one set is to support
> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
> settings are programming different values to different registers, mixing
> the two sets and/or overwriting one set with another set is definitely not
> blessed by UFS PHY designers.
>
> To add HS-G5 support for SM8550, split the two sets of PHY settings into
> their dedicated overlay tables, only the common parts of the two sets of
> PHY settings are left in the .tbls.
>
> Consider we are going to add even higher gear support in future, to avoid
> adding more tables with different names, rename the .tbls_hs_g4 and make it
> an array, a size of 2 is enough as of now.
>
> In this case, .tbls alone is not a complete set of PHY settings, so either
> tbls_hs_overlay[0] or tbls_hs_overlay[1] must be applied on top of the
> .tbls to become a complete set of PHY settings.
>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   9 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 174 ++++++++++++++++++---
>  4 files changed, 166 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> index c23d5e4..e563af5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> @@ -18,6 +18,7 @@
>  #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL            0x060
>  #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY           0x074
>  #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY           0x0bc
> +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY        0x12c
>  #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL               0x158
>  #define QPHY_V6_PCS_UFS_LINECFG_DISABLE                        0x17c
>  #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME            0x184
> @@ -27,5 +28,6 @@
>  #define QPHY_V6_PCS_UFS_READY_STATUS                   0x1a8
>  #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1              0x1f4
>  #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1               0x1fc
> +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME         0x220
>
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> index f420f8f..ef392ce 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> @@ -56,6 +56,8 @@
>  #define QSERDES_V6_COM_SYS_CLK_CTRL                            0xe4
>  #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE                       0xe8
>  #define QSERDES_V6_COM_PLL_IVCO                                        0xf4
> +#define QSERDES_V6_COM_CMN_IETRIM                              0xfc
> +#define QSERDES_V6_COM_CMN_IPTRIM                              0x100
>  #define QSERDES_V6_COM_SYSCLK_EN_SEL                           0x110
>  #define QSERDES_V6_COM_RESETSM_CNTRL                           0x118
>  #define QSERDES_V6_COM_LOCK_CMP_EN                             0x120
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> index 674f158..48f31c8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> @@ -15,8 +15,15 @@
>
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2          0x08
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4          0x10
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4          0x24
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4       0x54
>  #define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2                   0xd4
> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4                   0xdc
> +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4                   0xf0
> +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS                     0xf4
>  #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL                      0x178
> +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1             0x1bc
> +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3                        0x1c4
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0                     0x208
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1                     0x20c
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3                     0x214
> @@ -28,6 +35,8 @@
>  #define QSERDES_UFS_V6_RX_MODE_RATE3_B5                                0x264
>  #define QSERDES_UFS_V6_RX_MODE_RATE3_B8                                0x270
>  #define QSERDES_UFS_V6_RX_MODE_RATE4_B3                                0x280
> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4                                0x284
>  #define QSERDES_UFS_V6_RX_MODE_RATE4_B6                                0x28c
> +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL                      0x2f8
>
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index ad91f92..29106ec 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -41,6 +41,8 @@
>
>  #define PHY_INIT_COMPLETE_TIMEOUT              10000
>
> +#define NUM_OVERLAY                            2
> +
>  struct qmp_phy_init_tbl {
>         unsigned int offset;
>         unsigned int val;
> @@ -649,15 +651,22 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
> @@ -666,19 +675,24 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
>  };
>
> -static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_serdes[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x1b),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x1c),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
>  };
>
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_tx[] = {
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
>  };
>
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
> -       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
>
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
> @@ -694,16 +708,45 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>         QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
>  };
>
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_rx[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_rx[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0c),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS, 0x07),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3, 0x0e),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x1c),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B3, 0xb9),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B4, 0x4f),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B6, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> -       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_pcs[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
>         QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
>  };
>
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_pcs[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4f),
> +       QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
> +};
> +
>  struct qmp_ufs_offsets {
>         u16 serdes;
>         u16 pcs;
> @@ -723,6 +766,8 @@ struct qmp_phy_cfg_tbls {
>         int rx_num;
>         const struct qmp_phy_init_tbl *pcs;
>         int pcs_num;
> +       /* Maximum supported Gear of this tbls */
> +       u32 max_gear;
>  };
>
>  /* struct qmp_phy_cfg - per-PHY initialization config */
> @@ -730,13 +775,15 @@ struct qmp_phy_cfg {
>         int lanes;
>
>         const struct qmp_ufs_offsets *offsets;
> +       /* Maximum supported Gear of this config */
> +       u32 max_supported_gear;
>
>         /* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>         const struct qmp_phy_cfg_tbls tbls;
>         /* Additional sequence for HS Series B */
>         const struct qmp_phy_cfg_tbls tbls_hs_b;
> -       /* Additional sequence for HS G4 */
> -       const struct qmp_phy_cfg_tbls tbls_hs_g4;
> +       /* Additional sequence for different HS Gears */
> +       const struct qmp_phy_cfg_tbls tbls_hs_overlay[NUM_OVERLAY];
>
>         /* clock ids to be requested */
>         const char * const *clk_list;
> @@ -839,6 +886,7 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
>         .lanes                  = 1,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G3,
>
>         .tbls = {
>                 .serdes         = msm8996_ufsphy_serdes,
> @@ -864,6 +912,7 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
>         .lanes                  = 2,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G4,
>
>         .tbls = {
>                 .serdes         = sm8350_ufsphy_serdes,
> @@ -879,13 +928,14 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
>                 .serdes         = sm8350_ufsphy_hs_b_serdes,
>                 .serdes_num     = ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>         },
> -       .tbls_hs_g4 = {
> +       .tbls_hs_overlay[0] = {
>                 .tx             = sm8350_ufsphy_g4_tx,
>                 .tx_num         = ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>                 .rx             = sm8350_ufsphy_g4_rx,
>                 .rx_num         = ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>                 .pcs            = sm8350_ufsphy_g4_pcs,
>                 .pcs_num        = ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +               .max_gear       = UFS_HS_G4,
>         },
>         .clk_list               = sm8450_ufs_phy_clk_l,
>         .num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> @@ -898,6 +948,7 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>         .lanes                  = 2,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G4,
>
>         .tbls = {
>                 .serdes         = sm8350_ufsphy_serdes,
> @@ -913,13 +964,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>                 .serdes         = sm8350_ufsphy_hs_b_serdes,
>                 .serdes_num     = ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>         },
> -       .tbls_hs_g4 = {
> +       .tbls_hs_overlay[0] = {
>                 .tx             = sm8350_ufsphy_g4_tx,
>                 .tx_num         = ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>                 .rx             = sm8350_ufsphy_g4_rx,
>                 .rx_num         = ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>                 .pcs            = sm8350_ufsphy_g4_pcs,
>                 .pcs_num        = ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +               .max_gear       = UFS_HS_G4,
>         },
>         .clk_list               = sdm845_ufs_phy_clk_l,
>         .num_clks               = ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -932,6 +984,7 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>         .lanes                  = 2,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G3,
>
>         .tbls = {
>                 .serdes         = sdm845_ufsphy_serdes,
> @@ -960,6 +1013,7 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>         .lanes                  = 1,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G3,
>
>         .tbls = {
>                 .serdes         = sm6115_ufsphy_serdes,
> @@ -988,6 +1042,7 @@ static const struct qmp_phy_cfg sm7150_ufsphy_cfg = {
>         .lanes                  = 1,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G3,
>
>         .tbls = {
>                 .serdes         = sdm845_ufsphy_serdes,
> @@ -1016,6 +1071,7 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>         .lanes                  = 2,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G4,
>
>         .tbls = {
>                 .serdes         = sm8150_ufsphy_serdes,
> @@ -1031,13 +1087,14 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>                 .serdes         = sm8150_ufsphy_hs_b_serdes,
>                 .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>         },
> -       .tbls_hs_g4 = {
> +       .tbls_hs_overlay[0] = {
>                 .tx             = sm8150_ufsphy_hs_g4_tx,
>                 .tx_num         = ARRAY_SIZE(sm8150_ufsphy_hs_g4_tx),
>                 .rx             = sm8150_ufsphy_hs_g4_rx,
>                 .rx_num         = ARRAY_SIZE(sm8150_ufsphy_hs_g4_rx),
>                 .pcs            = sm8150_ufsphy_hs_g4_pcs,
>                 .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +               .max_gear       = UFS_HS_G4,
>         },
>         .clk_list               = sdm845_ufs_phy_clk_l,
>         .num_clks               = ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1050,6 +1107,7 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
>         .lanes                  = 2,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G4,
>
>         .tbls = {
>                 .serdes         = sm8150_ufsphy_serdes,
> @@ -1065,13 +1123,14 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
>                 .serdes         = sm8150_ufsphy_hs_b_serdes,
>                 .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>         },
> -       .tbls_hs_g4 = {
> +       .tbls_hs_overlay[0] = {
>                 .tx             = sm8250_ufsphy_hs_g4_tx,
>                 .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
>                 .rx             = sm8250_ufsphy_hs_g4_rx,
>                 .rx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_rx),
>                 .pcs            = sm8150_ufsphy_hs_g4_pcs,
>                 .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +               .max_gear       = UFS_HS_G4,
>         },
>         .clk_list               = sdm845_ufs_phy_clk_l,
>         .num_clks               = ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1084,6 +1143,7 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>         .lanes                  = 2,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G4,
>
>         .tbls = {
>                 .serdes         = sm8350_ufsphy_serdes,
> @@ -1099,13 +1159,14 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>                 .serdes         = sm8350_ufsphy_hs_b_serdes,
>                 .serdes_num     = ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>         },
> -       .tbls_hs_g4 = {
> +       .tbls_hs_overlay[0] = {
>                 .tx             = sm8350_ufsphy_g4_tx,
>                 .tx_num         = ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>                 .rx             = sm8350_ufsphy_g4_rx,
>                 .rx_num         = ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>                 .pcs            = sm8350_ufsphy_g4_pcs,
>                 .pcs_num        = ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +               .max_gear       = UFS_HS_G4,
>         },
>         .clk_list               = sdm845_ufs_phy_clk_l,
>         .num_clks               = ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1118,6 +1179,7 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
>         .lanes                  = 2,
>
>         .offsets                = &qmp_ufs_offsets,
> +       .max_supported_gear     = UFS_HS_G4,
>
>         .tbls = {
>                 .serdes         = sm8350_ufsphy_serdes,
> @@ -1133,13 +1195,14 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
>                 .serdes         = sm8350_ufsphy_hs_b_serdes,
>                 .serdes_num     = ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>         },
> -       .tbls_hs_g4 = {
> +       .tbls_hs_overlay[0] = {
>                 .tx             = sm8350_ufsphy_g4_tx,
>                 .tx_num         = ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>                 .rx             = sm8350_ufsphy_g4_rx,
>                 .rx_num         = ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>                 .pcs            = sm8350_ufsphy_g4_pcs,
>                 .pcs_num        = ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +               .max_gear       = UFS_HS_G4,
>         },
>         .clk_list               = sm8450_ufs_phy_clk_l,
>         .num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> @@ -1152,6 +1215,7 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>         .lanes                  = 2,
>
>         .offsets                = &qmp_ufs_offsets_v6,
> +       .max_supported_gear     = UFS_HS_G5,
>
>         .tbls = {
>                 .serdes         = sm8550_ufsphy_serdes,
> @@ -1167,6 +1231,26 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>                 .serdes         = sm8550_ufsphy_hs_b_serdes,
>                 .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
>         },
> +       .tbls_hs_overlay[0] = {
> +               .serdes         = sm8550_ufsphy_g4_serdes,
> +               .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_g4_serdes),
> +               .tx             = sm8550_ufsphy_g4_tx,
> +               .tx_num         = ARRAY_SIZE(sm8550_ufsphy_g4_tx),
> +               .rx             = sm8550_ufsphy_g4_rx,
> +               .rx_num         = ARRAY_SIZE(sm8550_ufsphy_g4_rx),
> +               .pcs            = sm8550_ufsphy_g4_pcs,
> +               .pcs_num        = ARRAY_SIZE(sm8550_ufsphy_g4_pcs),
> +               .max_gear       = UFS_HS_G4,
> +       },
> +       .tbls_hs_overlay[1] = {
> +               .serdes         = sm8550_ufsphy_g5_serdes,
> +               .serdes_num     = ARRAY_SIZE(sm8550_ufsphy_g5_serdes),
> +               .rx             = sm8550_ufsphy_g5_rx,
> +               .rx_num         = ARRAY_SIZE(sm8550_ufsphy_g5_rx),
> +               .pcs            = sm8550_ufsphy_g5_pcs,
> +               .pcs_num        = ARRAY_SIZE(sm8550_ufsphy_g5_pcs),
> +               .max_gear       = UFS_HS_G5,
> +       },
>         .clk_list               = sdm845_ufs_phy_clk_l,
>         .num_clks               = ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>         .vreg_list              = qmp_phy_vreg_l,
> @@ -1229,17 +1313,63 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
>         qmp_ufs_configure(pcs, tbls->pcs, tbls->pcs_num);
>  }
>
> -static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
> +static bool qmp_ufs_match_gear_overlay(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg, int *i)

You can simply return int from this function. -EINVAL would mean that
the setting was not found. Also this can make max_supported_gear
unused.

> +{
> +       u32 max_gear, floor_max_gear = cfg->max_supported_gear;
> +       bool found = false;
> +       int j;
> +
> +       for (j = 0; j < NUM_OVERLAY; j ++) {
> +               max_gear = cfg->tbls_hs_overlay[j].max_gear;
> +
> +               if (max_gear == 0)
> +                       continue;
> +
> +               /* Direct matching, bail */
> +               if (qmp->submode == max_gear) {
> +                       *i = j;
> +                       return true;
> +               }
> +
> +               /* If no direct matching, the lowest gear is the best matching */
> +               if (max_gear < floor_max_gear) {
> +                       *i = j;
> +                       found = true;
> +                       floor_max_gear = max_gear;
> +               }

We know that the table is sorted. So we can return an index of the
first setting that fits.

> +       }
> +
> +       return found;
> +}
> +
> +static int qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>  {
> +       bool apply_overlay;
> +       int i;
> +
> +       if (qmp->submode > cfg->max_supported_gear || qmp->submode == 0) {
> +               dev_err(qmp->dev, "Invalid PHY submode %u\n", qmp->submode);
> +               return -EINVAL;
> +       }
> +
> +       apply_overlay = qmp_ufs_match_gear_overlay(qmp, cfg, &i);
> +
>         qmp_ufs_serdes_init(qmp, &cfg->tbls);
> +       if (apply_overlay)
> +               qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_overlay[i]);
> +
>         if (qmp->mode == PHY_MODE_UFS_HS_B)
>                 qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
> +
>         qmp_ufs_lanes_init(qmp, &cfg->tbls);
> -       if (qmp->submode == UFS_HS_G4)
> -               qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g4);
> +       if (apply_overlay)
> +               qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_overlay[i]);
> +
>         qmp_ufs_pcs_init(qmp, &cfg->tbls);
> -       if (qmp->submode == UFS_HS_G4)
> -               qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g4);
> +       if (apply_overlay)
> +               qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_overlay[i]);
> +
> +       return 0;
>  }
>
>  static int qmp_ufs_com_init(struct qmp_ufs *qmp)
> @@ -1331,7 +1461,9 @@ static int qmp_ufs_power_on(struct phy *phy)
>         unsigned int val;
>         int ret;
>
> -       qmp_ufs_init_registers(qmp, cfg);
> +       ret = qmp_ufs_init_registers(qmp, cfg);
> +       if (ret)
> +               return ret;
>
>         ret = reset_control_deassert(qmp->ufs_reset);
>         if (ret)
> --
> 2.7.4
>
>


-- 
With best wishes
Dmitry

