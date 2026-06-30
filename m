Return-Path: <linux-scsi+bounces-25354-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kU6cH3uhQ2qCdwoAu9opvQ
	(envelope-from <linux-scsi+bounces-25354-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 12:59:07 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A6D6E343E
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 12:59:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nUdQL6z8;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25354-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25354-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7DCF30752A2
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6A406822;
	Tue, 30 Jun 2026 10:54:32 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3F404BFD;
	Tue, 30 Jun 2026 10:54:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816872; cv=none; b=PP00VGNqKpjz0tCiee1f73JnT2JAB/zNQVDX0D3HkxhtrcKrpiX7fTiC/ggqE1kxUL0OEuZrvtTFgh1eeCZCgrEXr5M0i9B8xUfoV2u/dELhWwBMcBW7dBQxjVm0re7UR4HEOSCa579F/72dT7ASzvh3Mh+0lU3iiXpbqNjvyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816872; c=relaxed/simple;
	bh=pzhODa9Msd/r82L3GpP6T6oUQil7qGgrPWt2h9/sbNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZ+XPWXGQ7jIY3xbCfvC3SAN252+G734WKuOHvs5d4sJPdfKkMkRIePXl4RucRfqCz8S7Gm7p5ewjDccu9wTRvUWV3HqJB5C8EXO3oFNu9nTXv3lJK1u170O6bKx188jmqjypJD7m7Ib5GS6tScoUsrtOOQcUeqOGhHVmjBW2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUdQL6z8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084581F00A3F;
	Tue, 30 Jun 2026 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816871;
	bh=8ZrKULHOZCI8ncGNpPaXRQATiyNvBkegtg9+f64SaWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nUdQL6z8kCSrzAcVNyvvv4NATSESaWwYY7FioZQvBxeGiHBtLSpLEi5Zh12SfpD9V
	 c6kqcn+Ycp2k9nYsQiR3fjnHyEpX01Qmgebuaom9NiQv/b00OSjyNH25q6B2aPi+fI
	 TAVk/NEn1hhqbKqlERQiL2Zq985mroLc+kRA1wuz1CeEx2M7aQkKd6hI+bTtqMvwmQ
	 pw66bVWWKgDXxIdVQqK5yWKPNJBLD4nPJDmpJYO0blVgyBFJqJCrBK+kM+//xv9s3c
	 AZH7dyUqOgvbphxcdfEmFzK1F+/dbasFC+HUCECy3zk365KWgJvRKJ1q89ANNKs1qr
	 y5aXyW0Kow0kw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:54:20 +0300
Subject: [PATCH 3/4] scsi: ipr: use kmalloc() to allocate IPR dump buffer
 memory
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-scsi-v1-3-494fb37ebe7b@kernel.org>
References: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
In-Reply-To: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Brian King <brking@us.ibm.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25354-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:brking@us.ibm.com,m:James.Bottomley@HansenPartnership.com,m:willy@infradead.org,m:rppt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08A6D6E343E

IPR dump machinery allocates memory to save adapter's crash dump using
__get_free_page().

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Replace use of __get_free_page() with kmalloc().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/scsi/ipr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index d207e5e81afe..5a212bfdeec2 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -2893,7 +2893,7 @@ static int ipr_sdt_copy(struct ipr_ioa_cfg *ioa_cfg,
 	       (ioa_dump->hdr.len + bytes_copied) < max_dump_size) {
 		if (ioa_dump->page_offset >= PAGE_SIZE ||
 		    ioa_dump->page_offset == 0) {
-			page = (__be32 *)__get_free_page(GFP_ATOMIC);
+			page = kmalloc(PAGE_SIZE, GFP_ATOMIC);
 
 			if (!page) {
 				ipr_trace;
@@ -3226,7 +3226,7 @@ static void ipr_release_dump(struct kref *kref)
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 
 	for (i = 0; i < dump->ioa_dump.next_page_index; i++)
-		free_page((unsigned long) dump->ioa_dump.ioa_data[i]);
+		kfree(dump->ioa_dump.ioa_data[i]);
 
 	vfree(dump->ioa_dump.ioa_data);
 	kfree(dump);

-- 
2.53.0


