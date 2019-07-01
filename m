Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D21130D
	for <lists+linux-scsi@lfdr.de>; Thu,  2 May 2019 08:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEBGFj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 May 2019 02:05:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:34988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfEBGFj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 2 May 2019 02:05:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D62BAF8F;
        Thu,  2 May 2019 06:05:38 +0000 (UTC)
Subject: Re: [PATCH 20/24] ses: switch to SPDX tags
To:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20190501161417.32592-1-hch@lst.de>
 <20190501161417.32592-21-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <84efdea2-1dec-41f6-717a-97415b2c8822@suse.de>
Date:   Thu, 2 May 2019 08:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501161417.32592-21-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/1/19 6:14 PM, Christoph Hellwig wrote:
> Use the the GPLv2 SPDX tag instead of verbose boilerplate text.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/ses.c | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
> index 0fc39224ce1e..8afea5a1d3f0 100644
> --- a/drivers/scsi/ses.c
> +++ b/drivers/scsi/ses.c
> @@ -1,25 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * SCSI Enclosure Services
>    *
>    * Copyright (C) 2008 James Bottomley <James.Bottomley@HansenPartnership.com>
> - *
> -**-----------------------------------------------------------------------------
> -**
> -**  This program is free software; you can redistribute it and/or
> -**  modify it under the terms of the GNU General Public License
> -**  version 2 as published by the Free Software Foundation.
> -**
> -**  This program is distributed in the hope that it will be useful,
> -**  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -**  GNU General Public License for more details.
> -**
> -**  You should have received a copy of the GNU General Public License
> -**  along with this program; if not, write to the Free Software
> -**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> -**
> -**-----------------------------------------------------------------------------
> -*/
> + */
>   
>   #include <linux/slab.h>
>   #include <linux/module.h>
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
