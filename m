Return-Path: <linux-scsi+bounces-25589-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3lklCcw1SGohnwAAu9opvQ
	(envelope-from <linux-scsi+bounces-25589-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 00:21:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0770608D
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 00:20:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=CkvbjOX1;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25589-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25589-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D9FD301AC1D
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE822D23A6;
	Fri,  3 Jul 2026 22:20:57 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF41F94F
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 22:20:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783117257; cv=none; b=DavhPqiIatHRg1VhGiuAEa2bcSQmI5Zg12uv66XZc73BE9w723LEs8wGC6Jqs5572BRyTMzhOeyAwlJR0IygK1f91z/dz1SsYnvpJHpLnYC0C3P9Pj7dSg6S2+5tVhh8GobxeXSQ+/xJxT7AvlDEFw/oydHokUrBiT21Uxw30ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783117257; c=relaxed/simple;
	bh=MJ/qh6D/zsDdIiDOfu7SIoCeBVXlf6R7b31cT1FIGdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tg1h1uBUsf7IAyxOyIj5HGRZP0LmQMBxe0HkSG5l1AjtlbKcZBuK8nk2cwhUfNd686TcAKitjiWX7eZg8dvcDjQGM6wYmlIbLoOPuCtq+ZxIUfJCmvozMiIWqBXrHfCHhZT+bcWE+SQ/4Y+GCStcgILuoqxSOqgBctXW9yZvAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CkvbjOX1; arc=none smtp.client-ip=91.218.175.182
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783117252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QjnNbXk3O9fzPLCQ/L/wqjlAhAAiHBN/Uo3FaUo9PAw=;
	b=CkvbjOX1sOTozz6Ylnw+lGOAkwiJ8PB8TV0AynpCM9N8t/NX8VviA1uuBmVFObmGtnzrLf
	vWEE8kzna7mY/MV8jMU/JmuoaLiJgGPlM+M7WaDTGHl4BgWOTyCoxXBxF7wQPX6sXRJrNu
	Rzo1JusEe4VFzMNfy1u6Oobh+5GOcvI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: csiostor: Use str_plural() in csio_mem_intr_handler()
Date: Sat,  4 Jul 2026 00:17:29 +0200
Message-ID: <20260703221731.180534-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=thorsten.blum@linux.dev; h=from:subject; bh=MJ/qh6D/zsDdIiDOfu7SIoCeBVXlf6R7b31cT1FIGdU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkeJr8rqmzPP7KZo/XbcMaXfE6t/ZaGL92uHvnqMUe73 cNa7d7BjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjI9IWMDN+POR/ln3GxNVsi 8at5QMkbk0u2p69EP1xUvO9EkuzRJj1GhlMGAgHvpxX3sz2MvRMb+ihuku7dVWrJEvdv9V2c2Bd RxgIA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25589-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:kees@kernel.org,m:thorsten.blum@linux.dev,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42A0770608D

Replace the manual ternary "s" pluralization with str_plural() to
simplify the code. This also corrects the "0 errors" case.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/csiostor/csio_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_hw.c b/drivers/scsi/csiostor/csio_hw.c
index df9f81f29950..44def5f92b68 100644
--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -38,6 +38,7 @@
 #include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/compiler.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
@@ -3490,7 +3491,7 @@ static void csio_mem_intr_handler(struct csio_hw *hw, int idx)
 
 		csio_wr_reg32(hw, ECC_CECNT_V(ECC_CECNT_M), cnt_addr);
 		csio_warn(hw, "%u %s correctable ECC data error%s\n",
-			    cnt, name[idx], cnt > 1 ? "s" : "");
+			  cnt, name[idx], str_plural(cnt));
 	}
 	if (v & ECC_UE_INT_CAUSE_F)
 		csio_fatal(hw, "%s uncorrectable ECC data error\n", name[idx]);

