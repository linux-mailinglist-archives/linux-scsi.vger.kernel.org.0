Return-Path: <linux-scsi+bounces-22656-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPaHFYgVzWmMZwYAu9opvQ
	(envelope-from <linux-scsi+bounces-22656-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 14:54:32 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB237ACBE
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 14:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A9E30E2978
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Apr 2026 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F040F8C2;
	Wed,  1 Apr 2026 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ow5ot4/7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOp4tiVP"
X-Original-To: linux-scsi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61056408237;
	Wed,  1 Apr 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046554; cv=none; b=BHWGSY0Kfrf74kvlDvtakFzGZ68ocFFT8g51GkHVaxFf1t180cNwqRPrd5ECAlpnsui30pscdEDfxoyH795+tGIq4fqK1Z3KbArVF97fUlH5iJW1JZG3q4XA3X1tN/VtLRLYCQG0GTpegaYSMsMGx+7Oya/7TmH2M1S7XJdFzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046554; c=relaxed/simple;
	bh=pM9A3xWVLYKkCp+v4Zndq3piKQEjl5Ao/07hnkVmhfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNBpqvmZAKZ43QiiiqBnJr144xBmAqAgLXcovTm+Qp2BEY9OyKHdo2cMjY0CLKsrKyvDNPEthhBZL2J5UotKkkMybMCiY5wcWYhY9BPxP0ldD4NzDKKMdk/vdPArXCYqN8lAJZTmAtC26YIkhz3/qNd9jZkEc+lkXQk1R2/Ga7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ow5ot4/7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOp4tiVP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 1 Apr 2026 14:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775046550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz9yqm2xW/wCQ4BGxlKJbUUSrjAgVJCbne2YOojl5Rw=;
	b=ow5ot4/7H/V7sxugopOVzfq11RiQLgEIk56AtHOX8C9k31weT2EEv8mH8fvgN6XwYwTQqZ
	tdJI0PSbur5wNsxwwoc6yijnh24YFaQv8uIxVAKyEwSnQEWHH6l0giXU8QkfojzVYXXVqu
	v2KZBOOZFLZ6wrdW0zffbyoO2S9QMlAyMxmOUFcJCi1MXikAtg86Zrb9LaUMzpD/CsUh6l
	cD3dMQ+SsLhhXvq3TCeq1lI9B/827qksmzgVsCvkcpwssOiEkUj4uSBuuQmee/AiBPD0fs
	84szdnT0eeoe4HOWtjS56WEmQsRSlTkhaKTxK0ecWHlqA4R53xIx+ybnBi6gtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775046550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz9yqm2xW/wCQ4BGxlKJbUUSrjAgVJCbne2YOojl5Rw=;
	b=qOp4tiVPsDEo2clqFhCTqobVu13lAnk+NbJ72USET8+2h2SlZW/GB06+cnnw27aZZhJtqQ
	3AXCmSfon7P8jrCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org,
	longman@redhat.com, chenridong@huawei.com, hare@suse.de,
	kch@nvidia.com, ming.lei@redhat.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v9 02/13] lib/group_cpus: remove dead !SMP code
Message-ID: <20260401122908.hxUnR63u@linutronix.de>
References: <20260330221047.630206-1-atomlin@atomlin.com>
 <20260330221047.630206-3-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330221047.630206-3-atomlin@atomlin.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22656-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,lst.de,grimberg.me,redhat.com,microsemi.com,hansenpartnership.com,oracle.com,h-partners.com,broadcom.com,cloud.ionos.com,infradead.org,linaro.org,linux-foundation.org,huawei.com,gmail.com,suse.de,nvidia.com,abita.co,ashe.io,suse.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 96EB237ACBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-30 18:10:36 [-0400], Aaron Tomlin wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> The support for the !SMP configuration has been removed from the core by
> commit cac5cefbade9 ("sched/smp: Make SMP unconditional").

!SMP is not dead code here. You can very much compile a !SMP kernel at
which point the code below will be used. It is more that the sched
department decided that scheduler's maintenance will be easier since we
don't have to deal with !SMP case anymore.

If you wish to remove the !SMP case here you need to argue as such.

> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

The previous patch, this one and probably the following lack a
Signed-off-by line with your name.

Sebastian

