Return-Path: <linux-scsi+bounces-25232-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 55DZNp1pO2peXggAu9opvQ
	(envelope-from <linux-scsi+bounces-25232-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 07:22:37 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C26BB85E
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 07:22:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="DXug/A/V";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25232-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25232-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC9D30107D6
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 05:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF89308F3E;
	Wed, 24 Jun 2026 05:17:34 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DC40D57C
	for <linux-scsi@vger.kernel.org>; Wed, 24 Jun 2026 05:17:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278254; cv=none; b=GhZ3lJc8guRQl2aKgvXFcK+Pw+kaDNuwaTr+ov13z2gYBZw/9/nVeyo3CRK16F2cC/62gC3N/yqsKrOmDRJubSHkZJy5h8pXEj/UXeIgV7e6WILflr4pMch4O4I8Xdhn6ZdAFX038qKTuHK7ueawftw5wgEl8exeKua9+F8eVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278254; c=relaxed/simple;
	bh=wVcaM3uK8bwL8u0Roxr72ygKc0iW4qI/XchsiyUooiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mmMqLv0wIU8udqYmdW3vS6skpfEw+wiB63mKHqLhHN2YsNX/Cz+Wqy/r0b3IFr6YKcOOgH6DmvADfOYacNehRZv3NtKqR1X9bqzlnWU+ujdc6eMqbGblyL5iYJO5ld1sTD3p5MXl+Jr7anKI2TRHS7RZy0VBPD+b6b9tjTXyIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXug/A/V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A361F000E9;
	Wed, 24 Jun 2026 05:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782278253;
	bh=793kcWiS/svuvcy2SyL+5Hxv4il/4QFXHCFbQKWA9Ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DXug/A/VfWsS+4/gEG9ZIXeirCDUeu5TA6av2ljl32rauXlEPOu0tWRMbNi/axYFv
	 lJ5wn9IPvZ8t2Co0AqDxyFeiWYH0/XVcMEI3E7Je20av8PubnpoRSFW91O6redM5KL
	 e+D3E5ztgsfagtiyn9nPgoikIBfC6rGWg+eHU7K1dDpCIhJkbWWIfNm9TKQfWzqPcv
	 yKho70yarKRywWAK4Fn9Fpv40UC9Ol/cR/ROpiuEXVbgijP/Vm0w4r1rzeVyKKGqbU
	 JOY4FdDqAozL5gHZyOtMFKIbbdMLktAWqwNhOX7n4X4dCZgMaMoAHctWnW+UpEvszM
	 rWCaJh+pJyreg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/13] scsi: fnic: Expose NVMe transport state in
 debugfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karan Tilak Kumar" <kartilak@cisco.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260624044334.3079-13-kartilak@cisco.com>
References: <20260624044334.3079-1-kartilak@cisco.com>
 <20260624044334.3079-13-kartilak@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 05:17:32 +0000
Message-Id: <20260624051732.C4A361F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25232-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kartilak@cisco.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,cisco.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 303C26BB85E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The NVMe debugfs file is created and exposed to user space before =
the data structures and locks it depends on are initialized, creating a rac=
e condition that can trigger a NULL pointer dereference and uninitialized s=
pinlock access.
--

commit 82342d5cda06cd97fbd3a125f13faf76b39082ad
Author: Karan Tilak Kumar <kartilak@cisco.com>

scsi: fnic: Expose NVMe transport state in debugfs

Create an NVMe debugfs directory with a per-host nvmef_info file,
reporting local-port and target-port identifiers for NVMe initiator
instances.

> diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
> index df8c8ebbc32b9..245db1b992b51 100644
> --- a/drivers/scsi/fnic/fnic_main.c
> +++ b/drivers/scsi/fnic/fnic_main.c
[ ... ]
> @@ -933,6 +933,7 @@ static int fnic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
>  		err =3D -EOPNOTSUPP;
>  		goto err_out_fnic_role;
>  	case VFCF_FC_NVME_INITIATOR:
> +		fnic_nvmef_debugfs_init(fnic);

[Severity: High]
Is it safe to create and expose the debugfs file nvmef_info this early in
the probe sequence?

At this point in fnic_probe(), the fnic structure has been allocated with
kzalloc(), but critical structures like fnic_lock and iport->tport_list
haven't been initialized yet. They appear to be initialized later in the
function or in fnic_fdls_init().

If a process concurrently opens and reads this debugfs file right after
fnic_nvmef_debugfs_init() returns, could it trigger a crash?

>  		fnic->role =3D FNIC_ROLE_NVME_INITIATOR;
>  		dev_info(&fnic->pdev->dev, "fnic: %d is NVME initiator\n",
>  			fnic->fnic_num);
[ ... ]
> diff --git a/drivers/scsi/fnic/fnic_nvme.c b/drivers/scsi/fnic/fnic_nvme.c
> index e322dd4dcb787..a19dd9cf76cf9 100644
> --- a/drivers/scsi/fnic/fnic_nvme.c
> +++ b/drivers/scsi/fnic/fnic_nvme.c
[ ... ]
> @@ -188,6 +188,36 @@ void nvfnic_release_nvme_ioreq_buf(struct fnic_iport=
_s *iport,
>  			     fnic->io_sgl_pool[io_req->sgl_type]);
>  }
> =20
> +int nvfnic_get_nvmef_info(struct fnic *fnic, struct fnic_nvmef_info *inf=
o)
> +{
> +	int len =3D 0;
> +	struct fnic_iport_s *iport =3D &fnic->iport;
> +	int buf_size =3D info->buf_size;
> +	struct fnic_tport_s *tport;
> +	struct fnic_tport_s *next;
> +	unsigned long flags;
> +
> +	if (buf_size <=3D 0)
> +		return 0;
> +
> +	len +=3D scnprintf(info->info_buffer + len, buf_size - len,
> +			 "lport wwpn 0x%llx wwnn 0x%llx fcid 0x%06x\n",
> +			 iport->wwpn, iport->wwnn, iport->fcid);
> +
> +	spin_lock_irqsave(&fnic->fnic_lock, flags);
> +	list_for_each_entry_safe(tport, next, &iport->tport_list, links) {

[Severity: High]
If nvfnic_get_nvmef_info() is executed concurrently before the fnic
struct is fully initialized, will this attempt to acquire an
uninitialized fnic_lock?

Furthermore, if iport->tport_list is still zeroed from the kzalloc(),
the list_for_each_entry_safe() macro expects a properly initialized
list head. Could passing a zeroed list head cause a NULL pointer
dereference when computing the next pointer for the first entry?

> +		if (len >=3D buf_size - 1)
> +			break;
> +
> +		len +=3D scnprintf(info->info_buffer + len, buf_size - len,
> +				 "tport wwpn 0x%llx wwnn 0x%llx fcid 0x%06x\n",
> +				 tport->wwpn, tport->wwnn, tport->fcid);
> +	}
> +	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
> +
> +	return len;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624044334.3079=
-1-kartilak@cisco.com?part=3D12

