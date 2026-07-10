Return-Path: <linux-scsi+bounces-25982-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IDryJy1JUWqPBwMAu9opvQ
	(envelope-from <linux-scsi+bounces-25982-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 21:34:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0980073DD17
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 21:34:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FAIFSmam;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25982-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25982-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7808C30A3DC4
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F12773CA;
	Fri, 10 Jul 2026 19:30:11 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92038AC78
	for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 19:30:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711811; cv=none; b=S4wvo9ZqpLUqg3c5F0AG7Wa2fdBTBHCdUDttc4IZDbHYLFlYIBWH3n1UdGmpUrcsQMVDYJr8ZAsRyvBczypZmcLei0MXVyh/OdqLxH98xNZgUYv2Z/2fULdGkt0TECp/cYtriuu/AE0vzVOEFuK4P2izDB7cCeVBH7+xJrNlG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711811; c=relaxed/simple;
	bh=+9Qk3tU9zMTBixNAn3ibCtKf2fgvDR4jPp1sTJueYuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNe/MDnmorNjUArlMngDZt6wCqbLTCLPjiJqGiKwUESjAGg1YKcgLkpzhFZcUGLjgRruCcyB7Z6SJg+qS6Hl0NvHpEOBZMtiPRMA4IQFhMtQoYe5beXr5eTy0JKxOO8a9rH9q7vuilmBODgMN7QGq8PwaIVoMeZaoHD/Dxt1OGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAIFSmam; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFBC1F000E9;
	Fri, 10 Jul 2026 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783711810;
	bh=RZlmjiKd/QQQWNxGLGZ9UgEtop/HJRcL+e9O1RtGDiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FAIFSmamAjWFsJ38yxRq/GvqmLiX9DapR7vLSHbRkFlAHdgJaihO6rM08zrpOlhJt
	 agOuBvjUjdq697IvLh0Od2PvGv3QNnRsvmqc/mJ9xJZ8BG/FpRWMFS9mLOSaMVKzmv
	 lvutbHSEIbOJTdQlYJ8N9sQ6W3QhYYKV1lc2eD/zUeKwU1j9K0MwAuLhNySRNeWKMj
	 QkgrWbdZX2oFY7ICZaJi/TMHDXV67NMLPUDH6TWvg83EbT1CGo8aQ6f12js5XXTL4f
	 7kh777ki1+xXUq2ksaTP2yWWYbwrQatu7rztKtzYZXqGfVrA17wwMc+ItqanszlLQc
	 2pYogtY2BfJTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/8] ibmvfc: make ibmvfc login to fabric
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Marquardt" <davemarq@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260710-ibmvfc-fpin-support-v4-3-ef031ac19520@linux.ibm.com>
References: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
 <20260710-ibmvfc-fpin-support-v4-3-ef031ac19520@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 19:30:09 +0000
Message-Id: <20260710193009.CCFBC1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25982-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davemarq@linux.ibm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0980073DD17

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced IBMVFC_YES_SCSI capability flag is defined =
but never added to the client's login capabilities payload, preventing the =
client from advertising SCSI fabric login support to the VIOS.
--

--- Patch [3]: [PATCH v4 3/8] ibmvfc: make ibmvfc login to fabric ---
commit 1b5a2938bf5a0e21e24c77be11449d47426c29c4
Author: Dave Marquardt <davemarq@linux.ibm.com>

ibmvfc: make ibmvfc login to fabric
   =20
Add fabric login capability to support asynchronous event queue with
dedicated interrupt as required by NPIV specification for async sub-queue
and full/extended FPIN message support.

[ ... ]

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvf=
c.h
> index 526632cb72377..adfd67e85af86 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.h
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.h
> @@ -180,6 +181,7 @@ struct ibmvfc_npiv_login {
>  #define IBMVFC_CAN_HANDLE_FPIN		0x004
>  #define IBMVFC_CAN_USE_MAD_VERSION	0x008
>  #define IBMVFC_CAN_SEND_VF_WWPN		0x010
> +#define IBMVFC_YES_SCSI			0x040

[Severity: Medium]
Will the new fabric login functionality be reachable?

The IBMVFC_YES_SCSI flag is defined here, but it doesn't appear to be added
to the login capabilities payload in ibmvfc_set_login_info():

	login_info->capabilities =3D
		cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN |
			    IBMVFC_CAN_USE_NOOP_CMD);

Without advertising this capability to the VIOS, will the VIOS ever return
the IBMVFC_SUPPORT_SCSI flag, or will the host always fall back to the
legacy initialization path?

>  #define IBMVFC_CAN_USE_NOOP_CMD		0x200
>  	__be64 node_name;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-ibmvfc-fpi=
n-support-v4-0-ef031ac19520@linux.ibm.com?part=3D3

