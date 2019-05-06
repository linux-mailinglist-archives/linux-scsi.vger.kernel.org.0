Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81F143AA
	for <lists+linux-scsi@lfdr.de>; Mon,  6 May 2019 04:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfEFC4c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 5 May 2019 22:56:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46817 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFC4c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 5 May 2019 22:56:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so6954171qkb.13
        for <linux-scsi@vger.kernel.org>; Sun, 05 May 2019 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3EkTKV/xQkVhztjonY/d2AGuSlnO5DKm1O3uub0aHJ4=;
        b=CiNMRpI1IAu6DnSiyjrSy5Aixri8/vQFDFlMzD8ensn0XCYTXSWhAgWy6g/hK7c6mZ
         wcEdg9GOe6dcwjVn+ntQt3OSopX7SR2cH23U90g5iLbWna5gJWKtGJAQjmHY1SC4V1RC
         n6WuBE62bihChM05MZ2kstQ978lwLmcaTSH4XSQi3DnhE0lAdsvBRR6+YJjmO4TpC0sz
         QTJPjVFEiBOPC5QnPf+kqUk8QWTEjmQsuTwU25paNSb4QawN8Wthhfl3kOLa1q8kc84R
         OFO2DhEt844O04oqS96eAv/tnGsjcMPWDKaiPADXa0zlfnjgX4BH/XPQtLS0N2Xh3F2i
         xsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3EkTKV/xQkVhztjonY/d2AGuSlnO5DKm1O3uub0aHJ4=;
        b=d1G3IarIzIIjjocYnBY59Y4/ZJF3RTUTMjuV63VrKgeMWS2ryNb+gan49OauYVn7Fs
         JftpbW3Li/R2z4a/jAwOEQibP+0QWsYUsCvev7GxJp4g6CnpkJ5Zhj/oeja8bYvpDnyw
         ZQgqa1xmwI2YgIITdodN8z8alLd0l7rR6G7B+XjTr74Za6ccpIGWkb9CvSlRHoCvxfCt
         cMgp56VAEKFYhRSLsXDN5dVXq8xELvIxsm3Tag2J5uxb2T2WoaB8t5ZftYkgIkU0J0Cc
         CoeemZEb5sC314I0BHN4RHo9+97jilRrEEy40FIt+k2y1YzPkiuEReyQZ4aXilIrmCyn
         GZqA==
X-Gm-Message-State: APjAAAVNGHFrbGUmC0i6NDalRQBYPQsvHWX7APA1UaAUSXq6UY0ktmnE
        9ZGq+1ayCX8yzMbGNewt9khcwg==
X-Google-Smtp-Source: APXvYqw34FnNuqogx9nOJUx63jvgosRyfZRsiTutqvSvyJ5zT+75yh4mjnY6m0C+08OyQ6Oj97fiWw==
X-Received: by 2002:a37:a3d8:: with SMTP id m207mr4392842qke.334.1557111391110;
        Sun, 05 May 2019 19:56:31 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d8sm2477648qtd.2.2019.05.05.19.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 19:56:30 -0700 (PDT)
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi
 offline
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de, hch@lst.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.ibm.com, don.brace@microsemi.com,
        kevin.barnett@microsemi.com, scott.teel@microsemi.com,
        david.carroll@microsemi.com
References: <1556290348.6132.6.camel@lca.pw>
Message-ID: <ca40e139-3b0e-01db-b3c8-df0c1a04f9e6@lca.pw>
Date:   Sun, 5 May 2019 22:56:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556290348.6132.6.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/26/19 10:52 AM, Qian Cai wrote:
> Applying some memory pressure would causes smartpqi offline even in today's
> linux-next. This can always be reproduced by a LTP test cases [1] or sometimes
> just compiling kernels.
> 
> Reverting the commit "iommu/amd: Set exclusion range correctly" fixed the issue.
> 
> [  213.437112] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0000 address=0x1000 flags=0x0000]
> [  213.447659] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0000 address=0x1800 flags=0x0000]
> [  233.362013] smartpqi 0000:23:00.0: controller is offline: status code 0x14803
> [  233.369359] smartpqi 0000:23:00.0: controller offline
> [  233.388915] print_req_error: I/O error, dev sdb, sector 3317352 flags 2000001
> [  233.388921] sd 0:0:0:0: [sdb] tag#95 UNKNOWN(0x2003) Result: hostbyte=0x01
> driverbyte=0x00
> [  233.388931] sd 0:0:0:0: [sdb] tag#95 CDB: opcode=0x2a 2a 00 00 55 89 00 00 01
> 08 00
> [  233.389003] Write-error on swap-device (254:1:4474640)
> [  233.389015] Write-error on swap-device (254:1:2190776)
> [  233.389023] Write-error on swap-device (254:1:8351936)
> 
> [1] /opt/ltp/testcases/bin/mtest01 -p80 -w

It turned out another linux-next commit is needed to reproduce this, i.e.,
7a5dbf3ab2f0 ("iommu/amd: Remove the leftover of bypass support"). Specifically,
the chunks for map_sg() and unmap_sg(). This has been reproduced on 3 different
HPE ProLiant DL385 Gen10 systems so far.

Either reverted the chunks (map_sg() and unmap_sg()) on the top of the latest
linux-next fixed the issue or applied them on the top of the mainline v5.1
reproduced it immediately.

Lots of time it triggered this BUG_ON(!iova) in iova_magazine_free_pfns()
instead of the smartpqi offline.

    kernel BUG at drivers/iommu/iova.c:813!
    Workqueue: kblockd blk_mq_run_work_fn
    RIP: 0010:iova_magazine_free_pfns+0x7d/0xc0
    Call Trace:
     free_cpu_cached_iovas+0xbd/0x150
     alloc_iova_fast+0x8c/0xba
     dma_ops_alloc_iova.isra.6+0x65/0xa0
     map_sg+0x8c/0x2a0
     scsi_dma_map+0xc6/0x160
     pqi_aio_submit_io+0x1f6/0x440 [smartpqi]
     pqi_scsi_queue_command+0x90c/0xdd0 [smartpqi]
     scsi_queue_rq+0x79c/0x1200
     blk_mq_dispatch_rq_list+0x4dc/0xb70
     blk_mq_sched_dispatch_requests+0x249/0x310
     __blk_mq_run_hw_queue+0x128/0x200
     blk_mq_run_work_fn+0x27/0x30
     process_one_work+0x522/0xa10
     worker_thread+0x63/0x5b0
     kthread+0x1d2/0x1f0
     ret_from_fork+0x22/0x40
