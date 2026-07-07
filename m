Return-Path: <linux-scsi+bounces-25832-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M6khLdmpTGpLnwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25832-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:25:13 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B3A718711
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:25:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ORoSrBqO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25832-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25832-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76108304C375
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD60384CEC;
	Tue,  7 Jul 2026 07:18:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3373BA22E
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 07:18:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408709; cv=none; b=eUoz6MNh2ozDljcRB/wMKP4xmSZNn0OJL7gsYuBUNWy0dE2HmqKp4mvdyv2OAaeWLV7TZVKOwkcgjSAMfVm/qq5gR4I5PPg8h/9gz15rN5ideiSRpRu1JB/jiRTBIAqaE6mgDGZfwGirq/eR3S/fdwlrQfi/WqMIq4A85zp1eqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408709; c=relaxed/simple;
	bh=aws5Pdtj6CU8lc7N+LE6kWtffwWBwMhC9jIArHYRdvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XWD7e+yOXvVDYdLh5d6ebvyf2FfRgRGd8yckO6wqbbgyroHlPiZtQx5f3+Q0gfnZj7pUyy1jXgZ5Za8OD4NFNraEkkC5WQHxsEHbrnlFPe8UOMbWnPVLsfYIxdxbFpW+/KcpEduuzgCXY9fiGjwzAwgZW8tmv0fJ8amusopMUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORoSrBqO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A8F1F00A3A;
	Tue,  7 Jul 2026 07:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408696;
	bh=5AhPO9C8guRNPJ4OfJaC1p+Y4ve4jtM+rvzs38CjaoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORoSrBqOgiPRJuo3zDsolcmhPODzQcm48G6yXwxE2yx3SRC3Mop/KCfLr3jorWNm5
	 kXlk0R/Q8YJb6WshQqqbfZBl9Z6n9+VH3VmM/rIFRGve5OgYvgBHaEzC60x97DRxI0
	 7qGVHwG59/WLTj0RxNXbujsEldydBHBSnKlI51vJg+4zzRvaDetxYA0aMOXLvAE9HX
	 TTn6iKDLdaRUVaduXmYltT3ZTC08sTY5F7CsVBCp4+FeP+dOwygBysU0AsJcQwNS03
	 aYtJKQnU/2lziJEPaOOmMuaxcVswcgD7aTTm7veY2P6JGSV7NNI1DKpidQTHJmW0hN
	 n2Hd/Wme8giDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 57/88] scsi: qla2xxx: Improve firmware dump data
 capture
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-58-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-58-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:18:16 +0000
Message-Id: <20260707071816.B0A8F1F00A3A@smtp.kernel.org>
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
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25832-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,marvell.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49B3A718711

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Dynamic reallocation of `ha->fw_dump` races with firmware dump cap=
ture in the interrupt handler, leading to a Use-After-Free.
- [High] Unprotected read-modify-write of the `flags` bitfield causes a dat=
a race that can drop concurrent flag updates (e.g., `lip_ae`).
- [Medium] The mailbox registers (`mbregs`) are dumped in native byte order=
, which breaks parsing on Big-Endian architectures.
--

--- Patch [57]: [PATCH v3 57/88] scsi: qla2xxx: Improve firmware dump data =
capture ---
commit 17ed3e31ad505ff9b7203eaec313bd7169cf990b
Author: Quinn Tran <qutran@marvell.com>

scsi: qla2xxx: Improve firmware dump data capture

Capture as much firmware dump data as possible. Save the mailbox
registers at start-of-day, before firmware execution, so they are
available in the dump, and allocate a guestimate dump buffer early
during driver load to capture failures that happen before the final
dump buffer is sized.

> diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_i=
nit.c
> index ae9bf68710793..9d6b229bd3525 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c
[ ... ]
> @@ -3907,13 +3888,11 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
[ ... ]
>  		fw_dump =3D vmalloc(dump_size);
>  		if (!fw_dump) {
[ ... ]
>  		} else {
>  			mutex_lock(&ha->optrom_mutex);
> -			if (ha->fw_dumped) {
> -				memcpy(fw_dump, ha->fw_dump, ha->fw_dump_len);
> -				vfree(ha->fw_dump);
> +
> +			if (ha->fw_dumped || ha->mpi_fw_dumped) {
> +				prev_fw_dump =3D ha->fw_dump;
> +
> +				if (ha->fw_dumped)
> +					memcpy(fw_dump, prev_fw_dump,
> +					    ha->fw_dump_len);
> +
> +				if (IS_QLA27XX(ha) || IS_QLA28XX(ha) ||
> +				    IS_QLA29XX(ha)) {
> +					prev_mpi_fw_dump =3D ha->mpi_fw_dump;
> +					ha->mpi_fw_dump =3D (char *)fw_dump +
> +						ha->fwdt[0].dump_size;
> +
> +					if (ha->mpi_fw_dumped)
> +						memcpy(ha->mpi_fw_dump,
> +						    prev_mpi_fw_dump,
> +						    ha->mpi_fw_dump_len);
> +				}
> +				vfree(prev_fw_dump);
>  				ha->fw_dump =3D fw_dump;

[Severity: High]
Could this lead to a Use-After-Free if the interrupt handler accesses the
firmware dump concurrently?

Since qla2x00_alloc_fw_dump() frees and reassigns ha->fw_dump while holding
optrom_mutex, but the interrupt handler (which calls qla27xx_fwdump())
writes to ha->fw_dump holding only hardware_lock, a concurrent firmware
crash might cause the ISR to write into the freed buffer.

[ ... ]
> @@ -4928,6 +4934,8 @@ qla2x00_init_rings(scsi_qla_host_t *vha)
>  		ql_dbg(ql_dbg_init, vha, 0x00d3,
>  		    "Init Firmware -- success.\n");
>  		vha->u_ql2xexchoffld =3D vha->u_ql2xiniexchg =3D 0;
> +		vha->hw->flags.t262_fail =3D 0;
> +		vha->hw->flags.t272_fail =3D 0;
>  	}
> =20
>  	return (rval);

[Severity: High]
Does modifying these bitfields without a lock cause a data race that could
drop concurrent flag updates?

These flags reside in the same 32-bit memory word as lip_ae and n2n_ae in
struct qla_hw_data. Because bitfield assignment compiles to a
read-modify-write operation, updating them here without holding
hardware_lock could overwrite and lose an asynchronous event update (like
lip_ae being set by the ISR).

> diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_t=
mpl.c
> index b0a74b036cf4b..fd39841274974 100644
> --- a/drivers/scsi/qla2xxx/qla_tmpl.c
> +++ b/drivers/scsi/qla2xxx/qla_tmpl.c
[ ... ]
> @@ -536,13 +547,12 @@ qla27xx_fwdt_entry_t269(struct scsi_qla_host *vha,
>  {
>  	ql_dbg(ql_dbg_misc, vha, 0xd20d,
>  	    "%s: scratch [%lx]\n", __func__, *len);
> -	qla27xx_insert32(0xaaaaaaaa, buf, len);
> -	qla27xx_insert32(0xbbbbbbbb, buf, len);
> -	qla27xx_insert32(0xcccccccc, buf, len);
> -	qla27xx_insert32(0xdddddddd, buf, len);
> -	qla27xx_insert32(*len + sizeof(uint32_t), buf, len);
> +
> +	/* The data format is based on entry type t260. */
> +	qla27xx_insert32(offsetof(struct device_reg_24xx, mailbox0), buf, len);
> +	qla27xx_insertbuf(vha->hw->mbregs, sizeof(vha->hw->mbregs), buf, len);

[Severity: Medium]
Are the mailbox registers being dumped in native byte order instead of
Little-Endian?

Since mbregs was populated using rd_reg_word() (which converts to host byte
order), qla27xx_insertbuf() will copy these bytes directly into the dump,
which may corrupt the diagnostic data on Big-Endian architectures.

>  	if (buf)
> -		ent->t269.scratch_size =3D 5 * sizeof(uint32_t);
> +		ent->t269.scratch_size =3D sizeof(uint32_t) + sizeof(vha->hw->mbregs);
> =20
>  	return qla27xx_next_entry(ent);
>  }

[Severity: Medium]
Could this assignment break parsing tools expecting a standard Little-Endian
format?

Directly assigning a native uint32_t constant to ent->t269.scratch_size (wh=
ich
is an __le32 field) will store the size in native byte order. It likely nee=
ds
cpu_to_le32().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D57

