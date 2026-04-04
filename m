Return-Path: <linux-scsi+bounces-22773-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJKoFSFt0Gkd7gYAu9opvQ
	(envelope-from <linux-scsi+bounces-22773-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Apr 2026 03:45:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0138B399839
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Apr 2026 03:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FF15303FDCA
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Apr 2026 01:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743AE287246;
	Sat,  4 Apr 2026 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfttzlZg"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D81D63E4;
	Sat,  4 Apr 2026 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775267074; cv=none; b=bCJbRixr3ROcAOe/dwpBEQSkoL75YemIFqx41BZlzLiFfelF9vOxzASkUZut3ulc0YaM2pijq06wcrtOxLE4ImNjUzKO9NzHn1rzW66XQRZE0EWccWPfG3OfsomS9kw/jrVfnXx9x6ZHCmPiAYgM4QpgwMaSbJdRiCSc4KYNY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775267074; c=relaxed/simple;
	bh=kGncH5QPq8GPbAkI+RMuvBe8TFeVXXpzYhHP07Hvrw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZ/ozKXlEkWjcT/6CWjREFqFF7UfXqwlaQOMKgOT0u5muBKlTDf/8XEa8+lr1PWPqs1tcGuUTULHHm1nsDlL6m5OReXztfYagWeorPXUYG8ykWsoorsDM2xfi96IuinlX1iASukej1WY/EA0YbWERhLRktoMP0RuueLIGv5CT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfttzlZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A181EC4CEF7;
	Sat,  4 Apr 2026 01:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775267074;
	bh=kGncH5QPq8GPbAkI+RMuvBe8TFeVXXpzYhHP07Hvrw0=;
	h=From:To:Cc:Subject:Date:From;
	b=DfttzlZgVj6qgVps+jnHVeu3qnxnoZDZy8gdcgJEGGq5RO0rrfVLQdy88LIDXmfog
	 corCzZGq6EAHPOzlLy+GmGtzodTIj/Y8ab0sz7kWi7J6Z8C0Iycl9vtvve7wzjPAkv
	 djQm3ioipAhHp/J5x/a6L+yxFwm8S49D3tRC5YC+DPHGVKJB/Ps0l7rxx7b5EKIwu7
	 sBITT9BjQ9t7dqVFN+DXsGht/nFoeNxT+V6JH8XV9CA49KPhgnRb9aCvB8v5myzlL3
	 0HjG4VCcYCKvrmtUa/pubM2yf3OtQSBDfglMkAftPXfIDCzv0+A4cGCOsTXN6GSefs
	 +f9RcCGZs+6Cw==
From: carlos.bilbao@kernel.org
To: martin.petersen@oracle.com,
	kees@kernel.org
Cc: pabeni@redhat.com,
	mlombard@redhat.com,
	kuniyu@google.com,
	d.bogdanov@yadro.com,
	michael.christie@oracle.com,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH] scsi: target: iscsi: reject zero-length Extended CDB AHS
Date: Fri,  3 Apr 2026 18:44:29 -0700
Message-ID: <20260404014429.115807-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22773-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.bilbao@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0138B399839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Bilbao <carlos.bilbao@kernel.org>

If ecdb_ahdr->ahslength is zero, two bugs follow:

  kmalloc(be16_to_cpu(ecdb_ahdr->ahslength) + 15, ...)

allocates 15 bytes, but the immediately following memcpy writes
ISCSI_CDB_SIZE (16) bytes into it, a one-byte heap overflow. Also:

  memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
           be16_to_cpu(ecdb_ahdr->ahslength) - 1);

(u16)0 - 1 promotes to (int)-1 which converts to SIZE_MAX as size_t,
causing a massive out-of-bounds write.

Reject ahslength == 0 with ISCSI_REASON_PROTOCOL_ERROR before the kmalloc.

Fixes: 8f1f7d297bce ("scsi: target: iscsi: Add support for extended CDB AHS")
Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index e80449f6ce15..8db24d35c762 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1100,6 +1100,8 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 	cdb = hdr->cdb;
 
 	if (hdr->hlength) {
+		u16 ahslength;
+
 		ecdb_ahdr = (struct iscsi_ecdb_ahdr *) (hdr + 1);
 		if (ecdb_ahdr->ahstype != ISCSI_AHSTYPE_CDB) {
 			pr_err("Additional Header Segment type %d not supported!\n",
@@ -1108,14 +1110,19 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 				ISCSI_REASON_CMD_NOT_SUPPORTED, buf);
 		}
 
-		cdb = kmalloc(be16_to_cpu(ecdb_ahdr->ahslength) + 15,
-			      GFP_KERNEL);
+		ahslength = be16_to_cpu(ecdb_ahdr->ahslength);
+		if (!ahslength) {
+			pr_err("Extended CDB AHS with zero length, protocol error.\n");
+			return iscsit_add_reject_cmd(cmd,
+				ISCSI_REASON_PROTOCOL_ERROR, buf);
+		}
+
+		cdb = kmalloc(ahslength + 15, GFP_KERNEL);
 		if (cdb == NULL)
 			return iscsit_add_reject_cmd(cmd,
 				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
 		memcpy(cdb, hdr->cdb, ISCSI_CDB_SIZE);
-		memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
-		       be16_to_cpu(ecdb_ahdr->ahslength) - 1);
+		memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb, ahslength - 1);
 	}
 
 	data_direction = (hdr->flags & ISCSI_FLAG_CMD_WRITE) ? DMA_TO_DEVICE :
-- 
2.43.0


