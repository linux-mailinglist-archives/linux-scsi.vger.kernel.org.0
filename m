Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48752B3F59
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Nov 2020 10:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgKPJD4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Nov 2020 04:03:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:52482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgKPJD4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 16 Nov 2020 04:03:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7128AAC90;
        Mon, 16 Nov 2020 09:03:55 +0000 (UTC)
Subject: Re: [PATCH 03/21] scsi: add scsi_{get,put}_internal_cmd() helper
To:     John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Don Brace <don.brace@microchip.com>,
        linux-scsi@vger.kernel.org, chenxiang <chenxiang66@hisilicon.com>
References: <20200703130122.111448-1-hare@suse.de>
 <20200703130122.111448-4-hare@suse.de>
 <5b9e5684-2235-7ba7-f81f-6dc46ee141e9@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b60ff356-b17b-128a-7b32-8cef3a234286@suse.de>
Date:   Mon, 16 Nov 2020 10:03:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5b9e5684-2235-7ba7-f81f-6dc46ee141e9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/16/20 9:56 AM, John Garry wrote:
> On 03/07/2020 14:01, Hannes Reinecke wrote:
>> Add helper functions to allow LLDDs to allocate and free
>> internal commands.
> 
> Hi Hannes,
> 
> Is there any way to ensure that the request allocated is associated with 
> some determined HW queue here?
> 
> The reason for this requirement is that sometimes the LLDD must submit 
> some internal IO (for which we allocate an "internal command") on a 
> specific HW queue. An example of this is internal abort IO commands, 
> which should be submitted on the same queue as the IO which we are 
> attempting to abort was submitted.
> 
> So, for sure, the LLDD does not have to honor the hwq associated with 
> the request and submit on the desired queue, but then we lose the blk-mq 
> CPU hotplug protection. And maybe other problems.
> 
> One way to achieve this is to run scsi_get_internal_cmd() on a CPU 
> associated with the desired HW queue, but that's a bit hacky. Not sure 
> of another way.
> 
Hmm. You are correct for the 'abort' command; that typically needs to be 
submitted to a specific hwq.

Let me think about it...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
