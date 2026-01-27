Return-Path: <linux-scsi+bounces-20583-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA9BJpz+eGmOuQEAu9opvQ
	(envelope-from <linux-scsi+bounces-20583-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Jan 2026 19:06:20 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF398C63
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Jan 2026 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF2A3077CE3
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Jan 2026 18:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEFE221540;
	Tue, 27 Jan 2026 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgxwNyo6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CD3254B1
	for <linux-scsi@vger.kernel.org>; Tue, 27 Jan 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537073; cv=none; b=C2Lyj3Ez1MmcDSbv/UunjWINE811K7Uf7jBs1HIynR7s+IkH0vDukzhx4ZwJmRAfyHJNJJZ0YRmrJjAgZZZNJPCaHs+GAkQxWho7aSMobU2OZXUsg7VgFU/nmYA+dAlNRVwFF4UN0jdFziFUBUMo0NCVnEGHmAg0pEkuAjbo/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537073; c=relaxed/simple;
	bh=ohmCt46wc/8rmgjncmDgWLXSNeCtgKAl4A61vlnKG+o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kwKtj8HfgNkA1xH0EJJWdrhIcGP90iJ/YlBITdVTtvSMFTa/KSrSvxRGk4cUmR50F3MZnuKY7vgY35t0k8q3sAiMG693vQ/sp4NXAqVh4NGx3A7xF4hVU9oXNZPYwvRC/kUoaD8TEX/0ih1bswIT+lC2rTvfbj72w+4e6/F0FOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgxwNyo6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769537071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gaYl+MTtxqWu+dnByqb8JL0UxFGExkG1q0r0rV/ciQ=;
	b=KgxwNyo6oZAkpdmbsS8IVnvfC6y4euFeKjofEIejJFNd64XH4qq/JKXjYL0BsMAjL3P+4s
	SQDfNbldOO34lPKNy2iE1ds4kxoMd/M/hmcBXb5oF4qfJ8SXySrbuLjiF+S+fs9aIqMCN4
	MzqH5zlm5YzD/G8pbxjNnSHeKFy0/f8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-7JWsdO2CO0COx48rOLQTJw-1; Tue,
 27 Jan 2026 13:04:29 -0500
X-MC-Unique: 7JWsdO2CO0COx48rOLQTJw-1
X-Mimecast-MFC-AGG-ID: 7JWsdO2CO0COx48rOLQTJw_1769537069
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D03DF18002C9
	for <linux-scsi@vger.kernel.org>; Tue, 27 Jan 2026 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.6.23.248])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D0F819560B4
	for <linux-scsi@vger.kernel.org>; Tue, 27 Jan 2026 18:04:28 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: sg: Add warning message in source code about non-idempotent SG_IO
Date: Tue, 27 Jan 2026 13:04:27 -0500
Message-ID: <20260127180427.471487-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20583-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NEQ_ENVFROM(0.00)[emilne@redhat.com,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDEF398C63
X-Rspamd-Action: no action

The SG_IO ioctl() is interruptible, and it is not obvious that
using it to send arbitrary commands that are non-idempotent can
resulted in failures or data corruption due to the syscall being
reissued.  Add a warning message in the source code of the function
to inform potential users of this pitfall.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/scsi/sg.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index b3af9b78fa12..40975f11e256 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -924,6 +924,17 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 
 	switch (cmd_in) {
 	case SG_IO:
+		/*
+		 * WARNING:
+		 *
+		 * This ioctl() uses an interruptible wait for I/O completion.
+		 * As a result, if it is interrupted by a signal (e.g. SIGSTOP)
+		 * the result will be discarded and the syscall will be retried.
+		 * Caution should be used with issuing commands that are not
+		 * idempotent (e.g. COMPARE AND WRITE, or commands to a sequential
+		 * media device such as a tape device) as this will likely not
+		 * have the desired behavior.  Data corruption could occur.
+		 */
 		if (atomic_read(&sdp->detaching))
 			return -ENODEV;
 		if (!scsi_block_when_processing_errors(sdp->device))
-- 
2.43.0


