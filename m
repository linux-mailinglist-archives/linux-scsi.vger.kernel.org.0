Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA35917A5B5
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Mar 2020 13:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCEMwr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 5 Mar 2020 07:52:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:32826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgCEMwr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 5 Mar 2020 07:52:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70B43B2AF;
        Thu,  5 Mar 2020 12:52:45 +0000 (UTC)
Subject: Re: [PATCH RFC v6 07/10] scsi: hisi_sas: Switch v3 hw to MQ
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        ming.lei@redhat.com, bvanassche@acm.org, don.brace@microsemi.com,
        sumit.saxena@broadcom.com, hch@infradead.org,
        kashyap.desai@broadcom.com, shivasharan.srikanteshwara@broadcom.com
Cc:     chenxiang66@hisilicon.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com
References: <1583409280-158604-1-git-send-email-john.garry@huawei.com>
 <1583409280-158604-8-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ae175f51-3ca4-2413-5854-41bfac325a90@suse.de>
Date:   Thu, 5 Mar 2020 13:52:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583409280-158604-8-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 3/5/20 12:54 PM, John Garry wrote:
> Now that the block layer provides a shared tag, we can switch the driver
> to expose all HW queues.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas.h       |  3 +-
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 36 ++++++-----
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 87 +++++++++++---------------
>   3 files changed, 56 insertions(+), 70 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
