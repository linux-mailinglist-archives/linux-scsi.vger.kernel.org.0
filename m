Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8D327275
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Feb 2021 14:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhB1NZD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Feb 2021 08:25:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:32964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhB1NZA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 28 Feb 2021 08:25:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45B0BAB7D;
        Sun, 28 Feb 2021 13:24:18 +0000 (UTC)
Subject: Re: [PATCH 05/24] mpi3mr: add support of internal watchdog thread
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, sathya.prakash@broadcom.com
References: <20201222101156.98308-1-kashyap.desai@broadcom.com>
 <20201222101156.98308-6-kashyap.desai@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <77fa035d-a678-8666-d126-b240a4f24e2c@suse.de>
Date:   Sun, 28 Feb 2021 14:24:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20201222101156.98308-6-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 12/22/20 11:11 AM, Kashyap Desai wrote:
> Watchdog thread is driver's internal thread which does few things like
> detecting FW fault and reset the controller, Timestamp sync etc.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: sathya.prakash@broadcom.com
> ---
>   drivers/scsi/mpi3mr/mpi3mr.h    |  11 +++
>   drivers/scsi/mpi3mr/mpi3mr_fw.c | 125 ++++++++++++++++++++++++++++++++
>   drivers/scsi/mpi3mr/mpi3mr_os.c |   3 +
>   3 files changed, 139 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N�rnberg
HRB 36809 (AG N�rnberg), Gesch�ftsf�hrer: Felix Imend�rffer
