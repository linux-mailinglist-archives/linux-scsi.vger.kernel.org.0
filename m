Return-Path: <linux-scsi+bounces-26049-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3tdFLFSPVGpGnQMAu9opvQ
	(envelope-from <linux-scsi+bounces-26049-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 09:10:12 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CF747D06
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 09:10:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R+YV1YTj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26049-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26049-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 695AB302E90D
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 07:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057D368D5F;
	Mon, 13 Jul 2026 07:08:49 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FE368D4B;
	Mon, 13 Jul 2026 07:08:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926529; cv=none; b=Qw8Gqszmowj4aQXdvGvrRKunQKdlDDhlkHjwL04vX9+delTaPTZVoh0DlKO7RA8x3WQ4lHglDicDsVAk3lPHX4a97tOInoeXx18dsOEjDNawWeGig7r7UVOBGYzgRMdvI8z1Ovg09GD3u92bVBL++dxKneukyehChi1Xjw8XdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926529; c=relaxed/simple;
	bh=7HaEFyemAtQ6rmV8FCm0qDb6NNiQQsQ8eMx5x/ZMQvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF3XGneZY8zgRv+EApjc4fmouoGARZiWBAaj+P8VOEyJVqDiC8QISXRyxOnlu/3M6WfMtV5o8i3SiUpUjcpZ8Vf5zImdVWObzN2EUDrL4SSzxuSpv7ub3ZKnc+q1qVIC2VoLFxsjUSeXk7iBc6dDHLjUC3Bz/m0ucdMpfeRIJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+YV1YTj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3499F1F000E9;
	Mon, 13 Jul 2026 07:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783926528;
	bh=IGt4+xk19bV/56VchxHCKTaDbb1pfUcwJG2Ttjez83Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R+YV1YTjCJ35fax7cPw+DmrHyQIEnxPt/MDsJWNE8YK4uSpt6vQ6Tj+STj4NWA0w1
	 tvFGSwXAFQy/a8LKt6v0tZZ++EMGUdMDpkoHTVmM27M8QX/AFnOsg1Oir1XI/jqxcM
	 bUkFAm+ZWsg8xnyzgrcH6yQCTDNzu1QIy7EUOJLstt0MP0dF7NBfNsmCHEwh/hK2F4
	 9cbF173kWDtFfBsiI1RV3kbvXqRrbNi4GxPofHyjf6yCP5OSfblHR/OXNYRjKnszJP
	 JH6Pt9VEmYBetVAAQQKGs6MVu6RBCjaMIpXz5jd3hmIbG8D6kzkwbmjAvshYXnUG5y
	 TtbJd9AHJWlhg==
Message-ID: <c28763de-a024-4fd8-aeb7-c797b24e824f@kernel.org>
Date: Mon, 13 Jul 2026 16:08:37 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] ATA support for storage element management
 commands
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 linux-scsi@vger.kernel.org
References: <20260706065610.3559692-1-dlemoal@kernel.org>
 <yq1tsq3dhnv.fsf@ca-mkp.ca.oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <yq1tsq3dhnv.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-26049-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E3CF747D06

On 7/13/26 06:30, Martin K. Petersen wrote:
> 
> Damien,
> 
> Series looks OK to me.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks!

>> I have more patches for sd and scsi_debug (depop emulation) that
>> depend on patch 1 & 2. So I am not sure how we should handle this
>> series. Maybe we should create a "depop" topic branch in the scsi or
>> libata tree ? I am open to suggestions.
> 
> I suggest you put this in a dedicated depop branch in ATA. And then I'll
> pull that branch in if I need to.

I pushed the 2 scsi patches to:

git@gitolite.kernel.org:pub/scm/linux/kernel/git/libata/linux

to the branch:

for-7.3-scsi-depop

-- 
Damien Le Moal
Western Digital Research

