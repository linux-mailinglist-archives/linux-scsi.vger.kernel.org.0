Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C00180987
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Mar 2020 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCJUrT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Mar 2020 16:47:19 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgCJUrT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 10 Mar 2020 16:47:19 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id AED8D1EA86F300381B4F;
        Tue, 10 Mar 2020 20:47:14 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 20:47:14 +0000
Received: from [127.0.0.1] (10.210.167.10) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 20:47:12 +0000
Subject: Re: [PATCH RFC v2 22/24] scsi: drop scsi command list
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <esc.storagedev@microsemi.com>, <chenxiang66@hisilicon.com>,
        Hannes Reinecke <hare@suse.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-23-git-send-email-john.garry@huawei.com>
 <20200310183504.GB14549@infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2ffd671a-e580-cd5e-dd90-802f9641519f@huawei.com>
Date:   Tue, 10 Mar 2020 20:47:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200310183504.GB14549@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.10]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/03/2020 18:35, Christoph Hellwig wrote:
> On Wed, Mar 11, 2020 at 12:25:48AM +0800, John Garry wrote:
>> From: Hannes Reinecke <hare@suse.com>
>>
>> No users left, kill it.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
> 
> Wasn't this part of a series from Hannes that already got merged?


Ah, yes. I'll check what can be dropped now.

cheers
