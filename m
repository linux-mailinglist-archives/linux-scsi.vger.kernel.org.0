Return-Path: <linux-scsi+bounces-23802-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEbFFObHBWrDbAIAu9opvQ
	(envelope-from <linux-scsi+bounces-23802-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 15:02:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829B54210B
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BFAD3060F33
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AEA28AAEB;
	Thu, 14 May 2026 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="q8lF1IGq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD41EFFA1;
	Thu, 14 May 2026 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763671; cv=none; b=maxVBSMH+Ktk+e2uGzQCkhU9LxjNkSTgx5ui5hM04oeynZbhCcVzXqfo6a3ZLTtez2tenF6OzsFiYrm3gZOJF8msXRBuz8XiPZKFXfq1KSH8zspWNb3zXTUgCEuUqoEhMjSREmRwQcqUtSRLcqYf9Au3Nkv6xUAotyG4vHWsWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763671; c=relaxed/simple;
	bh=SGJbP6sFxjGXPiDyRfFA35HHoZ+iEN4yTqcJ6e2lvV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VCRMFP25ohJerEBrRZAvvSWsa/6II0KWM/VNxYRVQT2k8fAubs5woxYyOfnGxGHpvfxpt9/lyP8Qyy4UQnZsaMU+9ho1ToIXv2qFVSmBG2XT6Aidc8wQ2REwlB+G0P0LxZtzfbnIyZW/nn3WF3nnWHjcaWS7EUx1Eb4YmuLZYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=q8lF1IGq; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=80+4nSyZyqhMOq97bLjGrpLILAZvgQUCyMlvXivwClQ=;
	b=q8lF1IGqwuKsZvCvjCBgALc+AvG0lKLZIRZVnXx7RZiPlwwsSqjYjkDF4aBy+WAPTjJN+FugV
	hVRE6WhKF8y8hEs6C6hynW0rkRfbiEiDkiLcGHBCjmuEtoZ4FsTflEsDowjS3nRx+2xwIez19Mp
	RZS25BxtDK0hq3aMX5++k10=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gGVcg0V2Xz1K996;
	Thu, 14 May 2026 20:53:23 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 79EFC402AB;
	Thu, 14 May 2026 21:00:59 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 21:00:58 +0800
Message-ID: <28bd9d5b-f597-0aae-5340-bd951b2083aa@huawei.com>
Date: Thu, 14 May 2026 21:00:58 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 0/3] scsi: libsas: handle linkrate change in
 sas_rediscover_dev
Content-Language: en-CA
To: John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
References: <20260513021603.3023329-1-yangxingui@huawei.com>
 <11d3560e-d956-4f0d-abc6-2ed897e0ce45@oracle.com>
 <391ec8d3-3bf7-16fc-774a-96c917c67d56@huawei.com>
 <c4e4c99f-a13c-4e28-8650-48be1f96d7cf@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <c4e4c99f-a13c-4e28-8650-48be1f96d7cf@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh100009.china.huawei.com (7.202.181.94) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Queue-Id: 7829B54210B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23802-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,h-partners.com:dkim,urldefense.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 2026/5/14 17:35, John Garry wrote:
> On 13/05/2026 09:14, yangxingui wrote:
>>
>>
>>
>> On 2026/5/13 15:29, John Garry wrote:
>>> On 13/05/2026 03:16, Xingui Yang wrote:
>>>> When a device attached to an expander phy experiences a linkrate change
>>>> (e.g., due to cable reconnection or negotiation), the current code in
>>>> sas_rediscover_dev() treats it as "broadcast flutter" and takes no 
>>>> action
>>>> if the SAS address and device type remain unchanged.
>>>
>>> Can sas_rediscover_dev() check the linkrate (vs expected) to 
>>> understand that this flutter has renegotiated the linkrate and then 
>>> consider it not just a flutter?
>>
>> Hi, John
>> Theoretically, it is possible. As early as 2019, Jason attempted to 
>> propose the solution you mentioned. He conducted a relatively 
>> comprehensive assessment for flutter, including scenarios where the 
>> SAS address changes or the ATA ID changes. However, in actual use, 
>> such situations almost never occur unless there is an extremely short 
>> time window during which the drive is swapped or a new SATA drive is 
>> replaced. Because this solution is associated with other modifications 
>> and may have significant impacts, it has not been adopted.
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/linux- 
>> scsi/20190130082412.9357-6-yanaijie@huawei.com/__;!!ACWV5N9M2RV99hQ! 
>> K7CIIOxMVXErIMxcZlvm10YX3EVqp0rhSbh_ARyqnaFDmtaqqJtoLTJQui0- 
>> Ox_URh97f8oyREG8htBVo2aC3Ew$
>> Currently, scenarios involving changes in linkrate are relatively more 
>> common, and such situations can be easily reproduced by manually 
>> adjusting the linkrate by sysfs. Therefore, a less impactful 
>> synchronous update solution was adopted.
>>
> 
> What Jason did was to check if same device for flutter, which is not 
> really the same thing as what you want.

Yes. Jason's modification check items include whether the link rate 
changes and whether the devices are the same.

> 
> I just don't like these special case callbacks which you propose, as 
> they seem fragile and too specialized.
Yes, perhaps, but the information about the remote device is obtained 
through smp discover. lldd cannot directly obtain information changes, 
so a notification call has been added to update it.

> 
> Is it possible to just check the linkrate and mark the device as gone 
> and rediscover when this flutter occurs occurs?

Of course, if you suggest doing so, Jason's related patch has also been 
verified to solve this issue.

Thanks,
Xingui


