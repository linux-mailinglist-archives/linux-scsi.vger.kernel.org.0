Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB75EEFC7
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Sep 2022 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiI2H4k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Sep 2022 03:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiI2H4f (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 29 Sep 2022 03:56:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7E13A077
        for <linux-scsi@vger.kernel.org>; Thu, 29 Sep 2022 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664438194; x=1695974194;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8+7jrNgrZjInF4YQCngqsA8zpNl71K0ZbDC0AH3WGWQ=;
  b=c4nhZVKJRddFSiNqrmtpHhN3n6n35rKv/HN0k3gcyvviiQj6CVymqb4E
   vAXr2sHJ1x/W9XNoDmPJ/HH/dP5L0hV1hQ9pZjPnvjvp6zqvifE0OqLCK
   n9UV/gg8DHOVa5fb6EgTb9rBl7UOOYDxkRgflRwPchXIpQtZbmLw1aEGM
   aOZwfsXkIA8gTe1R6wGKDMMG3VpFiGxQr9wdpGzf3VxSeTom05GJu+VfD
   svpf56j6PvCfAiBjYBl00mE354hlm+fvsfNb3sLEEtMlllRPxAT1bzMA+
   9xqlFFFfeYwOfDebFcrhb5i7jaJRQT9/xVo7FsKW6yywZG+C9Y/3HVReA
   A==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="212560705"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 15:56:33 +0800
IronPort-SDR: 7FguYqFiJ+xHKXt0/9pjLUKVoYdHkK94l0P6lj3F1q7ttCSd+C46e5+6RmwV3cBZfizTj88YpF
 v+wzN9z1v1V+Bsht/KUGmYhUYz5FcPyh1spsFSTy6KUpUV4IQ3ucJBCacX3SpX73h/EWegf/aN
 k0zrFt/8HFjBUzrNu4CmHAtgKej82Qje9eBjPJzv2PFhM2xlZSI/Y2norllIFA5bXaxnK8gR+y
 0/5OeM16e1u7Bcg2j8w/vhVZC5sRFwYV3So6d+wT8Wqyi5uPXcvhuN65JG2eRry/HO3k5A2fmF
 JLa1rJdDGJoTQ+pkW5l3/qOl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2022 00:10:55 -0700
IronPort-SDR: 9HObrkdm/OtmJKhMMfdNuoRpw8V0TMnr9KTaAGbmvGvMnYp8gpKxVbTyutcNu5teGDJAyHnc/j
 JdGXK6G9TfP+w1/8FRAQzZVrdym09lvFaJTNgPJz4mk9j5Z7hIxw9awNh6PFv3XCGAvL8PXHWt
 SOoldHVQwGt5SwyX0wpzmhDFZOfXopB6xYivrgMQggitAj4ysrN+gqqL/4K3DRadxwFXPudhOn
 qALxeRsEhFwBWgc4YdSXOmse/gJOVgyKz6/rp9hH5dV7y4NhLPpM+IEonMpSa4GSk7Id0Ey3yh
 u0c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2022 00:56:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdQfm6rLrz1Rwt8
        for <linux-scsi@vger.kernel.org>; Thu, 29 Sep 2022 00:56:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664438192; x=1667030193; bh=8+7jrNgrZjInF4YQCngqsA8zpNl71K0ZbDC
        0AH3WGWQ=; b=XZIhT6abVWLd/1XfGbSyhyg+CGiApcQkN85nUAQbY/seNhVqRZ0
        45EFQgddcjyQrmQ//JzeWHbPyucw6DV6E8e1JxLYQqthYGgy9o9kSIgovTAj9TVu
        rq5EeanXiY3oh9OccYqzDwi5UynCZ810Ytu/mX2T9Lsn7IOK1BoC7qsMnxnVUW+J
        LNTe1tHPetezm9rbTziXoLw1Z99nIz51I8zcojpgCauLWSU8zbwBS1rmthsERyGN
        +bxHpqQv0nQM/thC/DeXbhBWm2nedfZqRdRZ/78Z4OkZAPzm8yZ8TRCuj9QXALH2
        XkWAC8D/i9bO7pvceahC3scwCkSvTrufPXQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nDmROra-zqjF for <linux-scsi@vger.kernel.org>;
        Thu, 29 Sep 2022 00:56:32 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdQfk1SrDz1RvLy;
        Thu, 29 Sep 2022 00:56:29 -0700 (PDT)
Message-ID: <d938ff8d-caaf-9221-e598-62e7e04aa907@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 16:56:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@wdc.com
Cc:     hare@suse.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        ipylypiv@google.com, changyuanl@google.com, hch@lst.de
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
 <0c0306d7-2645-874a-9745-8aa5dcfeede1@opensource.wdc.com>
 <1356c5b0-5cd7-b006-1b34-a66a34e23fb4@huawei.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1356c5b0-5cd7-b006-1b34-a66a34e23fb4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/29/22 16:33, John Garry wrote:
> On 29/09/2022 03:09, Damien Le Moal wrote:
>> On 9/28/22 21:27, John Garry wrote:
>>> blk-mq already provides a unique tag per request. Some libsas LLDDs - like
>>> hisi_sas - already use this tag as the unique per-IO HW tag.
>>>
>>> Add a common function to provide the request associated with a sas_task
>>> for all libsas LLDDs.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   include/scsi/libsas.h | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>>> index f86b56bf7833..bc51756a3317 100644
>>> --- a/include/scsi/libsas.h
>>> +++ b/include/scsi/libsas.h
>>> @@ -644,6 +644,28 @@ static inline bool sas_is_internal_abort(struct sas_task *task)
>>>   	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
>>>   }
>>>   
>>> +static inline struct request *sas_task_find_rq(struct sas_task *task)
>>> +{
>>> +	struct scsi_cmnd *scmd;
>>> +
>>> +	if (!task || !task->uldd_task)
>>> +		return NULL;
>>> +
>>> +	if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
>>> +		struct ata_queued_cmd *qc;
>>> +
>>> +		qc = task->uldd_task;
>>
>> I would change these 2 lines into a single line:
>>
>> 		struct ata_queued_cmd *qc = task->uldd_task;
>>
>> And no cast as suggested.
>>
>>> +		scmd = qc->scsicmd;
> 
> So do you prefer:
> 
>   scmd = ((struct ata_queued_cmd *)task->uldd_task)->scsicmd

Not a fan of the cast approach suggested by Jason. I prefer my above
suggestion, but no strong feeling about it. Either way will be OK.

> 
> As Jason suggested?
> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

