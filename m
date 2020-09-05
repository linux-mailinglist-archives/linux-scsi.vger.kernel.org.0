Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404DD25E9B8
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Sep 2020 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIEShf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Sep 2020 14:37:35 -0400
Received: from smtp.infotech.no ([82.134.31.41]:59022 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgIEShe (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 5 Sep 2020 14:37:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id D99D6204190;
        Sat,  5 Sep 2020 20:37:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TpmWNB9h-DRM; Sat,  5 Sep 2020 20:37:25 +0200 (CEST)
Received: from [192.168.48.23] (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id D2B6E20415B;
        Sat,  5 Sep 2020 20:37:23 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 1/4] scsi: sg: fix BLKSECTGET ioctl
To:     Tom Yan <tom.ty89@gmail.com>, linux-scsi@vger.kernel.org
Cc:     stern@rowland.harvard.edu, James.Bottomley@SteelEye.com,
        akinobu.mita@gmail.com, hch@lst.de, jens.axboe@oracle.com
References: <CAGnHSE=fY2wkzNeZTSHC37Sp-uD4D8YMEb7LesDkPcQWAfiK=w@mail.gmail.com>
 <20200904200554.168979-1-tom.ty89@gmail.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <721c612e-d1c1-598d-793e-28b0ab2185c0@interlog.com>
Date:   Sat, 5 Sep 2020 14:37:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904200554.168979-1-tom.ty89@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-09-04 4:05 p.m., Tom Yan wrote:
> It should give out the maximum number of sectors per request
> instead of maximum number of bytes.
> 
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

> ---
>   drivers/scsi/sg.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 20472aaaf630..e57831910228 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -922,6 +922,7 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
>   	int result, val, read_only;
>   	Sg_request *srp;
>   	unsigned long iflags;
> +	unsigned int max_sectors;
>   
>   	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
>   				   "sg_ioctl: cmd=0x%x\n", (int) cmd_in));
> @@ -1114,8 +1115,9 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
>   		sdp->sgdebug = (char) val;
>   		return 0;
>   	case BLKSECTGET:
> -		return put_user(max_sectors_bytes(sdp->device->request_queue),
> -				ip);
> +		max_sectors = min_t(unsigned int, USHRT_MAX,
> +				    queue_max_sectors(sdp->device->request_queue));
> +		return put_user(max_sectors, ip);
>   	case BLKTRACESETUP:
>   		return blk_trace_setup(sdp->device->request_queue,
>   				       sdp->disk->disk_name,
> 

