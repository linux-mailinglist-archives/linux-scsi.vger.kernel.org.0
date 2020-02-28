Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0007A1733AF
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Feb 2020 10:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgB1JUe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 04:20:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:51434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgB1JUe (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Feb 2020 04:20:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 67236AC92;
        Fri, 28 Feb 2020 09:20:32 +0000 (UTC)
Subject: Re: [PATCH v7 36/38] sg: rework mmap support
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20200227165902.11861-1-dgilbert@interlog.com>
 <20200227165902.11861-37-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f3fd079a-2eb9-ce97-7885-56438b02d4a9@suse.de>
Date:   Fri, 28 Feb 2020 10:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227165902.11861-37-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2/27/20 5:59 PM, Douglas Gilbert wrote:
> Linux has an issue with mmap-ed multiple pages issued by
> alloc_pages() [with order > 0]. So when mmap(2) is called if the
> reserve request's scatter gather (sgat) list is either:
>    - not big enough, or
>    - made up of elements of order > 0 (i.e. size > PAGE_SIZE)
> then throw away reserve requests sgat list and rebuild it meeting
> those requirements.
> Clean up related code and stop doing mmap+indirect_io.
> 
> This new mmap implementation is marginally more flexible (but
> still compatible with) the production driver. Previously if the
> user wanted a larger mmap(2) 'length' than the reserve request's
> size, then they needed to use ioctl(SG_SET_RESERVED_SIZE) to set
> the new size first. Now mmap(2) called on a sg device node will
> adjust to the size given by 'length' [mmap's second parameter].
> 
> Tweak some SG_LOG() levels to control the amount of debug
> output.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>   drivers/scsi/sg.c | 150 +++++++++++++++++++++++++++-------------------
>   1 file changed, 87 insertions(+), 63 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
