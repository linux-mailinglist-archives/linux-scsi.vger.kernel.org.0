Return-Path: <linux-scsi+bounces-24809-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vxiqNbHeK2rmGgQAu9opvQ
	(envelope-from <linux-scsi+bounces-24809-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:25:53 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B2678AC2
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XL2GY0le;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24809-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24809-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBBC31382DA
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 10:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D18937C91E;
	Fri, 12 Jun 2026 10:25:51 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689953A48E6
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 10:25:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259951; cv=none; b=kOuoOVTQjQDUc9EXujWQxY6cBQP5t+JljmaZ4Lda9QybUpzAsjVFzrlIvafGWJjF9rbMLRZSmYYvZc0doDFJlzjXceSuMnqIAiZp3Igx/424Tdhc4A8yCWoN6vEtEpeSAoQ/6QMlXVeotJZ+a7khpFD0In17h7SJPZW5kcSQZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259951; c=relaxed/simple;
	bh=ZfBevt4ccEb8AkIiHeXNJUUO2rbhflBLXKxr7WjLt+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NajI6upcbq7dTRSApmcNiHicOac8pPF82YcUWQxWYCMN/+/YN0/SBrBrhIFb90Mp2ZFC0HlIAXPPQo9UwjZytk2vq0KYW/Uc4b6Ttk3hG+zoxpomfzMDKoQ8xKf+0eLy+tLm6HyvYjXJaYS9SpgnmIh+qf/vzCsTeOBbaMjg5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL2GY0le; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B552B1F000E9;
	Fri, 12 Jun 2026 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781259948;
	bh=iH20LFf2Gi3WC4mLB5IufzQi8VNVPUBT2SsUhslSPTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XL2GY0leEuNxNzao1RToov2xmzHmhmDvBZ08eQJ4DmCTR1pcNNlzGDgezdphvQR5y
	 UVk30jx///3vovxk5Ev17sf5qXHwkP+AkbOG3BAPHbNOKFJdQYla0IqR0hCpZ4Zsr9
	 PKRsuzMuWsqJWybTp9K9N/bCXuyn+E+6pTh054NJdHuaswswvSnd5HA54UqXX6CVlP
	 pOtpIlXKPOBpsXnFGmFoQGy6NyXYacUyVw00BGExLWM0elhulHduhg/jRy6BZevb2v
	 o5U3Sxw3I6eSN7nCh5rM5LGMbf/mER3cEN+1seCvah469aHASzky6euVcU+As5ZQya
	 /bUvLTMSr+/Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/60] scsi: qla2xxx: Extend execute_fw mailbox to
 include 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260612095333.1666592-18-njavali@marvell.com>
References: <20260612095333.1666592-18-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 10:25:48 +0000
Message-Id: <20260612102548.B552B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24809-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B0B2678AC2

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete implementation of 128 Gbps link speed reporting and c=
apability parsing.
--

commit 132584b87856488e93a0fd2c24a72b08430be770
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Extend execute_fw mailbox to include 29xx

Add IS_QLA29XX() to the BPM capability macros and to the
execute-firmware mailbox command so that NVMe enable, minimum
speed negotiation, 128 Gbps speed reporting, EDIF hardware
detection, and FW-semaphore retry logic all apply to 29xx
adapters.

[ ... ]

> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_de=
f.h
> index 2b57782b3cd34..e93766e814809 100644
> --- a/drivers/scsi/qla2xxx/qla_def.h
> +++ b/drivers/scsi/qla2xxx/qla_def.h
> @@ -4333,6 +4333,7 @@ struct qla_hw_data {
>  #define PORT_SPEED_16GB 0x05
>  #define PORT_SPEED_32GB 0x06
>  #define PORT_SPEED_64GB 0x07
> +#define PORT_SPEED_128GB 0x08

[Severity: Medium]
Will this new speed cause qla2x00_get_link_speed_str() and
qla2x00_port_speed_capability() to return unknown values for 128 Gbps links?

In drivers/scsi/qla2xxx/qla_isr.c:qla2x00_get_link_speed_str(), QLA_LAST_SP=
EED
is 8. Because PORT_SPEED_128GB is 8, the condition speed < QLA_LAST_SPEED
evaluates to false, causing the function to fall through to LS_UNKNOWN.

Consequently, the driver logs "LOOP UP detected (? Gbps)" instead of
reporting 128 Gbps.

In drivers/scsi/qla2xxx/qla_gs.c:qla2x00_port_speed_capability(), there is =
no
case for the FC-GS GPSC 128 Gbps bit (BIT_6).

Remote ports operating at 128 Gbps are mapped to PORT_SPEED_UNKNOWN, which =
may
prevent the driver from correctly adjusting iIDMA tuning parameters for
128 Gbps targets in qla2x00_set_idma_speed().

>  #define PORT_SPEED_10GB	0x13
>  	uint16_t	link_data_rate;         /* F/W operating speed */
>  	uint16_t	set_data_rate;		/* Set by user */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612095333.1666=
592-1-njavali@marvell.com?part=3D17

