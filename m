Return-Path: <linux-scsi+bounces-20569-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIynLCwVeGkynwEAu9opvQ
	(envelope-from <linux-scsi+bounces-20569-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Jan 2026 02:30:20 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8E8EBAB
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Jan 2026 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73A943004DB1
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Jan 2026 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1657B21772A;
	Tue, 27 Jan 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jBkeQEAT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA66265CD9
	for <linux-scsi@vger.kernel.org>; Tue, 27 Jan 2026 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477413; cv=none; b=gBjKneva0ybo2jAQL6uDXXwMb+HpoWi6X0iBNAbtEGJ16qWwYSK0n5TJ0OKx/Sl7ZWRO3L7QUs4xFOpyXL3kPzoTinD/uIXXalXmYRm6D/MfAbL+GbEDfIbFxWUO/sMEUWPl8Ou24L3QootUXYI9Z2YStayESlG3rHIp6KhAnZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477413; c=relaxed/simple;
	bh=HJf5STadY0mu5NC3cR1V8sYWw2EyO8GWe8YZOYQKYyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnjxOR+cgXYs6AsWO7Jh3ZceGxhdpP9RFZw0QN9767EXVBk0fueV7AEU0YCPlPIO36pk6P7t6NNzp8Z4M2SQ9dEaVPuxZiyw1oyYaQtOteaoi08/b/HaWMaIXORt/cN8h3DmNpU+I9x5v6TrW70gH/pthh0ZnBwih10H+Lf1SNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jBkeQEAT; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769477408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kCmR2iE1OIGu/ZxmC8f/nJ9sAuqOxLg/8zr1I5FkpE8=;
	b=jBkeQEATL0IuCRMF9uQVymXlM7ofWroOajuYwcRKxhed30BskwnMxyLJWk5rNF1KqilQrM
	hcK7/h1dM5plcG7uuhVjGI2WsXOjcrBcR3LFNGqOvC7eM/7HmRgcODscTcYQElI8lVvQAW
	Gp2/3FkAbsj1DTay2o5A41f5nmumYag=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Khalid Aziz <khalid@gonehiking.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] platform/surface: Replace deprecated strcpy + strcat in blogic_rdconfig
Date: Tue, 27 Jan 2026 02:29:54 +0100
Message-ID: <20260127012955.432671-1-thorsten.blum@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20569-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: E0F8E8EBAB
X-Rspamd-Action: no action

strcpy() is deprecated [1] and using strcat() is discouraged. Replace
them with scnprintf().  No functional changes.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/BusLogic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 865fcbac8fa1..82e436a8f012 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -1631,8 +1631,8 @@ static bool __init blogic_rdconfig(struct blogic_adapter *adapter)
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


