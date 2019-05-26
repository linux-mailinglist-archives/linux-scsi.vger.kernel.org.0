Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B82AA82
	for <lists+linux-scsi@lfdr.de>; Sun, 26 May 2019 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEZPqL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 May 2019 11:46:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42691 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfEZPqL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 May 2019 11:46:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id 33so4704000pgv.9
        for <linux-scsi@vger.kernel.org>; Sun, 26 May 2019 08:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E0wX7hx7fUHbd1V1s4e0inGVGb2AkZSANRS9TdClbBI=;
        b=RwYt8mfeZ9VhNcfr69w55+axmGJqN2FFG8hO3N2PTC72HFa9StFhUHxP6+oaHNnynz
         86Qce5Qu3/4Stn+3WsiYDAp0xon5JfvhxFbu01vYA/86L1t/Ir373PuDaGI1BEFD/EQQ
         xz2bKHRIWsUn6cOpSObkOy1nqhRC7S+Aty+TzXhDAFe/ouajAMqqgRqJjM6k6ABxN1+e
         npS/9MUzGVuRVEXknaAe6q5pYGxDCb1O+gtX5xnQ8q6+ZM2IyOIjcHJgE6qHpwuJZeDl
         TwRil3ldil4me84Q8p4Y+os0ZONzea9IYhhAo4Qt7NX7e+f4dNOjj17tyUDt/2GVM59m
         prAg==
X-Gm-Message-State: APjAAAUSDdng+cEwXU6rP24oP9w4GlXKdFVR1SZDDKHAGNKnFvxcl7rm
        1aDGHh3pmjRzl8/XHzisDPU=
X-Google-Smtp-Source: APXvYqzkk2z1WKwyBR1z0iQizaNZx9vkrOcJFY9mCouKt70eT6xGyyYPh+XLrabVcL0jegPfgROKKg==
X-Received: by 2002:aa7:9577:: with SMTP id x23mr128982066pfq.164.1558885570943;
        Sun, 26 May 2019 08:46:10 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id 1sm8694027pfn.165.2019.05.26.08.46.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:46:10 -0700 (PDT)
Subject: Re: [PATCH 01/19] sg: move functions around
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <20190524184809.25121-2-dgilbert@interlog.com>
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
Message-ID: <f67f3eef-bb0e-2211-9b3a-6628227e76b0@acm.org>
Date:   Sun, 26 May 2019 08:46:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524184809.25121-2-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/24/19 11:47 AM, Douglas Gilbert wrote:
> Move code around so it has the basic ordering: open(), close(),
> write(), read(), ioctl(), other system calls (e.g. mmap()),
> support code and finally debug code. The change was to put the
> write() associated code before the read() code. The write()
> system call is associated with submitting SCSI commands (i.e.
> writing metadata to the device).  The read() system call is
> associated with receiving the responses of earlier submitted
> commands.
> 
> Helper functions are often placed above their caller to reduce
> the number of forward function declarations needed.

Moving helper functions in front of their caller is useful but random
reordering of functions not. Such a random reordering of code pollutes
the git history. Please don't do that.

Thanks,

Bart.
