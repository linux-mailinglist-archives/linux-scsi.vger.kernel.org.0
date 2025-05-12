Return-Path: <linux-scsi+bounces-14062-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEC7AB30B0
	for <lists+linux-scsi@lfdr.de>; Mon, 12 May 2025 09:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625B9166E03
	for <lists+linux-scsi@lfdr.de>; Mon, 12 May 2025 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB204256C79;
	Mon, 12 May 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tm9kUkgM"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227252AD11
	for <linux-scsi@vger.kernel.org>; Mon, 12 May 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747035679; cv=none; b=GZjMwnoLIUdhjeRKiVYikWf75BOL/OmfV2sv1208fAMIu7E+XG7w1lZ4sMxiXVKtEI44X76iSKTtASqbkEMu3SFRpooV49yKhVliBmeqI5OltVBfKnKOfsjLgcTNGv6N00TkN/VumB1pE5sbAdv+ME/4gJyba0caDn0tuByAnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747035679; c=relaxed/simple;
	bh=yZ0CGA29M3rcJ+MvhLe+QeIcohtu6StaRYQuN2haPIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiZQM//dcFg4Q1i/iZ8XAX8NFsnuX0wyKdT2FRlvRIx2BeRpxmpp9H6d7CHsXBMoCPbMPQY8/W8KviLSzQoDi73EA5LfqEeIM1e9KaDejc+uOaC+txZNZi49ghVaU4/Hddokdhx9zP+iRsXj6zb85dv2Wua1Yq7lfRparVN1Bbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tm9kUkgM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BKQxp3016522
	for <linux-scsi@vger.kernel.org>; Mon, 12 May 2025 07:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=07H7J1WxUG240fs/pO939g9t
	ouj+8gGhAGiadw9TC9M=; b=Tm9kUkgMjp9XD0j7794zYjC7Kxhh1QR6KXzGcaA8
	+43GUr4yz4Sx8zIBf6Pf0hjlZ8HdtTLqUTNtdqPuZdkVqs3fWT3Dz/X3Y0xt9U9C
	2QYkWYRPl7l9rJsiPFj6C8NcxLXwnNfmkBvHi78ynvvTpRzzCkKL4ns3fdhbB1R8
	K3VqOor2CfWQpQspWtEpBh9q/kNm3VsPg/csw6i5GLjRhE/SNRSas7124NPsQNWl
	kPH23mVKSkes+j+RKRHnRwkxXvJPwVBmdgnVqPl3ts9jRFg2/Bn/VLYItZKbF2dS
	ZvwPNDIpB1GIxzRx2+ELxYyO2UfaO8EgmX9TxPRmGfseWw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hy15uh9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Mon, 12 May 2025 07:41:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3086107d023so4569063a91.2
        for <linux-scsi@vger.kernel.org>; Mon, 12 May 2025 00:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747035676; x=1747640476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07H7J1WxUG240fs/pO939g9touj+8gGhAGiadw9TC9M=;
        b=XfjU5du0whTYHEpSz7BXZWk20hMwsHT0Xnv9boM+IjjcsPmYTxInkWAtq/jpUH31rJ
         IpbY7tPz5760XVEOmbzp0FPGFAFVvd/5Re6/vnWpPZyv2+tJ94RUzJocrKlkZ4CGuXVT
         t41YJTpkDs7GTrLIm9QUlYBdiZ21PslO939i6YBBLcvD5Da0WrDVNJQIP5Vq8vM0Kpk4
         mWw76aEbBKi0kIe0pAOwIDx1P+YbxYFAh1H/J9nMnsAgcy1A/AyrVJhh+C+UZr+HRNYf
         xsjfKE6wUv0d/6tqzxwze9sd1Uah/DNbEqylH3mBrkl7vTEqLbgvHhmdgcX+mUQxC52y
         /8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXcg2QEZevPD50Y89FWC5Ob/22zfJmnM3VlPL76Dt2rfDTi1Wayr1W4K8S3lrBk+O6UZTM6kZyeAvXS@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMFLBZG97diJQ54qhoyLZkm4PNAGgYM9xUJieY+SaOcUowvmJ
	VY6SuFLT3FmlGIRkKayqV7dazVkDS1O8o2gViv9exh3H0Q8nL+TJ+BnPKDbY41PQ49qpHPBWsl+
	Ro+LP6cVmjzFG5Kkda8V2SLCauvfEf5cvazGpxNOaIVca/m3BnqNwpo8CX723
X-Gm-Gg: ASbGncsPBnV2rDYfUBVhwhd1Nd3N1t+PNOtJ0jKKMrwQOABbWiS4smJrFoCJvBIudwf
	3cikFW5h28+p2g1iiPILMvS65eFJzwQNyjplFetouwPSCMKksR1adsRa1+LMUfQjOs5foc6fZkG
	I48KvfaupiPM8ZLwN5yJg59BjTMd+wVmTLlt5Vta9lotOe5eo7hc0ELxlrxv8kjznXVIyi0HLdK
	k7j+6oN142MeR+8Qv3mZ1e1m3Ok6Q28NoHKn5SO+papEJcbJK/r7w1/t82EwKkereS7Qb+MW8sk
	z/66rcNDCACz5WUU1tP0u1WKNfZ6
