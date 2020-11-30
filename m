Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A62C80CA
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Nov 2020 10:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgK3JSf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Nov 2020 04:18:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:44260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgK3JSf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 30 Nov 2020 04:18:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A399EAC6A;
        Mon, 30 Nov 2020 09:17:53 +0000 (UTC)
Date:   Mon, 30 Nov 2020 10:17:53 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     trix@redhat.com
Cc:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, GR-QLogic-Storage-Upstream@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: remove trailing semicolon in macro
 definition
Message-ID: <20201130091753.4wyrzlbrqszdzy6s@beryllium.lan>
References: <20201127182741.2801597-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127182741.2801597-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Tom,

On Fri, Nov 27, 2020 at 10:27:41AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The macro use will already have a semicolon.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

> ---
>  drivers/scsi/qla2xxx/qla_def.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
> index ed9b10f8537d..86d249551b2d 100644
> --- a/drivers/scsi/qla2xxx/qla_def.h
> +++ b/drivers/scsi/qla2xxx/qla_def.h
> @@ -4970,7 +4970,7 @@ struct secure_flash_update_block_pk {
>  } while (0)
>  
>  #define QLA_QPAIR_MARK_NOT_BUSY(__qpair)		\
> -	atomic_dec(&__qpair->ref_count);		\
> +	atomic_dec(&__qpair->ref_count)		\

Nitpick, please insert an additional tab after the remove so that the
backlashes align again.

Thanks,
Daniel
