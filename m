Return-Path: <linux-scsi+bounces-21025-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBoJIga7nWklRgQAu9opvQ
	(envelope-from <linux-scsi+bounces-21025-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 15:51:50 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F1188B03
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 15:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C23311BE7F
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59FD3A0B24;
	Tue, 24 Feb 2026 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+C7NpyG"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AD3A0B1C;
	Tue, 24 Feb 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944521; cv=none; b=CTSsii+WMhl621JoBb7YAn2MAvGq0IoTQelfSPNsSgD8CUd0GH4jkbGy0AMrbeCoPhsLCS7bfMta86Q8XOO3Ubbvp3D0M11GayDLiF2qpba4Hx5MKbuKa7EBKRKbsvYDVzzXjoW87P7Kddpe3F273fZbS8mVDVLWmLA/aX0xCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944521; c=relaxed/simple;
	bh=Q585uK4JJDD0U3PHw8yVYOplqttVwNp607FKnHC0BRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKgZSf66bs8AV9OqfWeLidl7jUH07YU1W5FW/k2P8QmdvKCHHZ92DK+Xy9VkDlFMsbvjo0u580o0MJoK9Li7JunPj0NgCHiLhvebYTDWnkHHFPuFlyAytEmI9SSobnL/FbjeRrv4lx3jypEWFSlKuDtH02YODxPIBKndaL0hBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+C7NpyG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771944518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jL9+oAoqW2TSXE+lBX2iHJoQ1jOBMgp+GuI3U6TbfFY=;
	b=d+C7NpyGdzIc6LYzyiF39sdVdmLOYJ8LszbOxYIHoVXwGPGAjtYG0RfSLi1iNtdXuWHaeM
	HIsD2OB34ir9TwrrJBy4juZqwqNlODEO2sn0JZOXtBvHHfxrgUt2m8hlOmTy+jBhBvDcoC
	byZ3fx/x3aiPFbjIoUpoh0V15h5RSTw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Khalid Aziz <khalid@gonehiking.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] platform/surface: Replace deprecated strcpy + strcat in blogic_rdconfig
Date: Tue, 24 Feb 2026 15:48:27 +0100
Message-ID: <20260224144828.585577-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21025-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA9F1188B03
X-Rspamd-Action: no action

strcpy() is deprecated [1] and using strcat() is discouraged. Replace
them with scnprintf().  No functional changes.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/BusLogic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index da6599ae3d0d..5304d2febd63 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -1632,8 +1632,8 @@ static bool __init blogic_rdconfig(struct blogic_adapter *adapter)
 	/*
 	   Initialize the Host Adapter Full Model Name from the Model Name.
 	 */
-	strcpy(adapter->full_model, "BusLogic ");
-	strcat(adapter->full_model, adapter->model);
+	scnprintf(adapter->full_model, sizeof(adapter->full_model),
+		  "BusLogic %s", adapter->model);
 	/*
 	   Select an appropriate value for the Tagged Queue Depth either from a
 	   BusLogic Driver Options specification, or based on whether this Host
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


