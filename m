Return-Path: <linux-scsi+bounces-24721-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k+I6OGa0Kmo/vgMAu9opvQ
	(envelope-from <linux-scsi+bounces-24721-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 15:13:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CB967241C
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 15:13:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G9cNfXkO;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24721-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24721-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52B9A3020D71
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A695E406271;
	Thu, 11 Jun 2026 13:10:25 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136323FE344
	for <linux-scsi@vger.kernel.org>; Thu, 11 Jun 2026 13:10:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183425; cv=none; b=G57WVodmtK3mFv0fqG0JcUAi1n7SrxMW5RCk/H6LmR3qpon+p63ePo5pTHv7owTCJa8gBoCNnnqIxWv73dEZ7WaWjA0myJflADAXevZwOU2UBf9lkFnBOUQEAtIE4cNUPQyamoJ2uWyNBmNgChbUm/LSoA/qmkz8Q6ceZ3k3bvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183425; c=relaxed/simple;
	bh=xHvu1mdXXnwMxnf5gA7SZvE9OE1Hv/gA9tdsCfOjOO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g5wAeWCz8Tqu+7JXlnRlR9wLWIKqMkGzACbIavoiPE3L30iiE0OqwuD1ZlJYlN6/Rg/OOV9SnlAwpu3jre0D2lXQNhXlnnmccWkv+B/f6uQbwmLIIE9krFspA9HvFWwj8ZxX6Nmq6BUuVx1N0ly1Q1I2i36noUg6qegxgpcWemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9cNfXkO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FA21F00898;
	Thu, 11 Jun 2026 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781183423;
	bh=tAFprRORbEcnMxadTMRZwoISAVsy0dhYROV5KaomgsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9cNfXkOLPAz2f5l3MOC6UlB9Es9csx1dj5y3bjNC91xliTG0HXMQo1tf+E5+08gS
	 eqiuTAeM5xawSvU0VoUrbw+fl0awqsomyBxgwO4ZMWQ8Q5GgsquWjOcsK9jY3mFqG9
	 yn2b3R5OGxTqyceKGM/1kWDlLEF1WEGZXsvefHcCke+cJ6YN9h7gfV+bDTlxuSKBQb
	 XukjY4ZRqvHF5EFMX8eVPme9rTgKb01drZxMWutH8ZyRd6rg0k2dXBguomqS3joTwR
	 Sady7wELeU2u2u4Oygh6MwPof6B/trLxCH+qz6lc268NXozbePa7mJPwaINPi+2Cgy
	 oMO6XYr+jsLag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: bfa: reduce kernel stack usage in
 bfa_fcs_lport_fdmi_build_portattr_block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260611125601.3385418-1-arnd@kernel.org>
References: <20260611125601.3385418-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 13:10:22 +0000
Message-Id: <20260611131023.41FA21F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-24721-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32CB967241C

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled error path leaves the state machine stalled, leading to =
a leaked fcxp structure and a list_del() crash upon port offline.
--

commit 61029f85cbc6b31d41ea7d38cd2303b673cd3f35
Author: Arnd Bergmann <arnd@arndb.de>

scsi: bfa: reduce kernel stack usage in bfa_fcs_lport_fdmi_build_portattr_b=
lock

bfa_fcs_fdmi_get_portattr() gets inlined into multiple places and has two
fairly large variables on the stack, to the point of causing a warning
in some randconfig builds. Mark the inner function as noinline_for_stack
to keep it separate from the other variables.

> diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_=
lport.c
> index 2df399c537c13..8c9d423129c07 100644
> --- a/drivers/scsi/bfa/bfa_fcs_lport.c
> +++ b/drivers/scsi/bfa/bfa_fcs_lport.c
> @@ -2627,7 +2627,7 @@ bfa_fcs_fdmi_get_hbaattr(struct bfa_fcs_lport_fdmi_=
s *fdmi,
> =20
>  }
> =20
> -static void
> +static noinline_for_stack void
>  bfa_fcs_fdmi_get_portattr(struct bfa_fcs_lport_fdmi_s *fdmi,
>  			  struct bfa_fcs_fdmi_port_attr_s *port_attr)
>  {

[Severity: High]
This is a pre-existing issue, but I have a question about the error path in
bfa_fcs_lport_fdmi_send_rhba() when it calls bfa_fcs_lport_fdmi_build_rhba_=
pyld():

drivers/scsi/bfa/bfa_fcs_lport.c:bfa_fcs_lport_fdmi_send_rhba() {
    ...
	attr_len =3D
		bfa_fcs_lport_fdmi_build_rhba_pyld(fdmi,
					  (u8 *) ((struct ct_hdr_s *) pyld
						       + 1));
	if (attr_len < 0)
		return;
    ...
}

If this returns early due to a negative error code, does it leak the
successfully allocated fcxp structure?

It appears that returning early here fails to free the fcxp structure and d=
oes
not advance the state machine, leaving it stalled in the
bfa_fcs_lport_fdmi_sm_sending_rhba state.

If a port offline event subsequently occurs, the state machine blindly canc=
els
the allocation:

drivers/scsi/bfa/bfa_fcs_lport.c:bfa_fcs_lport_fdmi_sm_sending_rhba() {
    ...
	case FDMISM_EVENT_PORT_OFFLINE:
		bfa_sm_set_state(fdmi, bfa_fcs_lport_fdmi_sm_offline);
		bfa_fcxp_walloc_cancel(BFA_FCS_GET_HAL_FROM_PORT(port),
					   &fdmi->fcxp_wqe);
		break;
    ...
}

Since fcxp was originally successfully allocated, the wait queue entry
(fdmi->fcxp_wqe.qe) was never linked onto the wait list. Can calling
bfa_fcxp_walloc_cancel() on this unqueued and uninitialized element trigger=
 a
list_del() crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611125601.3385=
418-1-arnd@kernel.org?part=3D1

