Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39946643D74
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Dec 2022 08:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiLFHMZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Dec 2022 02:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiLFHMY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Dec 2022 02:12:24 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE411A1F
        for <linux-scsi@vger.kernel.org>; Mon,  5 Dec 2022 23:12:23 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s196so12623079pgs.3
        for <linux-scsi@vger.kernel.org>; Mon, 05 Dec 2022 23:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B1ANPs4DOsm+UmHpJKXF/8eOmbfQxRkzXdEOzvRDR0M=;
        b=h6iWhky3HNQ9/UAroFVu1c+YaOp5hTc8qWEg+liylRRbSddMndy3T8bGavUnnPHPoc
         BJHn0yVyaQCk/TP0+iqLwCBnOUS/CFyGhpP3v1X0RRSy19tKVJkFAMz8TGNKNgikv5Co
         evQOdPQ6v2JLkS2TbWCMZsZNLvooyzVGnOmnKEUclleIOBpfpuxB0ZVhr9mCRPdl35cm
         /T+HSA3Nn7xCMpoftJcstFZ83FTeaqGlofBVFZBttSR/6jCwxyOIahWOfXOfiALLJfAY
         /aGzowNZASXJYkbLpil8GHBc7leT9ovBsrfx0VukswY/lbzcQOK6vZqbEOpMUHwSL8kM
         1/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1ANPs4DOsm+UmHpJKXF/8eOmbfQxRkzXdEOzvRDR0M=;
        b=owz5e4c2CGI/EYGa5dq7S0rySSb4WWq15g2ExoSPrmAJkIEX1y1EpGFX8DlZuksB5r
         H99gtmxnCNDc90RVWkcElNHFz7KRgy1XmMCTC8G10BwbVBYgM5aawwFi8AocFZzXhpVH
         vemaVUAfCd5Uw0d3gUAVQmpdC55E5qsjXntQt9t233UXkNi5SbealqtNOa/z7H2bDLg7
         ubZTz9veNRpthpAh716UhtYFkMop6VXye0tOwWV1iQwPDwtSoI2sH1CtFfcy7jH9MpyB
         4W7fxSpa5a0I1olso84NkQem9N8PGd4EZYf/OUy58eO0xsLZa8Zt816Rron1j/2BFbmA
         oVyA==
X-Gm-Message-State: ANoB5plMiPPaUpDHeSJpqhctsEbX7ee7PXv/GpV5Fuy8ksiCKg3czl7H
        ZloaWNC2KifUB+cavqp1uRX5
X-Google-Smtp-Source: AA0mqf54IKnAGppRNz0mXYBvpJUyY3qJ/ynQHuD0Eq4Kx1RmzbUPe15c2LK96rk2XExXRZe1KksIPA==
X-Received: by 2002:a05:6a00:1d22:b0:577:e7d:5490 with SMTP id a34-20020a056a001d2200b005770e7d5490mr6282671pfx.71.1670310742370;
        Mon, 05 Dec 2022 23:12:22 -0800 (PST)
Received: from thinkpad ([117.207.29.147])
        by smtp.gmail.com with ESMTPSA id i28-20020a056a00005c00b005771f5ea2ebsm2058560pfk.135.2022.12.05.23.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 23:12:21 -0800 (PST)
Date:   Tue, 6 Dec 2022 12:42:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v4 04/23] phy: qcom-qmp-ufs: Add support for configuring
 PHY in HS Series B mode
Message-ID: <20221206071213.GA15486@thinkpad>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
 <20221201174328.870152-5-manivannan.sadhasivam@linaro.org>
 <32201EF1-8169-4940-99E1-31CC0C37C522@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32201EF1-8169-4940-99E1-31CC0C37C522@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Dec 06, 2022 at 12:51:42AM +0300, Dmitry Baryshkov wrote:
> 
> 
> On 1 December 2022 20:43:09 GMT+03:00, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >Add separate tables_hs_b instance to allow the PHY driver to configure the
> >PHY in HS Series B mode. The individual SoC configs need to supply the
> >serdes register setting in tables_hs_b and the UFS driver can request the
> >Series B mode by calling phy_set_mode() with mode set to PHY_MODE_UFS_HS_B.
> >
> >Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >---
> > drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 15 +++++++++++++++
> > 1 file changed, 15 insertions(+)
> >
> >diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >index 516027e356f0..2d5dd336aeb2 100644
> >--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >@@ -547,6 +547,8 @@ struct qmp_phy_cfg {
> > 
> > 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
> > 	const struct qmp_phy_cfg_tbls tbls;
> >+	/* Additional sequence for HS Series B */
> >+	const struct qmp_phy_cfg_tbls tbls_hs_b;
> > 
> > 	/* clock ids to be requested */
> > 	const char * const *clk_list;
> >@@ -580,6 +582,7 @@ struct qmp_ufs {
> > 	struct reset_control *ufs_reset;
> > 
> > 	struct phy *phy;
> >+	u32 mode;
> > };
> > 
> > static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> >@@ -841,6 +844,8 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
> > static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
> > {
> > 	qmp_ufs_serdes_init(qmp, &cfg->tbls);
> >+	if (qmp->mode == PHY_MODE_UFS_HS_B)
> >+		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
> 
> I still think that qmp_ufs_init_registers() is a way to go here , see the pcie driver.
> 

I did use qmp_ufs_init_registers() as a wrapper. Only difference here is that
there is one more level of abstraction which looks cleaner to me.

Thanks,
Mani

> > 	qmp_ufs_lanes_init(qmp, &cfg->tbls);
> > 	qmp_ufs_pcs_init(qmp, &cfg->tbls);
> > }
> >@@ -1011,9 +1016,19 @@ static int qmp_ufs_disable(struct phy *phy)
> > 	return qmp_ufs_exit(phy);
> > }
> > 
> >+static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> >+{
> >+	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> >+
> >+	qmp->mode = mode;
> >+
> >+	return 0;
> >+}
> >+
> > static const struct phy_ops qcom_qmp_ufs_phy_ops = {
> > 	.power_on	= qmp_ufs_enable,
> > 	.power_off	= qmp_ufs_disable,
> >+	.set_mode	= qmp_ufs_set_mode,
> > 	.owner		= THIS_MODULE,
> > };
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
