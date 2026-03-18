Return-Path: <linux-scsi+bounces-22175-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMUQLr9bumnFUgIAu9opvQ
	(envelope-from <linux-scsi+bounces-22175-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 09:01:03 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A482B7655
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 09:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34FB630AB0FF
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79258372B25;
	Wed, 18 Mar 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KB21++dS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wEldz0bY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KB21++dS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wEldz0bY"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23616370D62
	for <linux-scsi@vger.kernel.org>; Wed, 18 Mar 2026 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820670; cv=none; b=KKjhuGj9sZmumjbwIkTW9Q2lxa+CIpOScnVs/QfsOGzDSAi1SYa24iLDgOiiH9pS8BeNM0lA1u+xCdGGC/DgK4lSGIztfNs2SR8ba4hZT+2uyims7qfwigA/z4m45dBFwwUvnfOPLjX/SFqtha5+cjqMXS3zA6xvGmM7NUPrkTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820670; c=relaxed/simple;
	bh=N17Moq2ZUjOGCcQPvCGNcJDAPGJY9D4Lz8fzcdyCSUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUD3U/jdPUjA79uKTW+NRJnAomyQBVBv2eIWjQNy9ilZh3wHGfUgH0/zshvh+zYHyT9kGfkoypV17qtwooAdDD9QfWRfTEPgbjidgPYr6Mg/3Wu/oii1qJ2HeKReZPxhecn8eX3BRrWg/lnE5nonW4Z4d0yFcz1/3QPoqlAxVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KB21++dS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wEldz0bY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KB21++dS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wEldz0bY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79D484D3D4;
	Wed, 18 Mar 2026 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773820666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je8KKMoMMJJODFi0HW4pooZ4QtpFEZ2JbdY52S0m3vI=;
	b=KB21++dSfXFb7rJtzI8OLScihdnqhdnn/UsM27vsotlD8pyiLwWL4juKelcEdy01VN5nEy
	5iEFNbl6bRox6Uvf/DhN4kv6a7ZW//PfMlqyR/B3Y5Xb7Dmd5v2wcaH/QRHsn7xexf7R7w
	5eBqI5OwHQPFJgocCJSVrqk1qiK64pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773820666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je8KKMoMMJJODFi0HW4pooZ4QtpFEZ2JbdY52S0m3vI=;
	b=wEldz0bYmhpntIsOjPMsyz7rD7D6q997YSV0XOpWj7AYA6Bi8rFn0UyPABPTKzIccc1Z4w
	B84O1+iLdG+QtFAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773820666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je8KKMoMMJJODFi0HW4pooZ4QtpFEZ2JbdY52S0m3vI=;
	b=KB21++dSfXFb7rJtzI8OLScihdnqhdnn/UsM27vsotlD8pyiLwWL4juKelcEdy01VN5nEy
	5iEFNbl6bRox6Uvf/DhN4kv6a7ZW//PfMlqyR/B3Y5Xb7Dmd5v2wcaH/QRHsn7xexf7R7w
	5eBqI5OwHQPFJgocCJSVrqk1qiK64pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773820666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je8KKMoMMJJODFi0HW4pooZ4QtpFEZ2JbdY52S0m3vI=;
	b=wEldz0bYmhpntIsOjPMsyz7rD7D6q997YSV0XOpWj7AYA6Bi8rFn0UyPABPTKzIccc1Z4w
	B84O1+iLdG+QtFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 238C74273B;
	Wed, 18 Mar 2026 07:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fAMcB/paumn0TgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Mar 2026 07:57:46 +0000
Message-ID: <ebbff167-c392-4b5f-b57d-968e2591e4ee@suse.de>
Date: Wed, 18 Mar 2026 08:57:45 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] scsi: alua: Add scsi_alua_check_tpgs()
To: John Garry <john.g.garry@oracle.com>, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com, hare@suse.com, bmarzins@redhat.com
Cc: jmeneghi@redhat.com, linux-scsi@vger.kernel.org,
 michael.christie@oracle.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260317120703.3702387-1-john.g.garry@oracle.com>
 <20260317120703.3702387-9-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260317120703.3702387-9-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22175-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,oracle.com:email]
X-Rspamd-Queue-Id: 30A482B7655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 13:06, John Garry wrote:
> Add a core version of alua_check_tpgs() from scsi_sh_alua.c
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi_alua.c | 53 ++++++++++++++++++++++++++++++++++++++++
>   include/scsi/scsi_alua.h |  6 +++++
>   2 files changed, 59 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

