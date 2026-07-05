Return-Path: <linux-scsi+bounces-25611-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iivWLS7MSWr57AAAu9opvQ
	(envelope-from <linux-scsi+bounces-25611-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sun, 05 Jul 2026 05:14:54 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D94708D8F
	for <lists+linux-scsi@lfdr.de>; Sun, 05 Jul 2026 05:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=esFw6f8S;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25611-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25611-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAFA63011BEE
	for <lists+linux-scsi@lfdr.de>; Sun,  5 Jul 2026 03:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E32472B8;
	Sun,  5 Jul 2026 03:14:49 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF22C9D;
	Sun,  5 Jul 2026 03:14:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221289; cv=none; b=U1jUUXxItYn513/psjM6SE7ZO5Wq8JG/MOgGjBS1IyaQA0krBBWtSHu4AOld0SHu+w5cGNsKwY4cBEb4gDIe597PrEghTpqTGtLOu2KG1JAljXTElM/lzf5q1xhdwKcRM8E3/8aQPxaDRodRRZg6UTbX37HjRVo+QNssv2rBzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221289; c=relaxed/simple;
	bh=+Tjy3uPG5q9fUtV3OfYdO+Gwa1b+S1giVBgtMiD6kwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mu5LZ6WB5g2pBFg2lxI5SBWfAYugVFO9PIgenfoGl2M7DA0ebm/4oJTPMwEY8EQHASOvjQTJUN/Wj1dn3sr+hOCyVkBQbM4uo2aOK3SBU4kvsNKdXbk+IK6Ky92/n0z3uCDevNsdu2RaCGgJWWsoUh2JTvD1ZZZiEtKFyKNB+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esFw6f8S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D201F000E9;
	Sun,  5 Jul 2026 03:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221287;
	bh=u8ExCtRi0NLKUHDrdYhNLcLdmYK9Fk90/AANUNdS1AY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=esFw6f8SegSls6z+WQTQ9xg7kNCkq7JXpmbuRAKog3F9QyId3za0+TdIm5NLeDw0h
	 YRuJL6j6KhSJSvlgBHaI5oySZcaEHUklSS6raK5ZQ6v39DpwuJzvovg+imgo7QGAbX
	 +GcdCxoPQi9MMlXigzqkFukiCx93IiG8NB+55R9jbl4PpzNPJIYDRRhfEL7oP7pWlc
	 GMHPjAYMDXvUsKdECraDLRoir/a2UTnYktoCJ1pqMXAgNOfdf+rhQCdWllt4EAGjAu
	 lQLMSY3i1u/D6Hba6qe5JOqeoCgvsHihmgPvREfzYidSuKY5SQ3sjAWOqodNdL6Jnv
	 fyy7tgYIpCO0Q==
Message-ID: <fdcb7421-a56e-4274-bb57-0a20fb8fc809@kernel.org>
Date: Sun, 5 Jul 2026 12:14:44 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] scsi: st: use kzalloc_array()
To: Rosen Penev <rosenp@gmail.com>, linux-scsi@vger.kernel.org
Cc: =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
References: <20260703215345.253901-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260703215345.253901-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-scsi@vger.kernel.org,m:Kai.Makisara@kolumbus.fi,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25611-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05D94708D8F

On 7/4/26 06:53, Rosen Penev wrote:
> Merge allocations to simpily memory management with kzalloc_array(). No

s/simpily/simplify

> need to kfree separately.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after allocation as kzalloc_flex() does this with newer
> compilers.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

With the typo fixed, this looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

