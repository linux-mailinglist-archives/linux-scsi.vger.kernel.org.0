Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8364D2E344
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfE2Rd5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 13:33:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:53340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfE2Rd5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 13:33:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58DEBAD02;
        Wed, 29 May 2019 17:33:56 +0000 (UTC)
Subject: Re: [PATCH 02/24] scsi: add scsi_{get,put}_reserved_cmd()
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-3-hare@suse.de>
 <09f930f8-f152-095d-a428-8dba3722f7de@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <34a2714e-a117-fa1b-785e-95e7e113eab0@suse.de>
Date:   Wed, 29 May 2019 19:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <09f930f8-f152-095d-a428-8dba3722f7de@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/29/19 5:12 PM, Bart Van Assche wrote:
> On 5/29/19 6:28 AM, Hannes Reinecke wrote:
>> +    rq = blk_mq_alloc_request(sdev->request_queue,
>> +                  REQ_OP_SCSI_OUT | REQ_NOWAIT,
>> +                  BLK_MQ_REQ_RESERVED);
> 
> This looks wrong to me. To avoid that blk_mq_alloc_request() waits I 
> think it should be called as follows:
> 
>      rq = blk_mq_alloc_request(sdev->request_queue,
>              REQ_OP_SCSI_OUT,
>              BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
> 
> Bart.
Ah. Right.
Will be changing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
