Return-Path: <linux-scsi+bounces-26108-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZY4zEeqbVWqfqwAAu9opvQ
	(envelope-from <linux-scsi+bounces-26108-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 04:16:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8D750531
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 04:16:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=Yh3uU+7H;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26108-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26108-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D4FF301914D
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 02:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3637A488;
	Tue, 14 Jul 2026 02:16:05 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FB184540;
	Tue, 14 Jul 2026 02:16:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995365; cv=none; b=gIlUzxDovEBDpG6LEKV5p+rqk8JU84vT4fW+4+m1fCH+lk2QmPM1MwfFNsv8ZsCjdET29pyvlTc4QHMJv2pIJa3+uQIo1CJ6hhT2oXn7Y5EAy7AgGIrblOmTzYwaYlmItBesnHbHbvLONKuEzkIXg6SZymf+tHOSbHNsuDlJeFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995365; c=relaxed/simple;
	bh=tZX++DfyPVDO/toe/oHXewgONqwFDUfXmOoTF6i2/oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tChdU7C2pGTbP33uU8Mhi56RsW7xvQpN2RIorFxAemlX/CyJGUjAZ+8rbSrveIgNlRcWM1/+NIFQVrmjl1XZ6x232JXjwnghwf4S2U9yujU5GqrKKARThwh8qQmQdikYVLOEOxHPLsLzrfEGPHTXSFyUke3geEx8nkWFFA6EpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Yh3uU+7H; arc=none smtp.client-ip=113.46.200.225
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/0mhCrZ7CEJuo4fhtXWSJiqGCZOLSdFGZ1XOIPhZsbo=;
	b=Yh3uU+7HbDLfuUWQ7Nycu6y6ZbcTn7DpmIzQ6tqlT/SLgTfuDH8nSKc3L1w+JlTDjcrXAU0Mj
	hxRKkWCooKNMySmvq3GnV9WB9x/diSC90fjYZ2FycX2gZ+gDGvflhDgTBvCzLf5IFNutcLa7uu3
	pwVso64AUPT31esY8o6DEUY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gzjNC6flXz1K96b;
	Tue, 14 Jul 2026 10:06:35 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D07E40586;
	Tue, 14 Jul 2026 10:15:52 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 10:15:51 +0800
Message-ID: <e91cdddb-2323-904f-dc63-3d00597b5c8f@huawei.com>
Date: Tue, 14 Jul 2026 10:15:51 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] scsi: libsas: fix HA resume deadlock and hisi_sas
 disk-wake race
Content-Language: en-CA
To: John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
References: <20260702033211.1743313-1-yangxingui@huawei.com>
 <379091c9-3cd2-7599-baae-8c7f278e7ec3@huawei.com>
 <56d1c5d9-cb3f-4bef-a099-304ef0c49837@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <56d1c5d9-cb3f-4bef-a099-304ef0c49837@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh100017.china.huawei.com (7.202.181.103) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-26108-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:yanaijie@huawei.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:liuyonglong@huawei.com,m:kangfenglong@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,h-partners.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04E8D750531

Hi, John

On 2026/7/13 19:26, John Garry wrote:
> On 13/07/2026 04:10, yangxingui wrote:
>> Kindly ping for review...
>>
>> On 2026/7/2 11:32, Xingui Yang wrote:
>>> Commit fbefe22811c3140 ("scsi: libsas: Don't always drain event 
>>> workqueue
>>> for HA resume") introduced sas_resume_ha_no_sync() to avoid a 
>>> deadlock: the
>>> PHYE_RESUME_TIMEOUT handler, running on the HA event workqueue, calls
>>> sas_deform_port() -> sas_destruct_devices(), which removes SCSI 
>>> devices and
>>> waits for the host to become runtime-active. But the host cannot resume
>>> until sas_resume_ha() -> sas_drain_work() returns, and the drain is 
>>> blocked
>>> on that very handler.
>>>
>>> However skipping the drain reintroduces a race: hisi_sas returns from
>>> resume before all PHY UP work and libsas discovery work finish. The
>>> controller may then autosuspend while disks are still waking up. The 
>>> disks
>>> issue IO to a suspended controller, the IO fails, and the disks get
>>> disabled.
>>>
>>> Fix the deadlock at its source by moving the PHYE_RESUME_TIMEOUT
>>> notification to after sas_drain_work(). By then the host resume is 
>>> about to
>>> complete, so device removal through device_link no longer blocks on the
>>> resume and the cycle is broken.
>>>
>>> With the deadlock gone, restore sas_resume_ha() (the draining 
>>> variant) in
>>> hisi_sas and remove sas_resume_ha_no_sync().
>>>
>>> Fixes: fbefe22811c3140 ("scsi: libsas: Don't always drain event 
>>> workqueue for HA resume")
>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> 
> Any idea why this problem has only been discovered after 5 years (from 
> fbefe22811c3140 being merged)?
> 
> Is there some new test case?

Yes, the test environment is connected to more SATA disks. During the 
wake-up process, the controller wakes up first, and then the disks wake 
up one by one. Since the number of SATA disks has increased, and the 
SATA disk enter the EH (Error Handling) process when waking up, the 
wake-up time has become longer than before. It is possible that the 
controller has already entered the next suspend state, while many disks 
are still in the previous wake-up process, leading to a failure in disk 
wake-up and the disks being disabled.

However, we have tested some different kernel versions in between and 
found that the following patch significantly improves this issue, but it 
does not completely resolve it.

bede543d2f8a: ACPI: OSL: Use usleep_range() in acpi_os_sleep()

In addition, if some disks wake up a bit slowly, it may also lead to 
ssubsequent disk wake-up failure.
[  286.932540] hisi_sas_v3_hw 0000:32:04.0: resuming from operating 
state [D0]
[  287.732627] hisi_sas_v3_hw 0000:32:04.0: end of resuming controller
[  293.167893] hisi_sas_v3_hw 0000:32:04.0: entering suspend state
[  341.760789] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  341.761006] sas: Executing internal abort failed 5000000000000307 (-22)
[  341.761021] hisi_sas_v3_hw 0000:32:04.0: I_T nexus reset: internal 
abort (-22)
[  341.761028] sas: ata4: end_device-3:3: Unable to reset ata device?
[  341.916134] sas: lldd_execute_task returned: -22
[  341.916161] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  341.916165] ata4.00: revalidation failed (errno=-5)
[  346.980523] sas: Executing internal abort failed 5000000000000307 (-22)
[  346.980542] hisi_sas_v3_hw 0000:32:04.0: I_T nexus reset: internal 
abort (-22)
[  346.980552] sas: ata4: end_device-3:3: Unable to reset ata device?
[  347.136137] sas: lldd_execute_task returned: -22
[  347.136163] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  347.136169] ata4.00: revalidation failed (errno=-5)
[  352.356924] sas: Executing internal abort failed 5000000000000307 (-22)
[  352.357001] hisi_sas_v3_hw 0000:32:04.0: I_T nexus reset: internal 
abort (-22)
[  352.357011] sas: ata4: end_device-3:3: Unable to reset ata device?
[  352.512174] sas: lldd_execute_task returned: -22
[  352.512255] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x40)
[  352.512263] ata4.00: revalidation failed (errno=-5)
[  352.512269] ata4.00: disable device
[  352.512324] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 
tries: 1
[  352.512408] sas: sas_resume_sata: for direct-attached device 
5000000000000307 returned -19


Thanks,
Xingui
.


