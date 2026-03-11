Return-Path: <linux-scsi+bounces-21870-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPR4GKDgsWm2GgAAu9opvQ
	(envelope-from <linux-scsi+bounces-21870-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 22:37:36 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF1926A7DC
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 22:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A52530451D7
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 21:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C0B348479;
	Wed, 11 Mar 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx21Hlgq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312B175A73;
	Wed, 11 Mar 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265050; cv=none; b=AvZCtez7Noi58kyFJHpyI2DqIwjDQ1YtMLqr7LLFpCgxMtNfo9b+nsKt/9k7kYYZy0L9Inpv05r+b55NVPDQp6Sffg8espNmLgYrnIfGIWzQ0oVqXJx2iaeYINgqr7a503sb6RKFw2uN8mhnQeNxpiSwPRMBrUzG6uc4SCWtYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265050; c=relaxed/simple;
	bh=ORQzYJ3u6URHD61tJ2SgGSNAbElHdRC0qUDT7hNEH6w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f8MrGTJBz/Kalsl417RY/+Fp6GrxxljUpp/7+JNM2R9nCdQm1zvrrzdyK2mPJkgPN2ICApvAoFUVgS2Wv2xCLJz/7vXYo6LbTEtYTF2eVm0Btb7vYGv9lYhzE4EBvO3gTVFQvfzH2m30g1xmDFlEKamiPAfcuJ4hcSycKjgQHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx21Hlgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2F5C4CEF7;
	Wed, 11 Mar 2026 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773265050;
	bh=ORQzYJ3u6URHD61tJ2SgGSNAbElHdRC0qUDT7hNEH6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nx21HlgqQ6VZ+y2Us6LdjW0RQ1hUYuC/0bmVaTeszZWdDsxJXElSuZzXoBCgyp6lH
	 jkh4i3oqF5ejljyM9fxUvcxj9oxeg8UU+1E9TR7bIWP49btl8XpKIauCxvHL8Hqi31
	 ihrwzBSdj6MiSGNo13Ur5xHwp/QSl6B+gwVfZ5QBbfohbZZv3sFgFfxJGRmNIeIGGw
	 pQYDAxGrh5txU1Yy3u1G5RL6av0A6kpJpSIiqUd14kk4wKEG3r7qUzhsGwa7ilKUfy
	 CzEYKpkz2z7TfiJ5j33hP9tOJezEAhDjDne7ZorrYnrSH502PK93L9wcFogEh54tlq
	 roZ0rovRgelGA==
Date: Wed, 11 Mar 2026 16:37:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: David Jeffery <djeffery@redhat.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Tarun Sahu <tarunsahu@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	=?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
	Jordan Richards <jordanrichards@google.com>,
	Ewan Milne <emilne@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"Lombardi, Maurizio" <mlombard@redhat.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH 2/5] driver core: separate function to shutdown one device
Message-ID: <20260311213728.GA1024689@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932d4e59-395f-4022-a2de-874fdea778ac@acm.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21870-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lists.linux.dev,linuxfoundation.org,kernel.org,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[llvm.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFF1926A7DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 11:00:11AM -0700, Bart Van Assche wrote:
> On 3/11/26 10:12 AM, David Jeffery wrote:
> > +static void shutdown_one_device(struct device *dev)
> > +{
> > +	/* hold lock to avoid race with probe/release */
> > +	if (dev->parent && dev->bus && dev->bus->need_parent_lock)
> > +		device_lock(dev->parent);
> > +	device_lock(dev);
> > +
> > +	/* Don't allow any more runtime suspends */
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_barrier(dev);
> > +
> > +	if (dev->class && dev->class->shutdown_pre) {
> > +		if (initcall_debug)
> > +			dev_info(dev, "shutdown_pre\n");
> > +		dev->class->shutdown_pre(dev);
> > +	}
> > +	if (dev->bus && dev->bus->shutdown) {
> > +		if (initcall_debug)
> > +			dev_info(dev, "shutdown\n");
> > +		dev->bus->shutdown(dev);
> > +	} else if (dev->driver && dev->driver->shutdown) {
> > +		if (initcall_debug)
> > +			dev_info(dev, "shutdown\n");
> > +		dev->driver->shutdown(dev);
> > +	}
> > +
> > +	device_unlock(dev);
> > +	if (dev->parent && dev->bus && dev->bus->need_parent_lock)
> > +		device_unlock(dev->parent);
> > +
> > +	put_device(dev->parent);
> > +	put_device(dev);
> > +}
> 
> Please keep the following code in the caller:
> 
> 	if (dev->parent && dev->bus && dev->bus->need_parent_lock)
> 		device_lock(dev->parent);
> 
> 	if (dev->parent && dev->bus && dev->bus->need_parent_lock)
> 		device_unlock(dev->parent);
> 
> 	put_device(dev->parent);
> 	put_device(dev);

Can you elaborate on this a little bit?  I can see that doing this in
the caller is simpler in some ways, although there are two callers
that would need this.  Maybe it's just the lock anti-pattern below?

> Additionally, please make sure that the caller is made compatible with
> lock context analysis (see also
> https://lore.kernel.org/all/20250206181711.1902989-1-elver@google.com/).
> All that is required to make this code compatible with lock context
> analysis is to organize it as follows:
> 
> 	if (dev->parent && dev->bus && dev->bus->need_parent_lock) {
> 		device_lock(dev->parent);
> 		shutdown_one_device(dev);
> 		device_unlock(dev->parent);
> 	} else {
> 		shutdown_one_device(dev);
> 	}

I guess avoiding the "conditional acquisition and later conditional
release" pattern mentioned at [1] is what makes this compatible with
lock context analysis?

I guess this is another way of expressing the "no conditionally held
locks" rule [2], which is more concise and fits better in my pea
brain.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/context-analysis.rst?id=v7.0-rc1#n42
[2] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html#no-conditionally-held-locks

