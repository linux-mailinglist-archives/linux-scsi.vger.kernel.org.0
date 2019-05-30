Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77AF2FEDF
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 17:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfE3PFj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 11:05:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfE3PFj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 11:05:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D197ADD9;
        Thu, 30 May 2019 15:05:38 +0000 (UTC)
Subject: Re: [PATCH 06/24] virtio_scsi: use reserved commands for TMF
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-7-hare@suse.de>
 <411d86bf-abba-90c2-1021-f03c30f1b3d0@huawei.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <688da42a-efb6-1127-dc33-bae6cfd31322@suse.com>
Date:   Thu, 30 May 2019 17:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <411d86bf-abba-90c2-1021-f03c30f1b3d0@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/30/19 2:35 PM, John Garry wrote:
> On 29/05/2019 14:28, Hannes Reinecke wrote:
>>
>>  static int virtscsi_map_queues(struct Scsi_Host *shost)
>> @@ -827,6 +830,8 @@ static int virtscsi_probe(struct virtio_device *vdev)
>>      shost->max_channel = 0;
>>      shost->max_cmd_len = VIRTIO_SCSI_CDB_SIZE;
>>      shost->nr_hw_queues = num_queues;
>> +    shost->can_queue -= VIRTIO_SCSI_RESERVED_CMDS;
> 
> shost->can_queue is already referenced after it is set earlier in 
> virtscsi_probe(), so I wonder if this is ok to later revise it? See:
> 
> shost->cmd_per_lun = min_t(u32, cmd_per_lun, shost->can_queue);
> 
Yeah, I think it is correct.
But I'll be checking.

Cheers,

Hannes
