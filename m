Return-Path: <linux-scsi+bounces-23429-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC2rLWex8WmwjgEAu9opvQ
	(envelope-from <linux-scsi+bounces-23429-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 09:21:11 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2757C4905E5
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFB8B3051D95
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1F346A1C;
	Wed, 29 Apr 2026 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ui6dLRpP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J9qSfKVQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eJAMAc2M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="82O7nivf"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E83A3E60
	for <linux-scsi@vger.kernel.org>; Wed, 29 Apr 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446934; cv=none; b=UsOYtg12SySVRPl2sXiwrXaLnn15AGYSzdKJTIJos7ZeCTYOhDZcRruQW+mzzW9/rNz57GVw97xy8tMjhj8DecUs8XClqBp7WeA+lwobxbPxjFiJq2s9cY2NfwUmTSQS6f9HG4fnMUTfp0N1QepiToZZDvGuAKPX49eRhDLyfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446934; c=relaxed/simple;
	bh=oxqlNa2/y8qjO9ll8Dvgw+y4W7yKloCRO0IzaMmUHtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+oVRFQoIBQsVaXPtZGhVpjh+ggnQeIQSWSwHAh6H1bXWuzC3ujkaQ0MLD7KlaZ6KsgB8rhfJs1dDJYIwgLyOaPVt+yrqcQmsmZxsqokMR848enWXU/ioTAuXn08z13GaX0uAeI0NKpjxFvZ9Y2w8WvWV2pWkL8VwiBtwFW0at0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ui6dLRpP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J9qSfKVQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eJAMAc2M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=82O7nivf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8C556A81B;
	Wed, 29 Apr 2026 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777446931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+M0QKmMGibIDIev9gzuqJ8SGIZVpscaEkkEnzze7Wc=;
	b=ui6dLRpP0xcrWBwX/lfIUf7GD+tHCXC9ln1tqSRB1n8NrRHyVJ6AKpmmNAeWhH6iRugEd5
	3S77gah2+6FArlg5vnda64lZsz2Mq5sPY+FZBAROh+8h9vvAfepEugpK8BiF8V6rXddZf/
	haF8w8MPcvG8+8knqxuFX0wfixz100w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777446931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+M0QKmMGibIDIev9gzuqJ8SGIZVpscaEkkEnzze7Wc=;
	b=J9qSfKVQOlRR2e42u2O4sh3a+DpgFA1j7+YzK29qcg8UrDik46lNrQIo7R5/U2TV6VQRBm
	5zCyXms6rFblBdCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777446930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+M0QKmMGibIDIev9gzuqJ8SGIZVpscaEkkEnzze7Wc=;
	b=eJAMAc2MwcwLKNCUwyEYkSaE7IFXYOGx5bGcZ1lxLylUQIhX4cT0AckPIyeEQqe4rXVwPC
	cKRGvi5PVjxHEvVj505cu6vSwc0k0zywr8cw3Re+UlIEAvJeDw448mHroWZkF+27q0X39i
	e2drt+KvUduHzCEd477cR4wf8FiqSfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777446930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+M0QKmMGibIDIev9gzuqJ8SGIZVpscaEkkEnzze7Wc=;
	b=82O7nivfzJX0mhE90On+lguBHnjxhhH2VEt66Axh7/exWHmXw29ZVf8rUmCXysZ/WGx5If
	IqPbYMl5dolfC+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67944593B0;
	Wed, 29 Apr 2026 07:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eapEFxGw8WkzAwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 29 Apr 2026 07:15:29 +0000
Message-ID: <3a606788-bd88-4249-bf1c-b0f99cf680e3@suse.de>
Date: Wed, 29 Apr 2026 09:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/13] blk-mq: add
 blk_mq_{online|possible}_queue_affinity
To: Daniel Wagner <dwagner@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
 James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 liyihang9@h-partners.com, kashyap.desai@broadcom.com,
 sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
 chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
 sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
 ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, tglx@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org,
 ruanjinjie@huawei.com, yphbchou0911@gmail.com, wagi@kernel.org,
 frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
 kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co,
 sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
 nick.lange@gmail.com, marco.crivellari@suse.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
References: <20260422185215.100929-1-atomlin@atomlin.com>
 <20260422185215.100929-6-atomlin@atomlin.com>
 <20260427153416.MeVS8yxF@linutronix.de>
 <c4927a2b-c18d-42ce-8a60-d6d388155671@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c4927a2b-c18d-42ce-8a60-d6d388155671@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2757C4905E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[atomlin.com,kernel.dk,kernel.org,lst.de,grimberg.me,redhat.com,microsemi.com,hansenpartnership.com,oracle.com,h-partners.com,broadcom.com,cloud.ionos.com,infradead.org,linaro.org,linux-foundation.org,huawei.com,gmail.com,nvidia.com,abita.co,ashe.io,suse.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-23429-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/28/26 14:53, Daniel Wagner wrote:
> On Mon, Apr 27, 2026 at 05:34:16PM +0200, Sebastian Andrzej Siewior wrote:
>> Which driver uses cpu_possible_mask? This mask is assigned at boot time
>> once the kernel figured how many CPUs are possible based on ACPI or
>> whatever the system uses. This mask does not change.
>>
>> I only see drivers/scsi/lpfc/lpfc_init.c using it. Looking at
>> cpu_possible_mask might not be the right thing. It is usually the same
>> thing as "online" except on system where ACPI thinks that something
>> could be added via hotplug _or_ if the admin shuts down a CPU via
>> cpuhotplug _or_ boots with less (there a command line option for
>> that).
> 
> These HBAs are used on PowerPC which supports lpar (CPUs can be added
> during runtime) I am told it's properly the only driver which is caring
> about this type configuration, thus a bit of an odd ball.
> 
>> In case cpu_possible_mask != cpu_online_mask the intention is to
>> allocate memory and setup irqs for the offline CPUs?
> 
> I can't answer this. The lpfc driver has several strategies implemented
> how it spreads its resources.

The intention is to setup the driver queue affinity only once (knowing 
that all possible CPUs are handled correctly), avoiding a driver
reconfiguration on CPU hotplug.

Not the most efficient one, sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

