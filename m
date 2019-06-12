Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56C742D76
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 19:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407682AbfFLR2g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 13:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406395AbfFLR2f (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 13:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAD6C550CF
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jun 2019 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-193.rdu2.redhat.com [10.10.124.193])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6552A1001B17
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jun 2019 17:28:35 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:28:33 -0700
From:   Chris Leech <cleech@redhat.com>
To:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] qedi: update driver version to 8.37.0.20
Message-ID: <20190612172833.GC16360@localhost.localdomain>
Mail-Followup-To: Chris Leech <cleech@redhat.com>,
        linux-scsi@vger.kernel.org
References: <20190612080542.17272-1-njavali@marvell.com>
 <20190612080542.17272-3-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612080542.17272-3-njavali@marvell.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 12 Jun 2019 17:28:35 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 12, 2019 at 01:05:42AM -0700, Nilesh Javali wrote:
> Update qedi driver version to 8.37.0.20
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>

Reviewed-by: Chris Leech <cleech@redhat.com>

> ---
>  drivers/scsi/qedi/qedi_version.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/qedi/qedi_version.h b/drivers/scsi/qedi/qedi_version.h
> index f56f0ba..0ac1055 100644
> --- a/drivers/scsi/qedi/qedi_version.h
> +++ b/drivers/scsi/qedi/qedi_version.h
> @@ -4,8 +4,8 @@
>   * Copyright (c) 2016 Cavium Inc.
>   */
>  
> -#define QEDI_MODULE_VERSION	"8.33.0.21"
> +#define QEDI_MODULE_VERSION	"8.37.0.20"
>  #define QEDI_DRIVER_MAJOR_VER		8
> -#define QEDI_DRIVER_MINOR_VER		33
> +#define QEDI_DRIVER_MINOR_VER		37
>  #define QEDI_DRIVER_REV_VER		0
> -#define QEDI_DRIVER_ENG_VER		21
> +#define QEDI_DRIVER_ENG_VER		20
> -- 
> 1.8.3.1
> 
