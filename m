Return-Path: <linux-scsi+bounces-25392-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rQcDLGSYRGrhxQoAu9opvQ
	(envelope-from <linux-scsi+bounces-25392-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 06:32:36 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E16E9B3A
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 06:32:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chromium.org header.s=google header.b=f+yMIgCY;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25392-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25392-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=chromium.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E436302BDE3
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 04:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EB38E8B8;
	Wed,  1 Jul 2026 04:31:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36EF376A0D
	for <linux-scsi@vger.kernel.org>; Wed,  1 Jul 2026 04:31:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782880281; cv=none; b=cNAEFmw3PZPyqhKX7ApPh+w/Xw/AyuBkOdz7Sta7tMXFyJn+kyPxrsPrZdWK/DfM3f1uYjiG7+RffNTqoJrikw0r1eWHG/fSxFJP1xqOAdz9X8COUhCkB920N6P8WhdCEb53Qw74pOewYoYKVc5/v/JrRUpbcktnZhUvj9GrmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782880281; c=relaxed/simple;
	bh=AWKY4cc9CqfC8Hk+fcXwx0sO+5n7MEB7rG8uG7Wszik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCPQwFAhSr6shtY8ZPhKnlSPrVnGlBqvU4/+gCMQBbCiB52j6eCzHQ2dmrcZtbb5B8UwJ1qhURP1wkzCU3D3K1uTkRF6cPr1203OpdQK3/rnKJgpeTxelYzaAgzayS4GYBoqzeYYEYohbcyZugbzFDK9tgXwHe388VyQD2DtFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f+yMIgCY; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37d46e0d246so92178a91.2
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 21:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782880278; x=1783485078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBDjdsdXK93fPolwyRglgWnhTKiV7F2AKwYz1juHAG4=;
        b=f+yMIgCYuUtTlbjZ9j/dNtWKYQILJ5qbzLb4ZL6lQ63C4YgKzAq2xotDmSH7TUPPlN
         qHrJkCFGzzfdCbh9dInaQI0txY1/8B6gHczsbHCMIsnMGO+ME4pY4+NqsODlqReg/vTQ
         9/Rpp1gZI0Zxu6l3rL5GOrm98PMSUYATGBGWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782880278; x=1783485078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBDjdsdXK93fPolwyRglgWnhTKiV7F2AKwYz1juHAG4=;
        b=kZ0hWfCdqrtjUZmfgUZ7SYP0Mw5kRbjjTugTtsSjvrnZtZwFSFiVNwRfM3YXhGVQPX
         huJNY7EU3p8nuI62/gLW6cOGIK9pvN7nNU0iJl/4EWUFtXs/f3kOrtSeHW71yQriICoj
         TKd+8TnmBIRa5yKUd7ohjhJfYakc/tKBOALvOmkGczZ+/Wt3lJDNhXrKU+2E1AqFZElZ
         UStyZmJJiREaj83lxtUxAD7Grq+HcYEYO0CZGJd8fH6Zmp4M4yuZn/FAr8ZBSd4CBi9L
         +7sJ/q0eP0fxAWhQNYHbYTvxtt3NrPxEYt/stNHRBS/FEKm+IQc+qXyFtYvVgN7jfN9R
         cK2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr+h6xkdEL7l6Awh+ZAZ5QnIojo+liPZrhw922ScXuKEgsjlkJ11R5p/EeS7zVCjqYaCsYvcXRM/nj7@vger.kernel.org
X-Gm-Message-State: AOJu0YwCp6/286qXPZuSF0/vkqjJrTkmI0VCrCJB7Bl8x//FfyqIXv9M
	Sffh9FI8NRFvMShnk35BwShHTLxS63VT61UdTKooYicNrsLecT7v46Qm6pysTs0n1TeDpZq1vmS
	Ah3tbVA==
X-Gm-Gg: AfdE7cmBS9kRYuVSlY0V3JP3qzWwnFb1j/XF+GNhVBC7Uf4zOIaiOPyt4FD1uhGbnFp
	mIuaSJHpjN93RkhGFHJjfgppTjh2xEJt7ENCkJ3GdaJDWFnv/L/vNPFlHLOHVZXgan6TSboaYRP
	Ogsk9/AvmjHIoSclhiFuIXGXLCyapAj1qw5EFs4AnerX0BMRpTqS4aj73rqRY0eJr689Ysjni0x
	aTIQNNmaOHrynNK+0pihmW9UMIyO9POuPiBX3dbIHK1v9Lc6SgWu24ICegKwVY92vlWS4qfcHoW
	qgWBNt3f6KuqzFHg4WtS3yXOwc4++ZrTxf7XsRP0Pb/YqqOMJV++Ql0NjpV31zb8nrLEW8+6Nhg
	VbOjzFcfF5EDxcur+4Xpoujd4GiSfyiFnD7+oRfVspyYmg1b5QWTU4hSTnmmCQODe2rMMND6oIN
	sYA3n2NtB/as2baW7zYvzxUw5zGTpBkl+6f/4lzZyNlUp/JUaPZfBT
X-Received: by 2002:a17:90b:4c07:b0:380:7d9f:81f1 with SMTP id 98e67ed59e1d1-380aa098483mr158214a91.3.1782880277528;
        Tue, 30 Jun 2026 21:31:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:1379:da2f:9be6:bff2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097ba48d0sm360301a91.1.2026.06.30.21.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 21:31:17 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:31:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH] usb: storage: uas: limit consecutive device resets
 in error handling
Message-ID: <akSXFydSPAQGi-4b@google.com>
References: <20260701040335.810297-1-senozhatsky@chromium.org>
 <20260701041700.EB7971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701041700.EB7971F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25392-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[senozhatsky@chromium.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:senozhatsky@chromium.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D13E16E9B3A

On (26/07/01 04:17), sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Prematurely clearing `devinfo->resetting` and dropping the lock before calling `uas_zap_pending()` creates a race window with `uas_do_work()`, leading to a kernel warning and Use-After-Free.
> - [Medium] Time-of-Check to Time-of-Use (TOCTOU) race when reading the `uas_reset_limit` module parameter.

[..]

> > +	spin_lock_irqsave(&devinfo->lock, flags);
> > +	if (uas_reset_limit > 0 && devinfo->reset_cnt >= uas_reset_limit) {
> 
> [Severity: Medium]
> Can a concurrent sysfs write cause a Time-of-Check to Time-of-Use race here?
> 
> The module parameter uas_reset_limit has 0644 permissions. It is read twice
> in this condition without a READ_ONCE() wrapper. If it is modified from a
> positive value to zero or negative strictly between the two evaluations, the
> first check (uas_reset_limit > 0) could pass, while the second check could
> evaluate against the new zero or negative value, prematurely failing the reset
> and offlining the device.

Sounds reasonable.

> 
> > +		devinfo->resetting = 0;
> > +		spin_unlock_irqrestore(&devinfo->lock, flags);
> > +		uas_zap_pending(devinfo, DID_NO_CONNECT);
> 
> [Severity: High]
> Does clearing devinfo->resetting and dropping the lock before calling
> uas_zap_pending() introduce a race condition with uas_do_work()?

Yes, this looks wrong.  Let me take a look.

