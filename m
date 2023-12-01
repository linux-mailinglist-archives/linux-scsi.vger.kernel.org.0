Return-Path: <linux-scsi+bounces-404-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49480040C
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180B61C20BFF
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 06:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2B11725
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADa8Ma8z"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4A6FC4;
	Fri,  1 Dec 2023 05:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09A4C433C9;
	Fri,  1 Dec 2023 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701409400;
	bh=6sMeY93ms6fPD3cyS25qVVh5+8+aMjpl27NnFtOQ4YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADa8Ma8zdT9RYLBuGmS00EbJSC2pkQUF9x2/Jg5Ht1RbtWZ0/vfnbrgKkOPnCebDC
	 nVDrhJwyD5UClFbNwZDxHRC6HE7E10K8WhvRXVMePjIM2WMZLTO3zZXNU42CtO5O0X
	 UsZbfrvvRfiKPiP3SfuXno+EMDFZ5cxODpiHDL+0IcJd3YNDjQNQDm92VBbGpQPcbn
	 CRcB1mXV2NOYPT9XNEOTFUQvI7cD1bI49vcKbxxz+UuOdc7Lf8ru74joJY9IxQCBYW
	 q7kc2wgZ//jxvnbbcMuIh0KCrG0Kce7sbCOEvi2sV2NiK6EG6IHflXyzabR+hxHr3C
	 ugZuve0/PY7bA==
Date: Fri, 1 Dec 2023 11:13:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Can Guo <quic_cang@quicinc.com>
Cc: bvanassche@acm.org, adrian.hunter@intel.com, vkoul@kernel.org,
	beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 07/10] scsi: ufs: ufs-qcom: Check return value of
 phy_set_mode_ext()
Message-ID: <20231201054304.GB4009@thinkpad>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
 <1701407001-471-8-git-send-email-quic_cang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701407001-471-8-git-send-email-quic_cang@quicinc.com>

On Thu, Nov 30, 2023 at 09:03:17PM -0800, Can Guo wrote:
> In ufs_qcom_power_up_sequence(), check return value of phy_set_mode_ext()
> and stop proceeding if phy_set_mode_ext() fails.
> 
> Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 543939c..ee3f07a 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -475,7 +475,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  		return ret;
>  	}
>  
> -	phy_set_mode_ext(phy, mode, host->phy_gear);
> +	ret = phy_set_mode_ext(phy, mode, host->phy_gear);
> +	if (ret)
> +		goto out_disable_phy;
>  
>  	/* power on phy - start serdes and phy's power and clocks */
>  	ret = phy_power_on(phy);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

