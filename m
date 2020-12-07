Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1D2D1302
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 15:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgLGOBx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 09:01:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:33014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgLGOBx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Dec 2020 09:01:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07D97AB63;
        Mon,  7 Dec 2020 14:01:12 +0000 (UTC)
Subject: Re: [PATCH 01/35] scsi: drop gdth driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20201207124819.95822-1-hare@suse.de>
 <20201207124819.95822-2-hare@suse.de> <20201207133850.GB29249@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d6950d53-97aa-9487-8014-c91d74b824d4@suse.de>
Date:   Mon, 7 Dec 2020 15:01:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207133850.GB29249@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 12/7/20 2:38 PM, Christoph Hellwig wrote:
> On Mon, Dec 07, 2020 at 01:47:45PM +0100, Hannes Reinecke wrote:
>> The gdth driver refers to a SCSI parallel, PCI-only HBA RAID adapter
>> which was manufactured by the now-defunct ICP Vortex company, later
>> acquired by Adaptec and superseded by the aacraid series of controllers.
>> The driver itself would require a major overhaul before any modifications
>> can be attempted, but seeing that it's unlikely to have any users left
>> it should rather be removed completely.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> That is no the tag I gave you..
> 
Bah, s**t. You are right.
Original tag was:

Cautiously-Acked-by: Christoph Hellwig <hch@lst.de>


But it'll be up to mkp to decide what'll happen with this beast.
It has cropped up on virtually every patchset I've been working on, so I 
really would like to get it out of the way.

I might even have some cards floating around in case the decision is to 
keep it, but I've already found in testing the other drivers that 
getting _disks_ will be a major pain.
Plus in the 10-odd years we (ie SUSE) didn't have a _single_ incident 
involving this driver, which it typically a sure sign that no-one is 
using it.

Martin?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
