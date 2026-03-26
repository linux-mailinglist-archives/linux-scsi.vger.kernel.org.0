Return-Path: <linux-scsi+bounces-22513-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLkWA4zjxGnz4gQAu9opvQ
	(envelope-from <linux-scsi+bounces-22513-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Mar 2026 08:43:08 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D863308FB
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Mar 2026 08:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AD4E301D56F
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Mar 2026 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECBF34D4E0;
	Thu, 26 Mar 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eECZh1Xm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iO5XW1w6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3072349B16;
	Thu, 26 Mar 2026 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510950; cv=none; b=OT/w5d2CDxuZ9qwXMfRmfp02Cjr5mCwav8h9rp3BAuabOFrUc0vnXudE2iEdUTKf6ZsWUBis5VoQvYMd30H8lAyGJJe/zqOWLZF36Y63zxsyFGZLXbDCIBep34xjH7lwL4ceBMHY3cqki35AF8UZQv5+dvY6B41AeH/Yhm4BXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510950; c=relaxed/simple;
	bh=7N9TgMHFraFeVXNYuCdXIWNYZyWpOEPnK8jVkVQJ6hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEmk0/Pfz9MoOiXHrEyUcdMor6F4S3A6H9Y5jv0G4acXxUPSPhUM0Z4nELSii3DRJPgmJmYaUm5lUCofCQbUhOq+DqV4Y/3VHmkDkMMv10fhkAkN5Feh5k/XDwyLnX3/+Bu1glD80mtYit7HaLU6NS5Syu1iOukif0ZkE/YFFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eECZh1Xm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iO5XW1w6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Mar 2026 08:42:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774510946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N9TgMHFraFeVXNYuCdXIWNYZyWpOEPnK8jVkVQJ6hE=;
	b=eECZh1XmFpbS/h9sFHnwIGna1GvmUDCfAQos+dQQy7vFseAryD3PG2r+4/8b/emKKRMzwS
	8LGqJ4r4v6+y8ZKKanGxCPKCIBssfvTma4uzQw4ZshiS7FHtoMK6wQPHxIlX9XVIJNnBYP
	bXwQq+8vaWWg+WwvJOG0qRrChj5DSbHX8gr5GLfupappv2IMcd1ZpHdjhhWZoSCHhjpDfv
	zrUzLji2YpahDUDw1RkApR4NE8YjXy5z1qu92ZIvt9Yy04sdkvSqNz0jjcYTKI0Z6ERIGx
	52MNEAYHp5O2fczO/e/Kl+BKhD8eLOJdfm2pZDexQ3S0safZtZFfABr4/3TeqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774510946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N9TgMHFraFeVXNYuCdXIWNYZyWpOEPnK8jVkVQJ6hE=;
	b=iO5XW1w6drYoyeU0YbS1Z+G+BkXpW8c24lsR431Gzrtv2oMWBBW5UxNVZLKJXv9QwZwxdz
	ym3bWlXVBEdmDXBA==
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
Message-ID: <20260326074224.eEozcjTE@linutronix.de>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20260325175610.eY-VHHPS@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260325175610.eY-VHHPS@linutronix.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22513-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 10D863308FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-25 18:56:13 [+0100], To Daniel Wagner wrote:
> I have been just made aware of this. It is still not merged so let me
> ask the questions before it is too late.
> What is purpose of managed_irq? Doesn't this sort of aligns with this?

No, it does not. I got the answers. Let me write that down. Move on then=E2=
=80=A6

Sebastian

