Return-Path: <linux-scsi+bounces-25000-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I+AHF/oJMWrOagUAu9opvQ
	(envelope-from <linux-scsi+bounces-25000-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 10:31:54 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA568D306
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 10:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=iENWB1pM;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25000-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25000-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FB713030D5D
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31794192EC;
	Tue, 16 Jun 2026 08:31:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7732B9B6
	for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2026 08:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598690; cv=none; b=CDWByV2Z3RnKOI9zgAMz+vHeo43qQ/lIFj4aumJSCJINjRgViCgNInqe2JinDQ44voKGJyiug2rv5yJ00AQP02s23rvQbdX0rYV26+QeH3NW15pqr4fxiLGFB3kmZ/VQjQ+MESc5z0IdJeuds5U8h4GLONqpTcIZgAnx6W5ymps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598690; c=relaxed/simple;
	bh=U1CCaUEUj+Uj+CZV2pR4dhrK2VZTd4Us+SMggdhLU1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNbHirAIGTBYNyCFTgi7iz5o54LgvU6mNcNfkd4TuQ5EZsO8mGtu9S5dmRW74higF3Q0HZkepxXV83YKRk7dCLOy/OJkRFcGISm21LlUeYeGZ9CiL/UyrqdSeuXufuxnZNcKk8lCQAhI1W1wwzuBuAapnj9DlrhUUbHthPBYN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--himanshubatra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iENWB1pM; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso7730607a91.2
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2026 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781598688; x=1782203488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCVWn/Tak5xeployam8KSgFpW0BNc4qS3cakDpS+Z1Y=;
        b=iENWB1pMK9wFOwnSvWgTLY/9nmPdi5hEl7Yxs2AShcQz1xhV+Zkd6m1zWrrHVtqGJ4
         ix+oaIli8SDiKgavrBCzHpycMXTjLA5voJFbUODnfa+6tNZE6qmTMu2zU5UE/u+vgcOw
         jTUx6EfYnwTkAytYu6Q07cyOZU8mMoCB+UKzXNcVGvUKlLdc1+Yk/V6okzcC40tm35lk
         rwPni9iWtBpyAohkeqxjWPWGPhQm2U6t4q+A/CTjJ+PsG6RjXGHXepXR33lgwpd+uLPh
         Lb25Kd/OGQUdpPxpQViucTUnVFiCLNhaMeb+duX9s+4CdLORe8c0Ne0r9JRCKSZUQeDt
         b2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781598688; x=1782203488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCVWn/Tak5xeployam8KSgFpW0BNc4qS3cakDpS+Z1Y=;
        b=G8plvtuDp6DIqvAOSjNm9qRST309m2YpSgku/wnPmBbIRJIz0UpSYfqZH280Oe77zo
         af6cwBVxCGG96u3nOUocuktnKhdH/+LOFt1F5uoIy4AFbFJjjMSQl217r4Kr0mHKAETC
         3eHbAKpPis4UlHd7GGkU+MQdu3IM22AVf0a9k8MvCiwU2jcsxCnbAJy9lK8N/HHQ9POB
         xEegIz+Qzie25vZNQ+7uI0f3oZOc8tgK1fiYEAXFeFe0S0OS+NDbbzx7ItY+xRVPJqmc
         NCYbRRj0E+W545oI/wC8XgpLPjbfMHbikeTnp12UxjnJhPSxmesJTGKNV5ZkCLh/Eb9u
         j5AQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nemDwK/+I7DocFwWkqN4ny151s+BQZij7QkQ42Ls3Q27YgtepgN7N15HtmD4A10jTPXin/jNrjDdv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yHVWNpBZxmgwFyyzaShry+inVpOt4kQKc2NVycSu4qvU7VcJ
	RSJSCtLAI1wm1oux/5tOq742Q/zl028QNyW/A3jZJKj0ls5nleC8DXy6sgCPIq4AE1jeR/oUrhv
	//pDVBvy/qGtTDUM0OWcARogKUhmVlw8Nmw==
X-Received: from pgc13.prod.google.com ([2002:a05:6a02:2f8d:b0:c82:283f:132f])
 (user=himanshubatra job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7d01:b0:3b2:b1ed:d1df with SMTP id adf61e73a8af0-3b796363482mr16795836637.29.1781598687366;
 Tue, 16 Jun 2026 01:31:27 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:01:24 +0530
In-Reply-To: <CAEif7DR3KUdhPww-q_Fn6gR6L=V5nrD3EyLn3vi+hWLmS3eU6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEif7DR3KUdhPww-q_Fn6gR6L=V5nrD3EyLn3vi+hWLmS3eU6g@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616083124.267262-1-himanshubatra@google.com>
Subject: [PATCH v2] scsi: ufs: sysfs: Add HS_GEAR6 string in power_info/gear
 sysfs output
From: himanshubatra <himanshubatra@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	vamshigajjela@google.com, manugautam@google.com, 
	himanshubatra <himanshubatra@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25000-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[himanshubatra@google.com,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:bvanassche@acm.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-serial@vger.kernel.org,m:vamshigajjela@google.com,m:manugautam@google.com,m:himanshubatra@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[himanshubatra@google.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8FA568D306

In power_info/gear sysfs, currently it supports output only till gear 5.
If operating mode is gear 6, it outputs "UNKNOWN".
Add support for HS_GEAR6 string in sysfs output when operating mode
is gear 6.

Signed-off-by: himanshubatra <himanshubatra@google.com>
---

Changes in v2:
- A slightly better comment.

 drivers/ufs/core/ufs-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 99af3c73f1af..d1f5041fc3c8 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -54,6 +54,7 @@ static const char *ufs_hs_gear_to_string(enum ufs_hs_gear_tag gear)
 	case UFS_HS_G3:	return "HS_GEAR3";
 	case UFS_HS_G4:	return "HS_GEAR4";
 	case UFS_HS_G5:	return "HS_GEAR5";
+	case UFS_HS_G6:	return "HS_GEAR6";
 	default:	return "UNKNOWN";
 	}
 }
-- 
2.54.0.1189.g8c84645362-goog


