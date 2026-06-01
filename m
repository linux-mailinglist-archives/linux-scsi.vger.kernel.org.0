Return-Path: <linux-scsi+bounces-24327-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMt8EEShHWqncgkAu9opvQ
	(envelope-from <linux-scsi+bounces-24327-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 17:12:04 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A17621692
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B3A1301FE6B
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Jun 2026 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEBD3D905B;
	Mon,  1 Jun 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6GKp/dz"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642D3D9672;
	Mon,  1 Jun 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326606; cv=none; b=Xzg4WZvv+qg/QknwqgPXlRN/GWe5hS+zb4V4wMAFOJ/JdmhjTMY1bVcV5P+LJopzhmKAtwBtV0xUL9ozn/cgk6Kg/D6nVQQG4e8LeC4pkhvIG/FqRBDCReu2nHLfIFkYk7YYbwnCu0jSdCXjGT7iy4YB+iECyzUrUOqJeksNoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326606; c=relaxed/simple;
	bh=Qaj0RrUB7MeEP1B0GOhOYkFMIJHYElSdhOD4zbJy+z0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EUpxwcsCrWhbwSU6qT38vv42cOpvywHtnwB6T4fLwDxV3uhtfK8bWOvthLORvuol8vJlp73neNQbNlD2ATO6mR7ydIlo6AiL9/UMfh2nSoNYE6kpFcFthZplgQ3gMvZnJyt8Vj/yNK/QqZsaK4YsZK2xzhUSD1PQvR4SyiKcdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6GKp/dz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74AC1F00898;
	Mon,  1 Jun 2026 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326605;
	bh=CQQ3fHPI7z0+oYhhy2SS2++wUzwKs9NFKfTFjo35QFE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=H6GKp/dzqdK9ORxjj0B40gPyyI+Oji2zXc3Le5Sabsl/dFTi0wga5rdS2Kf9sYveJ
	 XADB9m10hTqyRD5XENfhigGHA6xbgGDk5NPtM7BRolacY8BQaIOlaU446uf7Dmi2zl
	 hmTmsBeVFgywVd9Y3U6r51xN20vw8Ze9xskMuxrAa47Xae4rrZ8vgH4MN2CEybz50K
	 t0WarlKSDJf6hW39j5PwA/N/G5xNTmutyB0YQ00tyPqnfT86uMY8B+GdTphTkwt7P2
	 LdEJxogDT4R4mCI3zNbccAbuKOvpgTUNEVxQ8s0MVQxcsYAv5scNpsLLfUgtDOeX68
	 YjwLO0KryJm/Q==
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 17:09:59 +0200
Message-Id: <DIXT3WV9XAWK.3E0JOPV2K6NC1@kernel.org>
Subject: Re: [PATCH v16 0/5] shut down devices asynchronously
Cc: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <linux-scsi@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <tatashin@google.com>, =?utf-8?q?Micha=C5=82_C=C5=82api=C5=84ski?=
 <mclapinski@google.com>, "Jordan Richards" <jordanrichards@google.com>,
 "Ewan Milne" <emilne@redhat.com>, "John Meneghini" <jmeneghi@redhat.com>,
 "Lombardi, Maurizio" <mlombard@redhat.com>, "Stuart Hayes"
 <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "Bjorn Helgaas" <helgaas@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, "John Garry"
 <john.g.garry@oracle.com>, <kexec@lists.infradead.org>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>
To: "David Jeffery" <djeffery@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260518193204.14273-1-djeffery@redhat.com>
In-Reply-To: <20260518193204.14273-1-djeffery@redhat.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24327-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linuxfoundation.org,kernel.org,google.com,redhat.com,gmail.com,acm.org,oracle.com,lists.infradead.org,HansenPartnership.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 43A17621692
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 18, 2026 at 9:31 PM CEST, David Jeffery wrote:
> These patches are now rebased against the driver-core tree's driver-core-=
next
> branch.

[...]

> Changes from V15:
>
> The async_shutdown bit field is converted to a device flags bit Convert a=
ll
> patches to use the flag bit accessor macros to set or check if async shut=
down
> should be used Added documentation on the kernel parameter to control use=
 of
> async shutdown

Did you have a look at the Sashiko report from v15 [1]? Some of the concern=
s
raised seem valid at a quick glance.

(It seems that this version has not been picked up by Sashiko (despite you
mentioning they are based on driver-core-next). I'd assume it doesn't like =
that
the series was not sent with '--base'.)

Can you have a look at [1] please?

Thanks,
Danilo

[1] https://sashiko.dev/#/patchset/20260429175016.7915-1-djeffery%40redhat.=
com

> Stuart Hayes (2):
>   driver core: separate function to shutdown one device
>   driver core: do not always lock parent in shutdown
>
> David Jeffery (3):
>   driver core: async device shutdown infrastructure
>   PCI: Enable async shutdown support
>   scsi: Enable async shutdown support

Not sure it will make it for 7.2, but I think it would be good to give this=
 some
more time in linux-next anyways.

Bjorn, James, Martin:

Should the PCI and scsi patch go through the driver-core tree too?

Do you prefer a signed tag with the driver-core changes to merge into the P=
CI
and scsi trees?

