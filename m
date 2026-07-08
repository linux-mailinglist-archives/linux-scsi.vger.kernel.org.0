Return-Path: <linux-scsi+bounces-25880-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rw9eF1DaTWqm/AEAu9opvQ
	(envelope-from <linux-scsi+bounces-25880-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 07:04:16 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93A721B04
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 07:04:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nQoZBOMg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25880-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25880-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FDC4300F7A6
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jul 2026 05:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515637CD3D;
	Wed,  8 Jul 2026 05:03:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0631355C
	for <linux-scsi@vger.kernel.org>; Wed,  8 Jul 2026 05:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487024; cv=none; b=PJtd69KkhARTvc08Fnoml+BTHvuoQUGAvyDLzew5xj91VqCZOiQjZIgpMnPccMzRklo6CA+Ga/le2Yl6ei82y1JGTfbmxwmV5min6YtuiGHIzvUfRCkv6ar5cnwc/cs1/kdqsbN9Z2iZZjEcWvvTBNoe3cFW93SD+wVAPrItIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487024; c=relaxed/simple;
	bh=RQOHhXbKwc8W8FochQlrUNE0GGyFfgJBfX9YuyMTUN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj5IdoJsALW1k6kmLavUMnRhXFAi3s80ba+Fv3nxn04Zm0spliLYovLDc/UKMGaSEcLCPdwYDmrGY0NiCoqXncy1biM2s3ON5tNDv2VlJnpzCGbiDpxVafpxhyPhquiuC0jrJ+JuinEbVL56mm/VH3xL+NO385J8wlkDXsdTtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQoZBOMg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7760F1F000E9;
	Wed,  8 Jul 2026 05:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783487023;
	bh=TNa4U3jglo78ontyKQhgBMpIF+HRlYDxGd4Kb8y1Z20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nQoZBOMgaJknnUj6bd20y8LZEKW05zEG6M1dPkA369WTu0PI7+o9088K7NtjQOdkb
	 zInVPqJ/KQqDCQ6ylQKsr4fDWiIs2Gr+vnqo6U/6R1Vqrm8FgLc5EMAlWGGUwAu+6y
	 jbH9Txc7E2+g5RXrXn9zazlAjt88hlIgUtSKEeBvKW95FFqJ2G2yEsWDlPQ3J5g9vC
	 gxsJTzpt1NvgJKIczbnRpPQYHQLRAjvVUFXOsJNcr6keK0DbfLIcGl9NcZDNncxmWK
	 mnYN/4GoKjaGrGtleJCyeZRi0xiikTmH0Cxh3bdFUCvurk387IHM7IaNPkMUSFpNdX
	 TV0WmdiNmPnjw==
Date: Wed, 8 Jul 2026 07:03:37 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Avri Altman <avri.altman@sandisk.com>, linux-scsi@vger.kernel.org
Subject: Re: Undeliverable: Re: [PATCH v2] scsi: ufs: core: Avoid possible
 memory reclaim deadlock in TX EQTR context
Message-ID: <yvqoymvwzy32dsvlease33e3dgapx2j6c2nebmbd3llanneh7x@lswksso2l6tg>
References: <20260618140941.902000-1-can.guo@oss.qualcomm.com>
 <h5lsilzmxhu3jyujladib3w75nsute7yrkr4t5sg57nwzwb2ek@d4btnbylvrvu>
 <f1960bd5-b583-4104-a343-e217ef7ed63d@SJ0PR04MB7504.namprd04.prod.outlook.com>
 <ucn5winjeqnixycuxldp3wgysrasrah4ie5egs4vo4prvy7e5c@6ef4y2gqqd7x>
 <20f076dd-636a-49f9-9a02-0046af2db0e2@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20f076dd-636a-49f9-9a02-0046af2db0e2@acm.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJ_BOUNCE_WORDS(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:avri.altman@sandisk.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25880-lists,linux-scsi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-scsi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A93A721B04

On Tue, Jul 07, 2026 at 09:41:34AM -0700, Bart Van Assche wrote:
> On 7/7/26 9:29 AM, Manivannan Sadhasivam wrote:
> > Are you willing to continue your role as UFS reviewer? If so, could you please
> > fix your email address to avoid bouncing?
> > 
> > I can also send a patch for that if you want. Let me know!
> 
> Please take a look at upstream commit b65b608eb8ff ("scsi: mailmap:
> Update Avri Altman's email address").
> 

Ah ok!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

