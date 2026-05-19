Return-Path: <linux-scsi+bounces-23922-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMc0BfPNDGqDmQUAu9opvQ
	(envelope-from <linux-scsi+bounces-23922-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 22:54:11 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9463584E88
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10900304DD88
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC63BFE4D;
	Tue, 19 May 2026 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jElXJuA4"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C42377017
	for <linux-scsi@vger.kernel.org>; Tue, 19 May 2026 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224048; cv=none; b=rdienHzVv1wm/lzNuXNQXZa+PR7bk8zlRqO2yR50FPP6ICGMkA6ZS/AKzp4YCF0lvPTG547SyFKeQ3aAphkUPHBHUbmJDvYCQOpqBZ41lUDpl29bbVY/rLDLm9EUV9LnM9SagNZjCGxEHVMvDKOaKPaSO7QKM3CxwIu8yh/kOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224048; c=relaxed/simple;
	bh=s4NtoFWlCyUyLtG00nr/O7UkVMYRrivR0MI8cZU58i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxvZuiJ4eTb/wPCAJkZctAL6ldZXWFx8gHom0qQ8sGxC53QqAOqd3t+AGfaCbeLr20uyM1hX/0zcniSEhX2It39a2ZVTuFO/pRrmmL54o1tTqq4mK30C/Gmp3VVRu0W24DYW3x+7bbknzMTanggH5/mFxYXZR4+K/CFmlkm/+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jElXJuA4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779224045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=il7d3I39XqqLs+mcA7JOomlpb692EKsIxQrV8zDr16Y=;
	b=jElXJuA4UWovCVtVy/aQOQPApdplcEikWAC92kfipnsc6WExOcAOcjIxP5Qxsn/GCthSBj
	fKYBIsTJM5lyKDTCB4rV9bk454srfiPRQBRtyb9Mr3KRBhhMLo8hdSrYD4n/2vmXGWZUJE
	0bgdhJy86MuUHHBhnCKtBYlGDw7PSBY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-6wmWlepxNWygUf6G9ZhR4A-1; Tue,
 19 May 2026 16:54:04 -0400
X-MC-Unique: 6wmWlepxNWygUf6G9ZhR4A-1
X-Mimecast-MFC-AGG-ID: 6wmWlepxNWygUf6G9ZhR4A_1779224043
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33192195605F;
	Tue, 19 May 2026 20:54:03 +0000 (UTC)
Received: from emilne-na.ibmlowe.csb (unknown [10.17.17.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E52D19560A2;
	Tue, 19 May 2026 20:53:57 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: john.g.garry@oracle.com
Subject: [PATCH] scsi: scsi_debug: Missing "\n" in sdev_printk() in scsi_debug_device_reset()
Date: Tue, 19 May 2026 16:53:56 -0400
Message-ID: <20260519205356.1040855-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23922-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[emilne@redhat.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A9463584E88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A "\n" at the end of the sdev_printk() string appears to have been
inadvertently removed.  Add it back for correct log message formatting.

Fixes: a743b120227a ("scsi: scsi_debug: Stop printing extra function name in debug logs")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1515495fd9ea..040c5e1e713a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6953,7 +6953,7 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 	++num_dev_resets;
 
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
-		sdev_printk(KERN_INFO, sdp, "doing device reset");
+		sdev_printk(KERN_INFO, sdp, "doing device reset\n");
 
 	scsi_debug_stop_all_queued(sdp);
 	if (devip) {
-- 
2.52.0


