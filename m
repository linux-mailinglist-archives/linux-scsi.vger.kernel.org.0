Return-Path: <linux-scsi+bounces-25342-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2tO2ETwdQ2riQwoAu9opvQ
	(envelope-from <linux-scsi+bounces-25342-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 03:34:52 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 395936DF9D6
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 03:34:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sfyzyys+;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25342-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25342-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39C9E3002F53
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 01:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EF936CE19;
	Tue, 30 Jun 2026 01:34:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5936C5B2
	for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 01:34:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783284; cv=none; b=VhKK0wkqHtf7GMxUyZQOeuEprahi1aTrmWxPCW96vEhKbuWF80uKhcQWrOpUBQ5d9lSPrfrhoLXC6KZy5jz8AXYU/qWnlIlHTn1Lz4vpWLz/p+m6xy6Y0UMtAyvhv/qBqvrmEntp7OUyzqvh0YQ3CK862/b1ZoLumrQEmAEl8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783284; c=relaxed/simple;
	bh=M0x7ksqF1OMobob8QYasLaMDrkw6TbUAJfO9UeaK1js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrQIHZcC/T4GMr8re/tfGJFa0Cg17ADtsLiazcTFDkIDTIuzS/urH2kKMKvZYFDjCSIUDGlo5bsLoZDjw804+s4Ogi2Vj2FFgB5l9xNozJ2mcCpnJW3d/zDSMnSGwH6DSRBQmMT9KtWBe9P67KQANbHrVaU5nwTQbXhZv6zBvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfyzyys+; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37defb2f231so2181894a91.2
        for <linux-scsi@vger.kernel.org>; Mon, 29 Jun 2026 18:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782783276; x=1783388076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9o2XNaTTYZWbLNFTbe76krv28sOX5tvFe5ixGZcwWY4=;
        b=sfyzyys+29KC5Ps7UoFVXWvflb5/iTRIHJZaI5tgVllFEYOonDpFUYZwrWLOfENinV
         H6nlfSOGvgH1nKCZaKV7a8tqLYIpEQ9odPAtro/eS62eqX6/kyCOzSy6zJMwh3sUpaS3
         wFmLfUvuMrXDpEgw6W+oriOPrSZF0cWhs06a8wfZB83psDjtNmIOWK8ztGZcjVgZIrgk
         ZDWsF73XEN6igEgyXoAcVLZ7IJvUEW6/DCtEm4StvCfP/vPJny6kc4uoN5BT/2zRcDcG
         MlC01nOlJ7tMPd+EvXnCgGvFUlftZ3UN7cRk4AcNlob1rySFpD/3OAxoE+izuPlP3liw
         G0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782783276; x=1783388076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o2XNaTTYZWbLNFTbe76krv28sOX5tvFe5ixGZcwWY4=;
        b=B0gt1/s35wsxg7zHNB3zsGY+SV4qB5YjbCh8FBuFG34HqH6I6bZm9QfvOV90xmcnuO
         L15UOTX5od+KssI8tDyM2CizvQZarLSTOnpoomgYmBeq4aFfe2Tvkr/6SeJRLKnIFiVT
         S/PDRJBybz+iJUEm106NzVUpWb+hcS+LMGt/MDT2C5b+RkIuruE7ArsCHS+ooc1ix8Nx
         xYV3xunA46P6+kJ8ngj7LaGTUgyYhR6ulG9A6wb31FU8YB2ulipA0Nc02x78wZlz0jyk
         xBlQLYHRYEKaiMt9MN/6843AdB7VnUsuXZy2nfWjN1Kg/z9SM4KURkRbPd2Za8cWUkI9
         c9ZA==
X-Gm-Message-State: AOJu0Yx6OIppHTYaF1OSnTxFkx6mppEQefYzagwog7dDNazJbM4svrlz
	anCiBqkIjL3WiFOC1+9FbhXmgjmc4xZAtpIlIPE0n4WQBTEbNCd++3cAlb0a+F54
X-Gm-Gg: AfdE7ckSYRYU4344bfAyMkUqeAog0Yv4yAPm6ts8NjTkEenNe50w6NA45uMnnBEZNw6
	FX9pv7FzMxSFfqrVUXWd74+XYiOJ7sQa2ifjPfv00l2meVWsxoL15+SzQ1NXRgQBeq5VTKgHv85
	j3X7/Oxk9aeq+4cEW6mp97mXStaYLIxD7PdEK6TWTpyPhKFuGJeP6aOfyR7aNxdTx1s3t+yVpxA
	qSKEqUNc0FUYTdTOSQuO7SWinuignodTtcfP5bHUEeSSpO2GJeAhs5xLuaOFU/s0MIkUoeeAZcy
	RBlfKf2ETn82y9RjXi4kX609sKdsH6BdkdZPZcXWPWJHzCzHfwkaBghRRFXzQFin7DyAoaEKKPt
	64F/E4BfjUwVudncjj/e/a/ZB+0OsTZ0fW4lGPQXtR/Covq7BkdH0i59n2q2yQ+K0O7xwwxammI
	d+IjBimNbadRxpGrDYTuxNI18zwE/BmSoxwfq5LHsfc2wgS+RszOtg9UqljBxONQJaQoyWCrs/M
	5VV1BpkjQ==
X-Received: by 2002:a17:90b:1646:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-380527a83famr1164028a91.20.1782783275845;
        Mon, 29 Jun 2026 18:34:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3805340870dsm636162a91.11.2026.06.29.18.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 18:34:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com (open list:LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] message: fusion: remove unused variable 'timeleft' in mptsas_issue_tm()
Date: Mon, 29 Jun 2026 18:34:33 -0700
Message-ID: <20260630013433.1518025-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-25342-lists,linux-scsi=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 395936DF9D6

timeleft is assigned from wait_for_completion_timeout() but never read;
the function checks ioc->taskmgmt_cmds.status flags instead. Remove it
to fix a -Wunused-but-set-variable warning.

Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/message/fusion/mptsas.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index c362f09a8c55..82ac24bf780f 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -4787,7 +4787,6 @@ mptsas_issue_tm(MPT_ADAPTER *ioc, u8 type, u8 channel, u8 id, u64 lun,
 	MPT_FRAME_HDR	*mf;
 	SCSITaskMgmt_t	*pScsiTm;
 	int		 retval;
-	unsigned long	 timeleft;
 
 	*issue_reset = 0;
 	mf = mpt_get_msg_frame(mptsasDeviceResetCtx, ioc);
@@ -4823,7 +4822,7 @@ mptsas_issue_tm(MPT_ADAPTER *ioc, u8 type, u8 channel, u8 id, u64 lun,
 	mpt_put_msg_frame_hi_pri(mptsasDeviceResetCtx, ioc, mf);
 
 	/* Now wait for the command to complete */
-	timeleft = wait_for_completion_timeout(&ioc->taskmgmt_cmds.done,
+	wait_for_completion_timeout(&ioc->taskmgmt_cmds.done,
 	    timeout*HZ);
 	if (!(ioc->taskmgmt_cmds.status & MPT_MGMT_STATUS_COMMAND_GOOD)) {
 		retval = -1; /* return failure */
-- 
2.54.0


