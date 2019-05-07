Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999D915764
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 03:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEGBnn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 21:43:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33973 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGBnn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 May 2019 21:43:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so7737857pfd.1
        for <linux-scsi@vger.kernel.org>; Mon, 06 May 2019 18:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H/0j026Kt8NlSYd1DjIdB4o20MjrDq6JvaS75mWmC/Q=;
        b=NYAO4JmxGozK+0TPLqx1Csw438Th8yRY1a4EmZnhOkqf7RXqsBIBzxu/ETZgv8fl/9
         U5LNgt8YSSjjIqgOICa92p3Hz0s5jb3Mm4xtmBaxwpdaRxednh06zPlGhiDwLuEmAnNg
         uRLwoUUB1AYlDxJKdGJm/0AbJuBE+9eawJVHUzxtygAtwSADBznIOZWMOWG7oZkUHUbW
         2VhGEhd6k/8N4LZRND7WfrY3pgTrLFzPFaZnJyNJzefUm+OzkdPJj8mIboB2CKriA1BA
         v+pb6MNNHpldA8Mb20zc+x80Zm9hX5jAbBKXL75vAwpdhrQauQAUui62hAiayXeksw9J
         28hQ==
X-Gm-Message-State: APjAAAVa20qioD5b1n1zipq+Hfmj/DIoiPPEN7D38ruvjcgfzzWjn0hG
        dHoUSNJ0Cf7wvA9fG82kKGZ4nZMp
X-Google-Smtp-Source: APXvYqw/e01hurIU8yLVV0R8f+0/EZQ1Pl8yyfeGmAPhNHlGQUseMgjVMo1sZ+p4ClQJtxWJxBnkQg==
X-Received: by 2002:aa7:925a:: with SMTP id 26mr37263132pfp.152.1557193421962;
        Mon, 06 May 2019 18:43:41 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id f14sm17444115pgj.24.2019.05.06.18.43.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 18:43:41 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] lpfc updated for 12.2.0.2
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
References: <20190507002650.23210-1-jsmart2021@gmail.com>
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
Message-ID: <630178e7-faee-1a62-edab-fc1521cf8495@acm.org>
Date:   Mon, 6 May 2019 18:43:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507002650.23210-1-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/6/19 5:26 PM, James Smart wrote:
> Update lpfc to revision 12.2.0.2

For the whole series:

Tested-by: Bart Van Assche <bvanassche@acm.org>
