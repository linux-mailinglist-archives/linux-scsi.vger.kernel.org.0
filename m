Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16132F5B34
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Jan 2021 08:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbhANHVb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Jan 2021 02:21:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:38054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbhANHV1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 14 Jan 2021 02:21:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2904BABD6;
        Thu, 14 Jan 2021 07:20:46 +0000 (UTC)
Subject: Re: [PATCH v13 40/45] sg: remove rcv_done request state
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        kashyap.desai@broadcom.com
References: <20210113224526.861000-1-dgilbert@interlog.com>
 <20210113224526.861000-41-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <43af5016-d42f-1222-3716-82aa4566c019@suse.de>
Date:   Thu, 14 Jan 2021 08:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210113224526.861000-41-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/13/21 11:45 PM, Douglas Gilbert wrote:
> Remove SG_RQ_RCV_DONE request state. Also remember the position of
> the last used request array element and start subsequent searches
> for completed requests and new requests from that index.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>   drivers/scsi/sg.c | 168 ++++++++++++++++++++++++++--------------------
>   1 file changed, 96 insertions(+), 72 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
