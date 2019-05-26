Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7258B2AA86
	for <lists+linux-scsi@lfdr.de>; Sun, 26 May 2019 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfEZPt7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 May 2019 11:49:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32815 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfEZPt7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 May 2019 11:49:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so8111734pfk.0
        for <linux-scsi@vger.kernel.org>; Sun, 26 May 2019 08:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=12t7u9VMJ+mqEYBTSIeWPteHmu9lHWEmftxe1+g6358=;
        b=GFc3LQNPMDU6vv/QuJbIv1svHO1dinsWcnXyOjopYMGvj14gkzeql71OqdTBx/qBZN
         p/2RY2VJ1BR75szKx/OO94mTYUstNkeRBo98b8SKQvOIqsPuJ/P66YyxEG6gMirOVOc6
         zk7gS6XbVRRPmE/M/KxZxkZWwfZ21c+IWjSUsensV79HguypebPrvbP6i+PHHnVxsPD2
         2S6fDMrPC8tclecshlXmP8H+6yfWJ+o3+HLgIGygLnKo+5zNWjgK0jWw4BPwqizH4whM
         Pr7LHHPOpMx3NIjQxfNcLR/jzxiWJiwmvIi8qtZuFxrl4nclT8Oomv+kBDv6hImexvDY
         J+1A==
X-Gm-Message-State: APjAAAVkAzxUNL39ayTcMkRDeti4Icb/IofJnYw5AmSA6h6O4+v5o/fc
        3GKvy6dzsD8gVs7gMCU2750=
X-Google-Smtp-Source: APXvYqzzMmZER1BPqCcd3dDX2Xy9ySROa3J7a0WUzEUVJjOOpijqs8USj+JTBK2bjliqwVxzQwRddQ==
X-Received: by 2002:aa7:930e:: with SMTP id 14mr71644715pfj.262.1558885798278;
        Sun, 26 May 2019 08:49:58 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id 206sm7652517pfy.90.2019.05.26.08.49.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:49:57 -0700 (PDT)
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
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
Message-ID: <a1096ff2-71f5-f398-6173-c8832ac7e26c@acm.org>
Date:   Sun, 26 May 2019 08:49:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/24/19 11:47 AM, Douglas Gilbert wrote:
> This patchset restores some functionality that was in the v2 driver
> version and has been broken by some external patch in the interim
> period (20 years).

What is an "external patch"?

Thanks,

Bart.
