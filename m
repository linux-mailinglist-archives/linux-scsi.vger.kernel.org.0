Return-Path: <linux-scsi+bounces-26009-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UBK0DhqxU2rCdgMAu9opvQ
	(envelope-from <linux-scsi+bounces-26009-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Jul 2026 17:22:02 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305A74523E
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Jul 2026 17:22:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lky0A0kq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26009-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26009-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D5583002904
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Jul 2026 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3C33F585;
	Sun, 12 Jul 2026 15:21:55 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C41233937;
	Sun, 12 Jul 2026 15:21:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783869715; cv=none; b=jii/T/KKHYBDfVv0g+6mMax75Bnhv6LE2dTfKocMF/+pIpB7DdfKabmNLx4ZmNctSil8t+PryuNnAkOqMY/tQO2i88xalE1NUmmtomJWovj8ZnDyOjtnAubUMbEuog9W2nR6N6FixNBfdkcPivjjk5RB/+JB3O2JwZ52eHRY5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783869715; c=relaxed/simple;
	bh=nmNKn8d8NL2MJuTkqQcDGPfhXnyRwEyvVGDq0rIntbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pAjPoVcoxtVp2MWhln6gch0Fd5zgFSz10KFVQbQmSVEX7aIrB6lVP2upI9k5HScGrHOZhub765Ekr8VKRvgtFtTlq2FxzLPTqb6F2zhRXk0rAytvpez/PEngz0+s95ol5T46T6+VzAkk/jtPq6UMAHasbG5CFXAPHwk4Awd2lnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lky0A0kq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565DF1F000E9;
	Sun, 12 Jul 2026 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783869713;
	bh=qWSMGfte5HRvvi5DpOJwL3QsCZIFyGpnLPEtSGY5lEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lky0A0kqLIt442M0ksxw0XTRy7sLVGM9DeK+tCR8VwvfjEwKdK2SWtjyswWtbSgJl
	 7xANlufk5NkFLMvLxvb/4JtOR+h7+n2dh2tQMSevOEEC0e/8hQm0s0jJxMyzkQFlcG
	 Cdc97mJxnFj/Ga7rx/OvJxnJX4LoGa5k1U+gJgmdqeKO8Z2EArmHZCc320fMU2lgGa
	 vb/uL+7YXD9eGd+AmPQHuo70stGcQPhPfb4GrwZKzjrD4g1SatXT2BfQ3ecKQhHNHc
	 fRHmQYG1gquVbCgPOGpx94ASOrpLmrnKYCCcD8dVwvAzQNkTcYzSXCYwlLF8jnMOp8
	 P1Pq8b0zqRFnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Replace pci_dev->is_busmaster with accessors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-scsi@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260711-pci-dev-flags-v1-1-2fcf2811138c@mailbox.org>
References: <20260711-pci-dev-flags-v1-0-2fcf2811138c@mailbox.org>
 <20260711-pci-dev-flags-v1-1-2fcf2811138c@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 15:21:52 +0000
Message-Id: <20260712152153.565DF1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-26009-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mhi@mailbox.org,m:linux-scsi@vger.kernel.org,m:ojeda@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mailbox.org:email,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2305A74523E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent read-modify-write of the hardware PCI_COMMAND register =
can lose updates.
--

--- Patch [1]: [PATCH 1/2] PCI: Replace pci_dev->is_busmaster with accessor=
s ---
commit ff1aee4bf47f9e69854d2a3ad6eea071a246ecb1
Author: Maurice Hieronymus <mhi@mailbox.org>

PCI: Replace pci_dev->is_busmaster with accessors

This commit moves the is_busmaster bit from a shared bitfield into a
new flags bitmap using atomic bitops. This prevents concurrent
read-modify-write cycles on the shared software bitfield, explicitly
enabling safe concurrent usage of pci_disable_device() and pci_set_master().

Link: https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@ker=
nel.org/ [1]

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..c4fd6fe6098d0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -2205,7 +2205,7 @@ void pci_disable_device(struct pci_dev *dev)
> =20
>  	do_pci_disable_device(dev);
> =20
> -	dev->is_busmaster =3D 0;
> +	pci_dev_assign_busmaster(dev, false);
>  }

[ ... ]

> @@ -4120,7 +4120,7 @@ static void __pci_set_master(struct pci_dev *dev, b=
ool enable)
>  			enable ? "enabling" : "disabling");
>  		pci_write_config_word(dev, PCI_COMMAND, cmd);
>  	}
> -	dev->is_busmaster =3D enable;
> +	pci_dev_assign_busmaster(dev, enable);
>  }

[Severity: High]
This is a pre-existing issue, but since the commit message notes that
pci_set_master() and pci_disable_device() can run concurrently to justify
this change, can those concurrent calls also lose updates to the hardware
PCI_COMMAND register?

In __pci_set_master(), there is an unprotected read-modify-write cycle on
the hardware register:

	pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
	if (enable)
		cmd =3D old_cmd | PCI_COMMAND_MASTER;
	else
		cmd =3D old_cmd & ~PCI_COMMAND_MASTER;
	if (cmd !=3D old_cmd) {
		pci_dbg(dev, "%s bus mastering\n",
			enable ? "enabling" : "disabling");
		pci_write_config_word(dev, PCI_COMMAND, cmd);
	}

Similarly, do_pci_disable_device() (called just before the change in
pci_disable_device() above) performs its own unprotected update:

	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
	if (pci_command & PCI_COMMAND_MASTER) {
		pci_command &=3D ~PCI_COMMAND_MASTER;
		pci_write_config_word(dev, PCI_COMMAND, pci_command);
	}

If a Rust guard object calls pci_disable_device() concurrently with
pci_set_master(), could we accidentally clear or set other critical flags
like PCI_COMMAND_INTX_DISABLE or PCI_COMMAND_MEMORY due to the hardware
read-modify-write race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-pci-dev-fl=
ags-v1-0-2fcf2811138c@mailbox.org?part=3D1

