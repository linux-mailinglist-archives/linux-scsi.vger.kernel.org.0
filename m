Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C923513A2A
	for <lists+linux-scsi@lfdr.de>; Sat,  4 May 2019 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfEDNYq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 4 May 2019 09:24:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40693 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfEDNYp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 4 May 2019 09:24:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so4120359pgl.7
        for <linux-scsi@vger.kernel.org>; Sat, 04 May 2019 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bi+tTaf/wZxULvPr2R5pEUvps2HmQg1idM+DekrMjAI=;
        b=u8tHeUIArZl/2gl/zOQqrYmvl47md4nlymszpwZWufaZgh4j7ODuju9pOVRMmkQbBF
         YtYNHRyOEVX4iGChYe3/ZJHcoL9qWjXaa9/Nzql9mXhfKRiysoIG9GdGK5qYGMipv2ym
         F9BfA7xXPe1V3/o56bpfLWwPsvlrn8HoC1QVVJPNGLSf5S0GXTztD3FVGJK2LSVa89A9
         sSMEmMIhxCCOImghVvFABJYMW9mx3XgLRXLrm3rbdHjnUYYN6NqcGuvRC+8yf3cfKtEb
         5E7f8Vl8vbmLJVYrCZYYsp2Ds06nlU+5/s3FR0UI+Vyb9wmnIrXB2uewCI71jTSD76vf
         oy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bi+tTaf/wZxULvPr2R5pEUvps2HmQg1idM+DekrMjAI=;
        b=i6UP2VyzfZX0tEBVigMELxpXeCTe1EQTx7pp/0hmslNFuM5mM6NR4luqJuUgxhXNQM
         kvD0ogVrrQLZO3QGGl1NeYgoxPHVd5CUKcz4JB9t5xNt8PRQsmNsviWwz/qOh6i0n3Ob
         y7Zh0A0JyDhB1ulLI3GuxynZs/3JZDAXstMicOM869Z4To/NIzZ5VIV4sGCg5PpWryOZ
         TcoRTfSDMjq0tmbdyCqtNN0XmGrsl445pzLmq4I/6G4Jk9XID5hautXYWLR/4x7j+loM
         YkhmBMBusMgkof0qUBxJHTyZdjHiu8Q0Vnr6Kj00keJNqPGnIWtJSgFRzKov7stHrO+9
         mEmw==
X-Gm-Message-State: APjAAAXsLwo1T6alPAGtLOMjQcybY7fZDizTyNWbiNKLJPyNccBWAp4W
        5rLMAWQvKNiLosOBaf5jfh9EwQ==
X-Google-Smtp-Source: APXvYqzFgKCFnperPrSbKjvxIIJ92eRIQ3VPsqwuoN0rKXHq5pO3DA42F85jV77P4i65nJdPAHFAow==
X-Received: by 2002:a62:5fc7:: with SMTP id t190mr19203370pfb.191.1556976285412;
        Sat, 04 May 2019 06:24:45 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id g32sm6079343pgl.16.2019.05.04.06.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 06:24:44 -0700 (PDT)
Subject: Re: [PATCH V9 0/7] blk-mq: fix races related with freeing queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190430015229.23141-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2472816-1994-be7c-239c-865a915567ef@kernel.dk>
Date:   Sat, 4 May 2019 07:24:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430015229.23141-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/29/19 7:52 PM, Ming Lei wrote:
> Hi,
> 
> Since 45a9c9d909b2 ("blk-mq: Fix a use-after-free"), run queue isn't
> allowed during cleanup queue even though queue refcount is held.
> 
> This change has caused lots of kernel oops triggered in run queue path,
> turns out it isn't easy to fix them all.
> 
> So move freeing of hw queue resources into hctx's release handler, then
> the above issue is fixed. Meantime, this way is safe given freeing hw
> queue resource doesn't require tags.

Applied, thanks Ming.

-- 
Jens Axboe

