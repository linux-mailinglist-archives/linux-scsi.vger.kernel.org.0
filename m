Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF2E372A74
	for <lists+linux-scsi@lfdr.de>; Tue,  4 May 2021 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhEDMzz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 May 2021 08:55:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:38322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhEDMzy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 May 2021 08:55:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45E63AE00;
        Tue,  4 May 2021 12:54:59 +0000 (UTC)
Subject: Re: [PATCH 03/18] scsi: add scsi_{get,put}_internal_cmd() helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
References: <20210503150333.130310-1-hare@suse.de>
 <20210503150333.130310-4-hare@suse.de> <20210504095346.GC25986@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5ef846cb-2861-3c23-ed8c-54f54131ad1a@suse.de>
Date:   Tue, 4 May 2021 14:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210504095346.GC25986@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/4/21 11:53 AM, Christoph Hellwig wrote:
> On Mon, May 03, 2021 at 05:03:18PM +0200, Hannes Reinecke wrote:
>> +struct scsi_cmnd *scsi_get_internal_cmd(struct scsi_device *sdev,
>> +	unsigned int op, blk_mq_req_flags_t flags)
> 
> Weird indentation - prototype continuations either use two tabs or
> are aligned after the opening brace (I generally prefer the former).
> 
Yeah, I'm never sure how one should be indenting the second line for a 
function declaration. But I'll fix it.

>> +{
>> +	struct request *rq;
>> +	struct scsi_cmnd *scmd;
>> +
>> +	WARN_ON_ONCE(((op & REQ_OP_MASK) != REQ_OP_SCSI_IN) &&
>> +		     ((op & REQ_OP_MASK) != REQ_OP_SCSI_OUT));
> 
> Woudn't a simple bool write command make more sense than passing the
> actual op here?
> 
Yep, can do.

>> +	rq = blk_mq_alloc_request(sdev->request_queue, op, flags);
>> +	if (IS_ERR(rq))
>> +		return NULL;
>> +	scmd = blk_mq_rq_to_pdu(rq);
>> +	scmd->request = rq;
>> +	scmd->device = sdev;
> 
> Maybe a comment that explains what part of the scmd are initialized
> and which not would be useful.
> 
Okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
