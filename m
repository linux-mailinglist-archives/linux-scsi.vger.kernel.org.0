Return-Path: <linux-scsi+bounces-25458-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H9CiGW7mRWrwGQsAu9opvQ
	(envelope-from <linux-scsi+bounces-25458-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 06:17:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 569896F3666
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 06:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=WFLMT+vv;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25458-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25458-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57FDC3004061
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 04:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8670535F180;
	Thu,  2 Jul 2026 04:17:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7F30F52A;
	Thu,  2 Jul 2026 04:17:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965863; cv=none; b=OWy6cPJJconuL7yUsu78lmBGMuwM8/aXG5UiVRjFn5s5ij/E4kSqQSGoglJCWC0qJzOxLRn8AxpoO/axHFA2NHN4UgXWOoymkCYAma7GFObrYUEud4f/BHGZSodqjlzXguhs8bjDeCZPJ7WE6TxDae+pieWU/iLJr8ojsut6Jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965863; c=relaxed/simple;
	bh=Eh1S6f/p1a+pqy1wseo/5q5I6puAwd7ZwhEiGMCDyQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dATvvUtVOtJYJ0jnOUCWSEdwAJfvQiQ45YEO9CxzXcGhRoS7iorEnEEVYPLh3fjLKQ/uI+ADpSLL44WKwTqEIL9sgZnP51LQHONeIXG0N/U+yaVD2gTn6yi8c4FpFr8R0kJKF8RoD8CxAFN8Yn8EA4VTU3L3YxbnH9owA74VCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=WFLMT+vv; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=83tRieJRpHXzPE2uWQuHWYJ1Y5EHPHIlqvfzV+ivG80=;
	b=WFLMT+vvqVs7UP8prS05a0Ks8NDwmRhoR6gPyjgj8/P0yYJ8fdDs9ETUzuAgDSXFMWxcrRJoA
	6xwiB4t51JWB5W988uTBrNp+fw0rECk4AziIsJs6BzzaQDCB7sMIqme+BMkPIRbbuN0pCAdFH/W
	LKgrRuB//HKq8N7Ri2RPJH0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4grNFl2vr4z1T4k9;
	Thu,  2 Jul 2026 11:50:35 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 41EAB4057F;
	Thu,  2 Jul 2026 11:59:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 11:59:26 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<john.g.garry@oracle.com>, <dlemoal@kernel.org>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <yangxingui@huawei.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
Subject: [PATCH 0/2] scsi: support spinup notification for SAS SSP devices in Active_Wait/Idle_Wait state
Date: Thu, 2 Jul 2026 11:57:22 +0800
Message-ID: <20260702035724.2059166-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-25458-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:mid,huawei.com:from_mime,h-partners.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 569896F3666

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

Xingui Yang (2):
  scsi: scsi_lib: add spinup_notify callback for ASC/ASCQ=0x04/0x11
  scsi: hisi_sas: add spinup_notify callback to handle
    Active_Wait/Idle_Wait SSP devices

 drivers/scsi/hisi_sas/hisi_sas.h       |  1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 25 +++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  1 +
 drivers/scsi/scsi_lib.c                |  4 ++++
 include/scsi/scsi_host.h               |  9 +++++++++
 7 files changed, 42 insertions(+)

-- 
2.43.0


