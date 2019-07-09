Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76863A9F
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfGISNC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jul 2019 14:13:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbfGISNC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 9 Jul 2019 14:13:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9934A30C5844;
        Tue,  9 Jul 2019 18:13:02 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E76FD117665;
        Tue,  9 Jul 2019 18:13:01 +0000 (UTC)
Message-ID: <9268b317de25f98f7c6b5bce885ed3a4e94f74c1.camel@redhat.com>
Subject: Re: [PATCH] scsi: use scmd_printk() to print which command timed out
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Maurizio Lombardi <mlombard@redhat.com>, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Date:   Tue, 09 Jul 2019 14:13:00 -0400
In-Reply-To: <20190702112705.30458-1-mlombard@redhat.com>
References: <20190702112705.30458-1-mlombard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Jul 2019 18:13:02 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2019-07-02 at 13:27 +0200, Maurizio Lombardi wrote:
> With a possibly faulty disk the following messages may appear in the logs:
> 
> kernel: sd 0:0:9:0: timing out command, waited 180s
> kernel: sd 0:0:9:0: timing out command, waited 20s
> kernel: sd 0:0:9:0: timing out command, waited 20s
> kernel: sd 0:0:9:0: timing out command, waited 60s
> kernel: sd 0:0:9:0: timing out command, waited 20s
> 
> This is not very informative because it's not possible to identify
> the command that timed out.
> 
> This patch replaces sdev_printk() with scmd_printk().
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/scsi/scsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index f6437b98296b..97ed233fa469 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1501,7 +1501,7 @@ static void scsi_softirq_done(struct request *rq)
>  	disposition = scsi_decide_disposition(cmd);
>  	if (disposition != SUCCESS &&
>  	    time_before(cmd->jiffies_at_alloc + wait_for, jiffies)) {
> -		sdev_printk(KERN_ERR, cmd->device,
> +		scmd_printk(KERN_ERR, cmd,
>  			    "timing out command, waited %lus\n",
>  			    wait_for/HZ);
>  		disposition = SUCCESS;

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

