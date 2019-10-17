Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95BEDA455
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Oct 2019 05:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392180AbfJQD0t (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Oct 2019 23:26:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732869AbfJQD0s (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 16 Oct 2019 23:26:48 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0331DCD7EB2ECB804A13;
        Thu, 17 Oct 2019 11:26:46 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 11:26:36 +0800
Subject: Re: [PATCH v3] scsi: core: fix uninit-value access of variable sshdr
To:     Bart Van Assche <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>
References: <1570850706-12063-1-git-send-email-zhengbin13@huawei.com>
 <3e3f05fb-387a-d55f-fc90-72d01c6d026a@acm.org>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <eb7310f0-ec09-0ed9-c19d-c52cf0d62f0c@huawei.com>
Date:   Thu, 17 Oct 2019 11:26:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <3e3f05fb-387a-d55f-fc90-72d01c6d026a@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


On 2019/10/17 10:45, Bart Van Assche wrote:
> On 2019-10-11 20:25, zhengbin wrote:
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 5447738..d5e29c5 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -255,6 +255,13 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
>>  	struct scsi_request *rq;
>>  	int ret = DRIVER_ERROR << 24;
>>
>> +	/*
>> +	 * Zero-initialize sshdr for those callers that check the *sshdr
>> +	 * contents even if no sense data is available.
>> +	 */
>> +	if (sshdr)
>> +		memset(sshdr, 0, sizeof(struct scsi_sense_hdr));
>> +
>>  	req = blk_get_request(sdev->request_queue,
>>  			data_direction == DMA_TO_DEVICE ?
>>  			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
> Although I don't have a strong opinion about this, I'm still wondering
> whether 'sshdr' should be initialized in __scsi_execute() or by its caller.
@jejb, @martin, any suggestion?
>
>> diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
>> index ffcf902..335cfdd 100644
>> --- a/drivers/scsi/sr_ioctl.c
>> +++ b/drivers/scsi/sr_ioctl.c
>> @@ -206,6 +206,11 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
>>
>>  	/* Minimal error checking.  Ignore cases we know about, and report the rest. */
>>  	if (driver_byte(result) != 0) {
>> +		if (!scsi_sense_valid(sshdr)) {
>> +			err = -EIO;
>> +			goto out;
>> +		}
>> +
>>  		switch (sshdr->sense_key) {
>>  		case UNIT_ATTENTION:
>>  			SDev->changed = 1;
> Shouldn't this be a separate patch?
OK, will send a separate patch
>
> Thanks,
>
> Bart.
>
> .
>

