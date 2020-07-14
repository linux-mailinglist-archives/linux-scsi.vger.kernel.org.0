Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9B21E889
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2020 08:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgGNGro (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jul 2020 02:47:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgGNGro (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Jul 2020 02:47:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 315BFACC6;
        Tue, 14 Jul 2020 06:47:45 +0000 (UTC)
Subject: Re: [PATCH v2 01/29] scsi: libfc: fc_exch: Supply some missing
 kerneldoc struct/function attributes/params
To:     Lee Jones <lee.jones@linaro.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20200713074645.126138-1-lee.jones@linaro.org>
 <20200713074645.126138-2-lee.jones@linaro.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2256a33b-3fc7-d9e9-ecb5-5160c7525b14@suse.de>
Date:   Tue, 14 Jul 2020 08:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713074645.126138-2-lee.jones@linaro.org>
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
>   drivers/scsi/libfc/fc_exch.c:66: warning: Function parameter or member 'left' not described in 'fc_exch_pool'
>   drivers/scsi/libfc/fc_exch.c:66: warning: Function parameter or member 'right' not described in 'fc_exch_pool'
>   drivers/scsi/libfc/fc_exch.c:100: warning: Function parameter or member 'lport' not described in 'fc_exch_mgr'
>   drivers/scsi/libfc/fc_exch.c:727: warning: Function parameter or member 'ep' not described in 'fc_invoke_resp'
>   drivers/scsi/libfc/fc_exch.c:727: warning: Function parameter or member 'sp' not described in 'fc_invoke_resp'
>   drivers/scsi/libfc/fc_exch.c:727: warning: Function parameter or member 'fp' not described in 'fc_invoke_resp'
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/scsi/libfc/fc_exch.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
