Return-Path: <linux-scsi+bounces-25561-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cRUcGL2ZR2rKbwAAu9opvQ
	(envelope-from <linux-scsi+bounces-25561-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:15:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A4701B40
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:15:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WLcKxda4;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25561-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25561-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2231D3134DD7
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144963BBA05;
	Fri,  3 Jul 2026 11:06:47 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68643BD63B
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 11:06:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076807; cv=none; b=LR1gT3f6YSkW7lk5BpbIR3mcTfy7Nm1iWckTGvgp3d4mFO8nS+n4IR1d0I9qyHr4KUxAomQIcwcvsmGYa3UGiKS3v1IPO9nwq/VH+g8x3IVkKN486rYOXNTprO19adNrLMvB39tFRVw0vJ4wRNMkLYdYqAW5GsgjDTNqGtQasNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076807; c=relaxed/simple;
	bh=7/qqfttO0D9ZITUuiYUzPoFWgtQAijV9whUkwQuV6RM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WnHzbqsB4+zDF1Ve/gBZA+1mjfAc8OgNW1foHjOWV0B756w0kpke12HyRrJFsXMD7uPgspn037+ysb3QivUbw818lYi94yaCQMWzz39/IjudGdI/nctbFMtQM8+q9DyNX8rXQ+qZHihOgStaXD95H56ZVPLLaLWd6/Shv1GL3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLcKxda4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568861F000E9;
	Fri,  3 Jul 2026 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783076805;
	bh=dyb+TJVQ53uVQJMYv+HsuMPxnR+mVqTP5prs1/XIjQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLcKxda4ZkqcLMq7S3SaIH4r0YMt6jLhExpdPQ9l4m30bvn7SgOwZdrbh0B6HmcCc
	 JtpCW7R3MsudzlYcg6uvrd7/8t2XBKlFrCZ3g3lPz73Cc/k0TE54sPD7ouuFTKOkVE
	 uNXpwwLhPvx5SI8teuOBbmVvy1vk7EpT9EpQiU4UozrhWCoIAqaZimVFoNGAcJ+1Mt
	 v7LTSYOv/6L1sNSwTx7bh5YrKHBMa/EHgiV66vHEIKUyUi+QlNS3OCtsvDDUcn2QDY
	 XfojKj03r05RhW5hN2R8Fz4art1+DdFumyduTUqEVvWCGszjqMAdHYDbJMPe8CkzYb
	 ZCLf1bn3A7flg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] nvme-multipath: add nvme_mpath_is_{disabled,
 optimised}
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703103204.3724406-5-john.g.garry@oracle.com>
References: <20260703103204.3724406-1-john.g.garry@oracle.com>
 <20260703103204.3724406-5-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:06:44 +0000
Message-Id: <20260703110645.568861F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25561-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF1A4701B40

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch relies on missing structs, headers, and Kconfig symbols, =
causing a fatal build failure.
--

commit b4542aff5d48fe0783ce1a5c4b163d732171214c
Author: John Garry <john.g.garry@oracle.com>

nvme-multipath: add nvme_mpath_is_{disabled, optimised}

This commit adds nvme_mpath_is_disabled and nvme_mpath_is_optimized callbac=
ks
for multipath devices. It wires these up to the mpath_head_template structu=
re.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index e0573ca71ec60..6d3df1775dbeb 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -305,6 +305,11 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
>  	return false;
>  }
> =20
> +static bool nvme_mpath_is_disabled(struct mpath_device *mpath_device)
> +{

[Severity: Low]
Does this patch depend on other missing patches in a series?

Compiling this change fails because struct mpath_device is an incomplete ty=
pe.
It appears other dependencies like <linux/multipath.h> or LIBMULTIPATH are
missing from the tree.

> +	return nvme_path_is_disabled(nvme_mpath_to_ns(mpath_device));
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703103204.3724=
406-1-john.g.garry@oracle.com?part=3D4

