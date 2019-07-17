Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5C6BC25
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jul 2019 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfGQMMI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jul 2019 08:12:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34953 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQMMH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 17 Jul 2019 08:12:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so11887378plp.2;
        Wed, 17 Jul 2019 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/Gb7jEE+ZplI0EyTPs6qOyFsh+o6XOv4kVQ51JCMkA=;
        b=rcwhe/pOh/DKHRE75RRh3McP6NnmkSW99cb7AUyjWSX12bH7QqCxEl4D6tlsJXdK3S
         gP8qjwnXpE4d7OadncmdHOzdNZbUYatXxmx+LTl/JPJ8JdcI8p8zuqMrMT/aWYiXlGr3
         Q9nLc7wHVPm0w+sfk8qyEeKhunF00mRJmhzfQsWqtnY6c90r00rTBYhx2VUwQuZ8D+EX
         2XjDlq8g3nVDmj/6JZoYDQeZD3kmsA0EI6d5RW3SK/t7FdGeSJ2gtiXFdcjqyJ5BrhBL
         Md4iAWujKNGP5mP6urAUoZLW1nT9PPTb/bRys4yy+lYiIGV5dqTGhgM+es2PUKewe1Jc
         WenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/Gb7jEE+ZplI0EyTPs6qOyFsh+o6XOv4kVQ51JCMkA=;
        b=QYV4vPqyzWD4D2+YV1KG7qNSHCO77Wn9b0/aU9IxHTQV+VinRlaObKIIv0gkL8oWvB
         Ma3fYbFGY2dlPch2oA+JsT1dEXz+f5bm81YxuGK6uwcQH14eU9QncN/pL+8GGJJatBEv
         1lbfg5E8t3icuGHlubvE8SvrlN4kleO1ivqBzwXok/Hv5GZKrhVD4B+I/YFcTG816Aot
         wSPg8isHAhr1Vrn6mIZLA9hI7SCGekwshY0qrfxswg4CGfRGvYLuEDIBfE58/YRRgFZH
         2m8VLFnG9/g2D49UZDuGtqHxfNmp0xWPM1g3BwZvSOnmVwTWrmMhm9xaLD/ejYwu5HUD
         Fsrg==
X-Gm-Message-State: APjAAAWT3mf2AhjjGl/Dg4sO7yVOe81eEfOpBbW6QpbFJhyqedDgzEtP
        97OxhI/AmPVrmZJY+snOAQg=
X-Google-Smtp-Source: APXvYqzBZ+hy9Pqe1AbK+XLm/UpVjxZ6oNOlD0cIM+IMV3HiQI83dgqAbpNpjzhyCn1HLQ1D8exNhw==
X-Received: by 2002:a17:902:2ae8:: with SMTP id j95mr39288806plb.276.1563365526969;
        Wed, 17 Jul 2019 05:12:06 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id b1sm22695471pfi.91.2019.07.17.05.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 05:12:06 -0700 (PDT)
Date:   Wed, 17 Jul 2019 21:12:03 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     minwoo.im@samsung.com,
        "sreekanth.reddy@broadcom.com" <sreekanth.reddy@broadcom.com>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH V2] mpt3sas: support target smid for [abort|query] task
Message-ID: <20190717121203.GE10495@minwoo-desktop>
References: <CGME20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
 <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 19-07-15 08:13:36, Hannes Reinecke wrote:
> I think this is fundamentally wrong.
> ABORT_TASK is used to abort a single task, which of course has to be
> known beforehand. If you don't know the task, what exactly do you hope
> to achieve here? Aborting random I/O?
> Or, even worse, aborting I/O the driver uses internally and corrupt the
> internal workflow of the driver?
> 
> We should simply disallow any ABORT TASK from userspace if the TaskMID
> is zero. And I would even argue to disabllow ABORT TASK from userspace
> completely, as the smid is never relayed to userland, and as such the
> user cannot know which task should be aborted.
> 
> Cheers,
> 
> Hannes

Sreekanth,

Could you please give some thoughts about what Hannes said?
