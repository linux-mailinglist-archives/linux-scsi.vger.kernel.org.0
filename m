Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C04294786
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Oct 2020 06:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440234AbgJUEw6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Oct 2020 00:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440209AbgJUEw6 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Oct 2020 00:52:58 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A664C207FF;
        Wed, 21 Oct 2020 04:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603255977;
        bh=UraehopB91mJB0sVQ3c9WR4rOSBImtDbOcY3TERhXzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzl/5GKkO/PhDhfyZu328++s/nVgy36QFKK22ppo1rhvoc1zgHe/EnBUycMrPUDAS
         i3Zg8DC1oamM9qGPQlZWVqiQwOD8+fbK7fdU6vHAcqnzJ+/U2lctcou2YzNghVDlBA
         qGWKjMHG494eqO6sf5GjzZWFgxt7GYtY3UFUV34I=
Date:   Tue, 20 Oct 2020 21:52:57 -0700
From:   jaegeuk@kernel.org
To:     Can Guo <cang@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH v2 3/5] scsi: ufs: use WQ_HIGHPRI for gating work
Message-ID: <20201021045257.GC3004521@google.com>
References: <20201020195258.2005605-1-jaegeuk@kernel.org>
 <20201020195258.2005605-4-jaegeuk@kernel.org>
 <d6e794548891f81a579cda138cd1529e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e794548891f81a579cda138cd1529e@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/21, Can Guo wrote:
> On 2020-10-21 03:52, Jaegeuk Kim wrote:
> > From: Jaegeuk Kim <jaegeuk@google.com>
> > 
> > Must have WQ_MEM_RECLAIM
> > ``WQ_MEM_RECLAIM``
> >   All wq which might be used in the memory reclaim paths **MUST**
> >   have this flag set.  The wq is guaranteed to have at least one
> >   execution context regardless of memory pressure.
> > 
> 
> You misunderstood my point. I meant you need to give more info about why
> we are adding WQ_HIGHPRI flag but not why WQ_MEM_RECLAIM must be there.

Oh, I thought that WQ_HIGHPRI is telling everything tho.

> 
> Thanks,
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
> > index feb10ebf7a35..0858c0b55eac 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -1867,7 +1867,7 @@ static void ufshcd_init_clk_gating(struct ufs_hba
> > *hba)
> >  	snprintf(wq_name, ARRAY_SIZE(wq_name), "ufs_clk_gating_%d",
> >  		 hba->host->host_no);
> >  	hba->clk_gating.clk_gating_workq = alloc_ordered_workqueue(wq_name,
> > -							   WQ_MEM_RECLAIM);
> > +					WQ_MEM_RECLAIM | WQ_HIGHPRI);
> > 
> >  	hba->clk_gating.is_enabled = true;
