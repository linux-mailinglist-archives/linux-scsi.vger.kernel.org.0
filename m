Return-Path: <linux-scsi+bounces-23016-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO39GtE54WnWqgAAu9opvQ
	(envelope-from <linux-scsi+bounces-23016-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 21:34:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E84B6414248
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 21:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93C523133A3E
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178C3E4C6D;
	Thu, 16 Apr 2026 19:30:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022129.outbound.protection.outlook.com [52.101.101.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADE3A9DA1;
	Thu, 16 Apr 2026 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367826; cv=fail; b=UW9Dv3pVfKVXJKFAkRXZhP+w86Kur/U6apqTUsKMZNKSQg6Vg9m6yjLdcERcRieLjplvWjk0K23F655i+q6kZDwD+kk9s0SFeKY16NJFZlVsRfNYFShNNfR6PCRm9F6hDG4c7ipLbFtAb5uP+JVtUt+meZ6+J2NVmtafZq99XPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367826; c=relaxed/simple;
	bh=Wdm1AL7cAW2lOhZ1+PctyE5JizjY0tMfIY3BCgnyOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8tbwXlGDE7KcCZRnNyKUZbDmX16m6wzA1Ul/I2QsYkYZj1n4lH2XFDiIdILQknb8nXh9BTHzYzV0Yep/Eh9zcwesx/YEMcumhsu8m6Ref3rHj5F0vR8WA/KkSAYa5lnWoWrX9aB6x2SBMTGwIKD5egrHyoDQU/2a6CMqQ0uIJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLEOQCNYGeopv76Hd4jjq2hkzqmV167Ox9rF5W/uL8+IcWO4QBfLrnpT2agRf692MRlLjzjd9ZZlqmPL/uPvP7mFkgxHwQ/iVOtHLlRQzvalpxfgsOUs6MOONzVqpfUW7ZY7mSlzgyxfNhWSQoRhgpLPHABjUZRpfmVByRmmFXfVuAXYgH2Ry8i3EnQleYrL8cTRaT+yMq/jEzzzPehen/ZH4g5vuUjiErKHM7Fi14p9en5ASRdV9QDWlTiMB+JbPUi3uP1C17B1/gWmMyPVdo5YCL4sSRz3JlGPxmfSupPbRrelI0m2hHYQLajWyyUb17t36k4a9XVb9Vrl6SCV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT73pcMrZGWJw7/cyUyLQHWE8j9CEal7s6MBWwSPoAw=;
 b=VGnCDFKsChxCW/lBaCmUVs71kkvEfrZmkpWMaZKcj06bt6oCZJXiMrmVdU1FsJHPfbpazyd2dFBvmksuj+zAVhA1xzqkTHumTab1u7bb1Q7d3ij+hhSGhx+dBl8yYhE9kc7fbbwPR9Zay8X6xIyifQQfxb8LqgcrkmqTDOJVOzYgWMCXudweEPdl8oNItbbL69S88dqPPyenrPHW6egvVOqVgrlZOqW/bqlwVcTQwPF+1o/1xgoLp7SdgVUBYYcam+MLe39cyt671HjeG+GfYRdt91dHDzb63XHrmroFvyh/EG/keM+mvqKREoG0iqpJDP9/qb6RId9Tynu968e/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB4039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 19:30:22 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 19:30:22 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	mst@redhat.com
Cc: atomlin@atomlin.com,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	liyihang9@h-partners.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com,
	jinpu.wang@cloud.ionos.com,
	tglx@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	ruanjinjie@huawei.com,
	bigeasy@linutronix.de,
	yphbchou0911@gmail.com,
	wagi@kernel.org,
	frederic@kernel.org,
	longman@redhat.com,
	chenridong@huawei.com,
	hare@suse.de,
	kch@nvidia.com,
	ming.lei@redhat.com,
	tom.leiming@gmail.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	nick.lange@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v11 09/13] isolation: Introduce io_queue isolcpus type
Date: Thu, 16 Apr 2026 15:29:38 -0400
Message-ID: <20260416192942.1243421-10-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416192942.1243421-1-atomlin@atomlin.com>
References: <20260416192942.1243421-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6ee339-2904-491a-1e0b-08de9bee99c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lH8cOcklbuyVO/XhyCoGtnb57MjMHIONDEMQLzWjee7mApPgq7nNNVttk0u7UDDVG6HLnAEAd/jyeaAgEKGkNEk8mae8nF0wMLdpxttDCWqG11FRcZMjbnzN4re5PYK5AyziD4dujxh2EGyxkhcs27cRU86IIkXG+tg0PqAGcXN6DL7n3jwN3oYjeBvZoxYysBWv1I3QhctWhN6XPcuEimFaV3H9xKYrEPZhcKH79hCGG20zZ14RV4WPY6L/qc5zmlu2m0VJIMtleq2GGu4WZ0C7/DdYQAGTGjgP7rKNLMWZILE9KcfFGk/+aaW2Isdc836heM3Iol218aF9d2WqODlli+8IralKbYiT8dyaGvKg/fe4FeBi6/Gu7sf6EZCMTfcGKDIdXaBE/URkfjyNLISGag3EoYL33ieJOmi/eMvpeUhLedV60K0AD/ux2yPTaWCSTYQp9k/9QZJwCag9Ytegkzd5ZHNGXB3bGJNTY5votXIFkf8PidrmuZjOD6Pve1le//OaFFst01jASLZJWUyNkIKe8mIfjK95v1Kj81cJTgD/HtTygVXIU7+Wy2vPGmWp9nor8QmWiqpKazUrHamZjxLh4FQQxnRgOO/O/659qv7fyjYRIhb+aYE4otb2em6GKAkFNI+OdIwbFmFyecPkQ4GTDVLfRqjo3jZQz5uRMyz/OaXaXMR5qJc0i1EX+E9s9KSAl5QcuJ5pd8Viuc4c3HWpKNNF6bejRNd6kLU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CsIRpKTBYiHYuSdKI6Rvs1W14HgUpgYGQuJM/uAMvdXzwPVoMic7j+FlMdIY?=
 =?us-ascii?Q?HO+5PHgSabwMJsv1r4drxpO4hxWAOO4G9+OSnyF9puAtwKb7LnAfp78guxp1?=
 =?us-ascii?Q?4a2sxbYTnG74gFo0BLxHhHzJkgYEIE6rnU9MLWeDAmJ2ih8EoIY6Md7OXi9T?=
 =?us-ascii?Q?sVrWY+X7D7FEP1qp8iLcbquN7QYIIzJVcC8ecOJa4KAwBDLhBSiuwcm8Ej5C?=
 =?us-ascii?Q?hL3ECOsBIgsgQo3BZtb4Kp1IKfF30GLfc3XXEYj9324Zjj75Dyixq6LTKnue?=
 =?us-ascii?Q?XAhdXZXvFnK8nwycmrWN/2ep9hEVQDbMSxmB7UXeCSANim1MQs54I3qpOMGW?=
 =?us-ascii?Q?D/YjzcPKZi67LMZH1ICnmXTzgQj0smswSrxSvhtj4fonuXhwdpWAmfIRx1NC?=
 =?us-ascii?Q?Wy82LcE3p9te3D5oVxb29uwnH2dCt77MQtylUTjZVbNnKBSEXqxD4jM1FZ/f?=
 =?us-ascii?Q?7BOfBLNZsDcE/fCXd3Ofw9lUdQY95C4ewFD5Sah4pbeDIoMStlMOo96tXeUP?=
 =?us-ascii?Q?qXhd+Aj5CEWIx8vsebxbpSBRH+FLpV8uO6/HGjd+TkfXFWHA73v3JD6QUOYB?=
 =?us-ascii?Q?XksPnMPf/lgX3cr10mZyo9HbVpv542HLd3pYFG4jgp/Icbr/4yfvtZjNQpip?=
 =?us-ascii?Q?gnlhtggIjV8W3wsgISWGCl69PSZsDwy7UT6ds6fRxMZ5zXyZVcwmZTfgpRdH?=
 =?us-ascii?Q?NMa+VoYRidinCZz+zH95CwXdSOvmd4kLiLq8XnclfK/iZi8+giGIsst2PeOl?=
 =?us-ascii?Q?JayrfFP1RntAEM9hTQ5RZlSrkSt3jICMil7dYvUaYpnhWR5rFu+ur4JfiIdz?=
 =?us-ascii?Q?p73g9JRHnrZ4l2A6qShMoyI8oKtgFfhvCbV6qPuc6u2YA5cwUdT27byvWS49?=
 =?us-ascii?Q?WhfnfEIjXY3jruE+Xcdqlb/G414EQaG6z1OQ/F9DAH5+gas4vTyKuUjfp8+b?=
 =?us-ascii?Q?WPSe5PPvrxRosdHzdm5gAVVHe+ywL5H0Q0gtnyQk2zZq1ZcUH8XVWP4JIrSK?=
 =?us-ascii?Q?cDvuCEuIg75MgItTqIpnHYeGFfPbJyHN+bwflYVhnAuzh/7sx03yaPzZZDbs?=
 =?us-ascii?Q?ksRUQXuCTbJYizzSb6+PnLypZjKMAGzNGEsDaKbPLtfD/sLqqIGcEvJQOCcl?=
 =?us-ascii?Q?23pKnzcpGjZZSvtVmQEAo8Rudg2/cnlve/1Cda38MUezvq85hJUcEhHJYwD+?=
 =?us-ascii?Q?QnwHW06V7lallWkNoDubhlChoZEdf7hSYs5TFQeDBENj3rE7CFiaBbHgbU0k?=
 =?us-ascii?Q?4tVBTHr3bsXEeGyDQLXcWjyFuBS2UMzN1moU9KoB9cqlLgdwp7pLzKHgRA9G?=
 =?us-ascii?Q?nbC1oekkTGW3AmYzFmGttB3Fs09+wlv1ifZV0Ovq9lfZ384CyL6UPBrCdZMx?=
 =?us-ascii?Q?KQJ9ICSfiqEb0qkB3YM5ETEl+bL+ZKU0lzqUforQMkU4WZGN4Vlu9qoW8wk1?=
 =?us-ascii?Q?SVBRJlShYQ2UEl45YsagOH7TTNaF0bbJcLgsQpFKuPPFHIvnbpSX0Wk6fXkc?=
 =?us-ascii?Q?MjJ3kDZl3YWjPj6w/yu/I8faQKmwOWpoIhMXc0rQOhWoDn4ONBcul8EjgYyQ?=
 =?us-ascii?Q?N1K9reZWbNHt3xGDrGpe18NdaAaXXZxz7dejUoubbH039bab537oDzPQL4LN?=
 =?us-ascii?Q?CMxSJ07LVNxV+eMQSw9C+u2RFY0TiUMMQPKXTAD5rGRFDBycrwInKK0xXoRA?=
 =?us-ascii?Q?iY9HopiPMBZHb4CtYmsnVhMo8Hruiq4TQGSlHwBpEBP0sabKPo0aiORPk4pr?=
 =?us-ascii?Q?RBSpL8JAXA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6ee339-2904-491a-1e0b-08de9bee99c5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 19:30:21.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKE0zfYQsnejZ96odTD4FhIFXvu0RpAXlEi52p1BkAZlr44IrYZ+Vm89i07GvfYCmLgVYxXm/ivvVU+eq59sdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4039
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23016-lists,linux-scsi=lfdr.de];
	FREEMAIL_CC(0.00)[atomlin.com,microsemi.com,HansenPartnership.com,oracle.com,h-partners.com,broadcom.com,cloud.ionos.com,kernel.org,redhat.com,infradead.org,linaro.org,linux-foundation.org,huawei.com,linutronix.de,gmail.com,suse.de,nvidia.com,abita.co,ashe.io,suse.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.953];
	RCPT_COUNT_GT_50(0.00)[51];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:mid,atomlin.com:email,suse.de:email,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E84B6414248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Daniel Wagner <wagi@kernel.org>

Multiqueue drivers spread I/O queues across all CPUs for optimal
performance. However, these drivers are not aware of CPU isolation
requirements and will distribute queues without considering the isolcpus
configuration.

Introduce a new isolcpus mask that allows users to define which CPUs
should have I/O queues assigned. This is similar to managed_irq, but
intended for drivers that do not use the managed IRQ infrastructure

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index dc3975ff1b2e..7b266fc2a405 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -18,6 +18,7 @@ enum hk_type {
 	HK_TYPE_MANAGED_IRQ,
 	/* Inverse of boot-time nohz_full= or isolcpus=nohz arguments */
 	HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_IO_QUEUE,
 	HK_TYPE_MAX,
 
 	/*
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ef152d401fe2..3406e3024fd4 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -16,6 +16,7 @@ enum hk_flags {
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
+	HK_FLAG_IO_QUEUE	= BIT(HK_TYPE_IO_QUEUE),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -340,6 +341,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "io_queue,", 9)) {
+			str += 9;
+			flags |= HK_FLAG_IO_QUEUE;
+			continue;
+		}
+
 		/*
 		 * Skip unknown sub-parameter and validate that it is not
 		 * containing an invalid character.
-- 
2.51.0


