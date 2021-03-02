Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25F432AA1D
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Mar 2021 20:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581578AbhCBS7L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Mar 2021 13:59:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:40374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347838AbhCBP2X (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71F8AAC24;
        Tue,  2 Mar 2021 15:27:31 +0000 (UTC)
Subject: Re: [PATCH v5 04/31] elx: libefc_sli: queue create/destroy/parse
 routines
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>
References: <20210103171134.39878-1-jsmart2021@gmail.com>
 <20210103171134.39878-5-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5fe46cc2-f3cd-2e32-02f0-10d22a441679@suse.de>
Date:   Tue, 2 Mar 2021 16:27:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210103171134.39878-5-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/3/21 6:11 PM, James Smart wrote:
> This patch continues the libefc_sli SLI-4 library population.
> 
> This patch adds service routines to create mailbox commands
> and adds APIs to create/destroy/parse SLI-4 EQ, CQ, RQ and MQ queues.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v5:
>   Remove efc_log_test.
> ---
>   drivers/scsi/elx/include/efc_common.h |   16 +
>   drivers/scsi/elx/libefc_sli/sli4.c    | 1363 +++++++++++++++++++++++++
>   drivers/scsi/elx/libefc_sli/sli4.h    |    9 +
>   3 files changed, 1388 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
