Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533E3294217
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 20:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbgJTS1J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 14:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgJTS1J (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 14:27:09 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14CB20BED;
        Tue, 20 Oct 2020 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603218429;
        bh=syF2yjpdpv6c6cBwA8S43bD1UXqKlZkbBSViMVykC9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2oH7zma9kUc8nVWM9keXK5k/FJ9VCUK19MGKEFn2QD7Mh1kQ54OJByq/0UTUjxoIr
         5zeTNGYHnqFjnTQWjGSOLyAS63Ov9cSIr3Aq6t/dtLX2AenO6dOid8w76U2gYr/UOz
         +6kWzb9C+NaZxNBdNOYciRnoRnsQ4pvHUzEQ1QLU=
Date:   Tue, 20 Oct 2020 11:27:07 -0700
From:   jaegeuk@kernel.org
To:     Can Guo <cang@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH 3/4] scsi: ufs: use WQ_HIGHPRI for gating work
Message-ID: <20201020182707.GA1087816@google.com>
References: <20201005223635.2922805-1-jaegeuk@kernel.org>
 <20201005223635.2922805-3-jaegeuk@kernel.org>
 <5c383fd90a0e97dbd1fffc35574133c9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c383fd90a0e97dbd1fffc35574133c9@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/20, Can Guo wrote:
> On 2020-10-06 06:36, Jaegeuk Kim wrote:
> > From: Jaegeuk Kim <jaegeuk@google.com>
> > 
> > Must have WQ_MEM_RECLAIM
> > ``WQ_MEM_RECLAIM``
> >   All wq which might be used in the memory reclaim paths **MUST**
> >   have this flag set.  The wq is guaranteed to have at least one
> >   execution context regardless of memory pressure.
> > 
> 
> The commit msg is not telling the same story as the change/title does.

This message explains why we need to keep WQ_MEM_RECLAIM when adding WQ_HIGHPRI.

Thanks,

> 
> Regards,
> 
> Can Guo.
> 
> > Cc: Alim Akhtar <alim.akhtar@samsung.com>
> > Cc: Avri Altman <avri.altman@wdc.com>
> > Cc: Can Guo <cang@codeaurora.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> > ---
> >  drivers/scsi/ufs/ufshcd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 0bb07b50bd23e..76e95963887be 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -1849,7 +1849,7 @@ static void ufshcd_init_clk_gating(struct ufs_hba
> > *hba)
> >  	snprintf(wq_name, ARRAY_SIZE(wq_name), "ufs_clk_gating_%d",
> >  		 hba->host->host_no);
> >  	hba->clk_gating.clk_gating_workq = alloc_ordered_workqueue(wq_name,
> > -							   WQ_MEM_RECLAIM);
> > +					WQ_MEM_RECLAIM | WQ_HIGHPRI);
> > 
> >  	hba->clk_gating.is_enabled = true;
