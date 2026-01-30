Return-Path: <linux-scsi+bounces-20635-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sARTOYxlfGk/MQIAu9opvQ
	(envelope-from <linux-scsi+bounces-20635-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Jan 2026 09:02:20 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF04B81AA
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Jan 2026 09:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C363D300E39E
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Jan 2026 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACED2E62A2;
	Fri, 30 Jan 2026 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nCPrPp0q"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD3218821
	for <linux-scsi@vger.kernel.org>; Fri, 30 Jan 2026 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760138; cv=none; b=WkW+PCsjvpFUhEUDkzU5bL7bxsDyfonaAYfiV9JdjdK88ghWoHQTjvVM1ne3rg4Ebp19zqaYo866CCpmXoOAfNP8kSWTcpOB5nRAHG2e1Uax8Ymwp4BREBfJdoruHIsR2DSueDvzlx0p8WzYjCsdTNA6ix+7nCp6Ok/l5yECI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760138; c=relaxed/simple;
	bh=sTy9gTXaVVls+tbdgjS1MW+/hfk2s14b97d4VT+JjMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bD+9nR2QoFf0676V+VB0vrfhhRJo+4NnUZmWu/d2ANyXShCRbHdYsbZyzKpp6Fwv0Oj13VFdbKN84/NIGLUlSLLoKrYl7FPZMmoIG3EQ14X3OWE0xt4l3BKDi1S7ZBHyLdDj4aMzPESYgdMp78clCKlNV0bEu3ZM0/6MO5gQQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nCPrPp0q; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769760132; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PI78EppF0qajnP+iJpNVBjMc2/rU/DtGUnxDfFkUH3k=;
	b=nCPrPp0qMLGZQSf8fvSy9zvBzZP0MoHRVakAnKpfnDpSdZLPFXsm0X6nRhrO4GSqXK1JLdaBiusTc99dlosPsbijIcSlo8Zlk+qcsw77O3bKt51gbDKIsMeLpFFGBV2MwXVtrizaLiHoTKrBV2ju87rJ7QvGkdbjX2469n1zrck=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WyA5QkZ_1769760127 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 16:02:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: mpi3mr: Make driver probing asynchronously
Date: Fri, 30 Jan 2026 16:02:07 +0800
Message-Id: <20260130080207.90053-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20635-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kanie@linux.alibaba.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FF04B81AA
X-Rspamd-Action: no action

Speed up the boot process by using the asynchronous probing feature
supported by the kernel.

Set the PROBE_PREFER_ASYNCHRONOUS flag in the device_driver
structure so that the driver core probes in parallel.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index d4ca878d0886..99fb37fa4f6b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5983,7 +5983,10 @@ static struct pci_driver mpi3mr_pci_driver = {
 	.remove = mpi3mr_remove,
 	.shutdown = mpi3mr_shutdown,
 	.err_handler = &mpi3mr_err_handler,
-	.driver.pm = &mpi3mr_pm_ops,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = &mpi3mr_pm_ops,
+	},
 };
 
 static ssize_t event_counter_show(struct device_driver *dd, char *buf)
-- 
2.32.0.3.g01195cf9f


