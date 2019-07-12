Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1BB67210
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGLPM6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 11:12:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37405 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLPM6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Jul 2019 11:12:58 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so21055559iog.4
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jul 2019 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TgV+P5xUNL5epV/ZpLeslnEZ8CdbgVF9nNrx/k03o8g=;
        b=CGNvk4/dqGZ6+i1O+wfwJKZoo7ZYVaVuFsXwbqWoKa2XITkHd3rk7eN+9PMEwi0ihT
         l0BWkPExicPNlcfnNhprd86+MADEO/JMKNcrEfFYDcy4UtSlyJGgqGti1tMF6ZQp1Pw7
         PgB5kmZlAOgYnnICnXaE4Ce6bjaK0DqQ1LgWCGLeCGYaGSWtlukgKp30GZNQ0H4JqKou
         Bhzr1mlWRh38YS94B8YBVD967PLS6In5oR2rO4WHBu5RroQ4ZqfcdoRTxKZGAbtzyhwH
         JSlZc1isR6qSYuSho0mHJeLajd0JRjwkmewOWFe26AkCy+6Kjq6/vqcAg+wTP3Y8clDE
         OwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TgV+P5xUNL5epV/ZpLeslnEZ8CdbgVF9nNrx/k03o8g=;
        b=oiRtVUxW2m8/cAd6MFFebXqUoCSdsRKx8g/x7jn9ZhjrElVSOKWB76Rjkv7pX4918S
         vPxSNpbpkqyM7bemyo9pdlxzla2icmxUXQk7lTfvkwRlJKG4dbCSwAZ3oIwZwdnfuqEt
         E8Ziq0QXx22kDfbGkMcWpC3YNBrbbw4Ql6wQVflRwH3WFswdOd/H8XXm5MTXHF8JxgC7
         wGVKLeMb3UicxlrjNePW4vJuKo5MoElvsTUxhrIjnjPblVbXCmwPu6TQqmA2GVjW0hhn
         ZLn44S1okjnQuXFkfXuE180JNJcDhABfrPcyWmfDcgTk7YMpTjrAE8UVMspSkjT5jx09
         ZEJA==
X-Gm-Message-State: APjAAAUIT0eNXfbIXy+fpqemDNKFpAAiaCFwoKDz5ZBrIPDds7bgwBca
        3kcjGVzcRVx5SoRrX8rKYFM=
X-Google-Smtp-Source: APXvYqzNOs4ktys5P/q5Zi/E8ueb3gbQD/m0JLYFVa+rUUweNFsMDDkgPqUBftGoeg2lyKpUDsUArg==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr11632533ion.239.1562944377622;
        Fri, 12 Jul 2019 08:12:57 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l5sm15960501ioq.83.2019.07.12.08.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:12:56 -0700 (PDT)
Subject: Re: [PATCH V6 0/4] Fix zone revalidation memory allocation failures
From:   Jens Axboe <axboe@kernel.dk>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816BC7EC358F5785AEE1EA9E7F60@BYAPR04MB5816.namprd04.prod.outlook.com>
 <cb26f686-ce7e-9d1a-4735-2375d65c0ea5@kernel.dk>
Message-ID: <27386e10-7494-7fcf-f203-484db5c3c69c@kernel.dk>
Date:   Fri, 12 Jul 2019 09:12:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cb26f686-ce7e-9d1a-4735-2375d65c0ea5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/11/19 8:05 PM, Jens Axboe wrote:
> On 7/7/19 8:02 PM, Damien Le Moal wrote:
>> On 2019/07/01 14:09, Damien Le Moal wrote:
>>> This series addresses a recuring problem with zone revalidation
>>> failures observed during extensive testing with memory constrained
>>> system and device hot-plugging.
>>
>> Jens, Martin,
>>
>> Any comment regarding this series ?
> 
> LGTM, I'll queue it up for this release.

This broke !CONFIG_BLK_DEV_ZONED builds for null_blk, btw. Please be
sure to test with zoned enabled and disabled in your builds when
changing things that affect both.

I fixed it up:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=e347946439ed70e3af0d0c330b36d5648e71727b

-- 
Jens Axboe

