Return-Path: <linux-scsi+bounces-25192-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hMaKJc1ZOmpB6wcAu9opvQ
	(envelope-from <linux-scsi+bounces-25192-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 12:02:53 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D23CE6B60B8
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 12:02:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=LieeMFXG;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25192-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25192-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC1C5300862F
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADFA30D3F6;
	Tue, 23 Jun 2026 10:02:46 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90482D7DEF
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 10:02:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208966; cv=none; b=o+FzRDp39drsBdhgbrMWZUN3wt7P2T9jmvR92vWlT5FG41OEKsEsXmZ+20gEpGSllvs0dMT/aDK9LTSOg4Or3fzwg516QEn4LoN+ZWPp1hLLv8NGs6OsUQSt/+w1omQ99M0YNSpCaA2V5kyVE2tniHenUl1VL7zhxDCBk6IH4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208966; c=relaxed/simple;
	bh=Io5JroLQDTpd8+NJd9T//DiaBnmcPaHgKzDeOQTTdBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aBAIyNursjoVuQrVs+Vqpx1/2x6AQvVZ2qiQ3TvaCSghnJw6vroryZOUh9KXWA7BT8XmcrFZlgxDPfqm+yXx3lAMUPZGtaod4W36J+HWDy/9Fp5v399HHJWdJZTVoWUZt76BaPi2dY8+RZArrkHDLtSVZJuLLAAFbVRJrHBwI5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LieeMFXG; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9d
	MGFFlM/VbKYpFk6P8CWjd6H8GtHSF6qm5cx5Ee0+s=; b=LieeMFXGGeYonEu1uH
	LIr8EwvRTi8601oEtQ4FYeh22V+5xRTa9SEnEoGFwMTBpren57V8V0aMHC2anXDk
	21wfAAZzOJ0PKZJ9i+mTxtQ85dgFXeIalop1H5DBCw+GBMZtkd/oaAPbsrdmxYxX
	i7OpVeSKJZUrgYebitxHCJfh8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAntXCaWTpqUiV6FA--.20165S3;
	Tue, 23 Jun 2026 18:02:04 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com
Cc: hare@suse.de,
	tom.leiming@gmail.com,
	p.raghav@samsung.com,
	dlemoal@kernel.org,
	sw.prabhu6@gmail.com,
	linux-scsi@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v1 1/4] scsi: sd: fix error handling in sd_probe() after large pool creation failure
Date: Tue, 23 Jun 2026 18:01:56 +0800
Message-Id: <20260623100159.4018066-2-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623100159.4018066-1-yangxiuwei@kylinos.cn>
References: <20260623100159.4018066-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAntXCaWTpqUiV6FA--.20165S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4xJF4UZw1DXw45Ar1UZFb_yoWfWFX_ur
	4I9397Wr1Ykr4xG3ZFkw1Yvry0vrsagr48ur4rtF95J3y2q39avFW0vrn8Ca1UW3y7ur1r
	Aw1jvr1Syw4kGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0YsjUUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwh2mN2o6WZ3k2AAA3m
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25192-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:hare@suse.de,m:tom.leiming@gmail.com,m:p.raghav@samsung.com,m:dlemoal@kernel.org,m:sw.prabhu6@gmail.com,m:linux-scsi@vger.kernel.org,m:yangxiuwei@kylinos.cn,m:tomleiming@gmail.com,m:swprabhu6@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,samsung.com,kernel.org,vger.kernel.org,kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D23CE6B60B8

After device_add(&sdkp->disk_dev) succeeds, sd_large_pool_create()
failure must unregister disk_dev and let scsi_disk_release() free
sdkp. Going through out_free_index kfree()s an already registered
device and leaks the sysfs entry.

Fixes: 7179e626b76e ("scsi: sd: Enable sector size > PAGE_SIZE in SCSI sd driver")
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


