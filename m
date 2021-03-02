Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F44732AA1F
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Mar 2021 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581582AbhCBS7N (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Mar 2021 13:59:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:51620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1575795AbhCBPoT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Mar 2021 10:44:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 969DEAC24;
        Tue,  2 Mar 2021 15:31:09 +0000 (UTC)
Subject: Re: [PATCH v5 09/31] elx: libefc: Emulex FC discovery library APIs
 and definitions
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>
References: <20210103171134.39878-1-jsmart2021@gmail.com>
 <20210103171134.39878-10-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <cb10627d-e5ee-7e6c-f156-b1ce9d834b38@suse.de>
Date:   Tue, 2 Mar 2021 16:31:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210103171134.39878-10-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/3/21 6:11 PM, James Smart wrote:
> This patch continues the libefc library population.
> 
> This patch adds library interface definitions for:
> - SLI/Local FC port objects
> - efc_domain_s: FC domain (aka fabric) objects
> - efc_node_s: FC node (aka remote ports) objects
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v5:
>   Added Mempool for ELS ios.
>   Remove EFC_HW_NODE_XXX and EFC_HW_NPORT_XXX events.
>   Use EFC_EVT_XXX events directly for port and node callbacks.
> ---
>   drivers/scsi/elx/libefc/efc.h     |  69 ++++
>   drivers/scsi/elx/libefc/efc_lib.c |  81 ++++
>   drivers/scsi/elx/libefc/efclib.h  | 601 ++++++++++++++++++++++++++++++
>   3 files changed, 751 insertions(+)
>   create mode 100644 drivers/scsi/elx/libefc/efc.h
>   create mode 100644 drivers/scsi/elx/libefc/efc_lib.c
>   create mode 100644 drivers/scsi/elx/libefc/efclib.h
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
