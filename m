Return-Path: <linux-scsi+bounces-24518-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BdOALf+CJGpi7gEAu9opvQ
	(envelope-from <linux-scsi+bounces-24518-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 06 Jun 2026 22:28:47 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D5964E3E3
	for <lists+linux-scsi@lfdr.de>; Sat, 06 Jun 2026 22:28:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="FuZuCF y";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24518-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24518-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 683A33028153
	for <lists+linux-scsi@lfdr.de>; Sat,  6 Jun 2026 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836E3CF1E7;
	Sat,  6 Jun 2026 20:27:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920827A462;
	Sat,  6 Jun 2026 20:27:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777645; cv=none; b=JXw2aDPGk11yvFXU89WgyB+P/L7UpZL4uqDBvllhOp3jgKnbzSoEga77TmgksGHF4FAgoSaVMiDTBUxF4qB4xdiBGJ9R9AdRz0elFmkiR2ibDM/9eXE2oH/ZZRGA1NCDnw9Fg5KlX8JEYgXTBP2MmM8y/bq6c8DTjJYBntZerew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777645; c=relaxed/simple;
	bh=IVTRybyENP9ZvsALHEwGvITCPJ14NH1hbJUa0q2kvWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avEfuNfMg5aY0TCJ0QzBIjO1klcDP3IGtwEKapuoPmvdWc8Y6OMqgPqg+SIM5mo4HptTlSsI0Z5Dn0VeoiFIhK7dkdTZOcTyUoNeXIFoQ1GtOTGEuq/piU9ZVLU6idO7Zx10hVzs4rNzgbiswwLJlyURhCaWlkAE2T3CehbBPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=FuZuCFy4; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbx-007cIS-Ca; Sat, 06 Jun 2026 22:27:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=jj4dGsDS5UDEhU/D7d8KdsG7GvNWgOpV73kbpJQir3I=; b=FuZuCF
	y4U64VXKIaVg6y4WFBp0CkWxEF0WqDEmIWAzGs2jJlUzpgWCJFLsoWl/adQY4M3lrliIVjgejIMxC
	g/KO3c4ysC0pgFKNhNNpFRCRLfoRvcnRawOxV4Mvsdij6zT9QPbLc4nUp/MZfCjIdZ15hEF04iyqc
	oproj8JVWUOC54gzFi7RetqU6nD3qy0/ig7x9JF4X8rasBTdP5b8wzZDOLDSf9zBJ9v0cFhEhxLID
	PWdmo+kqAygiUOsJaaXxt+eBK7B1dcL/Yt2ScJIp7Pp0XntQmz4gMFXHSjUum7fbyyAJJR3fLXvgP
	y2yhVHtfkZje/6rf1gs6LAw+LSvQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbw-0000uY-Pd; Sat, 06 Jun 2026 22:27:16 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbm-006V18-RJ;
	Sat, 06 Jun 2026 22:27:06 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/scsi/aic7xxx/aic7xxx_osm: Use kstrdup() instead of kmalloc() and strcpy()
Date: Sat,  6 Jun 2026 21:26:27 +0100
Message-Id: <20260606202633.5018-33-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-24518-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-scsi@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,HansenPartnership.com,oracle.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:hare@suse.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[runbox.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94D5964E3E3

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/scsi/aic7xxx/aic7xxx_osm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index d93b522695eb..d6237aa5beac 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -1101,12 +1101,10 @@ ahc_linux_register_host(struct ahc_softc *ahc, struct scsi_host_template *templa
 	ahc_lock(ahc, &s);
 	ahc_set_unit(ahc, ahc_linux_unit++);
 	ahc_unlock(ahc, &s);
-	sprintf(buf, "scsi%d", host->host_no);
-	new_name = kmalloc(strlen(buf) + 1, GFP_ATOMIC);
-	if (new_name != NULL) {
-		strcpy(new_name, buf);
+	snprintf(buf, sizeof (buf), "scsi%d", host->host_no);
+	new_name = kstrdup(buf, GFP_ATOMIC);
+	if (new_name != NULL)
 		ahc_set_name(ahc, new_name);
-	}
 	host->unique_id = ahc->unit;
 	ahc_linux_initialize_scsi_bus(ahc);
 	ahc_intr_enable(ahc, TRUE);
-- 
2.39.5


