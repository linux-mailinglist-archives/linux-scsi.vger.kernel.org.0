Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C646D80207
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 22:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfHBUvq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Aug 2019 16:51:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45713 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfHBUvq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 2 Aug 2019 16:51:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so34087231plr.12
        for <linux-scsi@vger.kernel.org>; Fri, 02 Aug 2019 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yhQyk8IoMkg6VHquCP646/YjI159eG2Qm/tmGkUGWc0=;
        b=eLknO8W268WA1BOZZOqsQaGOcE36fB6+Qco2TDByp03Y3syvQo5t3u8iNqWR50TWV2
         yKGN5VSl9gVYeJjvcjT00vdkjamt7KhrcEXeRhqBeCQUXAahxdTLxkNBs5/6PY3irFs/
         zsn2L/wm2rw7vPlGH+o8OMsEmWjT5prgg4wmdWTVJQSf5dnDA/0CXymykK6QiUi2J1OL
         BAuom5MZxhRmfl6daNIf5Pan7pvVyfdQi1GRzF6u93xJ8Di2qcmlFMLxmjBwnw4HqD5x
         8d8l39h5NuQnMXSHmGOMa7V2jkyLig9ufONEn5Gsy0Or8kKrI1y4OvMIRUKmqo6KSTKj
         o3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhQyk8IoMkg6VHquCP646/YjI159eG2Qm/tmGkUGWc0=;
        b=oMQsdgUJZLOTBw+V3SInim3GFJbZTh8tD12scIKdnHciyu+3Qxc6KLJwYKxi0OA/wk
         HRJHwHV5I+d+mWCcyzUy1P9Mz6LclYWHTtbD3IWZiLHmSNTjWbMlRtnrHReZAxYoyG0m
         ky5+dQgZXZaXhuAbC5yIR4xGvKxv0mo6x5fmhicTo6NZk0JEz9yYdriZHU1ozkEkMRph
         i/0ONR/W8XcrsP0fJe6ZcjRC0X2789wrECsKesSpNuyxjnBJVrcMHxIK0cASEhdm88mk
         jWA5HFzH8Cn3xHNohsAzu8c7fuk+hYV7j64nJRQw9ADc9HXs05W8ULK4sEgaqcqywVn8
         Twww==
X-Gm-Message-State: APjAAAWbeHYbklf724yx14QO0FfaP0RO0ILlln+7bN0o6ddaGHqshZOI
        I/yBDT/1SducvlYVDIQGoEw=
X-Google-Smtp-Source: APXvYqxnhhUgag8ACgmGz+kw/tadhC/nQqXCHeHfBG4vinB3NzD3w42LsuY+BlG0KvA6j1CIk0ZBBA==
X-Received: by 2002:a17:902:543:: with SMTP id 61mr132651767plf.20.1564779105704;
        Fri, 02 Aug 2019 13:51:45 -0700 (PDT)
Received: from [172.31.98.58] (rrcs-76-79-101-187.west.biz.rr.com. [76.79.101.187])
        by smtp.gmail.com with ESMTPSA id v13sm87924292pfn.109.2019.08.02.13.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 13:51:44 -0700 (PDT)
Subject: Re: [PATCH 3/8] block: blk-crypto for Inline Encryption
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190710225609.192252-1-satyat@google.com>
 <20190710225609.192252-4-satyat@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c5bffc1e-ce6a-0060-cf55-e3dc446d7049@kernel.dk>
Date:   Fri, 2 Aug 2019 13:51:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190710225609.192252-4-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/10/19 4:56 PM, Satya Tangirala wrote:
> We introduce blk-crypto, which manages programming keyslots for struct
> bios. With blk-crypto, filesystems only need to call bio_crypt_set_ctx with
> the encryption key, algorithm and data_unit_num; they don't have to worry
> about getting a keyslot for each encryption context, as blk-crypto handles
> that. Blk-crypto also makes it possible for layered devices like device
> mapper to make use of inline encryption hardware.
> 
> Blk-crypto delegates crypto operations to inline encryption hardware when
> available, and also contains a software fallback to the kernel crypto API.
> For more details, refer to Documentation/block/blk-crypto.txt.
> 
> Known issues:
> 1) We're allocating crypto_skcipher in blk_crypto_keyslot_program, which
> uses GFP_KERNEL to allocate memory, but this function is on the write
> path for IO - we need to add support for specifying a different flags
> to the crypto API.

That's a must-fix before merging, btw.

> @@ -1018,7 +1019,9 @@ blk_qc_t generic_make_request(struct bio *bio)
>   			/* Create a fresh bio_list for all subordinate requests */
>   			bio_list_on_stack[1] = bio_list_on_stack[0];
>   			bio_list_init(&bio_list_on_stack[0]);
> -			ret = q->make_request_fn(q, bio);
> +
> +			if (!blk_crypto_submit_bio(&bio))
> +				ret = q->make_request_fn(q, bio);
>   
>   			blk_queue_exit(q);

Why isn't this just stacking the ->make_request_fn() instead? Then we
could get this out of the hot path.

-- 
Jens Axboe

