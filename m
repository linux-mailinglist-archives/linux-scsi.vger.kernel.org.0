Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5782AA8D
	for <lists+linux-scsi@lfdr.de>; Sun, 26 May 2019 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfEZPx2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 May 2019 11:53:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43476 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEZPx2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 May 2019 11:53:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so7662541pgv.10
        for <linux-scsi@vger.kernel.org>; Sun, 26 May 2019 08:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wCRjd0Rzo8MEEzo8BijiRAKOVHjfzjw18XyPv9T8zxs=;
        b=n+K3nWtCckRKWY9gwjWTJ8e42awSIB0A0fodB/RPWyCDGfLVoGwuCgL8XhQJsckVNn
         7XDFEU27QHW9E0IubqGjLsW5O/ZF8SFse3qTdRUaj0T+/m2VSRqJEHziOfA2atU9/yfJ
         x5viJTwpjOtQ8hqscN7ObwtXYiLyn5hbldtatNhTNWc2QkChqds8RNZbVPT9zlms04SP
         Ie8WEdFQOHuat+VcSnCQAcfPDm/zxbZXe5H46DrmnAgkAeQeyITyg4KdypVJdGbW3e4f
         iFvBfaC9xf7k+pXcvKA4PgrunoRJg5l9o91s8c80M2ymkLAlPMjjjmToijqK4MZnis5q
         dLFA==
X-Gm-Message-State: APjAAAWablRiSzvkyjrnH7lHiwW3JJJRf86uq6ljAMOgzKPF8jmbaBN9
        MjOjnGljKvlKK7oSRlGVA5Y=
X-Google-Smtp-Source: APXvYqyK6bUJwsteOZ53/b1f5lNFFV2j3WGSL2nj6fLXgQVNHgRR5ftXJw2hrwk8/xJsIl7A9Wa9sA==
X-Received: by 2002:a63:7413:: with SMTP id p19mr118136173pgc.259.1558886007920;
        Sun, 26 May 2019 08:53:27 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id h14sm7422853pgj.8.2019.05.26.08.53.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:53:27 -0700 (PDT)
Subject: Re: [PATCH 02/19] sg: remove typedefs, type+formatting cleanup
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <20190524184809.25121-3-dgilbert@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
Openpgp: preference=signencrypt
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <f122bff1-81f9-bce9-0dec-617815845b0f@acm.org>
Date:   Sun, 26 May 2019 08:53:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524184809.25121-3-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/24/19 11:47 AM, Douglas Gilbert wrote:
>  static int
>  sg_open(struct inode *inode, struct file *filp)
>  {
> -	int dev = iminor(inode);
> -	int flags = filp->f_flags;
> +	bool o_excl;
> +	int min_dev = iminor(inode);
> +	int op_flags = filp->f_flags;
>  	struct request_queue *q;
> -	Sg_device *sdp;
> -	Sg_fd *sfp;
> +	struct sg_device *sdp;
> +	struct sg_fd *sfp;
>  	int retval;
>  
>  	nonseekable_open(inode, filp);
> -	if ((flags & O_EXCL) && (O_RDONLY == (flags & O_ACCMODE)))
> +	o_excl = !!(op_flags & O_EXCL);
> +	if (o_excl && ((op_flags & O_ACCMODE) == O_RDONLY))
>  		return -EPERM; /* Can't lock it with read only access */

One change per patch please. The introduction of the o_excl variable is
not related to the removal of the typedefs. I think this patch should be
split.

Thanks,

Bart.
