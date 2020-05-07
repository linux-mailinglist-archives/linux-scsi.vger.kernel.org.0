Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B51C8623
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEGJvV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 05:51:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:59290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgEGJvU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 May 2020 05:51:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BD77AFFD;
        Thu,  7 May 2020 09:51:22 +0000 (UTC)
Subject: Re: [PATCH 9/9] lpfc: Update lpfc version to 12.8.0.1
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>
References: <20200501214310.91713-1-jsmart2021@gmail.com>
 <20200501214310.91713-10-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9d099c6d-2e81-6d19-f4c2-4c28013081cb@suse.de>
Date:   Thu, 7 May 2020 11:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501214310.91713-10-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/1/20 11:43 PM, James Smart wrote:
> Update lpfc version to 12.8.0.1
> 
> Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_version.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
> index ca40c47cfbe0..ab0bc26c098d 100644
> --- a/drivers/scsi/lpfc/lpfc_version.h
> +++ b/drivers/scsi/lpfc/lpfc_version.h
> @@ -20,7 +20,7 @@
>    * included with this package.                                     *
>    *******************************************************************/
>   
> -#define LPFC_DRIVER_VERSION "12.8.0.0"
> +#define LPFC_DRIVER_VERSION "12.8.0.1"
>   #define LPFC_DRIVER_NAME		"lpfc"
>   
>   /* Used for SLI 2/3 */
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
