Return-Path: <linux-scsi+bounces-24421-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CfD0NHqFIGqN4gAAu9opvQ
	(envelope-from <linux-scsi+bounces-24421-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 21:50:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D17A63AF7A
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 21:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=aYMSECTA;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24421-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24421-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A5D3008200
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jun 2026 19:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A699F399354;
	Wed,  3 Jun 2026 19:47:57 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA603A8F7;
	Wed,  3 Jun 2026 19:47:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516077; cv=none; b=dx4j7fwn6qGXbjGFrCTTrA2fMvCBlVzaV7SkUEkr1ajGAK9chcGm9i2KZaIr09hsAlh9DPoGrpiZPwGk5kRiTJZYA/h14dL1PPiOPnfK8QD4hTuQLHY5brNfbK8o4CJRgXstfiwKGlxUhmwKgjMSiDNMo4u2np7NfDCEmB/DO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516077; c=relaxed/simple;
	bh=Qxn2FagqtQMjM5iyYOECW3TPR8VLbovH5IA+qxeYiSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXqw22ofjqfc1t6BB069Y+e/IWtzLDkyz3cV8Jw97Fwk/lfhLjXeCMMWU7S6djeagB+OqyVOkNYjgz8pVMowFpGsIFIMRYW/jXOyeGXc4aD0F8bX+luTrhft1Xl9kBIXyqupeJZUKs7UmeHhyhzB7Rf5MbsNQJFgWVVBUVLvcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aYMSECTA; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gVysl3Zn2zlfgfB;
	Wed,  3 Jun 2026 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780516072; x=1783108073; bh=r+HhMDCyFynpzyRW81LPr/QY
	kG8qvNQJtCSjgOT0yKs=; b=aYMSECTALJakGr80G5FCXJhS9d6P1hmqkrKyaVgQ
	Qg8uF4sr5uTtKRIUy0u1EdH7xCPg6bvEyilq+tk54W9lhjgrKAi29CC0OqQZ4CMU
	WIwzouuG6sAwHSJiT/Lzqo9MSqtfcarbR3sbI/ivBfGMhELYsvbk1B7En/8yXAfi
	mcgBA/ga/zKIrfDFa1tUVmtzdMRcIpKUUOwkDlNDkI5O7CNqhZAt1wvb0a7ES7ij
	ltKuR0BBOqa+krzMCM0SHtcDamIL66ebHVbnjxvMnb5ALfLEQdp0FxLkCfYUQduB
	40M5uvXYTUUSZ4Qn/b8Lww2XDRyg0CA4nSi3BqH6QkEGLA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PzBrzF9aveEd; Wed,  3 Jun 2026 19:47:52 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gVysd4MTXzlfl6N;
	Wed,  3 Jun 2026 19:47:49 +0000 (UTC)
Message-ID: <0626ebdf-76a1-45dd-8fee-59dad3539ea9@acm.org>
Date: Wed, 3 Jun 2026 12:47:48 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: scsi_debug: reject too-small REPORT ZONES buffers
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Samuel Moelius <sam.moelius@trailofbits.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260603171104.18464-1-sam.moelius@trailofbits.com>
 <c01aa774677d1f6fdb0f0924ae0e2de47836d55a.camel@HansenPartnership.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c01aa774677d1f6fdb0f0924ae0e2de47836d55a.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-24421-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:sam.moelius@trailofbits.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,acm.org:mid,acm.org:from_mime,acm.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D17A63AF7A


On 6/3/26 12:11 PM, James Bottomley wrote:
> On Wed, 2026-06-03 at 17:11 +0000, Samuel Moelius wrote:
>> REPORT ZONES subtracts the response header size from the allocation
>> length before ensuring that the allocation is large enough.=C2=A0 A sh=
ort
>> allocation can underflow and make the remaining length look huge.
>>
>> The handler can then write zone descriptors past the caller-provided
>> response buffer.
>>
>> Validate the allocation length before subtracting the header size.
>>
>> Assisted-by: Codex:gpt-5.5-cyber-preview
>> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
>> ---
>>  =C2=A0drivers/scsi/scsi_debug.c | 4 ++++
>>  =C2=A01 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
>> index 1515495fd9ea..f17e59482cfc 100644
>> --- a/drivers/scsi/scsi_debug.c
>> +++ b/drivers/scsi/scsi_debug.c
>> @@ -5911,6 +5911,10 @@ static int resp_report_zones(struct scsi_cmnd
>> *scp,
>>  =C2=A0	alloc_len =3D get_unaligned_be32(cmd + 10);
>>  =C2=A0	if (alloc_len =3D=3D 0)
>>  =C2=A0		return 0;	/* not an error */
>> +	if (alloc_len < RZONES_DESC_HD) {
>> +		mk_sense_buffer(scp, ILLEGAL_REQUEST,
>> INVALID_FIELD_IN_CDB, 0);
>> +		return check_condition_result;
>=20
> That doesn't look right.  The returned length is almost always the
> first parameter of a SCSI command (it is in this case) and a lot of
> users will send a buffer just big enough for the length (4 bytes in
> this case) to get the actual length before they ask for the whole
> thing.  If you require 64 bytes, we're going to reject perfectly legal
> requests.

Hi James,

Is my understanding of ZBC-1, ZBC-2 and ZBC-3 correct that the REPORT
ZONES parameter data should be at least 64 bytes long? The zone
descriptors list starts at offset 64. Bytes 0..63 form a header that
precedes the zone descriptors.

It seems to me that the resp_report_zones() implementation is already
based on the assumption that alloc_len >=3D 64 because of the following
statement:

	rep_max_zones =3D (alloc_len - 64) >> ilog2(RZONES_DESC_HD);

Thanks,

Bart.

