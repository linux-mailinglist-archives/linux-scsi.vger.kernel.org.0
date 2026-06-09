Return-Path: <linux-scsi+bounces-24579-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id boVtBJhlJ2o4wAIAu9opvQ
	(envelope-from <linux-scsi+bounces-24579-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 03:00:08 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDE565B7FE
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 03:00:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=elJquuNt;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24579-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24579-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2198C300D7BA
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jun 2026 00:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE428C874;
	Tue,  9 Jun 2026 00:59:13 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E20282F2E;
	Tue,  9 Jun 2026 00:59:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966752; cv=none; b=LQ1Teg8puGTM7KJUOxXZt3lfTrmWji882/1dJpFYai8VML6qXmcY1rt5d97z8fdShHJO6JGINAd7EOu6mfZkmHSQnsOWT4zsMZOGffldj0XL9odSqpbTV/olJpd+zeK71Ije9W6GL/Ll6tpUPNac0z4NgfsoW6Zyid/3e+AYFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966752; c=relaxed/simple;
	bh=emQColVb5JpepEtvSSs2I/M5bZIgI2CRo6RNk23HyJU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDugGpRcxw84+Bt6AcAgPpXN2gnlgIEW0Hb/5IqLdMq0kjoISeUWKQ1LXezKw4wFD9V7Mt6VI48lkf0wmoV7D3LuOqcJIuV4R5tMYA8M7svOB+zkd2PIp5QjRP5s7BqH3ysgDK8PILIuENmobFDTwRF+Nhdu8hZmpf07hZzfFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=elJquuNt; arc=none smtp.client-ip=185.70.43.100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780966740; x=1781225940;
	bh=3P35bW1gmmV3dnEbB9b86VqbPSQKXQsWFLxm1PJz68s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=elJquuNtDwupmaPJfPS/+7pZl9uF+f7LpRBb3Bab6ybJtTcEM6fgXMpyr4l7V+uma
	 5U9lM4Iff/V+GJGA86fluRrSEdypRaMFAUsPdIdvY43CyI38PbAxMweOJHIrbNIFh1
	 gz9duLIa2fXc3G5SeTU0GaAKtgNMCK/3D/w9uYKltuv2r0jg/2ahwZzWZn5DlRiVMl
	 JTQkLRKN4KOThf4lHa2V9ilBw/ELxCKDwsvh3naCa8F1VwtXw2nYzYbsaPGAtNPnNc
	 f8MeW4y0CwGSC5RWgq+7PqjhO4WSEjH8prihroHuogQGd2jh2wySxhGqe7IePR196d
	 dpnRfck2Gj7Qg==
Date: Tue, 09 Jun 2026 00:58:57 +0000
To: "Martin K . Petersen" <martin.petersen@oracle.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Mike Christie <michael.christie@oracle.com>, Maurizio Lombardi <mlombard@redhat.com>, John Garry <john.g.garry@oracle.com>, David Disseldorp <ddiss@suse.de>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: target: copy iSCSI ISID before unmapping the PR OUT buffer
Message-ID: <20260609005851.17484-1-hexlabsecurity@proton.me>
In-Reply-To: <43ed2b6f-5b84-4a3d-b185-4275c9bb69f0@oracle.com>
References: <20260606015359.181724-1-hexlabsecurity@proton.me> <43ed2b6f-5b84-4a3d-b185-4275c9bb69f0@oracle.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 96bf9b84640b6bfe34f2997174b9be027c812ed3
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24579-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:michael.christie@oracle.com,m:mlombard@redhat.com,m:john.g.garry@oracle.com,m:ddiss@suse.de,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,proton.me:dkim,proton.me:mid,proton.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EDE565B7FE

On 06/06/2026, John Garry wrote:
> It's not so nice to re-assign the pointer like this or have it even
> pointing at a local array.
>
> Is it really messy for iscsi_parse_pr_out_transport_id() to do something
> like kstrdup and then the caller has the job of later free'ing it?

You are right -- v2 moves the copy into iscsi_parse_pr_out_transport_id()
so the parser returns an owned allocation via *port_nexus_ptr and callers
kfree() it.

We use kzalloc(PR_REG_ISID_LEN) + strscpy_pad() rather than plain kstrdup()
because __core_scsi3_do_alloc_registration() reads the ISID with a fixed
8-byte get_unaligned_be64(isid).  A malformed TransportID with an ISID
shorter than 8 characters would give a kstrdup allocation smaller than 8
bytes, turning that read into a heap out-of-bounds.  kzalloc zero-fills the
full PR_REG_ISID_LEN (16) bytes so the be64 read is always in-bounds and
returns a deterministic value; strscpy_pad() copies the lowercased ISID and
NUL-fills the tail.

core_scsi3_decode_spec_i_port() also receives the allocated pointer and
needs to kfree() it.  The inner list_for_each_entry iterates over multiple
TPGs per TransportID, calling the parser at each; we kfree(iport_ptr) befor=
e
the reset at the top of each inner-loop iteration so a failed ACL match tha=
t
triggers a continue does not leak the previous parse's allocation.
kfree(iport_ptr) is also added at out_unmap: (error exit) and before
return 0 (success exit).

[PATCH v2] follows.


