Return-Path: <linux-scsi+bounces-4049-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E589718E
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 15:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8EB28B837
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Apr 2024 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088051487F8;
	Wed,  3 Apr 2024 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfbCHv/6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092E286A6
	for <linux-scsi@vger.kernel.org>; Wed,  3 Apr 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152224; cv=none; b=Z48IFiY3XhEJ8+65rGru5l4ekCDGGAqr3D+E06TW1gcZnENndz8udM2Ek3b8loWfxwYeJhUJnV6mrqUaCjaWXsaDfMjUmYe2qq5m4GqvsgjHGYO6n1A9tIxGBMzNzvY37svn37NAqNxgahANv6mWoLndhtBtE9MFgXhB4dNzYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152224; c=relaxed/simple;
	bh=X2XAS/oTqinlQY0bqWZ9HdUjhcK3j05vJH/5bNcOweY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCm5xQ4MRsOVFDM2Gi9DHqAJQ69efRgbT17qf31DobG+KuT8PSxYfbyXu9cfQtFlV8BOtQiUeBIpPMzcfm0CanWxrLL7+8luGZfR8qs8qQ6IBRqN8blDsIyMBJGxwEIeWq9KTCPNZ0cl/Kgj3SyczN8BMcR8pYKPUSkbijrrPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CfbCHv/6; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4827021a12.1
        for <linux-scsi@vger.kernel.org>; Wed, 03 Apr 2024 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712152223; x=1712757023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f7pIzWrkcLxbGwLKhe5BWqkH4QaoGIyBQXlY1niD1ok=;
        b=CfbCHv/6SIBCP1W72SXIpI4tjNL00nPcURc0KlN7pXRYdfRnQrWcBTC0ARABICVeUQ
         DJuDL7aC7W6+KpB95X5mGEBTy84QWkRzIoYBEygT3LK5k/GLKYf5/EYQ561R3Px3Vu+G
         5acaV4S/9j1d3Z2IP+xGbUmqVLds3dt3XLN9GnWwchtdQFPAQFkZhkzwqmpRpK9GWQw/
         BjqdIy7lkvwxwl5uhI3hCCdIq1uHDpM+YYTBsY555YFKhYZ8UJI6UjiDIPFCAY1GZbly
         Ij/KfL0GviUiDC4ZgxuE8YYRQ1TTQkJe/2Dc503l5PjJC9rHc9TExb7TmVuLAMJ6a2CN
         N4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152223; x=1712757023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7pIzWrkcLxbGwLKhe5BWqkH4QaoGIyBQXlY1niD1ok=;
        b=fgndKyU16LTtHvl/0i1wTZh8ZXqY69wbFZCVGsW2R43R9bmwIUc7V6D2Jsts36T7zS
         EjuxrljCx7oJkGxiHBDCOq2huaUVlc0G2EKPJJUKDBF7zYeQmhjpcC/JF0K20kRDqIBt
         +kGHLXBhU0MHJdKXrnH3+UdCTD9wcTrxykPPMhaOdWvZnTqsoDFV5z344Q3fv9HigAGb
         xy98Xt2ZW7vNUbm+5A256EguGpr6FRO2s4spqp8fXY8lDHTcsQuOuMJKbw1LhMezwhZY
         CNe/bMhLbbtvhE5t6X6x1nhihE0mLtPt6AQ/Coyp45nediGBX2q6ZqLTTrQ8PvcWV/VC
         GUUg==
X-Forwarded-Encrypted: i=1; AJvYcCVpvQ0UFga1PEUtzDPLpxdRqLNoY6SV8xQx3UHQTqaVCZyJTe5UpibcUQEJh60iHUMjAGf+Iwlg7D6W5eAzzvZ/fQSOb5b9K3YzIw==
X-Gm-Message-State: AOJu0YzfxX3l0Jq8n49aF6g15J9dWXH1T6AtUnGcAH1l5X0wo0lqOkk0
	vAJldF4d8ET3ZqEFDVUzJ/NCTYKn5+MyMX8Ch9GRCXCuFqHLEP48TGSZU/SyfQ==
X-Google-Smtp-Source: AGHT+IFDdfRiUaNJoLcOr55g0unal8pZiJ3WGx9PpUBA19tgVAi/tYPRzvUz9AfJy4wzh0i9HRnXeA==
X-Received: by 2002:a17:90a:4b8e:b0:2a2:6e60:b53c with SMTP id i14-20020a17090a4b8e00b002a26e60b53cmr3886528pjh.20.1712152222504;
        Wed, 03 Apr 2024 06:50:22 -0700 (PDT)
Received: from thinkpad ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a34ca00b0029b9954a02asm2196137pjf.0.2024.04.03.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:50:22 -0700 (PDT)
Date: Wed, 3 Apr 2024 19:20:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Andy Gross <andy.gross@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8996: Add missing UFS host
 controller reset
Message-ID: <20240403135015.GN25309@thinkpad>
References: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
 <20240129-ufs-core-reset-fix-v1-3-7ac628aa735f@linaro.org>
 <CAA8EJpphzwoCaetGfnM8dE478ic1-BMqXKA3XVLeC9j5BBu3SA@mail.gmail.com>
 <20240130065550.GF32821@thinkpad>
 <CAA8EJpqZYp0C8rT8E=LoVo9fispLNhBn8CEgx1-iMqN_2MQXfg@mail.gmail.com>
 <g4a6gl47kfjx47ww36qnwp7zgvbd5gi5r7d26ibitfrybaa3l4@gvnz2mhsdf4s>
 <CAA8EJppOPrSfD=VkHm8M0P07=mN_BikT=cGvLe6UFL3OpKVWzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJppOPrSfD=VkHm8M0P07=mN_BikT=cGvLe6UFL3OpKVWzA@mail.gmail.com>

On Tue, Apr 02, 2024 at 10:25:32PM +0300, Dmitry Baryshkov wrote:
> On Tue, 2 Apr 2024 at 20:35, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Fri, Feb 09, 2024 at 10:16:25PM +0200, Dmitry Baryshkov wrote:
> > > On Tue, 30 Jan 2024 at 08:55, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Mon, Jan 29, 2024 at 11:44:15AM +0200, Dmitry Baryshkov wrote:
> > > > > On Mon, 29 Jan 2024 at 09:55, Manivannan Sadhasivam
> > > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > >
> > > > > > UFS host controller reset is required for the drivers to properly reset the
> > > > > > controller. Hence, add it.
> > > > > >
> > > > > > Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > >
> > > > > I think I had issues previously when I attempted to reset the
> > > > > controller, but it might be because of the incomplete clocks
> > > > > programming. Let met check whether it works first.
> > > > >
> > > >
> > > > Sure. Please let me know.
> > >
> > > With the clocking fixes in place (I'll send them in a few minutes) and
> > > with this patch the UFS breaks in the following way:
> > >
> >
> > Was this further reviewed/investigated? What would you like me to do
> > with this patch?
> 
> I'd say, hold until we can understand what is going on.
> 
> Mani, If you have any ideas what can be causing the issue, I'm open to
> testing any ideas or any patches from your side.
> Judging that the UFS breaks after toggling the reset, we might be
> missing some setup steps.
> 

I've bombarded the Qcom UFS team with too many questions, but didn't get answer
for all of them. And this is one of those questions.

Let me try to dig further and come back.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

