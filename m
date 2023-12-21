Return-Path: <linux-scsi+bounces-1239-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D281BCC4
	for <lists+linux-scsi@lfdr.de>; Thu, 21 Dec 2023 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7098A1F21E52
	for <lists+linux-scsi@lfdr.de>; Thu, 21 Dec 2023 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0B62801;
	Thu, 21 Dec 2023 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxK+bMpO"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25C627F0;
	Thu, 21 Dec 2023 17:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE46C433D9;
	Thu, 21 Dec 2023 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178955;
	bh=+zyXRn20w9EQZVYWIlgPBatlUpErpGuSEmHVNzCBnRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dxK+bMpOr3ZXrqtkX+4I99FHLCgwz2ydUpLgWFDG3z4xLnkjRUe0I26qTX3UDcHbt
	 qCgjDqoNpQjQsLXwM920syDLXffV6ZNPlMmdtSm36vCw5lelSeI4VBkZFDvthQG5SR
	 0gakYzUj4rGQYYx/LHd+j6lj3A064Hcczgo54upcUXEYJtZZEMCRe4G9Cr2uaqqn+l
	 z0+m5d13TotrYyQO1NHo+Zc4HnnTgEd7LGpUku4e5LFd9NFK2yCFxHJC363mo5e+13
	 Ry6RutvhKDvkCAzeC8WtaU3+a9dxErBNAf5/lMUn7LaIIUA78ATe1H6MQEitixTbbN
	 1q/FztPwybVqw==
From: Vinod Koul <vkoul@kernel.org>
To: bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com, 
 beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com, 
 martin.petersen@oracle.com, Can Guo <quic_cang@quicinc.com>
Cc: linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
Subject: Re: (subset) [PATCH v8 00/10] Enable HS-G5 support on SM8550
Message-Id: <170317895067.712473.11493486832134923013.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:45:50 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 02 Dec 2023 04:36:06 -0800, Can Guo wrote:
> This series enables HS-G5 support on SM8550.
> 
> This series is rebased on below changes from Mani -
> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-1-manivannan.sadhasivam@linaro.org/
> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-2-manivannan.sadhasivam@linaro.org/
> 
> This series is tested on below HW combinations -
> SM8550 MTP + UFS4.0
> SM8550 QRD + UFS3.1
> SM8450 MTP + UFS3.1 (for regression test)
> SM8350 MTP + UFS3.1 (for regression test)
> 
> [...]

Applied, thanks!

[09/10] phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550 UFS HS-G4 PHY Settings
        commit: 5301b7a04040b0a6191856c765146e0a9ab88ebc
[10/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for SM8550
        (no commit info)

Best regards,
-- 
~Vinod



