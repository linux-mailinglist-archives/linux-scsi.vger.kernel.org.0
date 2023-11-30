Return-Path: <linux-scsi+bounces-352-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DBA7FEADF
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 09:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD4D1C20B38
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2CF36AFE
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khhBIH+Y"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23B1DA42;
	Thu, 30 Nov 2023 07:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21673C433C7;
	Thu, 30 Nov 2023 07:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701328370;
	bh=Nvr3s9a9nquft77vyd+DXYqvI9sRAvSV7ZSd+qVY2cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khhBIH+Y1UgeplrVX6OYu0+sC6c56AZrE6aVM7rhmO5pncLa92oxUP+Gsh/CAAR+j
	 zeG/UCMQJLyCzJN/f+QJ+PeyPTrpFRQv7QXn3lRjXxCgxiyP05Mx2pHpi7vAoR7JLb
	 pm6XMlQUGIEerBuG3SkG4bSgVb606gWu5IoK4+vwC5C17TEbsuJWr3LriHzzH2emYc
	 6kstRiMwGH1P6W4S88z+ZyskLBMGaikEhL1+W2+HYpDj3Onz+qtPr0lX8XWVzepvaV
	 j3XOpiC/l2zey/fo6W/i1QmwUd3uqR/04FbcTALnIOKz1KhXar21AWMMtsWuL+FJl1
	 NonrRMnNcy1cQ==
Date: Thu, 30 Nov 2023 12:42:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Can Guo <quic_cang@quicinc.com>
Cc: bvanassche@acm.org, adrian.hunter@intel.com, cmd4@qualcomm.com,
	beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Message-ID: <20231130071240.GG3043@thinkpad>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-9-git-send-email-quic_cang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701246516-11626-9-git-send-email-quic_cang@quicinc.com>

