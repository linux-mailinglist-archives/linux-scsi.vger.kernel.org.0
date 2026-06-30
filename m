Return-Path: <linux-scsi+bounces-25345-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MZcyAN1uQ2pvYQoAu9opvQ
	(envelope-from <linux-scsi+bounces-25345-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 09:23:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAC06E1177
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 09:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XLmBOoVr;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25345-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25345-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6DCB302269B
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFFA384CDC;
	Tue, 30 Jun 2026 07:19:37 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC9382F35
	for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 07:19:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803977; cv=none; b=HaY5DW6ZtKuRqtWFhI51dV9vIoUZUZ8MW25exawDk74SB8Cb4ElpfH0Ztppowgkzbs69BOkR6RmQpvJdndcEUrF4yJm6MjCh9x3l4gnL6rig9H56dmmc0tqrBAQHGdkt9tFqsN5xurYTMiHfGcWi//yWsaJAS+36IhejVrmIbjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803977; c=relaxed/simple;
	bh=6EK1xRgNk+RM6BEx8bbc26YBDjEyd2oNC6cMGcOoulY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KENb6mz0cnR16T9PQiGalUPCq9V6MR07fVMZzFTi2UuSLc1Hp8dcMuk2I4Got5YrEpydmW89yi5oUQtM3udA62L1im8wteFhQcXCqX92jhlE81tTXfo1kzVdORmqGtk9bB71I5OHBEVoNS0miJWyXy6VMV6mRQZlNGpkIFmaAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLmBOoVr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15C61F00A3A;
	Tue, 30 Jun 2026 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782803975;
	bh=fyWv7VVAdpPunVvgKXDheXxQgOrf6xDTEAH2tI0ZPuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLmBOoVr54DVhAEn+t2h5V8Gwx5uKbOrn4R+RUFJVBh1SWnjrAUhoTab/qFNhL26i
	 EgHtR2TOImzcyVPud8u1SRnOdrbPXTl+7qrhm0fCClCHdOO4VPdqb7++YyHR9dyCO/
	 2WjVCDe8FsgjQDoaIYVQLcQQKEvw+7SlEVuMUhVhxppLIujv06YtSBu1CHw+/n/58P
	 QLi6CMk3upsWCQ0vA6dUodNEuVMScAOpgGBs9TacRp/NQ2lbSSyml407hptsVhGL6H
	 3ydS8TAV5ncX3DDhyFBsjjmEkzlfkT1wQnF+V4V947ELyg6y9SQG9EADKuULasgSVq
	 tdmOLyiVQ8ioQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: libsas: fix HA resume deadlock and hisi_sas
 disk-wake race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xingui Yang" <yangxingui@huawei.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260630065157.421203-1-yangxingui@huawei.com>
References: <20260630065157.421203-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:19:34 +0000
Message-Id: <20260630071935.A15C61F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25345-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yangxingui@huawei.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,huawei.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EAC06E1177

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `flush_workqueue(hisi_hba->wq)` placement is ineffective, fail=
ing to prevent the autosuspend race for newly discovered PHYs.

Pre-existing issues:
- [High] PHY down events are silently dropped during resume because `HISI_S=
AS_RESETTING_BIT` remains set, permanently leaving libsas state out of sync.
--

commit ce8bc2a47295d4675bf4efa43c713662a8cd5696
Author: Xingui Yang <yangxingui@huawei.com>

scsi: libsas: fix HA resume deadlock and hisi_sas disk-wake race

This patch resolves a deadlock during HA resume by moving the
PHYE_RESUME_TIMEOUT notification to after sas_drain_work(). It restores
the draining sas_resume_ha() behavior in hisi_sas and introduces a
flush_workqueue() to prevent an autosuspend race.

> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_s=
as/hisi_sas_v3_hw.c
> index 213d5b5dea94f..901f508e8be77 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -5262,14 +5262,8 @@ static int _resume_v3_hw(struct device *device)
>  	}
>  	phys_init_v3_hw(hisi_hba);
> =20
> -	/*
> -	 * If a directly-attached disk is removed during suspend, a deadlock
> -	 * may occur, as the PHYE_RESUME_TIMEOUT processing will require the
> -	 * hisi_hba->device to be active, which can only happen when resume
> -	 * completes. So don't wait for the HA event workqueue to drain upon
> -	 * resume.
> -	 */
> -	sas_resume_ha_no_sync(sha);
> +	sas_resume_ha(sha);
> +	flush_workqueue(hisi_hba->wq);

[Severity: High]
Does this flush_workqueue() placement miss newly queued discovery events?

sas_resume_ha() drains the libsas event_q and disco_q. By flushing hisi_hba=
->wq
after this drain, any hisi_sas_phyup_pm_work items on hisi_hba->wq will que=
ue
PORTE_BYTES_DMAED events to event_q that bypass the drain.

Since hisi_sas_phyup_pm_work then calls pm_runtime_put_sync(), its PM refer=
ence
is dropped. When _resume_v3_hw() returns, the system PM reference is also
dropped, allowing the controller to autosuspend while the missed discovery
works execute asynchronously and attempt to send IO to a suspended controll=
er.

Should the flush be placed before sas_resume_ha() so the generated events a=
re
caught and synchronously processed by sas_drain_work()?

>  	clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);

[Severity: High]
This is a pre-existing issue, but are PHY down events silently dropped duri=
ng
resume because HISI_SAS_RESETTING_BIT remains set?

In _resume_v3_hw(), HISI_SAS_RESETTING_BIT is kept active across the
sas_resume_ha() call. If a PHY loses its link during this time, the hardware
interrupt handler drops the event:

drivers/scsi/hisi_sas/hisi_sas_main.c:hisi_sas_phy_down() {
		if (test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags) ||
		    phy->in_reset) {
			dev_info(dev, "ignore flutter phy%d down\n", phy_no);
			return;
		}
}

When HISI_SAS_RESETTING_BIT is finally cleared here, it does not call
hisi_sas_rescan_topology() to recover dropped events. Could this permanently
leave libsas state out of sync if a PHY disconnects during the resume wait?

> =20
>  	dev_warn(dev, "end of resuming controller\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630065157.4212=
03-1-yangxingui@huawei.com?part=3D1

