Return-Path: <linux-scsi+bounces-25788-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c2czDv2ZTGqlmwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25788-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:17:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 946EE717DF6
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:17:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=N7cYSt8Z;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25788-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25788-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 647D93078102
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 06:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DFB3955ED;
	Tue,  7 Jul 2026 06:13:24 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABA3A16AB
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 06:13:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404804; cv=none; b=NDhbjW6a9I454yXCwlUINdJk5xHeyZZkwlL0bSNiU+I9iuHmxVTsuRLpbhND0x1UCLsbjGcZo+FA+1xobAfbWiLR+80qt6cC2PXnh04c0NHAd+80Xi9rzsp/KCgOLY/tFeaz4ETwTBSMfYzVn+BfI+qUrP7lbxEEuYw86PVZlGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404804; c=relaxed/simple;
	bh=iWU9ustsvLoPMHOCNyDkIe6OaVrJwqjfJpwYMn56m34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EVHiIcSDWH9bgyzz6Cg20uiD3QS1x3LlKPpX7amDca35C0bTfF+IAH6I7wyXngc0+1Y2cZ2P8NlgZ8zGua7TQRtgnGXzqYsvt/35Ckd82mTi+vLmvKvmbUHOTX6pGHBy7Wt0RkVDhDn21c9QoT8DGJU5yD0YrRGA+GUNN85KcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7cYSt8Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4940F1F000E9;
	Tue,  7 Jul 2026 06:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783404802;
	bh=xrMRLBJcp7nwidwnuVcRhlHHPrTIIlCU2Zzz1La4Qes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N7cYSt8ZSp5ArYM1Ffdk1KS8FEr7KbEOAknl0sC/zPfuTehzLuwqIz+cnRQ5EM1ob
	 NH5TYstSiPer9x20FaLKRTQ96ux5xesLlL74KyFqJXjOhWXBfLaNqVg2N7YWAlMIZn
	 0QKwG1K52A1FYcV0tOytHCYY0jSMci1bOcDGzQCjF6KlsBiWs6oZjkRbZtkV9YQhPM
	 GG6fib5GbhkWoCIDSNhRUgGEQql+LLDbk5af9NzQTM71n3G92u6fJ0pPPkz//zgaif
	 /LonW8QldofoIU/avhcbcLCdSmM6LmUlJdH7Vqo7FIgK3JCC5zlGLjQmk+kVBfFKM6
	 nEGcbiGmPfarg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/88] scsi: qla2xxx: Add BSG MPI firmware load/dump
 for 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-9-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-9-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 06:13:21 +0000
Message-Id: <20260707061322.4940F1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25788-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 946EE717DF6

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Double completion of the BSG job in `qla2900_bsg_load_mpi()` when =
an error occurs.
- [High] The logic for the `LOAD_MPI` and `DUMP_MPI` commands is fundamenta=
lly reversed, causing 'load' to read from the adapter and 'dump' to write t=
o it.
- [Medium] Missing adapter type validation in `qla2900_bsg_dump_mpi()` and =
`qla2900_bsg_load_mpi()`.
- [Medium] Integer overflow in `chunk_count` causes firmware protocol corru=
ption for large payloads.
--

--- Patch [8]: [PATCH v3 08/88] scsi: qla2xxx: Add BSG MPI firmware load/du=
mp for 29xx ---
commit 7a0034bb29c7bf9118f18cc98555126fd42186bf
Author: Manish Rangankar <mrangankar@marvell.com>

scsi: qla2xxx: Add BSG MPI firmware load/dump for 29xx

Add BSG vendor commands for loading and dumping MPI firmware on
29xx adapters.  This extends the existing BSG infrastructure with
the necessary mailbox wrappers and flash helpers for MPI
operations.

> diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bs=
g.c
> --- a/drivers/scsi/qla2xxx/qla_bsg.c
> +++ b/drivers/scsi/qla2xxx/qla_bsg.c

[ ... ]

