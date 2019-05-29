Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3A2E366
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 19:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfE2RiQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 13:38:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:53944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfE2RiQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 13:38:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F97FAD02;
        Wed, 29 May 2019 17:38:15 +0000 (UTC)
Subject: Re: [PATCH 11/24] scsi: add scsi_host_get_reserved_cmd()
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-12-hare@suse.de>
 <25a5a8f5-324b-6b7c-71eb-6cb9f9a60ba8@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0af75234-7470-acb8-c7ac-10ebaa1e3321@suse.de>
Date:   Wed, 29 May 2019 19:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <25a5a8f5-324b-6b7c-71eb-6cb9f9a60ba8@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/29/19 5:19 PM, Bart Van Assche wrote:
> On 5/29/19 6:28 AM, Hannes Reinecke wrote:
>> +    rq = blk_mq_alloc_request(shost->reserved_cmd_q,
>> +                  REQ_OP_DRV_OUT | REQ_NOWAIT,
>> +                  BLK_MQ_REQ_RESERVED);
> 
> Is your purpose to avoid that blk_mq_alloc_request() waits? If so, why 
> do you want to avoid that?
> 
Typically these commands are intended for internal purposes, so there 
should always be enough commands free to allow direct allocation.
If not we're in an error condition, and we need to return so as not to 
lock up the driver (as it might rely on this command to make forward 
progress).

> The same comment as for patch 02/24 applies here: if you want to avoid 
> that blk_mq_alloc_request() I think you need BLK_MQ_REQ_NOWAIT instead 
> of REQ_NOWAIT.
> 
Sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
