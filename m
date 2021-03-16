Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAD33D017
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Mar 2021 09:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCPIsP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Mar 2021 04:48:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhCPIsF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Mar 2021 04:48:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54ACBAC1F;
        Tue, 16 Mar 2021 08:48:04 +0000 (UTC)
Date:   Tue, 16 Mar 2021 09:48:03 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Mike Christie <michael.christie@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 7/7] qla2xxx: Always check the return value of
 qla24xx_get_isp_stats()
Message-ID: <20210316084803.67if66dxxqs475f5@beryllium.lan>
References: <20210316035655.2835-1-bvanassche@acm.org>
 <20210316035655.2835-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316035655.2835-8-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Mar 15, 2021 at 08:56:55PM -0700, Bart Van Assche wrote:
>  		/* reset firmware statistics */
> -		qla24xx_get_isp_stats(base_vha, stats, stats_dma, BIT_0);
> +		rval = qla24xx_get_isp_stats(base_vha, stats, stats_dma, BIT_0);
> +		WARN_ONCE(rval != QLA_SUCCESS, "rval = %d\n", rval);

ql_log() instead of WARN_ONCE? The function uses ql_log() if
dma_alloc_coherrent() fails a few lines above.
