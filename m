Return-Path: <linux-scsi+bounces-24620-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +cJQOxx6KGr5FAMAu9opvQ
	(envelope-from <linux-scsi+bounces-24620-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 22:39:57 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E36641D1
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 22:39:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Guo6QeO9;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24620-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24620-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F61C3041380
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jun 2026 20:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CECF372ED0;
	Tue,  9 Jun 2026 20:39:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736936897E
	for <linux-scsi@vger.kernel.org>; Tue,  9 Jun 2026 20:39:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037594; cv=none; b=tzaKBR7tzHZPcqGfHB0XqkJJMXTproe3ILlO4al98FoPJUsei8orPRtoR4MCtPkqCioq6cd3Hs2GHhSkAQHkw8Pa09kj2G9AGyj9MzeDdIre4J1O9siS6wTIyIRGKewJx8wRYxOfOIG8ZBRb608tljjm6cMeMdL8m+IZi6bMwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037594; c=relaxed/simple;
	bh=9JI8TRtInnh+DKvkTpV7l9UsbBEFr3aNllUqSvwG+yk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CNFnnpuG72pjZq82nlXJ8OF3GUe9ZdDCf8QiT0Fo/FAm3SKNEThYE7Tn4a1jR/3mQSaVwnksLHLcnw10i9RQRt3kwoQ0NdLS1sUybcpbPBnW33inx1Uu3JaJbG/AsbGfbrSCn35aqIeoSEF4xNgZYPDKUIHxiOxc15jthvqCM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guo6QeO9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154771F00898;
	Tue,  9 Jun 2026 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781037593;
	bh=6v+FtL9XR0j2xB2OlG+rLPdJAV8XwZE7tkMbm5Z4ULM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Guo6QeO98P0Zi35gdY1JyEqYKz0Zo6KXIXWLWlVfNTPr/Q2fCzebe9klcFW+dmFGy
	 15/zQl7NV3vwGlpJ9pj7eJZ0QvXPJWhJbo8fCzMDXjqkwqBgywvwDH7KWNvorE05uZ
	 XYGPTL8PxKQwX0N8CCI+1K+l2qX69hnNbJp2GnaP8OF2jipdI2gR+rosGyXXQTFeJL
	 GcDyuaToB+9TPmandZ4KHapMCPTIQJ4XJfHRWsf06VRailUKQgKwwzDdRaklUfXoaR
	 u+fPpcn6BkIBL/IYCfrWBaV3ShyxIjsa9BdI1M5wm38e2eCfjUI/UGjlhTYV+DPqW4
	 v0ndkCcdWmxLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] scsi: target: Allow FUA if no write cache enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stuart Hayes" <stuart.w.hayes@gmail.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260609202156.90700-1-stuart.w.hayes@gmail.com>
References: <20260609202156.90700-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 20:39:52 +0000
Message-Id: <20260609203953.154771F00898@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24620-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stuart.w.hayes@gmail.com,m:linux-scsi@vger.kernel.org,m:stuartwhayes@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B8E36641D1

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Silently dropping the FUA bit when WCE=3D0 prevents the backen=
d from honoring the FUA request, causing silent data loss in the fileio AIO=
 backend.
--

commit 5cb17faff566c1313276f5a67af675e43649d8d6
Author: Stuart Hayes <stuart.w.hayes@gmail.com>

scsi: target: Allow FUA if no write cache enabled

This commit modifies the target core code to ignore the FUA bit in SCSI
commands for targets without an enabled write cache. This allows systems
with firmware that aggressively sets the FUA bit to successfully boot
without failing due to unsupported FUA write errors.

> diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_cor=
e_sbc.c
> index 21f5cb86d70c0..ffd2b6c9bd231 100644
> --- a/drivers/target/target_core_sbc.c
> +++ b/drivers/target/target_core_sbc.c
> @@ -754,6 +754,12 @@ sbc_check_dpofua(struct se_device *dev, struct se_cm=
d *cmd, unsigned char *cdb)
>  	}
>  	if (cdb[1] & 0x8) {
>  		if (!target_check_fua(dev)) {
> +			/*
> +			 * Silently ignore FUA if there's no write cache.
> +			 */
> +			if (!target_check_wce(dev))
> +				return 0;
> +

[Severity: Critical]
Does returning early here prevent the command from receiving the SCF_FUA fl=
ag?

By returning 0, this bypasses the cmd->se_cmd_flags |=3D SCF_FUA; assignment
that happens further down in sbc_check_dpofua().

While WCE=3D0 implies no write cache, the fileio AIO backend relies entirely
on the SCF_FUA flag to ensure synchronous writes:

drivers/target/target_core_file.c:fd_execute_rw_aio() {
...
	aio_cmd->iocb.ki_flags =3D IOCB_DIRECT;

	if (is_write && (cmd->se_cmd_flags & SCF_FUA))
		aio_cmd->iocb.ki_flags |=3D IOCB_DSYNC;
...
}

Without the SCF_FUA flag, fd_execute_rw_aio() will issue asynchronous
writes without flushing the cache, as it ignores the O_DSYNC flag set on
the underlying file descriptor.

Could this regression lead to silent data loss on power failure, since
what used to be rejected as an unsupported FUA write will now complete
asynchronously without a disk cache flush?

>  			pr_err("Got CDB: 0x%02x with FUA bit set, but device"
>  			       " does not advertise support for FUA write\n",
>  			       cdb[0]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609202156.9070=
0-1-stuart.w.hayes@gmail.com?part=3D1

