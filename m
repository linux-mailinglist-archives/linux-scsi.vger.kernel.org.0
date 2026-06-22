Return-Path: <linux-scsi+bounces-25108-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGT+OgzxOGqCkQcAu9opvQ
	(envelope-from <linux-scsi+bounces-25108-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 10:23:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF36ADAA6
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 10:23:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BEfFkuTA;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25108-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25108-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF16B3040965
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB2361657;
	Mon, 22 Jun 2026 08:15:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600123EA83
	for <linux-scsi@vger.kernel.org>; Mon, 22 Jun 2026 08:15:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116138; cv=none; b=Pf1FwimSV6n4oV9BVkDnGEFdRSIcmr+E5KH/Ub8QMdsQApMkn/KBZrSGVtuMRvvgSC9aeGgVfxB1PT4+EFJyJdBRDJtJv4Y90waNWeNYDMF7ephmiwQCTS8xaK6RcI9ks6lmxuLgVmQdtQMfdIoOchdcopMp2VA+6axWvd4taJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116138; c=relaxed/simple;
	bh=ufIAFG9KktyX8WzU2W3H31Y7Kd2vuurj9C4ErAdFgUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ockIppaWRJLI3DufZd2+MaIasaMJoH0Flj89WyapmS1dqi6MyibBRXhvkbO1nXoIfY8bXlHZW3kjTkSBFcZ4AzZtRs/LDs0oXzVGVlcwI8dUqfyKgWUFskP37hE9rPLJDji8kZkTh0cudtO9i4CYmRxjV0+6BmdES1mzQAlf4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEfFkuTA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5958D1F000E9;
	Mon, 22 Jun 2026 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782116136;
	bh=7U5+Y+zP9VkkKI+le4NbeqgMu/nnDDikAW0el5TXRfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEfFkuTA0wdFA1lVUbxFZhtH3O3BDAqUT3p8FfN0AMiKmAAnlYWYePV/ceHq3xXtV
	 yUDb7dSrOFaGR8G1XGHIQxP29lNI2X8JWWEjNjGImxf4h0PqO5071cuog+oGOwCPMQ
	 w+WQnuh+RIVL+aKEuN+DwsODb5f/HfljcL3F7GWn5xq+G3vwPuPjm5l5UZAYiPz+T8
	 +SVRrTTmUPXLHbIb6Y2qZHSIrZDfKdR+tap7PAhH/5GXfQeCRKlYw+rJlRjrhcCm3C
	 itv1YZWV7EfWME/+88sTviOxwmwnB9n/cPkAPvP660t8dzlue1wzTOkWjbjXWaF955
	 JCysDfnO2taQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] scsi: leapraid: Add driver documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dongdong Hao" <doubled@leap-io-kernel.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <56c38936ac64a3d37f04c85956008ea7c220fe8e.1782110784.git.doubled@leap-io-kernel.com>
References: <cover.1782110784.git.doubled@leap-io-kernel.com>
 <56c38936ac64a3d37f04c85956008ea7c220fe8e.1782110784.git.doubled@leap-io-kernel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:15:35 +0000
Message-Id: <20260622081536.5958D1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25108-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doubled@leap-io-kernel.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,leap-io-kernel.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5ACF36ADAA6

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Custom sysfs attributes introduced for standard SCSI/SAS feature=
s.
- [Medium] Kernel-space SMART polling thread violates separation of concern=
s.
- [Medium] Custom module parameters introduced for interrupt routing manage=
ment.
--

commit 60c41a7c6ea7e2df6e1711553263bb526e40d738
Author: Dongdong Hao <doubled@leap-io-kernel.com>

scsi: leapraid: Add driver documentation

This patch adds the necessary documentation for the LeapRAID SCSI driver
to the kernel's documentation tree.

