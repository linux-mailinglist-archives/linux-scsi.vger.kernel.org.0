Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F257412647E
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Dec 2019 15:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLSOVu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Dec 2019 09:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSOVu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Dec 2019 09:21:50 -0500
Received: from localhost (unknown [122.178.234.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C51222C2;
        Thu, 19 Dec 2019 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576765310;
        bh=qPE9//mZgMQYau8o2brsaK7UTZVASfudmoR5jovYAu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oovSBiD9bsR9UznqfKVYt5Xn3KNRdTeZ1HLao554efYP9YrFjoExRf30GNnvCpjD0
         i+HV8NpoIG/XhdiP0X111Qo8tjbv5hMUDr/r/Ejhh6QsAQx48gNu7hTFjub+yX5git
         V8g/zGOlBMfxXlP/L2NX+RetD6d/qW7Tizue6bQ8=
Date:   Thu, 19 Dec 2019 19:51:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cang@codeaurora.org
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, asutoshd@codeaurora.org,
        nguyenb@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, Mark Salyzyn <salyzyn@google.com>,
        Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] scsi: ufs-qcom: Add reset control support for
 host controller
Message-ID: <20191219142145.GV2536@vkoul-mobl>
References: <091562cbe7d88ca1c30638bc10197074@codeaurora.org>
 <20191217041342.GM2536@vkoul-mobl>
 <763d7b30593b31646f3c198c2be99671@codeaurora.org>
 <20191217092433.GN2536@vkoul-mobl>
 <fc8952a0eee5c010fe14e5f107d89e64@codeaurora.org>
 <20191217150852.GO2536@vkoul-mobl>
 <CAOCk7Np691Hau1FdJqWs1UY6jvEvYfzA6NnG9U--ZcRsuV5=Zw@mail.gmail.com>
 <75f7065d08f450c6cbb2b2662658ecaa@codeaurora.org>
 <20191218041200.GP2536@vkoul-mobl>
 <983c21bb5ad2d38e11c074528d8898b9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983c21bb5ad2d38e11c074528d8898b9@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 19-12-19, 15:12, cang@codeaurora.org wrote:
> On 2019-12-18 12:12, Vinod Koul wrote:
> > On 18-12-19, 02:44, cang@codeaurora.org wrote:

> 
> Aside of the phy settings, your DT needs some modifications too,
> seems you copied most of them from sdm845.
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=3834a2e92229ef26d30de28acb698b2b23d3e397
> 
> <--snip-->
> > +		ufs_mem_phy: phy@1d87000 {
> > +			compatible = "qcom,sm8150-qmp-ufs-phy";
> > +			reg = <0 0x01d87000 0 0x18c>;
> 
> The size 0x18c is wrong, in the code you are even accessing registers
> whose offsets are beyond 0x18c, see
> 
> #define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
> #define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
> #define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
> #define QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
> #define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
> 
> FYI, the total size of serdes registers is 0x1c0.

Yeah I will update it to 0x1c0

> 
> <--snip-->
> > +			ufs_mem_phy_lanes: lanes@1d87400 {
> > +				reg = <0 0x01d87400 0 0x108>,
> > +				      <0 0x01d87600 0 0x1e0>,
> > +				      <0 0x01d87c00 0 0x1dc>,
> 
> Same as above, see
> 
> #define QPHY_V4_MULTI_LANE_CTRL1			0x1e0
> 
> FYI, the total size of PCS registers is 0x200
> 
> > +				      <0 0x01d87800 0 0x108>,
> > +				      <0 0x01d87a00 0 0x1e0>;
> > +				#phy-cells = <0>;
> > +			};
> <--snip-->

So I managed to fix it by configuring QPHY_SW_RESET in
qcom_qmp_phy_com_init() before invoking the configuration. That makes it
work for me. Will send patches shortly

-- 
~Vinod
