Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93577EACC5
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Nov 2023 10:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjKNJPZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Nov 2023 04:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjKNJPX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Nov 2023 04:15:23 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2E21B6
        for <linux-scsi@vger.kernel.org>; Tue, 14 Nov 2023 01:15:17 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a87ac9d245so63399667b3.3
        for <linux-scsi@vger.kernel.org>; Tue, 14 Nov 2023 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699953316; x=1700558116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D0sT/udf/TbM4uFXrzOoI73pPnSUmbts1Ln79Q7EzBY=;
        b=H1kl0HazsdzoAXDisf9sCv14Nukp1+6/WkZ5UiMjckjLQVYDlElHtSTTpL9BFGxzKI
         XN8m37HBWpRvXT66dQn4auDT4shalW6OONnt5JR7G/O3SYnQRZTpm1Rj0y7v0uT4CMV0
         Kl29jmXw4a/WfUT1/uqyVBhygmGD2wEsqdsk/rOtTWVGxl2VAMlXe1GxKVoZeK9MPqh/
         7V6qwpnhsy1MYrFiLx9gYCufnTx2pjOfHSib9eFFT/wjrJvHaEglHfBuLF59vw+Vnn7a
         s+23X9Njft+xGJs0BShhFkgo7AzDlTEjj9xEx+i3hrFBDfQXY9pTRt+NmK11TtHjRQnW
         Mgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699953316; x=1700558116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0sT/udf/TbM4uFXrzOoI73pPnSUmbts1Ln79Q7EzBY=;
        b=q8nro3wxM33uYS/HqCBRHFfmG2WXqqzHgyaKo7k6PlFWiU6q/BypazEWfAfKAzuvYE
         sjNWpecjvlyFyw3lGkuwTrojJS5Cl0b9Jv33ik50HjBwuPJHaFjAphuvau4dNlId/GFl
         v4StelZcJhFFWVseRCj3M9dFhxl+ndPu8FiB+zm7aACsHlneGQost7Ebb5gh/KIhFtau
         CZw49XW5Cz+JbbVjLbpKmXHrTN25YRLkESZcm2W/cupRl/IGjN8UVDw42U7AicanRcGh
         8PGaOr0pvW0xZMIVrVQPELMYdVwZDPj5AJ/UkKcLHtVu2+eJ2Ho5R4y6qIEfTMAU+GTe
         b1cg==
X-Gm-Message-State: AOJu0YzEhfavBCXAkR62nZ195WKxXzNM02T3XoBH5CXe/o8Ur4S/wr3x
        npZl2udCTC+3+ygVOk6usWpBS8ILXPWC0gmDpfJBkA==
X-Google-Smtp-Source: AGHT+IEY/iFzpJXWVHtmA+GUOGfmSzRWpsGCcqZVWjiUSVVgLn+Mnrs/W/IQF8PlJHTyOVmbecJtJb2hkWJDMKN8UAo=
X-Received: by 2002:a81:4f03:0:b0:5a0:ae01:803c with SMTP id
 d3-20020a814f03000000b005a0ae01803cmr9839989ywb.38.1699953316478; Tue, 14 Nov
 2023 01:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20231108054942.GF3296@thinkpad> <CAA8EJpoCZChHDQLF0QHN0PkRUWV20thXMQvK-sH2fpYaC1zcvg@mail.gmail.com>
 <20231109032418.GA3752@thinkpad> <CAA8EJpoZUf9Ku5meH5VAcSkCbna__5LdPi8rgnN0tyBc-UzzWw@mail.gmail.com>
 <20231109104250.GF3752@thinkpad> <CAA8EJpp+wfe5wUj0FAMY2g3J8v7F8DVf8Bi3BwrAuCp-n=PFJg@mail.gmail.com>
 <20231109160430.GG3752@thinkpad> <CAA8EJpq+R4QsQSn1_sf1_dkh8mOmWLtBm7SSa953s8jRQR-pAg@mail.gmail.com>
 <20231110131803.GA5025@thinkpad> <1ac5ae60-7e76-43f2-8b3d-c286eade0251@quicinc.com>
 <20231111041215.GA4823@thinkpad> <7b98d2e0-b989-4937-a674-6866c6aa05d4@quicinc.com>
