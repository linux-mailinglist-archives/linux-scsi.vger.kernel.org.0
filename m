Return-Path: <linux-scsi+bounces-20918-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMk+K9PAlGkXHgIAu9opvQ
	(envelope-from <linux-scsi+bounces-20918-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Feb 2026 20:26:11 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC6914F9E8
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Feb 2026 20:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C93AC30074EC
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Feb 2026 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4836CE14;
	Tue, 17 Feb 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FNdY1BGQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8110294A10;
	Tue, 17 Feb 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356366; cv=none; b=SIk156lm+rmoV8v0wuczPbdmNux3N61nHAqPYPcDj/dU+1fDONEtucy2Ma5sF8W86gEhG35O+DbByZfXYzGo4RF+hfGOZDE4mdzwzoybeR3cUOBrvjg3cClDsgsvkVgz76VfkJyuaPKLOOGrrdEUcqyYAv3S6TGepSOguyKRTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356366; c=relaxed/simple;
	bh=HMhq+q2YhFC+cxrAnPfr9IT2151Th3pDAVDr2aXKnzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4DjKfl1Dxc941b24ZlTNo2nOzGxbYJhiPURHUb4MzO4X9PwpsD3Iv94vOSFaOOXonXgbcBs1EBRMUpSfYxadZcDn9Ic06Ass9DHcDndmct456bmPAEdOovlPPRudbUo6CrHhb9biTgowVIuzErxvCdBwOSYKNuFa8o9s+e+Pd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FNdY1BGQ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fFqPM2cFFzlfl8N;
	Tue, 17 Feb 2026 19:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771356357; x=1773948358; bh=Q/dy/mCL1L8B1QMUSYUopnFw
	uAwqOl7aQk4BGp7SVf0=; b=FNdY1BGQ5ZtPeeVZusZN3MdN+DfAg4qLQt6kD9yF
	LeYDlWW+AdDa4N1uWcv+gm8TRGFTXIL+XC7weJd/v+GqBttphUhbLWP+5n4bdt2G
	7nrnqAi4gOqDOsyXbDo5unrHRVfxzzgTTRVZU6o+rkjbhOJguDUpuq7vLPIFd6V5
	RaqHOG1rodOoxXsTLTOTWpv31JYV7sE9Z7Ph3OccDFNEFT2HHolpjC/A8lABSaGA
	OsrT5CEQca5iDqSVxqtGxSsSWAEmfFfAAjavEe4PeYzF063hSrh8PvMq7b9AUCp0
	/WXIahEA6TjUKRI25rLhppmdglFYM3JBaB3p5nbsxYXBxg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ui_qCjFeZn0y; Tue, 17 Feb 2026 19:25:57 +0000 (UTC)
Received: from [10.237.57.149] (173-255-98-114.utilitytelephone.net [173.255.98.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fFqPH107mzlfjRJ;
	Tue, 17 Feb 2026 19:25:54 +0000 (UTC)
Message-ID: <532ecccc-a225-44d2-bab9-52f0f758fb8b@acm.org>
Date: Tue, 17 Feb 2026 11:25:53 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: core: Add 'serial' sysfs attribute for SCSI/SATA
To: Igor Pylypiv <ipylypiv@google.com>, Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260209212151.342151-1-ipylypiv@google.com>
 <d61a1830-d9d0-4697-b547-80106ce57023@suse.de> <aYtiDLvRotCE0hEt@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aYtiDLvRotCE0hEt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20918-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CC6914F9E8
X-Rspamd-Action: no action

On 2/10/26 8:51 AM, Igor Pylypiv wrote:
> On Tue, Feb 10, 2026 at 12:38:51PM +0100, Hannes Reinecke wrote:
>> On 2/9/26 22:21, Igor Pylypiv wrote:
>>> +	if (sn_size < len + 1)
>>> +		return -EINVAL;
>>> +
>>> +	memcpy(sn, d, len);
>>
>> 'len' might well be '0' after 'strim()', please check
>> before calling 'memcpy'.
> 
> It looks like calling a memcpy() with zero length is a no-op. Is checking
> for len > 0 really necessary in this case?

It seems to me that the Linux kernel memcpy() implementation handles len 
== 0 fine. From lib/string.c:

void *memcpy(void *dest, const void *src, size_t count)
{
	char *tmp = dest;
	const char *s = src;

	while (count--)
		*tmp++ = *s++;
	return dest;
}
EXPORT_SYMBOL(memcpy);

Bart.

