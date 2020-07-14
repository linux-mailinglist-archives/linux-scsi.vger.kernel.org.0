Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8BF21E93B
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2020 09:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGNHFJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jul 2020 03:05:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgGNHFC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Jul 2020 03:05:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0E7EB86E;
        Tue, 14 Jul 2020 07:05:02 +0000 (UTC)
Subject: Re: [PATCH v2 11/29] scsi: libfc: fc_rport: Fix a couple of
 misdocumented function parameters
To:     Lee Jones <lee.jones@linaro.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20200713074645.126138-1-lee.jones@linaro.org>
 <20200713074645.126138-12-lee.jones@linaro.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3b98e5b9-412d-90c9-cd04-4844c645c774@suse.de>
Date:   Tue, 14 Jul 2020 09:04:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713074645.126138-12-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/13/20 9:46 AM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/scsi/libfc/fc_rport.c:129: warning: Function parameter or member 'port_id' not described in 'fc_rport_create'
>   drivers/scsi/libfc/fc_rport.c:129: warning: Excess function parameter 'ids' description in 'fc_rport_create'
>   drivers/scsi/libfc/fc_rport.c:1452: warning: Function parameter or member 'rdata_arg' not described in 'fc_rport_logo_resp'
>   drivers/scsi/libfc/fc_rport.c:1452: warning: Excess function parameter 'lport_arg' description in 'fc_rport_logo_resp'
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/scsi/libfc/fc_rport.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
> index 278d15ff1c5ae..18663a82865f9 100644
> --- a/drivers/scsi/libfc/fc_rport.c
> +++ b/drivers/scsi/libfc/fc_rport.c
> @@ -121,7 +121,7 @@ EXPORT_SYMBOL(fc_rport_lookup);
>   /**
>    * fc_rport_create() - Create a new remote port
>    * @lport: The local port this remote port will be associated with
> - * @ids:   The identifiers for the new remote port
> + * @port_id:   The identifiers for the new remote port
>    *
>    * The remote port will start in the INIT state.
>    */
> @@ -1445,7 +1445,7 @@ static void fc_rport_recv_rtv_req(struct fc_rport_priv *rdata,
>    * fc_rport_logo_resp() - Handler for logout (LOGO) responses
>    * @sp:	       The sequence the LOGO was on
>    * @fp:	       The LOGO response frame
> - * @lport_arg: The local port
> + * @rdata_arg: The remote port
>    */
>   static void fc_rport_logo_resp(struct fc_seq *sp, struct fc_frame *fp,
>   			       void *rdata_arg)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
