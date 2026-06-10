Return-Path: <linux-scsi+bounces-24624-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kV8xHMXmKGrqMgMAu9opvQ
	(envelope-from <linux-scsi+bounces-24624-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 06:23:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B60E3665BAB
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 06:23:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=zd6eno473bd2bjsrzqfw7kbxfa.protonmail header.b=UfYsp6YR;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24624-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24624-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2867330B2963
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 04:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18536308F;
	Wed, 10 Jun 2026 04:23:07 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180135E1A6;
	Wed, 10 Jun 2026 04:22:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065385; cv=none; b=A2CMn901NDGV3ZwkfrFmwb5QTGogBFtKfQiqn/WPPxRVl6wsWSKxpkYdVaeRHkG69wICNU23SVqP/HoCfbZx3xShiOQFP2YyEiejS66u+2065wFwKShgSsiySe3wMGgZbZ7ufpDW0g/eqDLJdx83cXaxtDswrIXksbs+QeeYcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065385; c=relaxed/simple;
	bh=/UVTYB/ZBvreZU53WKmxraFYB/R5KvBFQBbJcRNY7e4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MMJ5rmKRFOc15+rXVrovhjHAkVbSAzpMD2+x4VbI16dFENKIKSUJezS8nmFpOFPk5vzqUZfaxbYwxQnddCIqHCyo6y0ZYe6hGuwLtXbuXJuYU2QBCFFNpHxAoxNG8M3jiI5YWHSpxs8wajL3HSpc48VIJANvpIRqKVjkY1f2PXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UfYsp6YR; arc=none smtp.client-ip=79.135.106.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=zd6eno473bd2bjsrzqfw7kbxfa.protonmail; t=1781065372; x=1781324572;
	bh=3VXcyUfZ//Z5hx8XQ5hETEE2NN3V0W/RaRJoZjuapAA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UfYsp6YRkFpG0tNi3PqaOS6hlgzQy9QTlwS/x0wxYeXnA3v9gdtCIlw5t7yTvpqJf
	 Ir6Ry5lZt8rEBgXBRYsR5iduLZHxe6gLo/cwM9SNrdBoAFUk5KbwGGyGADIBvCjPpn
	 6ZeH2P+RMaPA/I5RezS9MzQqLsnszTMh2/J6eqjSoMvNQewQG15J1pv5d8y3ItiTXn
	 5onEXhCDbIRoKqemBHR15ODGRM6HA1UHL/5soRoZDfcQvOI4AVAiLq+3QygpRSPyLs
	 Mo3LzOMUbdklsJbqSwaeHv3MKGGuhVfACYStvEer4ZgqYtJkUrbZNgblawS+7iXYBK
	 pm1HlV1sqocaw==
Date: Wed, 10 Jun 2026 04:22:48 +0000
To: "Martin K . Petersen" <martin.petersen@oracle.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Mike Christie <michael.christie@oracle.com>, Maurizio Lombardi <mlombard@redhat.com>, John Garry <john.g.garry@oracle.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, David Disseldorp <ddiss@suse.de>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] scsi: target: fix iSCSI ISID use-after-free in REGISTER AND MOVE
Message-ID: <20260610042245.35473-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: effe56cfd120fb8796ae5aa8ca17f126e398f9da
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=zd6eno473bd2bjsrzqfw7kbxfa.protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24624-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:michael.christie@oracle.com,m:mlombard@redhat.com,m:john.g.garry@oracle.com,m:James.Bottomley@HansenPartnership.com,m:ddiss@suse.de,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,proton.me:dkim,proton.me:email,proton.me:mid,proton.me:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B60E3665BAB

core_scsi3_emulate_pro_register_and_move() maps the PERSISTENT RESERVE OUT
parameter list with transport_kmap_data_sg() and parses the destination
TransportID with target_parse_pr_out_transport_id(). For an iSCSI
TransportID (FORMAT CODE 01b), iscsi_parse_pr_out_transport_id() returns
the ISID in iport_ptr as a raw pointer into that mapped buffer.

The function then unmaps the buffer with transport_kunmap_data_sg() before
dereferencing iport_ptr in strcmp(), __core_scsi3_locate_pr_reg() and
core_scsi3_alloc_registration(). When the parameter list spans more than
one page (PARAMETER LIST LENGTH > 4096), transport_kmap_data_sg() uses
vmap() and transport_kunmap_data_sg() does vunmap(), so the kernel virtual
address backing iport_ptr is torn down and every subsequent dereference is
a use-after-free read of the unmapped region.

Keep the parameter list mapped until iport_ptr is no longer needed: drop
the early transport_kunmap_data_sg() and unmap once on the success path,
right before returning. The error paths already unmap through the existing
"if (buf) transport_kunmap_data_sg(cmd)" at the out: label, which now runs
on every post-map error exit because buf is no longer cleared early. Only
reads of the mapping happen while spinlocks are held; the map and unmap
calls remain outside any lock. The sibling caller
core_scsi3_decode_spec_i_port() already uses the buffer before unmapping it
and is left unchanged.

