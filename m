Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE729870B
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 07:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421990AbgJZGn5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 02:43:57 -0400
Received: from z5.mailgun.us ([104.130.96.5]:60725 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421840AbgJZGn4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Oct 2020 02:43:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603694635; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=1AFvyPUTwsQZGCwbJvPbwKXzpvY11ZKrNGDvUKm7z2U=;
 b=j5ODfsLdw37wVzk4k4IAEv4IYMVWP0yEQXT6pWJ5IUUr++3P7O4N9C6wkRamTio9lEdCCwMy
 NlZup4Br93oNgn7EUuCSI4Koy0ztt4BEyTj02/6q/CGp1mApQdC2IvQhe1illwEmfZofa1Pg
 N0NwHDneJI6E8LjroO02yveTevY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f96702bef7f807d40eedfff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 06:43:55
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BD93C433FF; Mon, 26 Oct 2020 06:43:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F06F0C433F0;
        Mon, 26 Oct 2020 06:43:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 14:43:53 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Subject: Re: [PATCH v3 1/5] scsi: ufs: atomic update for clkgating_enable
In-Reply-To: <20201026061313.GA2517102@google.com>
References: <20201024150646.1790529-1-jaegeuk@kernel.org>
 <20201024150646.1790529-2-jaegeuk@kernel.org>
 <68cf5fe17691653f07544db5fe390c97@codeaurora.org>
 <20201026061313.GA2517102@google.com>
Message-ID: <6c029b64cb4d78e7624bc896f9c9f16d@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-10-26 14:13, Jaegeuk Kim wrote:
> On 10/26, Can Guo wrote:
>> On 2020-10-24 23:06, Jaegeuk Kim wrote:
>> > From: Jaegeuk Kim <jaegeuk@google.com>
>> >
>> > When giving a stress test which enables/disables clkgating, we hit
>> > device
>> > timeout sometimes. This patch avoids subtle racy condition to address
>> > it.
>> >
>> > If we use __ufshcd_release(), I've seen that gate_work can be called in
>> > parallel
>> > with ungate_work, which results in UFS timeout when doing hibern8.
>> > Should avoid it.
>> >
>> 
>> I don't understand this comment. gate_work and ungate_work are queued 
>> on
>> an ordered workqueue and an ordered workqueue executes at most one 
>> work item
>> at any given time in the queued order. How can the two run in 
>> parallel?
> 
> When I hit UFS stuck, I saw this by clkgating tracepoint.
> 
> - REQ_CLK_OFF
> - CLKS_OFF
> - REQ_CLK_OFF
> - REQ_CLKS_ON
> ..
> 

I don't see how can you tell that the two works are running in parallel
just from above trace. May I know what is the exact error by "UFS 
timeout
when doing hibern8"?

By using __ufshcd_release() here, I do see one potential issue if your 
test
quickly toggles on/off of clk_gating - disable it, enable it, disable it 
and
enable it, which will cause that __ufshcd_release() being called twice, 
meaning
we queue two gate_works back to back. So can you try below code and let 
me know
if it helps or not? I am OK with your current change, but I would like 
to
understand the problem. Thanks.

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1791bce..3eee438 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2271,6 +2271,8 @@ static void ufshcd_gate_work(struct work_struct 
*work)
         unsigned long flags;

         spin_lock_irqsave(hba->host->host_lock, flags);
+       if (hba->clk_gating.state == CLKS_OFF)
+               goto rel_lock;
         /*
          * In case you are here to cancel this work the gating state
          * would be marked as REQ_CLKS_ON. In this case save time by

Regards,

Can Guo.

> By using active_req, I don't see any problem.
> 
>> 
>> Thanks,
>> 
>> Can Guo.
>> 
>> > Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
>> > ---
>> >  drivers/scsi/ufs/ufshcd.c | 12 ++++++------
>> >  1 file changed, 6 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> > index b8f573a02713..e0b479f9eb8a 100644
>> > --- a/drivers/scsi/ufs/ufshcd.c
>> > +++ b/drivers/scsi/ufs/ufshcd.c
>> > @@ -1807,19 +1807,19 @@ static ssize_t
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
>> > +		hba->clk_gating.active_reqs--;
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
