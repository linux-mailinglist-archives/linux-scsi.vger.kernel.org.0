Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5056E1A9F05
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2020 14:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368406AbgDOMGO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Apr 2020 08:06:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368401AbgDOMGJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Apr 2020 08:06:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93FC9ABB2;
        Wed, 15 Apr 2020 12:06:07 +0000 (UTC)
Subject: Re: [PATCH v3 01/31] elx: libefc_sli: SLI-4 register offsets and
 field definitions
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     dwagner@suse.de, maier@linux.ibm.com, bvanassche@acm.org,
        herbszt@gmx.de, natechancellor@gmail.com, rdunlap@infradead.org,
        Ram Vegesna <ram.vegesna@broadcom.com>
References: <20200412033303.29574-1-jsmart2021@gmail.com>
 <20200412033303.29574-2-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <65589867-a8f8-f15f-4aba-3f670dea2bba@suse.de>
Date:   Wed, 15 Apr 2020 14:06:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412033303.29574-2-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/12/20 5:32 AM, James Smart wrote:
> This is the initial patch for the new Emulex target mode SCSI
> driver sources.
> 
> This patch:
> - Creates the new Emulex source level directory drivers/scsi/elx
>    and adds the directory to the MAINTAINERS file.
> - Creates the first library subdirectory drivers/scsi/elx/libefc_sli.
>    This library is a SLI-4 interface library.
> - Starts the population of the libefc_sli library with definitions
>    of SLI-4 hardware register offsets and definitions.
> 
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
