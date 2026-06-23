Return-Path: <linux-scsi+bounces-25152-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P05vMJrmOWp4ywcAu9opvQ
	(envelope-from <linux-scsi+bounces-25152-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:51:22 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B97036B3678
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:51:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RIiLxOTb;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25152-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25152-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E499300B29F
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5936729C;
	Tue, 23 Jun 2026 01:49:50 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAF1A4F3C
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 01:49:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179389; cv=none; b=sSxDTfM5ZdDU18LbBRJEKTCI0Y8wa3D4f09bEv/gtbN916y/5NXMlHOsXFUOw3xT17oMrUL8y2+axon/3EXsJKxnBCLRHmvLCp4kgEyKuRxqS0TAovL/IGfIQuRk9OozDIpEwdValXvBmteOdUkiZOvDyTGyOOkxrxS0KJWmR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179389; c=relaxed/simple;
	bh=ttKpG3KqguLM7w2wCEMH0N4tVxyEKWFRQccquMvTAIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P9JRc9cKPXkxvqCeJrS8NsM/SND2Hgft1W6IYMF7EAhoYODM1vc7yji76LVwA5hR1xOQrUm7y4GWsKBtgVpc8Leg2tcHfeT//EcVybElRefzzCrm/9AFBC/Vs8IcURi3SxkYTnvRU1BamwwQ3xbuRBKYu5n34tAtCbnJ2ibIa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIiLxOTb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0E11F000E9;
	Tue, 23 Jun 2026 01:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179388;
	bh=b8pv/MxNv8vMvQscPUIl76o/Vv3PCvYyrvlgJhuyATo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIiLxOTbgRkzjSQr7AsypRq3SFx8kCTd5vZ3aDSoOJL/A3YblOYnFVl7EXkvNTXF7
	 NIDmBhhahMXIPkSV+ea8TgUGJCdwdId8xxlFIGYLY1GyIz2DTNBTOdDIMdkDAchAUc
	 GmQG6sEG22dnvsvA6bX7+9Pfe+n2XLBAnINwDx4yjJkglkveqKiqjvlAOqZKxnlgN/
	 OggdPg1Sl/fvL9orrykvEIHealHt6nz7774tusskrsus8+ZBh8VMEg4F4u02Qu3qeM
	 FmHNu+wr3z+e4dkhSbvn5cYgL/oEcmKarnaQB5tRIrB5hBPtD/Bwj1xKajdfBYfVvI
	 XkGmqzpj4YX3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/29] ibmvfc: add NVMe/FC Implicit Logout and Move
 Login support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tyrel Datwyler" <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623013035.3436640-13-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <20260623013035.3436640-13-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:49:47 +0000
Message-Id: <20260623014947.BE0E11F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25152-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B97036B3678

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL pointer check on the event allocated for implicit log=
out in `ibmvfc_tgt_implicit_logout_and_del()`, leading to a crash in `ibmvf=
c_send_event()`.
--

commit d7f6f97d0c832e12c02c910b6675c0a3be2fb197
Author: Tyrel Datwyler <tyreld@linux.ibm.com>

ibmvfc: add NVMe/FC Implicit Logout and Move Login support

This patch adds protocol-specific handling for implicit logout and
move-login operations on NVMe/FC targets. It extends the existing target
relogin and migration flows by selecting NVMe/FC-specific opcodes and
updating the associated logging.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/=
ibmvfc-core.c
> index 53480d150042e..3e3d77e0d5172 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
[ ... ]
> @@ -4456,7 +4461,7 @@ static void ibmvfc_tgt_implicit_logout_and_del(stru=
ct ibmvfc_target *tgt)
>  		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
>  		kref_put(&tgt->kref, ibmvfc_release_tgt);
>  	} else
> -		tgt_dbg(tgt, "Sent Implicit Logout\n");
> +		tgt_dbg(tgt, "%s Sent Implicit Logout\n", proto_type[tgt->protocol]);
>  }

[Severity: High]
This is a pre-existing issue, but does ibmvfc_tgt_implicit_logout_and_del()
need to check if evt is NULL before calling ibmvfc_send_event()?

If the reserved event pool is exhausted, __ibmvfc_tgt_get_implicit_logout_e=
vt()
can return NULL:

ibmvfc-core.c:__ibmvfc_tgt_get_implicit_logout_evt() {
        ...
        evt =3D ibmvfc_get_reserved_event(&vhost->crq);
        if (!evt)
                return NULL;
        ...
}

Unlike other callers such as ibmvfc_tgt_implicit_logout(), this function
lacks a NULL check and passes the evt pointer directly to ibmvfc_send_event=
(),
which unconditionally dereferences it:

ibmvfc-core.c:ibmvfc_send_event() {
        __be64 *crq_as_u64 =3D (__be64 *) &evt->crq;
        ...
}

Could this lead to a NULL pointer dereference under heavy queue pressure
or concurrent target teardowns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623013035.3436=
640-1-tyreld@linux.ibm.com?part=3D12

