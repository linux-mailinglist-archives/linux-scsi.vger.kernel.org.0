Return-Path: <linux-scsi+bounces-25688-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fdAkNAtVTGr2jAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25688-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 03:23:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA947168E6
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 03:23:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iAIb1MBW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25688-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25688-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5C0B301C3DF
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 01:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4712F8E95;
	Tue,  7 Jul 2026 01:23:20 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3A2D47F1;
	Tue,  7 Jul 2026 01:23:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783387400; cv=none; b=EvVipYGJYjSkbhqc0r0iQJjIvokcuvWrFntmskjOaMYtOIzKMwSy8mykMmDpqcGBqU3EOnFCzjDhUnlDOlUwkxMgXemwAf9GD7CyOE4K+/MgOAPqQIaOfewLcI6k904pPFMkk6ZAR2wkxc6h2r4JpLCV+woRae7ULSr6LQ9CKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783387400; c=relaxed/simple;
	bh=6OMU10E/7vvxhppU9sNySMI9MeMIZci+A44dIaZ2U4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOV4SBbn8hL8MN+bP4LwwzZW4eRTeMrn2/t+ysbQ3ek/AgELycoVS6CYpl7CwRfqTtW3jUQ+Bsqswfs/vOo9R6b5dzBdZRZ7nhaJ3SBgwkUowgaEOJ7DiBOR1I4sN5KWgerOGeQlA5MNNK8sClu31NEyIHNJOb+g8ytbmVmQxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAIb1MBW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06871F000E9;
	Tue,  7 Jul 2026 01:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783387399;
	bh=X+XhWenkPmatoMI1cmD2xxx7/I9YArI3ESeanbuJX5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iAIb1MBWomZNcQGe4+pmCJdLQHvpvJh9FXfTVYDDZi49Gn2mYt3OWG4wc93e/BnNU
	 DbuW7INr5fjmBPz/JpIDMvo4M1r02ofM10VRMFVO1TNsIwxAlJs8UHm7hgboht77Ym
	 dUXKKLLOuRAmFbIrndMsp8+LMNoeSIeZYLngy+BGoUCqSDmRqP4Lh8CibRSgssCX3/
	 ovp874UwWFR16CELv0dZoDZAh2nmsmUqMr3WImD45TQntG1YTBZ4riGeTAnd/bMkBy
	 uQi8kbU8hHtSCTJgw2VTyQG3LPg/S6QEqVII4BOSaM0tt8JQHEwesihTbLMAh/ErhA
	 wtNXfAkHseW5w==
Message-ID: <777f958b-de91-417a-ae1b-47e96204713e@kernel.org>
Date: Tue, 7 Jul 2026 10:23:16 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] scsi: st: use kzalloc_array()
To: Rosen Penev <rosenp@gmail.com>, linux-scsi@vger.kernel.org
Cc: =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
References: <20260706233029.814601-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260706233029.814601-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-25688-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BA947168E6

On 7/7/26 08:30, Rosen Penev wrote:
> Merge allocations to simplify memory management with kzalloc_array(). No
> need to kfree separately.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after allocation as kzalloc_flex() does this with newer
> compilers.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

You forgot to add my review tag. So here it is again.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

