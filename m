Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8E18B35
	for <lists+linux-scsi@lfdr.de>; Thu,  9 May 2019 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEIOGP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 May 2019 10:06:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfEIOGO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 May 2019 10:06:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so1372370pfm.12
        for <linux-scsi@vger.kernel.org>; Thu, 09 May 2019 07:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6oAL+cNkb4Uc/uSRIsXRaDfyfKgTUYhkep+tSwBssfQ=;
        b=j25A6TcLHot6PvtTlFzf0kSQH2ScO2KUVzV/sodOov72O82jLfpw2rSfwoeS3JsQTI
         6N9xD8kM86hFguisTTgciSiWEynQ4UqJmVO5lT6ZIeKjezgr6kVhJ3dC6OKH3tWaRJ5u
         4rbTxBmCITMeUWlqPM3kfw7+PKQhYpuofbsSM5xTY5WTrt6cc2+K2L8MGiaBc8Uby5z5
         dXRi0iwr97N/oF809R/AjqxLHlK7FUFsMnjWcRLcTdVICDcj5kO15R/z5zjqn1vx4zCM
         ZIm2SwgUwstlBqGeFvOY5seLnr+uuJzTpceWMzZV5Vy6ejTu+GsAM/Rd8eaM/eM2D+q9
         XMNA==
X-Gm-Message-State: APjAAAX50azMS0a8PpFGsL4YE/Lcn+m1Vpqxeo/CLR0zdlj2euH+ZAni
        dqoIV14pa+PakSeFPBUm1P0=
X-Google-Smtp-Source: APXvYqxajpA9uuK+M0Eqb9/7PBKGr8ydfEliMPZhSlmU+RFwpwBKZAVzMYPbAyE/p7bza85Qf3qg5Q==
X-Received: by 2002:a65:5c82:: with SMTP id a2mr5811958pgt.378.1557410773622;
        Thu, 09 May 2019 07:06:13 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id s85sm3544676pfa.23.2019.05.09.07.06.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:06:12 -0700 (PDT)
Subject: Re: [PATCH] qla2xxx: always allocate qla_tgt_wq
To:     Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@marvell.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190509131821.87338-1-hare@suse.de>
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
Message-ID: <1df9eb38-8ff9-bf21-4a49-4190eea9f2b4@acm.org>
Date:   Thu, 9 May 2019 07:06:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509131821.87338-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/9/19 6:18 AM, Hannes Reinecke wrote:
> The 'qla_tgt_wq' workqueue is used for generic command aborts,
> not just target-related functions. So allocate the workqueue
> always to avoid a kernel crash when aborting commands.

Hi Hannes,

Can the abort code be called directly? This means not queueing the abort
work? Do you perhaps know why the target workqueue is used for
processing aborts? In other words, can the abort functions be modified
to use one of the system workqueues instead of always allocating the
target workqueue?

Thanks,

Bart.
