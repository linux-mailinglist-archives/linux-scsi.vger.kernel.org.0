Return-Path: <linux-scsi+bounces-23041-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAFTNBEh4mlX1wAAu9opvQ
	(envelope-from <linux-scsi+bounces-23041-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 14:01:21 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A941B059
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 14:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673FB304E0F6
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9CF397683;
	Fri, 17 Apr 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ezjUUEt2"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0863368B6
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427100; cv=none; b=t9zXuesSWOErJ/Pn2fgZN9EduR9qKlTbvb0P72I/EIBThPApN+hVL9Fp70Ch+VDUkyWMEfrKR9kjuWUfIjdlfcj2ZFZz8SEzvDQ/fiqbqQnZ/BbXG+OeZmlt1JezckIfhQf3GlHTRhM90szmGEuDqzBjpKDLfOLHHi2PpbYcF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427100; c=relaxed/simple;
	bh=AInRQBnQ/YZQeTI74gewBGmfDMTkKnIh/m+dn4GfF98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=r3eb7b+tR+1pZZ7oEs9JBzwp6eYJL/MpDzXBZmjMasZRzYnBpDjYRPbjfl7dcuitA9yY0OrExkZwWA3T0kGjL4UnJjzoTya71WAzRqGwTsfaRMO5GZbvwlHDbZUUmKKTI+1DXjZLObepcUXDquddyEWlHfch0JT7VNCZRfjTyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ezjUUEt2; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260417115816epoutp0407cf45f2d10a1bc8661fa2f2ddd1cf47~nIwgub5pY3274832748epoutp04Y
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 11:58:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260417115816epoutp0407cf45f2d10a1bc8661fa2f2ddd1cf47~nIwgub5pY3274832748epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776427096;
	bh=iR31O3jFN8Z6FI7niZtsdXUfGMGP5z7RAKAyfUfD5rk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ezjUUEt2m1lOk0MuZjl3V4h4NUvidpa0yg768JwPJvEwqEw7O3uJfcv4Qy7GCyXoN
	 X6tdKAXAMILjz2Lpu3jx/jloPBVg2kbA8Lqj5o7JzIFHTfMmEz4FuYS2nvKTwKTJ++
	 Z8iuEQicJS2GVRfyRrBkGEuEbU6pg5hFwAC2SArQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260417115815epcas5p37d35940fccf6778b79000a1e988e155c~nIwgQQozj2038220382epcas5p3U;
	Fri, 17 Apr 2026 11:58:15 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fxtgV41d5z2SSKZ; Fri, 17 Apr
	2026 11:58:14 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260417115813epcas5p40234b872c221ce28981b17e42ca48139~nIweg_REp1715017150epcas5p4X;
	Fri, 17 Apr 2026 11:58:13 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260417115809epsmtip220bab86acb93e11cdea6f4e8effbd76f~nIwa6WK8f0861308613epsmtip2S;
	Fri, 17 Apr 2026 11:58:09 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	martin.petersen@oracle.com, krzk+dt@kernel.org
Cc: sowon.na@samsung.com, peter.griffin@linaro.org,
	linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Alim Akhtar
	<alim.akhtar@samsung.com>
Subject: [PATCH v2 0/4] add ufs support for Exynosautov920 SoC
Date: Fri, 17 Apr 2026 17:44:48 +0530
Message-Id: <20260417121452.827054-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260417115813epcas5p40234b872c221ce28981b17e42ca48139
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260417115813epcas5p40234b872c221ce28981b17e42ca48139
References: <CGME20260417115813epcas5p40234b872c221ce28981b17e42ca48139@epcas5p4.samsung.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-23041-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:dkim,samsung.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alim.akhtar@samsung.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E02A941B059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds ufs driver support for ExynosAutov920,
ExynosAutov920 has the UFSHCI 3.1 compliant UFS controller.

ExynosAutov920 has a different mask of UFS sharability from ExynosAutov9,
so this series provide flexible parameter for the mask.

With this series applied, UFS is functional and basic I/O operations are 
known to be working.

Changes since v1:
* collected Acked-by on patch 2/4
	* This Acked-by from Krzysztof was long back, for now kept it 
* rebased on linux-next
* fixed few self review comments
* split dtsi patch into two, separated out syscon node patch

Link v1:
https://lore.kernel.org/linux-samsung-soc/20250702013316.2837427-1-sowon.na@samsung.com/

Alim Akhtar (1):
  arm64: dts: exynosautov920: Add syscon hsi2 node

Sowon Na (3):
  dt-bindings: ufs: exynos: add ExynosAutov920 compatible string
  scsi: ufs: exynos: add support for ExynosAutov920 SoC
  arm64: dts: exynosautov920: enable support for ufs controller

 .../bindings/ufs/samsung,exynos-ufs.yaml      |   1 +
 .../boot/dts/exynos/exynosautov920-sadk.dts   |   8 ++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  27 +++++
 drivers/ufs/host/ufs-exynos.c                 | 110 ++++++++++++++++++
 4 files changed, 146 insertions(+)


base-commit: 452c3b1ea875276105ac90ba474f72b4cd9b77a2
-- 
2.34.1


