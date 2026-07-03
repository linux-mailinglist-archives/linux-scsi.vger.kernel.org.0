Return-Path: <linux-scsi+bounces-25547-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gRFtD3iWR2q+bgAAu9opvQ
	(envelope-from <linux-scsi+bounces-25547-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:01:12 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F097018DC
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:01:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KObgD5qS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25547-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25547-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BF8230FB795
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779973D6CA0;
	Fri,  3 Jul 2026 10:43:13 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832D3D6488
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 10:43:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075393; cv=none; b=bm98eTcu5VQqeAO8/elrUWjeD92nrEQfMuXkflMrKMhPief7n9/gWA1+i642MGEhXvMY9GxtX75Zi3WzVgmA+KO48TEZF0XV3cbuDHEUucMwB4Cm7Jao4RwdxwF+B5KV1yTNRDm+5VCwelY/IZR54wYOGM19sSepXPklhGRj/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075393; c=relaxed/simple;
	bh=E8OZvXfvhG/Ka1jc41xMOpU1C0GWXDCIjET7DK2fTU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CzwywltDLOIaTSphHTRr5o3Oqbf9HB0/8JkvxtACRutTp4h1iJQVyVTJ/YYG4NsBBiht9rS2Oi80Q6iO/HghA3kmydwxgIy8irM13D1se2RbTvKd+InY8uo2sclGnakit9DvxEbTqjNBtAZPCx0n0ixKXTElc3D3g+B/Ve0xmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KObgD5qS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18771F00A3D;
	Fri,  3 Jul 2026 10:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783075391;
	bh=DjLJbN0MGJfQNtVgAnyXQ6U3HSggWaRCMn93Y8QNrJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KObgD5qScCXztQ2gWZwJysX92H9cX+foAckqaX+iSOThhk4W+5yTomwLmi2QNfTro
	 Z8WaiRkd3q6DPp8TvpgS2op8H9uTlsDCEAXMJT/8IQkUIoCceiapvietrubIWhVX3D
	 IcOVtRQaN/tY8TPEC6BQJjg8coqtZCd35KVFAtXAyor8K8pWmaDK4qUAPhFgF2WJ22
	 2sOi6oBMxShad/lanz0XH0fLqOfh1F7Vl/biT8M1epCmT2lXDOSIu/sKAMUzDkw4o6
	 Nll/Jd+lslFTzUNvm8ydR41zai2fzq91FKggS5QiU3N25rryqVQJ88EwwVZqmaydbv
	 /TXo6ad5Z963Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/13] libmultipath: Add initial framework
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703102918.3723667-2-john.g.garry@oracle.com>
References: <20260703102918.3723667-1-john.g.garry@oracle.com>
 <20260703102918.3723667-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:43:10 +0000
Message-Id: <20260703104311.C18771F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25547-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36F097018DC

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A race condition between mpath_put_head() and mpath_head_uninit() =
leads to a use-after-free vulnerability when accessing mpath_head for clean=
up.
--

commit 594f063adb51503b6e7af6741526b8d738fee5ba
Author: John Garry <john.g.garry@oracle.com>

libmultipath: Add initial framework

This commit adds the initial framework for libmultipath to support path
management, path selection, and failover handling for multipath-capable
block drivers. It introduces the mpath_head structure to manage available
paths and the multipath gendisk.

> diff --git a/lib/multipath.c b/lib/multipath.c
> new file mode 100644
> index 0000000000000..009d4bb875c6f
> --- /dev/null
> +++ b/lib/multipath.c

[ ... ]

> +void mpath_put_head(struct mpath_head *mpath_head)
> +{
> +	refcount_t *refcount =3D &mpath_head->refcount;
> +
> +	if (refcount_dec_and_test(refcount)) {

[Severity: High]
Could this introduce a use-after-free regression on the mpath_head structur=
e?

If a teardown thread calls mpath_head_uninit() concurrently, it blocks in
wait_var_event() waiting for the refcount to drop to 0.

Once refcount_dec_and_test() drops the refcount to 0 here, the condition
!refcount_read(refcount) in mpath_head_uninit() can evaluate to true
immediately. The uninit thread could then wake up, return, and free mpath_h=
ead
before this thread completes mpath_head_cleanup() and wake_up_var().

> +		mpath_head_cleanup(mpath_head);
> +		wake_up_var(refcount);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mpath_put_head);
> +
> +void mpath_head_uninit(struct mpath_head *mpath_head)
> +{
> +	refcount_t *refcount =3D &mpath_head->refcount;
> +
> +	if (refcount_dec_and_test(refcount)) {
> +		mpath_head_cleanup(mpath_head);
> +	} else {
> +		wait_var_event(refcount, !refcount_read(refcount));
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mpath_head_uninit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703102918.3723=
667-1-john.g.garry@oracle.com?part=3D1

