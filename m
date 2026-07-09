Return-Path: <linux-scsi+bounces-25922-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QlU/MepPT2rXeAIAu9opvQ
	(envelope-from <linux-scsi+bounces-25922-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 09:38:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6B272DD40
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 09:38:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q1RRQK1m;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25922-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25922-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D903A30A9995
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2026 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6EF3E4506;
	Thu,  9 Jul 2026 07:34:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6B3DBD47
	for <linux-scsi@vger.kernel.org>; Thu,  9 Jul 2026 07:34:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582468; cv=none; b=dyWD70qeqkD0U7x77XseKLQoKQ+WB62Qpi0BebJbdvUu9oE9EjEgoBTC/yKBbklh10e7u3XLukftStetw+Cz7Pgnq56hw7QESjU68JWg7dtd10khWzzppHoJ3M5ybd7rmo2Yp6aP7pAIKpr4GphxdqaHr5el7u5lTAskJhEMuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582468; c=relaxed/simple;
	bh=rwgFyLQh5+WchmsRWwXQ6aS+UN/7tpUwbS+w2PhGIwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HmEg2h1ua2zjXjyquxFNOb1U/QJe8GbPKg8XfQD3XmQcTZC6u1W7e2I8puA11Y69bqU/D3+QsC9jUT4fanh+F08eVnn9aAG0zgKXObbbUOO1E6x+6KuSMiWAWxP3+nDZiGXyBRgUWmX1Ju5etA+7C7l2/dukirQ1oKH6kCgkH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1RRQK1m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7021F000E9;
	Thu,  9 Jul 2026 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783582466;
	bh=v81P6njW7SZRZHup0gMswUG8C98oe4TxJbKdgVVs6mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1RRQK1mE6yD0cPyQZ+vTUXEofhhN8KB8ii+ghsMqgqpxw7LMaDJ8tXuIDt1ryM2q
	 QD68cdyMsfSiZI247SROaR8NzKF6H+svbuc9E/CSFNMjxhlh7vMXRtpgQxDRGmSVm/
	 +qJr0xmCRcg6rVq26lNyXr2UMwOZ4zMS+mztNDxbT/6DPHp6Amu3u/Gq17TFtE0Z4f
	 Igrl+Oh9GtbBySm8LiQpAoS/MwEtwnguRvQuwaYYGGeHBD2SLm5OELAdN/HxA8eb8I
	 6o5w+UPrvgXUa+dmsqF57rcjZ5WFWZnyG/Q/t8lBwAc4azjgEPBoeCuOIsSaqJtO4U
	 vdPUM6ezUh1RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] target/stat: implement scsiPortBusyStatuses counter
Reply-To: sashiko-reviews@lists.linux.dev
To: kensanya@163.com
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260709071805.769860-1-kensanya@163.com>
References: <20260709071805.769860-1-kensanya@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:34:25 +0000
Message-Id: <20260709073426.5E7021F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25922-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kensanya@163.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B6B272DD40

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] NULL pointer dereference in `ib_srpt.c` error path when handli=
ng a malformed SRP command.
--

--- Patch [1]: [PATCH v2] target/stat: implement scsiPortBusyStatuses count=
er ---
commit 7d5200afbb36f3291f84cfd7445e77cbcd9a96de
Author: TanZheng <tanzheng@kylinos.cn>

target/stat: implement scsiPortBusyStatuses counter

Implement RFC 4455 scsiPortBusyStatuses (ConfigFS busy_count) by adding a
per-CPU busy_statuses counter to scsi_port_stats, incrementing it when
the target sends SAM_STAT_BUSY, and summing all CPUs in the show handler.

> diff --git a/drivers/target/target_core_transport.c b/drivers/target/targ=
et_core_transport.c
> index fad03a15c969e..bab5ee81817b5 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
[ ... ]
> @@ -829,6 +829,20 @@ void transport_copy_sense_to_cmd(struct se_cmd *cmd,=
 unsigned char *sense)
>  }
>  EXPORT_SYMBOL(transport_copy_sense_to_cmd);
> =20
> +static int target_queue_status(struct se_cmd *cmd)
> +{
> +	int ret;
> +	struct se_lun *lun =3D cmd->se_lun;
> +	u8 scsi_status =3D cmd->scsi_status;
> +	u32 flags =3D cmd->se_cmd_flags;
> +
> +	ret =3D cmd->se_tfo->queue_status(cmd);

[Severity: Critical]
This is a pre-existing issue, but does this lead to a null pointer derefere=
nce
when handling a malformed SRP command in ib_srpt.c?

If an initiator sends an SRP command with a malformed descriptor table,
srpt_get_desc_tbl() fails, causing srpt_handle_cmd() to jump to the busy
label before target_init_cmd() has initialized cmd->se_tfo:

drivers/infiniband/ulp/srpt/ib_srpt.c:srpt_handle_cmd() {
	...
	rc =3D srpt_get_desc_tbl(...);
	if (rc) {
		...
		goto busy;
	}
	...
busy:
	target_send_busy(cmd);
}

This calls target_send_busy(), which calls target_queue_status() here,
unconditionally dereferencing cmd->se_tfo->queue_status(cmd) while
cmd->se_tfo is still zero-initialized.

Could a remote initiator trigger a denial of service by sending a malicious=
ly
crafted packet?

> +	if (!ret)
> +		target_stat_count_sent_status(lun, scsi_status, flags);
> +
> +	return ret;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709071805.7698=
60-1-kensanya@163.com?part=3D1

