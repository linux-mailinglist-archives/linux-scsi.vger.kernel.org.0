Return-Path: <linux-scsi+bounces-23732-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KORNFBqIAmrVtwEAu9opvQ
	(envelope-from <linux-scsi+bounces-23732-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 03:53:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C5E5187D7
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 03:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F04030378B2
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126F2727E2;
	Tue, 12 May 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T84GAc2t"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE041754;
	Tue, 12 May 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550402; cv=none; b=k8GJP9Nmm9iVbPeS+5yqqr18W7q9Xq9WafjL3tIGYsGW07ivMi4I2j9ZCnYp8I0Jadte0jXCWfm4WH/4bsdG7pAatS6Wzs1Y1K6PIvZ1njBvfG0fw0Em0FnajgMZzH0jasN2iPPr+p55MS1DMR14XFxA3Wa92Ultzt173KRrTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550402; c=relaxed/simple;
	bh=7RCDKbmQRQvKIb4loCbj+GB8Hv/yHKezpm0LgUVaAOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuZgkBxZri8N8rjZCGJYMpGSP1q2QiZXi4IpKE3NIUamT5tx1yXJiwGRekMxOtbWeyIdCS1XcqTsWyfmUEKp3DyM68z0fMRTxjYiiloCEDQe1Oe1naesKseje5wPoCLTEhcfrjGYHu3VRxybf+trw5x3ffSEqFRbe7ENcueHNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T84GAc2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0946BC2BCB0;
	Tue, 12 May 2026 01:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778550402;
	bh=7RCDKbmQRQvKIb4loCbj+GB8Hv/yHKezpm0LgUVaAOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T84GAc2tgIjcMbWrP3Qnydxf/XM7mViiRSwr6Zb5C+oxoucBl3/CbzP88TUv4x8Cd
	 aVkdsKQbCjPkCm4Yh1vbMYJwvqGFqNjS8/YInza0zH0B2/6E8Mx8xydw7VJCPtEqeC
	 0TeNhDvzqbwfGfoZl43u3cukKQP4YraZrSxwpzW2PeAxpSHdNN6R27i2Hq6kff8BWw
	 iuU22H4TMgTGDwM7eoSOfcSb6NWw+6aJ4GlNKqxQZ+DfxBa740lHtx+87Jpxf9wYBJ
	 MMaQ438AgwWLy9rK4kB25C9Jtd+jaWreX9OZVi3e3+oT7LGNwmGsANM7mnti6KTgLk
	 Q/rS6gBKMfAJA==
Message-ID: <7f7126d4-0c8d-4f88-9ece-5bbfac2b47c7@kernel.org>
Date: Tue, 12 May 2026 10:46:39 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] ata: libata-scsi: add atapi_max_lun module
 parameter
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
References: <20260506234548.1974603-1-philpem@philpem.me.uk>
 <20260506234548.1974603-2-philpem@philpem.me.uk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260506234548.1974603-2-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F0C5E5187D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23732-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 08:45, Phil Pemberton wrote:
> Until now libata has hard-coded shost->max_lun = 1 for every ATA host,
> so the SCSI layer never scans past LUN 0.  This blocks support for
> the small handful of multi-LUN ATAPI devices (Panasonic LF-1195C and
> COMPAQ PD-1 PD/CD combos export CD on LUN 0 and PD on LUN 1; old
> Nakamichi MJ-x.y CD changers expose one LUN per disc slot, up to 7).
> 
> Introduce a libata module parameter, atapi_max_lun, that controls the
> upper bound of the per-host SCSI LUN scan.  Default is 1, preserving
> current behaviour exactly: out-of-the-box only LUN 0 is scanned.
> Range is clamped to 1..ATAPI_MAX_LUN (8, the SCSI-2 ceiling).
> 
> Subsequent patches gate actual LUN>0 probing on BLIST_FORCELUN, so a
> device must both be on the SCSI device list (or carry the appropriate
> quirk) and run on a host whose atapi_max_lun has been raised before
> any extra LUNs are scanned.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>

Looks good, but this does not apply to libata tree for-7.2 / for-next branch.
What is this based on ? Please rebase and resend as I would like to run some tests.

-- 
Damien Le Moal
Western Digital Research

