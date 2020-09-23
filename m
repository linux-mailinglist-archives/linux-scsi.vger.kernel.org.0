Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107322751CC
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Sep 2020 08:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWGq3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Sep 2020 02:46:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:50572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIWGq3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 23 Sep 2020 02:46:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54261B00D;
        Wed, 23 Sep 2020 06:47:04 +0000 (UTC)
Subject: Re: [PATCH V3 for 5.11 09/12] scsi: put hot fields of
 scsi_host_template into one cacheline
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200923013339.1621784-1-ming.lei@redhat.com>
 <20200923013339.1621784-10-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9629d3c1-61df-8816-5676-2788176b2b77@suse.de>
Date:   Wed, 23 Sep 2020 08:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923013339.1621784-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/23/20 3:33 AM, Ming Lei wrote:
> The following three fields of scsi_host_template are referenced in
> scsi IO submission path, so put them together into one cacheline:
> 
> - cmd_size
> - queuecommand
> - commit_rqs
> 
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   include/scsi/scsi_host.h | 72 ++++++++++++++++++++++------------------
>   1 file changed, 39 insertions(+), 33 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
