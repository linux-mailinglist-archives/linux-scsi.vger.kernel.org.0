Return-Path: <linux-scsi+bounces-6615-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FE925C83
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2024 13:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1A92C310F
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2024 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575FE1836CC;
	Wed,  3 Jul 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DrULvzDh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5PKrpnND";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DrULvzDh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5PKrpnND"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA117B4FF
	for <linux-scsi@vger.kernel.org>; Wed,  3 Jul 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004872; cv=none; b=APhSqFQN7ZASKhD812+D8PX9OyVInRkPVWCI62VzyhoeC8i0p5YTYw3ARBVjnsyZ9tspGPym4wvD65XcC2NnHr3JjqASWpXksmBYGwSR13ERWftkZdGdB8Ng2iAqvX3yLOkgARvfe/zS5jR6gsHlux+Kx/mftzx7OSUn9ZPUnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004872; c=relaxed/simple;
	bh=0rdB0VmpoZTnnjsoMd1VAc3s+ARXF2e3Wri5xbgrt1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HITqc6AvNmT0OpodknUGlotpVYg+QVp2Iv0nNOlTQEWRpOKH8JH85oDwTHwu/yet5DFH17x0yCQHj8IXZrtVEcO8YC5Z6wxgHQamRHzewoKo4c3710PGHcPt+pjzYLvf3AKBah9Z9t/5R48jrbyNJuDogFsSLdRg23escXKc8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DrULvzDh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5PKrpnND; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DrULvzDh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5PKrpnND; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 971B121BA1;
	Wed,  3 Jul 2024 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720004868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPtV4SbygEl4VuexCeazHDniA9ZyZ0O0ZlxOnA1RePI=;
	b=DrULvzDhfu0fR4hN9SNki9lwxqcFZUxyIklS6Hy2/P7GhSBIOLEPgtTWCYGXFDOOAIpuWu
	ZskE+6z+L89/jcTHpZ+Zop5n662sFaagDrhoKO7DULq75HP0ImNrVWhnX9rSmhKYCLRnF6
	w4kMvSSILf2JkZQGhOJ82VcH0aU5sGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720004868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPtV4SbygEl4VuexCeazHDniA9ZyZ0O0ZlxOnA1RePI=;
	b=5PKrpnNDtZasD6+XF0jFwV0N+YljkqcCOuj6hilUFvJbhc5dcvxQYtE/f0TmiNh6sy2Fi+
	YnZGlmPDYYW+Z0Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DrULvzDh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5PKrpnND
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720004868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPtV4SbygEl4VuexCeazHDniA9ZyZ0O0ZlxOnA1RePI=;
	b=DrULvzDhfu0fR4hN9SNki9lwxqcFZUxyIklS6Hy2/P7GhSBIOLEPgtTWCYGXFDOOAIpuWu
	ZskE+6z+L89/jcTHpZ+Zop5n662sFaagDrhoKO7DULq75HP0ImNrVWhnX9rSmhKYCLRnF6
	w4kMvSSILf2JkZQGhOJ82VcH0aU5sGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720004868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPtV4SbygEl4VuexCeazHDniA9ZyZ0O0ZlxOnA1RePI=;
	b=5PKrpnNDtZasD6+XF0jFwV0N+YljkqcCOuj6hilUFvJbhc5dcvxQYtE/f0TmiNh6sy2Fi+
	YnZGlmPDYYW+Z0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 695E713974;
	Wed,  3 Jul 2024 11:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EehNGQQxhWb9cgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jul 2024 11:07:48 +0000
Message-ID: <bc5c6729-0786-4e3f-9aab-121d2d158223@suse.de>
Date: Wed, 3 Jul 2024 13:07:48 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] scsi: myrb: Simplify an alloc_ordered_workqueue()
 invocation
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20240702215228.2743420-1-bvanassche@acm.org>
 <20240702215228.2743420-11-bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240702215228.2743420-11-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 971B121BA1
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 7/2/24 23:51, Bart Van Assche wrote:
> Let alloc_ordered_workqueue() format the workqueue name instead of calling
> snprintf() explicitly.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/myrb.c | 6 ++----
>   drivers/scsi/myrb.h | 1 -
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


