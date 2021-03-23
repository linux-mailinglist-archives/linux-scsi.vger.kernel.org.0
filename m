Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4537734590B
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Mar 2021 08:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCWHr2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Mar 2021 03:47:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCWHrO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 Mar 2021 03:47:14 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4Ngt3qSGzrWks;
        Tue, 23 Mar 2021 15:45:14 +0800 (CST)
Received: from [10.174.178.113] (10.174.178.113) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 15:47:06 +0800
Subject: Re: md/dm-mpath: check whether all pgpaths have same uuid in
 multipath_ctr()
To:     Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
CC:     <agk@redhat.com>, <dm-devel@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
References: <c8f86351-3036-0945-90d2-2e020d68ccf2@huawei.com>
 <20210322081155.GE1946905@infradead.org> <20210322142207.GB30698@redhat.com>
From:   lixiaokeng <lixiaokeng@huawei.com>
Message-ID: <a46013db-8143-7b41-95a8-182439b385f2@huawei.com>
Date:   Tue, 23 Mar 2021 15:47:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210322142207.GB30698@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.113]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 2021/3/22 22:22, Mike Snitzer wrote:
> On Mon, Mar 22 2021 at  4:11am -0400,
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> On Sat, Mar 20, 2021 at 03:19:23PM +0800, Zhiqiang Liu wrote:
>>> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>>
>>> When we make IO stress test on multipath device, there will
>>> be a metadata err because of wrong path. In the test, we
>>> concurrent execute 'iscsi device login|logout' and
>>> 'multipath -r' command with IO stress on multipath device.
>>> In some case, systemd-udevd may have not time to process
>>> uevents of iscsi device logout|login, and then 'multipath -r'
>>> command triggers multipathd daemon calls ioctl to load table
>>> with incorrect old device info from systemd-udevd.
>>> Then, one iscsi path may be incorrectly attached to another
>>> multipath which has different uuid. Finally, the metadata err
>>> occurs when umounting filesystem to down write metadata on
>>> the iscsi device which is actually not owned by the multipath
>>> device.
>>>
>>> So we need to check whether all pgpaths of one multipath have
>>> the same uuid, if not, we should throw a error.
>>>
>>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>> Signed-off-by: lixiaokeng <lixiaokeng@huawei.com>
>>> Signed-off-by: linfeilong <linfeilong@huawei.com>
>>> Signed-off-by: Wubo <wubo40@huawei.com>
>>> ---
>>>  drivers/md/dm-mpath.c   | 52 +++++++++++++++++++++++++++++++++++++++++
>>>  drivers/scsi/scsi_lib.c |  1 +
>>>  2 files changed, 53 insertions(+)
>>>
>>> diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
>>> index bced42f082b0..f0b995784b53 100644
>>> --- a/drivers/md/dm-mpath.c
>>> +++ b/drivers/md/dm-mpath.c
>>> @@ -24,6 +24,7 @@
>>>  #include <linux/workqueue.h>
>>>  #include <linux/delay.h>
>>>  #include <scsi/scsi_dh.h>
>>> +#include <linux/dm-ioctl.h>
>>>  #include <linux/atomic.h>
>>>  #include <linux/blk-mq.h>
>>>
>>> @@ -1169,6 +1170,45 @@ static int parse_features(struct dm_arg_set *as, struct multipath *m)
>>>  	return r;
>>>  }
>>>
>>> +#define SCSI_VPD_LUN_ID_PREFIX_LEN 4
>>> +#define MPATH_UUID_PREFIX_LEN 7
>>> +static int check_pg_uuid(struct priority_group *pg, char *md_uuid)
>>> +{
>>> +	char pgpath_uuid[DM_UUID_LEN] = {0};
>>> +	struct request_queue *q;
>>> +	struct pgpath *pgpath;
>>> +	struct scsi_device *sdev;
>>> +	ssize_t count;
>>> +	int r = 0;
>>> +
>>> +	list_for_each_entry(pgpath, &pg->pgpaths, list) {
>>> +		q = bdev_get_queue(pgpath->path.dev->bdev);
>>> +		sdev = scsi_device_from_queue(q);
>>
>> Common dm-multipath code should never poke into scsi internals.  This
>> is something for the device handler to check.  It probably also won't
>> work for all older devices.
> 
> Definitely.
> 
> But that aside, userspace (multipathd) _should_ be able to do extra
> validation, _before_ pushing down a new table to the kernel, rather than
> forcing the kernel to do it.
> 

Martin (committer of multipath-tools) said that:
"Don't get me wrong, I don't argue against tough testing. But we should
be aware that there are always time intervals during which multipathd's
picture of the present devices is different from what the kernel sees."

It is difficult to solve this in multipathd.

Regards,
Lixiaokeng
