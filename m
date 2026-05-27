Return-Path: <linux-scsi+bounces-24128-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMNjIEy3Fmo6pwcAu9opvQ
	(envelope-from <linux-scsi+bounces-24128-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 11:20:12 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F855E1B3E
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 11:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF4A7305C58B
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBD3093D8;
	Wed, 27 May 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvbgJuBI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377B3E7161;
	Wed, 27 May 2026 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873337; cv=none; b=rZXt5PDQuoO/GTjR1YhZzlVAisQ+DpADgEelK20Hdp1Hvc76Oe3UPVUMamZm5WGDHV8m3CESmWGpZCGzYmJH6ILgdV1Z7QsmOW3PWtF9jaUfLMFEBndO1SdxSJSbb+Ba88O9Dm9f0FtoXEE5JF/ZgssAjcv40NcT7Fx+vii0pzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873337; c=relaxed/simple;
	bh=0S9GEXXOXre4z3r+Ir1TCMuiKeUShE8+jciE2dhB59E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2KxR3sYkx0XCZ+SKVoyaG1gkMJTz1MOwMAif5Do5y7MAiHSY6cROwtLX/0uJxRv5eKbOHw9UKMxwXp8EFIFTCtSUvjtzERQ8pxM/gFebr9O1ttqD30OF6tpYV0gRIcc/wpS6L4SAA6xXj9OgDYt3HBoeqfUKhmhpTi1ndowOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvbgJuBI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87391F000E9;
	Wed, 27 May 2026 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779873330;
	bh=TSTZULIe3wWh/E5sP56eqUogIJMtnNx6SpEWRzhi+WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NvbgJuBIw0PVPDh5z1tp8avbRj3xrjFA4gNme4vHofJ6qymcbib19XLd8O1Kjlacx
	 hdAWplxczLYUXJQaP5vM2OYqxmoircZsyOnn2zdZkWUVUBP2NtbE99GhLo2vpY+dE6
	 NvyBopLTnx7t4ESBSp5+4Uuzygb2oJq2lCMH1C/pv7qW+yyq2t2m8otL6+25LwXADa
	 UtPFkcoSF1KCUqykgFTfxPnmlQjrb6dEIgkNkRvgBIvGt2nyAd+42tdJd/YZx3r2BI
	 1Ff7vNN+9Oco06HBIYqJcXtZ9rIhVw1cG+W7cvcli6Md9fSzRVFmnn/j9fkQWHpyPv
	 43SJl2L8LDCFQ==
Date: Wed, 27 May 2026 11:15:23 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Can Guo <can.guo@oss.qualcomm.com>
Cc: bvanassche@acm.org, beanhuo@micron.com, peter.wang@mediatek.com, 
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, Zhaoming Luo <zhml@posteo.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: ufs: Document static TX Equalization
 settings properties
Message-ID: <qrqggwpuigevauuzjcvggcmbzkphutemlpsvuymy7qn5yblnsd@djbgzgyeekre>
References: <20260523134711.323425-1-can.guo@oss.qualcomm.com>
 <20260523134711.323425-2-can.guo@oss.qualcomm.com>
 <m6qq3kxgfs73jve2pjmmszymgxb7aizdfo2rwg72o66n2rvov2@xkcvifciwu3z>
 <96962564-ff25-4d81-a605-3d9c05fa000a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96962564-ff25-4d81-a605-3d9c05fa000a@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24128-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 24F855E1B3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 04:51:04PM +0800, Can Guo wrote:
> Hi Mani,
> 
> On 5/23/2026 10:14 PM, Manivannan Sadhasivam wrote:
> > On Sat, May 23, 2026 at 06:47:10AM -0700, Can Guo wrote:
> > > UFS v5.0/UFSHCI v5.0 add HS-G6 support (46.6 Gbps/lane) via UniPro v3.0
> > > and M-PHY v6.0. In these specs, TX Equalization is defined for all High
> > > Speed Gears (not only HS-G6) to compensate channel loss and improve signal
> > > integrity at high speed operation.
> > > 
> > > For HS-G6, M-PHY uses PAM4 1b1b line coding, Pre-Coding may also be
> > > required depending on channel characteristics.
> > > 
> > > Add vendor-neutral DT patternProperties:
> > > txeq-settings-g[1-6]
> > > 
> > > Each property is a uint32 array of per-lane tuples:
> > > (PreShoot, DeEmphasis, PrecodeEn)
> > > 
> > I don't think combining all EQ settings (PreShoot, DeEmphasis, PrecodeEn) in a
> > single property as opaque tuples is the right approach. These are three
> > semantically distinct parameters with independent value ranges. So packing
> > them into a uint32 array makes validation impossible in the schema.
> > 
> > AFACIS, PrecodeEn is applicable only to HS-G6 (PAM4), but the proposed
> > patternProperties forces it into G1-G5 tuples as well, which is semantically
> > wrong.
> Point taken for the PrecodeEn.
> > 
> > PCIe binding defines one property per data rate for EQ presets:
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L193
> > 
> > Similarly, UFS should define one property per gear per (like, txeq-preshoot-g6,
> > txeq-deemphasis-g6, txeq-precode-enable-g6,...) rather than clubbing everything
> > into opaque tuples.
> Thanks for the suggestion. I will go with below approach:
> 
> txeq-preshoot-g6 = <Host Lane 0 PreShoot, Device Lane 0 PreShoot, Host Lane
> 1 PreShoot, Device Lane 1 PreShoot>;
> txeq-deemphasis-g6 = <Host Lane 0 DeEmphasis, Device Lane 0 DeEmphasis, Host
> Lane 1 DeEmphasis, Device Lane 1 DeEmphasis>;
> txeq-precode-en-g6 = <Host Lane 0 PrecodeEn, Device Lane 0 PrecodeEn, Host
> Lane 1 PrecodeEn, Device Lane 1 PrecodeEn>;
> 

How about encoding Host and Device values in a single tuple. Like,

	txeq-preshoot-g6 = <Lane_0 Host_PreShoot Device_PreShoot>, <Lane 1...>,

- Mani

-- 
மணிவண்ணன் சதாசிவம்

