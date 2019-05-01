Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529CB10628
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfEAIds (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 04:33:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfEAIds (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 1 May 2019 04:33:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F07D3ABD5;
        Wed,  1 May 2019 08:33:46 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] sd: Rely on the driver core for asynchronous
 probing
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>, Lee Duncan <lduncan@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190430213919.97437-1-bvanassche@acm.org>
 <20190430213919.97437-2-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <06c688dc-e500-6030-28e8-07a1eac4e380@suse.com>
Date:   Wed, 1 May 2019 10:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430213919.97437-2-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/30/19 11:39 PM, Bart Van Assche wrote:
> As explained during the 2018 LSF/MM session about increasing SCSI disk
> probing concurrency, the problems with the current probing approach are as
> follows:
> 
> - The driver core is unaware of asynchronous SCSI LUN probing.
>    wait_for_device_probe() waits for all asynchronous probes except
>    asynchronous SCSI disk probes.
> 
> - There is unnecessary serialization between sd_probe() and sd_remove().
>    This can lead to a deadlock.
> 
> Hence this patch that modifies the sd driver such that it uses the driver
> core framework for asynchronous probing. The async domain and
> get_device()/put_device() pairs that became superfluous due to this change
> are removed.
> 
> This patch does not affect the time needed for loading the scsi_debug
> kernel module with parameters delay=0 and max_luns=256.
> 
> This patch depends on commit ef0ff68351be ("driver core: Probe devices
> asynchronously instead of the driver") that went upstream in kernel version
> v5.1-rc1.
> 
> Cc: Lee Duncan <lduncan@suse.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/scsi.c      | 12 +++---------
>   drivers/scsi/scsi_pm.c   |  6 +-----
>   drivers/scsi/scsi_priv.h |  1 -
>   drivers/scsi/sd.c        | 12 +++---------
>   4 files changed, 7 insertions(+), 24 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
