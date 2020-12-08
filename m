Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119DC2D36C8
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Dec 2020 00:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbgLHXOx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Dec 2020 18:14:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2228 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbgLHXOw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Dec 2020 18:14:52 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CrGBP0468z67KCk;
        Wed,  9 Dec 2020 07:10:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 00:14:10 +0100
Received: from [10.210.169.98] (10.210.169.98) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 23:14:09 +0000
Subject: Re: problem booting 5.10
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Julia Lawall <julia.lawall@inria.fr>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
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
 <9106e994-bb4b-4148-1280-f08f71427420@huawei.com>
 <CAHk-=wjsWB612YA0OSpVPkzePxQWyqcSGDaY1-x3R2AgjOCqSQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2012082339470.16458@hadrien>
 <yq1sg8fud7y.fsf@ca-mkp.ca.oracle.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4f3cd4d4-87d3-dc9a-027d-293cba469d5a@huawei.com>
Date:   Tue, 8 Dec 2020 23:13:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <yq1sg8fud7y.fsf@ca-mkp.ca.oracle.com>
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

On 08/12/2020 22:51, Martin K. Petersen wrote:
> 
> Julia,
> 
>> This solves the problem.  Starting from 5.10-rc7 and doing this revert, I
>> get a kernel that boots.
> 

Hi Julia,

Can you also please test Ming's patchset here (without the megaraid sas 
revert) when you get a chance:
https://lore.kernel.org/linux-block/20201203012638.543321-1-ming.lei@redhat.com/

And please also share your .config, as I guess that it is not mainline 
vanilla and we will want to recreate this to be sure for future. Qian's 
issue was only exposed with a specific .config enabling lots of heavy 
debug options.

Thanks,
John

> Thanks for testing!
> 
> I'll go ahead and revert 103fbf8e4020 in 5.10/scsi-fixes. We can revisit
> this change in 5.11 when Ming's fixes are in place.
> 
