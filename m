Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7052F3457
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391738AbhALPj7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 10:39:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:60476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390080AbhALPj7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Jan 2021 10:39:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2FD7AED0;
        Tue, 12 Jan 2021 15:39:17 +0000 (UTC)
Subject: Re: [PATCH 2/3] aha1542: kill trailing whitespace
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <2726d35a-ac66-fae9-51e7-ea4f13e89fd7@omprussia.ru>
 <59829052-4932-4ea3-b504-857bbb19e6a0@omprussia.ru>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d653cfc7-0d69-601e-8da1-40184cffc572@suse.de>
Date:   Tue, 12 Jan 2021 16:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <59829052-4932-4ea3-b504-857bbb19e6a0@omprussia.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/10/21 5:48 PM, Sergey Shtylyov wrote:
> Some source lines (mostly the comments) in this driver end with spaces, as
> reported by 'scripts/checkpatch.pl' -- let's trim these lines.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
> 
> ---
>   drivers/scsi/aha1542.c |   14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
