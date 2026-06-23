Return-Path: <linux-scsi+bounces-25163-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t1LYNT3nOWqVywcAu9opvQ
	(envelope-from <linux-scsi+bounces-25163-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:54:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183016B36BF
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:54:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=amrM416C;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25163-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25163-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CEBC300E251
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103337AA9A;
	Tue, 23 Jun 2026 01:54:03 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF79379993
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 01:54:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179643; cv=none; b=UVpUqhF/GPx4ZY6aqpbpjS7g4/oWBSNDiyBGfTAkTXGOzmclpV8RSKMCFXnxl6vl7+Kso9RI3cPUJbaBZ63dxmvkKbSUi7nPKfubNeG+hYSny+Z/ixysIymxan6VnCoSvzeCFndSEMYPVonxdByMkTbQXlxP0BcUe4bMqVe2Coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179643; c=relaxed/simple;
	bh=Elf91vwvTieqqqfeZmAwwZwg3cDXo08WwGBdOerWa7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uaZvWSiGayPrE+jH8Ug17zqRII96bugVtf0MX6vgRihhz1mf37ZUNagirgrcRlg8SObtic7SUfxReV4i8MUw0K31h70gB+xmCcggnCWlcGQvasinLEU472T9HgVEiR3CItwkbd5NRFH6fdn6OUsCKLeCvChW8pteR8SNO9hmY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amrM416C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D360A1F000E9;
	Tue, 23 Jun 2026 01:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179641;
	bh=F490ByG9qhMlcT0ygJ7tXsaFp9oAzyktdMte8+W6Rh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=amrM416Cf10/XZp/sqtjQk/xDOY80Zarhw+5+Wy87gog6aVLtCtM3dijUuTKjrSTY
	 r+qgLJ7UvgHv1PmFg++qaSQGyVhE3aiyic0rf5HB2XRnjS9IkgKcR0oLjeTM2RK4VM
	 wHzfwD4nh01BPEV3mWpbiPyHvd0jseBm19uUpfcw/m8lCY+y1vwNdDe5q3sF/sf2Lc
	 nbuAQ3qsEJrZk2aInA7wVj70FoCAAhq7yZVdNcyAxYyOS6IxxIILCZE8HvZfwGGa+R
	 2uR1H/3IKkIHkvnxoRftxJToHWcMGelo34EAtAaze4B51nnoUqzax6qbuspB9Gz3gh
	 ZkNQOgbyh6Tew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/29] ibmvfc: add NVMe/FC protocol interface
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tyrel Datwyler" <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623013035.3436640-3-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <20260623013035.3436640-3-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:54:01 +0000
Message-Id: <20260623015401.D360A1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25163-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 183016B36BF

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional size expansion of `struct ibmvfc_implicit_logout` br=
eaks backwards compatibility with older VIOS versions.
--

commit c4f31afebbe28cbb64ba03689b7e7ed327cb6d9e
Author: Tyrel Datwyler <tyreld@linux.ibm.com>

ibmvfc: add NVMe/FC protocol interface definitions

This commit adds the protocol definitions for client-VIOS interface updates
needed to support NVMe/FC over the ibmvfc NPIV transport. It extends the
ibmvfc interface with NVMe/FC-specific capabilities, queue definitions,
and command layout support.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvf=
c.h
> index 0e259e9d2e9bb..f8a2bf92da410 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.h
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.h

[ ... ]

> @@ -377,20 +419,27 @@ struct ibmvfc_query_tgt {
>  struct ibmvfc_implicit_logout {
>  	struct ibmvfc_mad_common common;
>  	__be64 old_scsi_id;
> -	__be64 reserved[2];
> +	__be64 reserved[8];
> +	__be64 target_wwpn;
>  } __packed __aligned(8);

[Severity: High]
Will this unconditional size expansion break backwards compatibility with o=
lder
Virtual I/O Server (VIOS) firmware?

Since the driver calculates the MAD length dynamically using sizeof():

drivers/scsi/ibmvscsi/ibmvfc.c:__ibmvfc_tgt_get_implicit_logout_evt() {
    ...
    mad->common.length =3D cpu_to_be16(sizeof(*mad));
    ...
}

This changes the length sent for version 1 IBMVFC_IMPLICIT_LOGOUT operations
from 40 bytes to 96 bytes. Could older VIOS versions that strictly validate
MAD lengths against the version 1 specification reject this payload, breaki=
ng
target teardown and error recovery?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623013035.3436=
640-1-tyreld@linux.ibm.com?part=3D2

