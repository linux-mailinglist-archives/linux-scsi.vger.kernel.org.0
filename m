Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B6343239
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Mar 2021 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCUMEZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Mar 2021 08:04:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhCUMD5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 21 Mar 2021 08:03:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 011A9ACA8;
        Sun, 21 Mar 2021 12:03:56 +0000 (UTC)
Date:   Sun, 21 Mar 2021 13:03:55 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Mike Christie <michael.christie@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Lee Duncan <lduncan@suse.com>
Subject: Re: [PATCH v3 6/7] qla2xxx: Always check the return value of
 qla24xx_get_isp_stats()
Message-ID: <20210321120355.x6gtgjbzl6ahb6qz@beryllium.lan>
References: <20210320232359.941-1-bvanassche@acm.org>
 <20210320232359.941-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320232359.941-7-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Mar 20, 2021 at 04:23:58PM -0700, Bart Van Assche wrote:
> This patch fixes the following Coverity warning:
> 
>     CID 361199 (#1 of 1): Unchecked return value (CHECKED_RETURN)
>     3. check_return: Calling qla24xx_get_isp_stats without checking return
>     value (as is done elsewhere 4 out of 5 times).
> 
> Cc: Quinn Tran <qutran@marvell.com>
> Cc: Mike Christie <michael.christie@oracle.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Lee Duncan <lduncan@suse.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
