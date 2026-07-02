Return-Path: <linux-scsi+bounces-25455-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tdIbMy/iRWpVGQsAu9opvQ
	(envelope-from <linux-scsi+bounces-25455-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 05:59:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA16F3550
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 05:59:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=huE0Ywh+;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25455-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25455-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F54D300D9C3
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 03:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689934C155;
	Thu,  2 Jul 2026 03:59:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39C34C130;
	Thu,  2 Jul 2026 03:59:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782964778; cv=none; b=rxbn+U0JvgyhOsMLmCowpFCPI3gIJ3TzAHgucP+R93YFQtpF3PUnhNAqcthnGNSNCtx2AOyuPErSHV7v1j5oJZXCbgqAAk/UmNnlddUXZX65sPL5Kgyj9+6MS9t2vQePmzs9T5+kazbdTyIhGwA4UEQe/f3daz4YYd90uP+R2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782964778; c=relaxed/simple;
	bh=UunjM0092egpSTA5aUPq6+VjOAPUA2ekuy9Des6nBwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1QdwYKZB0j2bVPXpCn+ADUyASuHaNiZsYtth+ycpQWOfZzYQTjoOun2YfEdFqEx3obj0wdStlfcVAmjkm9ZDL8ck3Z6ZerDSWvlvSpWkT7ORfWP2U06//z7D7sFtpKzoPVO5pQ54mogfaHQCqv62am3BXSdhKbaoaqOKzaRVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=huE0Ywh+; arc=none smtp.client-ip=113.46.200.217
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nP/NXLt1Leq0gYIF0Cpx+S7okE/swTivpVbp85RmJC4=;
	b=huE0Ywh+UQWA5FOZBBUmAdNBx3iyVUp4MF8kJq5IGSs1zKf0vrYBjBQWrqkCjnHxYkA83bL4o
	0txMfFz5R84VFscRuJqz9oglWihnhBHx6+jPHowQKM3CZG038AMnAWaBI+DaWWPK3VbJMT0dgVS
	trbzjpUl7ZLF5VaHXFMkFpo=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4grNFl6r6Dzcb34;
	Thu,  2 Jul 2026 11:50:35 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B51564058C;
	Thu,  2 Jul 2026 11:59:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 11:59:27 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<john.g.garry@oracle.com>, <dlemoal@kernel.org>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <yangxingui@huawei.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
Subject: [PATCH 1/2] scsi: scsi_lib: add spinup_notify callback for ASC/ASCQ=0x04/0x11
Date: Thu, 2 Jul 2026 11:57:23 +0800
Message-ID: <20260702035724.2059166-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702035724.2059166-1-yangxingui@huawei.com>
References: <20260702035724.2059166-1-yangxingui@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-25455-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:from_mime,h-partners.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64CA16F3550

When a SCSI device returns NOT_READY with ASC/ASCQ = 0x04/0x11
("notify (enable spinup) required"), the device is in Active_Wait or
Idle_Wait power state and will not respond to standard START_STOP
spinup commands.

Add an optional spinup_notify callback to struct scsi_host_template.
When ASCQ=0x11 is detected in the mid-layer, invoke this callback
before ACTION_DELAYED_RETRY, allowing LLDDs to perform controller-
specific spinup notification.

Example log:
[Tue Jun 23 08:34:44 2026] sd 4:0:9:0: [sde] Spinning up disk...
[Tue Jun 23 08:36:22 2026] ...not responding...
[Tue Jun 23 08:36:24 2026] sd 4:0:9:0: [sde] Sense Key : Not Ready
[Tue Jun 23 08:36:24 2026] sd 4:0:9:0: [sde] Add. Sense: Logical unit
  not ready, notify (enable spinup) required

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/scsi_lib.c  | 4 ++++
 include/scsi/scsi_host.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b67f0dc79499..33c4339ca8c5 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -905,6 +905,10 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 				case 0x1a: /* start stop unit in progress */
 				case 0x1b: /* sanitize in progress */
 				case 0x1d: /* configuration in progress */
+					if (sshdr.ascq == 0x11 &&
+					    cmd->device->host->hostt->spinup_notify)
+						cmd->device->host->hostt->spinup_notify(
+							cmd->device);
 					action = ACTION_DELAYED_RETRY;
 					break;
 				case 0x0a: /* ALUA state transition */
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 7e2011830ba4..500fad5ffab6 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -374,6 +374,15 @@ struct scsi_host_template {
 #define SCSI_ADAPTER_RESET	1
 #define SCSI_FIRMWARE_RESET	2
 
+	/*
+	 * Optional callback invoked when a device returns NOT_READY with
+	 * ASC/ASCQ = 0x04/0x11 ("notify (enable spinup) required").
+	 * This allows LLDDs to perform controller-specific spinup
+	 * notification before the mid-layer retries.
+	 *
+	 * Status: OPTIONAL
+	 */
+	void (*spinup_notify)(struct scsi_device *sdev);
 
 	/*
 	 * Name of proc directory
-- 
2.43.0


