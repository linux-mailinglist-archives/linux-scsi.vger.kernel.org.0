Return-Path: <linux-scsi+bounces-23236-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEJQOBro6Wm2nAIAu9opvQ
	(envelope-from <linux-scsi+bounces-23236-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 11:36:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 604D044FC14
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 11:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45FAB301379F
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A93E4C8E;
	Thu, 23 Apr 2026 09:36:05 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FB3E4C68
	for <linux-scsi@vger.kernel.org>; Thu, 23 Apr 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936965; cv=none; b=S3hGymM+HNF/EUp9PO6bwl03Yb8j+KIKlzk9qCDexB2nghJdxGKpSgJxmol401TvaNx/fbvirk8EVJsPac5eXS0GeLx6ljW49dE1jTefXHSsL+ovp+ihB145R8xrE7x8ljuuMpangzuQIJOkGmO4Pi2YzR478qBSk8RQdapEuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936965; c=relaxed/simple;
	bh=26OngJjW4/xHxrx0C5o14MErqgvQs7RxRH+/qNSohhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE0mg0KWDEwAdERaAK2bMtOi60TjTx5g5tDy+kUiyf1E1eyOhzqMqyVNNj53hp4HYp/vzo35AmE6Kv9lhi4fqQf7FXNkx5wYP8zh8Wdb3a2+gJC5zA+SomL4kdhL8EjNm/6ygWVgNntlgtpJ/Kq4JIirce+qwY+uWP6DBeCOPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43E7B6A833;
	Thu, 23 Apr 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E21593A3;
	Thu, 23 Apr 2026 09:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zhkOCwLo6WlwOgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 23 Apr 2026 09:36:02 +0000
Date: Thu, 23 Apr 2026 11:36:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>, 
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>, "willy@infradead.org" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <344dd729-c192-4fc2-a226-851305d70f28@flourine.local>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <aY77ogf5nATlJUg_@shinmob>
 <901f4daf-3226-416f-8741-dd15573e736b@linux.ibm.com>
 <aecTw6IYs1fo26EX@shinmob>
 <d6282aa7-4673-4bae-a0ff-fbd84f0a610f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6282aa7-4673-4bae-a0ff-fbd84f0a610f@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[wdc.com,nvidia.com,vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,acm.org,suse.de,lst.de,kernel.dk,grimberg.me,mit.edu,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23236-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwagner@suse.de,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,flourine.local:mid]
X-Rspamd-Queue-Id: 604D044FC14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 01:35:47PM +0530, Nilay Shroff wrote:
> > Taking this chance, I'd like to express my appreciation for the effort to
> > resolve the lockdep issues. It is great that a number of lockdeps are already
> > fixed. Said that, two lockdep issues are still observed with v7.0 kernel at
> > nvme/005 and nbd/002 [1]. I would like to gather attentions to the failures.
> > 
> > [1] https://lore.kernel.org/linux-block/ynmi72x5wt5ooljjafebhcarit3pvu6axkslqenikb2p5txe57@ldytqa2t4i2x/
> > 
> I think nvme/005 and nbd/002 failures shall be addressed with this
> patch: https://lore.kernel.org/all/20260413171628.6204-1-kch@nvidia.com/
> 
> It's currently applied to nvme-7.1 and not there yet to mainline kernel.

FWIW, the nightly CI runs for nvme-cli with blktests/master and
linux/master are all green except for the above mentioned nvme/005 tcp
case. Thanks everyone for helping out!

https://github.com/linux-nvme/nvme-cli/actions/runs/24816292836

