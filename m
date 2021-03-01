Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7333277D9
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Mar 2021 07:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhCAGxw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 Mar 2021 01:53:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:47718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232166AbhCAGw7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 1 Mar 2021 01:52:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 881ACAAC5;
        Mon,  1 Mar 2021 06:52:15 +0000 (UTC)
Subject: Re: [PATCH 07/24] mpi3mr: add support of event handling pcie devices
 part-2
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, sathya.prakash@broadcom.com
References: <20201222101156.98308-1-kashyap.desai@broadcom.com>
 <20201222101156.98308-8-kashyap.desai@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <de867b51-7ce2-411a-27da-7eccceca9460@suse.de>
Date:   Mon, 1 Mar 2021 07:52:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20201222101156.98308-8-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 12/22/20 11:11 AM, Kashyap Desai wrote:
> Firmware can report various MPI Events.
> Support for certain Events (as listed below) are enabled in the driver
> and their processing in driver is covered in this patch.
> 
> MPI3_EVENT_PCIE_TOPOLOGY_CHANGE_LIST
> MPI3_EVENT_PCIE_ENUMERATION
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: sathya.prakash@broadcom.com
> ---
>   drivers/scsi/mpi3mr/mpi3mr_fw.c |   2 +
>   drivers/scsi/mpi3mr/mpi3mr_os.c | 202 ++++++++++++++++++++++++++++++++
>   2 files changed, 204 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N�rnberg
HRB 36809 (AG N�rnberg), Gesch�ftsf�hrer: Felix Imend�rffer
