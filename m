Return-Path: <linux-scsi+bounces-25397-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1fpjBuOtRGqqywoAu9opvQ
	(envelope-from <linux-scsi+bounces-25397-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 08:04:19 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 608556EA151
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 08:04:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chromium.org header.s=google header.b=jJLafG9B;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25397-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25397-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=chromium.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A013037BB4
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8647B2DF13B;
	Wed,  1 Jul 2026 06:01:44 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FA1AA1D5
	for <linux-scsi@vger.kernel.org>; Wed,  1 Jul 2026 06:01:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885704; cv=none; b=UNtlzyMSJNUp01+cWz9J2sV9MonWFl8pvt7sDkbVsg5uRNtJZS+lKA7UUbiGV1lol64W43qwLoalWPfQ7klgW2A4cQPv6Mio5fE+dZct4VtTYkGbgs6eqt/+fgyyWDj8CSFbN5GMmKTPBwL3Aqvmx/m3Dygt+j84opQVQabhQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885704; c=relaxed/simple;
	bh=3oeMZ6NNs7vMLHM4WilaG0v2t2tRVpTyTnDkKivbB1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/H3DNjF2cJ8jZ6w16RANSBWK4Tr+BCrr5WJULWcqJBX9HLPcQ8oXQrrUVo222EehtHaK1QIaZHMqS9s3KgJQIgnFTZtVdv02BrP3DE+bCHY7GQiXA9nZKf6TE41nIcmD8mDS4H5WUyQJaF646XCx62IIMCyxtKPuU57O1xjN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jJLafG9B; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c9cb97e178so2944525ad.3
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782885702; x=1783490502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0e78plCJzUw9mtQf3K/88IdWkJoFUVq9utFQfqU+ZPU=;
        b=jJLafG9B1CfiQIornqxu+KUsNtbIOICEg5+R9M0vh3OS5Uponag30+rtHkBH+p2sQO
         NbknKjvjqMZxvp10RqtWA3JaHeCL3ZjlBTW+X+DPyn+x24sQggaMAme0KMzkvqkLCzex
         ZfmFYuUZVwOG6pKZKn2MXtGonulb4rkQzD7Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782885702; x=1783490502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e78plCJzUw9mtQf3K/88IdWkJoFUVq9utFQfqU+ZPU=;
        b=q9USafn4iZkAqEra+xvM8mVSPt6zmzMXMZGuFW986rFPPp25hSUQOcwJtBVfHk++X4
         L+cv9EC9qLj6MKA0/pyvw899C+LblBO4WwFr5RUYRzFz23n1OcRJLlnJQde8ufGrj/2N
         BbJFIpMo23r0ZcKRvkt/W1bnSGSnun4CrJU8kD5821IyXpm9jr3jOrgxUzIhrFiBhTWG
         cr5HZWHSsyag2SGk6gk/QIIeUGsgGxGUqMpiNLzBLVTHSLvI3R4R0awD7QN5qM3Y+W+N
         d/31JtgYoGj7tNACcjuxM34VEwoe7HDb1R/gS21aIzBl4E6NgNOrVyKxSl3WoDnGGUes
         2Mig==
X-Forwarded-Encrypted: i=1; AHgh+Rrvx3aRjmodb2rGUH3WiedGk5blF4Tuh7N63DBYyzMcbuz8Lc9qOgvO8EiHa3J+uYn6gLm381C6Jlcs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PfE7IaKxRK8SpXCnamVUQY7PxyxKejh5cf+6qNT4AbXphQNj
	GV1be0VS0CF4nMqKSHmx5QFm6Ahc0OfRSijHFTZTkH5PdQfXTX8iyLX1dszMhQ9y/A==
X-Gm-Gg: AfdE7clIbCHy8gM4qwhx1c8T5ccsX/Le0mUjpTV0biEE0TkfYSW1C2TVEzpDVin979o
	FSuQxWdeg8chiARLKW2rMtZC25gE2Fai3MxynKb41G33zkfKMois+ipD/od5KU2cKX5S0kjSl1k
	xsF0T/mYg5X7f3gV1FBMEkGKns0FFmGLxRd7I4eVBIdWsrn+NVm6mOndYNedmpbFT8hKQGgasxo
	tnsgPBHiYwY3O2d1yr3ZIqKOVN+em4B64ThdvH802FeM849XfDzY2VIQuR7kJMDubitHoeFcr3k
	xvIh6t7Ow6ydrbNLRVvHdmpd0mENCVr4v5zG/xIyls1zKolFKLWnT8S0A+bxQOdtNafCS8+TgYB
	Gd6qQh7VTG9cyTuYehgOzfYt5oErQGxuBEKL5rXbDTLcamEkW0CccLRV/CsdyiV9y7kj4MTeo8d
	60pxznYjAThSg3dl2V2DEA2ca5tKVCEVtO/0md8YkEaDmSgka+glBF
X-Received: by 2002:a17:902:ccca:b0:2c8:1c05:16bb with SMTP id d9443c01a7336-2ca7e86b86bmr3693685ad.24.1782885702562;
        Tue, 30 Jun 2026 23:01:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:faee:2436:3347:c0a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a70c42sm26149575ad.11.2026.06.30.23.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:01:41 -0700 (PDT)
Date: Wed, 1 Jul 2026 15:01:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, 
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH] usb: storage: uas: limit consecutive device resets
 in error handling
Message-ID: <akSsw_iDneYb_4gQ@google.com>
References: <20260701040335.810297-1-senozhatsky@chromium.org>
 <2026070157-stench-shabby-2519@gregkh>
 <akSqd7HkrZI78_L_@google.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akSqd7HkrZI78_L_@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25397-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[senozhatsky@chromium.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:oneukum@suse.com,m:stern@rowland.harvard.edu,m:linux-usb@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:usb-storage@lists.one-eyed-alien.net,m:linux-kernel@vger.kernel.org,m:tfiga@chromium.org,m:senozhatsky@chromium.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,chromium.org:dkim,chromium.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 608556EA151

On (26/07/01 14:57), Sergey Senozhatsky wrote:
> On (26/07/01 07:38), Greg KH wrote:
> > > +static int uas_reset_limit = 3;
> 
> This obviously wanted to be 0 by default (just a side note).
> 
> > > +module_param_named(reset_limit, uas_reset_limit, int, 0644);
> > > +MODULE_PARM_DESC(reset_limit, "Maximum number of consecutive device resets during error handling before failing");
> > 
> > This is not the 1990's, we do not add module parameters for issues that
> > should be properly solved either automatically, or on a per-device
> > basis.
> > 
> > There's no way that ChromeOs wants to attempt to track this module
> > parameter as a bootline config option, right?
> 
> Can you please elaborate on "properly solved either automatically,
> or on a per-device basis".  I don't know how to break that endless
> reset loop otherwise.  I'm open to any suggestions, the patch is RFC
> for a reason.

I can imagine uas_reset_limit being auto-calculated based on SCSI
timeout (30 seconds) and HUNG_TASK_TIMEOUT (if set).  Will that
work?  I don't know if all those timeouts can be clearly exposed
to the UAS driver (or should they be in the first place).

