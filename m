Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC1316FE3F
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Feb 2020 12:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBZLvH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Feb 2020 06:51:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbgBZLvH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Feb 2020 06:51:07 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C3EDBF05E85AF203D49F;
        Wed, 26 Feb 2020 19:50:58 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.231) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 19:50:47 +0800
Message-ID: <5E565B97.2070004@huawei.com>
Date:   Wed, 26 Feb 2020 19:50:47 +0800
From:   AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Christoph Hellwig <hch@infradead.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <zhengchuan@huawei.com>,
        <jiangyiwen@huawei.com>, <robin.yb@huawei.com>,
        <yangjieyj.yang@huawei.com>
Subject: Re: [PATCH V2] scsi: add a new flag to set whether SCSI disks support
 WRITE_SAME_16 by default
References: <5E28118F.3070706@huawei.com> <5E3520A7.5030501@huawei.com> <20200225183126.GA6261@infradead.org>
In-Reply-To: <20200225183126.GA6261@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.231]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Christoph,

Thanks for your reply.

On 2020/2/26 2:31, Christoph Hellwig wrote:
> On Sat, Feb 01, 2020 at 02:54:31PM +0800, AlexChen wrote:
>> When the SCSI device is initialized, check whether it supports
>> WRITE_SAME_16 or WRITE_SAME_10 in the sd_read_write_same(). If
>> the back-end storage device does not support queries, it will not
>> set sdkp->ws16 as 1.
>>
>> When the WRITE_SAME io is issued through the blkdev_issue_write_same(),
>> the WRITE_SAME type is set to WRITE_SAME_10 by default in
>> the sd_setup_write_same_cmnd() since of "sdkp->ws16=0". If the storage
>> device does not support WRITE_SAME_10, then the SCSI device is set to
>> not support WRITE_SAME.
>>
>> Currently, some storage devices do not provide queries for WRITE_SAME_16
>> support, and only WRITE_SAME_16 is supported, not WRITE_SAME_10.
>> Therefore, we need to provide a new flag for these storage devices. When
>> initializing these devices, we will no longer query for support for
>> WRITE_SAME_16 in the sd_read_write_same(), but set these SCSI disks to
>> support WRITE_SAME_16 by default. In that way, we can add
>> 'vendor:product:flag' to the module parameter 'dev_flags' for these
>> storage devices.
> 
> Please send this along with the patch that actually sets the flag
> somewhere..
> 

If we want Huawei storage device to support WRITE_SAME_16 by default,
we can add module parameter dev_flags='HUAWEI::‭17179869184‬' to the kernel
command line parameters.
Do you mean I need to add these to this patch description?

Thanks
Alex

