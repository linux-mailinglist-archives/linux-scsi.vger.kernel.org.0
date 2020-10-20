Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48629351C
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 08:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbgJTGnE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 02:43:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:58060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404344AbgJTGnE (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 02:43:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1AA3AF06;
        Tue, 20 Oct 2020 06:43:02 +0000 (UTC)
Subject: Re: [PATCH v4 19/31] elx: efct: Hardware queues creation and deletion
To:     James Smart <james.smart@broadcom.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>
References: <20201012225147.54404-1-james.smart@broadcom.com>
 <20201012225147.54404-20-james.smart@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a21c86ab-cfba-c9dd-9fb1-f940d5008162@suse.de>
Date:   Tue, 20 Oct 2020 08:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012225147.54404-20-james.smart@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/13/20 12:51 AM, James Smart wrote:
> This patch continues the efct driver population.
> 
> This patch adds driver definitions for:
> Routines for queue creation, deletion, and configuration.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <james.smart@broadcom.com>
> 
> ---
> v4:
>    Changes for MRQ support.
>    Mbox request API.
> ---
>   drivers/scsi/elx/efct/efct_hw.h        |   4 +
>   drivers/scsi/elx/efct/efct_hw_queues.c | 677 +++++++++++++++++++++++++
>   2 files changed, 681 insertions(+)
>   create mode 100644 drivers/scsi/elx/efct/efct_hw_queues.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
