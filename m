Return-Path: <linux-scsi+bounces-24091-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNHcNeX+FGp2SAcAu9opvQ
	(envelope-from <linux-scsi+bounces-24091-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 26 May 2026 04:01:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 450E55CFA51
	for <lists+linux-scsi@lfdr.de>; Tue, 26 May 2026 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 278AD3039C83
	for <lists+linux-scsi@lfdr.de>; Tue, 26 May 2026 01:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041342E1F0E;
	Tue, 26 May 2026 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="cuVtSabS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52242E1722;
	Tue, 26 May 2026 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760558; cv=none; b=kVnv5crQJgIILp/lscNi04dUm3spv2Ik3d4Sal9U+WQHhjxZB0t6/zCNuioTioH82nMhMoDrUXtp/SvUaJPkcGC4WOmcX4e4kEU3pJ1BitvDYHTNrIdRkzkNKCACzr9Oi+oeOZ9DkvZ1Ih6Dqe/nXFqwgcaBqKBrOfcJ+7WvE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760558; c=relaxed/simple;
	bh=gfD5WYsHjzAUb1KEsAxt/QC+d62ywVNzw23fr5UeDgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gTtg3/Y2ZvjFuzBprtWIb+1RXf8W5yqJzdM2wwLTntWfESkND4iAlmqnH7n3Q9/gUg4aUpn4rsdrkRmrl7o8FYzBDTbNADBVmDq9J8kpA6iWGBU6aq9DF4wifBqRUnLOZ0vbJv0OjtZwNPNofekzTAPHhDEwt1611qfuRI8KMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=cuVtSabS; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4SxuhIeypZAIc27WTBGqvMTk4wcf0a0JHAGZVxiIjbo=;
	b=cuVtSabScudeQr0ySkLZVUc/iO7l3OpYmvuZzKAkDE9nQlubHHZLD7YEppD6UHod3VU8ULBKL
	2bmhXTQoTqCIH4J3yvU1RzugJg+e9vIgOrL3wEk+krhijYTso2kCjIOTGcu7qYhd+SIaifp/Uwp
	5DXQhLBXlo3Q7EVKliJn6GY=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gPbHS43bwzLlTj;
	Tue, 26 May 2026 09:48:04 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B12B4055B;
	Tue, 26 May 2026 09:55:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 26 May 2026 09:55:48 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <yangxingui@huawei.com>,
	<liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v4 0/2] libsas: rediscover improvements for linkrate/sas_addr changes
Date: Tue, 26 May 2026 09:54:16 +0800
Message-ID: <20260526015418.2022398-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-24091-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,h-partners.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 450E55CFA51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a device attached to an expander phy experiences a linkrate change
(e.g., due to cable reconnection or negotiation), the current code in
sas_rediscover_dev() treats it as "broadcast flutter" and takes no action
if the SAS address and device type remain unchanged.

This series is based on John Garry's suggestion [1] to check the linkrate
and mark the device as gone and rediscover when flutter occurs, replacing
the previous v2 patch series that used lldd callbacks.

The previous v2 approach added lldd_dev_info_update callback which John
commented as "seem fragile and too specialized" [2]. This series adopts
a simpler approach that directly checks linkrate/sas_addr changes in
sas_rediscover_dev() and triggers rediscovery using libsas's standard
async discovery pattern.

This aligns with Jason Yan's earlier work [3] which was verified to
solve the linkrate change issue.

Additionally, per the discussion in v3 [4], the existing replace code
path also suffers from the same sysfs duplication issue: 
sas_unregister_devs_sas_addr() only marks the device as gone, but the
actual sysfs cleanup happens later in sas_destruct_devices(). Calling
sas_discover_new() immediately after unregister causes sysfs_warn_dup()
errors. This series also optimizes the replace path to use the async
pattern, ensuring proper ordering for both flutter and replace cases.

Changes from v3:
- Also optimize the replace code path to use async discovery pattern
- Introduce sas_is_flutter() and sas_rediscover_phy() helpers
  to encapsulate the flutter handling logic and avoid function bloat
- Fix replace code path sysfs duplication issue

Changes from v2:
- Drop lldd_dev_info_update callback approach per John Garry's suggestion
- Drop hisi_sas specific changes (no longer needed without callback)
- Use libsas's async discovery pattern for rediscovery
- Add sas_addr change detection alongside linkrate change

Changes from v1:
- Split into three patches

[1] https://lore.kernel.org/linux-scsi/c4e4c99f-a13c-4e28-8650-48be1f96d7cf@oracle.com/
[2] https://lore.kernel.org/linux-scsi/28bd9d5b-f597-0aae-5340-bd951b2083aa@huawei.com/
[3] https://lore.kernel.org/linux-scsi/20190130082412.9357-6-yanaijie@huawei.com/
[4] https://lore.kernel.org/linux-scsi/b99cd59f-b986-432e-aaf1-3b757e1c4c34@oracle.com/

Xingui Yang (2):
  scsi: libsas: refactor sas_ex_to_ata() using new helper
    sas_ex_to_dev()
  scsi: libsas: Add linkrate and sas_addr change detection in rediscover

 drivers/scsi/libsas/sas_expander.c | 79 +++++++++++++++++++++++-------
 drivers/scsi/libsas/sas_internal.h |  1 +
 2 files changed, 62 insertions(+), 18 deletions(-)

-- 
2.43.0


