Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620C6301FE1
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Jan 2021 02:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAYBZW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 24 Jan 2021 20:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhAYBYu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 24 Jan 2021 20:24:50 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D50DC061574
        for <linux-scsi@vger.kernel.org>; Sun, 24 Jan 2021 17:24:10 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g15so7830076pgu.9
        for <linux-scsi@vger.kernel.org>; Sun, 24 Jan 2021 17:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MSpVHwkCX6jn2zmjsM3ERb1RCWT/CaWYVTGYkGxLPMQ=;
        b=cANH8e1JsQWWCA6K7c2yEeTbdiEO1GVf52BOvOvHMuuzuOwLMbDpTIG8lwpolK0icK
         0L3S/ocwk1bn0K4m4mezLZfUoMQFkPMVdzF0swABRaRDvhjPdS//d4rYF/hhSVlIj0e5
         GCTjUL4+USqxWngHHgmkMMISuZnFlCQ/DjAcXqZTPP+gCqtwV9N6H5Us2R2RTf4/Wm3l
         v9dC6xJ3eOcxO2kdzsIP9/VK8pDSh3vIrWiQigEURvRp6ZKeNDds2ga8oMas6khTZbUU
         bAXCXf9s6wkbPhLdiUZZx1F3c1+XzZivD4vAPVU1i93DCZ5GpPiHbaFqNE9Ar2HplqEB
         J7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSpVHwkCX6jn2zmjsM3ERb1RCWT/CaWYVTGYkGxLPMQ=;
        b=EdJoCY48CR1lS81YpI9elLgYoyfFvap7AvhaQf0/AXQ1zpEwwMuL1eymr9HHgmwUsD
         knnM1uY1++LInz6CuKGIFhCAHMFNF0lUy0XHXO4kkPRDg8ff22TQ1D/A8CJCHkiqibRN
         jmf+0dg0ybWjLGi3LBz8KB6NgVkAz1+PPcYsslz56VQPQgX0UkBxfdb2WHdzyhpIwvCu
         LicwXpUMFyqYmOH2aWmxV7L7wJjMIkjkAIh+A1YFIPxD0evZUFHe1dsPPVKJVEsGoEDZ
         eKkCCnpRhRf0cnginR6cisQROjWCMysYEDd0QfynT+z0/mWq/qquSKhseJ+ed+yDIXCd
         2H3A==
X-Gm-Message-State: AOAM531hDE45KdFXTlC5ahSUSBTcNyqbGbEIm8zxhioHGH8IiSPdBn8I
        HfQ9TUgTpiTDIIoO1W+F0S70oA==
X-Google-Smtp-Source: ABdhPJwGmmoJHjWbM4oOrfmGt+RyPavosTLmBxchZDys8SFvm/6ZSwmX7zSbzb/FwCp9pNaqXVDW9g==
X-Received: by 2002:a63:e30d:: with SMTP id f13mr8331115pgh.39.1611537849731;
        Sun, 24 Jan 2021 17:24:09 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b18sm15216556pfi.173.2021.01.24.17.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 17:24:08 -0800 (PST)
Subject: Re: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait
 and blk_execute_rq
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        hch@infradead.org
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <683e16be-1146-e60c-cfea-e4606844f080@kernel.dk>
Date:   Sun, 24 Jan 2021 18:24:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/22/21 2:28 AM, Guoqing Jiang wrote:
> V2 changes:
> 1. update commit header per Christoph's comment.
> 
> Hi Jens,
> 
> This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
> Also update the comment for blk_execute_rq_nowait.

What's this against? The lightnvm patch doesn't apply.

-- 
Jens Axboe

