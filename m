Return-Path: <linux-scsi+bounces-15730-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DDFB172E2
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Jul 2025 16:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC5C16F84A
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Jul 2025 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE582D1F61;
	Thu, 31 Jul 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVlzUc49"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A62C327C;
	Thu, 31 Jul 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970997; cv=none; b=R3GJxOTnlUbhVfxECyIOMWN+WYGe3HN/8SrVPNvWiJZ9Tn/r7lvxIQM7dpDdTcAiO6fnakzLRzcLYVAXVibiLY4NOVgAhK/y1aoC55sbcJEz1i7AhDWV6v0NjoaZF+t2PGjDOzcin3aUMdzh3ExiXqS7QwAfB08ppq5GdRP73Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970997; c=relaxed/simple;
	bh=4ckXLUcQZWuhpX7TQln+X9HK9J5VqakPRCNMdtfv1Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRQd1UyHxSeALwLrxa6iPabkXLMoXfwgi30Zdpis+LQ4i6mwX4+7rfTJINDtf6oFyefEFE52/DZDUNGa7RZL2tJcl8MMi9jLVoPxkAzvat+BPKTJdLgEiZHVNKeskQQONmRWHKw0aFAJLw1ytjYoTZiHr11mVOZWn5yyUxSR7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVlzUc49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE5FC4CEEF;
	Thu, 31 Jul 2025 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753970996;
	bh=4ckXLUcQZWuhpX7TQln+X9HK9J5VqakPRCNMdtfv1Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVlzUc49RRm8vqrxmeXNbKIhB1Sc0+GQq97exspTp8tl0Jg6bxqcyh6nWeU69Iomr
	 Dd5avAdxDVXDV9Q8Lw0Goamf7acl6QZh7dM0f8jqLDM3FGGBpg5LZcuTGc9hOKbUmM
	 m25J/KjRWoRmf28O0R7ka7sToUgejXIUBmQG4gV8TS6efQk3X2rJ37is0STzQDhMUS
	 6lK3Sc1HSmc0GI1eAURGgV/TBcmmUVPZ2Uut6AK7boQMNArDhtv2TQTzgWPD/IFhA5
	 1uemOiOwths/U8Y0LIkfJYR6F6JBPdtX/G+t3Xy07sgc5gjUQERvectZGhrbPiQVXs
	 r98Ty/c7Dnwyg==
Date: Thu, 31 Jul 2025 19:39:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
Subject: Re: [PATCH 0/2] dt-bindings: ufs: qcom: Split SC7280 and similar
 into separate file
Message-ID: <qemlydifa7u3zwrjnnp7umjsprjrje27ghzghyyoutufeyiimn@g2ejdt72opz3>
References: <20250730-dt-bindings-ufs-qcom-v1-0-4cec9ff202dc@linaro.org>
 <df8b3c85-d572-4cee-863b-35fe6a5ed9ff@quicinc.com>
 <6ebe7084-bb00-4fac-b64d-e08e188f3005@kernel.org>
 <148b46f3-2109-4c15-b7d8-17963b38095a@quicinc.com>
 <1547e339-5be2-4d87-ab35-98a9be0d250e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547e339-5be2-4d87-ab35-98a9be0d250e@kernel.org>

On Thu, Jul 31, 2025 at 09:04:48AM GMT, Krzysztof Kozlowski wrote:
> On 31/07/2025 08:59, Nitin Rawat wrote:
> >> Hm?
> >>
> >>>
> >>> For reference, only SM8650 and SM8750 currently support MCQ, though more
> >>> targets may be added later.
> >>
> >> Are you sure? Are you claiming that SM8550 hardware does not support MCQ?
> > 
> > Offcourse I can say that because I am working on Qualcomm UFS Driver.
> 
> Qualcomm sent many patches which were not related to hardware at all,
> just based on drivers, so my question is completely valid based on
> previous experience with Qualcomm.
> 

SM8550 indeed doesn't support MCQ. Even though it is based on UFSHCD 4.x, it
doesn't support MCQ due to hardware design. MCQ support only starts from SM8650.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

