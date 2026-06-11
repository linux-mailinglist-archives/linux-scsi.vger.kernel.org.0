Return-Path: <linux-scsi+bounces-24731-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ErQHGjMFK2qO1QMAu9opvQ
	(envelope-from <linux-scsi+bounces-24731-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 20:57:55 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B928E6749E0
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 20:57:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="cy7r/tx0";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24731-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24731-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4F483071C7E
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E851247A0A5;
	Thu, 11 Jun 2026 18:57:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94993306B08
	for <linux-scsi@vger.kernel.org>; Thu, 11 Jun 2026 18:57:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204230; cv=none; b=cPseIjeXjq5prUa2rMsyf72UM4LMDk42pt1BeFmFC3CBebb9P3+zbbKV/3QgTRdEYGUImOLNg6I7+X/Gm2Cv97HW3KE4vKCPhw1H+ADawA6cjKgxavWSyj30QKVOVI3rCyYMeF6nAr6yr2NAurssmbWaSupOF9bqgoJEyuLji04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204230; c=relaxed/simple;
	bh=Z28Y14R1bpH1TFR1CCxv/Xa9BdwzY8sIVM1YQ73zsug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=InaiRESrXIR7UeefsSjEdL5TLPAkJsdwRYy2gmA0ULpMxGFatkf0EJpEqvs24dwX9OJ3CrQZbDwPJ/A1qZ9DkIkp680HmkpgVEbDk3MxXvp0UiujUKdZ4sdj0bIXRzewcAj8EmOgURzVLJFS1hWNj5THUqCNHB9iuWzVU/vOK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy7r/tx0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D58E1F000E9;
	Thu, 11 Jun 2026 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781204229;
	bh=U4GYmimfsVKsAXjcC/xa0f/T3mgOHT/bfR7nDLsZIlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cy7r/tx0/XsW8/GAv3MsO5tNtqIyl1cA9+d7uYFPbgMHjF0oyvrda6LQi5IThpIkF
	 nnSuJwPl/UDyDeiCiczpVibrClK+8IQk602tp28cDa+NklcHlJiLSZz78yY3MjqPxq
	 AfPfHJhGWGc/JkOgE/KlJqb3tyFCeTuHN6gSnL5M7Qy0KMzcH8B9DNqYkSHJYVE/Eh
	 GFH4hk/9DfDnXJSEd+uZbiMafjxegS3HiTRzLAlR0C707SglpoixAh1Kx1nrXSAK1a
	 V+v4XWftwxehZuj/9sp0feAarG0igPnZGh2DVrp8BpMumrGP/vu+6H7IpL0V/Be+Rz
	 vK4aawxdMBqpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] scsi: target: bound PR-OUT TransportID parsing to
 the received buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260611-b4-disp-9f20739e-v6-1-f6630e2aae44@proton.me>
References: <20260611-b4-disp-9f20739e-v6-1-f6630e2aae44@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:57:08 +0000
Message-Id: <20260611185709.1D58E1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24731-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+hexlabsecurity.proton.me@kernel.org,m:linux-scsi@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,hexlabsecurity.proton.me];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,proton.me:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B928E6749E0

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The patch incorrectly rejects valid, maximum-length (224-byte) F=
ORMAT CODE 00b iSCSI TransportIDs due to an off-by-one error.

Pre-existing issues:
- [High] The parser does not enforce that the ISID string in a FORMAT CODE =
01b TransportID is NUL-terminated or bounded to 8 bytes, leading to out-of-=
bounds reads and potential Information Leaks.
- [High] In-place modification of the TransportID buffer breaks `SPEC_I_PT`=
 PR OUT registrations if the matching iSCSI Target Portal Group (TPG) is no=
t the first one evaluated.
- [High] Leak of configfs dependency and `pr_kref` for `local_pr_reg->pr_re=
g_deve` in `core_scsi3_decode_spec_i_port`.
--

commit 00c1537650e798bd12f371445b4780a799d66bab
Author: Bryam Vargas <hexlabsecurity@proton.me>

scsi: target: bound PR-OUT TransportID parsing to the received buffer

This commit fixes out-of-bounds reads when parsing an iSCSI TransportID
without a separator or NUL terminator by adding length validation. It checks
the lengths of the TransportID elements before scanning or copying data.

> diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/tar=
get_core_fabric_lib.c
> index 87c5d26a50895..2853b95b2c597 100644
> --- a/drivers/target/target_core_fabric_lib.c
> +++ b/drivers/target/target_core_fabric_lib.c
[ ... ]
> @@ -332,16 +345,32 @@ static bool iscsi_parse_pr_out_transport_id(
>  	 * format.
>  	 */
>  	if (format_code =3D=3D 0x40) {
> -		p =3D strstr(&buf[4], ",i,0x");
> +		p =3D strnstr(&buf[4], ",i,0x", tid_len - 4);
>  		if (!p) {
> -			pr_err("Unable to locate \",i,0x\" separator"
> -				" for Initiator port identifier: %s\n",
> -				&buf[4]);
> +			pr_err("Unable to locate \",i,0x\" separator in iSCSI TransportID\n");
> +			return false;
> +		}
> +		/*
> +		 * The iSCSI name runs from &buf[4] up to the separator; reject it
> +		 * if it cannot fit in i_str[TRANSPORT_IQN_LEN].
> +		 */
> +		if (p - &buf[4] >=3D TRANSPORT_IQN_LEN) {
> +			pr_err("iSCSI Initiator port name too long in TransportID\n");
>  			return false;
>  		}
>  		*p =3D '\0'; /* Terminate iSCSI Name */

[Severity: High]
This is a pre-existing issue, but does mutating the shared request buffer
in-place break SPEC_I_PT PR OUT registrations?

In core_scsi3_decode_spec_i_port(), the code loops over multiple exported
TPGs and calls target_parse_pr_out_transport_id() on the same payload
buffer.

If the node ACL is not found on the first matching TPG, the loop continues
and attempts to parse the exact same buffer again for the next TPG.

Because the separator is overwritten with a '\0' here during the first
pass, strnstr() fails to find ",i,0x" on the second pass, returning false
and causing the valid registration to fail.

[ ... ]
> @@ -349,7 +378,7 @@ static bool iscsi_parse_pr_out_transport_id(
>  		 * for comparison against the running iSCSI session's ISID from
>  		 * iscsi_target.c:lio_sess_get_initiator_sid()
>  		 */
> -		for (i =3D 0; i < 12; i++) {
> +		for (i =3D 0; i < 12 && p < buf + tid_len; i++) {

[Severity: High]
This isn't a bug introduced by this patch, but does the parser enforce that
the ISID string is NUL-terminated or bounded to 8 bytes?

If an attacker provides an unterminated ISID string that extends exactly
to the end of the mapped command buffer page,
iscsi_parse_pr_out_transport_id() correctly bounds the lowercasing loop but
returns the port_nexus_ptr pointing to the unterminated string.

Callers then read past the buffer boundary. For example,
__core_scsi3_do_alloc_registration() calls get_unaligned_be64(isid) and
snprintf("%s", isid) reading past the buffer.

Could this read into the adjacent vmalloc guard page causing a KASAN crash?

[ ... ]
> -	} else
> +		strscpy(i_str, &buf[4], TRANSPORT_IQN_LEN);
> +	} else {
>  		*port_nexus_ptr =3D NULL;
> -
> -	strscpy(i_str, &buf[4], TRANSPORT_IQN_LEN);
> +		/*
> +		 * FORMAT CODE 00b: the name occupies buf[4..tid_len-1].  The
> +		 * declared length tid_len - 4 must fit in i_str[TRANSPORT_IQN_LEN].
> +		 * (For 01b the same tid_len bound would be over-restrictive: the
> +		 * descriptor also carries the separator and ISID, so a legal
> +		 * <=3D223-byte name gives tid_len up to 244.)
> +		 */
> +		if (tid_len - 4 >=3D TRANSPORT_IQN_LEN) {

[Severity: Medium]
Does this incorrectly reject valid, maximum-length (224-byte) FORMAT CODE
00b iSCSI TransportIDs?

The length tid_len - 4 represents the entire length of the iSCSI NAME field
including its mandatory NUL terminator.

An iSCSI name of 223 characters plus a NUL terminator equals exactly 224
bytes, which SPC-4 explicitly allows.

Because strscpy() operates safely when the source perfectly matches the
destination array size, should this check use ">" instead of ">=3D"?

[ ... ]
> diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core=
_pr.c
> index 11790f2c5d80f..0b19997c2edde 100644
> --- a/drivers/target/target_core_pr.c
> +++ b/drivers/target/target_core_pr.c
> @@ -1573,7 +1573,7 @@ core_scsi3_decode_spec_i_port(
> =20
>  			iport_ptr =3D NULL;
>  			tid_found =3D target_parse_pr_out_transport_id(tmp_tpg,
> -					ptr, &tid_len, &iport_ptr, i_str);
> +					ptr, tpdl, &tid_len, &iport_ptr, i_str);

[Severity: High]
This is a pre-existing issue, but does core_scsi3_decode_spec_i_port()
leak a configfs dependency and pr_kref for local_pr_reg->pr_reg_deve?

Earlier in this function, local_pr_reg is created and
core_scsi3_lunacl_depend_item(local_pr_reg->pr_reg_deve) is called,
acquiring a configfs dependency.

The registration is added to tid_dest_list via a newly allocated tidh_new,
but tidh_new->dest_se_deve is left as NULL.

On the success path, the configfs dependency is not released. On the error
path, the cleanup loop bypasses core_scsi3_lunacl_undepend_item() because
tidh->dest_se_deve is NULL for local_pr_reg.

Could this prevent administrative tear down of the LUN via configfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-disp-9f=
20739e-v6-1-f6630e2aae44@proton.me?part=3D1

