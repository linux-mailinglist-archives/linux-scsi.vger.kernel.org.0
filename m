Return-Path: <linux-scsi+bounces-25494-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id COJTBn7/Rmp5gQsAu9opvQ
	(envelope-from <linux-scsi+bounces-25494-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 02:17:02 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840386FD940
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 02:17:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DuxZiwoV;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25494-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25494-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82778302AF29
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 00:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848F918A6D4;
	Fri,  3 Jul 2026 00:16:57 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE92E63C;
	Fri,  3 Jul 2026 00:16:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037817; cv=none; b=F81VeSgnwq25uZm9ME4TexznnBAtwXXmV4kmA+6W9+91KtXTNb+WMGWadgHBQ0Tl4zoTbwEuJeP0ETgZgwJdQqUYS7wdlS/1KW8v6GSrog4aSnIXHNKBpbXzszp/2M4zzGazxtNvVhXDAWeCuijvUXmxcbzyWI74TMsN64z6XA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037817; c=relaxed/simple;
	bh=69FQsKX3+4/1yrf/5KTMcmvdnr3ijU3Jo92ghzSu3z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBrmzzELupBFuWWqYXldqy8/Xo79pdond/bLdkWq8/+3lso4FaCnl/zydFN8UpG/36RjIKjXeC28qVXo2BDASnTZa5cMZbSZ7HDTULFD1frh3SmSoP4k3fQnLIdfcvS0s+HBsu/fh7+WMEZYR7YpTEp/8HQJe97oPMX+K8AKJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuxZiwoV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801741F000E9;
	Fri,  3 Jul 2026 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783037816;
	bh=/LVC6Hmw6zMzHK5fUXwnxznVg9uaG7qwXcwGvD26sKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DuxZiwoVDzLb+2WqWHJo4iFuN5oSe2E+SNo5krcuygPlnGgdmVQ/Mc5Fe2zJiBadm
	 DW2np4Cl9iUluvG/cJYBiDs6+KPeX0GKHNrtm8S75QlOdOZEvreSnuqQuRi3dBU2Fk
	 EcGvPn1j+kOFTBbEnfChUNLvj60buJ7PAcfNdLIALjFVQKStya+VO10YCUb7GQNgAI
	 r8GnFzlevfDRZ3O6FwHyJND1Yeo8sRjGGbApD6QAS1Xy8TcWft+JODRLkw+dmp8vbs
	 kasKyK7y/2Hk4cyFjH7HWPFw6AI7YwIgSiBdRE0JXje8qc+VdSLzbynUxxziUeU+R1
	 FjAIuyOex/Hwg==
Date: Fri, 3 Jul 2026 00:16:53 +0000
From: Yixun Lan <dlan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] scsi: ufs: spacemit: k3: Add UFS Host Controller
 driver
Message-ID: <20260703001653-GKB35811@kernel.org>
References: <20260702-08-k3-ufs-support-v1-0-1a64a3ab128f@kernel.org>
 <20260702-08-k3-ufs-support-v1-2-1a64a3ab128f@kernel.org>
 <c49d9bea7f9a172a97d0acfaa9680bdac80f75e1.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c49d9bea7f9a172a97d0acfaa9680bdac80f75e1.camel@pengutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25494-lists,linux-scsi=lfdr.de];
	FORGED_SENDER(0.00)[dlan@kernel.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:p.zabel@pengutronix.de,m:alim.akhtar@samsung.com,m:avri.altman@sandisk.com,m:bvanassche@acm.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-scsi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 840386FD940

Hi Philipp,
 Thanks for your review

On 09:53 Thu 02 Jul     , Philipp Zabel wrote:
> On Do, 2026-07-02 at 02:31 +0000, Yixun Lan wrote:
> > SpacemiT K3 SoC consist of UFS (Universal Flash Storage) Host Controller
> > which has features compatible with JEDEC UFS 2.2, MIPI UniPro v1.61 and
> > M-PHY v3.0 standard.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  drivers/ufs/host/Kconfig        |  12 +
> >  drivers/ufs/host/Makefile       |   1 +
> >  drivers/ufs/host/ufs-spacemit.c | 931 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/ufs/host/ufs-spacemit.h |  90 ++++
> >  4 files changed, 1034 insertions(+)
> > 
> [...]
> > --- /dev/null
> > +++ b/drivers/ufs/host/ufs-spacemit.c
> > @@ -0,0 +1,931 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2026 SpacemiT (Hangzhou) Technology Co. Ltd
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> 
> Missing #include <linux/reset.h> for
> devm_reset_control_get_optional_exclusive_deasserted() below.
> Don't rely on indirect includes.
> 
Will add in next version

> [...]
> > +/**
> > + * ufs_spacemit_init - init phy and prepare clk
> > + * @hba: host controller instance
> > + */
> > +static int ufs_spacemit_init(struct ufs_hba *hba)
> > +{
> > +	int err = 0;
> > +	struct device *dev = hba->dev;
> > +	struct ufs_spacemit_host *host;
> > +
> > +	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> > +	if (!host)
> > +		return -ENOMEM;
> > +
> > +	host->rst = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> 
> Why is this stored in struct ufs_spacemit_host at all? As far as I can
> see it is never used again, so this could be a local variable.
> 
Ok, will make it a local variable

> [...]
> > diff --git a/drivers/ufs/host/ufs-spacemit.h b/drivers/ufs/host/ufs-spacemit.h
> > new file mode 100644
> > index 000000000000..6ae3c263a360
> > --- /dev/null
> > +++ b/drivers/ufs/host/ufs-spacemit.h
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * SpacemiT UFS Host Controller driver
> > + *
> > + * Copyright (c) 2026 SpacemiT (Hangzhou) Technology Co. Ltd
> > + */
> > +
> > +#ifndef _UFS_SPACEMIT_H_
> > +#define _UFS_SPACEMIT_H_
> > +
> > +#include <linux/reset-controller.h>
> 
> Drop this, we are not implementing a reset controller driver here.
> 
Ok

> > +#include <linux/reset.h>
> 
> You could replace this with a struct reset_control forward declaration.
> Or drop it ...
> 
Will drop it

> [...]
> > +struct ufs_spacemit_host {
> > +	struct ufs_hba *hba;
> > +	struct ufs_pa_layer_attr dev_req_params;
> > +	struct reset_control *rst;
> 
> ... if you end up removing the rst field entirely.
> 
Yes, I will remove it

-- 
Yixun Lan (dlan)

