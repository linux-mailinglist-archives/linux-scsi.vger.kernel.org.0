Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17A2AA99
	for <lists+linux-scsi@lfdr.de>; Sun, 26 May 2019 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfEZQGQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 May 2019 12:06:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40206 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEZQGQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 May 2019 12:06:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id g69so6064462plb.7
        for <linux-scsi@vger.kernel.org>; Sun, 26 May 2019 09:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7XDucBh21k4HBS5yBzbcvJcUYwKypdInzWh/mfgS2ak=;
        b=uMnAyCksEpK+rHe6eLDRVgMtMu3QBr/2E93jNC8mwu7HgmjW6NniD2dMXEoRZ663vp
         BKfE7IdOd26BNfgaIGQ9l0Vc7MQvQJMAqAddUbOpVPyfiqmZL/xQ1Cpdr2i6/Y+etaYY
         xpjNiowvGlw6JOOMYweCOhjvEThHKfyw3drLTJyday/UrOiTIovkdXHqDw3+xQQsyu4Q
         eITh3FKdVLw8MyCBHjVXkl7TqN5RLHq7/98tdXZLVT2Vs3ey6DhERNSyYzg0xD97Da1Z
         wk2oI7+XTPDK1E6dw4ITdAb/mCRqHx/2nToAua5cxOYIUrRMXXXVSZx38Q8Uw1xa1WJF
         xAbw==
X-Gm-Message-State: APjAAAU/VItEtzd9ii+MXJoS36p9+kacXInxQ+Ar2GBUjrguW8Nf4xhg
        1LlKNwphsbds944x/X16rA4=
X-Google-Smtp-Source: APXvYqzVtvnqX0is9gEDg6HEmoabJ5LYaKgO3Y4gVaZAOcGLJfxfw0VzJaeBff2ymVetRLMvzK/QVA==
X-Received: by 2002:a17:902:b402:: with SMTP id x2mr7024814plr.128.1558886775819;
        Sun, 26 May 2019 09:06:15 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id n21sm8298939pff.92.2019.05.26.09.06.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 09:06:15 -0700 (PDT)
Subject: Re: [PATCH 03/19] sg: sg_log and is_enabled
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <20190524184809.25121-4-dgilbert@interlog.com>
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
Message-ID: <79fe5e48-3d5d-49c2-7f82-6e40c194c599@acm.org>
Date:   Sun, 26 May 2019 09:06:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524184809.25121-4-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/24/19 11:47 AM, Douglas Gilbert wrote:
> Replace SCSI_LOG_TIMEOUT macros with SG_LOG macros across the driver.
> The definition of SG_LOG calls SCSI_LOG_TIMEOUT if scsi_device
> pointer is non-zero, calls pr_info otherwise. Prints the thread id
> if current is non-zero, -1 otherwise.

What makes you think that logging the thread ID is useful?

What is sg-specific about the SG_LOG() macro? Why to restrict the
introduction of this macro to the sg code?

Do we really need the SG_LOG() macro?

> +#if IS_ENABLED(CONFIG_SCSI_LOGGING)
> +#define SG_LOG(depth, sdp, fmt, a...)					\
> +	do {								\
> +		char _b[160];						\

No new hardcoded buffer size limits please. Such size limits are
typically either too small or too big.

> +		int _tid = (current ? current->pid : -1);		\

Is current ever NULL?

Is this macro ever invoked from interrupt context? I'm asking because I
think in interrupt context 'current' refers to the context that has been
interrupted instead of the interrupt context.

Thanks,

Bart.
