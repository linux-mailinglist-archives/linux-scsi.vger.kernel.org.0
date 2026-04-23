Return-Path: <linux-scsi+bounces-23257-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJWcNOs/6mlvxQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23257-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 17:51:07 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A7454907
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 17:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED5513006209
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DBD36D503;
	Thu, 23 Apr 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="P9UOwK6B"
X-Original-To: linux-scsi@vger.kernel.org
Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3D359A62;
	Thu, 23 Apr 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776959437; cv=none; b=JQo7ZjefHMZafE3RfXHn+ap/3/IHKqxTP18lCWXmXKPypg0LhAx9psPFh4CFQyx1qClM56/62ixZAtnVj+jyTpNp/ZSJOR9mBbmF6hi/A/SkZUpn/tDo4OjYn0efVhdPFUXZqoCKWJbuBshxQYbgLllDW4LHck2osEkt3FE1BnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776959437; c=relaxed/simple;
	bh=QHhDqjhUf3ZXTf6hXAch0mKky0YVmw22vsPTTckUF04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVp0ORPGEXWOsK5DAIcUIgyQI2wwv55XT1mpWWRW+B41f+8cKharrAPT1CdQacA3yk81u62d/3DP5mGp6JbJDhaQ2DgSbrtaqkNbePUNqEesxvn8SKuo0aQ8Vi/N/t5ZAkcKxpxs5nRCJ795c8cpeEAPbBB60XkknxHBXRiPHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=P9UOwK6B; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1776959428;
	bh=QHhDqjhUf3ZXTf6hXAch0mKky0YVmw22vsPTTckUF04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P9UOwK6BgL3y7l6+wnZZrW4vpifFd+eF1X/GrB/KOTg21/9O3qlh0RAx2nH/CNP8r
	 Itbrx3kdnulSSrDVqwJXKzmDlb2EiDudYlln3ul6J3krn0LdEBzQERSK2O2SMMsBIl
	 A/dS53Yv5BpkXI6qXzpVNDI3LAL3Yapg7WKkaJ3c=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 0D30CBE5E5;
	Thu, 23 Apr 2026 15:50:28 +0000 (UTC)
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 6EB585FC15;
	Thu, 23 Apr 2026 16:50:27 +0100 (BST)
Message-ID: <99e30b3e-4f11-48b7-9104-28a0bacc8277@philpem.me.uk>
Date: Thu, 23 Apr 2026 16:50:27 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ata: libata-scsi: route non-zero LUN commands for
 multi-LUN ATAPI
To: Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260420122321.4161027-1-philpem@philpem.me.uk>
 <20260420122321.4161027-4-philpem@philpem.me.uk>
 <a32d15ae-2303-427c-9d06-d7d1df235ed0@suse.de>
Content-Language: en-GB
From: Phil Pemberton <philpem@philpem.me.uk>
In-Reply-To: <a32d15ae-2303-427c-9d06-d7d1df235ed0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[philpem.me.uk,reject];
	R_DKIM_ALLOW(-0.20)[philpem.me.uk:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[philpem.me.uk:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23257-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philpem@philpem.me.uk,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,philpem.me.uk:mid,philpem.me.uk:email,philpem.me.uk:dkim,philpem.me.uk:url]
X-Rspamd-Queue-Id: 858A7454907
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/04/2026 12:08, Hannes Reinecke wrote:
> On 4/20/26 14:23, Phil Pemberton wrote:
>> Two changes are required to route commands to ATAPI LUNs other than 0:
>>
>> 1. __ata_scsi_find_dev():  The existing code rejects any scsi_device
>>     with a non-zero LUN, returning NULL and dropping the command on
>>     the floor.  Relax both the PMP and non-PMP branches to allow
>>     non-zero LUNs through when the underlying ata_device is ATAPI
>>     class, since ATAPI devices can legitimately expose multiple LUNs.
>>
>> 2. atapi_xlat():  Older ATAPI devices (SCSI-2 era) expect the LUN in
>>     CDB byte 1 bits 7:5 rather than relying on transport-level LUN
>>     addressing.  Encode scmd->device->lun into those bits, preserving
>>     the existing command-specific bits in 4:0.  This is required by
>>     both the Panasonic PD/CD combos and Nakamichi CD changers.
>>
>> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
>> ---
>>   drivers/ata/libata-scsi.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 317883bac25f..4e88ae7d94c3 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -2951,6 +2951,11 @@ static unsigned int atapi_xlat(struct 
>> ata_queued_cmd *qc)
>>       memset(qc->cdb, 0, dev->cdb_len);
>>       memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
>> +    /* SCSI-2 CDB LUN encoding: bits 7:5 of byte 1 */
>> +    if (scmd->device->lun < 8)
>> +        qc->cdb[1] = (qc->cdb[1] & 0x1f) |
>> +                  ((u8)scmd->device->lun << 5);
>> +
> 
> Hmm. And what happens when scmd->device->lun is _greater_ than 7?
> We surely should abort that command, shouldn't we?

I was about to say "you can't have LUNs greater than seven" until I saw 
it's been extended in later versions of the standard.

What's the preferred way to abort the command in this context?

-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/

