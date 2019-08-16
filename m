Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3088F829
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Aug 2019 02:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfHPAyQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Aug 2019 20:54:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfHPAyP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 15 Aug 2019 20:54:15 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 250D485B8391164F6185;
        Fri, 16 Aug 2019 08:54:08 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 08:54:00 +0800
Subject: Re: [PATCH v4] SCSI: fix queue cleanup race before
 scsi_requeue_run_queue is done
To:     Bart Van Assche <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        <linux-scsi@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yanaijie@huawei.com>
References: <1565667334-22071-1-git-send-email-zhengbin13@huawei.com>
 <e79e0996-37e0-049c-7546-990b280424d0@huawei.com>
 <ca5e857f-472d-6849-6907-1f36879997dd@acm.org>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <8d9139cb-16a7-2a53-aaf2-fd13c71bf053@huawei.com>
Date:   Fri, 16 Aug 2019 08:53:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <ca5e857f-472d-6849-6907-1f36879997dd@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019/8/15 23:40, Bart Van Assche wrote:

> On 8/14/19 6:50 PM, zhengbin (A) wrote:
>> ping
>
> Sending a "ping" after 46 hours is way too soon and only causes irritation. What would help though is more information about how this patch has been tested. Does it e.g. survive the srp tests in blktests?

Very sorry for the noise, it won't happen again next time.

I have done abnormal operations while running sdtester, it is ok within this patch after a day.

Without this, it will cause oops because of use-after-free after about 4 hours.

>
> Thanks,
>
> Bart.
>
> .
>

