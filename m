Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A3FDF8BA
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Oct 2019 01:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfJUXox (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 19:44:53 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52798 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUXox (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Oct 2019 19:44:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 297D829E51;
        Mon, 21 Oct 2019 19:44:49 -0400 (EDT)
Date:   Tue, 22 Oct 2019 10:44:47 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Hannes Reinecke <hare@suse.de>
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 13/24] scsi: Kill DRIVER_SENSE
In-Reply-To: <20191021095322.137969-14-hare@suse.de>
Message-ID: <alpine.LNX.2.21.1910221034331.14@nippy.intranet>
References: <20191021095322.137969-1-hare@suse.de> <20191021095322.137969-14-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index c40fbea06cc5..649f9610ca72 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -1,3 +1,4 @@
> +
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *  Linux MegaRAID driver for SAS based RAID controllers

Typo?

> index 59443e0184fd..d6ecb773c512 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -203,8 +203,8 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
>  	 * If we have valid sense information, then some kind of recovery
>  	 * must have taken place.  Make a note of this.
>  	 */
> -	if (SCSI_SENSE_VALID(cmd))
> -		cmd->result |= (DRIVER_SENSE << 24);
> +	if (SCSI_SENSE_VALID(cmd) && status_byte(cmd->result) == SAM_STAT_GOOD)
> +		set_status_byte(cmd, SAM_STAT_CHECK_CONDITION);

This means that a REQUEST SENSE command can never result in SAM_STAT_GOOD, 
right? Are there implications for higher layers?

-- 
