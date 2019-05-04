Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8032A1371D
	for <lists+linux-scsi@lfdr.de>; Sat,  4 May 2019 05:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfEDDRY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 May 2019 23:17:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35489 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfEDDRY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 May 2019 23:17:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so3269785pfa.2
        for <linux-scsi@vger.kernel.org>; Fri, 03 May 2019 20:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KKGFqNu9PDflpLWnxkdE78BprD3Rse5s4h3gSjN22zw=;
        b=d8Xjw62yLsSZ0ZdENVRDLcUXttWTWrxLninpIBVJV95/zF8gyrjSmNQ9OVcO1QQD41
         bNbH29TPYs+SfNTEnQ3A0WCS+S4xETfFPpMX4PFV1VBuirIwGFJ+EisqYzlAHfXooMqB
         xCWRSqblHm5jihWHMjml9rx+nO5ZDWRzNTzyEbFg5Sg4FOuAkGsSj5ickhV6fPpu3GkU
         F9+qjmMa/WUIZHrXMwRjLs24E5V2gh14m3debzKCKeLj7UkBfquqF/t2hE5+993LhHZr
         SEhNRxhsGUlO7nkGwiOS7tIdmZLcsAQI0GomhP3pDwkdI27se/V4WxrOuVAtkVNvF5mh
         z4sA==
X-Gm-Message-State: APjAAAW6k9mY8LT3nI63aNmP0xgeZhdf71qpYVUHn7FcPuPEAnt8zLrF
        5G6MiTdmctKaCz/35vMtr1HNXoye
X-Google-Smtp-Source: APXvYqxQezxpI5zcupk5wV5vxt+m+nBKXOsF+v9wyBSENsiJ1JZ6hliuhU8G9NJX6LL/UiUaA5e26w==
X-Received: by 2002:a65:5342:: with SMTP id w2mr15057211pgr.220.1556939843342;
        Fri, 03 May 2019 20:17:23 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id s6sm4561416pfb.128.2019.05.03.20.17.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 20:17:22 -0700 (PDT)
Subject: Re: [PATCH 0/4] lpfc updated for 12.2.0.2
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
References: <20190501175926.4551-1-jsmart2021@gmail.com>
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
Message-ID: <8b11d5d2-fe7c-14c6-7224-3d0ec824f432@acm.org>
Date:   Fri, 3 May 2019 20:17:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501175926.4551-1-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/1/19 10:59 AM, James Smart wrote:
> Update lpfc to revision 12.2.0.2
> 
> A quick patch set that resolves lockdep checking issues and
> addresses a couple of bugs found when inspecting the paths
> for the lockdeps.
> 
> The patches were cut against Martin's 5.2/scsi-queue tree

Hi James,

While testing this patch series I hit the kernel warning shown below. Is
this kernel warning perhaps a regression due to patch 1/4 in this series?

Thanks,

Bart.


lpfc 0000:00:0a.0: 1:(0):2753 PLOGI failure DID:010000 Status:x3/x103
WARNING: CPU: 0 PID: 178 at drivers/scsi/lpfc/lpfc_sli.c:2994
lpfc_sli_iocbq_lookup+0x1aa/0x1c0 [lpfc]
CPU: 0 PID: 178 Comm: lpfc_worker_1 Tainted: G           O
5.1.0-rc7-dbg+ #3
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
RIP: 0010:lpfc_sli_iocbq_lookup+0x1aa/0x1c0 [lpfc]
Call Trace:
 lpfc_sli_sp_handle_rspiocb+0x43b/0xa30 [lpfc]
 ? check_chain_key+0x13f/0x200
 ? lpfc_sli_handle_fast_ring_event+0x7d0/0x7d0 [lpfc]
 ? memcpy+0x45/0x50
 ? lpfc_sli4_iocb_param_transfer+0xf7/0x420 [lpfc]
 lpfc_sli_handle_slow_ring_event_s4+0x252/0x320 [lpfc]
 lpfc_sli_handle_slow_ring_event+0x32/0x40 [lpfc]
 lpfc_do_work+0x1050/0x19f0 [lpfc]
 ? mark_held_locks+0x34/0xb0
 ? lpfc_unregister_unused_fcf+0xb0/0xb0 [lpfc]
 ? finish_wait+0x110/0x110
 ? _raw_spin_unlock_irqrestore+0x42/0x70
 ? __kthread_parkme+0xb5/0xd0
 kthread+0x1d2/0x1f0
 ? lpfc_unregister_unused_fcf+0xb0/0xb0 [lpfc]
 ? kthread_create_on_node+0xc0/0xc0
 ret_from_fork+0x24/0x50
irq event stamp: 50416
hardirqs last  enabled at (50415): [<ffffffff819d04c7>]
_raw_spin_unlock_irqrestore+0x57/0x70
hardirqs last disabled at (50416): [<ffffffff819d01e8>]
_raw_spin_lock_irqsave+0x18/0x60
softirqs last  enabled at (44458): [<ffffffff81c00451>]
__do_softirq+0x451/0x5b7
softirqs last disabled at (44447): [<ffffffff810af1ad>] irq_exit+0xdd/0x100
