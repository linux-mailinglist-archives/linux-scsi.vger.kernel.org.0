Return-Path: <linux-scsi+bounces-24405-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h4Z7CaDzH2qItAAAu9opvQ
	(envelope-from <linux-scsi+bounces-24405-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 11:28:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A3636260
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 11:27:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=Fjy8TwX1;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24405-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24405-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A76E630D25EF
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jun 2026 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D83C1418;
	Wed,  3 Jun 2026 09:22:50 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE2374E60;
	Wed,  3 Jun 2026 09:22:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478570; cv=none; b=IdpidtxWalRdNwVGe4VMdP+9nURmy70gimoEbi9e8AhoQYg+FFjralN8rTUI1G6sFBG2d/Zcd83fN/PpKqlGzvZ2bM5s1fcPJJzNimlsrH5HbQVVgGkEOgO3zx9303iM5l/Cf3OCUbf7Xisa8j3hp9s5wrf/zirE/xe+MbTuZ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478570; c=relaxed/simple;
	bh=gmfYk6mNxxV/zGqvRgBDRtWIGB84zSZR9aRILYq9jig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uz9ygnis6PomR4ixIqJ4WVuBJLIG3zXGySp5mmJVLAsAcillVTu3UlUeUQ58EEgh5AakG5+kkFKdQ7/gmZHxNqurWiL4a2Unq+rqcWy8CYN5XziNv0ObvcAHjbVlCqZwJslEY17/79umBhqYcX7L/ZtUHJ7ZVKdP3HaiD0clIyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Fjy8TwX1; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cxwjUCJXLnUMgMTewerXHfYRa7PwYYGmdcdm4sXds7I=;
	b=Fjy8TwX1wT/2TOjH5i53liQmhUyFaDWjzJQ/ZLUbJq7MLv1QvAEEgVg8b5eZ1sOIJLPrwyXNP
	3HMeEZ3QxhEEsX5whKrZ9eNrSLZjgrW8GdmjjXCLQ3w66Oj8gg+X3MI5Xh9BhQWiq2u07LBfko2
	6vZfZgD6SZVnREMmSJxvM0c=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gVhpw68l6z1T4Hf;
	Wed,  3 Jun 2026 17:14:32 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E67EB40571;
	Wed,  3 Jun 2026 17:22:43 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 3 Jun 2026 17:22:43 +0800
Message-ID: <f1b25f6e-b83a-26ca-b817-21c8c8059eb2@huawei.com>
Date: Wed, 3 Jun 2026 17:22:42 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 2/2] scsi: libsas: Add linkrate and sas_addr change
 detection in rediscover
Content-Language: en-CA
To: John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
References: <20260530024958.3279112-1-yangxingui@huawei.com>
 <20260530024958.3279112-3-yangxingui@huawei.com>
 <c7e88b75-6c90-46f6-bfa2-471a01a366d0@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <c7e88b75-6c90-46f6-bfa2-471a01a366d0@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh500012.china.huawei.com (7.202.181.145) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24405-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:yanaijie@huawei.com,m:jejb@linux.ibm.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:liyihang9@h-partners.com,m:liuyonglong@huawei.com,m:kangfenglong@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,h-partners.com:dkim,oracle.com:email,huawei.com:mid,huawei.com:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B5A3636260



On 2026/6/3 0:30, John Garry wrote:
> On 30/05/2026 03:49, Xingui Yang wrote:
>> In sas_rediscover_dev(), when detecting a "flutter" condition (same SAS
>> address and compatible device type), the code assumes the device remains
>> unchanged and only handles SATA pending state recovery. However, this
>> approach misses two important scenarios:
>>
>> First, the flutter detection only compares SAS address and device type,
>> ignoring potential linkrate changes that may have already occurred.
>>
>> Second, after sas_ex_phy_discover() re-queries the expander phy, both
>> linkrate and attached SAS address may be updated. The current code does
>> not validate these changes against the existing child device.
>>
>> Additionally, the replace code path (different SAS address detected)
>> has a sysfs duplication issue: sas_unregister_devs_sas_addr() only marks
>> the device as gone, but the actual sysfs cleanup happens later in
>> sas_destruct_devices(). Calling sas_discover_new() immediately after
>> unregister causes sysfs_warn_dup() errors.
>>
>> Introduce sas_dev_is_flutter() to check whether it is a true flutter with
>> validation for linkrate and sas_addr changes. It returns true for normal
>> flutter and false when changes are detected requiring rediscovery.
>>
>> Introduce sas_rediscover_ex_phy() to handle async rediscovery for both
>> flutter and replace cases. When invoked:
>> - Set phy_change_count and ex_change_count to -1 to force revalidation
>> - Unregister the device via sas_unregister_devs_sas_addr()
>> - Queue DISCE_REVALIDATE_DOMAIN event
>>
>> The old device sysfs is cleaned up by sas_destruct_devices() at the end
>> of current revalidation work. The new event triggers discovery via
>> sas_discover_new() since attached_sas_addr is cleared, avoiding the
>> sysfs duplication issue.
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> Suggested-by: John Garry <john.g.garry@oracle.com>
> 
> This looks ok, so:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Hi, John

Thank you for your review!

After further analysis, I found a small issue in the sas_addr change
handling that needs a minor fix:

When sas_addr change is detected in sas_dev_is_flutter(), after
sas_ex_phy_discover() updates phy->attached_sas_addr to the new address,
subsequent sas_unregister_devs_sas_addr() cannot properly match the
device because sas_phy_match_dev_addr() compares phy->attached_sas_addr
with child_dev->sas_addr, which would mismatch.

So I added a memcpy() to restore phy->attached_sas_addr to
child_dev->sas_addr before returning false, ensuring proper device
unregistration:

     memcpy(phy->attached_sas_addr, child_dev->sas_addr,
            SAS_ADDR_SIZE);

This change is included in v6. Would you mind taking another
look when you have time?

Thanks,
Xingui
.

