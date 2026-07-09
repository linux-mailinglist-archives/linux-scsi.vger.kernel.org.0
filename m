Return-Path: <linux-scsi+bounces-25915-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iJYvIaXzTmoXXgIAu9opvQ
	(envelope-from <linux-scsi+bounces-25915-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 03:04:37 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D867672B86A
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 03:04:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=h+KpCCJs;
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25915-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25915-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA6A7300C9AC
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2026 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123283932E9;
	Thu,  9 Jul 2026 00:59:55 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA506391853;
	Thu,  9 Jul 2026 00:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558795; cv=none; b=O58OzIFglZ+ftpzyFcczK1dJvica+/1BjGFq5xoVovO1+g2lDE4Y3ZlGtAo5OXxinKWsThSheSJut66g7hHZVmANnAWpe5rJ7tPNquqg2jPEGt4x5vXwCgz63BMEWOg4vWtQHfcbr1pgwGFE67maRppRZRFg9BquYaMitA+jyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558795; c=relaxed/simple;
	bh=LIHV+HE+Ks7r+PALIKh2TcbyskdwnmlliHjZbAEgX64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DvoLOcCvqtIiNkYl8eOOQDJpm2bof9DLccVitk3zgiqstBd51wSVbB8+wIlcp4SM9xCahzC8+pXHzC3lCEbb4m9Y55IoXPVoyF888kBr0oX9HVo0cr2RUWqPdn3CFG9NOs0JQi1uw2sm+utDNe+okB8Q2Ja4BpPpGy7PjUUsZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=h+KpCCJs; arc=none smtp.client-ip=113.46.200.222
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FHgY77I+AJCpAnaShfoa2rikXqXoO/GrUtdyxE8eo0I=;
	b=h+KpCCJs3toAEm5JxN0X0N1GYbH0g9567vpOTG9MPJz9++mWosKbm6bQKhs82AwiLB25PzJcF
	LxZQ5lVlUMQ/pgM4+luGfjKohzm0UvmdUeweNCeJEJmeQOulsGDugicdgEiAd1NnMAlyCVjEqcd
	2/XD34ck2EBeQmiyouWaqsw=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gwbwh3mdjzLlVT;
	Thu,  9 Jul 2026 08:50:28 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id EA99D4048B;
	Thu,  9 Jul 2026 08:59:42 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 08:59:42 +0800
Message-ID: <33474553-c47c-4508-ac77-e0598834bb7c@huawei.com>
Date: Thu, 9 Jul 2026 08:59:41 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: sg: validate and round up scatter_elem_sz module
 parameter
To: Bart Van Assche <bvanassche@acm.org>, <dgilbert@interlog.com>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<yukuai@kernel.org>, <hch@lst.de>, <axboe@kernel.dk>
CC: <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>
References: <20260708063045.2008478-1-yangerkun@huawei.com>
 <a5fa376d-90d6-4767-a994-2b91fb9cb951@acm.org>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <a5fa376d-90d6-4767-a994-2b91fb9cb951@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25915-lists,linux-scsi=lfdr.de];
	FORGED_SENDER(0.00)[yangerkun@huawei.com,linux-scsi@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:dgilbert@interlog.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:yukuai@kernel.org,m:hch@lst.de,m:axboe@kernel.dk,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:from_mime,huawei.com:dkim,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D867672B86A

在 2026/7/9 0:10, Bart Van Assche 写道:
> On 7/7/26 11:30 PM, Yang Erkun wrote:
>> Additionally, the code handling scatter_elem_sz is refactored for
>> clarity: [ ... ]
> One change per patch please. The code refactoring and the bug fix should
> be separate patches.

Thanks for your review! Will do it next version.

> 
> Thanks,
> 
> Bart.


