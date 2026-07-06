Return-Path: <linux-scsi+bounces-25635-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bmSDFvqOS2r/VQEAu9opvQ
	(envelope-from <linux-scsi+bounces-25635-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 13:18:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5922C70FBE5
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 13:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I9gnGgEC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25635-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25635-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ECE63394978
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 09:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAA541F7E2;
	Mon,  6 Jul 2026 08:55:46 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E7407576;
	Mon,  6 Jul 2026 08:55:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328143; cv=none; b=bTxqCRQiiNX1PIgkiLsPDXn+YGk4kwmyuUANTXKGXIDrPosZ3ob0m6jLT77Q543JYWoIMp05YTr3xV3OIWL4WzxE3lPmiguNQQdPOxFTRkizSQUEHXanCDpyGMiswjjceraI1lSQ9kuFPGRl3RGAq8IcMJSnduQwAZ6UvUd47Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328143; c=relaxed/simple;
	bh=4AsiANEPQQNn16+DkjnvaEFha/mXnJm8flL8tWtxPys=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sykOJA+hpP6CNg0ESsdCBb/EIdc1H9hBOFr6iohoUzIVbhp6/JDSnbf4mM8GquXImvjwZruvQ+ZLhGMFjLmLkoOtmtuR5i25GQ8Na7hzS0JwvAl1xcBewXZOb8lsyoEu/h0obYjqD0agirtyeuZce/gUZc/zLd4/dl5SYEn/FeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9gnGgEC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7CD1F00A3A;
	Mon,  6 Jul 2026 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783328133;
	bh=xUWLi5662FKqa6Hfl+915YdSn0wbC+NLoKBB+bv4hKU=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=I9gnGgEC3Qm66+NnVo0tfd5r5M8OGgFdfbMHIBEsVebXaq+dGlZprr4H1OalpmWIG
	 wuwHaUAecQBkUslxifKVsE6ziGcdNcmQTgJ1zBw/sOX+6Xo3b/dQdxCyJTYUpE2y7W
	 T8IoiJHmP1JG7rS/ildvDPf+FObvkM+9/VJdUZCbFMFok3jRJ9TkaTVv8j5ZAYOKp5
	 7QzLYsrEvhuqnAqFcKBo/cAgTQBlOVpQQUsETji4B4k2DwRNYAJIKwoqREfVMdAJJE
	 xAfe/cCuFYLQMeils4dFfGTl1/v8LMMhkbDWIBCxFWGXnb5yaxedFU/7Vz9DzKWO1M
	 Jxv9TtcsmBvuA==
Message-ID: <e92d2139-d8df-40c3-8350-68b9e37b8197@kernel.org>
Date: Mon, 6 Jul 2026 17:55:22 +0900
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
 <b7971067-1025-48ca-8ba4-d76714c283d5@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <b7971067-1025-48ca-8ba4-d76714c283d5@suse.de>
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
	TAGGED_FROM(0.00)[bounces-25635-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5922C70FBE5

On 7/6/26 5:29 PM, Hannes Reinecke wrote:
> While at it, would you mind converting the raw asc/ascq numbers
> in drivers/scsi/scsi_lib.c to use these definitions?
> That will make the code in there _so much_ more readable ...

100% agree. And not just scsi_lib, but also sd.c, libata, etc. We have so many
places where ASC/ASCQ are hardcoded/hard to understand, that this will be a
great cleanup.

BUT, that's too much for this series. I was planning such cleanup as a follow-up.

-- 
Damien Le Moal
Western Digital Research

