Return-Path: <linux-scsi+bounces-22042-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGGkJuTZt2mcWAEAu9opvQ
	(envelope-from <linux-scsi+bounces-22042-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 11:22:28 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C7297D48
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 11:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B11F3032643
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921438F25F;
	Mon, 16 Mar 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDAiyRhI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034593859E8;
	Mon, 16 Mar 2026 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656445; cv=none; b=hBLZ+jqShbROh7euT4kIrICI0UblNsE8D+emGKPsjP9d4mhd+zIa/ibnJ8jnu0Tpj6Sg2Ng27K0i2IJ6po1b2a/r10tx1fVCpJiQZ2P6TUQGej/sld1X2tz1U4hRRbn/cN6FZmuGQr8D0DvHiLbitTgwtX+2njvI7r1Q4h1RLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656445; c=relaxed/simple;
	bh=uBu8mLZ+rpt9hHO2zebFJ320GkM1XA33y5mwSl91uXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox6UpvQqKyIkLpUH3vCLxPEy8SI8r5w6B3by97RRGjSHrp9tScSf9K42g/mHpz6YXSf3pH0CI1JAa2l/GqPyQI9QVr2TogWpAurvomtJQR1vpdrmDmSYKg1+7QF9QuGWzIgokdtQkDe/+8pqwvNydEscKbIIW2pkdmHLEf3Lprg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDAiyRhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DBDC19421;
	Mon, 16 Mar 2026 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773656444;
	bh=uBu8mLZ+rpt9hHO2zebFJ320GkM1XA33y5mwSl91uXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDAiyRhIXd16/3n5yLWqFADfP+XReuxaog2CvKttjDc2OI/QYNL4mwF+CIqtaO3Xt
	 nVCnBO2veL3YHcW2M/al3N7NNdtQxG3RK5+PzYo5tgFWUbuZFWefrbgmebUobo/FqX
	 E/7Jvw9UXMob3HhGf9JzB083MJy5xifdVTNGSQRDwUsTi6kWbzYkuEDGBF2AZBIsUu
	 EsisgrMjf/pATcn8oakB9tMAm9J+p2kpQDMFFBWhJesBObIOEijxO7+S/94gcXri5W
	 HwaihjisMgWQuD8/WV5d3I2sSQcn1UBREtld7gk+oOAmDJ3ndKabxfbaj/+Z5VDOrJ
	 jGpDyanxyr9GA==
Date: Mon, 16 Mar 2026 11:20:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: (V)FS: Second Round of Invites Sent
Message-ID: <20260316-gebiss-drehkreuz-1f3f0e7a96df@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260225-aufeinander-kummervoll-1953a06beae9@brauner>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225-aufeinander-kummervoll-1953a06beae9@brauner>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22042-lists,linux-scsi=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F3C7297D48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Feb 25, 2026 at 03:52:23PM +0100, Christian Brauner wrote:
> Hey everyone,
> 
> I sent out the first round of invites for the (V)FS track.
> The first batch is also the largest batch. We will send out a set of
> smaller invites later.

Hey everyone,

I sent out the second and last batch of invites for the (V)FS track.
I've also sent out declined invitation notices. In case you have
received neither it is to be treated as a declined invitation at this
point.

Should any attendees be unable to attend because of... events... we may
be able to notify people on the list but it will likely be very short
notice unfortunately.

Thanks!
Christian

