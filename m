Return-Path: <linux-scsi+bounces-25618-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8gI7CmRRS2ohPQEAu9opvQ
	(envelope-from <linux-scsi+bounces-25618-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 08:55:32 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD10970D35E
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 08:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kmNg3XMC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25618-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25618-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0BF6310E8D6
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C643635D;
	Mon,  6 Jul 2026 06:22:33 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C63C429811
	for <linux-scsi@vger.kernel.org>; Mon,  6 Jul 2026 06:22:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318950; cv=none; b=WaAzuw8TcZNzmu1OCFBO4GIx9q4LdnSJMihoLJndHPSom89G+IbEXS3jE041hD62Y8EINAjJV1qvfmDYK5CrSnYgLpJOIi9XDxvPlr/ySRlLe8Y73umvLrm08Y/TmG0+Q0bglkFSEH6XtcT8LA+5/Gk4/IhudjCgn9QSXdq5qzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318950; c=relaxed/simple;
	bh=efzKjDZijOjRd4MF7DmkC/VG68tjPZCWbDF4QacBCAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDvhGpHceT+YFzj5F+jOlcUeW/4piVJq2wKzpMYMldxMz2/aKzvhvqeBm/gNmL25ODD8/4But9469/wRDPH8LX14CNlvA3WUXnZxUIi4RyFgxnFDGMqMhgjAV1NjEQV0ho3a6vfz7GvjqUNNuCTWD1ITva3VmsicH8jwFtLQkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmNg3XMC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAF81F01567;
	Mon,  6 Jul 2026 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783318941;
	bh=kwa8e3pwbtHmRDzCnJJ668Um64LxikooHJCDEWDDz1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kmNg3XMCLnUVk7UtQFm6OBoMtNIDp4TWPNN1MdWJHdf7XvEAqTwsqOrGfl3sNmS7z
	 i0u5zaUnUGnBldK/kInm4zV3r7AukkoRF7/7t6jj4RqoD4EQF8P1zRtctBmWAfyaiw
	 pok0bEtoPeEWGbb5p83rd1sLPAIZbz7Acx+HmqmuOcDNZmhbTO2Bxuiag+LO48yO8x
	 AI8Tb6CttCKsTVQfB7aHU1qoc+2kH8ohNJRvV4xZh+rV41adWoIxhpmxm7buzJb86M
	 CA/xMEFghbiY6c8oSlpuK7D/TvIgxXeoqP6zIOgIDrwGcFO4fL33PvNI8C7e4zK5Gr
	 Dhgd1jVc9uZkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: fix invalid kfree of embedded event_data
 in event callback
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260706060840.2287-1-lirongqing@baidu.com>
References: <20260706060840.2287-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 06:22:20 +0000
Message-Id: <20260706062220.CBAF81F01567@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25618-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD10970D35E

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver queues delayed works for firmware events but fails to c=
ancel them properly during module unload and host removal, leading to a use=
-after-free and workqueue corruption when the delayed timer eventually fire=
s.
- [High] Integer overflow in firmware event size calculation leads to out-o=
f-bounds read on the kernel heap.
- [Medium] Missing bounds check on EventDataLength allows out-of-bounds rea=
d from the DMA pool, leaking data to userspace.
--

commit b3e94f572f1eaa0696e3b47cd0fd8d836c959627
Author: Li RongQing <lirongqing@baidu.com>

scsi: mpt3sas: fix invalid kfree of embedded event_data in event callback

This commit removes an erroneous kfree(fw_event->event_data) call in the
MPI2_EVENT_SAS_TOPOLOGY_CHANGE_LIST error path. Since event_data is a
flexible array member embedded within the fw_event_work structure, freeing
it separately is invalid and can corrupt the heap. The extra kfree is also
redundant because the subsequent fw_event_work_put() frees the entire
structure.

> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/=
mpt3sas_scsih.c
> index 12caffeed3a0d..ca01a496f14c7 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -12267,7 +12267,6 @@ mpt3sas_scsih_event_callback(struct MPT3SAS_ADAPT=
ER *ioc, u8 msix_index,
>  		if (!fw_event->retries) {
> =20
>  			ioc_err(ioc, "failure at %s:%d/%s()!\n",  __FILE__, __LINE__, __func_=
_);
> -			kfree(fw_event->event_data);
>  			fw_event_work_put(fw_event);
>  			return 1;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this function
I noticed the size calculation can silently overflow:

drivers/scsi/mpt3sas/mpt3sas_scsih.c:mpt3sas_scsih_event_callback() {
    ...
	u16 sz;
    ...
	sz =3D le16_to_cpu(mpi_reply->EventDataLength) * 4;
	fw_event =3D alloc_fw_event_work(sz);
    ...
}

If a device provides a large EventDataLength (e.g., 16385), le16_to_cpu() *=
 4
will overflow the 16-bit sz integer, wrapping it to a small value like 4.
alloc_fw_event_work() will allocate memory using this truncated size.

Later, could _scsih_sas_topology_change_event() cast this small buffer and
read fields from uninitialized adjacent heap memory, potentially causing
unexpected device removals or a denial of service?

[Severity: High]
This is a pre-existing issue, but does this code properly cancel the timer?

drivers/scsi/mpt3sas/mpt3sas_scsih.c:_scsih_fw_event_cleanup_queue() {
    ...
		if (cancel_work_sync(&fw_event->work))
			fw_event_work_put(fw_event);
    ...
}

The driver queues delayed works for firmware events but calls
cancel_work_sync(&fw_event->work) instead of
cancel_delayed_work_sync(&fw_event->delayed_work) during module unload and
host removal.

Could this leave the timer active, leading to a use-after-free on the ioc
structure and workqueue corruption when the delayed timer eventually fires
after the ioc has been freed?

[Severity: Medium]
This is a pre-existing issue, but does this memcpy read out-of-bounds from
the DMA pool?

drivers/scsi/mpt3sas/mpt3sas_ctl.c:mpt3sas_ctl_add_to_event_log() {
    ...
		event_data_sz =3D le16_to_cpu(mpi_reply->EventDataLength)*4;
		sz =3D min_t(u32, event_data_sz, MPT3_EVENT_DATA_SIZE);
		memset(event_log[i].data, 0, MPT3_EVENT_DATA_SIZE);
		memcpy(event_log[i].data, mpi_reply->EventData, sz);
    ...
}

The function calculates event_data_sz from the untrusted EventDataLength
field and clamps it to MPT3_EVENT_DATA_SIZE (192 bytes), but fails to check
if this exceeds the actual hardware reply frame size (ioc->reply_sz,
typically 128 bytes).

Could the memcpy read past the end of the reply frame, pulling in data from
adjacent reply frames in the DMA pool and leaking it to userspace via the
MPT3EVENTREPORT ioctl?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706060840.2287=
-1-lirongqing@baidu.com?part=3D1

