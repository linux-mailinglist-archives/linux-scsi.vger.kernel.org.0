Return-Path: <linux-scsi+bounces-24325-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDLCGDqJHWrAbQkAu9opvQ
	(envelope-from <linux-scsi+bounces-24325-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 15:29:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF366200AB
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B16113049E25
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Jun 2026 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6A38655A;
	Mon,  1 Jun 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leap-io-kernel.com header.i=@leap-io-kernel.com header.b="jT1hpTjc"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m1973191.qiye.163.com (mail-m1973191.qiye.163.com [220.197.31.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793A3546EA
	for <linux-scsi@vger.kernel.org>; Mon,  1 Jun 2026 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320200; cv=none; b=G1MpTmE7MsMJ63SavPhqVi3Z3NU9R/5B/1ZoFEjjjUJRbdEwIEMtmF1oBgo6M25sP/URPqhom1cRo891CUB5t15Q+vHy3bb8K0rtsDKcDFXK55QIX59gNRM5eLWcd4SXS/yTvbfCyf9SHnFJJIpaZhA85YV+iviDES7zotuqYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320200; c=relaxed/simple;
	bh=b8sikl8mGUh0lYKMnMqJbgwqFYGSZZrRtuCfgbcx3Bs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=obeopgsuAsBmVIkOTxohCx4PRM58KdfQp2nPP26xUwB2mbyDIaff8VNQj6eBgpXHsaBpdic75lVobAgUH32Dn3cH2mbvTSQdO/wHBvFQmF+qTd/JeUOYjjsf4YKuTDtmhGcAL+yvmYZtY+NkHZNxXYfVAwIvZV/yexTNWlBgPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leap-io-kernel.com; spf=pass smtp.mailfrom=leap-io-kernel.com; dkim=pass (2048-bit key) header.d=leap-io-kernel.com header.i=@leap-io-kernel.com header.b=jT1hpTjc; arc=none smtp.client-ip=220.197.31.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leap-io-kernel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leap-io-kernel.com
Received: from localhost.localdomain (unknown [222.130.22.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4099a3dfe;
	Mon, 1 Jun 2026 20:07:36 +0800 (GMT+08:00)
From: Dongdong Hao <doubled@leap-io-kernel.com>
To: doubled@leap-io-kernel.com,
	yjzhang@leap-io-kernel.com,
	kezijie@leap-io-kernel.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH 0/2] scsi: leapraid: Add new scsi driver
Date: Mon,  1 Jun 2026 20:07:33 +0800
Message-Id: <cover.1780312123.git.doubled@leap-io-kernel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e83150f5c03aekunm9d8d0e6d637b46
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE5OVksfQk8aT0xJTEMfTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkhLVUlJVUlPSVlXWRYaDxIVHRRZQVlPS0hVSk
	tISk9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=jT1hpTjc3PyhsadtiX4rTR2rWK5A4cQHu/OJJxIyd0NljYUNb5PBjngJSKvbO37xpcPECo2KsQ8hXjmB5ACcgSuk8BjGumOpDKKhPx/U79kE3k0eRoZXRLV6MD6MLnnBItw50XAoQOibXcWMmur7cKSrZEF56gb+locr+5hfEA72l3z4fVK/by/vFSaJt0ifjS7XOgu4T9wqhHOjfxw8UUtQ7804IQfIlkvKaVo3hW6lcbNNLx7eRZ9U4GcHxl2CaSllBPQDGxBP1MdjOPEJZs7VaEWYHWvfSluvTds07VF0kj1rnQ+lSFraGMPiFSiWfBgs0u5X7uvubhmugr2bBg==; c=relaxed/relaxed; s=default; d=leap-io-kernel.com; v=1;
	bh=GayGnWova0n+aBZrxwyFw0C3bbHcinI+vkKohLa5hzw=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[leap-io-kernel.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[leap-io-kernel.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24325-lists,linux-scsi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[leap-io-kernel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[doubled@leap-io-kernel.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,leap-io-kernel.com:mid,leap-io-kernel.com:dkim]
X-Rspamd-Queue-Id: 0CF366200AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dongdong Hao (2):
  scsi: leapraid: Add new scsi driver
  scsi: leapraid: Add driver documentation

 Documentation/scsi/index.rst               |    1 +
 Documentation/scsi/leapraid.rst            |  139 +
 MAINTAINERS                                |    7 +
 drivers/scsi/Kconfig                       |    1 +
 drivers/scsi/Makefile                      |    1 +
 drivers/scsi/leapraid/Kconfig              |   14 +
 drivers/scsi/leapraid/Makefile             |   10 +
 drivers/scsi/leapraid/leapraid.h           | 2071 +++++
 drivers/scsi/leapraid/leapraid_app.c       |  705 ++
 drivers/scsi/leapraid/leapraid_func.c      | 9053 ++++++++++++++++++++
 drivers/scsi/leapraid/leapraid_func.h      | 1566 ++++
 drivers/scsi/leapraid/leapraid_os.c        | 2516 ++++++
 drivers/scsi/leapraid/leapraid_transport.c | 1387 +++
 13 files changed, 17471 insertions(+)
 create mode 100644 Documentation/scsi/leapraid.rst
 create mode 100644 drivers/scsi/leapraid/Kconfig
 create mode 100644 drivers/scsi/leapraid/Makefile
 create mode 100644 drivers/scsi/leapraid/leapraid.h
 create mode 100644 drivers/scsi/leapraid/leapraid_app.c
 create mode 100644 drivers/scsi/leapraid/leapraid_func.c
 create mode 100644 drivers/scsi/leapraid/leapraid_func.h
 create mode 100644 drivers/scsi/leapraid/leapraid_os.c
 create mode 100644 drivers/scsi/leapraid/leapraid_transport.c

-- 
2.25.1


