Return-Path: <linux-scsi+bounces-25497-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 195uJlweR2q8TQAAu9opvQ
	(envelope-from <linux-scsi+bounces-25497-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 04:28:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC886FDE87
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 04:28:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=jxGCiCa7;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25497-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25497-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 834A2302ACC7
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E06265CD9;
	Fri,  3 Jul 2026 02:28:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D71A6807;
	Fri,  3 Jul 2026 02:28:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045721; cv=none; b=sv+oyMzxdl0e00G73ByCFHCFVh4DN8IbMbH5LdR7lXtUT20fXf+W5CJ1ul61S8e+/4asiiOPqV38Wx/tSUz+7I9cs0Hm2nwvgcOl3DFSuieQ3YPJYHxU8rHirzvbP6uV9HiblOgCfhyFz8Vhczlx93pifIT6C8K7bMoluCuyeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045721; c=relaxed/simple;
	bh=c0cdLC+hJRPInEpxcRbnWrcotPQJO1KLSKlqoVtUeGs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DzypmYRAH5MXd45VWEAZq4L39tuIo/9K60GvTTV3uxFWpBIx3ujwF/bduVWQtn0vTfDPXr1N3CSLSP398tymGFbYa7UUh79TCDWLNgmIDNAQYxaSSD+BZRmYf0IKwOmnoCuLSEZIa3uCQbqBeQNQhmvqtqG83Q825MUY7GLHDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=jxGCiCa7; arc=none smtp.client-ip=113.46.200.221
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=49Pofb5TdlkLBj7PQnskmHFYTGlaCtbu0uyBHb/GpgU=;
	b=jxGCiCa7EIlz8Ed5n+iehHoInhBYoD9ah6C0vZ8TN7T0wz4Bsl585hJAj3+xd/376QhGplMbP
	vp9vUdx0JYUeUcU2oDcMHLENtR4JKLQ5kqXoIf0XTLmD3w9i8Ahip09dKWb3Uv/QY+KJYra0MJv
	fej6WwFX6hnFBkTNgmr+Ttk=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gryB63lXWzRhRN;
	Fri,  3 Jul 2026 10:19:26 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id F295740577;
	Fri,  3 Jul 2026 10:28:35 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 10:28:35 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<john.g.garry@oracle.com>, <dlemoal@kernel.org>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <yangxingui@huawei.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
Subject: [PATCH v2 0/2] scsi: support spinup notification for SAS SSP devices in Active_Wait/Idle_Wait state
Date: Fri, 3 Jul 2026 10:28:31 +0800
Message-ID: <20260703022833.36847-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-25497-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:john.g.garry@oracle.com,m:dlemoal@kernel.org,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:yangxingui@huawei.com,m:liuyonglong@huawei.com,m:kangfenglong@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[h-partners.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AC886FDE87

When a SAS HDD connected via SSP (Serial Attached SCSI Protocol) is powered
up with the RNOT (Ready Not Optimized) bit set, the device enters the
Active_Wait or Idle_Wait power state per the SAS protocol specification. In
this state, the device does not respond to standard SCSI START_STOP spinup
commands and instead returns NOT_READY with ASC/ASCQ = 0x04/0x11 ("Logical
unit not ready, notify (enable spinup) required").

Without handling this condition, the SCSI mid-layer will indefinitely retry
the command with ACTION_DELAYED_RETRY, resulting in the disk never spinning
up and becoming unusable. A typical manifestation is:

  sd 4:0:9:0: [sde] Spinning up disk...
  ...not responding...
  sd 4:0:9:0: [sde] Sense Key : Not Ready
  sd 4:0:9:0: [sde] Add. Sense: Logical unit not ready, notify (enable spinup) required

To resolve this, the SAS controller needs to send a NOTIFY(ENABLE SPINUP)
primitive to the target phy, which transitions the device out of the waiting
state and allows normal spinup to proceed.

This patch series addresses the issue:

Adds a new optional spinup_notify callback to struct scsi_host_template
in the SCSI mid-layer. When ASC/ASCQ = 0x04/0x11 is detected in
scsi_io_completion_action(), the callback is invoked before the mid-layer
falls through to ACTION_DELAYED_RETRY, giving the LLDD an opportunity to
perform controller-specific spinup notification.

Changes in v2 (addressing Sashiko AI review on v1):
- Add softirq context documentation to spinup_notify in scsi_host.h
- Defer sl_notify_ssp() to ordered workqueue, fixing msleep-in-
  atomic bug, preventing RMW races on SL_CONTROL, and deduplicating
  concurrent callbacks via queue_work()

Xingui Yang (2):
  scsi: scsi_lib: add spinup_notify callback for ASC/ASCQ=0x04/0x11
  scsi: hisi_sas: add spinup_notify callback to handle
    Active_Wait/Idle_Wait SSP devices

 drivers/scsi/hisi_sas/hisi_sas.h       |  2 ++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 34 ++++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  1 +
 drivers/scsi/scsi_lib.c                |  4 +++
 include/scsi/scsi_host.h               | 12 +++++++++
 7 files changed, 55 insertions(+)

-- 
2.43.0