X-Received: by 2002:a17:90b:2d06:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-30c3d2e2e67mr21168295a91.15.1747035675991;
        Mon, 12 May 2025 00:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWuL72ZS+7tugxJHglTxQK96hvhpMFxtO0vu/JY9uRC/XDAlkU5cQR07NvobNtlJ6mInbyg==
X-Received: by 2002:a17:90b:2d06:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-30c3d2e2e67mr21168238a91.15.1747035675558;
        Mon, 12 May 2025 00:41:15 -0700 (PDT)
Received: from hu-pkondeti-hyd ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e76062sm6007792a91.44.2025.05.12.00.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 00:41:15 -0700 (PDT)
Date: Mon, 12 May 2025 13:11:08 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, krzk+dt@kernel.org,
        robh@kernel.org, mani@kernel.org, conor+dt@kernel.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        beanhuo@micron.com, peter.wang@mediatek.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/3] scsi: ufs: dt-bindings: Document UFS Disable LPM
 property
Message-ID: <852e3d10-5bf8-4b2e-9447-fe15c1aaf3ba@quicinc.com>
References: <20250506163705.31518-1-quic_nitirawa@quicinc.com>
 <20250506163705.31518-2-quic_nitirawa@quicinc.com>
 <667e43a7-a33c-491b-83ca-fe06a2a5d9c3@kernel.org>
 <9974cf1d-6929-4c7f-8472-fd19c7a40b12@quicinc.com>
 <8ebe4439-eab8-456a-ac91-b53956eab633@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ebe4439-eab8-456a-ac91-b53956eab633@quicinc.com>
X-Proofpoint-GUID: 1zirDhkVIcpkM85AZtvxP5VuszywjTNe
X-Proofpoint-ORIG-GUID: 1zirDhkVIcpkM85AZtvxP5VuszywjTNe
X-Authority-Analysis: v=2.4 cv=P9U6hjAu c=1 sm=1 tr=0 ts=6821a61d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=gDD5y9GCQ-Lx19kb1DEA:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA4MCBTYWx0ZWRfX2BLUWGIHU4qP
 pIUQXHJCwk1vY47L1Kf1FkFX3QLv4QyRSN5ZSMG6odkdYJR9QH5zuyWho7BnAY0IoGfTvBVAVdm
 +hoOJ3Fycvz7LtpBtPL+QdbORf8Rc6y8jLoj7tq2A3YMYuSFNccNkvM10nEuEl4xPd72FvlS65C
 fu08li/8RGStK2ND0IikR4+Yy6q6rn3Tkwy66r1BtYTBpNwJ8D00HflHbpk/7mkj/BcM1ZvdSS8
 0V53XBtXhbGISIbpWa1LIGOhNz+eUo8TmjaHcF+Z/fCh0PGaqDXJGMO7rQ7c2ZK+R4P0OkqI2O2
 6b/Bi0bygIjCtwJfdAkguz2D7lDI3BPiHtppXqEHe8NL0UBZdRkT0S5v93GRa2J3jin6Hv2Jpr8
 RCeo0/jL3XCG2eb2G6CDIYKlWoc14Pf7oOnYyAnwrtjSfBMIthrwMZ5ATPUxMd59Tc85ot7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120080

On Mon, May 12, 2025 at 09:45:49AM +0530, Nitin Rawat wrote:
> 
> 
> On 5/7/2025 8:34 PM, Nitin Rawat wrote:
> > 
> > 
> > On 5/6/2025 11:46 PM, Krzysztof Kozlowski wrote:
> > > On 06/05/2025 18:37, Nitin Rawat wrote:
> > > > Disable UFS low power mode on emulation FPGA platforms or other
> > > > platforms
> > > 
> > > Why wouldn't you like to test LPM also on FPGA designs? I do not see
> > > here correlation.
> > 
> > Hi Krzysztof,
> > 
> > Since the FPGA platform doesn't support UFS Low Power Modes (such as the
> > AutoHibern8 feature specified in the UFS specification), I have included
> > this information in the hardware description (i.e dts).
> 
> 
> Hi Krzysztof,
> 
> Could you please share your thoughts on my above comment? If you still see
> concerns, I may need to consider other options like modparam.
> 

I understand why you are inclining towards the module param here. Before
we take that route,

Is it possible to use a different compatible (for ex: qcom,sm8650-emu-ufshc) for UFS controller
on the emulation platform and apply the quirk in the driver based on the device_get_match_data()
based detection?

Thanks,
Pavan

