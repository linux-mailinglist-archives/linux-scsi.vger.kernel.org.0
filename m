Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA793731275
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Jun 2023 10:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbjFOIlo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Jun 2023 04:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbjFOIld (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 15 Jun 2023 04:41:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD71F2951;
        Thu, 15 Jun 2023 01:41:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89960223F2;
        Thu, 15 Jun 2023 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686818466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGO76gFPPA5VnhAt82rZ+vIfVFYa+IwiE54it4kLocE=;
        b=iFYAIg4oFRq7sWPab2mlB5CrymkE6yPcUhL11DeVjziSB5Uy1dIArp0hAUbSarbob8n4sq
        hiUfoF8dpGRZMk1q9LFrcYHQw1A/araYjBlWux0eRQc6L4JmfL7tUERzYHo0q6qSETRqIO
        HVG/cq9L3JApJ3yWwQSvdYTFrzICu2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686818466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGO76gFPPA5VnhAt82rZ+vIfVFYa+IwiE54it4kLocE=;
        b=vQiCrvwRszMZaaJS1S0I7A/dAWCaIBCmakgbpdY+lVfYhx4RUw0FXj7mx2HFuRLnpvVExs
        69bBqf7bFEXg/HDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FF1B13467;
        Thu, 15 Jun 2023 08:41:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wiKXGqLOimT1OAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 15 Jun 2023 08:41:06 +0000
Message-ID: <cd56bd55-e0e5-d8f0-bdac-2e0513ed7106@suse.de>
Date:   Thu, 15 Jun 2023 10:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ata: libata-scsi: Avoid deadlock on rescan after device
 resume
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>
References: <20230615083326.161875-1-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230615083326.161875-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/15/23 10:33, Damien Le Moal wrote:
> When an ATA port is resumed from sleep, the port is reset and a power
> management request issued to libata EH to reset the port and rescanning
> the device(s) attached to the port. Device rescanning is done by
> scheduling an ata_scsi_dev_rescan() work, which will execute
> scsi_rescan_device().
> 
> However, scsi_rescan_device() takes the generic device lock, which is
> also taken by dpm_resume() when the SCSI device is resumed as well. If
> a device rescan execution starts before the completion of the SCSI
> device resume, the rcu locking used to refresh the cached VPD pages of
> the device, combined with the generic device locking from
> scsi_rescan_device() and from dpm_resume() can cause a deadlock.
> 
> Avoid this situation by changing struct ata_port scsi_rescan_task to be
> a delayed work instead of a simple work_struct. ata_scsi_dev_rescan() is
> modified to check if the SCSI device associated with the ATA device that
> must be rescanned is not suspended. If the SCSI device is still
> suspended, ata_scsi_dev_rescan() returns early and reschedule itself for
> execution after an arbitrary delay of 5ms.
> 
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Joe Breuer <linux-kernel@jmbreuer.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217530
> Fixes: a19a93e4c6a9 ("scsi: core: pm: Rely on the device driver core for async power management")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c |  3 ++-
>   drivers/ata/libata-eh.c   |  2 +-
>   drivers/ata/libata-scsi.c | 22 +++++++++++++++++++++-
>   include/linux/libata.h    |  2 +-
>   4 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8bf612bdd61a..b4f246f0cac7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5348,7 +5348,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>   
>   	mutex_init(&ap->scsi_scan_mutex);
>   	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
> -	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
> +	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
>   	INIT_LIST_HEAD(&ap->eh_done_q);
>   	init_waitqueue_head(&ap->eh_wait_q);
>   	init_completion(&ap->park_req_pending);
> @@ -5954,6 +5954,7 @@ static void ata_port_detach(struct ata_port *ap)
>   	WARN_ON(!(ap->pflags & ATA_PFLAG_UNLOADED));
>   
>   	cancel_delayed_work_sync(&ap->hotplug_task);
> +	cancel_delayed_work_sync(&ap->scsi_rescan_task);
>   
>    skip_eh:
>   	/* clean up zpodd on port removal */
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index a6c901811802..6f8d14191593 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2984,7 +2984,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>   			ehc->i.flags |= ATA_EHI_SETMODE;
>   
>   			/* schedule the scsi_rescan_device() here */
> -			schedule_work(&(ap->scsi_rescan_task));
> +			schedule_delayed_work(&ap->scsi_rescan_task, 0);
>   		} else if (dev->class == ATA_DEV_UNKNOWN &&
>   			   ehc->tries[dev->devno] &&
>   			   ata_class_enabled(ehc->classes[dev->devno])) {
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 8ce90284eb34..551077cea4e4 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4597,10 +4597,11 @@ int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
>   void ata_scsi_dev_rescan(struct work_struct *work)
>   {
>   	struct ata_port *ap =
> -		container_of(work, struct ata_port, scsi_rescan_task);
> +		container_of(work, struct ata_port, scsi_rescan_task.work);
>   	struct ata_link *link;
>   	struct ata_device *dev;
>   	unsigned long flags;
> +	bool delay_rescan = false;
>   
>   	mutex_lock(&ap->scsi_scan_mutex);
>   	spin_lock_irqsave(ap->lock, flags);
> @@ -4614,6 +4615,21 @@ void ata_scsi_dev_rescan(struct work_struct *work)
>   			if (scsi_device_get(sdev))
>   				continue;
>   
> +			/*
> +			 * If the rescan work was scheduled because of a resume
> +			 * event, the port is already fully resumed, but the
> +			 * SCSI device may not yet be fully resumed. In such
> +			 * case, executing scsi_rescan_device() may cause a
> +			 * deadlock with the PM code on device_lock(). Prevent
> +			 * this by giving up and retrying rescan after a short
> +			 * delay.
> +			 */
> +			delay_rescan = sdev->sdev_gendev.power.is_suspended;
> +			if (delay_rescan) {
> +				scsi_device_put(sdev);
> +				break;
> +			}
> +
>   			spin_unlock_irqrestore(ap->lock, flags);
>   			scsi_rescan_device(&(sdev->sdev_gendev));
>   			scsi_device_put(sdev);
> @@ -4623,4 +4639,8 @@ void ata_scsi_dev_rescan(struct work_struct *work)
>   
>   	spin_unlock_irqrestore(ap->lock, flags);
>   	mutex_unlock(&ap->scsi_scan_mutex);
> +
> +	if (delay_rescan)
> +		schedule_delayed_work(&ap->scsi_rescan_task,
> +				      msecs_to_jiffies(5));
>   }
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 311cd93377c7..dd5797fb6305 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -836,7 +836,7 @@ struct ata_port {
>   
>   	struct mutex		scsi_scan_mutex;
>   	struct delayed_work	hotplug_task;
> -	struct work_struct	scsi_rescan_task;
> +	struct delayed_work	scsi_rescan_task;
>   
>   	unsigned int		hsm_task_state;
>   

Hehe. That is exactly what I had in mind.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

