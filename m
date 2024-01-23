Return-Path: <linux-scsi+bounces-1835-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FF2839182
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jan 2024 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D947E1C2262C
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jan 2024 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9A50A64;
	Tue, 23 Jan 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUnOFEmh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE95026F
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jan 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020587; cv=none; b=uDPEYKu+EjmfJZkdKkbaOvXx1AG9EwY0KNCOunS2AWgWiMkoF56IkWtNEn7W5GpEnKxGqEaOhHQSaO0x0BFx284pSKidA9XDPLbYU8vC3Fyeq1upVjDFGGpMCYF/Rvsy5UXTB8vCvXXpEbdS1EHOmMQRz5+zdOGUxMEjK1rQlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020587; c=relaxed/simple;
	bh=KCs4dAp32MVQLZSoY2iIieFhYKhRLJochENga8+TbuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebre6GsLwA5RZv9u8sAX/GjNRrJY14O67bD4eldkaQM50hpVmMPNtlCWjulnUIpy/4idJCXJV0Dk4dQDbXcHmczRmeivBg4KbmUocRVww5cQ2Tvq8Vlm0jBT/IbwP5HPPYD6Ljetev2b3W9BsTZCCDvUWxi9+vreoG0AEc+cA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MUnOFEmh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2901ac9ba23so2321688a91.3
        for <linux-scsi@vger.kernel.org>; Tue, 23 Jan 2024 06:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706020584; x=1706625384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rKLcX29OWFYkuH0PtL6skunmUTEl57ir3ALlBCZtCIg=;
        b=MUnOFEmhB7wF8yZ1PzLMURL6mGxwLg01uUmmEmuQRObueJEszmlwgSbyvoRAXeoLUE
         5698oTM+2QNuim6SpKtaXTIQS3vaPiL3tppYusLlPVWGIQ1HxGnTCtL/pXobMVr7lC8F
         /wftkxM2PgOFyqoRlFPPcX2Rio7k6F4VlENwn2z/HzAYaZk0CpwXzWpEP+648U+y2LZA
         FveiHdJeqkZnr5kQAru3RleOTpKCZRAkLzG/RlLLfM8isV7s7Y8IpqgGTS06M4E/Lh6L
         OKp6q+d47rK9yn3/KdtZstpLTI36XUFj9tU5QggO3QAAF2adLc7HTi2qafSIvQA80mnI
         JEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020584; x=1706625384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKLcX29OWFYkuH0PtL6skunmUTEl57ir3ALlBCZtCIg=;
        b=CZCKFYmv8M2Aiphkep6z7SXSel66JRTEwfGNj7EWyJBAhDNdqpxEn7r2pYZPeG/OCX
         8NPaHMhb2rbozvJKmYEfAteKwrpbP96NvXU0E+w9cyh8aSnGY71owG7pVKEAeJ2m6nqs
         UM1v1SlsKUAM9piBr7q5mcdKt/jDsN5lRtqB+PinNO7aibaZQ415JiBq9eNFOfpejcHC
         0v0ZtI5CsWRVPBtYcNXbN4pJMx7reWFhSrLbdX+DRgR4iB1+p5CObR+tcBbIb55Xxl0S
         AVlg8POy1fxKxG8hrQElJnCWLViP1EAFiSNjHDuvMzMJP6KrBAxPn2WxjG6WOr2PLUdb
         mU3w==
X-Gm-Message-State: AOJu0YwDvlA363VvWjnykCI87xD7p8WB4O4tjg//bnHQQCk21gLLZGtM
	QFBINOaVCuzC3EcXjtL8eXgkqgyl0LEElqh6P3rSDQQbnTCT7eMStowERE2o1g==
X-Google-Smtp-Source: AGHT+IG3dsJ0nsLlvmUVmSWeW+v5Fy3gNBcQs+lxHbj0zWkZJViAOBXM3/pSyKOuORy9MvCzY5aF2w==
X-Received: by 2002:a17:90a:989:b0:28e:96b:f8ca with SMTP id 9-20020a17090a098900b0028e096bf8camr2500428pjo.55.1706020584262;
        Tue, 23 Jan 2024 06:36:24 -0800 (PST)
