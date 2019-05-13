Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D461AEF8
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 04:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfEMCk0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 May 2019 22:40:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727132AbfEMCk0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 12 May 2019 22:40:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5AD751B4627CE56F6144;
        Mon, 13 May 2019 10:40:20 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 May 2019
 10:40:11 +0800
Subject: Re: Looking for some help understanding error handling
To:     <Chris.Moore@microchip.com>, <hare@suse.de>,
        <linux-scsi@vger.kernel.org>
References: <BY2PR1101MB1174A2F340BA55EE1CF2E810EAE80@BY2PR1101MB1174.namprd11.prod.outlook.com>
 <45b9e96f-d5f9-e8aa-9daf-4d25c192af27@suse.de>
 <BY2PR1101MB117498CE93A1BA8B962F1771EAEB0@BY2PR1101MB1174.namprd11.prod.outlook.com>
CC:     John Garry <john.garry@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <73adc416-f1a7-d381-dd9f-fbc605c587d2@hisilicon.com>
Date:   Mon, 13 May 2019 10:40:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <BY2PR1101MB117498CE93A1BA8B962F1771EAEB0@BY2PR1101MB1174.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



在 2018/10/5 23:51, Chris.Moore@microchip.com 写道:
> Thanks Hannes,
>
> After some pointers from Shane Seymour I found that the FC and SRP transport layers
> have a devloss timer, so that when a device disappears they hold on to the target
> information for a time waiting to see if it comes back.  The SAS transport layer
> doesn't have that feature.
>
> The options for me then would be to modify scsi_transport_sas.c to implement
> the devloss timeout, or to put that functionality into my LLDD.
>
> I'm willing to put the work into the SAS transport and libsas, but I suspect there's
> not a universal need for it.  And since my LLDD is for internal use at our company and
> won't be upstreamed, I'll probably just do the work there.  If anyone feels that this
> is a feature that more people would want then I'll look into doing that.


Hi Chris,
Do you have any progress on dev loss feature? We also are considering
about the feature for driver hisi_sas.

Thanks,
Shawn

>
> Thanks,
> Chris
>
>> -----Original Message-----
>> From: Hannes Reinecke [mailto:hare@suse.de]
>> Sent: Friday, October 5, 2018 8:01 AM
>> To: Chris Moore - C33997 <Chris.Moore@microchip.com>; linux-
>> scsi@vger.kernel.org
>> Subject: Re: Looking for some help understanding error handling
>>
>> On 10/2/18 11:04 PM, Chris.Moore@microchip.com wrote:
>>> I'm working on LLDD for a SAS/SATA host adapter, and trying to understand
>> how the system handles link loss and recovery.
>>> Say I have a device that gets recognized and attached as sd 12:0:4:0, at
>> /dev/sdb.
>>> The drive goes offline temporarily, then comes back online.
>>> When it does, it comes back as sd 12:0:5:0, and maybe /dev/sdb, maybe
>> /dev/sdc.
>>> I'm not sure how the Id gets assigned.  Since this is the same drive,
>>> is there some way my driver can tell libsas and/or SCSI core that it's the
>> same drive coming back?
>>> Or is there no way to control that?
>>>
>> Not really. The target device is getting destroyed once the device
>> disconnects, and when it reconnects a new structure is allocated. But as the
>> target number is a simple counter it gets increased up each allocation.
>>
>>> I looked into /dev/disk/by-id, but that also didn't quite do what I
>>> expected.  If I open /dev/disk/by-id/some_identifier, that's a symlink to,
>> say, /dev/sdb.
>>
>> Yes.
>>
>>>   /dev/sdb goes away, comes back as /dev/sdc, but my process doesn't
>>> know that, it still has /dev/disk/by-id/some_identifier opened and so it will
>> never recover without closing and reopening the file.
>> Simply don't keep hold of the symlink; once you have opened you'll miss any
>> updates to the symlink itself.
>> So better to open the symlink, check the device, do whatever needs to be
>> done, and _close the symlink_ again.
>> Then you can listen for udev events telling you when a device appears or
>> vanishes.
>>
>> Cheers,
>>
>> Hannes
>> --
>> Dr. Hannes Reinecke		   Teamlead Storage & Networking
>> hare@suse.de			               +49 911 74053 688
>> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
>> GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton HRB 21284
>> (AG Nürnberg)


