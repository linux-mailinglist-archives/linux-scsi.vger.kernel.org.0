Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8BC1ABD78
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2020 12:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504298AbgDPKCQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Apr 2020 06:02:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:46964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504310AbgDPKCP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Apr 2020 06:02:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 455F5AD71;
        Thu, 16 Apr 2020 10:02:12 +0000 (UTC)
Subject: Re: [PATCH v3 30/31] elx: efct: Add Makefile and Kconfig for efct
 driver
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     dwagner@suse.de, maier@linux.ibm.com, bvanassche@acm.org,
        herbszt@gmx.de, natechancellor@gmail.com, rdunlap@infradead.org,
        Ram Vegesna <ram.vegesna@broadcom.com>
References: <20200412033303.29574-1-jsmart2021@gmail.com>
 <20200412033303.29574-31-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <dcb5f386-0b47-70c1-96b3-88c15278e9d5@suse.de>
Date:   Thu, 16 Apr 2020 12:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412033303.29574-31-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/12/20 5:33 AM, James Smart wrote:
> This patch completes the efct driver population.
> 
> This patch adds driver definitions for:
> Adds the efct driver Kconfig and Makefiles
> 
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v3:
>    Use SPDX license
>    Remove utils.c from makefile
> ---
>   drivers/scsi/elx/Kconfig  |  9 +++++++++
>   drivers/scsi/elx/Makefile | 18 ++++++++++++++++++
>   2 files changed, 27 insertions(+)
>   create mode 100644 drivers/scsi/elx/Kconfig
>   create mode 100644 drivers/scsi/elx/Makefile
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
