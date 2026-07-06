Return-Path: <linux-scsi+bounces-25636-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QkGdDpt2S2pzRwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25636-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 11:34:19 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902B470EA54
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 11:34:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FzGTWbLT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25636-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25636-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A0913082074
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B48430CF4;
	Mon,  6 Jul 2026 09:01:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627753B27D8;
	Mon,  6 Jul 2026 09:01:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328468; cv=none; b=hwsqlVZcJu0tmq5eDVuPpa5Yyc23YoflUuxzhr70eRiDeVrM2QztUTb/k/OPgcb9Kv+QHV7EcZidBp5sLc83mREAdyG8pdVTpM+bOO3tQFc0HdQDBAWECHAPuIN3e59yUA/uWn0hTM6k2DKSOC1Bk7HXrXOMVDamFHT0DunVm2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328468; c=relaxed/simple;
	bh=Y+LvtnbFS7Pk8rMTIi6bBfp9mbHm4Uhyusiwi5v+XCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TnTxvwtvybETXEDYkJ9BaLyLe/dxdBcMFbQ5Zr8y4tQh13C2IFgu4U8bDILkKCtmX8VYYz/DdK8PBsu9d8FDA4wXJIn3QPEldOOwdUlJILpINWvnZSGAIRvD201sZ5YdYj2rFIki3fxDQUJC1IfNDHv/wuIXnYsdcAY4K4TQgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzGTWbLT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C41F00A3A;
	Mon,  6 Jul 2026 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783328456;
	bh=3fHynrpnm/i0ACjcT4Z/n2urCPV7odE64YZ7oCtLtRg=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=FzGTWbLTzr/WvlX+6Me+CfuAk9B81b8QLqJOQ0qnfE6AWdtbWxq/YWZOIiwmraUMN
	 4Uo/xwZ5DVmWtfGZWJX1Z1PkRe6uDbflrGZEpWEDloJw2aZs0kSuj1raS9qkkDWkkt
	 UjNO0AF3otjkbWsmRYngK6AiEv691y13bFQ7zMHH4ZE1m3rzXJ9BnUGM0akmzf9d0u
	 zTEkaet4KR0OAea7YJ6eQ0UUUr0a0U8fMmBJAsPDjTlgF9y7GEMYPXSAoNZSLH2K0p
	 D4GLcjDXLYM3mnS43XFU7iwNFmLwij67RkyHrDvlQGRnF7TdkEF2s6sUtdN3+kLJXZ
	 Q7yWMrKIzhCqA==
Message-ID: <cfc34288-244e-417a-9586-36fc2b2642c3@kernel.org>
Date: Mon, 6 Jul 2026 18:00:45 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] scsi: scsi_debug: move ASC and ASCQ definitions to
 scsi_proto.h
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260706065610.3559692-1-dlemoal@kernel.org>
 <20260706065610.3559692-2-dlemoal@kernel.org>
 <78b0142a-23a6-4959-8535-fef18d62bb46@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <78b0142a-23a6-4959-8535-fef18d62bb46@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hare@suse.de,m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25636-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 902B470EA54

On 7/6/26 5:44 PM, Hannes Reinecke wrote:
> Weelll ... _technically_ the ASC/ASCQ codes have to be evaluated
> together, and the individual definitions only make sense for a
> combination of ASC/ASCQ codes.

Yes, I am well aware.

> EG SPC-5 defines the ASC/ASCQ 0x20/0x00 as 'Invalid command opcode',
> but with this we would deocde it as 'INVALID_OPCODE'/'POWER_ON_RESET_ASCQ',
> but 'POWER ON RESET OCCURRED' is ASC/ASCQ 0x29/0x00.
> So if we were to define ASCQ codes we would need to define the
> ASCQ codes for each ASC to avoid these issues.

Yes, this is messy. But re-check the specs. There are plenty of places that say
"with additional sense code XXX" without actually specifying the exact
combination of ASC/ASCQ as they are defined on the T10 site
(https://www.t10.org/lists/asc-num.htm).

> Makes me wonder if we shouldn't introduce u16 for sense code
> handling ...

Maybe, but that will be more work as we have many functions and code that
handle asc and ascq separatly. Which I kind of like.

The main benefit of having the macros and using them is code readability: the
values used/tested for ASC & ASCQ become self explanatory, making it far easier
to match code and specs.

-- 
Damien Le Moal
Western Digital Research

