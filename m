Return-Path: <linux-scsi+bounces-25902-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5+/PLsWbTmpNQgIAu9opvQ
	(envelope-from <linux-scsi+bounces-25902-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 20:49:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0739729B2E
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 20:49:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=bP5v3t0W;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25902-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25902-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE9C73053F06
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jul 2026 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6EA4D8D91;
	Wed,  8 Jul 2026 18:40:50 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15BE4C955D
	for <linux-scsi@vger.kernel.org>; Wed,  8 Jul 2026 18:40:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536050; cv=none; b=fmFGSyuNHz7y9c9hGZ8Y6qlTqEDosErxKR81RnxI60ggV3jYipcDy8NJoyR09IuuHTn1fBE3ksqDNY7Fia8EoOhy3nJ6zbkPIV01b7bz9WDC/idFJCWSWbooHLrYYlKrLzEsXulhnCoeKiBcph5EOJalJj5IEQ3IAwiPeMcAcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536050; c=relaxed/simple;
	bh=yyvYgSBOdUFBI8R65E42fYPCb9lbaY1keNsoIAV0lKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9G9LZGOjO2zZXWM/oU7E7sUUPRqfWQVHSgU7uBB0s7s9aPpilN+IxeQ1pxcnjKK3tRjhpDjarmE5ewcO+piFOm493JD6zmfGbWd/q3uX0KDTW7cM3zaFAjXq3Ex8D+lp+u3HkLk3NHbX+Dk/mg4QocdB7BHRERsDSJfKI5ILMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bP5v3t0W; arc=none smtp.client-ip=209.85.160.227
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-51c0ecfaee7so6063131cf.0
        for <linux-scsi@vger.kernel.org>; Wed, 08 Jul 2026 11:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783536047; x=1784140847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s42jLCXfMOvB6l1OVeyw6JzKtdDHabduMHs9R1/vORU=;
        b=MPmvxzcXN59Fpvhc3Xjrx1KoiRj6B2c/WhJE4s+tCWP9wYDaTs1DJmTocfnt6EftLC
         VXOwh4lqCrfDdhamivIPtv8yjlZwL/1+IA8H1rRjafXuPHb37JtVeOOpsR6RBVZ/CktS
         k8Q0AhjSMgifLM9DMvJykjIzc0RKK1pdSmCbChKYrLaSAr+o5VlGeV94rHSvT2VVNxlH
         urwJS2JyxGXmarjpEE+fLR2+eCmHvx/3Vsd3MYBtXQuW9CXXBK03lbVZcVvrPhLMjsa4
         WozP+yOIa/1aHSiFqPD01HiGLNse2VGrEwWfoRvcM+iiP6fbG9ha1WdZMWo16jO70NGY
         Cx3w==
X-Gm-Message-State: AOJu0YyNiLbntl6kH9xEM4LrhujQj9KYqnftvv647hT2gGgZwansfIv6
	KrLD6SnhgQXWxj11Y/OsO0ExAy2IkI4IhEJ6WG4uOsmfjCysMq13f+7oCvmCfiWnsmyyVinzbVX
	Jq2pWlgje5emWeNCPxJxAAU1za387JUMNmUroXpsHJlGWXb0PSEsXadxP6R0mKqwsJLW0Z2PjQR
	/S0wZZQ0+b3dF1GTcv49s3JAdKV0fCfyDB6di+ZSb+3dAaIgxN7v4yQDIFRAOEa72LICdEYUXNF
	7tSxr0dy7rRb2FQ
X-Gm-Gg: AfdE7ckrKabbbVWZ8b7hXv8ASmQw7VmgeDZp8iXJAvqNBkWn8ueR+HmlTBWL1XvGp5E
	xuZpaAeF2YdhIAo38AxYl9StgofZp7gEYBQGl03z5aTiV+HOk4KA+FmBtHYjZytEXRiZNP6N4IF
	RGHjMMD9mh4q6m7SJW+G0KJ5LumEyZNNFld/eVZM9Ck00rNQ2BcbPnd8fsXbUrTx+J/CAcaBdoe
	8LMAkmFOT+Q8kVfb33vKPlDxcGdkJn7BkR0XQUc4BeuOtWtZ7gWNIekgaaK9YS5nQfdcYPHwecV
	jjhcoiVj7sejYK99ed3Q+rAsykb4FJdph4792C29QW/53G83E7Brb6Jx9o7Lh19C8V4Df2TOvH/
	DjKo8p6Zyewy9JaMaJ/6uG7YVLfqdT80ouW6BssOptmtDd2tbZ41j8KYV2B+hUr1bVR3W2JHtUa
	BA1Iin4xjukuxty1onu5ctiMTm6l7EZjTDr73e+uiNq+QD4w==
X-Received: by 2002:ac8:574d:0:b0:51a:8c97:9387 with SMTP id d75a77b69052e-51c8b565510mr38356491cf.62.1783536047361;
        Wed, 08 Jul 2026 11:40:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51c41cb32a4sm8834881cf.15.2026.07.08.11.40.47
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2026 11:40:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so911873a12.3
        for <linux-scsi@vger.kernel.org>; Wed, 08 Jul 2026 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783536046; x=1784140846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s42jLCXfMOvB6l1OVeyw6JzKtdDHabduMHs9R1/vORU=;
        b=bP5v3t0WGgszuDgkjqyMjl9567cAjNNKo/UdutsA2VMQ/0IUVJ79qfKUxnxjEdRpew
         KBrFcF4IKgga+9hZ2yNWnX5KZi9dK5RyasmTq6/TjV/4b1AnLwIKOU0jpLqgkdZnorGi
         R5SD3BvEiZ5WuMdJ1Oh7bBhgFXAjUy9K2t3/s=
X-Received: by 2002:a05:6a20:9595:b0:3c0:9c19:65ac with SMTP id adf61e73a8af0-3c0bd3799cbmr4584447637.68.1783536046156;
        Wed, 08 Jul 2026 11:40:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:9595:b0:3c0:9c19:65ac with SMTP id adf61e73a8af0-3c0bd3799cbmr4584415637.68.1783536045478;
        Wed, 08 Jul 2026 11:40:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm19820599eec.18.2026.07.08.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:40:44 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: sathya.prakash@broadcom.com,
	chandrakanth.patil@broadcom.com,
	vishakhavc@google.com,
	ipylypiv@google.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 07/10] mpi3mr: Fix firmware event reference leak during cleanup
