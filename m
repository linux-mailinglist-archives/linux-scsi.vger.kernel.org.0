Return-Path: <linux-scsi+bounces-23436-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wS+YJwQi8mlnoQEAu9opvQ
	(envelope-from <linux-scsi+bounces-23436-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 17:21:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C977496BCD
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3C9E30451E1
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2026 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131C37754B;
	Wed, 29 Apr 2026 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjaYYV3k"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0C2F745C;
	Wed, 29 Apr 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475798; cv=none; b=Ro5QzPmKhT9OCnQmN696ZAYREgMB+aLnAI0N+mMta+t4FY48pDTQ5ODEJTi9Igm6p5ex97o0jKZZIyg4cIWtz5/2JfmBsqykJlFgQWR5meakYiSLIPVCixl4649MoEKdxay9tvtQNJvXim5a+1EuMPtaqgXtnSShhUXmdJXb/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475798; c=relaxed/simple;
	bh=hDm09YBYrAz6Ma5GI1suFLSOqs30AeX8Z5+RgIebBbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m2BfNQ8rdvxnCc+7utpVcZBYQi8Md2UBFHnP8OgtVznO65ehXu4bced5hr6aqLps9lNkkZfZIRCefHX0ihnF2c9Nhq1Jb7xxOTpvHAJjKrQXiDQbr/ik0JZ3rHJFDhdu+w9sOV3zFe2dj/PbhV8Ekb9DsWy6ZDAVpgP5MTctyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjaYYV3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6924C2BCB8;
	Wed, 29 Apr 2026 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475797;
	bh=hDm09YBYrAz6Ma5GI1suFLSOqs30AeX8Z5+RgIebBbY=;
	h=From:To:Cc:Subject:Date:From;
	b=kjaYYV3kdG0UT4lwZ83UTsKMhrkx6wo7QlCdtAcytYMU2gqPnyB2b1xoqoW5wfXFD
	 aGzC6sUhThA5J70uD1Y/30tSr0Dq0aAvw5g2SyBSATAMjrq8dSkVFe695JilgiDiRw
	 6dGtAomtHnf6CME390YW39JOjQqm2F9yAzKzl3c4oTGl5pqS2btN7vPdMYuQ2Ou0lf
	 5Bmx8TZBi21RONsCiB+Ngc6w9Kz/eehHwPA5cx9YQuNP4/g7leHC5uY5ZwqlvqmMzK
	 TbTOQoImFACJ1tQKWqZr6sNpKTkHmuNVNASkXPa2fWNI5AqQ+0a+Fzrwc+NiCdYxcH
	 ssuloN5FK9VGA==
From: Arnd Bergmann <arnd@kernel.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: advansys: drop ISA_DMA_API remnants
Date: Wed, 29 Apr 2026 17:15:37 +0200
Message-Id: <20260429151623.3899875-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C977496BCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23436-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email]

From: Arnd Bergmann <arnd@arndb.de>

Support for ISA bus mastering was removed a few years ago, and the VLB
mode does not use the ISA DMA API, so drop the dependency and the
header inclusion.

Fixes: 9b4c8eaa68d0 ("advansys: remove ISA support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
There are only a couple of ISA_DMA_API users remaining in the tree
after the ethernet driver spring cleaning, so I noticed this one.

There is now only one SCSI driver remaining that uses ISA DMA,
the aha1542 ISA support, which is also the only ISA DMA bus master
driver in the tree now
---
 drivers/scsi/Kconfig    | 1 -
 drivers/scsi/advansys.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index fc8e8b0bfa39..c3042393af23 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -474,7 +474,6 @@ config SCSI_ADVANSYS
 	tristate "AdvanSys SCSI support"
 	depends on SCSI
 	depends on (ISA || EISA || PCI) && HAS_IOPORT
-	depends on ISA_DMA_API || !ISA
 	help
 	  This is a driver for all SCSI host adapters manufactured by
 	  AdvanSys. It is documented in the kernel source in
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index fcf059bf41e8..5cdbf2bdb13d 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -36,7 +36,6 @@
 #include <linux/dmapool.h>
 
 #include <asm/io.h>
-#include <asm/dma.h>
 
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
-- 
2.39.5


