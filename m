Return-Path: <linux-scsi+bounces-25273-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vx1cIiw3PWrpzAgAu9opvQ
	(envelope-from <linux-scsi+bounces-25273-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 16:11:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 201506C6715
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 16:11:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Oby+VZKy;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25273-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25273-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57595305F99E
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD77E35AC32;
	Thu, 25 Jun 2026 14:08:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EEA3C09E7
	for <linux-scsi@vger.kernel.org>; Thu, 25 Jun 2026 14:08:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396506; cv=none; b=paDnXRkPu+HYc53csmd6hpSm8X7CSwzEsPdEHKV8NsRkaEt+bW4bUhBK0nKJf14XyZdoVN8jOwXZPCkkRYcyk+yCxnQnQGRwhj+dS0kGB3mWSLj5MKev1tM5uKtbGPIT6w3Vn3TROezTiMYIA8vsajHDMZ8zbHFpFYtY9UkDHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396506; c=relaxed/simple;
	bh=F2yftobYdkCIVsdzSG956gNyzRIsCZvP1vNLuoi+R9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F50Ojkz2TfZfgtprmptS72PzzxNBWJoe5VsYzDemaw/fP2JbGlmF3luk9CvSbhQSRisRdULfNlZ4cb0xB5VVnsiB//4eIrOUmnvWFvx0+Ms4cX8ZrePiYmCmQS02ByaFk15IbVpRCh02zbDSL2wxyA5U7XLRfszYRFjk4RSz/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oby+VZKy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299211F000E9;
	Thu, 25 Jun 2026 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396505;
	bh=uZjjxpd66+YkwtEBo3xBB+WDMpz+7/0FfXS/T5kJoHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oby+VZKyjDqYO05k8A8Rk5JMzXY6rt6eLmhslzFQKyTMl76JlLzA6YxdLEjF6IGyu
	 FTsdCsjdZjgX8ZmSF56KVBr30j43rD/DC7Is2fzXxsK0FjRqA5xTA7IQEXDI7dMZ12
	 BrYyjtaSmZoPOpidz/JYJCzHNdCpIE4MDnRa/wuAAdzxJ043Ji2kdK0eqj/d/3z0X5
	 EQQ0uMzKthHZWFdIHfvrTjdGMGoAIPOF7m93maru4ihhdd+swXAwpEjR8QW8siOe8S
	 NcUzKvoZcgEpNtQ3NLMwQeBVQC14HwZ67rCWhhartuVxVYKCCr3xFKu9FLUwTX0Zw2
	 CYUmIxXKK8DKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] scsi: 3w-xxxx: sanitize passthrough SGLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260625135746.1639-2-alhouseenyousef@gmail.com>
References: <20260625085842.4522-1-alhouseenyousef@gmail.com>
 <20260625135746.1639-2-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 14:08:24 +0000
Message-Id: <20260625140825.299211F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25273-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 201506C6715

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Physical DMA address leak to userspace via `TW_CMD_PACKET_WITH_DAT=
A` ioctl response.
--

commit f37c5fb0d6d5db87dd629b44ae0ac174cd9a5912
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

scsi: 3w-xxxx: sanitize passthrough SGLs

This patch updates TW_CMD_PACKET_WITH_DATA to clear SGL arrays, reject
unknown SGL offsets, and fix the command size. It also zeroes the ioctl
buffer before copying the request to prevent leaking stale memory on short
writes.

> diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
> --- a/drivers/scsi/3w-xxxx.c
> +++ b/drivers/scsi/3w-xxxx.c
[ ... ]
> @@ -966,17 +967,31 @@ static long tw_chrdev_ioctl(struct file *file, unsi=
gned int cmd, unsigned long a
>  			/* Load the sg list */
>  			switch (TW_SGL_OUT(tw_ioctl->firmware_command.opcode__sgloffset)) {
>  			case 2:
> +				memset(tw_ioctl->firmware_command.byte8.param.sgl, 0,
> +				       sizeof(tw_ioctl->firmware_command.byte8.param.sgl));
> +				tw_ioctl->firmware_command.size =3D 4;
>  				tw_ioctl->firmware_command.byte8.param.sgl[0].address =3D dma_handle=
 + sizeof(TW_New_Ioctl);

[Severity: High]
This is a pre-existing issue, but does this leak the physical DMA address
to userspace?

In tw_chrdev_ioctl(), the physical DMA address is written into the command
SGL here. After the device finishes processing the request, the driver
copies the command packet back into the firmware_command structure:

memcpy(&(tw_ioctl->firmware_command),=20
       tw_dev->command_packet_virtual_address[request_id],=20
       sizeof(TW_Command));

Finally, this buffer is copied back to user memory:

if (copy_to_user(argp, tw_ioctl, sizeof(TW_New_Ioctl) + data_buffer_length))

Since the structure still contains the kernel-injected physical DMA address,
could this help userspace map the physical memory structure or bypass
protections?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625085842.4522=
-1-alhouseenyousef@gmail.com?part=3D2