Date: Thu,  9 Jul 2026 00:03:02 +0530
Message-ID: <20260708183305.244485-8-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708183305.244485-1-ranjan.kumar@broadcom.com>
References: <20260708183305.244485-1-ranjan.kumar@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sashiko.dev:server fail,sin.lore.kernel.org:server fail,broadcom.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25902-lists,linux-scsi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER(0.00)[ranjan.kumar@broadcom.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:sathya.prakash@broadcom.com,m:chandrakanth.patil@broadcom.com,m:vishakhavc@google.com,m:ipylypiv@google.com,m:ranjan.kumar@broadcom.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0739729B2E

During firmware event cleanup, when an event is currently executing or
pending at the SCSI mid-layer, the driver sets a discard flag and exits
the cleanup routine early. This early exit skips the normal cancel path,
resulting in the firmware event reference count not being decremented,
leading to a reference leak.

Additionally, the cleanup routine performed a lockless read of
mrioc->current_event. This created a Time-of-Check to Time-of-Use
(TOCTOU) race condition where the firmware event worker thread could
free the event before the cleanup routine finished accessing it,
potentially leading to a Use-After-Free panic.

Fix these issues by:
1. Safely acquiring a reference to current_event under the fwevt_lock
   to prevent the TOCTOU race and ensure the event is not freed
   prematurely.
2. Releasing the acquired firmware event reference before returning
   from both the early-exit path and the normal cancel path.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260626114109.43685-1-ranjan.kumar@broadcom.com?part=7
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index df7365d19b44..273512ab25ba 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -379,6 +379,7 @@ static void mpi3mr_cancel_work(struct mpi3mr_fwevt *fwevt)
 void mpi3mr_cleanup_fwevt_list(struct mpi3mr_ioc *mrioc)
 {
 	struct mpi3mr_fwevt *fwevt = NULL;
+	unsigned long flags;
 
 	if ((list_empty(&mrioc->fwevt_list) && !mrioc->current_event) ||
 	    !mrioc->fwevt_worker_thread)
@@ -387,8 +388,17 @@ void mpi3mr_cleanup_fwevt_list(struct mpi3mr_ioc *mrioc)
 	while ((fwevt = mpi3mr_dequeue_fwevt(mrioc)))
 		mpi3mr_cancel_work(fwevt);
 
-	if (mrioc->current_event) {
-		fwevt = mrioc->current_event;
+	/*
+	 * Safely read current_event under lock to prevent TOCTOU race
+	 * with the firmware event worker thread.
+	 */
+	spin_lock_irqsave(&mrioc->fwevt_lock, flags);
+	fwevt = mrioc->current_event;
+	if (fwevt)
+		mpi3mr_fwevt_get(fwevt);
+	spin_unlock_irqrestore(&mrioc->fwevt_lock, flags);
+
+	if (fwevt) {
 		/*
 		 * Don't call cancel_work_sync() API for the
 		 * fwevt work if the controller reset is
@@ -399,10 +409,12 @@ void mpi3mr_cleanup_fwevt_list(struct mpi3mr_ioc *mrioc)
 		 */
 		if (current_work() == &fwevt->work || fwevt->pending_at_sml) {
 			fwevt->discard = 1;
+			mpi3mr_fwevt_put(fwevt);
 			return;
 		}
 
 		mpi3mr_cancel_work(fwevt);
+		mpi3mr_fwevt_put(fwevt);
 	}
 }
 
-- 
2.47.3


