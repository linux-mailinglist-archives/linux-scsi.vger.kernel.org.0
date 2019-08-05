Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292E782275
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfHEQd2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 12:33:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbfHEQd2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 12:33:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C603C307D88D;
        Mon,  5 Aug 2019 16:33:27 +0000 (UTC)
Received: from [10.10.121.197] (ovpn-121-197.rdu2.redhat.com [10.10.121.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC3D5194B2;
        Mon,  5 Aug 2019 16:33:26 +0000 (UTC)
Subject: Re: [PATCH] scsi: target/tcm_loop: update upper limit of LUN
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20190805062313.343221-1-naohiro.aota@wdc.com>
Cc:     Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D485A56.9070208@redhat.com>
Date:   Mon, 5 Aug 2019 11:33:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190805062313.343221-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 05 Aug 2019 16:33:27 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 08/05/2019 01:23 AM, Naohiro Aota wrote:
> targetcli-fb (or its library: rtslib-fb) allows us to create LUN up to
> 65535. On the other hand, the kernel driver is limiting max_lun to 0.
> 
> This limitation causes an actual problem when you delete a loopback device
> (using /sys/class/scsi_device/${lun}/device/delete) and rescan it (using
> /sys/class/scsi_host/host${h}/scan). You can delete the device, but cannot
> rescan it because its LUN is larger than the max_lun and so the scan
> request results in -EINVAL error in scsi_scan_host_selected().

How are you kicking off this rescan?

Just to make sure I understood you, does the initial LU have LUN 0, you
delete that, then are you creating another LU with a LUN value that is
not 0?

Is it rtslib that is giving the new LU a LUN that is not 0?

> 
> This commit fix the upper limit to be as same as rtslib-fb allows.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  drivers/target/loopback/tcm_loop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
> index 3305b47fdf53..3db541ad727d 100644
> --- a/drivers/target/loopback/tcm_loop.c
> +++ b/drivers/target/loopback/tcm_loop.c
> @@ -336,10 +336,10 @@ static int tcm_loop_driver_probe(struct device *dev)
>  	 */
>  	*((struct tcm_loop_hba **)sh->hostdata) = tl_hba;
>  	/*
> -	 * Setup single ID, Channel and LUN for now..
> +	 * Setup single ID, and Channel for now..
>  	 */
>  	sh->max_id = 2;
> -	sh->max_lun = 0;
> +	sh->max_lun = 65536;
>  	sh->max_channel = 0;
>  	sh->max_cmd_len = SCSI_MAX_VARLEN_CDB_SIZE;
>  
> 

