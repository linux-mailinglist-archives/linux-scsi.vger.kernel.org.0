Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8957D36A084
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Apr 2021 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhDXJV5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 24 Apr 2021 05:21:57 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52338 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhDXJV4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 24 Apr 2021 05:21:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2296322830;
        Sat, 24 Apr 2021 05:21:16 -0400 (EDT)
Date:   Sat, 24 Apr 2021 19:21:19 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Hannes Reinecke <hare@suse.de>
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 35/39] fdomain: translate message to host byte status
In-Reply-To: <20210423113944.42672-36-hare@suse.de>
Message-ID: <2c47aede-3da6-33d7-60f-374144845248@nippy.intranet>
References: <20210423113944.42672-1-hare@suse.de> <20210423113944.42672-36-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 23 Apr 2021, Hannes Reinecke wrote:

> Instead of setting the message byte translate it to the appropriate
> host byte. As error recovery would return DID_ERROR for any non-zero
> message byte the translation doesn't change the error handling.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/scsi/fdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
> index 294dbfa5c761..2b946cb02693 100644
> --- a/drivers/scsi/fdomain.c
> +++ b/drivers/scsi/fdomain.c
> @@ -361,8 +361,8 @@ static void fdomain_work(struct work_struct *work)
>  
>  	if (done) {
>  		set_status_byte(cmd, cmd->SCp.Status);
> -		set_msg_byte(cmd, cmd->SCp.Message);
>  		set_host_byte(cmd, DID_OK);
> +		translate_msg_byte(cmd, cmd->SCp. Message);

There's an extra space character here.
