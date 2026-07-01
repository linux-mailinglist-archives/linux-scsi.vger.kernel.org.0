Return-Path: <linux-scsi+bounces-25438-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e2jUKhtdRWoL/AoAu9opvQ
	(envelope-from <linux-scsi+bounces-25438-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 20:31:55 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 121776F09E1
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 20:31:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q5phPdva;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v3LeSbuA;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q5phPdva;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v3LeSbuA;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25438-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25438-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3209302630D
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 18:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94D933ADB2;
	Wed,  1 Jul 2026 18:31:53 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37099330D35
	for <linux-scsi@vger.kernel.org>; Wed,  1 Jul 2026 18:31:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930713; cv=none; b=leFq9B46R+W821QgEmw7pw5VPtNQTfqiHWr+BrvGaxx4hkbfjyU5FWBRuw/2bp3K344OOIKnUiQUnIBIrVwbWhXJbNxMdONwIN2dvgXe59fkPBwZ0BU0nCJ8DwR8mCDkBwkIZZpn7NNqyDnft8j0sHsVau0QkvSO8V5fSYfQ2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930713; c=relaxed/simple;
	bh=I73QlQZ6etcC/ViEpSvUp6ckys3J8IQRQDqUtgE2hwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIQoP0pC9/2X4s+H50EnZEEHO6onCUtOOv7QZmi8z7SW4gBvGTqlkJeV4q9wMYExrR9k79jJlss2qcJktJeAD+jbuABUzUwtfWW03aP3Q4tWU1VphOodIWYELzQYhfYa0B45dH4mJiYPl0XmadjW+Wvac+SMOa4Rk0TID7k4Xw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q5phPdva; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v3LeSbuA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q5phPdva; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v3LeSbuA; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60F0E7598B;
	Wed,  1 Jul 2026 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782930709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jvuKD9/ufkG7smd9/XxhKa2emtCEznJyOQ+7FmXR40=;
	b=Q5phPdvaZ65YgcA+6aJWcH4nVd3EMgfVLxmJJ9zKZudlOHnuw1OeePkN7nZcXRyhJW8AfC
	omYeFQzLJuc35AgvqciJx2IUii3SaphxNWFbF0oQnRG28MObc/OH5/yzDVgGwwivLBwKtk
	um6AsPQ1Ksv/LVSIqfD9jcvK61O+N/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782930709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jvuKD9/ufkG7smd9/XxhKa2emtCEznJyOQ+7FmXR40=;
	b=v3LeSbuArnIqsmM/iXYO8sdahlnEa8IERUQvcPndtg9qeuhNHSB23OUMM6pmkXVAR9uh76
	oisNHwe+gZ8elTAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782930709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jvuKD9/ufkG7smd9/XxhKa2emtCEznJyOQ+7FmXR40=;
	b=Q5phPdvaZ65YgcA+6aJWcH4nVd3EMgfVLxmJJ9zKZudlOHnuw1OeePkN7nZcXRyhJW8AfC
	omYeFQzLJuc35AgvqciJx2IUii3SaphxNWFbF0oQnRG28MObc/OH5/yzDVgGwwivLBwKtk
	um6AsPQ1Ksv/LVSIqfD9jcvK61O+N/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782930709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jvuKD9/ufkG7smd9/XxhKa2emtCEznJyOQ+7FmXR40=;
	b=v3LeSbuArnIqsmM/iXYO8sdahlnEa8IERUQvcPndtg9qeuhNHSB23OUMM6pmkXVAR9uh76
	oisNHwe+gZ8elTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36E93779AD;
	Wed,  1 Jul 2026 18:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HJHlCxVdRWrmMQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 01 Jul 2026 18:31:49 +0000
Date: Thu, 2 Jul 2026 04:31:26 +1000
From: David Disseldorp <ddiss@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org, "Martin K.
 Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/2] scsi: target: fix CHAP_N handling
Message-ID: <20260702043126.37fe9855.ddiss@suse.de>
In-Reply-To: <8a1ba462-50ac-45b2-9d38-4a2671f7a1f9@oracle.com>
References: <20260602115840.26490-1-ddiss@suse.de>
	<d8126fb0-85ac-4b1f-b6e0-b4e206ec90c3@oracle.com>
	<20260603091924.0892d415.ddiss@suse.de>
	<8a1ba462-50ac-45b2-9d38-4a2671f7a1f9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25438-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ddiss@suse.de,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:target-devel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-scsi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email,urldefense.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 121776F09E1

Bumping this, as I still think it's worth addressing...

On Wed, 3 Jun 2026 09:24:19 +0100, John Garry wrote:

> On 03/06/2026 00:19, David Disseldorp wrote:
> > On Tue, 2 Jun 2026 17:42:57 +0100, John Garry wrote:
> >   
> >> On 02/06/2026 12:43, David Disseldorp wrote:  
> >>> The sashiko bot pointed out issues with CHAP_N handling recently, when
> >>> reviewing a patch for a separate issue:
> >>> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260521151121.808477-1-hossu.alexandru*40gmail.com__;IyU!!ACWV5N9M2RV99hQ!MNesZJ3IsH9Mv0iZxHUcVmbC_3uwDkJgMhAX8i1TelyqqZD_dAq1cwIy6RtYI8D3boJh5iFeGhtTvfTX$
> >>>     Since extract_param() unconditionally strips '0x' or '0b' prefixes and
> >>>     alters the returned type, wouldn't a valid user with a name like '0xalice' or
> >>>     '0bob' have their username mutated to 'alice' or 'ob'?  
> >>
> >> is there a real world case or vulnerability being fixed here?  
> > 
> > No vulnerability -  the "real world case" is as above: CHAP
> > authentication currently fails if the CHAP username begins with 0x, 0b
> > or the upper case variants. The bug is trivial to reproduce.
> >   
> Understood.
> 
> To me, this is a fix for a problem which does not exist. And even if the 
> spec says it's possible, it does not mean that we need to support it. If 
> 0x prefix is part of the username, I think that problems should be expected.

IMO it's a real problem, e.g.: 'I changed my username from "bob" to
"0bob" and now I can't access my data.'

> Anyway, the code itself looks ok, so:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> But the maintainer can make the judgement to take this obviously.

Thanks for the review.

