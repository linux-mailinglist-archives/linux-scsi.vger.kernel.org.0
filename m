Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D471733B5
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Feb 2020 10:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgB1JVC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 04:21:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:51534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgB1JVC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Feb 2020 04:21:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 810F4AC92;
        Fri, 28 Feb 2020 09:21:00 +0000 (UTC)
Subject: Re: [PATCH v7 37/38] sg: warn v3 write system call users
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20200227165902.11861-1-dgilbert@interlog.com>
 <20200227165902.11861-38-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5129f3d1-add2-29e5-3431-1e7675e7061d@suse.de>
Date:   Fri, 28 Feb 2020 10:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227165902.11861-38-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2/27/20 5:59 PM, Douglas Gilbert wrote:
> Should generate one log message per kernel run when the write()
> system call is used with the sg interface version 3. Due to
> security concerns suggest that they use ioctl(SG_SUBMIT_v3)
> instead.
> 
> Sg interface version 1 or 2 based code may also be calling
> write() in this context. There is no easy solution for them
> (short of upgrading their interface to version 3 or 4), so
> don't produce a warning suggesting the conversion will be
> simple.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>   drivers/scsi/sg.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
