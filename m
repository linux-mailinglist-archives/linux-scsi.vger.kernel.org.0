Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77132AA24
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Mar 2021 20:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581599AbhCBS7T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Mar 2021 13:59:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:36928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1839691AbhCBQhv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3CF2AE79;
        Tue,  2 Mar 2021 16:37:07 +0000 (UTC)
Subject: Re: [PATCH v5 15/31] elx: libefc: Extended link Service IO handling
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>
References: <20210103171134.39878-1-jsmart2021@gmail.com>
 <20210103171134.39878-16-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <28cedfd0-fb84-9e3c-ff1b-66be408d293e@suse.de>
Date:   Tue, 2 Mar 2021 17:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210103171134.39878-16-jsmart2021@gmail.com>
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
> Functions to build and send ELS/CT/BLS commands and responses.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v5:
>   ELS IO mempool changes.
> ---
>   drivers/scsi/elx/libefc/efc_els.c | 1131 +++++++++++++++++++++++++++++
>   drivers/scsi/elx/libefc/efc_els.h |  107 +++
>   2 files changed, 1238 insertions(+)
>   create mode 100644 drivers/scsi/elx/libefc/efc_els.c
>   create mode 100644 drivers/scsi/elx/libefc/efc_els.h
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
