Return-Path: <linux-scsi+bounces-25858-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NyC2M13bTGoArAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25858-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 12:56:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC3771AB03
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 12:56:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=U2yOpvqx;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25858-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25858-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3783300AB10
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F093F4138;
	Tue,  7 Jul 2026 10:56:27 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70D3AEF27
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 10:56:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421787; cv=none; b=eMVIucB9XJr00UI4tS813UZ8osWFSIH4Nd9N1Ff87GBd5VobnAksXg7O1yc/YAUvyf3N+O0bBVOkFY5ISSRtiVt5JHaMaTLdpguZ0lW+u1zyLgzEraGh6PaqZngCCNBbRuivMvWWkFX4Se3e92XTmWVoc9ojB9Gv1bB55kRrnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421787; c=relaxed/simple;
	bh=awhhvCgICifL1tQgcoJS/mW48fOurHuo99YkdBdLzk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGBp4MXI3s45QTGKUpnnUCeM+NE8tb9Soba11fEJSLSO4tzBQcXhF8PB8EMCy0Y5EHV1MxgDGQ1JHx8dmqfEq9Riv7S5E3M8vJVEIjVWPsUELOLJBNBqsu453mO3M3/ZcGW0PuPGJhKJDWGjo5hBYpEf/x1ONIr03Vhz8eFISk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U2yOpvqx; arc=none smtp.client-ip=95.215.58.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783421780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gWWEywfitziTG44pKsxejOLDxZopVxNIPtMFzDkT2Yo=;
	b=U2yOpvqxia6C/WW/Y37RzEXFYUFX07TIsRO6AmfYf17zAXu/PzbE51cdOFLvEIy1IoR8El
	CmG5advzta7pXPAAxFz0ZYnNqopJlpxdc+fx+br1Dm+Ir4hageAhSLtekkzVP6JDma2K7I
	LNDHnzHTX6XaUSBjXn4LLp+9hIWZJl0=
From: John Garry <john.garry@linux.dev>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: p.raghav@samsung.com,
	sw.prabhu6@gmail.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Garry <john.garry@linux.dev>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH] scsi: sd: fix error handling for sd_large_pool_create() call failure
Date: Tue,  7 Jul 2026 11:55:55 +0100
Message-ID: <20260707105555.1382237-1-john.garry@linux.dev>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25858-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[samsung.com,gmail.com,vger.kernel.org,linux.dev,oracle.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[john.garry@linux.dev,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:p.raghav@samsung.com,m:sw.prabhu6@gmail.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:john.garry@linux.dev,m:john.g.garry@oracle.com,m:swprabhu6@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.garry@linux.dev,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DC3771AB03

If the sd_probe() -> sd_large_pool_create() call fails, then we incorrectly
unwind the probe actions.

Currently for the sd_large_pool_create() failure we do no undo the
device_add() call.

Fix this by mimicking the handling of device_add_disk() failure, in calling
device_unregister() and put_disk(). The device_unregister() call will
result in scsi_disk_release() being called, which unwinds many actions in
sd_probe().

Fixes: 7179e626b76e ("scsi: sd: Enable sector size > PAGE_SIZE in SCSI sd driver")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I do wonder if it is simpler to always create this pool when we can
support LBS. We only create a min of two elements in the pool, so
hardly large.

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 599e75f33334..d18693d390b2 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4089,7 +4089,9 @@ static int sd_probe(struct scsi_device *sdp)
 	if (sdp->sector_size > PAGE_SIZE) {
 		if (sd_large_pool_create()) {
 			error = -ENOMEM;
-			goto out_free_index;
+			device_unregister(&sdkp->disk_dev);
+			put_disk(gd);
+			goto out;
 		}
 	}
 
-- 
2.43.0


