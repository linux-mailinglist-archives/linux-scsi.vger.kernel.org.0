Return-Path: <linux-scsi+bounces-22711-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGlLFhlxzmnxngYAu9opvQ
	(envelope-from <linux-scsi+bounces-22711-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Apr 2026 15:37:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B385C389D91
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Apr 2026 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1505530DB462
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Apr 2026 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA42F9D82;
	Thu,  2 Apr 2026 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielfernau.com header.i=@danielfernau.com header.b="GelOC/SL"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D430100D
	for <linux-scsi@vger.kernel.org>; Thu,  2 Apr 2026 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136358; cv=none; b=BxYP9DFMTJUusnHH0rPsRHUOJ1z2pZhgeSDiZfq6v2Mzk3SYJUuI+Vm933w3uRJ9H1dlz+GKO3bo/+OEuqZn1S6yJ5a9+k2P0f5c9SY9QcOVoa3xZBRV6EucBYWyZPb+ZmmRpjEzxUjCa5ez28e339hXVmJ61syTVcQAUNRdMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136358; c=relaxed/simple;
	bh=7AU+FKoONfTmb40hDy0wKxmE/m8Em6282YuFBtlwBss=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Hxo83bXmI24SjFbirdPvlo0x1Yd3lrG8lFdu3lOHNmH+iEIF7fBZJu8Ftr0d7J/9u+CahvHcw6vIr/Eo8DEUCaVm7JdC+GMA0s5p/dzaPHDBmcOKujQd8aMzjjFZvT4V6SkxD0Bl9Swhb2EzH/KeZMq47vhIvt0q6LAssTK9o94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=danielfernau.com; spf=pass smtp.mailfrom=danielfernau.com; dkim=pass (2048-bit key) header.d=danielfernau.com header.i=@danielfernau.com header.b=GelOC/SL; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=danielfernau.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielfernau.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielfernau.com;
	s=protonmail3; t=1775136353; x=1775395553;
	bh=7AU+FKoONfTmb40hDy0wKxmE/m8Em6282YuFBtlwBss=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GelOC/SLv4K/Wq/gx+6HMwF6lH0XNSD7bK0C0T2MSbD9zZSebLTkrDUV054cKzkEy
	 mww2KKSM+kYBAoRWe0fMKw4SJHh9nej2Pj0hUJgTQgmuMQ9hsVTcO/wmD1ERe3unQM
	 3qCSoeP120liPnBgbK1E4N9pLMTIq3H1cpsr9XigHWyWgX1rMxtZgRro2M3SuXUNhx
	 51mTI/GvQ/c5OvULrXrwSeWS61HhUho+mABeC4dEUFK2xYkIvqDGNvUCeKt/kszFl4
	 b5MegpjivS0FtEoxEAX2l16IMcnisj9qEnaGv5D8ICIByUNXk8gNh4Qd83fjY6bq5t
	 mg2onIrWCJS2A==
Date: Thu, 02 Apr 2026 13:25:47 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>
From: Daniel Fernau <mail@danielfernau.com>
Cc: me@magik.net, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, Chandrakanth patil <chandrakanth.patil@broadcom.com>, "megaraidlinux.pdl@broadcom.com" <megaraidlinux.pdl@broadcom.com>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH] scsi: megaraid_sas: fix PRP list out-of-bounds write
Message-ID: <0CFE3F49-179D-4735-86E2-B6C1EE2FDD2A@danielfernau.com>
Feedback-ID: 131378921:user:proton
X-Pm-Message-ID: 38d0655639a30ced2910d7fa174ed482641caf73
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_VnoCgvPB31RNdhK6S5U8UITsliC7PM0qQ7ugdRORc"
X-Spamd-Result: default: False [-1.06 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[danielfernau.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[danielfernau.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22711-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@danielfernau.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[danielfernau.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[magik.net:email,danielfernau.com:dkim,danielfernau.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leemhuis.info:email]
X-Rspamd-Queue-Id: B385C389D91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--b1=_VnoCgvPB31RNdhK6S5U8UITsliC7PM0qQ7ugdRORc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I tested this on an HPE MR416i-o Gen11 with 6.17.13-2-pve and can
reproduce the crash reliably with large direct-I/O through Ceph.

I also rebuilt and loaded the posted patched megaraid_sas module on that
system and verified that the patched module was actually in use after
reboot (module path, hash, srcversion, and vermagic all matched the test
build).

With the patch loaded, the crash still occurs for my reproducer, but the
failure mode appears to have changed.

Before the patch, I was hitting the PRP-list boundary condition, with
the driver logging:

=C2=A0 page boundary ptr_sgl: ...

and then faulting in the PRP construction path.

With the patch loaded, addr2line now resolves the fault into
megasas_make_prp_nvme() at the SG-advance path:

=C2=A0 megasas_make_prp_nvme()
=C2=A0 =C2=A0 drivers/scsi/megaraid/megaraid_sas_fusion.c:2271

which corresponds to:

=C2=A0 sg_scmd =3D sg_next(sg_scmd);
=C2=A0 sge_addr =3D sg_dma_address(sg_scmd);
=C2=A0 sge_len =3D sg_dma_len(sg_scmd);

The relevant disassembly also lines up with that sequence. So at least on
my hardware and workload, the current bounds-check patch is not
sufficient by itself. It looks like there is an additional unsafe path
when advancing to the next SG entry and dereferencing it.

In other words, the posted patch may address the PRP-frame boundary
write, but my reproducer still reaches another failure in
megasas_make_prp_nvme() afterwards.

I am going to investigate this further over the next few days, including
whether an additional guard is needed around sg_next() / sg_dma_address()
/ sg_dma_len() in the PRP builder, and I will report back with results.

For reference, this is on an HPE MR416i-o Gen11, and I can still
reproduce it with the patched module definitely loaded.


Best,
Daniel





> On Apr 1, 2026, at 9:02=E2=80=AFAM, Thorsten Leemhuis <regressions@leemhu=
is.info> wrote:
>=20
> On 3/27/26 04:20, me@magik.net wrote:
>=20
> > megasas_make_prp_nvme() builds NVMe PRP lists in cmd->sg_frame,
> > which is a DMA-pool allocation sized by instance->max_chain_frame_sz.
> > [...]
> > Before this patch, 6.19.10 crashed repeatedly during boot and normal
> > disk I/O. After applying it, the system boots cleanly and completes 4GB
> > direct-I/O reads without crashes.
> >=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lukasz Magiera <me@magik.net>
>=20
>=20
> You CCed the regression list, but this lacks a Fixes: tag, which makes
> me wonder: what change caused the problem? That tag would also help the
> stable team to see where this needs to be applied, so it most likely is
> needed.
>=20
>=20
> > [...]
>=20
>=20
> Ciao, Thorsten
--b1=_VnoCgvPB31RNdhK6S5U8UITsliC7PM0qQ7ugdRORc
Content-Type: application/pgp-keys; name="publickey - mail@danielfernau.com - 0x618592AD.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - mail@danielfernau.com - 0x618592AD.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWjRqZlloWUpLd1lCQkFI
YVJ3OEJBUWRBR1VmZEF2NVpDUEgxNHVVOFNhLzM2dFB1ZDVYOWdTNkYKckd6aTM3L01jRmJOTFcx
aGFXeEFaR0Z1YVdWc1ptVnlibUYxTG1OdmJTQThiV0ZwYkVCa1lXNXBaV3htClpYSnVZWFV1WTI5
dFBzTEFFUVFURmdvQWd3V0NaNGpmWWdNTENRY0prRThWYiszcXJNdVpSUlFBQUFBQQpBQndBSUhO
aGJIUkFibTkwWVhScGIyNXpMbTl3Wlc1d1ozQnFjeTV2Y21lS0RSZE9maFk1Mzl2UXA5aTIKYW9u
dlAwNGJPUER5bzZLQ2w5T0VqcUFPblFNVkNnZ0VGZ0FDQVFJWkFRS2JBd0llQVJZaEJHR0ZrcTBI
CjVFYkYxZ1pnUzA4VmIrM3FyTXVaQUFEclNnRUEvTlRjRTE3WWFYbE5qaXZMZ3lLME9XMitmN2dV
TDlsQwpKRkF5M3RwSVVPSUJBT0F0UkN6ejlhYW5PMU5aYWRpSHFLNDZLTGVINktjM3hIS0NQaWJD
ZVBVSnpqZ0UKWjRqZlloSUtLd1lCQkFHWFZRRUZBUUVIUU5WMkV6K2ZPbWJFUWx2SlJEM204VFI5
SlhyMHNibm1Md2ZDCnQzeEVBV0V0QXdFSUI4SytCQmdXQ2dCd0JZSm5pTjlpQ1pCUEZXL3Q2cXpM
bVVVVUFBQUFBQUFjQUNCegpZV3gwUUc1dmRHRjBhVzl1Y3k1dmNHVnVjR2R3YW5NdWIzSm5rVU5H
UkE4SzJTNWhoZnliTUI1VWlOZksKUER4a0N3dVZtY3VvbW4xU0lzY0Ntd3dXSVFSaGhaS3RCK1JH
eGRZR1lFdFBGVy90NnF6TG1RQUFnT1FBCi9pOUpGL3hPeEJVTHhjV2ozbG1PaDZLUUVkUFhkTnJm
aVkxNklmSUNDRG9HQVFDODdnOWYyUTUrY25rOAo5WjdETld3cUtWcGdSWExVVVE5KzBRdDBRMnAx
REE9PQo9aVhPbAotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==

--b1=_VnoCgvPB31RNdhK6S5U8UITsliC7PM0qQ7ugdRORc--


