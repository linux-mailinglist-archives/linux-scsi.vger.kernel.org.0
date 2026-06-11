Return-Path: <linux-scsi+bounces-24676-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t4APInkhKmpfjAMAu9opvQ
	(envelope-from <linux-scsi+bounces-24676-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 04:46:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D7866DDE8
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 04:46:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=philpem.me.uk header.s=mail header.b=RAHRTxmn;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24676-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24676-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=philpem.me.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DDDC31ABF39
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 02:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7E23290C9;
	Thu, 11 Jun 2026 02:44:07 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F9317145;
	Thu, 11 Jun 2026 02:44:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145847; cv=none; b=fRvp464/OJY+Tfw91sSIlYvCp/7w7hHIcc6/TqIVD9sqfYnu63qK60Zkr+JQZkD9sCG1cekx3tUuejzCpamU/K9BNMBneihGB6v5cM3dRB+cgj3fTapQWHAuKvRTympPhJ0p2Gau14ZxMXak4pzkHgI7tpSbo4UBxDpv5bfTZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145847; c=relaxed/simple;
	bh=Ohwei67EyyiLNbo47BimEV7g1a9XykkOtkEiQgxjyD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq0/QtNAtIy7kCXEGdEj0vC4yMpoM/N24Js2cf3DgN2Zj7pqkqsPsEJB31v21zUjZGNVBE3CJubZJP4dwgUw9dTBqtTqWsYvqCweSnoOHbekDLIHDPLcz8vbZyEHlHExpS8LGPuuEO9664mZDF/9Kt0wJq2qFbVo4qgT3xiLw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=RAHRTxmn; arc=none smtp.client-ip=178.62.38.78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1781145841;
	bh=Ohwei67EyyiLNbo47BimEV7g1a9XykkOtkEiQgxjyD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAHRTxmn67J9HlqHgki/Y7ezeoGymz7XEco5Wx2Xoj2UfH4KaojezBneRkRQngQNl
	 huqLM9SbdX9iK4oXKnsdIiN2jS9z1NiHuIT9APTq+4d2wUAsKve185MlCpDd3Jxjcn
	 3/Y6fL8Il1keuxxjPE9VdfqPGowGOKQfGEOzoogA=
Received: from wolf.philpem.me.uk (81-187-163-148.ip4.reverse-dns.uk [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id AA6ACBE526;
	Thu, 11 Jun 2026 02:44:01 +0000 (UTC)
Received: from cheetah.homenet.philpem.me.uk (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 51D235FC51;
	Thu, 11 Jun 2026 03:44:01 +0100 (BST)
From: Phil Pemberton <philpem@philpem.me.uk>
To: linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Phil Pemberton <philpem@philpem.me.uk>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v7 5/6] ata: libata-scsi: probe additional LUNs for multi-LUN ATAPI devices
Date: Thu, 11 Jun 2026 03:43:55 +0100
Message-ID: <20260611024356.2769320-6-philpem@philpem.me.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611024356.2769320-1-philpem@philpem.me.uk>
References: <20260611024356.2769320-1-philpem@philpem.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[philpem.me.uk:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24676-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dlemoal@kernel.org,m:cassel@kernel.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:hare@suse.de,m:philpem@philpem.me.uk,m:hare@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[philpem@philpem.me.uk,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philpem@philpem.me.uk,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[philpem.me.uk:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22D7866DDE8

After LUN 0 is added for an ATAPI device, check its BLIST_FORCELUN
flag.  If set, call scsi_scan_target() with SCAN_WILD_CARD to trigger
the SCSI layer's built-in sequential LUN scan for that target only.
This probes LUNs 1..shost->max_lun, driven by the libata atapi_max_lun
module parameter.

Devices without BLIST_FORCELUN (the vast majority of ATAPI devices)
are left with only LUN 0 -- no sequential scan is triggered, so
single-LUN devices like the iHAS124 DVD writer are completely
unaffected.

Non-responding LUNs (PQ=0/PDT=0x1f) are silently skipped by
scsi_probe_and_add_lun() when BLIST_NO_LUN_1F is set on the device
via scsi_devinfo.

Also fix a TOCTOU window: call ata_scsi_assign_ofnode() before
scsi_device_put() so the reference to dev->sdev[0] is held while
the OF node is assigned.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
---
 drivers/ata/libata-scsi.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 2e3b5fd41d05..64cb2860a67b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -26,6 +26,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_transport.h>
+#include <scsi/scsi_devinfo.h>
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <linux/uaccess.h>
@@ -4754,13 +4755,27 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 
 			sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
 						 NULL);
-			if (!IS_ERR(sdev)) {
-				dev->sdev[0] = sdev;
-				ata_scsi_assign_ofnode(dev, ap);
-				scsi_device_put(sdev);
-			} else {
+			if (IS_ERR(sdev)) {
 				dev->sdev[0] = NULL;
+				continue;
 			}
+
+			/*
+			 * For multi-LUN ATAPI (BLIST_FORCELUN), trigger a
+			 * sequential scan for this target.  pdt_1f_for_no_lun,
+			 * set during LUN 0 configure, ensures non-responding
+			 * LUNs are silently skipped; dev->sdev[] is populated
+			 * by ata_scsi_dev_config() during the scan.
+			 */
+			if (dev->class == ATA_DEV_ATAPI &&
+			    sdev->sdev_bflags & BLIST_FORCELUN &&
+			    !WARN_ON_ONCE(ap->scsi_host->max_lun > ATAPI_MAX_LUN))
+				scsi_scan_target(&ap->scsi_host->shost_gendev,
+						 channel, id, SCAN_WILD_CARD,
+						 SCSI_SCAN_RESCAN);
+			if (dev->sdev[0])
+				ata_scsi_assign_ofnode(dev, ap);
+			scsi_device_put(sdev);
 		}
 	}
 
-- 
2.43.0


