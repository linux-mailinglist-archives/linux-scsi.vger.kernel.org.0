Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385312D3511
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Dec 2020 22:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgLHVP3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Dec 2020 16:15:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2227 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLHVP3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Dec 2020 16:15:29 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CrCXd65Qtz67FSB;
        Wed,  9 Dec 2020 05:11:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 22:14:47 +0100
Received: from [10.210.169.98] (10.210.169.98) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 21:14:46 +0000
Subject: Re: problem booting 5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Julia Lawall <julia.lawall@inria.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <nicolas.palix@univ-grenoble-alpes.fr>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
 <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
 <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com>
 <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9106e994-bb4b-4148-1280-f08f71427420@huawei.com>
Date:   Tue, 8 Dec 2020 21:14:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.98]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 08/12/2020 19:19, Linus Torvalds wrote:
> On Tue, Dec 8, 2020 at 10:59 AM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
>>
>>> So I'm adding SCSI people to the cc, just in case they go "Hmm..".
>>
>> Only change in this department was:
>>
>> 831e3405c2a3 scsi: core: Don't start concurrent async scan on same host
> 
> Yeah, I found that one too, and dismissed it for the same reason you
> did - it wasn't in rc1. Plus it looked very simple.
> 
> That said, maybe Julia might have misspoken, and rc1 was ok, so I
> guess it's possible. The scan_mutex does show up in that "locks held"
> list, although I can't see why it would matter. But it does
> potentially change timing (so it could expose some existing race), if
> nothing else.
> 
> But let's make sure Jens is aware of this too, in case it's some ATA
> issue. Not that any of those handful of 5.10 changes look remotely
> likely _either_.
> 
> Jens, see
> 
>     https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2012081813310.2680@hadrien/
> 
> if you don't already have the lkml thread locally.. There's not enough
> of the dmesg to even really guess what Julia's actual hardware is,
> apart from it being a Seagate SATA disk. Julia? What controllers and
> disks do you have show up when things work?
> 
>               Linus
> .
> 

JFYI, About "scsi: megaraid_sas: Added support for shared host tagset 
for cpuhotplug", we did have an issue reported here already from Qian 
about a boot hang:

https://lore.kernel.org/linux-scsi/fe3dff7dae4494e5a88caffbb4d877bbf472dceb.camel@redhat.com/

And the solution to that specific problem is in:
https://lore.kernel.org/linux-block/20201203012638.543321-1-ming.lei@redhat.com/

This issue may be related, so you could test by reverting that megaraid 
sas commit or setting the driver module param "host_tagset_enable=0" 
just to see.

Thanks,
John
