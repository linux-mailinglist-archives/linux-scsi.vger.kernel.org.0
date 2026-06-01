Return-Path: <linux-scsi+bounces-24272-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLpNF5wsHWo4WAkAu9opvQ
	(envelope-from <linux-scsi+bounces-24272-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 08:54:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A761A70E
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 08:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CD7C300DA5A
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Jun 2026 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D73803C3;
	Mon,  1 Jun 2026 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zs7ILprS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0BkD+4ZE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZEFy3pHF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VOg5ODbJ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B71A0BF3
	for <linux-scsi@vger.kernel.org>; Mon,  1 Jun 2026 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296789; cv=none; b=sQK2AMtE3rSvpUXUNec705uJ85tDbDdAhRWUGuOLkcdnHrpZY6DIZ5TmeUR1uJZwVG5hug5FwqJK7mR23eJhfp4AZ397spxkSmBJv/LpVmqaDR1iPOZGhN9RBqcHUX0At1QPL885fAdRaQBZF1ri3SceGYqvw5/fU2LBUp6WMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296789; c=relaxed/simple;
	bh=akeDaFB5wU3z95KJgOTfjRX5nDuhgErjLQmTst17+Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoIU59Qb8U5MahddGkDTHdi9Hn7ebq2nO9dLmxeqc+U1NZV46ulZ1q1CyPSRKxNRrsKniXN94cn+hk8btchkTzSUq4pcCZt8ihunL7ECfKj4Jakg0aVtnTd0rQkUxhsR37oPKZGEZNjXR9ykjQF4pleq+XCmkJNrIhU6CjDu/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zs7ILprS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0BkD+4ZE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZEFy3pHF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VOg5ODbJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCF5E6AF23;
	Mon,  1 Jun 2026 06:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780296786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itUE2gJoi6CNrjHxuEqdq9MAqdo4hfB5rDxSoEg7tLs=;
	b=Zs7ILprSkPEC5S754WMCnvXk0Gp2NP28OVZMun3A06YUiiO6cwJA13TPH/RvcjWi/9A5VT
	PCCRVXXAIN9cqM059iEoiRWAQ6r1iuyp/IysbbG2DJvrVcqrqgL19s7KDrNM6X/iHHjuB0
	oJi6Muh3pRHChQU1xRjq3a01GnbYGOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780296786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itUE2gJoi6CNrjHxuEqdq9MAqdo4hfB5rDxSoEg7tLs=;
	b=0BkD+4ZEO25Vt7gfdrYagjS2JCca8RC2BqY08vdmNcx8xRmOFED3JBRMaZaPazEXIoEWvR
	lH6D8f2AZsX3BdAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZEFy3pHF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VOg5ODbJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780296784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itUE2gJoi6CNrjHxuEqdq9MAqdo4hfB5rDxSoEg7tLs=;
	b=ZEFy3pHFKntyCGilgvScs+LGYTj6dqk7AeX6ADZhgB92cn7XMmbvzaQ+1xRh8x+HfxT1B8
	arWP5+kN2dgzzafXA4p/e4+117PNln/qxqlH+rfTAoHMO7ZU4EzZ3rRXPcbfOwSRfnLmcE
	u8vhOaNDrmrx+uBlXLBiO2DSKTdIlQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780296784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itUE2gJoi6CNrjHxuEqdq9MAqdo4hfB5rDxSoEg7tLs=;
	b=VOg5ODbJCLhM3fOP6KkN/guWfpaB4HiWnTW6CEolf+r8m3jOeL5mWdFaoacPra1I8PmDv8
	lawdcdRZ4C/C+ZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A93C3779A7;
	Mon,  1 Jun 2026 06:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A/LUJ1AsHWrbMQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Jun 2026 06:53:04 +0000
Message-ID: <7e8ddf13-91eb-430d-a12f-4604923134a8@suse.de>
Date: Mon, 1 Jun 2026 08:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] scsi: core: Handle reprobe for existing devices
 during SCSI scan
To: Brian Bunker <brian@purestorage.com>, linux-scsi@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 bvanassche@acm.org, Krishna Kant <krishna.kant@purestorage.com>
References: <20260429224939.77082-1-brian@purestorage.com>
 <20260530002019.47109-1-brian@purestorage.com>
 <20260530002019.47109-6-brian@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260530002019.47109-6-brian@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-24272-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,purestorage.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C50A761A70E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/30/26 02:20, Brian Bunker wrote:
> Complement scsi_rescan_device() reprobe by handling the scan path.
> Update INQUIRY data and reprobe existing devices when PQ or type changed.
> 
> Co-developed-by: Krishna Kant <krishna.kant@purestorage.com>
> Signed-off-by: Krishna Kant <krishna.kant@purestorage.com>
> Signed-off-by: Brian Bunker <brian@purestorage.com>
> ---
>   drivers/scsi/scsi_scan.c | 91 ++++++++++++++++++++++++++++++++++++----
>   1 file changed, 83 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

