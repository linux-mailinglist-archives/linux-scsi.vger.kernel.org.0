Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576FA6AA3E
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 16:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbfGPOFX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 10:05:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35695 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPOFW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jul 2019 10:05:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so3195694pgr.2
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jul 2019 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aoVagbFNhgXjrt3W/Zg0iqvw808Ej48g/8edVM2FIxY=;
        b=oB+KUHUY8jt3xmhaIq2rMBhWkYYVxc9eFPInFzebpABp/zB+uYCQgZ3glw+vyYLnV/
         2mg0EhT075HTjuRnRbAKJuaqPU6ib+K895FCPnCxGwszWDGOVKc/wfSnREM+UVMRqXuv
         ZnK5puZMup9/KjRqYLNSRS01VzBq4dGdDSRsonnY3FhPNMMziuHRz/Ej0PvtLCYFO8fn
         f78ZjcEb4EYtPsZ22IkAKG8on/FD308r+91bk9uDXS/bIliBn7bIFfX7rXQdNq2RpHUI
         lyg4akf0G03slJn5OrL6b2iISkyDq+PBy/dQYwKhRTaUFQ7GjaLqGsS6wAOseBsIwewQ
         Fd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aoVagbFNhgXjrt3W/Zg0iqvw808Ej48g/8edVM2FIxY=;
        b=g1oLdB7w4gB0E5kwUQmkgUsds3Ybnw6EdIWCmzbhBYzNI5vfn21zGQw/M5wbh2Qgrq
         iIPASl/VlTQu9zummHYXurS4yDte27JGBYY8t/tU1mN65pMJnMfSfd2WtkIqwRMhG1T8
         9Wh11YpYImF2K4UVQkmG7u8kacrD6P54B69sHmpKTq1MscFZl9OnxsPbOjoZ1yf2qALf
         hFXRtboMzrf54aSl+b3+ElXhU2rMzeILQ0J2ApedMCERv/oJFZkDW6VnfYwulV8KK5ra
         S+T3fC0nXtxFq8Gzn9p/eI0cfA7RPn5q6sZMBOujI4cr7gnvv2a/8SAIioOOojOLQlkk
         IVew==
X-Gm-Message-State: APjAAAXZ/ft4MSx+8D6z3YFIDYoHBldzlX5XHaanl0ycFdAm0o4nMye0
        yTQv+t115dHpGb31047IXyioNPFLH0A=
X-Google-Smtp-Source: APXvYqzjx0xWwCczyNCO7AxzI9Vek3/4hKvb7RI6GhrXm06aGJFLjKM6citOIZnYOh4ngmsyCA3uRQ==
X-Received: by 2002:a63:9318:: with SMTP id b24mr24121376pge.31.1563285922055;
        Tue, 16 Jul 2019 07:05:22 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i198sm7788161pgd.44.2019.07.16.07.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:05:20 -0700 (PDT)
Subject: Re: [PATCH] scsi: sd_zbc: Fix compilation warning
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190715053833.5973-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4812ac1-dfae-73d7-4722-4158c38d2382@kernel.dk>
Date:   Tue, 16 Jul 2019 08:05:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715053833.5973-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/14/19 11:38 PM, Damien Le Moal wrote:
> kbuild test robot gets the following compilation warning using gcc 7.4
> cross compilation for c6x (GCC_VERSION=7.4.0 make.cross ARCH=c6x).
> 
>     In file included from include/asm-generic/bug.h:18:0,
>                      from arch/c6x/include/asm/bug.h:12,
>                      from include/linux/bug.h:5,
>                      from include/linux/thread_info.h:12,
>                      from include/asm-generic/current.h:5,
>                      from ./arch/c6x/include/generated/asm/current.h:1,
>                      from include/linux/sched.h:12,
>                      from include/linux/blkdev.h:5,
>                      from drivers//scsi/sd_zbc.c:11:
>     drivers//scsi/sd_zbc.c: In function 'sd_zbc_read_zones':
>>> include/linux/kernel.h:62:48: warning: 'zone_blocks' may be used
>     uninitialized in this function [-Wmaybe-uninitialized]
>      #define __round_mask(x, y) ((__typeof__(x))((y)-1))
>                                                     ^
>     drivers//scsi/sd_zbc.c:464:6: note: 'zone_blocks' was declared here
>       u32 zone_blocks;
>           ^~~~~~~~~~~
> 
> Fix this by initializing the zone_blocks variable to 0.

Probably worth noting that this is a false positive, and even if it is,
include a Fixes: entry as well.

Otherwise obviously looks fine to me. Martin, do you want to pick this
one up?

-- 
Jens Axboe

