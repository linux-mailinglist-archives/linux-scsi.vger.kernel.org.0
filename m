Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A0770CD
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 20:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfGZSAm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 14:00:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43296 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfGZSAm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 14:00:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so18038957pld.10
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 11:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vB1bFidDOWZSCkiOPQE1pzSoILXy5Xtre/DdArG/EGk=;
        b=bRSHv8SzRRgfb3HdtXnNbYWTxoQXl/n+t5mep9n4A8zZBu1Inus+0tAib0SGNNr3S0
         FR6LWvFkoTMRWrtObAbVk5dxvHx7x5lPOmFIu3IiXdEfP5vNtyK3D2rVgayhM36Jnoko
         fkPugNo+FFlcgl5guWzgbX9g8PDIp8n6Sc4SH4tl0eYs4PHEn5roHxmTP7dPIFThUlmW
         EIbhwyp5GwsuCgHMnlntqAV9665F1f+Izkr8jm/XeiwLuOPGWUwo7yLUg+3WM9cEvrtP
         UN6OLYf6XTHeeHxT4Mz6Wgfk0L5jnnF32g007fyU6Uwn3cXjvI7QRef3IlXEC4xy65Nr
         +KLA==
X-Gm-Message-State: APjAAAWQzgpUrnK4JsWj9b+r6Hhorc019f/NGL7rUk7sDLib3Cj07xdq
        r9MZp7DxCGksDCU0mKbeLrw=
X-Google-Smtp-Source: APXvYqydB8DGJKBWAHlH4Wt9LtE4fInagThVYSW9ichqT0XDznlomfLOHCjAQ3OCtfu2du1k3PziTA==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr93294746plp.4.1564164041856;
        Fri, 26 Jul 2019 11:00:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id bo20sm39874865pjb.23.2019.07.26.11.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:00:40 -0700 (PDT)
Subject: Re: [PATCH 3/4] Complain if scsi_target_block() fails
To:     James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20190726164855.130084-1-bvanassche@acm.org>
 <20190726164855.130084-4-bvanassche@acm.org>
 <1564160404.9950.1.camel@linux.vnet.ibm.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <210a31fb-37d1-93ab-c339-f8cc410f65d7@acm.org>
Date:   Fri, 26 Jul 2019 11:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1564160404.9950.1.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/26/19 10:00 AM, James Bottomley wrote:
> On Fri, 2019-07-26 at 09:48 -0700, Bart Van Assche wrote:
>> If scsi_target_block() fails that can break the code that calls this
>> function. Hence complain loudly if scsi_target_block() fails.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/scsi/scsi_lib.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index bbed72eff9c9..c9630bd59b5a 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -2770,6 +2770,8 @@ int scsi_target_block(struct device *dev)
>>   	else
>>   		device_for_each_child(dev, &ret, target_block);
>>   
>> +	WARN_ONCE(ret, "ret = %d\n", ret);
>> +
> 
> If this is the only point to the previous change to make SCSI target
> block return an error, why not put the WARN_ONCE in device_block?  That
> way you'll at least know which device was the problem.

Hi James,

Adding a WARN_ON_ONCE() statement in device_block() sounds like a good 
idea to me. But since scsi_target_block() can fail, I think it should 
have a return value that indicates whether or not it succeeded.

Bart.
