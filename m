Return-Path: <linux-scsi+bounces-26195-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tdBGIj0+Vmps2AAAu9opvQ
	(envelope-from <linux-scsi+bounces-26195-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 15:48:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A90755568
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 15:48:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26195-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26195-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CC523028B52
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7CB18FC80;
	Tue, 14 Jul 2026 13:46:07 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2554477E28;
	Tue, 14 Jul 2026 13:46:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036767; cv=none; b=PwTmMj2HtGNMPwBL6LkpZC4cSic6LjC7wRooe58XQbj/BI0dV5Xv0NvxMBnc8vbNL31lwp3FhHpnMwFPDfFhVYzzctFRcM+iWMfq1MXsg57LsnYvRCjhpXt2uYHww8HFc/1tRAT+9GiOR6sxVO+gAnRxt0jJ2j6lcVJe5RNYFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036767; c=relaxed/simple;
	bh=iQ66h0CSnaeDJY+5S4c4RU6btkxvwUiep2IzGUB8V3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0Hsd/EfKWIrIQP1j6nU3N9XPFBW5aYB1yXUf/4sKKGYJHJ6WfaqAEl53XWvAY9ThgHlGacR7gb3co89eKbZv7LuTLqIhFqHmBbrUPU6Lixkd/vGc0rqN5rdYRqGZhLVf2rqOsGz6Pt/Jiucj7F7WqCu+XL5sgotde+tjfSiYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D70168B05; Tue, 14 Jul 2026 15:45:59 +0200 (CEST)
Date: Tue, 14 Jul 2026 15:45:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] block: use integrity interval instead of sector
 as seed
Message-ID: <20260714134558.GA714@lst.de>
References: <20260627054220.2174166-1-csander@purestorage.com> <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:csander@purestorage.com,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:anuj20.g@samsung.com,m:linux-block@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-26195-lists,linux-scsi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:from_mime,lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06A90755568

On Sun, Jul 12, 2026 at 07:09:01PM -0400, Martin K. Petersen wrote:
> 
> Caleb,
> 
> > The block integrity layer currently sets the integrity seed (initial
> > reference tag) in units of 512-byte sectors.
> 
> ... because that is the fundamental addressing unit in the block layer.
> 
> > However, Type 1 and Type 2 ref tags are actually in units of integrity
> > intervals.
> 
> They are not in units of anything until they reach their final
> protection envelope.

If that is the assumption we need to clearly specify that somewhere,
and also explain why that is a good idea.

Most users of bip_set_seed seem to assume it is in integrity interval
units, see commits:

e4dc9a4c31fe10d1751c542702afc85be8a5c56a
c6e3f13398123a008cd2ee28f93510b113a32791
3d8b5a22d40435b4a7e58f06ae2cd3506b222898

so we'll need to find out a way to come up with interfaces that
just do the right thing.

> 
> > On devices with integrity interval size > 512 bytes, ref tags are
> > seeded incorrectly.
> 
> The bip seed is whatever the caller decides it should be. The integrity
> interval size is irrelevant. As is the destination LBA.
> 
> > But REQ_OP_ZONE_APPEND operations don't have their ref tags remapped,
> > so the ref tags using units of sectors will be stored to the device.
> 
> Then there's a problem with how we handle REQ_OP_ZONE_APPEND. For NVMe,
> the PIREMAP flag should address this issue by remapping the written ref
> tags based on their ultimate destination LBA.

PIREMAP expects the ref tag to be in logical block sized units.

> Fundamentally, you should be able to set the bip seed for any READ or
> WRITE bio to 42, regardless of logical block size, and have it work. If
> it doesn't, then that's a bug.
> 
> The fact that the block layer happens to know the start LBA or ZSLBA
> does not mean that callers above the block layer have access to the same
> information. Changing the block layer's integrity handling semantics is
> not the correct approach. Everything above the block layer depends on
> the existing, format-agnostic, semantics.

We have 4 callers above the block layer, and all of them know that the
see is the LBA.  For type 1 that is enforced by hardware, and all the
Linux code is basically based around a type 1 model, which is emulate
don type 2 PI and type 3 PI using the available means.


