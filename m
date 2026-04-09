Return-Path: <linux-scsi+bounces-22837-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGaUEGET12kSKwgAu9opvQ
	(envelope-from <linux-scsi+bounces-22837-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Apr 2026 04:48:01 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0AE3C5ADE
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Apr 2026 04:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE9A30401A2
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Apr 2026 02:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42444366810;
	Thu,  9 Apr 2026 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs8F/qqW"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB635C1BC;
	Thu,  9 Apr 2026 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702578; cv=none; b=GXUAxLmNjIRBCZOnN8nXRYGcc18OH+UkQ1WlarFYbrksHCJN2og2/aWEx9CBEz4Dxx+kL1qCuYxeefCj2AsH5E5YH11j0hmdejUAUFdq5scqSNuZfir7sumTqiioADaDY5+zKOeLJXjFC4Tefx+U76eKq1URPByazxRH495M/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702578; c=relaxed/simple;
	bh=/4TUkqIj714VbpV3V5urDLV51x5ECDI2r8DsaLqIsNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAlb2vaxgRBm/gllwdUXi1CccC8ejyBGhBolg7465uQ4HbZpzftnY2g1QwI5aEx2KRMsp9YvK02G0Lc6ZiGY8WEaBT50LG/FYHkaFpHOKCW4e5k42H9RQUuHPCF7vlcQPD6zwRwMMmTRmXd0/Woru5ZaOA6tWZd9I4E3ihA29H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs8F/qqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E0BC19421;
	Thu,  9 Apr 2026 02:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702577;
	bh=/4TUkqIj714VbpV3V5urDLV51x5ECDI2r8DsaLqIsNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bs8F/qqWvYdrx+qlDCNY67jEvotytKjibYcs8gkw6O1NYLQ68f/furFfZ7n6CJThW
	 2YGg6c4IzBUydNp+wGhpRGk4Pl6NXlwxc4A0jr/d3wIumDkMwirwdJWvfm5budEXM5
	 v7NAgBOSiCUf42CsPQIL9ONNuo3IrQo0jUwb/pfnR0YN3cTNNu/14bDJnUGTMakPYp
	 fX1Q1pybuXL2PqHfsus1JYbLkjBtlm5bs9mfBseHkkemL4dRT2TzsEyJkgb6TJfohC
	 LCKJTN5V2rCXmpGh5zRYWRrC6uvC1m8Lqny9L6Ay6GnGaWnuqy6zkGCufbOGd2sBQp
	 NLLphehooVH/Q==
From: carlos.bilbao@kernel.org
To: d.bogdanov@yadro.com
Cc: bilbao@vt.edu,
	martin.petersen@oracle.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH v2] scsi: target: iscsi: reject invalid size Extended CDB AHS
Date: Wed,  8 Apr 2026 19:42:53 -0700
Message-ID: <20260409024253.34926-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404014429.115807-1-carlos.bilbao@kernel.org>
References: <20260404014429.115807-1-carlos.bilbao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22837-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.bilbao@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA0AE3C5ADE
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
Also reject ahslength values that exceed the actual AHS buffer advertised.

Changes in v2:

- Add bounds check: ahslength must not exceed (hdr->hlength * 4) - 3.
- Replace opaque ahslength + 15 with explicit cdb_length variable.

Fixes: 8f1f7d297bce ("scsi: target: iscsi: Add support for extended CDB AHS")
Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index e80449f6ce15..1a492965ebdf 100644
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
@@ -1108,14 +1110,27 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
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
+		if (ahslength > (hdr->hlength * 4) - 3) {
+			pr_err("Extended CDB AHS length %u exceeds available buffer.\n",
+			       ahslength);
+			return iscsit_add_reject_cmd(cmd,
+				ISCSI_REASON_PROTOCOL_ERROR, buf);
+		}
+
+		u16 cdb_length = ahslength - 1 + ISCSI_CDB_SIZE;
+
+		cdb = kmalloc(cdb_length, GFP_KERNEL);
 		if (cdb == NULL)
 			return iscsit_add_reject_cmd(cmd,
 				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
 		memcpy(cdb, hdr->cdb, ISCSI_CDB_SIZE);
-		memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
-		       be16_to_cpu(ecdb_ahdr->ahslength) - 1);
+		memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb, cdb_length - ISCSI_CDB_SIZE);
 	}
 
 	data_direction = (hdr->flags & ISCSI_FLAG_CMD_WRITE) ? DMA_TO_DEVICE :
-- 
2.43.0


