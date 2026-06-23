Return-Path: <linux-scsi+bounces-25157-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jDciG+rnOWqzywcAu9opvQ
	(envelope-from <linux-scsi+bounces-25157-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:56:58 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 186E26B3727
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:56:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jugG+rR3;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25157-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25157-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BC23050A52
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47144379993;
	Tue, 23 Jun 2026 01:51:20 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DE36EAB8
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 01:51:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179480; cv=none; b=Y2JKz49TQriCxuxS+Fu4SXZ+GSh/AWCyq5wzEZOnWyH2yeEA6i3Ccy9WRdyoC3urY113uzbZH6H8Xgt8hcx2BZBicVx0VsLHxe58+sLYyMDBPbPCAFzS5MsYQI4w8auz4qJZnjt3HZMsCU+2uVWSI5rPXrDeZ7joEM1yXJ74+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179480; c=relaxed/simple;
	bh=j/CTeDwY7LSKnXYZzzwVtwGB31GH4k7c+Y9YJalEU8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bK8o/CkZqi+MAA/TG2Ymk/5Zz9XpVNqGAsbaAfLkF1D5x3wM7OrAeN6Hg9/g1XqXF77syE02bTVbnYEkSVs5EgAjZgjNR9b6xui0OQE+hHr8odZ1JpjRlVN7alJgN9iiGBfROB0lsQqVPzMqZjTtM1TOZdP3lm/Y46U+GVYQbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jugG+rR3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B691F000E9;
	Tue, 23 Jun 2026 01:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179479;
	bh=E3FhlBmONlciTMC1sO0A6jp+t8o7ud3levL7gA6kHOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jugG+rR3OFj3Th1iVjX77DYs6WxT71f4+IfUzbn+DQP2OH2T6giyq9ZqDA0faCmAN
	 rvdcpgeoXBrxRvo9ohRQ5urrRQgcxQ26bXuIAmWnV1yaceJ9gu4onazAc5nrtUrUSg
	 Vw3FXxuq0B6RIfyrmEwUes+k2ZisuxoKFn0vjZjzouw+/Lunp/Q0i47AASCnCYnHeo
	 nAFWXSOaD/Z1xeruIZVtufAuRm8ewyJGm9CVvzfA2wRXdjW5nD5nnJGAJ1Mp2JkY/X
	 qHtyPzQJbNUULpJv/R0UHTDF6TL/R/WbgpqKiFQAs7QVVeTbVhZNUGxSnvm7pA7j6q
	 OhzlNXkuR41vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/29] ibmvfc: extend ibmvfc_debug visibility to
 ibmvfc-nvme.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tyrel Datwyler" <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623013035.3436640-23-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <20260623013035.3436640-23-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:51:18 +0000
Message-Id: <20260623015118.E8B691F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25157-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tyreld@linux.ibm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 186E26B3727

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Core driver debug variable declared in protocol-specific header
--

commit 719e4b33f0990bbcd15f1244a436cf69d36807ef
Author: Tyrel Datwyler <tyreld@linux.ibm.com>

ibmvfc: extend ibmvfc_debug visibility to ibmvfc-nvme.h

Export ibmvfc_debug so the NVMe support code can use the
existing ibmvfc_dbg logging macro.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.h b/drivers/scsi/ibmvscsi/=
ibmvfc-nvme.h
> index 0465e87198817..3aa2857887950 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.h
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.h
> @@ -22,6 +22,8 @@
>  #define IBMVFC_MAX_NVME_QUEUES	16
>  #define IBMVFC_NVME_CHANNELS	8
> =20
> +extern unsigned int ibmvfc_debug;
> +

[Severity: Low]
This isn't a bug, but should this core driver debug variable be declared in
the core ibmvfc.h header rather than this protocol-specific header?

Declaring it here creates a confusing dependency where the core header reli=
es
on a protocol header for its macro dependencies.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623013035.3436=
640-1-tyreld@linux.ibm.com?part=3D22

