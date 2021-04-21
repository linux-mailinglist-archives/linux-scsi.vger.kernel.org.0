Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4227367408
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhDUUPd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 16:15:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:36302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235541AbhDUUPc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 16:15:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57EF5ACC5;
        Wed, 21 Apr 2021 20:14:58 +0000 (UTC)
Subject: Re: [PATCH 0/5] scsi: fnic: use blk_mq_tagset_busy_iter() to walk
 scsi commands
To:     Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Satish Kharat <satishkh@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210421075543.1919826-1-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d251c21e-dd3e-979a-1c90-1f94b042e83c@suse.de>
Date:   Wed, 21 Apr 2021 22:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210421075543.1919826-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/21/21 9:55 AM, Ming Lei wrote:
> Hello Guys,
> 
> fnic uses the following way to walk scsi commands in failure handling,
> which is obvious wrong, because caller of scsi_host_find_tag has to
> guarantee that the tag is active.
> 
>          for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
> 				...
>                  sc = scsi_host_find_tag(fnic->lport->host, tag);
> 				...
> 		}
> 
> Fix the issue by using blk_mq_tagset_busy_iter() to walk
> request/scsi_command.
> 
> thanks,
> Ming
> 
> 
> Ming Lei (5):
>    scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
>      fnic_terminate_rport_io
>    scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
>      fnic_clean_pending_aborts
>    scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
>      fnic_cleanup_io
>    scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
>      fnic_rport_exch_reset
>    scsi: fnic: use blk_mq_tagset_busy_iter() to walk scsi commands in
>      fnic_is_abts_pending
> 
>   drivers/scsi/fnic/fnic_scsi.c | 933 ++++++++++++++++++----------------
>   1 file changed, 493 insertions(+), 440 deletions(-)
> 
> Cc: Satish Kharat <satishkh@cisco.com>
> Cc: Karan Tilak Kumar <kartilak@cisco.com>
> Cc: David Jeffery <djeffery@redhat.com>
> 
Well, this is actually not that easy for fnic.
Problem is the reset hack hch put in some time ago (cf 
fnic_host_start_tag()), which will cause any TMF to use a tag which is 
_not_ visible to the busy iter.
That will cause the iter to miss any TMF, with unpredictable results if 
a TMF is running at the same time than, say, a link bounce.

I have folded this as part of my patchset for reserved commands in SCSI; 
that way fnic can use 'normal' tags for TMFs, which are then visible to 
the busy iter and life's good.

Will be reposting the patchset shortly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
