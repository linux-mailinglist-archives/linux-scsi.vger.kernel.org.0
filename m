Return-Path: <linux-scsi+bounces-25049-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t9KvMIbcMmoV6QUAu9opvQ
	(envelope-from <linux-scsi+bounces-25049-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2026 19:42:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C191D69BC32
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2026 19:42:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arkamax.eu header.s=mail1 header.b="bXoC4Q/+";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25049-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25049-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=arkamax.eu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DA4C3017F31
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2026 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B273630B2;
	Wed, 17 Jun 2026 17:42:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A1374E71
	for <linux-scsi@vger.kernel.org>; Wed, 17 Jun 2026 17:42:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718130; cv=none; b=SWqgSEcHLRuboXlfR3ALhlVHR2rbh6JvHspoLwVmww7pYFkt6GzL3KZ0BqXvSQtfklAKpHXq5JPH5697a6X2nzBvKrR4zmTKWcxsdp6iBsqAviixYMHl3RnxxpDGyqwxtfkGc0c31+hDSoCIoZttNOl4un2hu9oe7QzdBd3XWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718130; c=relaxed/simple;
	bh=kvFAel3hT2aCpodG8ZLF82cEweXUConelsw4C01uKcs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hAtDHxgL0GVWT3qK5Ke7qLrfG5GVUcKXtlWn0IgG7pbcBmkeP48BQLGGAqF++ktHD5V86H4Ufnvt+avVx/blVZbi0i1KnWO8YzUaQY6EBLwnqivdAEzbHdUr9nFWDYrpskaBXTVtzpHETYGzZ0EBQpFi0IfyJZ20xl8So2UbHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu; spf=pass smtp.mailfrom=arkamax.eu; dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.b=bXoC4Q/+; arc=none smtp.client-ip=128.116.240.228
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=kvFAel3hT2aCpo
	dG8ZLF82cEweXUConelsw4C01uKcs=; h=in-reply-to:references:cc:to:from:
	subject:date; d=arkamax.eu; b=bXoC4Q/+g8Q3M+9xsufKiMepSkRrdEDbRettbEIo
	oajAncUGQUldjtbTqy8AhgaD+HzaJ8QAADRQLRGqczE7okLXDvig4Lz48/IDg02y89IFTn
	aTC1piz2s2ajSiFnh3J6Uh04E6UkdMVY3aAY/f0eViV1SAUmSuFSkyI51WBtjCEcArizU6
	Indz+Zmt8umniFjDZwXlzbVabHvL5eQl/dIbD35xX5+nzG7/wTIUg6yIJOK6m779E0ggwU
	MTPmbT21rydTl7O6YryJVEvIA8szKEy2Cw0XS1TxVmkemKpOysUEmNO4nEug2IAp4bjEMD
	32RESfS9GtpbnrzxVpIVAQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 52c4389b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 19:41:58 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 19:41:58 +0200
Message-Id: <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Hannes Reinecke" <hare@suse.de>
Cc: "John Meneghini" <jmeneghi@redhat.com>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>, "Maurizio Lombardi" <mlombard@redhat.com>,
 <hch@lst.de>, <chaitanyak@nvidia.com>, <bvanassche@acm.org>,
 <linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <James.Bottomley@hansenpartnership.com>, <emilne@redhat.com>,
 <bgurney@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp> <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp>
 <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp>
In-Reply-To: <aaXE4s3AT45UIAN8@kbusch-mbp>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arkamax.eu,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[arkamax.eu:s=mail1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kbusch@kernel.org,m:hare@suse.de,m:jmeneghi@redhat.com,m:mlombard@arkamax.eu,m:mlombard@redhat.com,m:hch@lst.de,m:chaitanyak@nvidia.com,m:bvanassche@acm.org,m:linux-scsi@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:James.Bottomley@hansenpartnership.com,m:emilne@redhat.com,m:bgurney@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mlombard@arkamax.eu,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-25049-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlombard@arkamax.eu,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[arkamax.eu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,arkamax.eu:dkim,arkamax.eu:mid,arkamax.eu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C191D69BC32

Hello Keith,

On Mon Mar 2, 2026 at 6:12 PM CET, Keith Busch wrote:
> On Mon, Mar 02, 2026 at 08:16:19AM +0100, Hannes Reinecke wrote:
>> I really would like to go with the nsid based solution from Keith.
>> That would avoid quite some cumbersome code here.
>
> I've seen various documentation that assumes the current naming
> indicates the nsid, so the scheme follows at least some people's
> expectations. I don't know if we can make everyone happy here, though.
> :(
>
> I've fixed up most of the multipath races that get us closer to allowing
> nsid suffix, but there's one left: nvme_remove_head is called outside
> the subsys lock after detaching the head from the subsystem list. That
> could cause a subsequent add event to call nvme_alloc_ns() before the
> mpath side has completed del_gendisk() for the old nsid.

Did you manage to find a solution for this race?
I just wanted to check whether you had any patches ready for testing since
this discussion.

Thanks,
Maurizio

