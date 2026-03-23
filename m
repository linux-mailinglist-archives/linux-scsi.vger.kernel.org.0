Return-Path: <linux-scsi+bounces-22439-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCUTK0OjwWknUQQAu9opvQ
	(envelope-from <linux-scsi+bounces-22439-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 21:32:03 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B92FD4A0
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06D17301081C
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3143DEAD7;
	Mon, 23 Mar 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3Ide9p8t"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522653E1201
	for <linux-scsi@vger.kernel.org>; Mon, 23 Mar 2026 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297892; cv=none; b=FRAF9NNuSNTNBsmD8sp4l4LkwlaJJMmQ7icRiaiDapC+JXZAKjsbzETuXrfNsaPh4qf3tEdBQiXiyNEfXFkw5hzvUhnjHxwcuC2qH4Z1ZStZOCtkQIjufzb8WZBt1fWtK4Q1ualj+TfCwf4DKTEIEBuCaReKYtfUEcbFuLg1S2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297892; c=relaxed/simple;
	bh=tRhwh8mUrVabdxHEqWdfBZT1CrDf0Gh8/7yumGqL9Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjg7D0HL0KAw2q3fSiXBjb7W4L9BHWkZZC/bjk/XCwhsmsoIb6hGNnsC0qUAcDKEBV8V2HneSdEUMjs9ppWbT/2rarqEYXEZV6LeVJ3HzwFTsJauL3WgcYCu002v8EDzx7RwDiBOBqQXvtH/lZgQhERqqJ5lZtNQznMDTaTCKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3Ide9p8t; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fflFG6ZcSzlfddn;
	Mon, 23 Mar 2026 20:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1774297886; x=1776889887; bh=NGtAcygivo6M9R5Di4GVTFXGceblXjNRL9E
	EHECVPCc=; b=3Ide9p8t7DZdJDnCnmferYvjYTE07vwdjYIQlbzheckqJOzqUzJ
	nZIuYVUlaXa6FKHLIC9QGuUltVgFLy9mTx2/I6j2HMCTdAfDeARf4iibrr/GgrJ4
	Nvf93dqE08I1rPSDK8qI7mF7wo8r2z91xcpgnN1hrY14OuZQTWK7ngg2osX88I46
	O24XtOIX4BXyGamcTOYcwn/rLzBZmRuoDX8kC63cxYZK4JYJKy5p2njAx/7MG6sm
	uPX6yVLgV5Z/d8GNXcr/rgveALGCBIEJQ+eUWD4Rwv9qzfJ/uZVQNzzhie1Mas6X
	PaijuHJCc+ShtCn9w3YloPuqo/gmgis46Bg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JZmE_nlFR4qU; Mon, 23 Mar 2026 20:31:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fflF935F0zlfl6N;
	Mon, 23 Mar 2026 20:31:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] scsi_debug: Support configuring the maximum segment size
Date: Mon, 23 Mar 2026 13:31:16 -0700
Message-ID: <20260323203117.1248925-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22439-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Queue-Id: D08B92FD4A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a kernel module parameter for configuring the maximum segment size.
This patch enables testing SCSI support for segments smaller than the
page size. A test that uses this functionality is available here:
https://lore.kernel.org/linux-block/20260323200751.1238583-1-bvanassche@a=
cm.org/

Cc: John Garry <john.g.garry@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1515495fd9ea..641cc0e01dfc 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -915,6 +915,7 @@ static int sdebug_host_max_queue;	/* per host */
 static int sdebug_lowest_aligned =3D DEF_LOWEST_ALIGNED;
 static int sdebug_max_luns =3D DEF_MAX_LUNS;
 static int sdebug_max_queue =3D SDEBUG_CANQUEUE;	/* per submit queue */
+static unsigned int sdebug_max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
 static unsigned int sdebug_medium_error_start =3D OPT_MEDIUM_ERR_ADDR;
 static int sdebug_medium_error_count =3D OPT_MEDIUM_ERR_NUM;
 static int sdebug_ndelay =3D DEF_NDELAY;	/* if > 0 then unit is nanoseco=
nds */
@@ -7366,6 +7367,7 @@ module_param_named(lowest_aligned, sdebug_lowest_al=
igned, int, S_IRUGO);
 module_param_named(lun_format, sdebug_lun_am_i, int, S_IRUGO | S_IWUSR);
 module_param_named(max_luns, sdebug_max_luns, int, S_IRUGO | S_IWUSR);
 module_param_named(max_queue, sdebug_max_queue, int, S_IRUGO | S_IWUSR);
+module_param_named(max_segment_size, sdebug_max_segment_size, uint, S_IR=
UGO);
 module_param_named(medium_error_count, sdebug_medium_error_count, int,
 		   S_IRUGO | S_IWUSR);
 module_param_named(medium_error_start, sdebug_medium_error_start, int,
@@ -7449,6 +7451,7 @@ MODULE_PARM_DESC(lowest_aligned, "lowest aligned lb=
a (def=3D0)");
 MODULE_PARM_DESC(lun_format, "LUN format: 0->peripheral (def); 1 --> fla=
t address method");
 MODULE_PARM_DESC(max_luns, "number of LUNs per target to simulate(def=3D=
1)");
 MODULE_PARM_DESC(max_queue, "max number of queued commands (1 to max(def=
))");
+MODULE_PARM_DESC(max_segment_size, "max bytes in a single segment");
 MODULE_PARM_DESC(medium_error_count, "count of sectors to return follow =
on MEDIUM error");
 MODULE_PARM_DESC(medium_error_start, "starting sector number to return M=
EDIUM error");
 MODULE_PARM_DESC(ndelay, "response delay in nanoseconds (def=3D0 -> igno=
re)");
@@ -9566,6 +9569,7 @@ static int sdebug_driver_probe(struct device *dev)
 	}
 	hpnt->can_queue =3D sdebug_max_queue;
 	hpnt->cmd_per_lun =3D sdebug_max_queue;
+	hpnt->max_segment_size =3D sdebug_max_segment_size;
 	if (!sdebug_clustering)
 		hpnt->dma_boundary =3D PAGE_SIZE - 1;
=20

