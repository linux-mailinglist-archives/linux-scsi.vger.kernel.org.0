Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B629310629
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEAIeQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 04:34:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfEAIeQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 1 May 2019 04:34:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA70AADD2;
        Wed,  1 May 2019 08:34:15 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] sd: Inline sd_probe_part2()
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>, Lee Duncan <lduncan@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190430213919.97437-1-bvanassche@acm.org>
 <20190430213919.97437-3-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <60abcdf6-007f-14e2-c1ee-1839266fa132@suse.com>
Date:   Wed, 1 May 2019 10:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430213919.97437-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/30/19 11:39 PM, Bart Van Assche wrote:
> Make sd_probe() easier to read by inlining sd_probe_part2(). This
> patch does not change any functionality.
> 
> Cc: Lee Duncan <lduncan@suse.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/sd.c | 101 ++++++++++++++++++++--------------------------
>   1 file changed, 43 insertions(+), 58 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