In-Reply-To: <7b98d2e0-b989-4937-a674-6866c6aa05d4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 11:15:04 +0200
Message-ID: <CAA8EJppXg1S_L2dkts5UWLW2z2q9i8vf3bpK9Fdk9_W_BprWzQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
To:     Can Guo <quic_cang@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <cang@qti.qualcomm.com>, bvanassche@acm.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, 12 Nov 2023 at 07:13, Can Guo <quic_cang@quicinc.com> wrote:
>
> Hi Mani,
>
> On 11/11/2023 12:12 PM, Manivannan Sadhasivam wrote:
> > On Fri, Nov 10, 2023 at 10:40:53PM +0800, Can Guo wrote:
> >>
> >>
> >> On 11/10/2023 9:18 PM, Manivannan Sadhasivam wrote:
> >>> On Fri, Nov 10, 2023 at 12:11:46AM +0200, Dmitry Baryshkov wrote:
> >>>> On Thu, 9 Nov 2023 at 18:04, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >>>>>
> >>>>> On Thu, Nov 09, 2023 at 01:00:51PM +0200, Dmitry Baryshkov wrote:
> >>>>>> On Thu, 9 Nov 2023 at 12:43, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >>>>>>>
> >>>>>>> On Thu, Nov 09, 2023 at 11:40:51AM +0200, Dmitry Baryshkov wrote:
> >>>>>>>> On Thu, 9 Nov 2023 at 05:24, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Nov 08, 2023 at 08:56:16AM +0200, Dmitry Baryshkov wrote:
> >>>>>>>>>> On Wed, 8 Nov 2023 at 07:49, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Tue, Nov 07, 2023 at 03:18:09PM +0200, Dmitry Baryshkov wrote:
> >>>>>>>>>>>> On Tue, 7 Nov 2023 at 06:47, Can Guo <cang@qti.qualcomm.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> From: Can Guo <quic_cang@quicinc.com>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On SM8550, two sets of UFS PHY settings are provided, one set is to support
> >>>>>>>>>>>>> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
> >>>>>>>>>>>>> settings are programming different values to different registers, mixing
> >>>>>>>>>>>>> the two sets and/or overwriting one set with another set is definitely not
> >>>>>>>>>>>>> blessed by UFS PHY designers. In order to add HS-G5 support for SM8550, we
> >>>>>>>>>>>>> need to split the two sets into their dedicated tables, and leave only the
> >>>>>>>>>>>>> common settings in the .tlbs. To have the PHY programmed with the correct
> >>>>>>>>>>>>> set of PHY settings, the submode passed to PHY driver must be either HS-G4
> >>>>>>>>>>>>> or HS-G5.
> >>>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> You should also mention that this issue is also present in G4 supported targets.
> >>>>>>>>>>> And a note that it will get fixed later.
> >>>>>>>>>>>
> >>>>>>>>>>>>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> >>>>>>>>>>>>> ---
> >>>>>>>>>>>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
> >>>>>>>>>>>>>    drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
> >>>>>>>>>>>>>    .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 +++
> >>>>>>>>>>>>>    drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 112 ++++++++++++++++++---
> >>>>>>>>>>>>>    4 files changed, 115 insertions(+), 13 deletions(-)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> >>>>>>>>>>>>> index c23d5e4..e563af5 100644
> >>>>>>>>>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> >>>>>>>>>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> >>>>>>>>>>>>> @@ -18,6 +18,7 @@
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL            0x060
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY           0x074
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY           0x0bc
> >>>>>>>>>>>>> +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY        0x12c
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL               0x158
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_LINECFG_DISABLE                        0x17c
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME            0x184
> >>>>>>>>>>>>> @@ -27,5 +28,6 @@
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_READY_STATUS                   0x1a8
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1              0x1f4
> >>>>>>>>>>>>>    #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1               0x1fc
> >>>>>>>>>>>>> +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME         0x220
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>    #endif
> >>>>>>>>>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> >>>>>>>>>>>>> index f420f8f..ef392ce 100644
> >>>>>>>>>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> >>>>>>>>>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> >>>>>>>>>>>>> @@ -56,6 +56,8 @@
> >>>>>>>>>>>>>    #define QSERDES_V6_COM_SYS_CLK_CTRL                            0xe4
> >>>>>>>>>>>>>    #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE                       0xe8
> >>>>>>>>>>>>>    #define QSERDES_V6_COM_PLL_IVCO                                        0xf4
> >>>>>>>>>>>>> +#define QSERDES_V6_COM_CMN_IETRIM                              0xfc
> >>>>>>>>>>>>> +#define QSERDES_V6_COM_CMN_IPTRIM                              0x100
> >>>>>>>>>>>>>    #define QSERDES_V6_COM_SYSCLK_EN_SEL                           0x110
> >>>>>>>>>>>>>    #define QSERDES_V6_COM_RESETSM_CNTRL                           0x118
> >>>>>>>>>>>>>    #define QSERDES_V6_COM_LOCK_CMP_EN                             0x120
> >>>>>>>>>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> >>>>>>>>>>>>> index 15bcb4b..48f31c8 100644
> >>>>>>>>>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> >>>>>>>>>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> >>>>>>>>>>>>> @@ -10,10 +10,20 @@
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX                     0x2c
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX              0x30
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX              0x34
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_TX_LANE_MODE_1                          0x7c
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL                          0x108
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2          0x08
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4          0x10
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4          0x24
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4       0x54
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2                   0xd4
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4                   0xdc
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4                   0xf0
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS                     0xf4
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL                      0x178
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1             0x1bc
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3                        0x1c4
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0                     0x208
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1                     0x20c
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3                     0x214
> >>>>>>>>>>>>> @@ -25,6 +35,8 @@
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_MODE_RATE3_B5                                0x264
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_MODE_RATE3_B8                                0x270
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_MODE_RATE4_B3                                0x280
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4                                0x284
> >>>>>>>>>>>>>    #define QSERDES_UFS_V6_RX_MODE_RATE4_B6                                0x28c
> >>>>>>>>>>>>> +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL                      0x2f8
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>    #endif
> >>>>>>>>>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>>>>>>>>>>>> index 3927eba..e0a01497 100644
> >>>>>>>>>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>>>>>>>>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>>>>>>>>>>>> @@ -649,32 +649,51 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> >>>>>>>>>>>>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> >>>>>>>>>>>>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> >>>>>>>>>>>>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> >>>>>>>>>>>>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
> >>>>>>>>>>>>> +};
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> >>>>>>>>>>>>> +};
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> >>>>>>>>>>>>>           QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> >>>>>>>>>>>>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> >>>>>>>>>>>>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> >>>>>>>>>>>>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
> >>>>>>>>>>>>> -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
> >>>>>>>>>>>>
> >>>>>>>>>>>> Aside from moving these registers to the HS_G4 table, you are also
> >>>>>>>>>>>> changing these registers. It makes me think that there was an error in
> >>>>>>>>>>>> the original programming sequence.
> >>>>>>>>>>>> If that is correct, could you please split the patch into two pieces:
> >>>>>>>>>>>> - Fix programming sequence (add proper Fixes tags)
> >>>>>>>>>>>> - Split G4 and G5 tables.
> >>>>>>>>>>>
> >>>>>>>>>>> Ack
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
> >>>>>>>>>>>>> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
> >>>>>>>>>>>>
> >>>>>>>>>>>> I see all the MODE1 registers being only present in G4 and G5 tables.
> >>>>>>>>>>>> Should they be programmed for the modes lower than G4?
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> We use G4 table for all the modes <= G4.
> >>>>>>>>>>
> >>>>>>>>>> Could you please point me how it's handled?
> >>>>>>>>>> In the patch I see just:
> >>>>>>>>>>
> >>>>>>>>>>          if (qmp->submode == UFS_HS_G4)
> >>>>>>>>>>                  qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g4);
> >>>>>>>>>>          else if (qmp->submode == UFS_HS_G5)
> >>>>>>>>>>                  qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g5);
> >>>>>>>>>>
> >>>>>>>>>> Which looks like two special cases (HS_G4 and HS_G5) and nothing for
> >>>>>>>>>> anything else.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Yes, and the UFS driver passes only G4/G5. For all the gears <=G4, G4 init
> >>>>>>>>> sequence will be used and for G5, G5 sequence will be used.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> That's what I could not find in the UFS driver. I see a call to
> >>>>>>>> `phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);` and
> >>>>>>>> host->phy_gear is initialised to UFS_HS_G2.
> >>>>>>>>
> >>>>>>>
> >>>>>>> You need to check the UFS driver changes in this series to get the complete
> >>>>>>> picture as the logic is getting changed.
> >>>>>>>
> >>>>>>> It is common to get confused because of the way the UFS driver (qcom mostly)
> >>>>>>> handles the PHY init sequence programming. We used to have only one init
> >>>>>>> sequence for older targets and life was easy. But when I wanted to add G4
> >>>>>>> support for SM8250, I learned that there are 2 separate init sequences. One for
> >>>>>>> non-G4 and other for G4. So I used the phy_sub_mode property to pass the
> >>>>>>> relevant mode from the UFS driver to the PHY driver and programmed the sequence
> >>>>>>> accordingly. This got extended to non-G5 and G5 now.
> >>>>>>>
> >>>>>>> Now, the UFS driver will start probing from a low gear for older targets (G2)
> >>>>>>> and G4/G5 for newer ones then scale up based on the device and host capability.
> >>>>>>> For older targets, the common table (tbls) will be used if the submode doesn't
> >>>>>>> match G4/G5. But for newer targets, the UFS driver will _only_ pass G4 or G5 as
> >>>>>>> the phy_gear, so those specific sequence will only be used.
> >>>>>>>
> >>>>>>> Hope I'm clear.
> >>>>>>
> >>>>>> Yes, it is now clear, thank you!
> >>>>>>
> >>>>>> Would it be possible / feasible / logical to maintain this idea even
> >>>>>> for newer platforms (leaving the HS_A  / HS_B aside)?
> >>>>>>
> >>>>>> tbls - works for HS_G2
> >>>>>> tbls + tbls_g4 - works for HS_G4
> >>>>>> tbls + tbls_g5 - works for HS_G5
> >>>>>>
> >>>>>
> >>>>> No. The PHY team only gives 2 init sequences for any SoC now.
> >>>>
> >>>> Ack. Then the code should become
> >>>> if (HS_G5)
> >>>>      program(tbls_hs_g5)
> >>>> else
> >>>>      program(tbls_hs_g4);
> >>>>
> >>>
> >>> This should work. Even if we have to accomodate G6 in the future, we can use
> >>> "else if" for that and keep G4 as the "else" condition. This logic can also be
> >>> optimized in the future.
> >>
> >> That would make dual init meaningless for old targets. Say on SM8450, the
> >> initial PHY gear is G2, with the "else" condition, during the first init, G4
> >> table would be programmed, then gear negotiation happens btw host and device
> >> and the negotiated gear is G3 (assume a UFS2.x is connected). During the 2nd
> >> init, the "else" condition would __again__ program the G4 table - it is not
> >> programming the non-G4 table for power saving. The dual init is supposed to
> >> find the optimal PHY settings, but the "else" condition is programming G4
> >> table unconditinally.
> >>
> >> With the original code change in this patch, the dual init works as it is
> >> for old targets. say SM8450, the initial PHY gear is G2, during the 2nd
> >> init, it is programming the non-G4 table (assume a UFS2.x is connected), but
> >> not the G4 table.
> >>
> >
> > You are right. I completely overlooked the compatibility for old targets. But
> > still we can move the common table to the "else" condition. This makes it clear
> > that one of the 3 will be programmed at a time. But with the current logic, I
> > get the impression that common table is overridden by G4/G5 tables.
> >
> > So this is what I'm suggesting:
> >
> > if (HS_G5)
> >       program(tbls_hs_g5)
> > else if (HS_G4)
> >       program(tbls_hs_g4);
> > else
> >       program(tbls_hs_common);
> >
>
> Common table is needed regardlessly, we cannot put it in "else",
> otherwise it would break all targets -
>
> On old targets (no G5 supported):
> Common table            - supports non-G4 (G3 and lower)
> Common table + G4 table - supports G4
>
> On new targets (G5 supported):
> Common table            - supports nothing, as it is just common parts of G4
> table and G5 table.
> Common table + G4 table - support non-G5 (G4 and lower)
> Common table + G5 table - support G5

There is one issue with this approach, which you might be able to fix.
For the older PHYs we have two cases: pre-G4 and G4. The host driver
can set any mode of its choice.
For the newer targets we only support G4 and G5 modes, don't we?
However the knowledge that there will be no modes lower than G4 is
hidden inside the host driver.
Could you please add a flag / condition to the PHY driver to error out
if the host tries to set e.g. G2 for the newer PHYs?

-- 
With best wishes
Dmitry
