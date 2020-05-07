Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F0B1C861C
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgEGJuj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 05:50:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgEGJuj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 May 2020 05:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE361AFFB;
        Thu,  7 May 2020 09:50:40 +0000 (UTC)
Subject: Re: [PATCH 7/9] lpfc: Fix noderef and address space warnings
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>
References: <20200501214310.91713-1-jsmart2021@gmail.com>
 <20200501214310.91713-8-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3e980e09-7fd8-a754-2cda-0557470bd442@suse.de>
Date:   Thu, 7 May 2020 11:50:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501214310.91713-8-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/1/20 11:43 PM, James Smart wrote:
> Running make C=1 M=drivers/scsi/lpfc triggers sparse warnings
> 
> Correct the code generating the following errors:
> - Incompatible address space assignment without proper conversion.
> - Deference of usespace and per cpu pointers.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_debugfs.c | 3 ++-
>   drivers/scsi/lpfc/lpfc_mbox.c    | 3 ++-
>   drivers/scsi/lpfc/lpfc_sli.c     | 8 ++++----
>   3 files changed, 8 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
