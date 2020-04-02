Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6289D19BA44
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Apr 2020 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgDBCZH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 Apr 2020 22:25:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732435AbgDBCZH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 1 Apr 2020 22:25:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5314D35FA9B420C4201C;
        Thu,  2 Apr 2020 10:25:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 10:24:55 +0800
Subject: Re: [PATCH] scsi: remove show_use_blk_mq()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     John Garry <john.garry@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <linux-scsi@vger.kernel.org>, "Ewan D . Milne" <emilne@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20200401134049.9352-1-yanaijie@huawei.com>
 <57f6fde1-fe0c-68e7-f476-35d92902c6b1@huawei.com>
 <ba97c964-1da2-e465-f472-dce50dcfd3f6@huawei.com>
 <yq1zhbu4p4v.fsf@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <8119d044-dbf4-0fbe-946a-86fb7dec23b2@huawei.com>
Date:   Thu, 2 Apr 2020 10:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <yq1zhbu4p4v.fsf@oracle.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



ÔÚ 2020/4/2 10:06, Martin K. Petersen Ð´µÀ:
> 
> Jason,
> 
>> Maybe. But removing a module param may break the user space too.
> 
> It won't break loading the module.
> 
> The intent is to leave the sysfs parameter in place for a while to make
> sure nobody depends on it.
> 

OK, thanks.

