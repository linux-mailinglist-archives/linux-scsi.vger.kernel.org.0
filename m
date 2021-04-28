Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647B136D2C5
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Apr 2021 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhD1HId (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Apr 2021 03:08:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhD1HId (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 28 Apr 2021 03:08:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B059AEA6;
        Wed, 28 Apr 2021 07:07:48 +0000 (UTC)
Subject: Re: [PATCH v18 43/83] sg: no_dxfer: move to/from kernel buffers
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20210427215733.417746-1-dgilbert@interlog.com>
 <20210427215733.417746-45-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <939470fc-6867-3a8a-b0df-ebaebf7ac050@suse.de>
Date:   Wed, 28 Apr 2021 09:07:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210427215733.417746-45-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/27/21 11:56 PM, Douglas Gilbert wrote:
> When the NO_DXFER flag is use on a command/request, the data-in
> and data-out buffers (if present) should not be ignored. Add
> sg_rq_map_kern() function to handle this. Uses a single bio with
> multiple bvec_s usually each holding multiple pages, if necessary.
> The driver default element size is 32 KiB so if PAGE_SIZE is 4096
> then get_order()==3 .
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>  drivers/scsi/sg.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
