Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B31C29A361
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Oct 2020 04:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505071AbgJ0Dhy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 23:37:54 -0400
Received: from z5.mailgun.us ([104.130.96.5]:46770 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444404AbgJ0Dhy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Oct 2020 23:37:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603769874; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=D4ptAK/G5fQCiIbsv81pzLjHpEOeMVA9CSSPFZvFg48=;
 b=CXPt8TTthJxsuVoGuJ8YJPMHFKPBUHBjlovBY3N+pjFqk4cMBC2LNttXznx3y4Rkymfjiy2t
 155BZVhazvAufU5NUx5zcCXUX/PREK2KV3o+VEVdhEFf2emMiMI8dqtlgz4pxbqJV2Lfgdpv
 zlgIkBL0S90m+SQFX/N/lcOhzKM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f9796115c97867acedd99fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 03:37:53
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8BBABC433FE; Tue, 27 Oct 2020 03:37:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 036D7C433F0;
        Tue, 27 Oct 2020 03:37:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Oct 2020 11:37:52 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: Re: [PATCH v4 1/5] scsi: ufs: atomic update for clkgating_enable
In-Reply-To: <20201027033311.GA1745317@google.com>
References: <20201026195124.363096-1-jaegeuk@kernel.org>
 <20201026195124.363096-2-jaegeuk@kernel.org>
 <20d1c2ca06e95beb207fd4ba1b61dc80@codeaurora.org>
 <20201027033311.GA1745317@google.com>
Message-ID: <76df977d164683c7404d2dc702f2e5ad@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-10-27 11:33, Jaegeuk Kim wrote:
> On 10/27, Can Guo wrote:
>> On 2020-10-27 03:51, Jaegeuk Kim wrote:
>> > From: Jaegeuk Kim <jaegeuk@google.com>
>> >
>> > When giving a stress test which enables/disables clkgating, we hit
>> > device
>> > timeout sometimes. This patch avoids subtle racy condition to address
>> > it.
>> >
>> > Note that, this requires a patch to address the device stuck by
>> > REQ_CLKS_OFF in
>> > __ufshcd_release().
>> >
>> > The fix is "scsi: ufs: avoid to call REQ_CLKS_OFF to CLKS_OFF".
>> 
>> Why don't you just squash the fix into this one?
> 
> I'm seeing this patch just revealed that problem.

That scenario (back to back calling of ufshcd_release()) only happens
when you stress the clkgate_enable sysfs node, so let's keep the fix
as one to make things simple. What do you think?

Thanks,

Can Guo.

> 
>> 
>> Thanks,
>> 
>> Can Guo.
>> 
>> >
>> > Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
>> > ---
>> >  drivers/scsi/ufs/ufshcd.c | 12 ++++++------
>> >  1 file changed, 6 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> > index cc8d5f0c3fdc..6c9269bffcbd 100644
>> > --- a/drivers/scsi/ufs/ufshcd.c
>> > +++ b/drivers/scsi/ufs/ufshcd.c
>> > @@ -1808,19 +1808,19 @@ static ssize_t
>> > ufshcd_clkgate_enable_store(struct device *dev,
>> >  		return -EINVAL;
>> >
>> >  	value = !!value;
>> > +
>> > +	spin_lock_irqsave(hba->host->host_lock, flags);
>> >  	if (value == hba->clk_gating.is_enabled)
>> >  		goto out;
>> >
>> > -	if (value) {
>> > -		ufshcd_release(hba);
>> > -	} else {
>> > -		spin_lock_irqsave(hba->host->host_lock, flags);
>> > +	if (value)
>> > +		__ufshcd_release(hba);
>> > +	else
>> >  		hba->clk_gating.active_reqs++;
>> > -		spin_unlock_irqrestore(hba->host->host_lock, flags);
>> > -	}
>> >
>> >  	hba->clk_gating.is_enabled = value;
>> >  out:
>> > +	spin_unlock_irqrestore(hba->host->host_lock, flags);
>> >  	return count;
>> >  }
