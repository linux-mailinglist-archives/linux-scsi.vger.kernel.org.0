Return-Path: <linux-scsi+bounces-24990-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DXowLybBMGpcXAUAu9opvQ
	(envelope-from <linux-scsi+bounces-24990-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 05:21:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E98E68BACE
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 05:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=mssvMQH0;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24990-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24990-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8843024A6D
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 03:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D637C108;
	Tue, 16 Jun 2026 03:21:04 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849861D5CC6;
	Tue, 16 Jun 2026 03:21:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781580064; cv=none; b=dV6cmVR/BNP7FHoVd9MrU70xn6Cuo0rKgvLYDsUCf7f+0QughO4Xk0x+ktrOU2ZKyJ8P40Fs1BNyAJsI2jQPK0gVOBNuMkHsS7KyY/yhvXb5jZvimUlkXrssCZsV3aZRr9hkE7dQsrutmyW+h6EisD4Fj61eiT9G6hxNYEaFx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781580064; c=relaxed/simple;
	bh=/EL8eY2TL2jS5EME0l0RSpLQKHeeeOrW3A9XU0Uruio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3SRlyhky0OroUUyqxOlXZ8Jqh6NNhIszPw/Kn4ff89i1lLJxhITwIm7fZgSeLnX05JMui6/l4uv3kv6V19GIN00ExABKLVTbSzhNTK8bFlidSYQWo2/uhgIzXwrHH1XBGbemXSrEWWabSUpXmlCEv8YHSaeooBHmjULcXtOgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=mssvMQH0; arc=none smtp.client-ip=113.46.200.226
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q94PVf8v6G7U6GL6rHV4xkPFDzwEYfzuShR0rVa3Tts=;
	b=mssvMQH0dKvhGQRQz8T+etgzfm017RbFui58bRI7KWlnjzwm1G1RXGEVJwp7gMFk9JMraprY0
	aMX0/BdeVT9dNhifutLvXXzhqwZ4jY7E2JkMtqmCu+B6VP3jZX1DkiRn0JH+bV2UOgA8cRc4l3M
	RbAOgJ5DgNrM4PM4pWzCd4s=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gfX9c4x6czKmT3;
	Tue, 16 Jun 2026 11:12:52 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id E5216405D1;
	Tue, 16 Jun 2026 11:20:52 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 11:20:52 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH] MAINTAINERS: Update HiSilicon hisi_sas driver maintainer to Xingui Yang
Date: Tue, 16 Jun 2026 11:20:51 +0800
Message-ID: <20260616032051.1268608-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh200005.china.huawei.com (7.202.181.112)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-24990-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:liyihang9@h-partners.com,m:liuyonglong@huawei.com,m:prime.zeng@hisilicon.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[liyihang9@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyihang9@huawei.com,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[h-partners.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,hisilicon.com:url,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E98E68BACE

Replace myself with Xingui Yang who is very familiar with the HiSilicon
hisi_sas drivers.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a068db0ade61..6760865a2bad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11675,7 +11675,7 @@ F:	Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
 F:	drivers/infiniband/hw/hns/
 
 HISILICON SAS Controller
-M:	Yihang Li <liyihang9@h-partners.com>
+M:	Xingui Yang <yangxingui@huawei.com>
 S:	Supported
 W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
-- 
2.33.0


