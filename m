Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1636EB38
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Apr 2021 15:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhD2NSB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Apr 2021 09:18:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2952 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhD2NSA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 29 Apr 2021 09:18:00 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FWG3Y4zCWz77b25;
        Thu, 29 Apr 2021 21:06:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 15:17:12 +0200
Received: from [10.47.27.96] (10.47.27.96) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 29 Apr
 2021 14:17:11 +0100
Subject: Re: [PATCH] scsi_debug: fix cmd_per_lun, set to max_queue
To:     <dgilbert@interlog.com>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>
CC:     <jejb@linux.vnet.ibm.com>, <kashyap.desai@broadcom.com>,
        <ming.lei@redhat.com>, <axboe@kernel.dk>
References: <20210415015031.607153-1-dgilbert@interlog.com>
 <408b1dce-3c6e-48dc-2f8b-23fe999ab3db@huawei.com>
 <85dec8eb-8eab-c7d6-b0fb-5622747c5499@interlog.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <33878b23-319e-3ac4-7c5e-b8f28887ede2@huawei.com>
Date:   Thu, 29 Apr 2021 14:17:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <85dec8eb-8eab-c7d6-b0fb-5622747c5499@interlog.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.27.96]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 16/04/2021 17:32, Douglas Gilbert wrote:
> On 2021-04-16 5:12 a.m., John Garry wrote:
>> On 15/04/2021 02:50, Douglas Gilbert wrote:
>>> Make sure that the cmd_per_lun value placed in the host template
>>> never exceeds the can_queue value. If the max_queue driver
>>> parameter is not specified then both cmd_per_lun and can_queue are
>>> set to CAN_QUEUE. CAN_QUEUE is a compile time constant and is used
>>> to dimension an array to hold queued requests. If the max_queue
>>> driver parameter is given it is must be less than or equal to
>>> CAN_QUEUE and if so, the host template values are adjusted.
>>>
>>> Remove undocumented code that allowed queue_depth to exceed
>>> CAN_QUEUE and cause stack full type errors. There is a documented
>>> way to do that with every_nth and
>>>      echo 0x8000 > /sys/bus/pseudo/drivers/scsi_debug/opts
>>> See: https://sg.danny.cz/sg/scsi_debug.html
>>>
>>> Tweak some formatting, and add a suggestion to the "trim
>>> poll_queues" warning.
>>>
>>> Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
>>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>

Hi Martin,

Could we get this picked up please?

Thanks!
