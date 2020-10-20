Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7E293457
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 07:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbgJTFmb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 01:42:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbgJTFma (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 01:42:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD977B26B;
        Tue, 20 Oct 2020 05:42:29 +0000 (UTC)
Subject: Re: [PATCH v4 10/31] elx: libefc: FC Domain state machine interfaces
To:     James Smart <james.smart@broadcom.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>
References: <20201012225147.54404-1-james.smart@broadcom.com>
 <20201012225147.54404-11-james.smart@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <63779bd9-bd4d-8615-78e8-071c25e33f7e@suse.de>
Date:   Tue, 20 Oct 2020 07:42:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012225147.54404-11-james.smart@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/13/20 12:51 AM, James Smart wrote:
> This patch continues the libefc library population.
> 
> This patch adds library interface definitions for:
> - FC Domain registration, allocation and deallocation sequence
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <james.smart@broadcom.com>
> 
> ---
> v4:
>    Changes to use new function template
>    Get Domain Ref count when a new nport is added. Release domain ref when
>       nport is freed.
> ---
>   drivers/scsi/elx/libefc/efc_domain.c | 1095 ++++++++++++++++++++++++++
>   drivers/scsi/elx/libefc/efc_domain.h |   54 ++
>   2 files changed, 1149 insertions(+)
>   create mode 100644 drivers/scsi/elx/libefc/efc_domain.c
>   create mode 100644 drivers/scsi/elx/libefc/efc_domain.h
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
