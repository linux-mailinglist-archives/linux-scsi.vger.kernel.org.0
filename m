Return-Path: <linux-scsi+bounces-23773-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNAOOFBEBGqqGQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23773-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 11:28:48 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ADE530A0E
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 11:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E7C30143D4
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 09:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CFC3314D9;
	Wed, 13 May 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WK9PBkyt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ox25IcZv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NyzIdnGM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kdBfaUrI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950D36F919
	for <linux-scsi@vger.kernel.org>; Wed, 13 May 2026 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664524; cv=none; b=RNa1Jc3TT0k0QvJq9EazqEIVVh9N7GV0WwDvBqOqBcr9UTEMPQvNPDUD7EdI0kNGduU8i91XSH0ehqF4xivD7hrROGEqBCIBB9pMyYOqzGhGYZU3Stc6VVqYhf4uClsbt56iSqKvHSbpE8xUCtbzzYXEZQEGztd899TmD/3TR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664524; c=relaxed/simple;
	bh=KGtgU2UypPsxwykBs5YUHCdKxx3XWW26uQVCpP6Nh8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSM8zJYkpcl+qHvVerWGnh85fz8KQrb6XiBT1xCi7Z+ilVqE8HgBjm+OphE66hDwCqvYXqx075HaM6Fc3qq4u3D89Fsfp2L3IKldldB71d/yrOSg7IuHf7N+MAWDScnDfXYz1T1D4M9GD3vc7936FrVrVjMqbwE7npDYD36WsqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WK9PBkyt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ox25IcZv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NyzIdnGM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kdBfaUrI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE5837628A;
	Wed, 13 May 2026 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778664521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLhQ0qlAU9phYh6jhyeYrsU3J4pVkdMJrM9FXq6tfRg=;
	b=WK9PBkytCHktvNBMQC4wNAZtgQSS2Dm3Bl0TB13PGSounMSK+wbYFnefcMp/I3kKHWR1bw
	WDqIIB90k07W9hg4S4JvgCgUDRLvkma1zLoBYU01owOmhq1NdJVhpAj0utFhZ/ImuecHME
	Kg1aeOBA6Q/dlw1brKl3dTfCuOxL4t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778664521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLhQ0qlAU9phYh6jhyeYrsU3J4pVkdMJrM9FXq6tfRg=;
	b=Ox25IcZvb3NdKtZPEWoeQbO2ChXRovVoKCvyxPG+mD2QUwf55l/bnicIFqWCfI5Kd/cY10
	U//vwaeRxpQ4nbBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NyzIdnGM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kdBfaUrI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778664520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLhQ0qlAU9phYh6jhyeYrsU3J4pVkdMJrM9FXq6tfRg=;
	b=NyzIdnGM+pT5sTtl6ARd4nMnXzGOw84fwQEWYB3GrtKHVmkTwLOKGm+WCk1svUqiD1/CVC
	ImCusufrvt0OJOLsC1ugdeV/eeS5agNFxZm9ikNDOoJNkr+eMnTDidXORjacP4/jCgkpkg
	LhNqHhIyETNgGpK7qXaMtr/5089Ri5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778664520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLhQ0qlAU9phYh6jhyeYrsU3J4pVkdMJrM9FXq6tfRg=;
	b=kdBfaUrIqw7KAmWve7OrqeooWfE7Qo5PV1lNMcoHihLYDf+9wzcY40AbfVsnPQWJ8SzOmG
	ZYfZ2jT1f7mZOYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D90E5593A9;
	Wed, 13 May 2026 09:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UueENEhEBGpiaQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 May 2026 09:28:40 +0000
Message-ID: <0e1b7f75-8500-4ac1-8e15-9c381ff955ae@suse.de>
Date: Wed, 13 May 2026 11:28:40 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: core, target: Move three constants into
 <scsi/scsi_common.h>
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, Brian Bunker <brian@purestorage.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20260512194634.58145-1-bvanassche@acm.org>
 <20260512194634.58145-2-bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260512194634.58145-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 78ADE530A0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23773-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Action: no action

On 5/12/26 21:46, Bart Van Assche wrote:
> Prepare for using these constants in the SCSI core.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/scsi/scsi_common.h        | 4 ++++
>   include/target/target_core_base.h | 5 +----
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

