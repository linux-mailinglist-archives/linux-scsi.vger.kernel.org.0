Return-Path: <linux-scsi+bounces-23685-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPYJE2rT+2lxFAAAu9opvQ
	(envelope-from <linux-scsi+bounces-23685-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 07 May 2026 01:48:58 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B94E19B0
	for <lists+linux-scsi@lfdr.de>; Thu, 07 May 2026 01:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B12793054338
	for <lists+linux-scsi@lfdr.de>; Wed,  6 May 2026 23:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1213DA5B9;
	Wed,  6 May 2026 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="gHOt6MzO"
X-Original-To: linux-scsi@vger.kernel.org
Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE33D565E;
	Wed,  6 May 2026 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111162; cv=none; b=uDwjMFUyfTFoVuAda/q2Mx/n1NsFonOAcjVvQWb1LuV74okd94+LwvlUblJT18xCsArnuWyHHazzgs8DU7N3DS+3PCm6b4rm03ud8ud3OxFOs2uxD1eSWng3kedkNYYRJkOXW9zn4tWCUVd+Mk7rsUOE6eh9M0Oo/F19hsT/8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111162; c=relaxed/simple;
	bh=NgI+BloTluXJ7eZWq4tfe6pWs03z++jaiAMs+De/a1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGUrT4AJRFHslAPnFB6prIVlzTBIFK2uNxnCx1gPgQ1TBattvkxo8A5+YyVHioemMnLNL/3B+HS3ZzmVZ35Ydk/kR4sjMKUlhm1R9nLOnN7tbnswzMlUb9HEA2U7ZCQ+Tq3QYfA7lQq6WKJ08mE+tOy5hiC9XeUbPJlDr6Shfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=gHOt6MzO; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1778111155;
	bh=NgI+BloTluXJ7eZWq4tfe6pWs03z++jaiAMs+De/a1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHOt6MzOnbZcGUUVJDWsQ9SLZQ5mhw3VjCV6DnCqzh0YN/kzu9gWNoWaSHxWujIS4
	 qNYd0gsvl7fJRtV07RHXGXfOWPR5jC4tRXEsSOGGckaB3ppA9E4uxdnC1CnZMJKgfW
	 UxXTAnOxUkxKJ+HdIVZYeZv3WjkkW8aMNyqS4jJo=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 8EF82BE5BA;
	Wed,  6 May 2026 23:45:55 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 4CC415FC56;
	Thu,  7 May 2026 00:45:55 +0100 (BST)
From: Phil Pemberton <philpem@philpem.me.uk>
To: linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Phil Pemberton <philpem@philpem.me.uk>
Subject: [PATCH v4 6/7] scsi: scsi_devinfo: add COMPAQ PD-1 multi-LUN ATAPI device quirk
Date: Thu,  7 May 2026 00:45:47 +0100
Message-ID: <20260506234548.1974603-7-philpem@philpem.me.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506234548.1974603-1-philpem@philpem.me.uk>
References: <20260506234548.1974603-1-philpem@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A85B94E19B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[philpem.me.uk,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[philpem.me.uk:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23685-lists,linux-scsi=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philpem@philpem.me.uk,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[philpem.me.uk:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The COMPAQ PD-1 (OEM Panasonic/Matsushita LF-1195C) is a PD/CD combo
drive that exposes two ATAPI LUNs: LUN 0 is a CD-ROM (TYPE_ROM),
LUN 1 is a 650 MB PD (TYPE_DISK).

Add it to the SCSI device list with:
  - BLIST_FORCELUN: tells the SCSI layer to scan past LUN 0
  - BLIST_SINGLELUN: serialises commands across the two LUNs, since
    the drive has a single transport and cannot handle concurrent
    operations on both
  - BLIST_NO_LUN_1F: the drive returns PQ=0/PDT=0x1f for unpopulated
    LUNs instead of PQ=3; this flag tells scsi_probe_and_add_lun()
    to silently skip them

The INQUIRY strings as reported by the device are:
  Vendor:  "COMPAQ  " (T10 format, space-padded)
  Product: "PD-1"

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
---
 drivers/scsi/scsi_devinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 68a992494b12..bfc2cbd43897 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -150,6 +150,8 @@ static struct {
 	{"COMPAQ", "MSA1000", NULL, BLIST_SPARSELUN | BLIST_NOSTARTONADD},
 	{"COMPAQ", "MSA1000 VOLUME", NULL, BLIST_SPARSELUN | BLIST_NOSTARTONADD},
 	{"COMPAQ", "HSV110", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
+	{"COMPAQ", "PD-1", NULL, BLIST_FORCELUN | BLIST_SINGLELUN |
+				 BLIST_NO_LUN_1F},
 	{"DDN", "SAN DataDirector", "*", BLIST_SPARSELUN},
 	{"DEC", "HSG80", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
 	{"DELL", "PV660F", NULL, BLIST_SPARSELUN},
-- 
2.43.0


