Return-Path: <linux-scsi+bounces-25691-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 92SVGq9sTGpmkQEAu9opvQ
	(envelope-from <linux-scsi+bounces-25691-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 05:04:15 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC66716EDA
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 05:04:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=WHxwbJTt;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25691-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25691-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8691F301FCBE
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52513B293;
	Tue,  7 Jul 2026 03:04:13 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E07361DBC
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 03:04:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393453; cv=none; b=jpXbcbJhAI2IkDZwN7uUicVHW4S9gvmQrwLIqUG0RTWmc0cO/h/CdMaQiNwMD1tnhQ0xBq8hgADz6CGYWOG38kLvWQ/1RXJZUXM13PpsI15HpnHsf+2yNEc7DsoPXMYBS29vBJ3cvmeLOqUwFoCQOM6IlJ1aRtrkfuBO6P+GCCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393453; c=relaxed/simple;
	bh=y5a3OE0k/8/6gWfjddV1XTAcLVVv8B2tohQkZ49pdT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGSAfAVAp7mEz6HYmYL609jf/0MsBYLM1Cnz5+BsJ1ez5Fh7Xnh/xLlNwIO/F10lMj+c0zzEd2jht9dOzVFjJY/HteWHPwgf0SkEkcxYAQdKW4t26GQhIrshP7gKKzEYRe4CgnBigTMa4xoH0t6Ed2Ty/ELlAP/htCwkN24v7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WHxwbJTt; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0/
	BFxGjLblaJf+NoLFVJCRBzW2ZNSULKWoQDBqKVYGw=; b=WHxwbJTteE7qh4Ni0M
	7yL6q7Nb3NPY3Z7aqFbZ/RhBeMqmh1D9BU4EWuHweJ/hiSsRoZMiAer1+XXT9Yck
	bpJvJ66zmBd2L+wrBSlU9b8YotNpfuKYnYR0ZeumJVAmgkYa0RYKWsEhEk+IqWR9
	sKjlE8sz3hPVJtigBokLQx/MY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3HB2HbExqrYb5Fw--.30099S3;
	Tue, 07 Jul 2026 11:03:39 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: dlemoal@kernel.org,
	linux-scsi@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v2 1/3] scsi: sd: fix error handling in sd_probe() after large pool creation failure
Date: Tue,  7 Jul 2026 11:03:31 +0800
Message-Id: <20260707030333.22245-2-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260707030333.22245-1-yangxiuwei@kylinos.cn>
References: <20260707030333.22245-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3HB2HbExqrYb5Fw--.30099S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4xJF4UZw1DXw45Ar1UZFb_yoWftrc_ur
	409rZ7Wr1Ykr4xG3ZFkw1Yvry0vrsagr48ur48tFyrJ3yjq39YvFWFvrn8Ca1UW39rAr1U
	A3WDZr1Syw4DGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0niSPUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwgvqe2pMbIsESAAA3V
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:dlemoal@kernel.org,m:linux-scsi@vger.kernel.org,m:yangxiuwei@kylinos.cn,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25691-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AC66716EDA

After device_add(&sdkp->disk_dev) succeeds, sd_large_pool_create()
failure must unregister disk_dev and let scsi_disk_release() free
sdkp. Going through out_free_index kfree()s an already registered
device and leaks the sysfs entry.

Fixes: 7179e626b76e ("scsi: sd: Enable sector size > PAGE_SIZE in SCSI sd driver")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 drivers/scsi/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 599e75f33334..d18693d390b2 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4089,7 +4089,9 @@ static int sd_probe(struct scsi_device *sdp)
 	if (sdp->sector_size > PAGE_SIZE) {
 		if (sd_large_pool_create()) {
 			error = -ENOMEM;
-			goto out_free_index;
+			device_unregister(&sdkp->disk_dev);
+			put_disk(gd);
+			goto out;
 		}
 	}
 
-- 
2.25.1


