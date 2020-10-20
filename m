Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C05292E3B
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Oct 2020 21:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgJSTNu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Oct 2020 15:13:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbgJSTNu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 19 Oct 2020 15:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0617AB5C;
        Mon, 19 Oct 2020 19:13:48 +0000 (UTC)
Subject: Re: [PATCH v4 06/31] elx: libefc_sli: bmbx routines and SLI config
 commands
To:     James Smart <james.smart@broadcom.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>
References: <20201012225147.54404-1-james.smart@broadcom.com>
 <20201012225147.54404-7-james.smart@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <db985fd4-31ca-0d0e-cb62-e88e455a11d8@suse.de>
Date:   Mon, 19 Oct 2020 21:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012225147.54404-7-james.smart@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/13/20 12:51 AM, James Smart wrote:
> This patch continues the libefc_sli SLI-4 library population.
> 
> This patch adds routines to create mailbox commands used during
> adapter initialization and adds APIs to issue mailbox commands to the
> adapter through the bootstrap mailbox register.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <james.smart@broadcom.com>
> 
> ---
> v4:
>    Changed bmbx_wait and fw_ready routines to use usleep_range and
>       time_before apis
>    Removed size input for all the cmds as its fixed to SLI4_BMBX_SIZE.
> ---
>   drivers/scsi/elx/libefc_sli/sli4.c | 1167 ++++++++++++++++++++++++++++
>   1 file changed, 1167 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
