Return-Path: <linux-scsi+bounces-21949-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NSCG+Uts2ksSwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21949-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:19:33 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF2279EF0
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A1E8321047F
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33F3CAE78;
	Thu, 12 Mar 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Pu02H+a5"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8A3C660F
	for <linux-scsi@vger.kernel.org>; Thu, 12 Mar 2026 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350246; cv=none; b=hYSD7jMEIAL2elxQ1yvnppMfhx8G23Swmwz0IlydXU6UAUtKutPH9JSV5YjXSXw0DKSpb/CCCIU9vOd8Vdm05Rudw9VMkGvUZwyLhga8iAyitXIKzRkCOqfW3IHsnA54hGnF1UI2GzlUwx85BlKhYQhylsGonm24d6hiniEI81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350246; c=relaxed/simple;
	bh=TQzoojSyzxu8AlOCVL9o+EeOKJRppjk7PB2JeAbPhnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldNUrikdqSOrm99IOt+cg4uPDA+oM5vGDWjIOt2YnZUqxKbnv2pbBDho/BD5ppW++1df2LvjaztEH3q2+4O1FI+dSWvem0vaG3iNQhQtgIIAHNE/wXSBkDL6DS//5KrHOiBxf9pivgLhh+V1PE/yE1Awj5z1qubDSqZtVlWznYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Pu02H+a5; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fX0nK2RTYzlfl5V;
	Thu, 12 Mar 2026 21:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773350243; x=1775942244; bh=CziN9
	L6yRfPQVwmSywUDtrqwx600Rfe7Plh/c78zmsY=; b=Pu02H+a5ryejNfAmm4N9I
	ZpNbH0fWMXcEhLHrU6a9DUYOfOyT0En4JqmZwOJDQVcB+ujFL9DN2i/tHFjLamdy
	g42PIOLPwGCBg6s2UeYbrEbnyI0ZFVMegBoNrNgw7yqk3+D5zO747FQ/YLxS7x2b
	ci27pdSUdi7BHBb1BwIlCWTp4eR/Fnn00lurV6N5bO+SaT9jhKTrl4rxaTb9UaPw
	UuegPnAW/WfW4QszTwC8mvsT5HwKbjZTSwQpBW4wmdabb5iPh4/+Igewbl5AtjDO
	+6a0rlqk6zWCXLUpQCtEo0M8l2SluvSXSYYVyd4ripGdEVI2uLei0/Sz9f3XGJHJ
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Vos-Zy6h7Btu; Thu, 12 Mar 2026 21:17:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fX0nF4TxJzlfl8L;
	Thu, 12 Mar 2026 21:17:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Juergen E. Fischer" <fischer@norbit.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 09/36] scsi: aha152x: Prepare for enabling lock context analysis
Date: Thu, 12 Mar 2026 14:15:20 -0700
Message-ID: <20260312211636.3245119-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260312211636.3245119-1-bvanassche@acm.org>
References: <20260312211636.3245119-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21949-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 09EF2279EF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Annotate is_complete() with __no_context_analysis because it performs
conditional locking.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/aha152x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index e3ccb6bb62c0..ba0dc0e9b668 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -2319,6 +2319,7 @@ static void rsti_run(struct Scsi_Host *shpnt)
  *
  */
 static void is_complete(struct Scsi_Host *shpnt)
+	__no_context_analysis /* conditional locking */
 {
 	int dataphase;
 	unsigned long flags;

