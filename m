Return-Path: <linux-scsi+bounces-23782-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNWqNH23BGqKNQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23782-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 19:40:13 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E35382B6
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 19:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C675B30073D8
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464004D2EC5;
	Wed, 13 May 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1k015M3Q"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E34968E2
	for <linux-scsi@vger.kernel.org>; Wed, 13 May 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694009; cv=none; b=kUbNe3RwRVEq4k9QUGNYyKThQfbaTp4Nf6qFmuANbqMCO85IvoIX0pWR5a1CqHoiGpTtIXL/vD6XD6dFLBOcKny0hMQO60yWiVbVir5loka4Sftg02jbAyPZsZhtS3nKUQetmZp0gXA0v8krDTZnsB/sVerf9A8ToQn+4jN1nU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694009; c=relaxed/simple;
	bh=SW8qtmVYVox8l73MHaUg2Il26EQ6wiiF1Y8M6ymsCms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRY9iby6oaWwnKsRJU7BM19sO5+82ogVdB08m3Ou3BGZQYUbQ6gva8GkUzFTKuV1mU4/l+yP6Jk6M2FzB4IuZJzxGjUCk8QeUCmQaRZHKflmp1X9JTrGnB6+gG5oytOZjPeHd4eR6YEoXz6oonN8jazu1IC/tpEMBN/0MIpx/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1k015M3Q; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gG11z2KvLz1XM6JH;
	Wed, 13 May 2026 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778694003; x=1781286004; bh=s8DaqZynxXDdTO3fddKTn+XG
	nlr6rK8F+LVPaUBEe64=; b=1k015M3QdDhM0KJVi/nSIprYdv3jvH2uHLXKanVr
	gQJ0H7VQe37FUWmdkTgwInql7cQgu3R/hwuHWFpdE9/n+CYHVGgS0YO8lkb+8JlJ
	JBEdLDoiUXiNQN17Sb+y9RfK9taw+QmiEFny88AGnxQ7gLpl+XbDm9nLAGT/oXeA
	/J0vIcZC17vm5KbSf5InZrwddFXkyMIeXtdlIXgCbR01/yf1fJec0qtDbGOyBI2T
	nnFvc0xXEQVXVbEfxP0d6yesGzu6PaNn644FSAeKM6O7XYuX3A5Va2f0HZ1kwUDl
	1l4nHYwrkYuhw4/EJMfBgvoLAQelu3Cy/e2NK8gQ30BvmA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 22cxo0J7FZVX; Wed, 13 May 2026 17:40:03 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gG11t0ckcz1XM6JG;
	Wed, 13 May 2026 17:40:01 +0000 (UTC)
Message-ID: <1a68681a-3080-4279-9406-96838bba4345@acm.org>
Date: Wed, 13 May 2026 10:40:01 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: core: Convert inquiry information
To: Hannes Reinecke <hare@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, Brian Bunker <brian@purestorage.com>,
 Damien Le Moal <dlemoal@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20260512194634.58145-1-bvanassche@acm.org>
 <20260512194634.58145-3-bvanassche@acm.org>
 <dc50e8ba-9c5b-41e9-8549-bde33a05f64a@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <dc50e8ba-9c5b-41e9-8549-bde33a05f64a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4C6E35382B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23782-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim]
X-Rspamd-Action: no action

On 5/13/26 2:33 AM, Hannes Reinecke wrote:
> Question is whether we shouldn't make this generic, ie treat 'inquiry'
> as a temporary blob, copy things over to fields in 'sdev', and then
> free the 'inquiry' blob again.
> There are soo many things tacked onto the standard inquiry data 
> (especially for storage array trying to mimic SCSI-2 inquiry data),
> that we're better of copying over only fields which we _know_.
> _And_ it'll save us a permanent data allocation for the scsi device...
> 
> Hmm?

Are you perhaps suggesting to remove the inquiry sysfs attribute? From
scsi_sysfs.c:

static ssize_t show_inquiry(struct file *filep, struct kobject *kobj,
			    const struct bin_attribute *bin_attr,
			    char *buf, loff_t off, size_t count)
{
	struct device *dev = kobj_to_dev(kobj);
	struct scsi_device *sdev = to_scsi_device(dev);

	if (!sdev->inquiry)
		return -EINVAL;

	return memory_read_from_buffer(buf, count, &off, sdev->inquiry,
				       sdev->inquiry_len);
}

Bart.

