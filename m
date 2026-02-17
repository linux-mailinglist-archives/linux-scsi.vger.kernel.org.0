Return-Path: <linux-scsi+bounces-20915-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFKaCwBFlGmcBwIAu9opvQ
	(envelope-from <linux-scsi+bounces-20915-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Feb 2026 11:37:52 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B5814AE95
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Feb 2026 11:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CE7A30214F5
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Feb 2026 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67148326D5D;
	Tue, 17 Feb 2026 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dmYLmGrQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630D32694F
	for <linux-scsi@vger.kernel.org>; Tue, 17 Feb 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324655; cv=pass; b=lEm73GAycSHxe9Ve0CS36FWylg2UYANYHPtwy6Dza029FkAG2bhMHmc9r22NjfYsWCQG9ZK8t2bZJXgnOKbdwQgdHcKWiysRLGkwdEfn7vEOtZviPrhrxsy3Gx0qA+xD8AshNiSsHEfyKlAPxaPcUBAToAy5jTqIIXpODWYtfjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324655; c=relaxed/simple;
	bh=dPjtly+ZxqrcgnTcKSIFDHsF1hA5MWE73lwPbiR8+3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0fsjCO/bTjm3LZvTGfvj3RKqYnrmk93+fOmtDoV5chHdOxDkU0OzIlBKc9pwtC+wzDgIEuxSxqXZ/zGT6iKpoorpe+1hm+VLco9LHFNwYSmclbKavNRccoZy1GQo63mW7fyRyb/n/Qq/1QUjbNMIYSeR//Q2nT41Ua1KYfAmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dmYLmGrQ; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3870c7479c6so25852941fa.3
        for <linux-scsi@vger.kernel.org>; Tue, 17 Feb 2026 02:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771324652; cv=none;
        d=google.com; s=arc-20240605;
        b=aH6XcfQ+jWNMlGTIYNlIGj0e2wLsjD4G5Bwq4Om+mYufivORzALV8FaSmoIVN3tjrQ
         uLJKwLciPYnhgfn7uoL/iuXAduMEI9G8kkLMLNbmETWZQv+D5RANupOWgFWaq3J2yBY9
         9BeeHnzC9BGbVNMhuPYooFbqhTVYZyWhmaR94mFtdXmpmLxXFAZHTqz2xXb7ei16rJhH
         eytdshWGuUqUF0kaHHWE+WZkWcw1GmgWuZnJDKRy7Z7Ji1NvPHvgZzN2wUEYnjrayKPW
         5fRvcvMVvZR4gyFD8zBkdBsKzwOOGb3wt8JLSvlacoK04zP8f3pJ6nvfkYqKlh8d2jv4
         zOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        fh=Wq0Z0YfGvXIiZxspuv+SATtsswMJNTURSDGwHQvBtPg=;
        b=hi+8hytR7NKXX9IIiATjdCB2YjU8i8KnvPbSs/qfXl45kT612rTOaAr1HnxYLklhdI
         nzM1QHjosHYPnV/AbPHnyJZVc0ykd/JRuP0HAOifYWtl9A3ujJ1EAb43kqXe1DIyov/b
         CCJC/jDKHuXcq5XYCSR+Uz8AP+OZC6pMgHxP/IVA839/wE2SWvtGFV18HuCZshFhlP7v
         cuxCI44HXux0307hqHSjEr/XwdYB73uVJvg3xmSXoJxfyFJOTKbdjcZFzmSeSTsUy4/w
         PIVkhUjfI/1aSnTaBJwUQh8+DNQufbLL6CkLusZtWepaBwjayMdJMzOZ9En8voywSXor
         ChkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771324652; x=1771929452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=dmYLmGrQL6EpWGinGmazJYZO2mJYS/9YAtjKAkQYVsYcu67/5AA8mkj764LmfULiGy
         Bq1tyIlasq5pw9UoS4Sr+XCwvWTBbwX8s+hIVYntsZPYoiwNa3nVU4Db6qMzN0KObR5u
         +szP0cw+XNRlcTzTNf4B5GXh2CK1xmRAFYDmrGhbKeZ1DNZbm24/fY6wlyVWhzNOgLOX
         /tZInKxJH3v+wzSCU2v2Mk1DEhlRMMh0/0h0X+K4aDFEi0cYkMFereA5+SHXhdwt9Ejn
         m9++REQio3HlLCp4R4ZiLcPl3WV10drQ7hxCz+iw3pxBnEx/RC6cNykCWYgpsliYzvIg
         1YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324652; x=1771929452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=Wl3+3OxSJcqo1W8LNKizUlFC0ylUQY55Lh72IRZFfsd0IjP/dyMdc4x1NNu+AjVk+j
         w+hsP7BXoEAdZ0ZRL3jfxzYhLNrJnsmjAplPIsR4D6BTDzXin64ozlLw7IB8FBlgY4rT
         YjUKI9TtFrExldfJgO2oRWfXxv9Oz7rJfJcAqHwWP268it+fmRPup4+zOVb4XocfwS1X
         h3vHbmVMDIbnpMeaAgBZKgOIonahhMdVetSs51eFQwdWiB2+IV/czh6S8Q5y8F1SSdrU
         4RTJJn8hhmfhxhfCCzgnuTWrBbGKJe8Pex7FwvUln0bOURvNIRW7obCP5GI8UMgAUeE3
         Urmg==
X-Forwarded-Encrypted: i=1; AJvYcCX7J3G7q/KdXPW9MeJ0Ad6rZjstPH0W9U4KJBsgsTGSicVqeabKVWlVuy6uFtq9MKw1OwT1BagP0AQ+@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJ9ZSKBQGXsSm0jnFC7sxi2FBdTiDgD8wq6OwpNtAcSc6EuVY
	fQUFrHqkohvpzj6wK4x/SHiFcOLOVZjaTutKeCR8QlYkId9TfCFm+e9eFs+scPYrIWvQzbzFYjw
	i3Fzg56b0mgldbHHPIa5SY6L6Orc/Tq4g5+ht3esM7g==
X-Gm-Gg: AZuq6aL3IrPJfv8Aq+a3wZ2553K6G4x8M7WcEfnxc8jGn+mRyADg+oeg24kV8tgI7Sh
	P/rp3bTdkqRz2JaIiQ+mp8dQ2mn9VxUq8BUnACfFqdK4nKXuut433OkaXkkipqAXD7vgR2ycUl4
	IC1Sso8kY6erGYXbVC7uedlYYAS12C3UmlHLsLf8rEZ8bPPxx761KWpu12f7RaZTTopI+9vowKd
	702FXikIk78xoQMPu1UCrkMGD+Uuvgsg69dfq2oeXApO3ahUa4bM//M4dOohPTPdDybLfokXnLV
	k+WS7T6cQ7XW9xOPvI+sIM/IAQ7xkv0SVCHrPag+q/Z+hIjpeQ2N+MLDcvG6/SBodDAw
X-Received: by 2002:a05:651c:1ca:b0:386:ec21:c87f with SMTP id
 38308e7fff4ca-3881b99cc9cmr30135731fa.42.1771324651832; Tue, 17 Feb 2026
 02:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner> <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner> <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
In-Reply-To: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 17 Feb 2026 11:37:19 +0100
X-Gm-Features: AaiRm52ye33PKO28CcExseV6coNOG-rZ2nBeMP78z80h8Dwp-N455yQLK7UlhmY
Message-ID: <CAJpMwyg-3-Z=ZDC60Vn0s-8Z78VOPKYmvX9s=Nnvcoao4T5zbg@mail.gmail.com>
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20915-lists,linux-scsi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,forms.gle:url,ionos.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+]
X-Rspamd-Queue-Id: 86B5814AE95
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jan 29, 2026 at 05:13:52PM +0100, Christian Brauner wrote:
> > On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > > > (1) Fill out the following Google form to request attendance and
> > > >     suggest any topics for discussion:
> > > >
> > > >           https://forms.gle/hUgiEksr8CA1migCA
> > > >
> > > >     If advance notice is required for visa applications, please poi=
nt
> > > >     that out in your proposal or request to attend, and submit the =
topic
> > > >     as soon as possible.
>
> This is (likely) the final reminder to put in your invitation request!
> The invitation request form closes this Friday, 20th February.

Hello,

What is the announcement date for accepted topics and invitations?

>
> Fever has struck me down so all you get is a bad limerick:
>
> There's a conference called LSFMM,
> Where maintainers debate and condemn,
> They argue till dawn
> What's merged or withdrawn,
> Then next year do it over again!
>
> Don't forget to pester^wask^wremind your respective organizations to
> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
> considering renaming it LSF/MM/BPF/AI.
>
> Thanks!
> Christian
>