On Wed, Nov 29, 2023 at 12:28:33AM -0800, Can Guo wrote:
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
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 170 ++++++++++++++++++---
>  4 files changed, 163 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> index c23d5e4..e563af5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> @@ -18,6 +18,7 @@
>  #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
>  #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
>  #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0bc
> +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY	0x12c
>  #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL		0x158
>  #define QPHY_V6_PCS_UFS_LINECFG_DISABLE			0x17c
>  #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME		0x184
> @@ -27,5 +28,6 @@
>  #define QPHY_V6_PCS_UFS_READY_STATUS			0x1a8
>  #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1		0x1f4
>  #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1		0x1fc
> +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME		0x220
>  
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> index f420f8f..ef392ce 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> @@ -56,6 +56,8 @@
>  #define QSERDES_V6_COM_SYS_CLK_CTRL				0xe4
>  #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE			0xe8
>  #define QSERDES_V6_COM_PLL_IVCO					0xf4
> +#define QSERDES_V6_COM_CMN_IETRIM				0xfc
> +#define QSERDES_V6_COM_CMN_IPTRIM				0x100
>  #define QSERDES_V6_COM_SYSCLK_EN_SEL				0x110
>  #define QSERDES_V6_COM_RESETSM_CNTRL				0x118
>  #define QSERDES_V6_COM_LOCK_CMP_EN				0x120
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> index 674f158..48f31c8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> @@ -15,8 +15,15 @@
>  
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x08
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4		0x10
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4		0x24
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4	0x54
>  #define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0xd4
> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4			0xdc
> +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4			0xf0
> +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS			0xf4
>  #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
> +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x1bc
> +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3			0x1c4
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
> @@ -28,6 +35,8 @@
>  #define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
>  #define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
>  #define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4				0x284
>  #define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
> +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL			0x2f8
>  
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 2173418..7e5f1154 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -41,6 +41,8 @@
>  
>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
>  
> +#define NUM_OVERLAY				2
> +
>  struct qmp_phy_init_tbl {
>  	unsigned int offset;
>  	unsigned int val;
> @@ -754,15 +756,22 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
> @@ -771,19 +780,24 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
>  };
>  
> -static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x1b),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
>  };
>  
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_tx[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
>  };
>  
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
>  
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
> @@ -799,16 +813,45 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
>  };
>  
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B3, 0xb9),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B4, 0x4f),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B6, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> -	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_pcs[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
>  };
>  
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_pcs[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4f),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
> +};
> +
>  struct qmp_ufs_offsets {
>  	u16 serdes;
>  	u16 pcs;
> @@ -828,6 +871,8 @@ struct qmp_phy_cfg_tbls {
>  	int rx_num;
>  	const struct qmp_phy_init_tbl *pcs;
>  	int pcs_num;
> +	/* Maximum supported Gear of this tbls */
> +	u32 max_gear;
>  };
>  
>  /* struct qmp_phy_cfg - per-PHY initialization config */
> @@ -835,13 +880,15 @@ struct qmp_phy_cfg {
>  	int lanes;
>  
>  	const struct qmp_ufs_offsets *offsets;
> +	/* Maximum supported Gear of this config */
> +	u32 max_supported_gear;
>  
>  	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>  	const struct qmp_phy_cfg_tbls tbls;
>  	/* Additional sequence for HS Series B */
>  	const struct qmp_phy_cfg_tbls tbls_hs_b;
> -	/* Additional sequence for HS G4 */
> -	const struct qmp_phy_cfg_tbls tbls_hs_g4;
> +	/* Additional sequence for different HS Gears */
> +	const struct qmp_phy_cfg_tbls tbls_hs_overlay[NUM_OVERLAY];
>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -944,6 +991,7 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
>  	.lanes			= 1,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G3,
>  
>  	.tbls = {
>  		.serdes		= msm8996_ufsphy_serdes,
> @@ -969,6 +1017,7 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8350_ufsphy_serdes,
> @@ -984,13 +1033,14 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
>  		.serdes		= sm8350_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8350_ufsphy_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>  		.rx		= sm8350_ufsphy_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>  		.pcs		= sm8350_ufsphy_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sm8450_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> @@ -1003,6 +1053,7 @@ static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
>  	.lanes                  = 2,
>  
>  	.offsets                = &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes         = sm8150_ufsphy_serdes,
> @@ -1018,13 +1069,14 @@ static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
>  		.serdes         = sm8150_ufsphy_hs_b_serdes,
>  		.serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx             = sm8250_ufsphy_hs_g4_tx,
>  		.tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
>  		.rx             = sc7280_ufsphy_hs_g4_rx,
>  		.rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
>  		.pcs            = sm8150_ufsphy_hs_g4_pcs,
>  		.pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list               = sm8450_ufs_phy_clk_l,
>  	.num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> @@ -1037,6 +1089,7 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8350_ufsphy_serdes,
> @@ -1052,13 +1105,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>  		.serdes		= sm8350_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8350_ufsphy_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>  		.rx		= sm8350_ufsphy_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>  		.pcs		= sm8350_ufsphy_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1071,6 +1125,7 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G3,
>  
>  	.tbls = {
>  		.serdes		= sdm845_ufsphy_serdes,
> @@ -1099,6 +1154,7 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>  	.lanes			= 1,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G3,
>  
>  	.tbls = {
>  		.serdes		= sm6115_ufsphy_serdes,
> @@ -1127,6 +1183,7 @@ static const struct qmp_phy_cfg sm7150_ufsphy_cfg = {
>  	.lanes			= 1,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G3,
>  
>  	.tbls = {
>  		.serdes		= sdm845_ufsphy_serdes,
> @@ -1155,6 +1212,7 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8150_ufsphy_serdes,
> @@ -1170,13 +1228,14 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>  		.serdes		= sm8150_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8150_ufsphy_hs_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_tx),
>  		.rx		= sm8150_ufsphy_hs_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_rx),
>  		.pcs		= sm8150_ufsphy_hs_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1189,6 +1248,7 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8150_ufsphy_serdes,
> @@ -1204,13 +1264,14 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
>  		.serdes		= sm8150_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8250_ufsphy_hs_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
>  		.rx		= sm8250_ufsphy_hs_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_rx),
>  		.pcs		= sm8150_ufsphy_hs_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1223,6 +1284,7 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8350_ufsphy_serdes,
> @@ -1238,13 +1300,14 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>  		.serdes		= sm8350_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8350_ufsphy_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>  		.rx		= sm8350_ufsphy_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>  		.pcs		= sm8350_ufsphy_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1257,6 +1320,7 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8350_ufsphy_serdes,
> @@ -1272,13 +1336,14 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
>  		.serdes		= sm8350_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8350_ufsphy_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>  		.rx		= sm8350_ufsphy_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>  		.pcs		= sm8350_ufsphy_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sm8450_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> @@ -1291,6 +1356,7 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets_v6,
> +	.max_supported_gear	= UFS_HS_G5,
>  
>  	.tbls = {
>  		.serdes		= sm8550_ufsphy_serdes,
> @@ -1306,6 +1372,26 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>  		.serdes		= sm8550_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
>  	},
> +	.tbls_hs_overlay[0] = {
> +		.serdes		= sm8550_ufsphy_g4_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_g4_serdes),
> +		.tx		= sm8550_ufsphy_g4_tx,
> +		.tx_num		= ARRAY_SIZE(sm8550_ufsphy_g4_tx),
> +		.rx		= sm8550_ufsphy_g4_rx,
> +		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_g4_rx),
> +		.pcs		= sm8550_ufsphy_g4_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
> +	},
> +	.tbls_hs_overlay[1] = {
> +		.serdes		= sm8550_ufsphy_g5_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_g5_serdes),
> +		.rx		= sm8550_ufsphy_g5_rx,
> +		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_g5_rx),
> +		.pcs		= sm8550_ufsphy_g5_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_g5_pcs),
> +		.max_gear	= UFS_HS_G5,
> +	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> @@ -1368,17 +1454,55 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
>  	qmp_ufs_configure(pcs, tbls->pcs, tbls->pcs_num);
>  }
>  
> +static int qmp_ufs_get_gear_overlay(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
> +{
> +	u32 max_gear, floor_max_gear = cfg->max_supported_gear;
> +	int i = NUM_OVERLAY - 1;

Just use i directly in the for loop. Also, please rename "i" with "idx" to make
it clear.

> +	int ret = -EINVAL;
> +
> +	for (; i >= 0; i --) {

i--

> +		max_gear = cfg->tbls_hs_overlay[i].max_gear;
> +
> +		if (max_gear == 0)
> +			continue;

You are setting max_gear even for targets with a single overlay. How can this
become 0?

> +
> +		/* Direct matching, bail */
> +		if (qmp->submode == max_gear)
> +			return i;
> +
> +		/* If no direct matching, the lowest gear is the best matching */
> +		if (max_gear < floor_max_gear) {
> +			ret = i;
> +			floor_max_gear = max_gear;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>  {
> +	int i;
> +	bool apply_overlay = false;
> +
> +	i = qmp_ufs_get_gear_overlay(qmp, cfg);
> +	if (i >= 0)
> +		apply_overlay = true;

How about?

```
	int idx;

	idx = qmp_ufs_get_gear_overlay(qmp, cfg);

	qmp_ufs_serdes_init(qmp, &cfg->tbls);
	qmp_ufs_lanes_init(qmp, &cfg->tbls);
	...

	if (idx >= 0) {
		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_overlay[idx]);
		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_overlay[idx]);
		...
	}
```

Since the ordering doesn't matter for init sequence, you can program the overlay
tables under a single condition.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

