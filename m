Return-Path: <linux-scsi+bounces-24687-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3uAAg5JKmpXlwMAu9opvQ
	(envelope-from <linux-scsi+bounces-24687-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 07:35:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD366EA3C
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 07:35:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ln2lwGn8;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24687-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24687-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCA83049FE8
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 05:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECFB33E37C;
	Thu, 11 Jun 2026 05:24:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF45356758;
	Thu, 11 Jun 2026 05:24:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155483; cv=none; b=MMy4qknuc3vf2o/AsNuytpujO0+q+8MbB3eKE9W4XimTmlspsqSqQzVcG18CVaZUlFSh3NESJ8C3SIwjSohQT+EzPF/JfecRyZXi34Y68Epf0MUvjZbSGnmKqRJhWAJaS5Q7rj8q1IEsnypBW4SxALM6RF7r+XK5AouDULA/R84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155483; c=relaxed/simple;
	bh=2HfYUlEVwvi11DexqkZ9u8rB8kDyMXVmY5S5bkIGQHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D4rcCEKfFvFP5niFEIxkmTQ+z1q5LMvzna/LF+4bX5O+etcXtvlRvLwiS/tbi65LjNNichNhyP4fpLWav/PRt6jhftvPOP2IpoRx1dIYSzdc5x3OlxayoIa8SqRol0W5u6LfqZq602n8f04/RteaRJjGU+3/iapG/P4d/UyFL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln2lwGn8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7161F00893;
	Thu, 11 Jun 2026 05:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781155478;
	bh=Buhkmxb3ZNMrPMUtF32QejzkZs38v+9romIh8ssMWMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ln2lwGn8ebV0wVeZZc38175s7vjKk61wJ6PsM0anQfDAdcqF4wzs+q3AUa/Z3YEdb
	 jCDteE19K5SqF7r6BhdWxW2b4E2cATzp2hGdZkJIt21MCCBBvsbmasRnW05XbFNtFi
	 +c31oybkunZnbFB++eAR7q5278EpUqNvchUqVkAU51ae6EJ2KJSm3iQmmp32KGELOg
	 /TUhPob0t9IxoS5PatV60dK7RTpQP6x2mP9M9Q7Hj086qahgUBdgfVWRpPV/uXOTVK
	 /DnhE7wnzNaEKwLcP5oEn4y/DIsORv7zW+uo3ikQ5AAxMoi936lYeclRT8a4TzGogJ
	 s1akCT6Z+aIeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] zfcp: Trace plogi and prli within open port
 response as payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nihar Panda" <niharp@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260611050550.796772-4-niharp@linux.ibm.com>
References: <20260611050550.796772-4-niharp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 05:24:37 +0000
Message-Id: <20260611052438.0C7161F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24687-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:niharp@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FAD366EA3C

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting out-of-bounds read of kernel memory due to unvalidated=
 `log_start` and `log_length` fields from the FCP adapter response.
--

commit 9e601763da63b3c0c65512bab46a16c131e45614
Author: Steffen Maier <maier@linux.ibm.com>

zfcp: Trace plogi and prli within open port response as payload

This commit updates the zfcp debug trace to include PLOGI and PRLI content
from open port responses back-to-back in the payload trace record. It also
introduces a level argument to zfcp_dbf_pl_write() to control trace
verbosity and avoid flooding the log.

> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index 89b859176b8bd..4217b74baa380 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c

[ ... ]

> @@ -96,7 +101,27 @@ void zfcp_dbf_hba_fsf_res(char *tag, int level, struc=
t zfcp_fsf_req *req)
> =20
>  	rec->pl_len =3D q_head->log_length;
>  	zfcp_dbf_pl_write(dbf, (char *)q_pref + q_head->log_start,
> -			  rec->pl_len, "fsf_res", req->req_id);
> +			  rec->pl_len, "fsf_res", req->req_id,
> +			  ZFCP_DBF_PAY_LEVEL);

[Severity: High]
This is a pre-existing issue, but I noticed it while looking at this
modified call to zfcp_dbf_pl_write().

Are q_head->log_start and q_head->log_length validated before being used
to compute the source pointer and length here?

Since these fields are retrieved from the FCP adapter's response header,
could a malfunctioning or malicious adapter return arbitrarily large
values? If log_start + log_length exceeds the bounds of the req->qtcb
allocation, could this result in an out-of-bounds read of kernel memory
when copying into the trace buffer?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611050550.7967=
72-1-niharp@linux.ibm.com?part=3D2

