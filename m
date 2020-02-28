Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BF173329
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Feb 2020 09:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1IpN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 03:45:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:60418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1IpN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Feb 2020 03:45:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A5479ABF4;
        Fri, 28 Feb 2020 08:45:11 +0000 (UTC)
Subject: Re: [PATCH v7 20/38] sg: sg_find_srp_by_id
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20200227165902.11861-1-dgilbert@interlog.com>
 <20200227165902.11861-21-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f6277717-dd6f-dce6-9f20-1c4e0fc4b90b@suse.de>
Date:   Fri, 28 Feb 2020 09:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227165902.11861-21-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2/27/20 5:58 PM, Douglas Gilbert wrote:
> Replace sg_get_rq_mark() with sg_find_srp_by_id() and
> sg_get_ready_srp(). Add sg_chk_mmap() to check flags and
> reserve buffer available for mmap() based requests. Add
> sg_copy_sense() and sg_rec_state_v3() which is just
> refactoring. Add sg_calc_rq_dur() and sg_get_dur() in
> preparation for optional nanosecond duration timing.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>   drivers/scsi/sg.c | 286 +++++++++++++++++++++++++++++++---------------
>   1 file changed, 197 insertions(+), 89 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
