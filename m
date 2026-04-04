Return-Path: <linux-scsi+bounces-22775-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bwjcD3N10WkEKAcAu9opvQ
	(envelope-from <linux-scsi+bounces-22775-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Apr 2026 22:32:51 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A739C676
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Apr 2026 22:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07E06300CC02
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Apr 2026 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C95242D7F;
	Sat,  4 Apr 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwAF9Pm2"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CE1A23B9;
	Sat,  4 Apr 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775334765; cv=none; b=k+y2NlENFGMMB0ljcf5qeuVPQRPX8QescDD8gFDQ89BzTuzJZSTjBZLH87AEmATfsadZShLiSNLZBG7kDd/A5sSvCV3hJ5eqjnemJWiv1mDLPOqHTgL4/OwFySQSXFtdgGkmzTKsi+944GN80FZieR0LagOwbACM/OuCa4y7mQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775334765; c=relaxed/simple;
	bh=56YgknKY5wqtgqdVwaOiDf9IfnG3xlQ71H3eLacWOhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAMK+1+vNkBrWSnMGbJwLZg336S9U8X+kYBGXWm+sb2xIfJD5YGODbKlpKZm5oMdwl+YzSl++4IOwVExJW7YbP1/5mXaxDGmD/9MIcmWDowaP4dNAxtcvsXdw2U8GNwhyivd73IOYjt3UkkTDmj15ZEiMRB9mbGhg0WBx5GbqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwAF9Pm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB871C19421;
	Sat,  4 Apr 2026 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775334765;
	bh=56YgknKY5wqtgqdVwaOiDf9IfnG3xlQ71H3eLacWOhU=;
	h=From:To:Cc:Subject:Date:From;
	b=BwAF9Pm2MLndEs9UFPegvs7311FXakIaHr/6c2nqAZYGQ4DokOuV8xHnVnmtWAJiI
	 db547OtAhoA6f8wQ213vMJBpbofOkHSO3823+c7ACVcZWi0jXnNbe3RAUTD1vWaUyi
	 0hFeUWgxVh8/omv3+Nb6YMhydFCpGCusNzQEKD3aAj3EoDLpo/+TPMukbFupuJ7NSa
	 GfbTV4Vb+x1XJcu7exBVoTsy2Yrq6AQ/l8+ZLD+8SRCyBttx7YuTUgpnNifotln9MU
	 P8XggP+8GkoG/Cqar7uW3ys9Av3gQcM9wVuUviSQilMNcgsg9r36qy4AUlwJQALd3P
	 v+ypPBhmjY68Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] scsi: iscsi_tcp: Remove unneeded selections of CRYPTO and CRYPTO_MD5
Date: Sat,  4 Apr 2026 13:30:03 -0700
Message-ID: <20260404203003.33738-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22775-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C0A739C676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As far as I can tell, CRYPTO_MD5 has been unnecessary here ever since it
was added by commit c899e4ef96f0 ("[SCSI] open-iscsi/linux-iscsi-5
Initiator: Kconfig update") in 2005.

CRYPTO was needed until commit 92186c1455a2 ("scsi: iscsi_tcp: Switch to
using the crc32c library"), but is no longer needed.

Remove these unnecessary kconfig selections.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch is targeting the scsi tree

 drivers/scsi/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index f811ce473c2ab..fc8e8b0bfa391 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -302,12 +302,10 @@ if SCSI_LOWLEVEL && SCSI
 
 config ISCSI_TCP
 	tristate "iSCSI Initiator over TCP/IP"
 	depends on SCSI && INET
 	select CRC32
-	select CRYPTO
-	select CRYPTO_MD5
 	select SCSI_ISCSI_ATTRS
 	help
 	 The iSCSI Driver provides a host with the ability to access storage
 	 through an IP network. The driver uses the iSCSI protocol to transport
 	 SCSI requests and responses over a TCP/IP network between the host

base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
-- 
2.53.0