Fixes: 4949314c7283 ("target: Allow control CDBs with data > 1 page")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v3 (review of v2 by John Garry and James Bottomley):
  - Drop the parser-ownership approach. Rather than copy the ISID into an
    allocation that both callers must kfree() (v2), keep the PR-OUT
    parameter list mapped across the iport_ptr dereferences and move the
    single unmap to the success path. No allocation, no kfree, and
    target_core_fabric_lib.c / core_scsi3_decode_spec_i_port() are
    unchanged. This is the form John Garry asked for ("keep the mapping in
    place for longer, until the out: label") and removes the multiple
    kfree() paths v2 added.
  - Re: holding the mapping while spinlocks are held (raised on v2): only
    reads of the mapping occur under dev_reservation_lock; the kmap/kunmap
    calls are all outside any lock, so there is no sleep-in-atomic concern.

v2: https://lore.kernel.org/linux-scsi/20260609005858.17504-1-hexlabsecurit=
y@proton.me/
v1: https://lore.kernel.org/linux-scsi/20260606015359.181724-1-hexlabsecuri=
ty@proton.me/

Class / impact: CWE-416 use-after-free (use-after-vunmap) in the LIO SCSI
target, reachable by an authenticated iSCSI initiator that is a current
Persistent Reservation registrant on the LUN. It sends PERSISTENT RESERVE
OUT / REGISTER AND MOVE with an iSCSI (FORMAT CODE 01b) TransportID and a
PARAMETER LIST LENGTH > 4096 so the parameter list spans >1 page and is
mapped with vmap(). After transport_kunmap_data_sg() vunmap()s that region,
the retained iport_ptr is dereferenced -> kernel read of an unmapped
vmalloc address (oops / DoS). Primarily a remotely reachable authenticated
denial of service. Present in all maintained trees since 4949314c7283
(v3.3, 2012), which introduced the multi-page vmap() path. Verified at
mainline v7.1-rc6 and stable v6.12.92.

Reproducer (authenticated iSCSI initiator, current PR reservation holder):
  1. PERSISTENT RESERVE OUT / REGISTER a key from the iSCSI nexus.
  2. PERSISTENT RESERVE OUT / REGISTER AND MOVE, FORMAT CODE 01b TransportI=
D
     (IQN + ",i,0x" + 12-char ISID), RELATIVE TARGET PORT IDENTIFIER of an
     existing target port, with PARAMETER LIST LENGTH =3D 8192 (two pages -=
>
     vmap()/vunmap()), the inner ADDITIONAL LENGTH set so tid_len + 24 =3D=
=3D
     data_length, the remainder zero padding.

A/B verification (CONFIG_KASAN_VMALLOC=3Dy, kasan.fault=3Dreport, x86-64,
6.12.90; same kernel for every arm; 64-bit and 32-bit initiator):
  - Without this patch (8192-byte, two-page request):
      BUG: KASAN: vmalloc-out-of-bounds in strcmp+0xa7/0xb0
        strcmp
        core_scsi3_emulate_pro_register_and_move [target_core]
        ? remove_vm_area
        target_scsi3_emulate_pr_out [target_core]
        __target_execute_cmd / iscsit_execute_cmd / iscsi_target_rx_thread
      followed by "unable to handle page fault" (PTE 0); the command never
      completes (the iSCSI rx kthread dies).
  - Control (128-byte, single-page request): no report (kunmap is a no-op
    on 64-bit !HIGHMEM, no vunmap).
  - With this patch (same 8192-byte request, 64-bit and 32-bit initiator):
    no report, the command completes.

 drivers/target/target_core_pr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_p=
r.c
index 11790f2c5d80..7c5bb7d67947 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -3293,9 +3293,6 @@ core_scsi3_emulate_pro_register_and_move(struct se_cm=
d *cmd, u64 res_key,
 =09=09goto out;
 =09}
=20
-=09transport_kunmap_data_sg(cmd);
-=09buf =3D NULL;
-
 =09pr_debug("SPC-3 PR [%s] Extracted initiator %s identifier: %s"
 =09=09" %s\n", dest_tf_ops->fabric_name, (iport_ptr !=3D NULL) ?
 =09=09"port" : "device", initiator_str, (iport_ptr !=3D NULL) ?
@@ -3532,6 +3529,11 @@ core_scsi3_emulate_pro_register_and_move(struct se_c=
md *cmd, u64 res_key,
 =09core_scsi3_update_and_write_aptpl(cmd->se_dev, aptpl);
=20
 =09core_scsi3_put_pr_reg(dest_pr_reg);
+=09/*
+=09 * iport_ptr aliases the PR-OUT parameter list mapped above, so the
+=09 * buffer is unmapped only here on success (and at out: on error).
+=09 */
+=09transport_kunmap_data_sg(cmd);
 =09return 0;
 out:
 =09if (buf)
--=20
2.43.0



