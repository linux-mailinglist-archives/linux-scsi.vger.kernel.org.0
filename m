Return-Path: <linux-scsi+bounces-25288-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gAAVKelnPmr0FQkAu9opvQ
	(envelope-from <linux-scsi+bounces-25288-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 13:52:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1186CCA63
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 13:52:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=D8PJv3eE;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25288-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25288-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC0530BCBE7
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969F83AD510;
	Fri, 26 Jun 2026 11:49:05 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F744380FF8
	for <linux-scsi@vger.kernel.org>; Fri, 26 Jun 2026 11:49:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474545; cv=none; b=M4ujVgHybk3yXfWq+vfnAe33I/tIS/M0ZHSrUP3751Ph3lL/omNRzsKdCxktOVE74+3aSmrd2cG1I9IQhx7Vg2OuOSui3Vt9gKtcl3JioHRnrLWotpQeXFsFLIZGC/zwNkzt4CmEtr2rn67vk2pT8SSyVqwWaNyS0WvvriMlI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474545; c=relaxed/simple;
	bh=AGk0MJGEpzshXszGBCvSYECLjox5oIF+9Y8PhOpIIXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOmDAzJtgv6zxF0y4HVGkS0VRxOTrh3etz4q0iOIQlWNfHyH7zDrY+foOARYyqH7HAadfEHGrIqQdvr/YWH0TMZG6zV6vVjXxPIdbFbVXcabWXvBj2V8TW+WXo8oM6FQdNMa5luaKf6Sv9/bKZqjZI+oZdMcJ2HKoUbRJthky28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D8PJv3eE; arc=none smtp.client-ip=209.85.214.227
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2c81d799ef2so1920545ad.3
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jun 2026 04:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782474543; x=1783079343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dns3KcC8wp75jV+EFmchfrXNPHbBikOrwHZMHJQta/c=;
        b=MJQowdPSCYurHCyU4Ma4xQYQIZDKxkf5CYUDRqUjvZ5NpkjW3S5BBCK10Vid7Ha9DW
         QVZ1uaQFD+q15ArQVMCdlQatBofYnMHlPRqa5K5+KXzpZEdHA0R2HTjq0YiDfH8U3LGz
         AtrPaTU30f/+rNr61tAOKAZ/Xw+cVYrYOBQbQ6AR1OXQHdyX8lc4szUWEb17CpMmojHO
         Vy7O3/0kpLGbsyPVCKcPTNlzsHovdf+mibbT8iTx6Ut6anZmHwaznprRSsWOkX0WLa4k
         B1FpCFdl44hbK10Gn9zGxdnRj2ZVGw8K2VOPsy4w+hc/dKxOIZffDCZqjk6AYJHJ5lCJ
         wv6Q==
X-Gm-Message-State: AOJu0YyfQuhvprfA+8ZlBewi3GQ+3tkIOCops1YUG4mcm+d5f8INEbw6
	k4r2jgmPVYCGlJXAYtATXisqfW3pGI08DfYXAuhqf5bHj2kFVYK4cw0pTFW8xUWTa8FKPXJHYyJ
	4bhBxIGpUftbDO44B7yzRuFWMw9xLDn1NoWIm5EUSShuElycut9FycnWQp6TLCYOLSx5AeFWOlv
	AfoD67sGuaDko4PlisM3vatikqNKflEVpjJZjtAXO/OCzFPRATObv+tNuj4C2N7KC8/iqvyQefD
	RoHTfwJSHl5OHwt
X-Gm-Gg: AfdE7ckN0Ha5JuDQS52Vt3WqNHuf9YH1vqPJUaic6AEYPKxSt4boET2h2FAR8HrfmTc
	JyjTlnc0+V25TV60I/Mu33/5bwbuu9H6MEIApdKLzw4NY0dIG+kRLfpb6TPZjRRXbaaSmDcOMxg
	dxE6esSlZyU0M52bP998GWg+KX5E0bwxcId9dlbqSBRJAsZ2AsoczA/bHWqupLZqsgb5Ysu3/Cv
	BCsE70TINDMzGDPw1dkZgt9bPEeBLh1iOLV23O4QVCtmBQqGPFXHwE+YZUwSlelrtnLlwRnGsBs
	2ML7N+Sbdv5Bjk/RAWNirFZIxtu9wGm2DbG7Ie+iEtMK4HIxDjx5ppuG3hWvPTVvWgkXEqCTHIH
	ZqGZKtL73ZVroJrkdpzDfOk8AqCtW7WnN4ykjif2GvwW7FwSv3QYKghIN0poHS0lYcq4HBiW0sy
	esQMBNosBMELvxm1bmlXjrSifFjh70DfjSGqP5b0aWP69Ovg==
X-Received: by 2002:a17:902:ef4e:b0:2c8:8f7:cc26 with SMTP id d9443c01a7336-2c808f7ce98mr45561185ad.24.1782474543262;
        Fri, 26 Jun 2026 04:49:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c7f5a9daa2sm5235695ad.6.2026.06.26.04.49.02
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:49:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bccca5620so1264991eec.1
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jun 2026 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782474541; x=1783079341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dns3KcC8wp75jV+EFmchfrXNPHbBikOrwHZMHJQta/c=;
        b=D8PJv3eE9/wRX+2GqYwKgprQYNO+yHxhctbz0rO78tVzNbsRz5DC7r+Fm9miePbLoH
         XRHU8QRUE3RHtvBvwpz4K00fqByXH9kNfT62dyJy3Z9lirgQx1DYCivpSN++oEmWYnVt
         I21NCbBPWVaPIE5N0wpTU5dnG2HSheoRiBz+U=
X-Received: by 2002:a05:7300:7246:b0:30c:5a5:df4f with SMTP id 5a478bee46e88-30c84eb9cf8mr7616998eec.16.1782474541472;
        Fri, 26 Jun 2026 04:49:01 -0700 (PDT)
X-Received: by 2002:a05:7300:7246:b0:30c:5a5:df4f with SMTP id 5a478bee46e88-30c84eb9cf8mr7616954eec.16.1782474540730;
        Fri, 26 Jun 2026 04:49:00 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c58831asm18844838eec.13.2026.06.26.04.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:49:00 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: sathya.prakash@broadcom.com,
	chandrakanth.patil@broadcom.com,
	vishakhavc@google.com,
	ipylypiv@google.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>
Subject: [PATCH v1 10/10] mpi3mr: Driver version update to 8.18.0.8.50
Date: Fri, 26 Jun 2026 17:11:09 +0530
Message-ID: <20260626114109.43685-11-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626114109.43685-1-ranjan.kumar@broadcom.com>
References: <20260626114109.43685-1-ranjan.kumar@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ranjan.kumar@broadcom.com,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25288-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:sathya.prakash@broadcom.com,m:chandrakanth.patil@broadcom.com,m:vishakhavc@google.com,m:ipylypiv@google.com,m:ranjan.kumar@broadcom.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E1186CCA63

Update driver version to 8.18.0.8.50

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 1d11d7c69536..c6bbd6b33cfe 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -56,8 +56,8 @@ extern struct list_head mrioc_list;
 extern int prot_mask;
 extern atomic64_t event_counter;
 
-#define MPI3MR_DRIVER_VERSION	"8.17.0.3.50"
-#define MPI3MR_DRIVER_RELDATE	"09-January-2026"
+#define MPI3MR_DRIVER_VERSION	"8.18.0.8.50"
+#define MPI3MR_DRIVER_RELDATE	"26-June-2026"
 
 #define MPI3MR_DRIVER_NAME	"mpi3mr"
 #define MPI3MR_DRIVER_LICENSE	"GPL"
-- 
2.47.3


