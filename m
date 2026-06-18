Return-Path: <linux-scsi+bounces-25060-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xIBkKjCTM2pPDgYAu9opvQ
	(envelope-from <linux-scsi+bounces-25060-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 08:41:52 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9269DE43
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 08:41:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aKLvBhLb;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25060-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25060-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24935306640B
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786136A362;
	Thu, 18 Jun 2026 06:41:46 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA4368D67
	for <linux-scsi@vger.kernel.org>; Thu, 18 Jun 2026 06:41:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764905; cv=none; b=BvHXvednnpHZygvslt/ArLmuJO1LrGgVWxGSFORxQ2Y2+LaPBvXB7NkYV7sFg7Gt4HaoU5sfbrowW3UVg7PQKhsGwShBFPnNB79/Yp2Kpo0/Ze1Tx8JMF+bgs87IutIk/jO/knEON01GT9GUpBEz6SYLZGLhCq7Vi/jQHfLzGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764905; c=relaxed/simple;
	bh=pg68vd0Z3fbpDBkUb7jhzr7msvu6jsgA9LZHi4U9ls4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sAafko6krNRyVwWEX3ejdx5+LeJjkjbA0qrK50tlqO/f7ZaNt2JqqnPRoMHYc8i02sXn1Ies3DsLRIKBQDeEov2zbnx1uM1AtnvAy8U4WHdjOUz+nnQfMVPlvwfZs6KIWXiHd60fXCRvLB9aYxFuu2E27taH0M8mOlFcWJc+6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKLvBhLb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C30E1F000E9;
	Thu, 18 Jun 2026 06:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781764902;
	bh=QhQ5cOeewwZA3VY6nBoXuVEAyxW7uEznW+Hxz/tJWvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKLvBhLbRA8N+U/PuSvxErlEEl0UNde3xZpYoHULMbxIhr5mgYBN2AKnWKMdD9wnN
	 R9S8Tho4Ofe63KVV4CTRiO+2HNAVmVkbbMViyatyK6QA7loP40eMtW57banypYl/Oy
	 z5ws7zcHLiyA1OLg7fBb7/b+5cxwDXw+4zVkaBHm3Nlm/HlyiLvfJhgM2dR8Ga5Q6Z
	 n4/kMVjchiVeofi91p22DQQ/9ENlOSMKU4jURb08/66nXoZT7jqfj7PoA3evIbjHlU
	 mfp1rzHhnfEzklCodsDpDJ0GOqUys3l5zPTOwlwlFW5oJdqYwlYK9ISCru76iTWquA
	 mILnh8CIMTWbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: ufs: Remove redundant ret check in rpmb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ao Sun" <ao.sun@transsion.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260618062752.492-1-ao.sun@transsion.com>
References: <20260618062752.492-1-ao.sun@transsion.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 06:41:42 +0000
Message-Id: <20260618064142.8C30E1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25060-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ao.sun@transsion.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[transsion.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20A9269DE43

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incorrect device lifecycle management for `ufs_rpmb_dev` cause=
s a reference cycle and Use-After-Free on device removal.
--

commit e8c5159f6cdc84b865b38447899724970aac1440
Author: Ao Sun <ao.sun@transsion.com>

scsi: ufs: Remove redundant ret check in rpmb

Removes an unnecessary check of the return value before calling
ufs_sec_submit() at the end of ufs_rpmb_route_frames(). All earlier error
paths return early, ensuring ret is zero at this point.

> diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
> index ffad049872b9a..55d0884dd4124 100644
> --- a/drivers/ufs/core/ufs-rpmb.c
> +++ b/drivers/ufs/core/ufs-rpmb.c
> @@ -115,11 +115,9 @@ static int ufs_rpmb_route_frames(struct device *dev,=
 u8 *req, unsigned int req_l
>  		}
>  	}
> =20
> -	if (!ret) {
> -		ret =3D ufs_sec_submit(hba, protocol_id, resp, resp_len, false);
> -		if (ret)
> -			dev_err(dev, "Response read failed with ret=3D%d\n", ret);
> -	}
> +	ret =3D ufs_sec_submit(hba, protocol_id, resp, resp_len, false);
> +	if (ret)
> +		dev_err(dev, "Response read failed with ret=3D%d\n", ret);
> =20
>  	return ret;
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but there is a device lifecycle
issue causing a reference cycle and use-after-free on device removal.

The ufs_rpmb structure is allocated via devm_kzalloc() in ufs_rpmb_probe():

drivers/ufs/core/ufs-rpmb.c:ufs_rpmb_probe() {
    ...
    ufs_rpmb =3D devm_kzalloc(hba->dev, sizeof(*ufs_rpmb), GFP_KERNEL);
    ...
}

Because the child RPMB device (rdev) natively holds a reference to its
parent device (ufs_rpmb->dev), unregistering the child in the parent's
release callback creates an unbreakable cycle:

drivers/ufs/core/ufs-rpmb.c:ufs_rpmb_device_release() {
    ...
    rpmb_dev_unregister(ufs_rpmb->rdev);
    ...
}

Since ufs_rpmb_remove() unregisters the parent without explicitly
unregistering the child device:

drivers/ufs/core/ufs-rpmb.c:ufs_rpmb_remove() {
    ...
    device_unregister(&ufs_rpmb->dev);
    ...
}

The parent's release callback will never execute because the child still
holds a reference to it.

Because ufs_rpmb is allocated with devm_kzalloc(), its memory is forcefully
freed when the host device unbinds. Does this leave the driver core and
still-registered child device holding dangling pointers to freed memory,
guaranteeing a use-after-free during driver unbind or module unload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618062752.492-=
1-ao.sun@transsion.com?part=3D1

