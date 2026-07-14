Return-Path: <linux-scsi+bounces-26194-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8zQ2MpM9VmpF2AAAu9opvQ
	(envelope-from <linux-scsi+bounces-26194-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 15:45:55 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CB07554FA
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 15:45:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SqYFGd7+;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26194-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26194-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE19C300A338
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD3477E28;
	Tue, 14 Jul 2026 13:45:51 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67C3BBFC4
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 13:45:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036751; cv=none; b=ZL01X/zyQULU3vVl5ZIz0VvbvTv7Dljn++ALrqGm0lwRgpwDquF1c3IaccTmZjpAzp1LeqJpVsMKmpo9iCRBUWY6tp+rYiyOu/r19oGqXgUh2crmOy/TOD62vdASLXEIEDwIo6KnQGLY4+FVUaq4usNqa0IHHecExfn1gzianSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036751; c=relaxed/simple;
	bh=8cOOz5cPo4HTzfxIZVBBIDUc0lr8ACGy+FalA7m5NZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TXR0VhfsjAEwg/6/CsyKMrdz/dDjFe9Ki4WiLkhTyrzYkQ63v7PJO9uuY4UstH6aGKM9zTUN6zf+BagPAktzB7bLbgy3JX61MxpY4EBgA71TNcN9BIiWaAfwK2PUsJQsNKkysQP+aEhtQC5LN5367QntKdbwnVF4ndBJQ22Xkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqYFGd7+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F721F000E9;
	Tue, 14 Jul 2026 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036750;
	bh=ZuWKjFzvOp5kblYDBoIEcDo4lgKitN2LbiZxBvKlneE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqYFGd7+DBq71EuRrdzZ0UHzvR9coZIixMGe98oTZIQ4990uQK2RntjJHGR8xEKpE
	 DyeAdCeVvDQdjsQjYidp7psVCucuEF5I05s2wIN1vNBytsCas1CGl2iwjWrYcVp6RB
	 W00XsksqZqpXvgD06Od09YRoyw8DrFmMfpAieAnJ0jVBCItAC2GpFt3nqBh/TXJ+GX
	 JlAAovjCzGR9Z8q6qGN1TPxFY9IvuKLqaTvnB3/Uar+wONXF8VeLHV5fAC/LzxZ7Ud
	 UQEj/iH/cKKO0oMQ2M4Abr0Ru37GWDkE4TbfH1NhuDB0XNnbOZIusBgEUY2Bj6zSvG
	 ZjbHucTApyE6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 25/56] scsi: qla2xxx: Handle sts_cont_entry_ext_t for
 29xx adapters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260714095353.289460-26-njavali@marvell.com>
References: <20260714095353.289460-1-njavali@marvell.com>
 <20260714095353.289460-26-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:45:49 +0000
Message-Id: <20260714134550.53F721F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-26194-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64CB07554FA

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Reading up to 124 bytes from a pointer derived from a 60-byte =
array triggers a FORTIFY_SOURCE runtime kernel panic on QLA29XX adapters.
--

--- Patch [25]: [PATCH v4 25/56] scsi: qla2xxx: Handle sts_cont_entry_ext_t=
 for 29xx adapters ---
commit c469c92ca0a450f7a9aa8d8525c84c9f7c522b1c
Author: Nilesh Javali <njavali@marvell.com>
Subject: scsi: qla2xxx: Handle sts_cont_entry_ext_t for 29xx adapters

This commit adds support for 128-byte response queue entries on 29xx
adapters. It updates status continuation IOCB processing paths to use
the correct entry type and data payload size based on the adapter type.

> diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_is=
r.c
> index 26722afa937c8..f668012de3d44 100644
> --- a/drivers/scsi/qla2xxx/qla_isr.c
> +++ b/drivers/scsi/qla2xxx/qla_isr.c
[ ... ]
> @@ -271,10 +276,12 @@ int __qla_copy_purex_to_buffer(struct scsi_qla_host=
 *vha,
> =20
>  	do {
>  		while ((total_bytes > 0) && (entry_count_remaining > 0)) {
> -			new_pkt =3D (sts_cont_entry_t *)rsp_q->ring_ptr;
> -			*pkt =3D new_pkt;
> +			*pkt =3D rsp_q->ring_ptr;
> +			data =3D ((sts_cont_entry_t *)*pkt)->data;

[Severity: Critical]
Will this trigger a FORTIFY_SOURCE panic on QLA29XX adapters?

The pointer data is unconditionally derived by casting to sts_cont_entry_t,
which has a 60-byte data array. The compiler tracks this 60-byte bound,
so when memcpy() copies up to 124 bytes later (from the 128-byte continuati=
on
entry), FORTIFY_SOURCE will detect a read buffer overflow and panic the ker=
nel.

> +			data_sz =3D qla_sts_cont_data_size(ha);
> =20
> -			if (new_pkt->entry_type !=3D STATUS_CONT_TYPE) {
> +			if (((sts_cont_entry_t *)*pkt)->entry_type !=3D
> +			    STATUS_CONT_TYPE) {
[ ... ]
> @@ -906,28 +915,24 @@ qla27xx_copy_multiple_pkt(struct scsi_qla_host *vha=
, void **pkt,
>  				continue;
>  			}
> =20
> -			new_pkt =3D (sts_cont_entry_t *)rsp_q->ring_ptr;
> -			*pkt =3D new_pkt;
> +			*pkt =3D rsp_q->ring_ptr;
> +			data =3D ((sts_cont_entry_t *)*pkt)->data;

[Severity: Critical]
Does this face the same FORTIFY_SOURCE bounds checking issue on the 60-byte
data array as __qla_copy_purex_to_buffer() above?

> +			data_sz =3D qla_sts_cont_data_size(ha);
[ ... ]
> @@ -1190,10 +1206,12 @@ qla27xx_copy_fpin_pkt(struct scsi_qla_host *vha, =
void **pkt,
>  				continue;
>  			}
> =20
> -			new_pkt =3D (sts_cont_entry_t *)rsp_q->ring_ptr;
> -			*pkt =3D new_pkt;
> +			*pkt =3D rsp_q->ring_ptr;
> +			data =3D ((sts_cont_entry_t *)*pkt)->data;

[Severity: Critical]
Does this face the same FORTIFY_SOURCE bounds checking issue on the 60-byte
data array as above?

> +			data_sz =3D qla_sts_cont_data_size(ha);
[ ... ]
> @@ -3682,7 +3701,7 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct r=
sp_que *rsp, void *pkt)
>   * Extended sense data.
>   */
>  static void
> -qla2x00_status_cont_entry(struct rsp_que *rsp, sts_cont_entry_t *pkt)
> +qla2x00_status_cont_entry(struct rsp_que *rsp, void *pkt, u32 data_sz)
>  {
>  	uint8_t	sense_sz =3D 0;
>  	struct qla_hw_data *ha =3D rsp->hw;
> @@ -3691,6 +3710,7 @@ qla2x00_status_cont_entry(struct rsp_que *rsp, sts_=
cont_entry_t *pkt)
>  	struct scsi_cmnd *cp;
>  	uint32_t sense_len;
>  	uint8_t *sense_ptr;
> +	u8 *data =3D ((sts_cont_entry_t *)pkt)->data;

[Severity: Critical]
The commit message mentions that qla2x00_status_cont_entry() was changed to
accept void * so it can internally select the right structure based on adap=
ter
type. However, doesn't this hardcoded cast to sts_cont_entry_t * defeat that
and restrict the pointer to a 60-byte array, causing the same FORTIFY_SOURCE
panic when sense_sz is larger than 60 bytes?

> =20
>  	if (!sp || !GET_CMD_SENSE_LEN(sp))
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714095353.2894=
60-1-njavali@marvell.com?part=3D25

