Return-Path: <linux-scsi+bounces-24574-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ITXEcM6J2qOtgIAu9opvQ
	(envelope-from <linux-scsi+bounces-24574-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 23:57:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D74CD65AD0B
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 23:57:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=philpem.me.uk header.s=mail header.b=JxfUmSAd;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24574-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24574-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=philpem.me.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EACC8300C00F
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jun 2026 21:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317AE3AFD0C;
	Mon,  8 Jun 2026 21:57:05 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BFF3AFD16;
	Mon,  8 Jun 2026 21:57:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955824; cv=none; b=UPnjRJQWar1wQngD1+Fdxf+h8jsqbQyPehgQTpDbhtqzDqBS/kiy36VylUDQ1NQIdCtVZ3p6gr9onIfFtQhsvYWL5P1GlhHLBP5EmKE8L9xrSIt+CmZ73vGkWywt2fmhRcARiO9ithOjEWbiWP/jTmvcSSJ8OYP7kEh5gzuYrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955824; c=relaxed/simple;
	bh=x6f8CJNbI915EJ13DABGEvOBY0TFxfB2QN6TGIZA5KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOeE1bYqqGEuVLGr5RIJyetUP6G/zUOGEeNc/6kNwcSN2xvV9KcCJPwcHKwrtJvJ4zgv0SPwVkCh5wpxc8O9xOkki/iQOBjoskyTO6jXwLYNkjYkGxtvAdS/oPB1FwUblgmv7Rb512QHfz8OU4rMqZJWEUJTJwy+qPeRtFZya54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=JxfUmSAd; arc=none smtp.client-ip=178.62.38.78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1780954491;
	bh=x6f8CJNbI915EJ13DABGEvOBY0TFxfB2QN6TGIZA5KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxfUmSAdJyWchnn7m+sZfM3j1JVMxlLw+o3KSqvceKIOa34D8DNrqmELmvqKhOrgJ
	 sbIdFYXeeXe3VB4wqH93vnKvi1hUT9DWHHU+IUNr06z2Oie8tTT9m14qZqepPqgn3n
	 uzdJOF2fIl0Kj7cvXoO9hnYV6i9XAuQM8lIbfHPM=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 30069BD6EE;
	Mon,  8 Jun 2026 21:34:51 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id D793B5FC0F;
	Mon,  8 Jun 2026 22:34:50 +0100 (BST)
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
Subject: [PATCH v6 1/6] ata: libata-scsi: add atapi_max_lun module parameter
Date: Mon,  8 Jun 2026 22:34:38 +0100
Message-ID: <20260608213443.2296614-2-philpem@philpem.me.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608213443.2296614-1-philpem@philpem.me.uk>
References: <20260608213443.2296614-1-philpem@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[philpem.me.uk,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[philpem.me.uk:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24574-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dlemoal@kernel.org,m:cassel@kernel.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:hare@suse.de,m:philpem@philpem.me.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[philpem@philpem.me.uk,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[philpem@philpem.me.uk,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[philpem.me.uk:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,philpem.me.uk:dkim,philpem.me.uk:email,philpem.me.uk:mid,philpem.me.uk:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D74CD65AD0B

Until now libata has hard-coded shost->max_lun = 1 for every ATA host,
so the SCSI layer never scans past LUN 0.  This blocks support for
the small handful of multi-LUN ATAPI devices (Panasonic LF-1195C and
COMPAQ PD-1 PD/CD combos export CD on LUN 0 and PD on LUN 1; old
Nakamichi MJ-x.y CD changers expose one LUN per disc slot, up to 7).

Introduce a libata module parameter, atapi_max_lun, that controls the
upper bound of the per-host SCSI LUN scan.  Default is 1, preserving
current behaviour exactly: out-of-the-box only LUN 0 is scanned.
Range is clamped to 1..ATAPI_MAX_LUN (8, the SCSI-2 ceiling).

Subsequent patches gate actual LUN>0 probing on BLIST_FORCELUN, so a
device must both be on the SCSI device list (or carry the appropriate
quirk) and run on a host whose atapi_max_lun has been raised before
any extra LUNs are scanned.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
---
 drivers/ata/libata-core.c | 5 +++++
 drivers/ata/libata-scsi.c | 2 +-
 drivers/ata/libata.h      | 1 +
 include/linux/libata.h    | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e76d15411e2a..4408b1fb48c7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -122,6 +122,11 @@ int atapi_passthru16 = 1;
 module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
 
+int atapi_max_lun = 1;
+module_param(atapi_max_lun, int, 0444);
+MODULE_PARM_DESC(atapi_max_lun,
+	"Maximum LUN to scan on ATAPI devices flagged BLIST_FORCELUN (1 [default] .. 7)");
+
 int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
 MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f44612e269a4..32c6a0e497cf 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4627,7 +4627,7 @@ int ata_scsi_add_hosts(struct ata_host *host, const struct scsi_host_template *s
 		shost->transportt = &ata_scsi_transportt;
 		shost->unique_id = ap->print_id;
 		shost->max_id = 16;
-		shost->max_lun = 1;
+		shost->max_lun = clamp(atapi_max_lun, 1, ATAPI_MAX_LUN);
 		shost->max_channel = 1;
 		shost->max_cmd_len = 32;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index b5423b6e97de..96d804d02b99 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -33,6 +33,7 @@ enum {
 #define ATA_PORT_TYPE_NAME	"ata_port"
 
 extern int atapi_passthru16;
+extern int atapi_max_lun;
 extern int libata_fua;
 extern int libata_noacpi;
 extern int libata_allow_tpm;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5c085ef4eda7..3e33ee30628d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -131,6 +131,7 @@ enum {
 	ATA_SHORT_PAUSE		= 16,
 
 	ATAPI_MAX_DRAIN		= 16 << 10,
+	ATAPI_MAX_LUN		= 8,	/* SCSI-2 cap (LUN values 0..7) */
 
 	ATA_ALL_DEVICES		= (1 << ATA_MAX_DEVICES) - 1,
 
-- 
2.43.0


