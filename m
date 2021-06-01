Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E439397462
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Jun 2021 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhFANfb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Jun 2021 09:35:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54548 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhFANex (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Jun 2021 09:34:53 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 442E91FD40;
        Tue,  1 Jun 2021 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622554390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAlwsesqw1LXjLjiTi841dpdgmr9KJoO7kF5C5YQHuY=;
        b=IPPe9DZsF30uyzd/wrb5X/q1CcSP4GECB44UYJM+WlO0DnFZhbUg5OGnWstPBg4GGvkIj+
        Lpzmldnw28SDXzofv4rIKpQgG7DMeu5Pce2ckXHDjm0o4xAS9MUw+XGag655hxeEPcQW8R
        GQOGroYeGI27py8trkRO4cS0s0+1QmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622554390;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAlwsesqw1LXjLjiTi841dpdgmr9KJoO7kF5C5YQHuY=;
        b=GFniMHrE5UPFaT7jJUvLFpzjq+MYKj8bb9M1g43NVYj40k/yIn1mdLmOQScf3mcZ+qYAtU
        64npeyxmSkqrJrDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2A08B118DD;
        Tue,  1 Jun 2021 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622554390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAlwsesqw1LXjLjiTi841dpdgmr9KJoO7kF5C5YQHuY=;
        b=IPPe9DZsF30uyzd/wrb5X/q1CcSP4GECB44UYJM+WlO0DnFZhbUg5OGnWstPBg4GGvkIj+
        Lpzmldnw28SDXzofv4rIKpQgG7DMeu5Pce2ckXHDjm0o4xAS9MUw+XGag655hxeEPcQW8R
        GQOGroYeGI27py8trkRO4cS0s0+1QmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622554390;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAlwsesqw1LXjLjiTi841dpdgmr9KJoO7kF5C5YQHuY=;
        b=GFniMHrE5UPFaT7jJUvLFpzjq+MYKj8bb9M1g43NVYj40k/yIn1mdLmOQScf3mcZ+qYAtU
        64npeyxmSkqrJrDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id LsjSCRY3tmBfCgAALh3uQQ
        (envelope-from <hare@suse.de>); Tue, 01 Jun 2021 13:33:10 +0000
Subject: Re: [PATCH v6 11/24] mpi3mr: print ioc info for debugging
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, sathya.prakash@broadcom.com
References: <20210520152545.2710479-1-kashyap.desai@broadcom.com>
 <20210520152545.2710479-12-kashyap.desai@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <445187f2-57aa-fd8c-04c2-056f3736165b@suse.de>
Date:   Tue, 1 Jun 2021 15:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520152545.2710479-12-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/20/21 5:25 PM, Kashyap Desai wrote:
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reviewed-by: Tomas Henzl <thenzl@redhat.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Cc: sathya.prakash@broadcom.com
> ---
>  drivers/scsi/mpi3mr/mpi3mr_fw.c | 95 +++++++++++++++++++++++++++++++++
>  drivers/scsi/mpi3mr/mpi3mr_os.c |  1 +
>  2 files changed, 96 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
