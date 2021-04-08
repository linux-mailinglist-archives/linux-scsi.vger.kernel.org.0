Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118AD357E5B
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Apr 2021 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhDHIpD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Apr 2021 04:45:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:40266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhDHIpB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 8 Apr 2021 04:45:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 081F5AFF6;
        Thu,  8 Apr 2021 08:44:50 +0000 (UTC)
Subject: Re: [PATCH v17 24/45] sg: xarray for reqs in fd
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20210408014531.248890-1-dgilbert@interlog.com>
 <20210408014531.248890-25-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <57dec276-4db4-8c4a-06a4-07e14fbe252f@suse.de>
Date:   Thu, 8 Apr 2021 10:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210408014531.248890-25-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/8/21 3:45 AM, Douglas Gilbert wrote:
> Replace the linked list and the fixed array of requests (max 16)
> with an xarray. The xarray (srp_arr) has two marks: one for
> INACTIVE state (i.e. available for re-use) requests; the other
> is AWAIT state which is after the internal completion point of
> a request and before the user space has fetched the response.
> 
> Of the five states in sg_request::rq_st, two are marked. They are
> SG_RS_INACTIVE and SG_RS_AWAIT_RCV. This allows the request xarray
> (sg_fd::srp_arr) to be searched (with xa_for_each_mark) on two
> embedded sub-lists. The SG_RS_INACTIVE sub-list replaces the free
> list. The SG_RS_AWAIT_RCV sub-list contains requests that have
> reached their internal completion point but have not been read/
> received by the user space. Add support functions for this and
> partially wire them up.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>   drivers/scsi/sg.c | 317 +++++++++++++++++++++++++++++++++-------------
>   1 file changed, 230 insertions(+), 87 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
