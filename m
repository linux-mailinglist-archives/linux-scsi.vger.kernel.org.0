Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6122F0D3F
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Jan 2021 08:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbhAKHeE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jan 2021 02:34:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:50902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbhAKHeD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 11 Jan 2021 02:34:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BD77AD6A;
        Mon, 11 Jan 2021 07:33:22 +0000 (UTC)
Subject: Re: [PATCH v7 05/16] lpfc: vmid: Supplementary data structures for
 vmid and APIs
To:     Muneendra <muneendra.kumar@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
 <1609970430-19084-6-git-send-email-muneendra.kumar@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <91bb4afd-a7de-12eb-cd27-a0e5ec72c6d6@suse.de>
Date:   Mon, 11 Jan 2021 08:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1609970430-19084-6-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/6/21 11:00 PM, Muneendra wrote:
> From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> 
> This patch adds additional data structures for supporting the two
> versions of vmid implementation. First type uses app header while
> the other types uses priority tagging mechanism. These data
> structures are used mostly for ELS and CT commands for the
> two vmid implementation.
> 
> The API determines if VMID is enabled by the user or not.
> 
> Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v7:
> No change
> 
> v6:
> No change
> 
> v5:
> Merged the patch5 of v4 to this patch
> Uniform data type naming scheme
> 
> v4:
> No change
> 
> v3:
> No change
> 
> v2:
> Ported the patch on top of 5.10/scsi-queue
> ---
>   drivers/scsi/lpfc/lpfc.h      |  24 +++++++
>   drivers/scsi/lpfc/lpfc_disc.h |   1 +
>   drivers/scsi/lpfc/lpfc_hw.h   | 124 ++++++++++++++++++++++++++++++++--
>   drivers/scsi/lpfc/lpfc_sli.h  |   8 +++
>   4 files changed, 153 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
