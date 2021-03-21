Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDFA343246
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Mar 2021 13:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCUMKc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Mar 2021 08:10:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhCUMKC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 21 Mar 2021 08:10:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71AFEACA8;
        Sun, 21 Mar 2021 12:10:01 +0000 (UTC)
Date:   Sun, 21 Mar 2021 13:10:00 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>
Subject: Re: [PATCH v3 7/7] qla2xxx: Check kzalloc() return value
Message-ID: <20210321121000.twouhcdlawo464z6@beryllium.lan>
References: <20210320232359.941-1-bvanassche@acm.org>
 <20210320232359.941-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320232359.941-8-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Mar 20, 2021 at 04:23:59PM -0700, Bart Van Assche wrote:
>  	data = kzalloc(response_len, GFP_KERNEL);
> +	if (!data) {
> +		kfree(req_data);
> +		return -ENOMEM;
> +	}

There is the host_stat_out label which could be reused for the exit
path. I am not sure if this the preferred solution by the
maintainers.

Reviewed-by: Daniel Wagner <dwagner@suse.de>


