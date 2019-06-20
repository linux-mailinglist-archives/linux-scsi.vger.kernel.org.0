Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA64D215
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfFTPY7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 11:24:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37810 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbfFTPY7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 11:24:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so1539347plb.4
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 08:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VmMfbHsVX/BSWCzkPoWnoMCoL+tVqEhJF4b7117J++I=;
        b=on/wQMbmlMLtS14C0+8SruAumh/MaXTyyOHptI5qZCtz5xxzgNT00AmeQQS6bxMYbR
         GPzVXWLzQ0qh7Dbxy0cQVrEAanfFp+tJp6jMwf1UoA8JjCzVPQMLdu8W3gKFSxHcJOwR
         W598D2dq+/irgRXWPMrXjIXOhCKPt6wtvTh+7xAoiB5X9bHonVHtjixSpNecGWWWsK/p
         zyDsYe/3A2wC7xtLM0yg9oxgU5G/5LNGxU2r0ur5xuLNYkfPvGLAyRhckGJqUFb6LHHJ
         I9Djn8rC6h5xbRg/0ErOPK/fipcJ88U087g++/gyfPcjuuJZ8LcUxyhIM3X8daFEDqMj
         HufQ==
X-Gm-Message-State: APjAAAXjkaBCWOBXbTO6y5RC9eQEiomChaM8TPYC575hPQTwiadMDZCk
        MqSw1GsTbdkhQVNSrCPVzYw=
X-Google-Smtp-Source: APXvYqwdv/0HwerHIcIPYF2oOH91F/g6g2hvyREy63Cd0wNMIWz9It+JWdPUu13CjCvAfWf4g5pHKw==
X-Received: by 2002:a17:902:7891:: with SMTP id q17mr70427184pll.236.1561044298095;
        Thu, 20 Jun 2019 08:24:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x26sm23792402pfq.69.2019.06.20.08.24.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 08:24:57 -0700 (PDT)
Subject: Re: [PATCH] sd_zbc: Fix report zones buffer allocation
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190620034812.3254-1-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b6f250ad-0473-4643-8611-e395295e0379@acm.org>
Date:   Thu, 20 Jun 2019 08:24:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620034812.3254-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/19/19 8:48 PM, Damien Le Moal wrote:
> +	/*
> +	 * Limit the command buffer size to the arbitrary SD_ZBC_REPORT_SIZE
> +	 * size (1MB), allowing up to 16383 zone descriptors being reported with
> +	 * a single command. And make sure that this size does not exceed the
> +	 * hardware capabilities. To avoid disk revalidation failures due to
> +	 * memory allocation errors, retry the allocation with a smaller buffer
> +	 * size if the allocation fails.
> +	 */
> +	bufsize = min_t(size_t, *buflen, SD_ZBC_REPORT_SIZE);
> +	bufsize = min_t(size_t, bufsize,
> +			queue_max_hw_sectors(disk->queue) << 9);
> +	for (order = get_order(bufsize); order >= 0; order--) {
> +		page = alloc_pages(gfp_mask, order);
> +		if (page) {
> +			*buflen = PAGE_SIZE << order;
> +			return page_address(page);
> +		}
> +	}

Hi Damien,

As you know Linux memory fragmentation tends to increase over time. The 
above code has the very unfortunate property that the more memory is 
fragmented the smaller the allocated buffer will become. I don't think 
that's how kernel code should work. Have you considered to use vmalloc() 
+ blk_rq_map_sg() instead? See also efa_vmalloc_buf_to_sg() for an 
example of how to build a scatterlist for memory allocated by vmalloc().

Thanks,

Bart.
