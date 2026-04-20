Return-Path: <linux-scsi+bounces-23122-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFk8IGlk5mkKvwEAu9opvQ
	(envelope-from <linux-scsi+bounces-23122-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 19:37:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 782F9431A08
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 19:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 958AC301981F
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3953A6F1A;
	Mon, 20 Apr 2026 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NyTNdR0U"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BA3A5E8D
	for <linux-scsi@vger.kernel.org>; Mon, 20 Apr 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706637; cv=none; b=rPKfLE3m6woNEH164lZ2VpYX1zVSWDcoz+DmveAyoLD9+QqPvuJkNLbemKOgb8OXxzxmJT7H6n2+rEhphS//wdgtGeM3TtYprUchL3YO0Vm9WD/i3UVv6u5IarSLevOWs/ge8I4khPKFKOmwOUK9ORdlsfyWqHxAHLvO/LSQPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706637; c=relaxed/simple;
	bh=5deyr1PhulKMm8A9Zk2skihFdQUb2hO4iTqt6Zdgk8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YFRFPptQ2Wdz2bgYyrbqS6RpcvVKBoiJP9CQfuR/47cV1rr64gtV2OqxUaWNye48eN1pez7btj7yTWFxKgMwkUm2b+w/9Tc/s+QWkuPtOctPOIfY0gw3QzAatO3vKmnzRnO+Dii5+o8xikuKAF54EALDz1uOdOizAYZ22PB0dGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NyTNdR0U; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fzt3H3gy5zlgtcs;
	Mon, 20 Apr 2026 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776706631; x=1779298632; bh=dVKIkqH1q/lQNs0KvDgyYScS
	/ZOZCHYkpiD8niv8WKQ=; b=NyTNdR0UU2cSI3sliGzede1f9gcHIYHVBEWasvhf
	KB5RAmc2xeWDs73tdm0J8CYvsHzL7w6bOkVV3akEnz7U/u8qW+9Wsu5rZtVFatY0
	cU06NvOeusMRwLGyAiKYk3UwbchPTI7Qe5XC+W4X0ta/sDA6iN/0dFDwsN+iYB4R
	zzBKfvybBpGTUff47UwZqraYtZiW72w+f7KWGjfaml5XDI/2hhy+GIyIZV4+ML13
	nES8469qMkX4tjQxe6l7kOCqgS+uZcR95vvUTzJT2M96fSwIEYSbAUbe65cEHT5o
	7PhWTNzvzxQ73NE03Gd3ft9j5MRTsJiet6sqv4PFvH8wWg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AI6PH3ck0GJJ; Mon, 20 Apr 2026 17:37:11 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fzt3937PBzlfgfG;
	Mon, 20 Apr 2026 17:37:09 +0000 (UTC)
Message-ID: <401c69e6-27fe-4569-b1be-ee8240e26ddb@acm.org>
Date: Mon, 20 Apr 2026 10:37:08 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] virtio-scsi: Support scsi_devices without a device
 wide limit
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
 virtualization@lists.linux.dev, mst@redhat.com, pbonzini@redhat.com,
 stefanha@redhat.com, eperezma@redhat.com
References: <20260417230751.117836-1-michael.christie@oracle.com>
 <20260417230751.117836-5-michael.christie@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260417230751.117836-5-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23122-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 782F9431A08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 3:57 PM, Mike Christie wrote:
>   	cmd_per_lun = virtscsi_config_get(vdev, cmd_per_lun) ?: 1;
> -	shost->cmd_per_lun = min_t(u32, cmd_per_lun, shost->can_queue);
> +	if (cmd_per_lun == U32_MAX)
> +		shost->cmd_per_lun = SCSI_UNLIMITED_CMD_PER_LUN;
> +	else
> +		shost->cmd_per_lun = min_t(u32, cmd_per_lun, shost->can_queue);

Although this has not been introduced by this patch: shost->cmd_per_lun 
is a signed 16-bits variable and can_queue has type u32 so the above
assignment can cause integer truncation.

Thanks,

Bart.

