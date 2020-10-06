Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA602845A6
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Oct 2020 07:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJFFtX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Oct 2020 01:49:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbgJFFtW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 6 Oct 2020 01:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42594AC0C;
        Tue,  6 Oct 2020 05:49:20 +0000 (UTC)
Subject: Re: [PATCH 08/10] scsi: cleanup allocation and freeing of sgtables
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org
References: <20201005084130.143273-1-hch@lst.de>
 <20201005084130.143273-9-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5dfdca74-23c3-7679-dac8-cd59c4a7364c@suse.de>
Date:   Tue, 6 Oct 2020 07:49:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005084130.143273-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/5/20 10:41 AM, Christoph Hellwig wrote:
> Rename scsi_init_io to scsi_alloc_sgtables, and ensure callers call
> scsi_free_sgtables to cleanup failures close to scsi_init_io instead
> of leaking it down the generic I/O submission path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/scsi_lib.c  | 22 ++++++++--------------
>   drivers/scsi/sd.c        | 27 +++++++++++++++------------
>   drivers/scsi/sr.c        | 16 ++++++----------
>   include/scsi/scsi_cmnd.h |  3 ++-
>   4 files changed, 31 insertions(+), 37 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
