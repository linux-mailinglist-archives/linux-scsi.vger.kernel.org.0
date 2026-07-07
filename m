Return-Path: <linux-scsi+bounces-25870-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3jFAO9AbTWrtvAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25870-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 17:31:28 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4753471D4C3
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 17:31:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kS7q9N37;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25870-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25870-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694643214679
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 15:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49637B02D;
	Tue,  7 Jul 2026 15:13:51 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593D13A3ED
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 15:13:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437231; cv=none; b=ZgGxuFlm32M96VjbTaq2Hfqg0zay2XZvSASMpLVbRM8myNTGEZ0XCKTT1bRp3pOhgyiX88ILJT6GyaOqS2T155PeODgJT7E2DlQafUbc5mZyngfhnLrbM7B0IBKf5tBvNnynLy2n6X+LvP07ucvH9WleJ7T6WZvjeDHq/b2k2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437231; c=relaxed/simple;
	bh=XgaQtR0zEhOxU+LUxU7nc6R+DsNex8WNVCypeAJAl60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scT5xUEWTI2pub98eXRYztQzf6SQ+TD/SnRYl3PMrP7CGWPtP3yYx8pu5QvD56HJFrvYmmpx2opMufZMoPr7G84wVioKQBerqJ7yXwhf2xFq5UX9vxxz+j3nJw7BZ35hYvNGAhX++QmP6zqvB8LhbNFzHaZgSdTv3jo6tIZ4Iys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS7q9N37; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cac59f8b64so51442935ad.0
        for <linux-scsi@vger.kernel.org>; Tue, 07 Jul 2026 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437230; x=1784042030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdfpnM3CA2QwImWOuD1el08v3VrLUrTzpOPnDM3A8bw=;
        b=kS7q9N37DtcA8O1vQtRmdN4BCPmVadtAxJ3AyWGdPyKeV89tMSKhBMb7pSC6UJBxLr
         hlo8BgML3N1nL6RchUX5Q7WZz2bobdN//405QcCxRuxhKPm2EFUuVZH5OLWde5lmyNUe
         ajJbdAAsnc/8ZN9+vgHV5pI7hc0mly5CzKa9CWSvdCiJfoNtRacAVbqWlI03Nox/hNIv
         ngliocSaZzwGhPaeccsRfjhwuiXN72RCwAhHk+cJHr7cuQ7cQBd3uAL2knOw22S6GIWT
         bTCNHF9BKE1YpUIqUx/srg6Urwv4A3pePIPlUjd7epix16vqOXX/oWOCfXvJ/x/2FRnc
         HwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437230; x=1784042030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdfpnM3CA2QwImWOuD1el08v3VrLUrTzpOPnDM3A8bw=;
        b=owQkjcVBfsI3ehQOkSmRYW8/crehcTQHzn0nQTXxa8sYHjuwBrLNSga/nWmUQRBd4O
         +yQPNhZjn9h5vboUgkU+j5/EfZLhRrKkZDmhXlDoRfBtxJcf5KuUiYrOO+vNUDuoRhJf
         OAJtcEVB2w9VfNPjjhdm5y59guyv9j848zwLFQ5SyVk7IKaBJ2+syTquwxNCbT0t7fCc
         FB9jX5/bWZbkGzQGUjcMtO2aOzTWn4fWH48Ew8w6mNwXutdqrwfTS/ZMwdAvQAHWY2ir
         vbZZAZmf31JlOSzmldtJzT89IP4Jom+OrqYS3Hf1HIpttcXSwI96xImVo8pzKz8p3cDP
         A06g==
X-Forwarded-Encrypted: i=1; AHgh+RolCsXjtYSVNLbIVZWhsM6dQvmvnSEpXtDt6uuG4YQZMIrWvi8p2N8a/1+XP8kW1tcXWNwTtIc7AHOP@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQu1nfKlrccNsH1lXJaOhM/20MLUGb5u+YoOHkcT85cExy/5w
	m5jfkdrGALomjzGscAtqB/+XcT4KHhMK31bOanU4r7BS+oaRbB0+4qRJiw1/eClA
X-Gm-Gg: AfdE7cluobIrkwvT24tgE5EHRtD5hzLYD6VGqDcw41/UXlXMrDi+oKIkz+R4wZHuDme
	58jRQuNatq1QAq50LAtuWBPAmbCuNWjmKqH0bJlmwERXqzMxzjtJquXY8KZfL7T1NVzO4+AkEOe
	Ge7V5ScpSUSNTum7QtbFpV7RahdiiB5TI3hwZP4+UFdDa2tqeP3HP5xogdu1xgq7VpxJ4AWd6SI
	4RR3Z0QZzucrYJCfpnIWlZLT2/RXKIgrHHbIBfwpLmcCy5YLgr0WDm/Km9z3MNblJ7xYi+8Uj9q
	jb39qSyMmdVNcKnYxmNGlGOCD5god5cix+j5tap1RlCR5aoNQ9zx/ooXlsw8UovU8ZFkbpjv6g1
	NUxAmhG6AOZgLd1Yezg6LlOJvlAXI0M3/9rvO7rw/3xW8iCB/IxBSQPUKrULEvuQElDYCd/A77g
	eavd3DlbXAkTJKnqAUQ0NoV3gGHThXAUCp
X-Received: by 2002:a17:903:160c:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ccbf05f204mr60422535ad.38.1783437230010;
        Tue, 07 Jul 2026 08:13:50 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:239e:a31b:1d0d:374f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdcbe2sm14127215ad.9.2026.07.07.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:13:49 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com
Cc: James.Bottomley@HansenPartnership.com,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] scsi: mptfusion: Avoid NULL alt_ioc reload in reset work
Date: Tue,  7 Jul 2026 23:13:43 +0800
Message-ID: <20260707151344.2335768-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,broadcom.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25870-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:James.Bottomley@HansenPartnership.com,m:MPT-FusionLinux.pdl@broadcom.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4753471D4C3

mpt_fault_reset_work() alternates delayed fault polling between bound IOC
ports by switching to ioc->alt_ioc before rearming the timer.

The peer pointer is cleared from detach and probe-error paths without
holding the task management lock used when the worker rearms itself. The
old code tested ioc->alt_ioc and then loaded it again for assignment. If
the peer clear lands between those loads, ioc becomes NULL and the
following spin_lock_irqsave(&ioc->taskmgmt_lock, flags) dereferences
NULL.

Take one READ_ONCE() snapshot and fall back to the current IOC when no
alternate is present. This preserves the existing alternating polling
behavior while removing the NULL reload window.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: d54d48b80fb5 ("[SCSI] mpt fusion : Adding FAULT Reset polling work")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/message/fusion/mptbase.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 3a431ffd3e2eb..29bcf44356d23 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -424,8 +424,7 @@ mpt_fault_reset_work(struct work_struct *work)
 	/*
 	 * Take turns polling alternate controller
 	 */
-	if (ioc->alt_ioc)
-		ioc = ioc->alt_ioc;
+	ioc = READ_ONCE(ioc->alt_ioc) ?: ioc;
 
 	/* rearm the timer */
 	spin_lock_irqsave(&ioc->taskmgmt_lock, flags);
-- 
2.51.0


