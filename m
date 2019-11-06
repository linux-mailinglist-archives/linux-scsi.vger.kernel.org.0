Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951ECF211D
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Nov 2019 22:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfKFVxD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Nov 2019 16:53:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:37146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726817AbfKFVxD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 6 Nov 2019 16:53:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A164AED5;
        Wed,  6 Nov 2019 21:53:01 +0000 (UTC)
Message-ID: <153c884477426611dcde3407b164ed7dae64aab8.camel@suse.de>
Subject: Re: [PATCH 1/2] qla2xxx: Remove an include directive
From:   Martin Wilck <mwilck@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>
Date:   Wed, 06 Nov 2019 22:53:31 +0100
In-Reply-To: <20191106044226.5207-2-bvanassche@acm.org>
References: <20191106044226.5207-1-bvanassche@acm.org>
         <20191106044226.5207-2-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2019-11-05 at 20:42 -0800, Bart Van Assche wrote:
> Since the code in qla_init.c is initiator code, remove the SCSI
> target
> core include directive.
> 
> Cc: Himanshu Madhani <hmadhani@marvell.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/qla2xxx/qla_init.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_init.c
> b/drivers/scsi/qla2xxx/qla_init.c
> index 7cb7545de962..c1004d47514c 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c
> @@ -17,7 +17,6 @@
>  #include <asm/prom.h>
>  #endif
>  
> -#include <target/target_core_base.h>
>  #include "qla_target.h"
>  
>  /*

Reviewed-by: Martin Wilck <mwilck@suse.com>


