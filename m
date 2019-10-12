Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F751D4C0B
	for <lists+linux-scsi@lfdr.de>; Sat, 12 Oct 2019 04:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfJLCK4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Oct 2019 22:10:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728587AbfJLCK4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 11 Oct 2019 22:10:56 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5C4939953D7986DE7905;
        Sat, 12 Oct 2019 10:10:53 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 12 Oct 2019
 10:10:50 +0800
Subject: Re: [PATCH v2] scsi: core: fix uninit-value access of variable sshdr
To:     James Bottomley <jejb@linux.ibm.com>, <bvanassche@acm.org>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
References: <1570843610-63645-1-git-send-email-zhengbin13@huawei.com>
 <1570845482.17735.27.camel@linux.ibm.com>
 <783b66dc-e7e9-3780-3041-7ab03491def5@huawei.com>
 <1570845968.17735.28.camel@linux.ibm.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <f99ef947-080a-b2ff-e43e-66a0a69fa304@huawei.com>
Date:   Sat, 12 Oct 2019 10:10:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1570845968.17735.28.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


On 2019/10/12 10:06, James Bottomley wrote:
> On Sat, 2019-10-12 at 10:03 +0800, zhengbin (A) wrote:
>> On 2019/10/12 9:58, James Bottomley wrote:
>>> On Sat, 2019-10-12 at 09:26 +0800, zhengbin wrote:
>>>> BTW: we can't just init sshdr->response_code, sr_do_ioctl use
>>>> sshdr->sense_key
>>> That's an actual bug, isn't it?
>> If we init sshdr in __scsi_execute, this will be ok
> No I mean it's a bug because sr_do_ioctl shouldn't be acting on sense
> that isn't valid.  So all uses of sshdr should be gated on a validity
> check.

Yes you are right, the right way is use scsi_sense_valid(&sshdr), I have troubleshoot callers,

this is the only wrong use(Maybe I miss some...).

>
> James
>
>
> .
>

