Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E56292E63
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Oct 2020 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgJSTXN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Oct 2020 15:23:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbgJSTXN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 19 Oct 2020 15:23:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60B13AC55;
        Mon, 19 Oct 2020 19:23:12 +0000 (UTC)
Subject: Re: [PATCH v4 07/31] elx: libefc_sli: APIs to setup SLI library
To:     James Smart <james.smart@broadcom.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>
References: <20201012225147.54404-1-james.smart@broadcom.com>
 <20201012225147.54404-8-james.smart@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <541dd665-ddb9-1052-dcd8-e9cec86d111d@suse.de>
Date:   Mon, 19 Oct 2020 21:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012225147.54404-8-james.smart@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/13/20 12:51 AM, James Smart wrote:
> This patch continues the libefc_sli SLI-4 library population.
> 
> This patch adds APIS to initialize the library, initialize
> the SLI Port, reset firmware, terminate the SLI Port, and
> terminate the library.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <james.smart@broadcom.com>
> 
> ---
> v4:
>    Changed all SLI mbox routines to memset using SLI_BMBX_SIZE.
>    All WQE helper routines to use sli->wqe_size for memset.
> ---
>   drivers/scsi/elx/libefc_sli/sli4.c | 1135 ++++++++++++++++++++++++++++
>   drivers/scsi/elx/libefc_sli/sli4.h |  396 ++++++++++
>   2 files changed, 1531 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
