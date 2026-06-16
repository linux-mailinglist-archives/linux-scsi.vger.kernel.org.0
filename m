Return-Path: <linux-scsi+bounces-25005-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R9YGJQMfMWrVbwUAu9opvQ
	(envelope-from <linux-scsi+bounces-25005-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 12:01:39 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1368DD40
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 12:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=YCA7K1dL;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25005-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25005-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3B0D300603F
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC84426EB6;
	Tue, 16 Jun 2026 10:01:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9973AC0C7
	for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2026 10:01:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604088; cv=none; b=nVx/wvFGXKbUF1Ftm19GBPIiGsB4cTe2JM+WJoYTN8jHsheghlv4AOHhsomMLCYlwcsn4jSwl+ZOrNEaIPqkcRGWFbml10bZh9XA7xlyCU7RtagAyw6lTsO+Q3uAglsqEPUCk3SS8rFJATEUFRo0QEMBCObW3VIEDO3AVvxaNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604088; c=relaxed/simple;
	bh=5YPRfJtwZLRFV0Jul74SWkiWszu9PKIMTqshqX3gRC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QqwISCdoteOX+uYotxEKYIShmPZG8rFM+kWv6dEcZACAzrDyFkfJn38kz6qAT7wNzZFnpv3Ey7AuctwiFIoBUKBPFEarDf1fIe5HcIn8ZTWk7YG15Se3Hf0z2eBwgoRwzN8e4m20BGeKC3AZkL8AB4P/OLAIq7IlG1w241lVQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--himanshubatra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCA7K1dL; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c856470fe9fso2149908a12.2
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2026 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781604087; x=1782208887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=21NwLBUNehqApSlGBHg1TEkC78aGT7ZEdik5YJarQwI=;
        b=YCA7K1dLciWrXOiQziXUCWuW55lhlrDFiYZD96PWrZgNXVpy6QJ1bQaN/r+dAowAY6
         PW5lFvvr2z2Ms16+6cmmtiL7yE0IS/C2t3yqmGa9nqT6C/BqVROg1xyXwuSMK4x1sh0Y
         c4oFE/pt6VzYyvJ3rvpoHIo+TO1M2aH+vi17mrYTCAwnk7FIOZWQaqlLMTJtNz3LyvTN
         AwOELoAw95fVxHIBuQnaDPbo+n3Z4N+XptQgOsG/3lrYjA+q3twHJhUNfJ01MGlieFH1
         wYv7IdCn7l0PDLyV6sgZz7DkF0Wl9BwWM5zTh9TW6b0JsBWrI0RhRPhd0dnOr7PnR9od
         yJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604087; x=1782208887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21NwLBUNehqApSlGBHg1TEkC78aGT7ZEdik5YJarQwI=;
        b=fnHHL5YUcnzLUKHhiLksV92HwIdkIo8PrBV8GpD2IEp7Qe1672gk/ujqbq0GizPTrR
         ISbUNIi2hYiI3Q2xNu+eM6jLwugA1/IfyHOyvH8M9cn9GFIajMMYSHqkpfDQA8jnHZF+
         qsyrXfLnWVA6bSwC8Ozj8lqugoCXkgqZcFe4tLz9yK5oXDye3et/m+xpeAFOT5IqCFxo
         AdrWDUZ+0xYbZY8FyLghEfDGcRo4S5d/AFs81jF9yTaJarvJB8FI3zXuk7odFwlFr2A3
         24qmWypbIPCltKvA30PzOjMrJQBTgbwuJCSmqRITiy8wo5XZYFBhcnUC2sNKqwddztaw
         s/1g==
X-Forwarded-Encrypted: i=1; AFNElJ+uWCyAMO8MMRKiOUbzKvq80SJKbwxTZ8NVlgCdS1YAM7MPP49yKb2EHBo2UpzWFqhaR40yYEiI4vo4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rbdM4+YTZCU9/oiHRBpQmYjtLVK7YSXAfkeiN2MmxkRhBxOB
	zRcKQWdT8WRy0Yb32ouXdSE7udzCcgiljQXhjkzREA9C46HSwihj3b3FEm2VJYKeH6izICeKRDK
	1ZfH2uFI0q7bf7IUlJ2oLNwqQORvsp4OkUg==
X-Received: from pgao66.prod.google.com ([2002:a63:4145:0:b0:c86:1337:acfe])
 (user=himanshubatra job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c6ca:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3b7e4d4fdf1mr3252491637.37.1781604085919;
 Tue, 16 Jun 2026 03:01:25 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:31:21 +0530
In-Reply-To: <2026061659-enjoyer-boogeyman-25c0@gregkh>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026061659-enjoyer-boogeyman-25c0@gregkh>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616100121.548759-1-himanshubatra@google.com>
Subject: [PATCH v3] scsi: ufs: sysfs: Add HS_GEAR6 string in power_info/gear
 sysfs output
From: Himanshu Batra <himanshubatra@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	vamshigajjela@google.com, manugautam@google.com, 
	Himanshu Batra <himanshubatra@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25005-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[himanshubatra@google.com,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:bvanassche@acm.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-serial@vger.kernel.org,m:vamshigajjela@google.com,m:manugautam@google.com,m:himanshubatra@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-scsi@vger.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[himanshubatra@google.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9F1368DD40

In power_info/gear sysfs, currently it supports output only till gear 5.
If operating mode is gear 6, it outputs "UNKNOWN".
Add support for HS_GEAR6 string in sysfs output when operating mode
is gear 6.

Signed-off-by: Himanshu Batra <himanshubatra@google.com>
---

Changes in v3:
- Fixed the identity alignment issue: updated both the 'From:' line 
  and 'Signed-off-by:' tag to use my full real name ("Himanshu Batra")

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


