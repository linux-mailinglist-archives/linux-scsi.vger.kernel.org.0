Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6E1E1307
	for <lists+linux-scsi@lfdr.de>; Mon, 25 May 2020 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbgEYQtp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 May 2020 12:49:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30314 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388279AbgEYQto (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 25 May 2020 12:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590425383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ILw//qOdAs3N72qYaIvb4OqchiR2UaRFPCuz59E+ho=;
        b=FvQTGjLm4MVFe+l7XlKAbZj5sA13mBr81JxXDMmeLyPmsyxmLshxnSfYgilKutQIg/chFo
        fe4NLCvGZMV84J5O21M4ESPzB9rrWuEBTKPzDIOVuerStgX5wBAvGQeYorotuHIhz3JGBd
        Hh5jD1PqNhvhTwDTWHedGT/lGllueTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-rQoqV7gxOdqwaxkKs_QF3A-1; Mon, 25 May 2020 12:49:39 -0400
X-MC-Unique: rQoqV7gxOdqwaxkKs_QF3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9022107ACCD;
        Mon, 25 May 2020 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1C496EDA4;
        Mon, 25 May 2020 16:49:37 +0000 (UTC)
Subject: Re: [PATCH] mpt3sas: Fix reply queue count in non RDPQ mode.
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     sreekanth.reddy@broadcom.com
References: <20200522103558.5710-1-suganath-prabu.subramani@broadcom.com>
From:   Tomas Henzl <thenzl@redhat.com>
Message-ID: <62c55ae3-ac50-309d-8f78-c2f4a2fb750c@redhat.com>
Date:   Mon, 25 May 2020 18:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200522103558.5710-1-suganath-prabu.subramani@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/22/20 12:35 PM, Suganath Prabu S wrote:
> For non RDPQ mode, Driver allocates a single contiguous block of
> memory pool for all reply descriptor post queues and passes down a
> single address in the ReplyDescriptorPostQueueAddress field of the IOC
> Init Request Message to the firmware. So reply_post queue will have
> only one entry which holds the address of this single contiguous block
> of memory pool.
> 
> So while allocating the reply descriptor post queue pool driver should
> loop for only one time in non-RDPQ mode. But due to a bug in below
> patch driver is looping for ioc->reply_queue_count number of times
> even though reply_post queue's queue depth is only one in non-RDPQ
> mode. This leads to 'BUG: KASAN: use-after-free in
> base_alloc_rdpq_dma_pool'.
> 
> commit 8012209eb26b7819385a6ec6eae4b1d0a0dbe585 ("scsi: mpt3sas:
> Handle RDPQ DMA allocation in same 4G region")
> 
> Fix is to loop over only one time while allocating the memory for the
> reply descriptor post queue in non-RDPQ mode
> 
> Reported-by: Tomas Henzl <thenzl@redhat.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>

I've tested it and this patch fixes the problem

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

