Return-Path: <linux-scsi+bounces-25339-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id chVqBo8LQ2pSOAoAu9opvQ
	(envelope-from <linux-scsi+bounces-25339-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 02:19:27 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2B16DF5D1
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 02:19:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IlI+iCBl;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25339-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25339-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A60C5302F4EA
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 00:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703B0156661;
	Tue, 30 Jun 2026 00:19:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE640D56E;
	Tue, 30 Jun 2026 00:19:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778762; cv=none; b=AfMndcsMaihkIeeijLHLV5XtHztw5JpUdwQTxTrKnfedU2VE5dtBOycpKAVvEm3Rc3cs6fDeeg3kdu8S5Jk5SxB/1ePIGb3M9gdo3S2GifmwQVWAV+x40fB9sE9L88b6ccTqaEsKgGgeSoXVbi6boyaEQFG5UDBhlfjeSi9kJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778762; c=relaxed/simple;
	bh=csi7AsxAN0DYEvzF9fOih+0A5ukF8JnJ07Hbt2F/qo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofrcaUtTm71Mv191LarXvhJZmzNjbUx4kAZH4wZSxC1bhzd7PkAZ0TLXyQ8ItdSpSPFeImp2tXwnEH2Jj86zUn2KxPufSex2chvuBfMQtovF6Xo4bKB0SOMSRA0ZQn304rAxi2TJDLzbxN0nL5pBPazNjKHU3PsOHkUX63lgH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlI+iCBl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1701F000E9;
	Tue, 30 Jun 2026 00:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782778761;
	bh=LBEehFIWxZkQUhN9j6hIcOBBY4oYxR+BNVTiz0BEYbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IlI+iCBlg81brz3/NAYgGHy+AfAss8TuGCESYrGd56d+3O/9DevoFqAo4J1qpAWR7
	 mRHkkwFOsPLf2S9FMfPKMvTTFYj4vKhVuuvqbK1O/igHoTGOMIKCBowDcSShhn2Y3T
	 WG+u0MolqtP+Pm1HLMRWkEZm2yns3oit968S+HfbQg6stws4gE6SIL7SDUVEA/k0Sg
	 s24Y79eCW85R4H9/09cQ2Wj8j/oXxnmJxjis528SfTtQyZTb6A4NbsYi3g2l1Vi5SD
	 w73Qt0sxCZLw0wle+SV0MGBsqoDFI9SEgRETMq9bVM8wl2dj9yARvml4j30hEYowtl
	 0BDSFzgQYYL+A==
Message-ID: <44fe243e-b5ee-484b-a760-9269bb8fe816@kernel.org>
Date: Tue, 30 Jun 2026 09:19:18 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 2/2] scsi: mpt3sas: add hwmon support
To: Louis Sautier <sautier.louis@gmail.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Ranjan Kumar <ranjan.kumar@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Guenter Roeck <linux@roeck-us.net>, MPT-FusionLinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260609164423.2829699-1-sautier.louis@gmail.com>
 <20260609164423.2829699-3-sautier.louis@gmail.com>
 <93542109-2101-4d62-aae4-bbf058029663@kernel.org>
 <airk3Os03wPV0rvW@localhost>
 <fdea1a8b-d631-43d8-bcf0-1c79e635782c@kernel.org>
 <ajkaf0aa0TWXdRZW@localhost>
 <841e8ff7-12db-4ca4-aaa5-fb8accfc9df0@kernel.org>
 <akMKIk8JN8REuYVB@localhost>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <akMKIk8JN8REuYVB@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25339-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sautier.louis@gmail.com,m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:linux@roeck-us.net,m:MPT-FusionLinux.pdl@broadcom.com,m:linux-scsi@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sautierlouis@gmail.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E2B16DF5D1

On 6/30/26 09:13, Louis Sautier wrote:
> On Mon, 22 Jun 2026 20:28:48 +0900, Damien Le Moal wrote:
>> I saw only patch 1/2... I was waiting for the new version of the full series.
> 
> Hi again Damien,
> 
> The whole series is there, including 2/2. I sent it all on June 13:
> https://lore.kernel.org/linux-hwmon/20260613023833.3163507-3-sautier.louis@gmail.com/

If you want me to review, address to me all patches. I only got 1/2 which I had
already reviewed.

-- 
Damien Le Moal
Western Digital Research

