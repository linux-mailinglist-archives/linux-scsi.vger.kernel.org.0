Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1823510D
	for <lists+linux-scsi@lfdr.de>; Sat,  1 Aug 2020 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgHAHvq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 1 Aug 2020 03:51:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33796 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgHAHvp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 1 Aug 2020 03:51:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id d2so12370360lfj.1;
        Sat, 01 Aug 2020 00:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D61n9PHvtCBq5d0zkEOp5P+qElAFgL6TZOSItQN+fNw=;
        b=unv+3hObHZgB8yP54vrmdlrM5+vvC/+ZSqriaEhK5XwdL1PHyi/b/EHxLpS4kKSKsH
         UgExMTZIHOICVh78QwCh+nrKWyQAtXhZqciPFsQohnaaRL9Qf4zNW8ldfKIuCvbIS+fn
         Gki8Q8p3/vLgCDSqxMDvsYrfK5d9VevRKgYQuywiZLqGpXhBykrz5Hz+znPanHrz5faR
         O0zFSRLF3uHUbhtHvq3Z+6rU3SfZv81aq+z9bs9oZ44rznM0i3PhhzXm+CtIJGamrEu+
         +bL1dBFj30W4nwbQ3hJyFa3j6E0eNmoQ8YvzR9HaUkFbWQ/1PU2Vw83MoVrGDa2VUfMb
         0jTg==
X-Gm-Message-State: AOAM530KuTlQhykItj1h7RihGdN8U8OFdSvwUKbyTBLULou5aZHr0Y9J
        QymElmSvh9Xodzh2VIXX31B4uB9p1QI=
X-Google-Smtp-Source: ABdhPJyRt9uBN3vXuSGE3KryvOBUshX9Od19rYUUPa7syKRl0bFLN+nsKTZrr9W3SyBgh2qForVNUg==
X-Received: by 2002:ac2:4d31:: with SMTP id h17mr3695345lfk.144.1596268301922;
        Sat, 01 Aug 2020 00:51:41 -0700 (PDT)
Received: from [10.68.32.192] (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.gmail.com with ESMTPSA id t22sm2515675lfr.12.2020.08.01.00.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 00:51:41 -0700 (PDT)
To:     Joe Perches <joe@perches.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200731215524.14295-1-efremov@linux.com>
 <33d943d2b83f17371df09b5962c856ea2d894954.camel@perches.com>
 <70fb8220-2102-adb5-bbe6-9c2ea74a0623@linux.com>
 <8638183f559c0f8f8d377bd0a6c91903b2c588df.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH] scsi: libcxgbi: use kvzalloc instead of opencoded
 kzalloc/vzalloc
Message-ID: <c5a18804-3236-9688-2a3c-68184f0dd9e8@linux.com>
Date:   Sat, 1 Aug 2020 10:51:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8638183f559c0f8f8d377bd0a6c91903b2c588df.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 8/1/20 1:24 AM, Joe Perches wrote:
> On Sat, 2020-08-01 at 01:10 +0300, Denis Efremov wrote:
>>
>> On 8/1/20 12:58 AM, Joe Perches wrote:
>>> On Sat, 2020-08-01 at 00:55 +0300, Denis Efremov wrote:
>>>> Remove cxgbi_alloc_big_mem(), cxgbi_free_big_mem() functions
>>>> and use kvzalloc/kvfree instead.
>>>
>>> Sensible, thanks.
>>>
>>>> diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
>>> []
>>>> @@ -77,9 +77,9 @@ int cxgbi_device_portmap_create(struct cxgbi_device *cdev, unsigned int base,
>>>>  {
>>>>  	struct cxgbi_ports_map *pmap = &cdev->pmap;
>>>>  
>>>> -	pmap->port_csk = cxgbi_alloc_big_mem(max_conn *
>>>> -					     sizeof(struct cxgbi_sock *),
>>>> -					     GFP_KERNEL);
>>>> +	pmap->port_csk = kvzalloc(array_size(max_conn,
>>>> +					     sizeof(struct cxgbi_sock *)),
>>>> +				  GFP_KERNEL);
>>>
>>> missing __GFP_NOWARN
>>>
>>
>> kvmalloc_node adds __GFP_NOWARN internally to kmalloc call
>> https://elixir.bootlin.com/linux/v5.8-rc4/source/mm/util.c#L568
> 
> Only when there's a fallback, and the fallback does not.
> 

Sorry, Joe, I don't understand why do we need to add __GFP_NOWARN here.

We use GFP_KERNEL for allocation. cxgbi_alloc_big_mem adds __GFP_NOWARN only to kzalloc().
kvzalloc is: kvmalloc(size, flags | __GFP_ZERO)
kvmalloc is: kvmalloc_node(size, flags, NUMA_NO_NODE)
kvmalloc_node: 
	if ((flags & GFP_KERNEL) != GFP_KERNEL)           // false, flags == GFP_KERNEL|__GFP_ZERO
		return kmalloc_node(size, flags, node);

	if (size > PAGE_SIZE) {
		kmalloc_flags |= __GFP_NOWARN;            // add __GFP_NOWARN for "big" allocations

		if (!(kmalloc_flags & __GFP_RETRY_MAYFAIL))
			kmalloc_flags |= __GFP_NORETRY;
	}

	// kmalloc_flags == GFP_KERNEL|__GFP_ZERO|__GFP_NOWARN if size > PAGE_SIZE
	ret = kmalloc_node(size, kmalloc_flags, node);    

	if (ret || size <= PAGE_SIZE)
		return ret;

	// flags == GFP_KERNEL|__GFP_ZERO
	return __vmalloc_node(size, 1, flags, node,
			__builtin_return_address(0));

So, to my understanding the difference is only that cxgbi_alloc_big_mem adds __GFP_NOWARN
to kzalloc unconditionally, kvzalloc adds __GFP_NOWARN to kmalloc_node if size > PAGE_SIZE.
We use: max_conn * sizeof(struct cxgbi_sock *) in allocation. max_conn can be either
CXGBI_MAX_CONN or CXGB4I_MAX_CONN. CXGBI_MAX_CONN == 16384, CXGB4I_MAX_CONN == 16384.
Thus the allocation is bigger than PAGE_SIZE and kvmalloc_node adds __GFP_NOWARN to the
kmalloc_node call. Maybe I missed something?

Thanks,
Denis
