Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB233322E8
	for <lists+linux-scsi@lfdr.de>; Sun,  2 Jun 2019 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfFBKPm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 2 Jun 2019 06:15:42 -0400
Received: from ozlabs.org ([203.11.71.1]:49641 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfFBKPm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 2 Jun 2019 06:15:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45GvG369hPz9s7h;
        Sun,  2 Jun 2019 20:15:39 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvscsi: Don't use rc uninitialized in ibmvscsi_do_work
In-Reply-To: <20190531185306.41290-1-natechancellor@gmail.com>
References: <20190531185306.41290-1-natechancellor@gmail.com>
Date:   Sun, 02 Jun 2019 20:15:38 +1000
Message-ID: <87blzgnvhx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Nathan,

Nathan Chancellor <natechancellor@gmail.com> writes:
> clang warns:
>
> drivers/scsi/ibmvscsi/ibmvscsi.c:2126:7: warning: variable 'rc' is used
> uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>         case IBMVSCSI_HOST_ACTION_NONE:
>              ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvscsi.c:2151:6: note: uninitialized use occurs
> here
>         if (rc) {
>             ^~
>
> Initialize rc to zero so that the atomic_set and dev_err statement don't
> trigger for the cases that just break.
>
> Fixes: 035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action states")
> Link: https://github.com/ClangBuiltLinux/linux/issues/502
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvscsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index 727c31dc11a0..6714d8043e62 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -2118,7 +2118,7 @@ static unsigned long ibmvscsi_get_desired_dma(struct vio_dev *vdev)
>  static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
>  {
>  	unsigned long flags;
> -	int rc;
> +	int rc = 0;
>  	char *action = "reset";
>  
>  	spin_lock_irqsave(hostdata->host->host_lock, flags);

It's always preferable IMHO to keep any initialisation as localised as
possible, so that the compiler can continue to warn about uninitialised
usages elsewhere. In this case that would mean doing the rc = 0 in the
switch, something like:

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 727c31dc11a0..7ee5755cf636 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2123,9 +2123,6 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 
        spin_lock_irqsave(hostdata->host->host_lock, flags);
        switch (hostdata->action) {
-       case IBMVSCSI_HOST_ACTION_NONE:
-       case IBMVSCSI_HOST_ACTION_UNBLOCK:
-               break;
        case IBMVSCSI_HOST_ACTION_RESET:
                spin_unlock_irqrestore(hostdata->host->host_lock, flags);
                rc = ibmvscsi_reset_crq_queue(&hostdata->queue, hostdata);
@@ -2142,7 +2139,10 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
                if (!rc)
                        rc = ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0);
                break;
+       case IBMVSCSI_HOST_ACTION_NONE:
+       case IBMVSCSI_HOST_ACTION_UNBLOCK:
        default:
+               rc = 0;
                break;
        }


But then that makes me wonder if that's actually correct?

If we get an action that we don't recognise should we just throw it away
like that? (by doing hostdata->action = IBMVSCSI_HOST_ACTION_NONE). Tyrel?

cheers
