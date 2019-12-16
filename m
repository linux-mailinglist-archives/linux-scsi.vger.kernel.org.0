Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238B111FB8F
	for <lists+linux-scsi@lfdr.de>; Sun, 15 Dec 2019 22:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLOVt3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Dec 2019 16:49:29 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41856 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOVt3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 15 Dec 2019 16:49:29 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so2092854pjb.8;
        Sun, 15 Dec 2019 13:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1Nok0OYxBUITJBFgjopuLvaYc0uEMTryXxMGYnCkmXI=;
        b=Dj71gVmItrD6gT70ldyH6++3GmYjclHB/zxw02/WvCU5NNc7EHftpVITqi3wmARorw
         R/1PliS4njMEJLzndeS9mGNog6EGDmYzP/F4Efo6M2vnzyvvJzuUt9Boba4E4wtcR69I
         IOtGjlgYV6+fsh5aEwNU6Xqn9Xr80yLTeG3a35fh/IWX2NxbXmdlrlnQNwZXmwQxOBov
         foagLnlcvQu2mqU9GM2cGGSwRBZC5SaV6CHMjtdFY3hLxgJnuoIol5F9dbXuwnGHoqMB
         j/bnTAYWYRXC879GlXb4DnsGnhCnJDo7zAqu4RrtunHfyblhOoajnH14/8SnQ/cnT/A1
         nPZw==
X-Gm-Message-State: APjAAAXq/HcYw53/qGkpE8fL/GR8c8vDHChwPXTRFb/mL5Kp2i0YgXn2
        AMlbWxk1iryBV1Ir/sH12NkxlPD6fGY=
X-Google-Smtp-Source: APXvYqwmzt5YZdb9GscOzVHOdIgF4ILZNIjovGqd41GxGwrb7htBIXMD7H1mR5MLyHreg0nqFwh2Dw==
X-Received: by 2002:a17:90a:fb87:: with SMTP id cp7mr14182089pjb.56.1576446568112;
        Sun, 15 Dec 2019 13:49:28 -0800 (PST)
Received: from ?IPv6:2601:647:4000:110a:d014:2a0a:ea98:f50e? ([2601:647:4000:110a:d014:2a0a:ea98:f50e])
        by smtp.gmail.com with ESMTPSA id i4sm16614949pjd.19.2019.12.15.13.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 13:49:27 -0800 (PST)
Subject: Re: [PATCH v2 2/3] scsi: ufs: Modulize ufs-bsg
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, cang@codeaurora.org
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bean Huo <beanhuo@micron.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
References: <1576054123-16417-1-git-send-email-cang@codeaurora.org>
 <0101016ef425ef65-5c4508cc-5e76-4107-bb27-270f66acaa9a-000000@us-west-2.amazonses.com>
 <20191212045357.GA415177@yoga>
 <0101016ef8b2e2f8-72260b08-e6ad-42fc-bd4b-4a0a72c5c9b3-000000@us-west-2.amazonses.com>
 <20191212063703.GC415177@yoga>
From:   Bart Van Assche <bvanassche@acm.org>
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
Message-ID: <5691bfa1-42e5-3c5f-2497-590bcc0cb2b1@acm.org>
Date:   Sun, 15 Dec 2019 13:49:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191212063703.GC415177@yoga>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-12-11 22:37, Bjorn Andersson wrote:
> It's the asymmetry that I don't like.
> 
> Perhaps if you instead make ufshcd platform_device_register_data() the
> bsg device you would solve the probe ordering, the remove will be
> symmetric and module autoloading will work as well (although then you
> need a MODULE_ALIAS of platform:device-name).

Hi Bjorn,

From Documentation/driver-api/driver-model/platform.rst:
"Platform devices are devices that typically appear as autonomous
entities in the system. This includes legacy port-based devices and
host bridges to peripheral buses, and most controllers integrated
into system-on-chip platforms.  What they usually have in common
is direct addressing from a CPU bus.  Rarely, a platform_device will
be connected through a segment of some other kind of bus; but its
registers will still be directly addressable."

Do you agree that the above description is not a good match for the
ufs-bsg kernel module?

Thanks,

Bart.
