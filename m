Return-Path: <linux-scsi+bounces-23759-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFFyJUDfA2qA/gEAu9opvQ
	(envelope-from <linux-scsi+bounces-23759-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 04:17:36 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B352C35D
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 04:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C734D302FF88
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 02:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084F38655B;
	Wed, 13 May 2026 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="j1MeNNT0"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5981A23A6;
	Wed, 13 May 2026 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638637; cv=none; b=Hs6A0FdnsY/BB+TSnLShcOQeMqp9klK8UyhhliaFLn7olomo+RSWOgBb2MlZbrBaOruHlcV4KT6TULCvSDKnSwb+5eINXRwlWMaQFcQT+e6hJLD/7IhO91a6MdwKWW8BqoOxUnuomhglsqsmPZs2YNkU+Fk/wyJMXAwVSJbsncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638637; c=relaxed/simple;
	bh=ryWSDy1Ny1XY6lrUx0izSCHBnn3hQRwgtCnTHi7uMkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecOQ9qKzJhLVc/hwu28r+dAN73j+5izuV/gRjv26C5601kCXXYsXWxf6JHP87wiaUKTH3VgcLAO5+VZHrKeReMGm6Is7fBPnZjbM3btDtjGneHjtH2U68is0RBxW1ZgkoM2tGfxxayZriZzAdrIpY3QdqTQxueCUXA8hND/50Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=j1MeNNT0; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FDvvwxrcvJxzNX1p5Xv0AQLP6vrc2nExn3GXqVJN1C8=;
	b=j1MeNNT0HWBCqWB06cEKKr3NANIFaUKaqeK+dWaUKqYYihEkchsLWIR9qNPYdZ7osiAFH6BEd
	EXibTKPBBe8nmlWF38WMBq93RAlOh77irXH2uLxK9Yf7DxKrqOD2iTT+QSfMFj7gF7OeCfG7b7b
	8uw87P0OfyZ2nQgZDJX+Y2g=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gFcNH3ZH6zRhTw;
	Wed, 13 May 2026 10:09:35 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 137DA202E6;
	Wed, 13 May 2026 10:17:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 10:17:11 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <yangxingui@huawei.com>,
	<liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v2 0/3] scsi: libsas: handle linkrate change in sas_rediscover_dev 
Date: Wed, 13 May 2026 10:16:00 +0800
Message-ID: <20260513021603.3023329-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Queue-Id: A23B352C35D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	TAGGED_FROM(0.00)[bounces-23759-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,h-partners.com:dkim]
X-Rspamd-Action: no action

When a device attached to an expander phy experiences a linkrate change
(e.g., due to cable reconnection or negotiation), the current code in
sas_rediscover_dev() treats it as "broadcast flutter" and takes no action
if the SAS address and device type remain unchanged.

However, for drivers like hisi_sas, the ITCT entry needs to be updated
to reflect the new linkrate. Without this update, the hardware continues
using stale linkrate information, which can cause performance issues or
protocol errors.

This series introduces a new LLDD callback lldd_dev_info_update() to
notify the low-level driver when a device's information changes, allowing
the driver to update its hardware structures accordingly. The callback
is designed to be extensible for future device information updates beyond
linkrate changes.

Changes from v1:
- Split into three patches.

Xingui Yang (3):
  scsi: libsas: refactor sas_ex_to_ata() using new helper
    sas_ex_to_dev()
  scsi: libsas: add lldd_dev_info_update callback for device info
    changes
  scsi: hisi_sas: add support for dev info update notification

 drivers/scsi/hisi_sas/hisi_sas_main.c | 16 ++++++++++++++++
 drivers/scsi/libsas/sas_discover.c    | 12 ++++++++++++
 drivers/scsi/libsas/sas_expander.c    | 25 +++++++++++++++++++------
 drivers/scsi/libsas/sas_internal.h    |  2 ++
 include/scsi/libsas.h                 |  1 +
 5 files changed, 50 insertions(+), 6 deletions(-)

-- 
2.43.0


