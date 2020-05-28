Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E639A1E6562
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2020 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403893AbgE1PEQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 May 2020 11:04:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36153 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404000AbgE1PEP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 28 May 2020 11:04:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id bg4so6351282plb.3;
        Thu, 28 May 2020 08:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uPSaN+XBxHm8k8sdDoChlHXa5xtnDeGhj92iVNe5hQs=;
        b=GZoJOXunV8ShZZmMrxCtn4MbBHDQtpRISWJeqHt/HqAb/BgZiD5fq8mDfYRN37XqM5
         hfQ3wbAl5VeWNEa5eFMzNzmJPYwp8VB/Z9k3wAz5r/4bye58aiprJoYJwaGT7rFERDBz
         UO3JTvklJcQq0IhBfOQi3m019+q7SrQhh4Y8H3tXe+qdlZimzELdqRQDwpThSjBU1Tof
         Ed25exQdQ2bxYJ0xQrVZB9ciOV7tIBQ4K3qLUL1YCXDTT+n/yFOhwbG7Qluk8azGZnhs
         CNNs50cfCm8hC76WjVuLPlw5wnYX8r8lQJCoDKN73HgA9dhv5c51NQRYMIUAljmmWtnI
         eEBA==
X-Gm-Message-State: AOAM530GgVMZWwQUaeiau+kJKQUDqIR4PCiN2XOvY9gp18Y7WTUtuv2G
        kFP8UgWXT8CYvKUy+iQ0m+9+azra7KI=
X-Google-Smtp-Source: ABdhPJyDP3r42R//ebPCAFnQNfqqxfR7d/LymzdhEDWiC926NGMb4z0Rq1hk36lwlJtGU3aeZ3M/XA==
X-Received: by 2002:a17:90b:3010:: with SMTP id hg16mr4254783pjb.157.1590678252524;
        Thu, 28 May 2020 08:04:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:40e6:aa88:9c03:e0b4? ([2601:647:4000:d7:40e6:aa88:9c03:e0b4])
        by smtp.gmail.com with ESMTPSA id e12sm4758074pgi.40.2020.05.28.08.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:04:11 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] scsi: ufs: cleanup ufs initialization path
To:     Bean Huo <huobean@gmail.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200528115616.9949-1-huobean@gmail.com>
 <20200528115616.9949-4-huobean@gmail.com>
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
Message-ID: <dc54d52b-0687-9236-2e59-8a90465ec85b@acm.org>
Date:   Thu, 28 May 2020 08:04:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528115616.9949-4-huobean@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-05-28 04:56, Bean Huo wrote:
> At UFS initialization stage, to get the length of the descriptor,
> ufshcd_read_desc_length() being called 6 times. This patch is to
> delete unnecessary reduntant code, remove ufshcd_read_desc_length()
> and boost UFS initialization.

As explained in Documentation/process/submitting-patches.rst, please use
the imperative mood in patch descriptions. In other words, please change
"This patch is to delete" into "Delete". Please also change "reduntant"
into "redundant". Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart van Assche <bvanassche@acm.org>
