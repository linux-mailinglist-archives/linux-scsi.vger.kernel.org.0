Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4B381662
	for <lists+linux-scsi@lfdr.de>; Sat, 15 May 2021 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhEOGpX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 15 May 2021 02:45:23 -0400
Received: from verein.lst.de ([213.95.11.211]:52570 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhEOGpW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 15 May 2021 02:45:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B046A68AFE; Sat, 15 May 2021 08:44:07 +0200 (CEST)
Date:   Sat, 15 May 2021 08:44:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH 1/3] libsas: Introduce more SAM status code aliases in
 enum exec_status
Message-ID: <20210515064407.GB26545@lst.de>
References: <20210514232308.7826-1-bvanassche@acm.org> <20210514232308.7826-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514232308.7826-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> index 9271d7a49b90..9b17f7c8c314 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -477,6 +477,9 @@ enum exec_status {
>  	/* The SAM_STAT_.. codes fit in the lower 6 bits, alias some of
>  	 * them here to silence 'case value not in enumerated type' warnings
>  	 */
> +	__SAM_STAT_GOOD = SAM_STAT_GOOD,
> +	__SAM_STAT_BUSY = SAM_STAT_BUSY,
> +	__SAM_STAT_TASK_ABORTED = SAM_STAT_TASK_ABORTED,
>  	__SAM_STAT_CHECK_CONDITION = SAM_STAT_CHECK_CONDITION,

I don't think the (existing) naming and comment are very helpful here.

I'd so a s/__SAM_/SAS_SAM_/

and replace the comment with something like:

	/*
	 * The first 6 bytes are used to return the SAM_STAT_* codes.  To avoid
	 * 'case value not in enumerated type' compiler warnings every value
	 * returned through the exec_status enum will need an alias with
	 * the SAS_ prefix here.
	 */
	SAS_SAM_STAT_GOOD = SAM_STAT_GOOD,
	SAS_SAM_STAT_BUSY = SAM_STAT_BUSY,
	...
