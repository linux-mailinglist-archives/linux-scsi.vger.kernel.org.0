Return-Path: <linux-scsi+bounces-25110-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qgo4D572OGrFkgcAu9opvQ
	(envelope-from <linux-scsi+bounces-25110-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 10:47:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739E6ADE5A
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 10:47:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kk8HxdPG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iSCD3x1h;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kk8HxdPG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iSCD3x1h;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25110-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25110-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB8C3059E32
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70E391501;
	Mon, 22 Jun 2026 08:43:08 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E331DA60D
	for <linux-scsi@vger.kernel.org>; Mon, 22 Jun 2026 08:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117788; cv=none; b=cT3wHsrtferuX1HwYJR60CriZ7kjoxvPjmwnE/ZU69T+amo5OlpQwn4NbjGDPUMMO2kM1vzdyjnLPjd761eIFLbRTn7ljpKvw2kvqqYp0TrRBVJFnO4uRa6UaWaNAse2G1cRGPWrZMxcz5sZzafs8fpvZsq/5tLGEqifwcl/Jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117788; c=relaxed/simple;
	bh=qf8qMcD/GnPP7Ua6yt+EU7wi1GFYIkY9uJ+yOZ5sjus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAuK+3Nl1yUOi8ZH31tf9KbSjNmkrCNUByjY/SGAG79Q9qhXj5m5MQ0OJLiaRpFpt2VvzsLwS3cjFx/Ya2RHvArPMWZ9thdSjaxHooUCm4bpDaF1kL/7G8k4ijfqEtSE9TdXfs306VcmXW89aFWBNbChID4mRTO9ybOUIMneDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kk8HxdPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iSCD3x1h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kk8HxdPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iSCD3x1h; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 619C66B64A;
	Mon, 22 Jun 2026 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782117785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qf8qMcD/GnPP7Ua6yt+EU7wi1GFYIkY9uJ+yOZ5sjus=;
	b=kk8HxdPGoxHbFz3WW+wp/qFpGeO6L80Zfel68jv5LFsqPUMBw72Vwq62rR06Q52OtOwlwV
	XO0QCqf/JQbsYYZoNvUPQgXtnA9n3ftb2DXsRhwvppTQ1FpF3K2My4bzCg6XwmRstqPFYI
	vq5uNpS4ysk/7tbghOJFivDuXRocWe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782117785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qf8qMcD/GnPP7Ua6yt+EU7wi1GFYIkY9uJ+yOZ5sjus=;
	b=iSCD3x1hS+QM4QYbpMNKSMO2/bB7WXBYAvYNJ249n0ItbSLR/RL7yk9aaQYeH+nTaxhSuK
	6MQZlECGP5oebOCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782117785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qf8qMcD/GnPP7Ua6yt+EU7wi1GFYIkY9uJ+yOZ5sjus=;
	b=kk8HxdPGoxHbFz3WW+wp/qFpGeO6L80Zfel68jv5LFsqPUMBw72Vwq62rR06Q52OtOwlwV
	XO0QCqf/JQbsYYZoNvUPQgXtnA9n3ftb2DXsRhwvppTQ1FpF3K2My4bzCg6XwmRstqPFYI
	vq5uNpS4ysk/7tbghOJFivDuXRocWe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782117785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qf8qMcD/GnPP7Ua6yt+EU7wi1GFYIkY9uJ+yOZ5sjus=;
	b=iSCD3x1hS+QM4QYbpMNKSMO2/bB7WXBYAvYNJ249n0ItbSLR/RL7yk9aaQYeH+nTaxhSuK
	6MQZlECGP5oebOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44CF3779A8;
	Mon, 22 Jun 2026 08:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FAnvDpn1OGqgCgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 22 Jun 2026 08:43:05 +0000
Date: Mon, 22 Jun 2026 10:43:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: sashiko-reviews@lists.linux.dev
Cc: Haoxiang Li <haoxiang_li2024@163.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: elx: efct: Fix IO leak on unsupported additional
 CDB
Message-ID: <947fd1e6-cbf0-4b2e-a0c7-9d4bda439ff2@flourine.local>
References: <20260622075844.832871-1-haoxiang_li2024@163.com>
 <20260622081220.9D0B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622081220.9D0B71F000E9@smtp.kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25110-lists,linux-scsi=lfdr.de];
	FREEMAIL_CC(0.00)[163.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dwagner@suse.de,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:haoxiang_li2024@163.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwagner@suse.de,linux-scsi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,flourine.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8739E6ADE5A

Indeed, the callsite needs to handle the error code return by
efct_dispatch_fcp_cmd and not just blindly enqueue the io.

