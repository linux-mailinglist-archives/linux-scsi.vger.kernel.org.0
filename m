Return-Path: <linux-scsi+bounces-7239-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E694C8F0
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2024 05:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF6A1F22D9D
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2024 03:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2C18E29;
	Fri,  9 Aug 2024 03:44:56 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E418B04;
	Fri,  9 Aug 2024 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723175096; cv=none; b=PMjehfYMRKM8EQvkd2rwPc/5WoyeO0YGpNjs5dlSZutB5N9hhYf4aU5G9F+jnY9FWE/hSiM7/mHBl/wmbBYRhVdpQgb7RhNzVxxI1ZN7F82NjPlPc0WByg1QTCsvoiG56EpfOyCA9yfzRwQiIrGHJiFG1vycxHgHSZtGqDOII1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723175096; c=relaxed/simple;
	bh=OhET1XZSG40Mo/skFzSUw3iQfX3vkRLXE0SBE9EiGto=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NQlQaO0E04OvDSjv1PfFkAgcILOqbCUJDv82yIzpUwVdzf3TnAHEU7FjokEgHRaEbzcHtJtDIAdj310iZgdATpAPPsBZxXlP2dGGCUnb7xIivtRcIWHcxkuft78qKmWWG5d8ddIkyOJaoOcZ38pNU0j1OFpCkMGFDM9cUuI04cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wg8t31rQbzyP5D;
	Fri,  9 Aug 2024 11:44:27 +0800 (CST)
Received: from dggpemf100013.china.huawei.com (unknown [7.185.36.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 53B2714011A;
	Fri,  9 Aug 2024 11:44:50 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 dggpemf100013.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Aug 2024 11:44:50 +0800
Subject: Re: [PATCH] scsi: sd: retry command SYNC CACHE if format in progress
To: Bart Van Assche <bvanassche@acm.org>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>
References: <20240808021719.4167352-1-liyihang9@huawei.com>
 <1cd0b145-431a-4d9f-979f-04d4063eeda8@acm.org>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@huawei.com>, <linuxarm@huawei.com>, <liyihang9@huawei.com>
From: Yihang Li <liyihang9@huawei.com>
Message-ID: <e6b05d46-7acd-8364-2826-c14e342f8e2d@huawei.com>
Date: Fri, 9 Aug 2024 11:44:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1cd0b145-431a-4d9f-979f-04d4063eeda8@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100013.china.huawei.com (7.185.36.179)



On 2024/8/9 3:09, Bart Van Assche wrote:
> On 8/7/24 7:17 PM, Yihang Li wrote:
>> If formatting a suspended disk (such as formatting with different DIF
>> type), the SYNC CACHE command will fail because the disk is in the
>> formatting process, which will cause the runtime_status of the disk to
>> error and it is difficult for user to recover it.
>>
>> To solve the issue, retry the command until format command is finished.
> 
> How is the format command submitted to the SCSI disk? Is that command
> perhaps submitted as a SCSI pass-through command (SG_IO ioctl)?
> 

When formatting a suspended disk, the disk will be resuming first,
and then the format command will submit to the disk through SG_IO ioctl.

When the disk is processing the formatting command, the system does not
submit other commands to the disk. Therefore, the system attempts to suspend
the disk again and sends the SYNC CACHE command. However, the SYNC CACHE
command fails because the disk is being formatted.

Error info like:

[  669.925325] sd 6:0:6:0: [sdg] Synchronizing SCSI cache
[  670.202371] sd 6:0:6:0: [sdg] Synchronize Cache(10) failed: Result: hostbyte=0x00 driverbyte=DRIVER_OK
[  670.216300] sd 6:0:6:0: [sdg] Sense Key : 0x2 [current]
[  670.221860] sd 6:0:6:0: [sdg] ASC=0x4 ASCQ=0x4


> Should the sd driver perhaps be unbound while the format command is in
> progress?
> 

I do not have any suggestions for this yet. I don't know how to unbound driver
when executing the format command and bound driver after the command is executed.

If you have any suggestions, please let me know.

Thanks,

Yihang.

