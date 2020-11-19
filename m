Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575562B901F
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 11:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgKSK3V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 05:29:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:53876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgKSK3V (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Nov 2020 05:29:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 768E3AA4F;
        Thu, 19 Nov 2020 10:29:19 +0000 (UTC)
Subject: Re: [PATCH V5 10/13] megaraid_sas: v2 replace sdev_busy with local
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>
References: <20201119094705.280390-1-ming.lei@redhat.com>
 <20201119095147.GB279559@T590>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0a3b01e0-434b-7962-ffc7-611bc9c680a1@suse.de>
Date:   Thu, 19 Nov 2020 11:29:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201119095147.GB279559@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/19/20 10:51 AM, Ming Lei wrote:
>  From 4c13ab0b85057de70c523970bbb9d2268e6d980d Mon Sep 17 00:00:00 2001
> From: Kashyap Desai <kashyap.desai@broadcom.com>
> Date: Thu, 19 Nov 2020 12:39:01 +0530
> Subject: [PATCH V5 10/13] megaraid_sas: v2 replace sdev_busy with local
>   counter
> 
> use local tracking of per sdev outstanding command since sdev_busy in
> SML is improved for performance reason using sbitmap (earlier it was
> atomic variable).
> 
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> 
> Fix checkpatch ERROR and WARNING.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/scsi/megaraid/megaraid_sas.h        |  2 +
>   drivers/scsi/megaraid/megaraid_sas_fusion.c | 47 +++++++++++++++++----
>   2 files changed, 41 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
