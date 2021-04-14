Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F41035F963
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Apr 2021 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhDNRDw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Apr 2021 13:03:52 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:51143 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhDNRDv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Apr 2021 13:03:51 -0400
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 9A38B2EA280;
        Wed, 14 Apr 2021 13:03:29 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id BlG6Ymp4W5vy; Wed, 14 Apr 2021 12:44:11 -0400 (EDT)
Received: from [192.168.48.23] (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id C55362EA02B;
        Wed, 14 Apr 2021 13:03:28 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [bug report] shared tags causes IO hang and performance drop
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
References: <YHaez6iN2HHYxYOh@T590>
 <9a6145a5-e6ac-3d33-b52a-0823bfc3b864@huawei.com>
 <cb326d404c6e0785d03a7dfadc42832c@mail.gmail.com> <YHbOOfGNHwO4SMS7@T590>
 <b41586781cffea03c5fd6b0849e2b9e4@mail.gmail.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <75ac498d-763c-e52b-a870-e3a91b930624@interlog.com>
Date:   Wed, 14 Apr 2021 13:03:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b41586781cffea03c5fd6b0849e2b9e4@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-04-14 9:59 a.m., Kashyap Desai wrote:
>>> I tried both - 5.12.0-rc1 and 5.11.0-rc2+ and there is a same
> behavior.
>>> Let me also check  megaraid_sas and see if anything generic or this is
>>> a special case of scsi_debug.
>>
>> As I mentioned, it could be one generic issue wrt. SCHED_RESTART.
>> shared tags might have to restart all hctx since all share same tags.
> 
> Ming - I tried many combination on MR shared host tag driver but there is
> no single instance of IO hang.
> I will keep trying, but when I look at scsi_debug driver code I found
> below odd settings in scsi_debug driver.
> can_queue of adapter is set to 128 but queue_depth of sdev is set to 255.
> 
> If I apply below patch, scsi_debug driver's hang is also resolved. Ideally
> sdev->queue depth cannot exceed shost->can_queue.
> Not sure why cmd_per_lun is 255 in scsi_debug driver which can easily
> exceed can_queue.  I will simulate something similar in MR driver and see
> how it behaves w.r.t IO hang issue.
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 70165be10f00..dded762540ee 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -218,7 +218,7 @@ static const char *sdebug_version_date = "20200710";
>    */
>   #define SDEBUG_CANQUEUE_WORDS  3       /* a WORD is bits in a long */
>   #define SDEBUG_CANQUEUE  (SDEBUG_CANQUEUE_WORDS * BITS_PER_LONG)

So SDEBUG_CANQUEUE is 3*64 = 192 and is a hard limit (it is used to
dimension an array). Should it be upped to 4, say? [That will slow things
down a bit if that is an issue.]

> -#define DEF_CMD_PER_LUN  255
> +#define DEF_CMD_PER_LUN  SDEBUG_CANQUEUE
> 
>   /* UA - Unit Attention; SA - Service Action; SSU - Start Stop Unit */
>   #define F_D_IN                 1       /* Data-in command (e.g. READ) */
> @@ -7558,6 +7558,7 @@ static int sdebug_driver_probe(struct device *dev)
>          sdbg_host = to_sdebug_host(dev);
> 
>          sdebug_driver_template.can_queue = sdebug_max_queue;
> +       sdebug_driver_template.cmd_per_lun = sdebug_max_queue;

I'll  push out a patch shortly.

Doug Gilbert


>          if (!sdebug_clustering)
>                  sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
>>
>>
>> Thanks,
>> Ming

