Return-Path: <linux-scsi+bounces-20970-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG19LtPvmWnQXQMAu9opvQ
	(envelope-from <linux-scsi+bounces-20970-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 21 Feb 2026 18:48:03 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F35416D6B7
	for <lists+linux-scsi@lfdr.de>; Sat, 21 Feb 2026 18:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11FBC3033383
	for <lists+linux-scsi@lfdr.de>; Sat, 21 Feb 2026 17:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E39330D22;
	Sat, 21 Feb 2026 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyhNHW29"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89AC2F39CE;
	Sat, 21 Feb 2026 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771696080; cv=none; b=eoMuKcj8zcvuakww2uIP4NVfBj3GToPm8sw/R8khHFbhQUObIZUFXszh09IYtJysLk5JNDD5CAPq/qYO3e3+RnuPgsYJDRAKYUevLinRLVVt2C197GCPzN8KRpLtwHUEQsc+Q8M7peomsAa/8PeZchJnF6UD8/R9TaJVQBYGOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771696080; c=relaxed/simple;
	bh=4kSvkddoRLlf4Sl9dPi1cbg858c6h700l6Keq7+pJZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiKPc5z/IbSk5DmVCczu/RmPQ83n33BHldUqL34uMkU6ubyGIILpTNaFRy+jMP94SQzCWHdq54/SN+AOtuwKpRLnlb5805GTgS3LtCakHyv7ajoQkTcMQRGZbN0vCLv3v9Q7Mrd96DVGOT6TfXkn3Da0RV9rQS8X/EHIzFTRQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyhNHW29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937F9C4CEF7;
	Sat, 21 Feb 2026 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771696079;
	bh=4kSvkddoRLlf4Sl9dPi1cbg858c6h700l6Keq7+pJZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyhNHW29F+qYJ6yM4kxO0Dtu4K2ATWMw7JnFkeMoP5Ic1t8PdhhuJtV2Y+Dus2060
	 vVmaq/YSoyLzz1WB38ozkHHuGhgZenl9IHa9LEwYWQaM8AjPv8oBSqanAScb+MadEH
	 UP7DWxkUFdASJ5aeyyIhCuFDE2Vgaz3g8TNlEOAGe1yv+rcsnYsGNE6Cl5MVdjPTyG
	 z2JmOUT4x7cES1clgR961FQB1ci3CjDrAZuXamjZVVxbniVBeG+2xbTa2ExhLSej44
	 P/tGWYFVGqnOePLY4YQcpNoDeK6e1ijxCDOG/fClW398hmoqMslbAWkM+S2hpgGJPS
	 0nkyKP0bkJj/A==
Date: Sat, 21 Feb 2026 12:47:58 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.g.garry@oracle.com>, lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
Message-ID: <aZnvzhCrt-2kgyfb@kernel.org>
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <b598c5c9-6732-4661-85b2-7ab10a0830d4@suse.de>
 <dbf5fbdd-8894-40b7-b574-0c6385995ec2@oracle.com>
 <a5a0aa42-33e4-401f-ad94-8104cff9368c@suse.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a0aa42-33e4-401f-ad94-8104cff9368c@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20970-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 2F35416D6B7
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 05:32:04PM +0100, Hannes Reinecke wrote:
> On 2/14/26 10:42, John Garry wrote:
> > On 13/02/2026 17:21, Hannes Reinecke wrote:
> > > > At ALPSS 25 I presented a proposal for Native SCSI multipath
> > > > support. Let's discuss this topic at LSFMM.
> > > > 
> > > > The idea for this is that SCSI could natively support multipath,
> > > > like how NVMe host driver does today. It is intended as an
> > > > alternative to dm- multipath support.
> > > > 
> > > > I have been working on the implementation and I plan to post
> > > > patches in the next cycle. I am looking at a 3-stage approach:
> > > > a. create a driver-agnostic multipath library, very heavily
> > > > based on NVMe host multipath support.
> > > > The library would support features such as path management, path
> > > > selection/iopolicy, failover recovery, PR, delayed removal,
> > > > gendisk management etc.
> > > > b. switch NVMe over to use this library
> > > > c. add native SCSI multipath support based on this common library
> > > > 
> > > Go for it, John!
> > > 
> > > I'd be very interested in that.
> > 
> > cheers, in the meantime, I have some comments:
> > 
> > - I need to test PRs for both NVMe and SCSI, any advice on that would be
> > good. I don't think that blktests covers it. I did see Christoph mention
> > a testsuite at: https://lore.kernel.org/linux-nvme/1438672271-11309-1-
> > git-send-email-hch@lst.de/ - I can check that.
> > 
> Well, you might have seen the discussion on the device-mapper list, where
> stefanha is implementing generic PRs for dm-multipathing.
> Or rather, trying to. We might need to revisit that and see what we
> could be doing on the SCSI side.
> Maybe we should be having a session about PRs at LSF?
> 
> > - I am still not sure on whether we require a multipath version of sg.
> > We can still have per-path sg. NVMe does have a multipath nvme-generic
> > dev, but that just handles IOCTLs/uring cmd, and nothing like sg read/
> > write fops
> > 
> 'sg' is primarily for testing 'raw' SCSI commands. (And dastardly complex to
> boot). I really would keep it in it's current form, and not
> try to mimick something with SCSI multipathing.
> 
> > - I have not tried to detangle ALUA support from SCSI DH, so no ALUA
> > support yet
> > 
> Ouch. But that is the key point of the implementation; ALUA provides
> _all_ the information required for multipathing, so how can you _not_
> have support for it?

Exactly: no ALUA support makes, whatever this is, completely useless.