> diff --git a/Documentation/scsi/leapraid.rst b/Documentation/scsi/leaprai=
d.rst
> new file mode 100644
> index 0000000000000..4067f07e64283
> --- /dev/null
> +++ b/Documentation/scsi/leapraid.rst
[ ... ]
> +LeapRAID specific host attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +::
> +
> +   /sys/class/scsi_host/host*/fw_queue_depth
> +   /sys/class/scsi_host/host*/host_sas_address
> +   /sys/class/scsi_host/host*/board_name
> +
> +The host "fw_queue_depth" read-only attribute shows the firmware queue
> +depth of the host.
> +
> +The host "host_sas_address" read-only attribute shows the SAS address
> +of the host.
> +
> +The host "board_name" read-only attribute shows the board name reported
> +by manufacturing page 0.
> +
> +LeapRAID specific disk attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +::
> +
> +   /sys/class/scsi_disk/host:bus:target:lun/device/sas_address
> +   /sys/class/scsi_disk/host:bus:target:lun/device/sas_device_handle
> +   /sys/class/scsi_disk/host:bus:target:lun/device/sas_ncq
> +
> +The disk "sas_address" read-only attribute shows the SAS address of the
> +disk.
> +
> +The read-only attribute "sas_device_handle" represents the disk's device
> +handle, which is a unique identifier maintained by the firmware.
> +
> +This attribute "sas_ncq" controls the Native Command Queuing (NCQ) featu=
re
> +for SATA devices. A value of 0 indicates that NCQ is currently disabled =
or
> +not supported. Writing 1 attempts to enable NCQ on the device. If the
> +operation succeeds, the value remains 1, indicating that NCQ has been
> +successfully enabled.

[Severity: Medium]
Should these features be exposed via custom driver-specific sysfs nodes rat=
her
than using standard kernel mechanisms?

In Linux, SAS topologies and addresses should generally be exposed via the
standard scsi_transport_sas class, and NCQ is typically managed through the
standard SCSI queue_depth interface. Introducing driver-specific sysfs node=
s for
standard capabilities creates UAPI fragmentation and breaks compatibility w=
ith
standard userspace tools.

[ ... ]
> +3. msix_disable
> +---------------
> +
> +This parameter specifies whether MSI-X interrupts should be disabled. By
> +default, 0 keeps MSI-X enabled, providing high-performance interrupt
> +handling. Setting this parameter to 1 disables MSI-X, causing the driver
> +to fall back to legacy INTx interrupts.
> +
> +4. max_msix_vectors
> +-------------------
> +
> +This parameter sets the upper limit on the number of MSI-X interrupt
> +vectors that the driver will request during initialization. The default
> +value of -1 allows the driver to use all available vectors as provided
> +by the device. Setting a positive integer restricts the number of vector=
s.
> +
> +5. interrupt_mode
> +-----------------
> +
> +This parameter defines which interrupt delivery mechanism is used by the
> +driver. A value of 0 selects MSI-X mode (default), providing the highest
> +performance and scalability. A value of 1 switches to MSI mode, while 2
> +forces the driver to use legacy INTx interrupts.

[Severity: Medium]
Is it appropriate to expose these low-level interrupt routing knobs to user=
s via
module parameters?

The Linux PCI core (pci_alloc_irq_vectors()) is designed to automatically h=
andle
vector allocation and gracefully fall back from MSI-X to MSI to INTx. If th=
ere
are hardware quirks or broken MSI-X implementations, shouldn't they be hand=
led
programmatically via standard PCI quirks rather than shifting the configura=
tion
burden to users?

[ ... ]
> +7. smart_poll
> +-------------
> +
> +This parameter controls the SMART polling mechanism for SATA drives. When
> +enabled (1), the driver periodically checks the health of connected SATA
> +devices, allowing early detection of potential drive failures. The defau=
lt
> +value is 0, which disables SMART polling.

[Severity: Medium]
Does this background SMART polling belong in the kernel driver?

SMART monitoring and health polling are typically userspace policy domains
handled by tools like smartd via standard ATA pass-through. Implementing th=
is in
the kernel duplicates userspace functionality, unnecessarily bloats the ker=
nel,
and could lead to concurrent ATA command collisions with standard monitoring
tools.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782110784.gi=
t.doubled@leap-io-kernel.com?part=3D2

