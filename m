Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6622811318
	for <lists+linux-scsi@lfdr.de>; Thu,  2 May 2019 08:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfEBGGY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 May 2019 02:06:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbfEBGGY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 2 May 2019 02:06:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 731DDAF81;
        Thu,  2 May 2019 06:06:23 +0000 (UTC)
Subject: Re: [PATCH 23/24] st: add a SPDX tag to st.c
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
 <20190501161417.32592-24-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d488ea80-ed62-ab0b-0e6e-48e14b1e1027@suse.de>
Date:   Thu, 2 May 2019 08:06:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501161417.32592-24-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/1/19 6:14 PM, Christoph Hellwig wrote:
> st.c is the only st file missing licensing information.  Add a
> GPLv2 tag for the default kernel license.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/st.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
> index 19c022e66d63..b814906af0a3 100644
> --- a/drivers/scsi/st.c
> +++ b/drivers/scsi/st.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>      SCSI Tape Driver for Linux version 1.1 and newer. See the accompanying
>      file Documentation/scsi/st.txt for more information.
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