> @@ -1804,6 +1804,18 @@ static int qla2900_bsg_dump_mpi(struct bsg_job *bs=
g_job)
>  {
>  	struct fc_bsg_request *bsg_req =3D bsg_job->request;
>  	struct fc_bsg_reply *bsg_reply =3D bsg_job->reply;
>  	struct Scsi_Host *host =3D fc_bsg_to_shost(bsg_job);
>  	scsi_qla_host_t *vha =3D shost_priv(host);
>  	struct qla_hw_data *ha =3D vha->hw;

[Severity: Medium]
Could this command be sent to older adapters that do not support it?
There doesn't appear to be a capability check (like IS_QLA29XX) before
processing these 29xx-specific mailbox commands, which might cause
unpredictable behavior on older hardware.

>  	struct qla_load_dump_mpi *dmcmd;
>  	uint16_t opts =3D 0;
>  	int rval =3D 0;
> =20
>  	if (bsg_job->request_len < sizeof(struct fc_bsg_request) +
>  	    2 * sizeof(uint32_t) + sizeof(struct qla_load_dump_mpi))
>  		return -EINVAL;
> =20
>  	dmcmd =3D
>  	(struct qla_load_dump_mpi *)&bsg_req->rqst_data.h_vendor.vendor_cmd[2];
> =20
>  	ql_log(ql_log_info, vha, 0xffff,
>  	       "%s: mpi_address 0x%x mpi options 0x%x length 0x%x\n",
>  		__func__, dmcmd->mpi_address, dmcmd->options, dmcmd->length);
> =20
>  	mutex_lock(&ha->optrom_mutex);
>  	rval =3D qla29xx_mpi_optrom_setup(bsg_job, vha, dmcmd->mpi_address, 1);

[Severity: High]
Does this function implement the dump operation in reverse? Setting
is_update=3D1 reads from the host request payload and writes the contents
to the device, which is typically the behavior of a load operation.

[ ... ]

> @@ -1877,6 +1877,18 @@ static int qla2900_bsg_load_mpi(struct bsg_job *bs=
g_job)
>  {
>  	struct fc_bsg_request *bsg_req =3D bsg_job->request;
>  	struct fc_bsg_reply *bsg_reply =3D bsg_job->reply;
>  	struct Scsi_Host *host =3D fc_bsg_to_shost(bsg_job);
>  	scsi_qla_host_t *vha =3D shost_priv(host);
>  	struct qla_hw_data *ha =3D vha->hw;

[Severity: Medium]
Is there a missing adapter capability check here as well? Without verifying
the hardware type, this could be dispatched to older adapters that lack
support for this feature.

>  	struct qla_load_dump_mpi *lmcmd;
>  	uint16_t opts =3D 0;
>  	int rval =3D 0;
> =20
>  	if (bsg_job->request_len < sizeof(struct fc_bsg_request) +
>  	    2 * sizeof(uint32_t) + sizeof(struct qla_load_dump_mpi))
>  		return -EINVAL;
> =20
>  	lmcmd =3D
>  	(struct qla_load_dump_mpi *)&bsg_req->rqst_data.h_vendor.vendor_cmd[2];
> =20
>  	ql_log(ql_log_info, vha, 0xffff,
>  	       "%s: mpi_address 0x%x mpi options 0x%x length 0x%x\n",
>  		__func__, lmcmd->mpi_address, lmcmd->options, lmcmd->length);
> =20
>  	mutex_lock(&ha->optrom_mutex);
>  	rval =3D qla29xx_mpi_optrom_setup(bsg_job, vha, lmcmd->mpi_address, 0);

[Severity: High]
Similarly, does this implement the load operation in reverse? The is_update=
=3D0
flag causes it to read from the device and write to the host reply payload,
which is typically the behavior of a dump operation.

[ ... ]

>  	bsg_reply->reply_payload_rcv_len =3D ha->optrom_region_size;
>  	vfree(ha->optrom_buffer);
>  	ha->optrom_buffer =3D NULL;
>  	ha->optrom_state =3D QLA_SWAITING;
>  	mutex_unlock(&ha->optrom_mutex);
>  	bsg_job->reply_len =3D sizeof(struct fc_bsg_reply);
>  	bsg_job_done(bsg_job, bsg_reply->result,
>  		     bsg_reply->reply_payload_rcv_len);
> =20
>  	return rval;
>  }

[Severity: High]
Will returning a non-zero error code here cause a double completion?
Since bsg_job_done() is already called to manually complete the job,
returning an error code in rval could cause the block layer to attempt
completion a second time, potentially causing block request list corruption.
The qla2900_bsg_dump_mpi() function returns 0 unconditionally after
calling bsg_job_done().

> diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_su=
p.c
> --- a/drivers/scsi/qla2xxx/qla_sup.c
> +++ b/drivers/scsi/qla2xxx/qla_sup.c

[ ... ]

> @@ -573,6 +573,12 @@ int
>  qla29xx_mpi_optrom_data(struct scsi_qla_host *vha, uint16_t opts, void *=
buf,
>  		       uint32_t offset, uint32_t length, enum qla29xx_mpi_optrom_op op)
>  {
>  	struct qla_hw_data *ha =3D vha->hw;
>  	dma_addr_t optrom_dma;
>  	void *optrom;
>  	uint32_t mpi_addr, mpi_size, burst =3D 0;
>  	uint32_t total_chunks =3D 0;
>  	uint32_t *dcode, *fwcode;
>  	uint16_t chunk_count =3D 0;

[Severity: Medium]
Can chunk_count overflow if the payload is large enough?
Since total_chunks is a 32-bit integer, a large payload could cause the
16-bit chunk_count to wrap to zero. When passed to set_chunk_mpi_bits()
later in this loop, this wrapped value could incorrectly set the 'first chu=
nk'
flags for segments in the middle of the payload.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D8

