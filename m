Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9D54991B
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 08:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfFRGpA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 02:45:00 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:34905 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFRGpA (ORCPT
        <rfc822;groupwise-linux-scsi@vger.kernel.org:0:0>);
        Tue, 18 Jun 2019 02:45:00 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 18 Jun 2019 08:24:58 +0200
Subject: Re: [PATCH v4 1/3] scsi: Restrict user space SCSI device state
 changes to "running" and "offfline"
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
References: <20190617151820.241583-1-bvanassche@acm.org>
 <20190617151820.241583-2-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <16d58f6b-c797-409c-9259-a4dbf6b4e4a4@suse.com>
Date:   Tue, 18 Jun 2019 08:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617151820.241583-2-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/17/19 5:18 PM, Bart Van Assche wrote:
> The ability to modify the SCSI device state was introduced by commit
> 638127e579a4 ("[PATCH] Fix error handler offline behaviour"; v2.6.12). That
> same commit introduced the following device states:
> 
>        { SDEV_CREATED, "created" },
>        { SDEV_RUNNING, "running" },
>        { SDEV_CANCEL,  "cancel"  },
>        { SDEV_DEL,     "deleted" },
>        { SDEV_QUIESCE, "quiesce" },
>        { SDEV_OFFLINE, "offline" },
> 
> The SDEV_BLOCK state was introduced later to avoid that an FC cable pull
> would immediately result in an I/O error (commit 1094e682310e; "[PATCH]
> suspending I/Os to a device"; v2.6.12). That same patch introduced the
> ability to set the SDEV_BLOCK state from user space. I'm not sure whether
> that ability was introduced on purpose or accidentally.
> 
> Since there is agreement that only writing "running" or "offline" into
> the SCSI sysfs device state attribute makes sense, restrict sysfs writes
> to these values.
> 
> This patch makes sure that SDEV_BLOCK is only used for its original
> purpose, namely to allow transport drivers and LLDs to block further
> .queuecommand() calls while transport layer or adapter recovery is in
> progress.
> 
> Note: a web search for "/sys/class/scsi_device" AND "device/state"
> revealed several storage configuration guides. The instructions I found
> in these guides tell users to write the value "running" or "offline" in
> the SCSI device state sysfs attribute and no other values.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 3b119ca0cc0c..850cdc731a1f 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -766,8 +766,13 @@ store_state_field(struct device *dev, struct device_attribute *attr,
>  			break;
>  		}
>  	}
> -	if (!state)
> +	switch (state) {
> +	case SDEV_RUNNING:
> +	case SDEV_OFFLINE:
> +		break;
> +	default:
>  		return -EINVAL;
> +	}
>  
>  	mutex_lock(&sdev->state_mutex);
>  	ret = scsi_device_set_state(sdev, state);
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
