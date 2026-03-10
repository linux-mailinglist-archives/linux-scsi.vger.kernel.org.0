Return-Path: <linux-scsi+bounces-21760-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNFCAM0osGn1ggIAu9opvQ
	(envelope-from <linux-scsi+bounces-21760-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Mar 2026 15:21:01 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 220AA251C78
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Mar 2026 15:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245A133E1118
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Mar 2026 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C092D979C;
	Tue, 10 Mar 2026 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="N/DucNRc"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B42BE056;
	Tue, 10 Mar 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150079; cv=none; b=AlVmpVb29elMNhn59iWriMxmavzCTc0MEQlAFzgApl/SvjTue9sUXtfdO9RO3TrgJ+QeYA/habTdrHaByT/WFAuztN2qEq9ebsiv9rc9swOm6LzOQrCOapUo1c6VmVYzkn0zVbWyyiwH3YkbJwSq51+TSjPhUPcmJSZY4qNoSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150079; c=relaxed/simple;
	bh=R2Lxn0kir6DhvOJlq8mXW8EHAujQhyZEDCh5GVOktJo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XU5SijfESiLheHp/nuR0P+e0FIBE68Iy5rfh/YRD3sZjPkWXf7eDtxb53IuCE32IxUSEnT61YvNr4Ub5qqeslo46bHW2/kpI6PI6QkKpB7HN6Q/Uuqf/8CH6tL0u+8N8W/DobLmu4OzZWqB/TyYq1OyoGXpsNcWuGGRFgHvLDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=N/DucNRc; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773150072; bh=CNiHs/fmh8VQOaV3n+a8UGqizjL8jYAT5el6fsIopU0=;
	h=From:To:Cc:Subject:Date;
	b=N/DucNRcVN4JgNry5KUdrTJsKNK1hwGFH8s8APO6vCQPvy93zvHxlZzYHUe7YKvFv
	 glFiG1FKsfwYA3gu2Qf3jNSlCeBOXPBsdqPYOHhgG3GHBJVqJkMKcYcgJlwiFjqW4X
	 JKmW/1veTnVzcN6PTzZBAxOSARghywFLD6IsWFvA=
Received: from June.localdomain ([123.121.145.35])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id A49B96EC; Tue, 10 Mar 2026 21:41:09 +0800
X-QQ-mid: xmsmtpt1773150069tghprnf8d
Message-ID: <tencent_20D61470B21FF11A382026C8503A7B504508@qq.com>
X-QQ-XMAILINFO: Oe2Ep21nNiFr4ANWl869CO6jYUMeWlXRTxRygJg6/QcliARgcHx6GL7FPU9Mlk
	 7RAFkHsMwfzesF2rkiPv5Q3qKOovj+a/Fk/cgIxabW52zA4/PEnWaPpcg614+gdzOPw5mjBZHQPS
	 W0Zw4x8LDL2B5n5grPdrj7/1sI83XFiLfauP/lDgRDxubT8HUYRjyrM6U4ie6RogYS1o3E9s0uFu
	 WZz7z7fwc5LqRWFshbsY94qaV1+1Cx8+YbTNj3Ap8tDu3W7ZbysrHX+C3zDF5pztsT2Qzu/VacyS
	 PPP9rF+5xXBKccdr2wRRHt4vnbGhDGIL0dO6zvW3lWqfFdv1e86f+BrWiZbJ7DTyL6c80fv+NbGt
	 W7MM2iQJc/PSx/pJ0YTeu8iIKm5yRH99gvChu8lsoFVjFkLFuHFUSYY8E634nDbu1ivMfdwQv6V1
	 pR7E5oEci2I7IO+PZmKzzbNQoDwKmGIpVsbVTwzQiq84Im/RBRvoQcc1gT955sPo0nCiPSnKqHS4
	 PSqBHbdVe/wVbDF61kWB0Pqf8UlO18O0X2m1RaKYI5XNbD2ASMXepbmlnOqcpy036ITdL2Ojcg4K
	 6FOU4wScT3dsWJZ3JxoAMGDDGax3R7hLo68PaglWyA9E/MQt/YgijXIrktk6iWxLs312QEBRo+Os
	 oTw3T++5JQDTBW08i+0J2qjxrTDqWz3sPi663xC0BvG2Af64zgXc7OCev8YUAELMzo9124aPiTHZ
	 iqw+CwHccDgt+bDoC+C9ccZ9G+oPguSIC9KHm+FQngKTtqNxo1s000bkvx0E7yBbQV2sRHZ7hegP
	 vZWQvkyv0U9BETAKlsVKj7IxjLyfCuEnCCob7l/Tpl1T1tPfDbvhmUlFBwjbiz2sjcd9GpYanbaa
	 QwotykRcmHKgdh22JjGPFKCqW7rmEZDJ1wfFUFv5Uy4SWvjvxnbDLuhKuRH4XcetoBstZcnbB1wN
	 f0YX5/h+anHSHGwqe7JYKQ6/2Nev0+Y3/634r9dyscdFbwStBoGij7zb1Z/p5REvNlgmRbS7/QwB
	 Gkk3EUXuIT49iMXKOp7P9iH0BKNRBX2uWVUzHmMk12zM5QuC2MssSHgJL49IDhVq5lqCTxPQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Wang Jun <1742789905@qq.com>
To: Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wang Jun <1742789905@qq.com>
Subject: [PATCH] scsi: elx: efct: Check return value of ioremap() when mapping BARs
Date: Tue, 10 Mar 2026 21:41:04 +0800
X-OQ-MSGID: <20260310134104.64635-1-1742789905@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 220AA251C78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bjtu.edu.cn,qq.com];
	TAGGED_FROM(0.00)[bounces-21760-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1742789905@qq.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Action: no action

The driver maps PCI BAR memory using ioremap() but does not check
the return value. If ioremap() fails and returns NULL, the driver
may later dereference an invalid pointer, leading to a crash.

Add proper error handling for ioremap() failures when mapping
memory BARs during device probe.

Signed-off-by: Wang Jun <1742789905@qq.com>
---
 drivers/scsi/elx/efct/efct_driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index 1bd42f7db177..ba23d73c3ec1 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -528,6 +528,11 @@ efct_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM) {
 			efct->reg[r] = ioremap(pci_resource_start(pdev, i),
 					       pci_resource_len(pdev, i));
+			if (!efct->reg[r]) {
+				dev_err(&pdev->dev, "Failed to ioremap BAR %d\n", i);
+				rc = -EIO;
+				goto dma_mask_out;
+			}
 			r++;
 		}
 
-- 
2.43.0


