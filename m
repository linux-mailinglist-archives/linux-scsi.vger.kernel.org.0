Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F40918CED
	for <lists+linux-scsi@lfdr.de>; Thu,  9 May 2019 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEIP0p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 May 2019 11:26:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfEIP0p (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 May 2019 11:26:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08E60ABB1;
        Thu,  9 May 2019 15:26:44 +0000 (UTC)
Subject: Re: [PATCH] scsi: myrs: Fix uninitialized variable
To:     YueHaibing <yuehaibing@huawei.com>, hare@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190509152247.26164-1-yuehaibing@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f57c9744-6208-cbc5-50eb-854d335b4d7f@suse.de>
Date:   Thu, 9 May 2019 17:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509152247.26164-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/9/19 5:22 PM, YueHaibing wrote:
> drivers/scsi/myrs.c: In function 'myrs_log_event':
> drivers/scsi/myrs.c:821:24: warning: 'sshdr.sense_key' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    struct scsi_sense_hdr sshdr;
> 
> If ev->ev_code is not 0x1C, sshdr.sense_key may
> be used uninitialized. Fix this by initializing
> variable 'sshdr' to 0.
> 
> Fixes: 77266186397c ("scsi: myrs: Add Mylex RAID controller (SCSI interface)")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/scsi/myrs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
> index b8d54ef..eb0dd56 100644
> --- a/drivers/scsi/myrs.c
> +++ b/drivers/scsi/myrs.c
> @@ -818,7 +818,7 @@ static void myrs_log_event(struct myrs_hba *cs, struct myrs_event *ev)
>   	unsigned char ev_type, *ev_msg;
>   	struct Scsi_Host *shost = cs->host;
>   	struct scsi_device *sdev;
> -	struct scsi_sense_hdr sshdr;
> +	struct scsi_sense_hdr sshdr = {0};
>   	unsigned char sense_info[4];
>   	unsigned char cmd_specific[4];
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
