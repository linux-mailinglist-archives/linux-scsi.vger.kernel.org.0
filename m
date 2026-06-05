Return-Path: <linux-scsi+bounces-24475-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lk8KFSCyImoScQEAu9opvQ
	(envelope-from <linux-scsi+bounces-24475-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 13:25:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D14647B22
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 13:25:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rdukO1tZ;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rdukO1tZ;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24475-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24475-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76415307B4CF
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2026 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A13A4CA29B;
	Fri,  5 Jun 2026 11:15:59 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157D41931B
	for <linux-scsi@vger.kernel.org>; Fri,  5 Jun 2026 11:15:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658159; cv=none; b=M7rFncya1Kofj1CKFBnUe8/yRt5Xqed7IID/6B4jQ9dHM+SWPJ3MRsF4740SSm41p413W5zyKXdT8eo010gba0Fk9sTN9uHJ5Nyzj87n/IXVAq7fmCxxRFGwNl0Erxq86Z0KRjUrCKwkQo62ykM/i88B1PT8ucY/kzkhRK9aHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658159; c=relaxed/simple;
	bh=kqxiOotK0FA1RkAiHhG2IBA+vwuPdIDMrIhttxYJopM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeBgAeTa1isjxQug4bBwhXuyO4SVpZ3XPvuCJWwONO3UF7IxqSuShauDjNVY6nd9Lkl23E4xFPwSTsqk4r8kiYSKORdyGcMD+M3stFddbPq6UFFaFAlPPtiAvF8OOsgjzMEntEaIM3XRJXccMiQKvKHYncdpGBsIZUZaJdM3HoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rdukO1tZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rdukO1tZ; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 234DB68574;
	Fri,  5 Jun 2026 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780658156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqxiOotK0FA1RkAiHhG2IBA+vwuPdIDMrIhttxYJopM=;
	b=rdukO1tZQ/5OTSb2Pble2X5+mt7jVSomYJjZI5HxOr9IFFEqWcUuF8DUCzWjCCRJ5LU/Yz
	7fjso5eiR1Rv8WUsjawhAlGGqpYCcfPp+dxPrI9dSMN/B3SLZ2C+KrcbdTdwLzgtCXZp+s
	wcM8tiI5LK+Gw9CakFLXO2V3E31QnQg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780658156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqxiOotK0FA1RkAiHhG2IBA+vwuPdIDMrIhttxYJopM=;
	b=rdukO1tZQ/5OTSb2Pble2X5+mt7jVSomYJjZI5HxOr9IFFEqWcUuF8DUCzWjCCRJ5LU/Yz
	7fjso5eiR1Rv8WUsjawhAlGGqpYCcfPp+dxPrI9dSMN/B3SLZ2C+KrcbdTdwLzgtCXZp+s
	wcM8tiI5LK+Gw9CakFLXO2V3E31QnQg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBC1A779A9;
	Fri,  5 Jun 2026 11:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j0+SNOuvImqoEAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Fri, 05 Jun 2026 11:15:55 +0000
Message-ID: <91b28db156bf1a643cbe6b6380d2361f2b954a98.camel@suse.com>
Subject: Re: [PATCH] scsi: devinfo: broaden Promise VTrak E310/E610
 identification
From: Martin Wilck <mwilck@suse.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Alexander Perlis <aperlis@math.lsu.edu>, Nikkos Svoboda	
 <nsvoboda@math.lsu.edu>, Benjamin Marzinski <bmarzins@redhat.com>, 
 Christophe Varoqui <christophe.varoqui@opensvc.com>, Christoph Hellwig
 <hch@lst.de>, "James E.J. Bottomley"	
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"	
 <martin.petersen@oracle.com>, SCSI-ML <linux-scsi@vger.kernel.org>,
 DM_DEVEL-ML	 <dm-devel@lists.linux.dev>
Date: Fri, 05 Jun 2026 13:15:55 +0200
In-Reply-To: <20260529205602.177515-1-xose.vazquez@gmail.com>
References: <20260529205602.177515-1-xose.vazquez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24475-lists,linux-scsi=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xose.vazquez@gmail.com,m:aperlis@math.lsu.edu,m:nsvoboda@math.lsu.edu,m:bmarzins@redhat.com,m:christophe.varoqui@opensvc.com,m:hch@lst.de,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:dm-devel@lists.linux.dev,m:xosevazquez@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mwilck@suse.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwilck@suse.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,suse.com:mid,suse.com:dkim,suse.com:from_mime,suse.com:email,vger.kernel.org:from_smtp,lst.de:email,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6D14647B22

On Fri, 2026-05-29 at 22:56 +0200, Xose Vazquez Perez wrote:
> The Promise VTrak Ex10 series share the same hardware base and
> firmware.
> Consequently all interface variants, whether fibre channel ("f") or
> SAS ("s") in dual/single controller, exhibit the same SCSI behavior.
>=20
> Instead of adding separate blacklist entries for every specific model
> variant (such as E610f, E610s, E310f, E310s), consolidate and
> broaden the match strings to "VTrak E310" and "VTrak E610".
>=20
> Cc: Alexander Perlis <aperlis@math.lsu.edu>
> Cc: Nikkos Svoboda <nsvoboda@math.lsu.edu>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Benjamin Marzinski <bmarzins@redhat.com>
> Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: SCSI-ML <linux-scsi@vger.kernel.org>
> Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

Reviewed-by: Martin Wilck <mwilck@suse.com>

