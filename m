Return-Path: <linux-scsi+bounces-24571-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Am1nMKs5J2o5tgIAu9opvQ
	(envelope-from <linux-scsi+bounces-24571-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 23:52:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD1965AC73
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 23:52:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=philpem.me.uk header.s=mail header.b=HGMOtsNb;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24571-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24571-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=philpem.me.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 056D83019A3A
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jun 2026 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13003AFD04;
	Mon,  8 Jun 2026 21:52:03 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914C3AFCEA;
	Mon,  8 Jun 2026 21:52:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955523; cv=none; b=Su2seWd/88EpPrAuCwDQIWrHu2aDGt06JYv8S1IH8i9f4s5TqUhvk0Jd9z94OBFJXCCYVynBT0lMuoplsSWqjzd3njybqo+AkzS7kdbq+hsdAe7bD1rjbDPSJ9+oVfVzl4jsQrRPiyqDXSvLNEIurUBS724b0tCBly2LK8PSy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955523; c=relaxed/simple;
	bh=TvxDQEo20GxcEfBjGwo/dMBpT4kGWwqB2G0X2IUMJE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkpgCxNRYyP3bzbvQBa7RZfflKOaJ/XTO+ZuK7d/hsK3hE0PZ3uKqfSvyCvaP8M1ZOx06DwVa/oYdP7GE2kF9EJ1NYLCaXFhTneUZk60KzzuQphK82Lb6VuWIx7OERW5Rro9SAj7uRVn1TxapCWV6vdfZGtM0NWSpb18O3jY9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=HGMOtsNb; arc=none smtp.client-ip=178.62.38.78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1780954491;
	bh=TvxDQEo20GxcEfBjGwo/dMBpT4kGWwqB2G0X2IUMJE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGMOtsNbS4j07G+N6YVpuMXnlp6DcP5TRcVltvnzamlDfh6dkxV8EE+InSL6kls8q
	 7NjkFAAEWFEhjln0k/+eupdG7j/MaTh13O+2gtBzNiv0XkFnfKWeGeO+1xr0dOEP6Z
	 U+z7XkO1TVNr3GG7vIDQXuYS0TXQr6mPWFnYffVk=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 5A25ABE6EB;
	Mon,  8 Jun 2026 21:34:51 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 0266B5FC4B;
	Mon,  8 Jun 2026 22:34:51 +0100 (BST)
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
Subject: [PATCH v6 3/6] ata: libata-scsi: route non-zero LUN commands for multi-LUN ATAPI
Date: Mon,  8 Jun 2026 22:34:40 +0100
Message-ID: <20260608213443.2296614-4-philpem@philpem.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24571-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,philpem.me.uk:dkim,philpem.me.uk:email,philpem.me.uk:mid,philpem.me.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCD1965AC73

Two changes are required to route commands to ATAPI LUNs other than 0:

1. __ata_scsi_find_dev():  The existing code rejects any scsi_device
   with a non-zero LUN, returning NULL and dropping the command on
   the floor.  Hoist a non-zero LUN early-exit ahead of the original
   channel/id checks: when scsidev->lun is non-zero, allow it through
   only if the underlying ata_device is ATAPI class.  The original
   LUN-0 path is left structurally unchanged.

2. atapi_xlat():  Older ATAPI devices (SCSI-2 era) expect the LUN in
   CDB byte 1 bits 7:5 rather than relying on transport-level LUN
   addressing.  Encode scmd->device->lun into those bits, preserving
   the existing command-specific bits in 4:0.  This is required by
   both the Panasonic PD/CD combos and Nakamichi CD changers.

   The SCSI layer caps the LUN at shost->max_lun, so a value beyond
   the device's nr_luns should never reach this point; guard with
   WARN_ON_ONCE() and return AC_ERR_INVALID if it does, since the
   3-bit CDB field cannot represent it.

Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
---
 drivers/ata/libata-scsi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7c3d31dc49a1..2d714efc855f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2953,6 +2953,15 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	memset(qc->cdb, 0, dev->cdb_len);
 	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
 
+	/*
+	 * SCSI-2 CDB LUN encoding: bits 7:5 of byte 1 (3-bit field).
+	 * The SCSI layer caps the LUN at shost->max_lun (<= ATAPI_MAX_LUN),
+	 * so this should never trip; warn and reject if it does.
+	 */
+	if (WARN_ON_ONCE(scmd->device->lun >= dev->nr_luns))
+		return AC_ERR_INVALID;
+	qc->cdb[1] = (qc->cdb[1] & 0x1f) | ((u8)scmd->device->lun << 5);
+
 	qc->complete_fn = atapi_qc_complete;
 
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
@@ -3063,6 +3072,29 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
 {
 	int devno;
 
+	/*
+	 * Non-zero LUN is only legal for ATAPI devices, since they can
+	 * legitimately expose more than one LUN (PD/CD combos, CD changers).
+	 * Handle that case up front so the LUN-0 path below stays unchanged.
+	 */
+	if (unlikely(scsidev->lun)) {
+		struct ata_device *dev;
+
+		if (!sata_pmp_attached(ap)) {
+			if (unlikely(scsidev->channel))
+				return NULL;
+			devno = scsidev->id;
+		} else {
+			if (unlikely(scsidev->id))
+				return NULL;
+			devno = scsidev->channel;
+		}
+		dev = ata_find_dev(ap, devno);
+		if (!dev || dev->class != ATA_DEV_ATAPI)
+			return NULL;
+		return dev;
+	}
+
 	/* skip commands not addressed to targets we simulate */
 	if (!sata_pmp_attached(ap)) {
 		if (unlikely(scsidev->channel || scsidev->lun))
-- 
2.43.0


