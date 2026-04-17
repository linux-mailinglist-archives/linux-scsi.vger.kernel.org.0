Return-Path: <linux-scsi+bounces-23058-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XP0EHxWT4mkt7gAAu9opvQ
	(envelope-from <linux-scsi+bounces-23058-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 22:07:49 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012241E718
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 22:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 118793024113
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC5B30BBB8;
	Fri, 17 Apr 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="TexcsiXU"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B472FE58C;
	Fri, 17 Apr 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456463; cv=none; b=Yn2BBk6Gtf8V46nqN5lqI0MW1rvNfD78GbMgYyjqp9Iwof/m3s9ZctM2f+vYXYNi5E25cUMcurmePWALdfLSn9r0DqyS4Pqt2b+FQAt9rlPk76ZstxGMvQwl0IAIld1nMDb9EVbzM1Yh4WrwbYpsobHNiSZYSzdGasawz2dE0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456463; c=relaxed/simple;
	bh=r3dcpzUTyZ3Ll/+6lC35ys6Pz2enClcuWS7OKYhJLig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK7xRTjV0+a4pNAg3VeRLfl0ISwXEvDZZ6A9yRES26XNXyq5HVv3uDrulhQm3KqscbOZk7UthX8K8lcD/7chGAiNTygVAFXSLohpu8+SETA6mJLs4iCsCoZL0r1NjUseqSxXAbH+eYq7zLaCk5j6VP0OHyWWYxqdT0aUrT72t5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=TexcsiXU; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=XSNjjT78S1FdDsqZ9Z8cpbJxB/sRGvX8KExpQlqxhyM=; b=TexcsiXUKCg/tb79uxyjz/vR0e
	rYnw76vhXN9i6tDJHjqLsJDH/lSox+BJ6Kh90++z0AHnfDTT0fF2i6ubbDddD+RthHIIYi1lmVLsL
	JG/OS1hViKlVaIGtlJXXdwXnxXEdoTvBGOzyje90Qeue2sexGRlJeKGfVEhUEOSuH6cQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDpTY-000000008IR-28Gj;
	Fri, 17 Apr 2026 16:07:40 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pmcraid: Fix typos in comments
Date: Fri, 17 Apr 2026 16:07:31 -0400
Message-ID: <20260417200738.3920001-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hugovil.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hugovil.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23058-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hugo@hugovil.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hugovil.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dimonoff.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hugovil.com:dkim,hugovil.com:mid]
X-Rspamd-Queue-Id: 6012241E718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix typos in structure comments.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/scsi/pmcraid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.h b/drivers/scsi/pmcraid.h
index 9f59930e8b4fd..cd059b7599b4c 100644
--- a/drivers/scsi/pmcraid.h
+++ b/drivers/scsi/pmcraid.h
@@ -657,7 +657,7 @@ struct pmcraid_hostrcb {
  */
 struct pmcraid_instance {
 	/* Array of allowed-to-be-exposed resources, initialized from
-	 * Configutation Table, later updated with CCNs
+	 * Configuration Table, later updated with CCNs
 	 */
 	struct pmcraid_resource_entry *res_entries;
 

base-commit: 59bd5ae0db22566e2b961742126269c151d587c7
-- 
2.47.3


