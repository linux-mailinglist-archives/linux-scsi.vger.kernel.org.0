Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99F5165665
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2020 05:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBTEvH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Feb 2020 23:51:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45878 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgBTEvH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Feb 2020 23:51:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so1032279pls.12
        for <linux-scsi@vger.kernel.org>; Wed, 19 Feb 2020 20:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rvX3XEOXqDEH9MES5sM6cds1p7zG5/RC7LDBMlKugeU=;
        b=RfwL7k2ItiZEEUelaGjR/TeeGN7BlzqmxnhzeE0D1XpioenLjNUazT7KeKIjVj3jd6
         uEiQAIZ6GF+gHJgcnj0tFAIsqm/6O/TM9iO/yCPgZfYgDJUrvAdQY+YqR9L/MuWkqKV4
         N1bsGK2SKzq91aYBHPI108apaXxuWLIz8/kswplFv3SsBjarxNQ1NwVxxGGm48KzFlGu
         BkdBHGR/Fdn4ONj6WuM4N9Vtj47V55G5fJR+VxAnEPaRvq+Z4ViYKUDwstEjhcBlG5v9
         M1ULAQKhcjI/Ox/MTf6eezmbb6ZQNo1AKRbMo7TbXkpqlheI6IWEQPffGZqEJdpS+z96
         iaxg==
X-Gm-Message-State: APjAAAWclL3JnyOEiuVgTPwwnFxyTJKf6GJouNLyJ9yksoPcu/VCFwob
        F4iTqut2T7Z49zaGQ5xJvcCIyf8hc4o=
X-Google-Smtp-Source: APXvYqz9TaqARifec01OfdYWj2kMU7q+PLhcaExwWTN9FPY+N/cNY618C4h3V98GkqmjgKtzU47fyw==
X-Received: by 2002:a17:90a:654a:: with SMTP id f10mr1450058pjs.50.1582174265877;
        Wed, 19 Feb 2020 20:51:05 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:29a7:b1bb:5b40:3d61? ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id d22sm1284509pfo.187.2020.02.19.20.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 20:51:05 -0800 (PST)
Subject: Re: [PATCH 2/3] ch: synchronize ch_probe() and ch_open()
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20200213153207.123357-1-hare@suse.de>
 <20200213153207.123357-3-hare@suse.de>
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
Message-ID: <e4e0ea82-3651-df94-78a6-85060ea9fe85@acm.org>
Date:   Wed, 19 Feb 2020 20:51:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200213153207.123357-3-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-02-13 07:32, Hannes Reinecke wrote:
> The 'ch' device node is created before the configuration is
> being read in, which leads to a race window when ch_open() is called
> before that.
> To avoid any races we should be taking the device mutex during
> ch_readconfig() and ch_init_elem(), and also during ch_open().
> That ensures ch_probe is finished before ch_open() completes.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
