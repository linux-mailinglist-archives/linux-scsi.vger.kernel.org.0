Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028922A7C93
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Nov 2020 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgKELFX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 5 Nov 2020 06:05:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7146 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKELFX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 5 Nov 2020 06:05:23 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CRgfP2bwhz15RqR;
        Thu,  5 Nov 2020 19:05:17 +0800 (CST)
Received: from [127.0.0.1] (10.57.22.126) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 5 Nov 2020
 19:05:11 +0800
Subject: Re: [PATCH v3 0/5] Introduce a new helper marco
 DEFINE_SHOW_STORE_ATTRIBUTE at seq_file.c
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <john.garry@huawei.com>, <himanshu.madhani@cavium.com>,
        <felipe.balbi@linux.intel.com>, <uma.shankar@intel.com>,
        <anshuman.gupta@intel.com>, <animesh.manna@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1604406584-53926-1-git-send-email-luojiaxing@huawei.com>
 <20201103133644.GA2067567@kroah.com>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <69d4de3f-cf1f-3530-fc53-5cf30d11010d@huawei.com>
Date:   Thu, 5 Nov 2020 19:05:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20201103133644.GA2067567@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.57.22.126]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi, Greg

On 2020/11/3 21:36, Greg KH wrote:
> On Tue, Nov 03, 2020 at 08:29:39PM +0800, Luo Jiaxing wrote:
>> We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
>> for read-only file, but we found many of drivers also want a helper macro
>> for read-write file too.
>>
>> So we add this macro to help decrease code duplication.
>>
>> ---
>>   v1->v2:
>>          1.Rename DEFINE_STORE_ATTRIBUTE() to DEFINE_SHOW_STORE_ATTRIBUTE().
>>   v2->v3:
>>          1.Fixed some spelling mistakes in commit.
>>          2.Revised resumes are added for easy tracing.
> You forgot to address Al Viro's review comments :(


Yes, I remember that AI Viro point out that he don't want this, but Andy 
reply later and suggest me to modify the naming,

So I send a v2 for review.


Actually I am not sure about what you mean by " forgot to address Al 
Viro's review comments ". Should I add AI Viro's review comments at my 
changes description?


Thanks

Jiaxing


>
>
> .
>

