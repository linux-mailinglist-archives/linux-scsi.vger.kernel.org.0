Return-Path: <linux-scsi+bounces-25468-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G4VZF3hcRmrBRgsAu9opvQ
	(envelope-from <linux-scsi+bounces-25468-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 14:41:28 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AD66F7C29
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 14:41:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=GF0WIixI;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25468-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25468-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7101730457DD
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E147F2C1;
	Thu,  2 Jul 2026 12:25:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E540480978
	for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2026 12:25:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995110; cv=none; b=ha+izLncRoB4FnxQN0KzDdLnGDsmzxDzmsrXKaPcNMEaW+Ah5q0YoGFYg1WlKWiaW9DGmVUcTI9GhVLnaAHQHPEv0ND7uQIpRKw2RCg1EltlbFKr+Dt8ORHmg93j7xxfA2MFLgb3bltAoRjH295Py3/nbSG2iCbJ763ion0HlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995110; c=relaxed/simple;
	bh=xxJs8Zy3x7HaiihdDCQiQX/xiDvsSQldVEjorNkWsY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g7+gTQl0vWhZPSpGALw+NXNZvl5D48vfuMYKfjJhmpdDl0CMiG1mzgFb5Zn6w4UbOXOzB7uCMsfR/UvpVo51SmRMifqGdn/a42vphJy6GVqtwfPY2kPqzqx8Zt/mbz7OpqSNulHazmpoAPfPHK2QcJipkgbGwLacl+YP6EWl2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=GF0WIixI; arc=none smtp.client-ip=113.46.200.221
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2wPyCJuguvWFu8csi2DRSMqiFZCLQ9A3pa/dFLczro8=;
	b=GF0WIixIdWYxbYaHc7gx387XfXN3WOOTgfmX1UrjKa00FmRUyPalRH8Ye41lno76jqaa+uRNi
	yAG7VyzDvdI+BYljpYFw2mYRF1jrCaHVnJq8W3dyRDfD4Zep25nbrjLmomoTE2d+5oFVJTtOvuG
	pq1IZHadTy4ORooRvhJzk6Y=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4grbSj4blkzRhT6;
	Thu,  2 Jul 2026 20:15:49 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id BA92F2012A;
	Thu,  2 Jul 2026 20:24:58 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:24:58 +0800
Message-ID: <948fbaf9-8fc1-c1ce-3fd1-caaa6d9e5a0e@huawei.com>
Date: Thu, 2 Jul 2026 20:24:57 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/2] scsi: hisi_sas: add spinup_notify callback to handle
 Active_Wait/Idle_Wait SSP devices
Content-Language: en-CA
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-scsi@vger.kernel.org>
References: <20260702035724.2059166-1-yangxingui@huawei.com>
 <20260702035724.2059166-3-yangxingui@huawei.com>
 <20260702042042.73C511F000E9@smtp.kernel.org>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <20260702042042.73C511F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh200006.china.huawei.com (7.202.181.113) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25468-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82AD66F7C29



On 2026/7/2 12:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Sleep in atomic context (softirq) leading to kernel panic.
> - [High] Unprotected lockless read-modify-write on the per-PHY SL_CONTROL register.

I'll update in next version, hisi_sas_spinup_notify() no longer calls 
sl_notify_ssp() directly. Instead, it queues a new 
HISI_PHYE_SPINUP_NOTIFY work item onto the driver's private workqueue 
(hisi_hba->wq) via hisi_sas_notify_phy_event().


Thanks,
Xingui

