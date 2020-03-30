Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2F1976FE
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2020 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgC3IuM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Mar 2020 04:50:12 -0400
Received: from mail.archive.org ([207.241.224.6]:47652 "EHLO mail.archive.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgC3IuM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 30 Mar 2020 04:50:12 -0400
Received: from mail.archive.org (localhost [127.0.0.1])
        by mail.archive.org (Postfix) with ESMTP id 001B720F8A;
        Mon, 30 Mar 2020 08:50:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.archive.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from [0.0.0.0] (a82-161-36-93.adsl.xs4all.nl [82.161.36.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: merlijn@archive.org)
        by mail.archive.org (Postfix) with ESMTPSA id 8965820EF6;
        Mon, 30 Mar 2020 08:50:10 +0000 (UTC)
Subject: Re: [PATCH] sr: Fix sr_block_release()
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        stable@kernel.org, simon@octiron.net
References: <20200330025151.10535-1-bvanassche@acm.org>
From:   "Merlijn B.W. Wajer" <merlijn@archive.org>
Message-ID: <ed0b6af3-94c3-c184-f3fc-e6181ac0e843@archive.org>
Date:   Mon, 30 Mar 2020 10:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200330025151.10535-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Envelope-From: <merlijn@archive.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

Oops, looks like Simon (CC) reported this earlier on too, missed that.

On 30/03/2020 04:51, Bart Van Assche wrote:
> This patch fixes the following two complaints:

Acked-By: Merlijn Wajer <merlijn@archive.org>

Cheers,
Merlijn

> 
> [snip]
> 
> Cc: Merlijn Wajer <merlijn@archive.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <stable@kernel.org>
> Fixes: 51a858817dcd ("scsi: sr: get rid of sr global mutex")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/sr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> index 0f1a926f6341..e8b2e014770c 100644
> --- a/drivers/scsi/sr.c
> +++ b/drivers/scsi/sr.c
> @@ -551,10 +551,12 @@ static int sr_block_open(struct block_device *bdev, fmode_t mode)
>  static void sr_block_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct scsi_cd *cd = scsi_cd(disk);
> +
>  	mutex_lock(&cd->lock);
>  	cdrom_release(&cd->cdi, mode);
> -	scsi_cd_put(cd);
>  	mutex_unlock(&cd->lock);
> +
> +	scsi_cd_put(cd);
>  }
>  
>  #ifndef CONFIG_COMPAT
> 
