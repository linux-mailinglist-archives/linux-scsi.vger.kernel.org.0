Return-Path: <linux-scsi+bounces-24532-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KuLfObiSJmrCYwIAu9opvQ
	(envelope-from <linux-scsi+bounces-24532-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 12:00:24 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D2654CE7
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 12:00:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="LVm8oY D";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24532-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24532-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACCA7300845A
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jun 2026 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7693CCFD8;
	Mon,  8 Jun 2026 09:55:55 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B233BA225
	for <linux-scsi@vger.kernel.org>; Mon,  8 Jun 2026 09:55:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912553; cv=none; b=aEGUptyq+XWibZzMFVscw9VtRXC53fGypR85sMjaTUg5/F6i3HCvZA1EJzWtB6QYjWyqS0b4R8OJSYfRH7Wd3DByQqZve4wcBOOngd1hdHxcsiWpe1PQ4UIJhg2iX53QU3cSxgJHBupMuSgl0N8cQC2J9S6+PmsCukW0LyC2Pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912553; c=relaxed/simple;
	bh=n4LIM2C9vgIqUuS7+5mN7lYtMCoBPZG1RqZJ1TbbNZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rhIU32PmUSqXIx5Fi3J47ps1GEPBMy/JSjOFPSyHIS1eXCvgD/9W+bhPfOAFeE1rMgqCt2jip1/KmR+eX/oZNmLXMrhq2CsdFAkCLu7TDA2wMlctCMH8xam+ADZPPTIoAKEl6ll/3mvM71xybKdZXYB3hzM6zHPZ0V9aQwqfMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=LVm8oYDg; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-00BrDu-Vh; Mon, 08 Jun 2026 11:55:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=usYY0fbAaxH4l0RSJSLe8L2lBIO3kdrjP5tiLhHTKK0=; b=LVm8oY
	Dg6iHWQ4zY/zfxN+EOF/TvKRwrHSmHYYHn0PkADyogBsIYgPXcuQbB+3UM/l4s3Tpn/65fv2hatzu
	Yn+dIT3LAXe1OhqQOjvT5Ae0/FsCLm+AaL+uq5WvafQSpdyGGoQmP7E8rXPRme4CkqJUtJwQ2Arjh
	HQP6V2FFtF9mMZXfU+ISK9EkSGCWvmOVpr57qn2LPmcPKnYbhK+B3J+WK9cU9T14yfxUmrHBHikoN
	q24VczA3RuXseM+bri02kdul7X/CqeG0q2hADIK24RcwZAS/uKZp1Un1fOSX+7hBqi5c3SipcJ9Yk
	ooB5Pat2hdesPM2efFd/OZXU5k4w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-0000Jm-Ly; Mon, 08 Jun 2026 11:55:44 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhb-00Ag6G-Qi;
	Mon, 08 Jun 2026 11:55:27 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/scsi/bfa/bfad_bsg: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:50 +0100
Message-Id: <20260608095523.2606-6-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-24532-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-scsi@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,qlogic.com,HansenPartnership.com,oracle.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:arnd@kernel.org,m:anil.gurumurthy@qlogic.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:sudarsana.kalluru@qlogic.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[runbox.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-scsi];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,runbox.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C87D2654CE7

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

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

 drivers/scsi/bfa/bfad_bsg.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index 292bc9aa43f1..e15bac14cf0f 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -92,12 +92,12 @@ bfad_iocmd_ioc_get_info(struct bfad_s *bfad, void *cmd)
 	iocmd->host = im_port->shost->host_no;
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
 
-	strcpy(iocmd->name, bfad->adapter_name);
-	strcpy(iocmd->port_name, bfad->port_name);
-	strcpy(iocmd->hwpath, bfad->pci_name);
+	strscpy(iocmd->name, bfad->adapter_name);
+	strscpy(iocmd->port_name, bfad->port_name);
+	strscpy(iocmd->hwpath, bfad->pci_name);
 
 	/* set adapter hw path */
-	strcpy(iocmd->adapter_hwpath, bfad->pci_name);
+	strscpy(iocmd->adapter_hwpath, bfad->pci_name);
 	for (i = 0; iocmd->adapter_hwpath[i] != ':' && i < BFA_STRING_32; i++)
 		;
 	for (; iocmd->adapter_hwpath[++i] != ':' && i < BFA_STRING_32; )
@@ -118,12 +118,11 @@ bfad_iocmd_ioc_get_attr(struct bfad_s *bfad, void *cmd)
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
 
 	/* fill in driver attr info */
-	strcpy(iocmd->ioc_attr.driver_attr.driver, BFAD_DRIVER_NAME);
-	strscpy(iocmd->ioc_attr.driver_attr.driver_ver,
-		BFAD_DRIVER_VERSION, BFA_VERSION_LEN);
-	strcpy(iocmd->ioc_attr.driver_attr.fw_ver,
+	strscpy(iocmd->ioc_attr.driver_attr.driver, BFAD_DRIVER_NAME);
+	strscpy(iocmd->ioc_attr.driver_attr.driver_ver, BFAD_DRIVER_VERSION);
+	strscpy(iocmd->ioc_attr.driver_attr.fw_ver,
 		iocmd->ioc_attr.adapter_attr.fw_ver);
-	strcpy(iocmd->ioc_attr.driver_attr.bios_ver,
+	strscpy(iocmd->ioc_attr.driver_attr.bios_ver,
 		iocmd->ioc_attr.adapter_attr.optrom_ver);
 
 	/* copy chip rev info first otherwise it will be overwritten */
@@ -200,9 +199,9 @@ bfad_iocmd_ioc_set_name(struct bfad_s *bfad, void *cmd, unsigned int v_cmd)
 	struct bfa_bsg_ioc_name_s *iocmd = (struct bfa_bsg_ioc_name_s *) cmd;
 
 	if (v_cmd == IOCMD_IOC_SET_ADAPTER_NAME)
-		strcpy(bfad->adapter_name, iocmd->name);
+		strscpy(bfad->adapter_name, iocmd->name);
 	else if (v_cmd == IOCMD_IOC_SET_PORT_NAME)
-		strcpy(bfad->port_name, iocmd->name);
+		strscpy(bfad->port_name, iocmd->name);
 
 	iocmd->status = BFA_STATUS_OK;
 	return 0;
-- 
2.39.5


