Return-Path: <linux-scsi+bounces-25959-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rr7aJ2qpUGo53AIAu9opvQ
	(envelope-from <linux-scsi+bounces-25959-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 10:12:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E91CE738516
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 10:12:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i+5pTI2W;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25959-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25959-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A45F303CE95
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC913C81AF;
	Fri, 10 Jul 2026 08:06:37 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B383CF695;
	Fri, 10 Jul 2026 08:06:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670797; cv=none; b=WzZwwULW7gpseyWmvZ2smJrc7Ae2KHh3wdQlCcuI9tOQKB0S7WsfQPETav5eHy04E8LJLvxHiL0m/1siyhom2JF0YD/Q3BH7tY9+whGSP5zXO4U2UBB1y4bwX+kKUUaQSdYra2fb+trC813Bft3mNwmkB0jBlTCuti5BmNEtiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670797; c=relaxed/simple;
	bh=eNTmM0PRvrTstyEVyUTL5S7tZKuiELAL7ZHn9iKKfAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHDROnXbbegJgT25HCOA2d92HUBZ8UW+xuNq45CEyCPQTwOFBlkyh2J7G8UvWqJ9PL5Q+8pTFIyZpkg2UIZaZcoU3VMYvo9tBkITdbnYbB3+DveAHIzeTpK1Vhpva52MiTdMKhNZ73HIZLKw2j+7uzPJYb/2kV5bZiZYDqbuvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+5pTI2W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE711F000E9;
	Fri, 10 Jul 2026 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783670795;
	bh=062AOf4xy6IUNKse36CRvbnErAbVR7CgdWYuOF6vhh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i+5pTI2WdjZrb0yN2gFjVpwAlTm+tVO8fhEDvBeeGkWI0j+zDddFUTHGYDTVjbeNq
	 P7HoxRNsvYrfYliGb3zV6FU8cz7cNnRMrhTWzOIa1XNAAa473/Q/JUP8f+e2JjWO+7
	 nv1u1P1hubCUDJExkTMWH0lSW+Brqb2Ym8mf/gMGI3RDkWQT8+HVG85/Pktb46JApF
	 3WX0HZHiUjPz0miROg/Tbb8prFgfyPleW/bFdDU+21JWQYvp//ELy6ymJU3w9VdD/8
	 Upzyx6zNNe59qiRneDcuW7EMDTLTx7nNwmBbavhqMZRkp3YSftddhRKLUcq+gyeAFG
	 6sQNO51EBfSJA==
Date: Fri, 10 Jul 2026 10:06:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ata: libata-scsi: terminate deferred commands on
 time out
Message-ID: <alCoB5FOGJTljbjU@fedora>
References: <20260710000646.1202200-1-dlemoal@kernel.org>
 <20260710000646.1202200-2-dlemoal@kernel.org>
 <20260710002431.3148D1F000E9@smtp.kernel.org>
 <724b4a01-e396-4cc0-be2a-9860f42d803f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724b4a01-e396-4cc0-be2a-9860f42d803f@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25959-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cassel@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:sashiko-reviews@lists.linux.dev,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedora:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E91CE738516

On Fri, Jul 10, 2026 at 04:25:38PM +0900, Damien Le Moal wrote:
> > [Severity: High]
> > Does this function need to set ATA_PFLAG_EH_PENDING?
> > 
> > Because this flag is not set, ata_port_eh_scheduled() will evaluate to
> > false. This allows the block layer to immediately retry the requeued
> > commands, which __ata_scsi_queuecmd() will accept and re-defer, keeping
> > the host busy.
> 
> No it will not because this is called with SCSI EH already waiting to run, so
> newly incoming commands are not passed down by the scsi layer.

Could you please point to specific functions + lines in the code?

AFAICT, I don't see how SCSI EH is waiting to run when
scsi_eh_scmd_add() has not yet been called.

Note that all the places that currently call ata_scsi_requeue_deferred_qc()
are called when ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS
(ata_port_eh_scheduled() evaluates to true).

We could add an WARN_ON(!ata_port_eh_scheduled) in ata_scsi_requeue_deferred_qc()
and we would never see the warning.

With the new function ata_scsi_port_eh_timed_out(), AFAICT, it can call
ata_scsi_requeue_deferred_qc() before ata_port_eh_scheduled() evaluates to true.

See e.g. the commit message for:
e20e81a24a4d ("ata: libata-core: do not issue non-internal commands once EH is pending")
of why I think __ata_scsi_queuecmd() will accept new commands.


Kind regards,
Niklas

