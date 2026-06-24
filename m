Return-Path: <linux-scsi+bounces-25236-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uBEtMdh6O2otYggAu9opvQ
	(envelope-from <linux-scsi+bounces-25236-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 08:36:08 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259876BBCD7
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 08:36:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=MRtC46B4;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25236-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25236-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEEF3090A78
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jun 2026 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7BD388395;
	Wed, 24 Jun 2026 06:32:37 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B05388869;
	Wed, 24 Jun 2026 06:32:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282757; cv=none; b=d+fBNdBDr4tZZgppNN/57sXpP+B3CHyuJgHupyXMC7JLvu/mnADQrKXqrAwYH/ALqr6UufQKxsV88bIled5Sx9eq47pa22jORGqE01YW/ktWZZbC45NTwfTVPd/rPXgEmwbm95m+3kRD3fDzP5KfyoIa5K4ZkxH/nk7DAqFPdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282757; c=relaxed/simple;
	bh=nunaeUxm6Oi1BloG0S8khwa9UPU0axpZzQR8dqCMKh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f7Xsk9N/HqrAAMLVp0MsbPv0RESU93YKY7i/4CghBHkR0sjo8M2WrMC1mB9S66VZ7vFkTtFxEO6nuC416VaeHweedwVtKxa43YClOGiR92UJoJiRFyrdU/drKfhY0xBfc1ml3tUiVkbqGPTQgvsxfaGNwI5dngeHFyjTFl8dJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=MRtC46B4; arc=none smtp.client-ip=113.46.200.217
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+BTbCihoDFiln9oAh0INFZkbqXRaNOk5vk27Rm3YnwQ=;
	b=MRtC46B4wtckQ026gBv9MAfMq+Gh84CTZ+mKoqfu26fAmKSM0ANepYaKGRDo7zaLlwePL5G6O
	9wqFsrRU8ufR1kMBqCat78VJTQc1g3j/Nmu/IoQh7U2Yz+nqaCBZY8/fSF3AMgvPz+PdE/24Jk6
	CRvU4pCbbdxvBaWnOWiGHTI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4glX2K6fzMzcb13;
	Wed, 24 Jun 2026 14:23:53 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 378242012A;
	Wed, 24 Jun 2026 14:32:31 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 14:32:30 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <yangxingui@huawei.com>,
	<liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v9 0/2] libsas: rediscover improvements for linkrate/sas_addr changes
Date: Wed, 24 Jun 2026 14:32:28 +0800
Message-ID: <20260624063230.3264029-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-25236-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:yanaijie@huawei.com,m:jejb@linux.ibm.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:liyihang9@h-partners.com,m:yangxingui@huawei.com,m:liuyonglong@huawei.com,m:kangfenglong@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[h-partners.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,h-partners.com:dkim,vger.kernel.org:from_smtp,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 259876BBCD7

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

Changes from v8:
- In sas_dev_is_flutter(), call sas_ex_phy_discover() before
  sas_ex_to_dev() to ensure PHY state is always updated and to avoid
  use-after-free since the child device pointer is obtained after the
  sleeping SMP request completes, eliminating the need for kref
- Addressed Sashiko AI review [5][6] feedback on PHY discovery bypass
  and TOCTOU concerns

Changes from v7:
Addressed issues identified by Sashiko AI review [5][6]:
- In sas_dev_is_flutter(), reorder sas_addr check before linkrate check
  to ensure address restoration is not skipped when both change
  simultaneously, preventing device leak
- In sas_ex_to_dev(), add defensive NULL check for ex_dev to guard
  against callers passing a NULL device

Not addressed (pre-existing subsystem design):
- sas_find_dev_by_rphy() returns unreferenced pointer: subsystem-wide
  pattern used by 10+ call sites, should be a separate patch
- ex_phy->port TOCTOU: discovery path is serialized by disco_mutex,
  no race occurs in practice

Changes from v6:
- Add comment for restoring phy->attached_sas_addr to child_dev->sas_addr
- Optimize the conditional structure in sas_dev_is_flutter()

Changes from v5:
- In sas_addr change handling, restore phy->attached_sas_addr to
  child_dev->sas_addr before returning false, ensuring
  sas_unregister_devs_sas_addr() can properly match the device via
  sas_phy_match_dev_addr() for correct device unregistration

Changes from v4:
- Rename sas_rediscover_phy to sas_rediscover_ex_phy for consistency
  with expander phy symbol naming convention
- Rename sas_is_flutter to sas_dev_is_flutter per John's suggestion
- Check return value of sas_ex_phy_discover() for errors
- Factor out child_dev checks to improve code clarity

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
[5] https://lore.kernel.org/linux-scsi/20260611062530.3B6651F00898@smtp.kernel.org/
[6] https://lore.kernel.org/linux-scsi/20260611062833.357031F00893@smtp.kernel.org/


Xingui Yang (2):
  scsi: libsas: refactor sas_ex_to_ata() using new helper
    sas_ex_to_dev()
  scsi: libsas: Add linkrate and sas_addr change detection in rediscover

 drivers/scsi/libsas/sas_expander.c | 102 +++++++++++++++++++++++------
 drivers/scsi/libsas/sas_internal.h |   1 +
 2 files changed, 84 insertions(+), 19 deletions(-)

-- 
2.43.0


