Return-Path: <linux-scsi+bounces-24669-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O6lAO7MQKmqQiAMAu9opvQ
	(envelope-from <linux-scsi+bounces-24669-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 03:34:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5B66DA61
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 03:34:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=YKTNrkQX;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24669-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24669-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCF530B32F2
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34C1FCFFC;
	Thu, 11 Jun 2026 01:34:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5E74C14;
	Thu, 11 Jun 2026 01:34:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781141678; cv=none; b=f4K/WyngMC8m29b0XfoASmJNIGB5icNQK5f96kCfLT8W15TxM7YwF2PVmJrxWsl5hzWLbSSplDiPs60tx8R4GzoowgcwReKVNPES7MySUrq7s7EGNRRYcmbDy7GzJKPK3kaIZFHAnnXVoHIWhD2X2FTo0bspFUgb8Y0sAVpbzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781141678; c=relaxed/simple;
	bh=r10PDlkogS5LBwV4B2rLhiwz+xRI3htAOVIJcXTYa+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DZZ1W8A2iK/nq65/L2UChs0BhbeZL44d+5YP7dcXSunF8rWIoPVA3buhjFjTFMX3Xb02dO+mlTuWI57IjpotMpx5HwjfXO5Il81qxNzBKDMCd0Vm2xflTPfJQ6XqxnvqyMu6FEz331r4m7OiZIxZaiNBPEDqQlaFlg8XQ48p10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=YKTNrkQX; arc=none smtp.client-ip=113.46.200.217
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VHBRk+HjEpMLYhoU5qeYaEsvvHZ40VXCd1+Fxt6C0Hw=;
	b=YKTNrkQXP+3oXBOkOMnQTrFK5K+y2+DD2b25eUzNNu5qhDdX2g9kHkfe8wCwOSZbN4QbV+TWc
	FZQgzpMsbiwqkg6eYOfA2stjLlEOKmmYyCJbkYCQOIc6ey370toRT5fRNcEP1FRum6OrEnaw4OC
	iMXIaVDqIrYe1pON0CI/WU0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gbQ2z3zCjzcb1Y;
	Thu, 11 Jun 2026 09:26:19 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B3FA74048F;
	Thu, 11 Jun 2026 09:34:32 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 11 Jun 2026 09:34:32 +0800
Message-ID: <2e082951-bdd6-564e-30a8-2ab21c9c2215@huawei.com>
Date: Thu, 11 Jun 2026 09:34:31 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v6 2/2] scsi: libsas: Add linkrate and sas_addr change
 detection in rediscover
Content-Language: en-CA
To: John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
References: <20260603092124.2221524-1-yangxingui@huawei.com>
 <20260603092124.2221524-3-yangxingui@huawei.com>
 <f51b19e3-0848-4384-85d7-8fe7a7b11754@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <f51b19e3-0848-4384-85d7-8fe7a7b11754@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepemh500016.china.huawei.com (7.202.181.150) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24669-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:yanaijie@huawei.com,m:jejb@linux.ibm.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:liyihang9@h-partners.com,m:liuyonglong@huawei.com,m:kangfenglong@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94A5B66DA61



On 2026/6/10 17:37, John Garry wrote:
> On 03/06/2026 10:21, Xingui Yang wrote:
>> +        return false;
>> +    } else if (SAS_ADDR(child_dev->sas_addr) != 
>> SAS_ADDR(phy->attached_sas_addr)) {
>> +        pr_info("ex %016llx phy%02d sas_addr changed from %016llx to 
>> %016llx\n",
>> +            SAS_ADDR(dev->sas_addr), phy_id,
>> +            SAS_ADDR(child_dev->sas_addr),
>> +            SAS_ADDR(phy->attached_sas_addr));
>> +        memcpy(phy->attached_sas_addr, child_dev->sas_addr, 
>> SAS_ADDR_SIZE);
> 
> can you comment in the code why you are going this?

Good point. I will add a comment explaining the reason.

sas_ex_phy_discover() has already updated phy->attached_sas_addr to the
new address discovered from the expander. However, 
sas_unregister_devs_sas_addr()
matches devices by comparing child->sas_addr with phy->attached_sas_addr
via sas_phy_match_dev_addr(). So we need to restore phy->attached_sas_addr
to the old device's address for proper matching.

I will update in next version.

Thanks,
Xingui