Received: from thinkpad ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090ad40500b0028e01ddb6c2sm12027335pju.12.2024.01.23.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:36:23 -0800 (PST)
Date: Tue, 23 Jan 2024 20:06:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] scsi: ufs: qcom: avoid re-init quirk when gears
 match
Message-ID: <20240123143615.GD19029@thinkpad>
References: <20240119185537.3091366-11-echanude@redhat.com>
 <3xnedre2d32rkad6n2ln4rrah7sgg6epxnzsdm54uab3zrutnz@fww7wb5mvykj>
 <otgj6524k6wiy27depeo7ckopmrr2v3xdnaoph4c5djjohnpmg@f7hyetygcyyr>
 <graeyylgohsukni35djpbxibnz5ya7laqvsydharkzcktv2iwz@knbu5uq5fa4x>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <graeyylgohsukni35djpbxibnz5ya7laqvsydharkzcktv2iwz@knbu5uq5fa4x>

On Fri, Jan 19, 2024 at 04:33:10PM -0500, Eric Chanudet wrote:
> On Fri, Jan 19, 2024 at 02:33:32PM -0600, Andrew Halaney wrote:
> > On Fri, Jan 19, 2024 at 02:07:15PM -0600, Andrew Halaney wrote:
> > > On Fri, Jan 19, 2024 at 01:55:47PM -0500, Eric Chanudet wrote:
> > > > On sa8775p-ride, probing the hba will go through the
> > > > UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH path although the power info
> > > > are same during the second init.
> > > > 
> > > > If the host is at least v4, ufs_qcom_get_hs_gear() picked the highest
> > > > supported gear when setting the host_params. After the negotiation, if
> > > > the host and device are on the same gear, it is the highest gear
> > > > supported between the two. Skip the re-init to save some time.
> > > > 
> > > > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > > > ---
> > > > 
> > > > "trace_event=ufs:ufshcd_init" reports the time spent where the re-init
> > > > quirk is performed. On sa8775p-ride:
> > > > Baseline:
> > > >   0.355879: ufshcd_init: 1d84000.ufs: took 103377 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
> > > > With this patch:
> > > >   0.297676: ufshcd_init: 1d84000.ufs: took 43553 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
> > > > 
> > > >  drivers/ufs/host/ufs-qcom.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > > index 39eef470f8fa..f9f161340e78 100644
> > > > --- a/drivers/ufs/host/ufs-qcom.c
> > > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > > @@ -738,8 +738,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
> > > >  		 * the second init can program the optimal PHY settings. This allows one to start
> > > >  		 * the first init with either the minimum or the maximum support gear.
> > > >  		 */
> > > > -		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
> > > > +		if (hba->ufshcd_state == UFSHCD_STATE_RESET) {
> > > > +			if (host->hw_ver.major >= 0x4 &&
> > > 
> > > Is this check really necessary?
> 
> I *think* so.
> 
> For example, if hw_ver < 4, ufs_qcom_set_phy_gear() has a comment saying
> "power up the PHY using minimum supported gear (UFS_HS_G2). Switching to
> max gear will be performed during reinit if supported."
> 
> > > 
> > > The initial phy_gear state is something like this (my phrasing of
> > > ufs_qcom_set_phy_gear()):
> > > 
> > >     if hw_ver < 4:
> > >         # Comments about powering up with minimum gear (with no
> > >         # reasoning in the comment afaict), and mentions switching
> > >         # to higher gear in reinit quirk. This is opposite of the later
> > >         # versions which start at the max and scale down
> > >         phy_gear = UFS_HS_G2
> 
> IIUC, the device would not be able to negotiate a gear higher than the
> minimum set for the phy_gear on initialization.
> 
> ufshcd_init_host_params() and ufs_qcom_get_hs_gear() both set the
> controller <v4 host_params to G3. So if the device is HS capable, the
> re-init would set G3, instead of the G2 selected by
> ufs_qcom_set_phy_gear().
> 

REINIT quirk is applicable for controllers starting from v4 only, because legacy
controllers don't need separate PHY init sequences. So you can get rid of that
check.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

