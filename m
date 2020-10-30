Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8384329FE55
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Oct 2020 08:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgJ3HR1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Oct 2020 03:17:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:41142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgJ3HR1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 30 Oct 2020 03:17:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FEDCAC0C;
        Fri, 30 Oct 2020 07:17:26 +0000 (UTC)
Subject: Re: [PATCH 2/2] scsi: scsi_vpd_lun_id: replace while-loop by for-loop
To:     mwilck@suse.com, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        James Bottomley <jejb@linux.vnet.ibm.com>
References: <20201029170846.14786-1-mwilck@suse.com>
 <20201029170846.14786-2-mwilck@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <357520a8-08bb-d07a-3089-6e819333e428@suse.de>
Date:   Fri, 30 Oct 2020 08:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029170846.14786-2-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/29/20 6:08 PM, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> This makes the code slightly more readable.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   drivers/scsi/scsi_lib.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
If you insist ...

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
