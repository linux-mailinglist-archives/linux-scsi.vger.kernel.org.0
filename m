Return-Path: <linux-scsi+bounces-1860-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB283A177
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jan 2024 06:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BBE1F24246
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jan 2024 05:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC9D308;
	Wed, 24 Jan 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="F0BpVUTY"
X-Original-To: linux-scsi@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AF8465
	for <linux-scsi@vger.kernel.org>; Wed, 24 Jan 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074889; cv=none; b=eWt8bD3O2+8FJ8ADIwVYuChkPNF26kP16bsdPSlDp4+p2b1Bdx7EUYcZBatJlXiHYdzIpAJLlgoA3b6BKQskczGwlYrEg4KpI1jeD/HNy++OM0TFL5YaeoNaLb1vqqnXe2eKUbZWf2phbTXfPJjdHXbtt2K43qz350fMZ5oOWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074889; c=relaxed/simple;
	bh=RLLxUdkDPBsC4Vc8m/92Z8uc3PsBrwkuLEFD0qAnxk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz4/nfPUY62Qw9uWlI3bXypa/FLu3vL9drUomVwLJxvTCCwWzWlsseC1EI+ScOyOKCUgWR9a2pWIDoJ9XU4rFJYERcFevw/COoX1Dnba1a8RbL8wgwi/i9ry5eSekfIpRIMCJ4HlW/qBkNhirfFoW0g6HK3AsOwHL9ZTAodpA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=F0BpVUTY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-122-36.bstnma.fios.verizon.net [173.48.122.36])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40O5aZSQ021415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 00:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706074597; bh=sRhoaUO93OYOZ4Mh1rIvfQPvG6ITdq3qLbPLkxj4DZc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=F0BpVUTYIIq9DhD6RIMbtl8UtRyoZOfiiIWalFE4m3/nj+EyRGTrwU07sQz/KoWal
	 NpwtarN3J7R0VIgTAZxNMn3j1CcW3B17QaYGzOmNRp+6OKAtvZqKBwWOCGFOh6NikM
	 NjSG7Ek2kdVd08NvNoixsHjp72hiUpfCLyRR5H/fkOVd0EKbl0mlsmdiQyV/KrMt8S
	 VlENNQZuzuAQAmho+7Lw/Nb0AaHZVmCdD4cPY7xQFtiETbaRjXgBCh9I1UYcfFDzNH
	 HWTSjgdWUITuD/nyJOFZe0PRnXoXMgy98sSEevoH28zJJCQMS239VPFd3TJk/qhuI3
	 8d6NgA4oLWMew==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E029415C04DD; Wed, 24 Jan 2024 00:36:34 -0500 (EST)
Date: Wed, 24 Jan 2024 00:36:34 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, G@mit.edu,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
Message-ID: <20240124053634.GD1452899@mit.edu>
References: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
 <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
 <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
 <20240121063038.GA1452899@mit.edu>
 <CAHk-=whhvPKxpRrZPOnjiKPVqWYC3OVKdGy5Z3joEk4vjbTh6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whhvPKxpRrZPOnjiKPVqWYC3OVKdGy5Z3joEk4vjbTh6Q@mail.gmail.com>

On Sun, Jan 21, 2024 at 10:48:35AM -0800, Linus Torvalds wrote:
> On Sat, 20 Jan 2024 at 22:30, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Linus, you haven't been complaining about my key, which hopefully
> > means that I'm not causing you headaches
> 
> Well, honestly, while I pointed out that if everybody was expiring
> keys, I'd have this headache once or twice a week, the reality is that
> pretty much nobody is. There's James, you, and a handful of others.
> 
> So in practice, I hit this every couple of months, not weekly. And if
> I can pick up updates from the usual sources, it's all fine. James'
> setup just doesn't match anybody elses, so it's grating.

If we told those people who wantg to pursue key rotation to just
always upload keys to the Kernel keyring, using the instructions
here[1], and at the beginning of each merge window, you updated your
local clone of the kernel keyring git repo[2], and then ran the
scripts/korg-refresh-keys, the headache to you would be limited to
running "cd ~/git/korg-pgpkeys ; git pull ;
./scripts/korg-refresh-keys" every 2 or 3 months.  The work you'd have
to do would be a fixed amount of work, even if more people were using
PGP key rotation.

[1] https://korg.docs.kernel.org/pgpkeys.html
[2] https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Would that be an acceptable (hopefully minimal!) amount of annoyance
for you?

					- Ted

