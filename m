Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2770E42D
	for <lists+linux-scsi@lfdr.de>; Tue, 23 May 2023 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbjEWR5A (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 May 2023 13:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237912AbjEWR44 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 May 2023 13:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC6DD
        for <linux-scsi@vger.kernel.org>; Tue, 23 May 2023 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684864568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4j97EwXZbpGeydneOiYzyqIdUbofrkUoFZFV5L4oKTY=;
        b=G/pddICAp7KIDMcFC8ADCnk6XJCB2zz40wuUz8NASazMGbliIlyKsU/6FP04k5FNz5ssLs
        aAAC9B9IX8l9dLMWP9vKFbuvRV0lm9xa5muHVmR/0YRforhZuu//Yd4Ia4L7UskhV18enq
        Lswwqnq2V6H1qwX6uEcJFjBZdQyGJWA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-sKK87bC5NIKvP4NS1nAXng-1; Tue, 23 May 2023 13:56:05 -0400
X-MC-Unique: sKK87bC5NIKvP4NS1nAXng-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50a16ab50e6so122739a12.0
        for <linux-scsi@vger.kernel.org>; Tue, 23 May 2023 10:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684864564; x=1687456564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4j97EwXZbpGeydneOiYzyqIdUbofrkUoFZFV5L4oKTY=;
        b=Df9x3M/7GZlcmtz3M4GraT+zZsuddt6SRw2fCLDLBJ/l1DNMyZoFFIJReMlq4UmqN/
         gFes95VDFYOLFlrhVPEOZIdjXiZIqKAzbnEUKrAjeBI8re6Jh80BHMo/tPHx7SOH3KKS
         r5TyoQPWUdHIVxztjXUpfTJZGRrmC0oPt08Ba+zURL3uFpbQgMZUJmtcAJ8PWP3eQhCV
         AgI2fSGMAlSuwEigEvqNScd0CJdqXAv5F4WrAW172G8myRJ4B1sYNWz2Bi72QviHxeux
         7EuxR0QWeYR8+Wp+QH2YueQk4WjKcpi4YlvKPwqUo6xJdt57LalQ6pCFGkyxbeLy0nfc
         Fssg==
X-Gm-Message-State: AC+VfDwrTBtBENU7WKzP55/tCPa5UosrgSvafhJ+73Xy8AbyZaG/v/xT
        GwvBqaX+1CXjrOdmeUl6DImOMS7EXvJmyLhwt8DCarxV+5t8mSu7+1z7W/vPX88qVS9ep3KiLW3
        QGvS8Xu6OgSe5MHXO9GDLSQ==
X-Received: by 2002:aa7:d397:0:b0:50b:d270:6b6f with SMTP id x23-20020aa7d397000000b0050bd2706b6fmr13033727edq.4.1684864564241;
        Tue, 23 May 2023 10:56:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OjC/WBaUIOdcO5ca/pkGTV8HRMGItXeHTCT10i9NO7a8kOkcBihYbR/ZpPyvYpATJ1Ey90w==
X-Received: by 2002:aa7:d397:0:b0:50b:d270:6b6f with SMTP id x23-20020aa7d397000000b0050bd2706b6fmr13033713edq.4.1684864563964;
        Tue, 23 May 2023 10:56:03 -0700 (PDT)
Received: from [192.168.0.107] (ip4-83-240-118-160.cust.nbox.cz. [83.240.118.160])
        by smtp.gmail.com with ESMTPSA id c9-20020aa7c989000000b0050b2f588db6sm4190270edt.16.2023.05.23.10.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:56:03 -0700 (PDT)
Message-ID: <461c6576-71df-c16a-3c4f-4691ae84064f@redhat.com>
Date:   Tue, 23 May 2023 19:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drivers: mpt3sas: mpt3sas_debugfs: return value check of
 `mpt3sas_debugfs_root`
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Jing Xu <U202112064@hust.edu.cn>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230423122535.31019-1-U202112064@hust.edu.cn>
 <6e69b57c-80ae-8b6e-cb5f-9e05da46ecd6@redhat.com>
 <1484408f-f68e-4354-ab59-56af9cd1ef14@kili.mountain>
 <b7154e2c-0438-87d1-9edc-7eb1aad40cd1@hust.edu.cn>
 <81d236bb-3913-4eef-bf71-6d17535d6d79@kili.mountain>
 <892bc614-9e2e-904b-29e0-62daeb855f79@redhat.com>
 <3c4b372f-db4b-43b4-b5ab-7f4860cf6f20@kili.mountain>
From:   Tomas Henzl <thenzl@redhat.com>
In-Reply-To: <3c4b372f-db4b-43b4-b5ab-7f4860cf6f20@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/23/23 16:57, Dan Carpenter wrote:
> On Tue, May 23, 2023 at 04:48:12PM +0200, Tomas Henzl wrote:
>> On 5/8/23 16:38, Dan Carpenter wrote:
>>> On Mon, May 08, 2023 at 09:40:41PM +0800, Dongliang Mu wrote:
>>>>>>> diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>>>>>> index a6ab1db81167..c92e08c130b9 100644
>>>>>>> --- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>>>>>> +++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>>>>>> @@ -99,8 +99,6 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
>>>>>>>   void mpt3sas_init_debugfs(void)
>>>>>>>   {
>>>>>>>   	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
>>>>>>> -	if (!mpt3sas_debugfs_root)
>>>>>>> -		pr_info("mpt3sas: Cannot create debugfs root\n");
>>>>>> Hi Jing,
>>>>>> most drivers just ignore the return value but here the author wanted to
>>>>>> have the information logged.
>>>>>> Can you instead of removing the message modify the 'if' condition so it
>>>>>> suits the author's intention?
>>>>>
>>>>> This code was always just wrong.
>>>>>
>>>>> The history of this is slightly complicated and boring.  These days it's
>>>>> harmless dead code so I guess it's less bad than before.
>>>>
>>>> Hi Dan and Tomas,
>>>>
>>>> Any conclusion about this patch? The student Jing Xu is not sure about how
>>>> to revise this patch.
>>>
>>> The correct fix is to delete the code.
>>>
>>> Debugfs code has error checking built in and was never supposed to be
>>> checked for errors in normal driver code.
>>>
>>> Originally, debugfs returned a mix of error pointers and NULL.  In the
>>> kernel, when you have a mix of error pointers and NULL, then the NULL
>>> means that the feature has been disabled deliberately.  It's not an
>>> error, we should not print a message.
>>>
>>> So a different, correct-ish way to write write debugfs error handling
>>> was to say:
>>>
>>> 	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
>>> 	if (IS_ERR(mpt3sas_debugfs_root))
>>> 		return PTR_ERR(mpt3sas_debugfs_root);
>> I'm fine with this as well, I could wish we get a fix for the exact same
>> case of debugfs_create_dir in mpt3sas_setup_debugfs and ideally all the
>> debugfs_create* in  mpt3sas_debugfs.c in a single patch. But this patch
>> is ok even if that wasn't possible.
>> tomash
> 
> No, you didn't read until the end.  That will break the driver badly.
> 
> This *used* to be a correct-ish way that *used* to work but it was never
> the what Greg wanted.  So to discourage people from doing it, Greg made
> it *impossible* to check for if debugfs has failed.  Literally, the only
> correct thing to do now is to delete the debugfs checking.

I put my comment in on a wrong place I meant the original patch without
the check, sorry for the confusion. The only thing I'd like to see is to
have corrected all debugfs_create* and that is also optional.

> 
> regards,
> dan carpenter
> 
> 

