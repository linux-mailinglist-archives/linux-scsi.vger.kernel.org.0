Return-Path: <linux-scsi+bounces-22506-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCkpIjsixGmZwgQAu9opvQ
	(envelope-from <linux-scsi+bounces-22506-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2026 18:58:19 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2121332A300
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2026 18:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31427300B3D4
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2026 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CDA40F8C1;
	Wed, 25 Mar 2026 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YBpqKbsh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qyY290+x"
X-Original-To: linux-scsi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739740B6D9;
	Wed, 25 Mar 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461376; cv=none; b=oKFRMV1JDdQBYf+ImtxnT8xSsfkM9UNujqrmKNka51NIbVwJFOBBnd/YewhhFVRRuzYJ1iNq26xWs/7Xtv12FpHvO+UNTnuhhId8pCPrSEG/5DPt16ak2cbs0zKCTxyKfRlU0R9ypF/Homb/7EHoZxflc2WlHZlDcnT9Zu9SPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461376; c=relaxed/simple;
	bh=qIDB0pkXXhpWuA6IMGIwjkFUKCqT5y7d6umUfVlCn5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsRtsD2NSu1ScERAP90d88NbBrEth/IQJVirbMgka1kCzQ5HTOcDHaE9s0wMNrJf+SBRv9Y9ciV+Y0RsHoXazyT0ShjcZsoT+sWUTxDrzxakb0ZgJUYTBWbfXakw4aCInJP77e3iUPQQD1gPOH6RVddaMdTNuxo0Ss/XX3CJbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YBpqKbsh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qyY290+x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Mar 2026 18:56:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774461372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIqxshH5v/kqlkka5Fys70biUG8RbxH1oZ71KulCzLQ=;
	b=YBpqKbshdPlJu3AcoWLnrzsRC6Ae0uS2dqj2hZm8sV6kAQm3/9diR/7/tSvamk/9Pkdoz/
	wlR2YU5NWAUDcQPIpkRnrAAfRuyzHYT4QsYzDJA8dLamlFNRPMZZMJkgsumccvDxFNZaMq
	cB98imsYRGVW8rE/9ZAxMHMlWVEZgxhJM11Tw8sb0A7gDjCt4HUnIjFl9yD8/WNlzncSJn
	jSyp8mt860DgWw4Tvmh6xil4RZ6uZFYWySQU4MDIUJJUgPVVkXteBRGkpyEZSAo1zTyopO
	bJy6d4+BFz8BGh/5ScpGP2u/eoqDGNxhzUZgw6SA1U5ZyKHR8k6cyvfnLRHCyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774461372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIqxshH5v/kqlkka5Fys70biUG8RbxH1oZ71KulCzLQ=;
	b=qyY290+xc963pc4I0oYLTElTPEXP2NuJR8oeKQMMe8AFVQx8op8IjKmEt8+Qbck1ImR392
	W+6IV1teDdeXYVAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 00/12] blk: honor isolcpus configuration
Message-ID: <20260325175610.eY-VHHPS@linutronix.de>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22506-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2121332A300
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2025-09-05 16:59:46 [+0200], Daniel Wagner wrote:
> The main changes in this version are
>=20
>   - merged the mapping algorithm into the existing code
>   - dropping a bunch of SCSI drivers update
>=20
> With the merging of the isolcpus-aware mapping code, there is a change in
> how the resulting CPU=E2=80=93hctx mapping looks for systems with identic=
al CPUs
> (non-hyperthreaded CPUs). My understanding is that it shouldn't matter,
> but the devil is in the details.
=E2=80=A6

I have been just made aware of this. It is still not merged so let me
ask the questions before it is too late.
What is purpose of managed_irq? Doesn't this sort of aligns with this?
It was originally introduce to limit the number of nvme interrupts which
can have multiple interrupts but don't need to use all of them. virtio
is using it.  Yet I don't see an affect if I use isolcpus=3Dmanaged_irq,X.

I would expect that it limits the number of used interrupts as intended
by this series. The only affect I see is that once the CPU goes off/on
the assigned CPU mask is restored.

What do I miss?

Sebastian

