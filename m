Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D5357E5A
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Apr 2021 10:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhDHIpC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Apr 2021 04:45:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:40264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhDHIpB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 8 Apr 2021 04:45:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 057E8AFEA;
        Thu,  8 Apr 2021 08:44:50 +0000 (UTC)
Subject: Re: [PATCH v17 39/45] sg: add mmap_sz tracking
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20210408014531.248890-1-dgilbert@interlog.com>
 <20210408014531.248890-40-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9818dacb-d1e7-7d9a-8ba6-b490d82d9dd7@suse.de>
Date:   Thu, 8 Apr 2021 10:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210408014531.248890-40-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/8/21 3:45 AM, Douglas Gilbert wrote:
> Track mmap_sz from prior mmap(2) call, per sg file descriptor. Also
> reset this value whenever munmap(2) is called. Fail SG_FLAG_MMAP_IO
> uses if mmap(2) hasn't been called or the memory associated with it
> is not large enough for the current request.
> 
> Remove SG_FFD_MMAP_CALLED bit as it can be deduced from
> sfp->mmap_sz where a value of 0 implies no mmap() call active.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>   drivers/scsi/sg.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
