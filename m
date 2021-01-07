Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5C2ED707
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jan 2021 19:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbhAGS4D (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 13:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGS4C (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 Jan 2021 13:56:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C0E223428;
        Thu,  7 Jan 2021 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610045721;
        bh=4Y+zYG7GtFTHzLhMXO9T2m3GcbuSvFUk/1zbJfLgwSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKLcQCJ4/lM6fCRf5mI/ev1NXaJ5HZkj4wL4xitnVLd3o9/Cx0Aa2y2tEy7yNc0NN
         8WhQwRLXr1/+ueWTOpUzCyY7g9GkxZOppQDjHtwNwHdReTTxX/qjJveZ3/mD2KSRpG
         pxI8rVhMH57xjvSKq5E8amM9D0KfKy2ntTN/kQFewdf/8WmOt9l0liHXJWdLgRWE/k
         v88/8K+q9D1rJvUayLg6NyX/AclDHIG4LVgfko+UUUI0LvG/jga3Kv+NYN+//KUzs0
         Hs+MtjmELbKt9I3hbEsV3O3bbxhjzBwAnx3Bbwxz7jAVlf6sE7THkGicyGFozUjXsH
         4ecKbYqorKfTg==
Date:   Thu, 7 Jan 2021 10:55:20 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Can Guo <cang@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, stanley.chu@mediatek.com
Subject: Re: [PATCH v4 2/2] scsi: ufs: handle LINERESET with correct tm_cmd
Message-ID: <X/dZGOvZ23S6rK+0@google.com>
References: <20210107074710.549309-1-jaegeuk@kernel.org>
 <20210107074710.549309-3-jaegeuk@kernel.org>
 <03a47a3f49914230653bea777e2ee550@codeaurora.org>
 <X/bBX6t31BOfRG/i@google.com>
 <abce95b0eb219fb6dee50f925e8fdb36@codeaurora.org>
 <X/bKZDxl1HeelB1a@google.com>
 <3e2245953c143b55d512d46a16ed8a2c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2245953c143b55d512d46a16ed8a2c@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 01/07, Can Guo wrote:
> On 2021-01-07 16:46, Jaegeuk Kim wrote:
> > On 01/07, Can Guo wrote:
> > > On 2021-01-07 16:07, Jaegeuk Kim wrote:
> > > > On 01/07, Can Guo wrote:
> > > > > On 2021-01-07 15:47, Jaegeuk Kim wrote:
> > > > > > From: Jaegeuk Kim <jaegeuk@google.com>
> > > > > >
> > > > > > This fixes a warning caused by wrong reserve tag usage in
> > > > > > __ufshcd_issue_tm_cmd.
> > > > > >
> > > > > > WARNING: CPU: 7 PID: 7 at block/blk-core.c:630 blk_get_request+0x68/0x70
> > > > > > WARNING: CPU: 4 PID: 157 at block/blk-mq-tag.c:82
> > > > > > blk_mq_get_tag+0x438/0x46c
> > > > > >
> > > > > > And, in ufshcd_err_handler(), we can avoid to send tm_cmd before
> > > > > > aborting
> > > > > > outstanding commands by waiting a bit for IO completion like this.
> > > > > >
> > > > > > __ufshcd_issue_tm_cmd: task management cmd 0x80 timed-out
> > > > > >
> > > > > > Fixes: 69a6c269c097 ("scsi: ufs: Use blk_{get,put}_request() to
> > > > > > allocate and free TMFs")
> > > > > > Fixes: 2355b66ed20c ("scsi: ufs: Handle LINERESET indication in err
> > > > > > handler")
> > > > >
> > > > > Hi Jaegeuk,
> > > > >
> > > > > Sorry, what is wrong with commit 2355b66ed20c? Clearing pending I/O
> > > > > reqs is a general procedure for handling all non-fatal errors.
> > > >
> > > > Without waiting IOs, I hit the below timeout all the time from
> > > > LINERESET, which
> > > > causes UFS stuck permanently, as mentioned in the description.
> > > >
> > > > "__ufshcd_issue_tm_cmd: task management cmd 0x80 timed-out"
> > > 
> > > In that case, ufshcd_try_to_abort_task(), the caller of
> > > __ufshcd_issue_tm_cmd(),
> > > should return -ETIMEOUT, then err_handler would jump to do a full
> > > reset,
> > > then bail.
> > > I am not sure what gets UFS stuck permanently. Could you please
> > > share the
> > > callstack
> > > if possible? I really want to know what is happening. Thanks.
> > 
> > I can't share all the log tho, it entered full reset. While printing out
> > whole registers, the device was hard reset. Thanks,
> 
> Hi Jaegeuk,
> 
> Entering full reset is expected in this case, which is why I am saying
> line-reset handling logic should not be penalized. I think we need to
> find out what caused the hard reset but not just adding a delay before
> clearing pending reqs, because let's say 3 sec expires and you hit the
> same tm req timeout (maybe with a lower possibility), you may still end
> up same at the hard reset. You don't need to share all the log, just the
> last call stacks before hard reset. Is it a QCOM's platform used in your
> case? Can you check the log/dump if NoC error happened?

Hi Can,

I figured out it is caused by verbose kernel logs printed in terminal.
I posted v5, so could you please review it?

Thanks,

> 
> Thanks.
> Can Guo.
> 
> > 
> > > 
> > > Regards,
> > > Can Guo.
> > > 
> > > >
> > > > >
> > > > > Thanks,
> > > > > Can Guo.
> > > > >
> > > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > > ---
> > > > > >  drivers/scsi/ufs/ufshcd.c | 35 +++++++++++++++++++++++++++++++----
> > > > > >  1 file changed, 31 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > > > > > index e6e7bdf99cd7..340dd5e515dd 100644
> > > > > > --- a/drivers/scsi/ufs/ufshcd.c
> > > > > > +++ b/drivers/scsi/ufs/ufshcd.c
> > > > > > @@ -44,6 +44,9 @@
> > > > > >  /* Query request timeout */
> > > > > >  #define QUERY_REQ_TIMEOUT 1500 /* 1.5 seconds */
> > > > > >
> > > > > > +/* LINERESET TIME OUT */
> > > > > > +#define LINERESET_IO_TIMEOUT_MS			(30000) /* 30 sec */
> > > > > > +
> > > > > >  /* Task management command timeout */
> > > > > >  #define TM_CMD_TIMEOUT	100 /* msecs */
> > > > > >
> > > > > > @@ -5826,6 +5829,7 @@ static void ufshcd_err_handler(struct work_struct
> > > > > > *work)
> > > > > >  	int err = 0, pmc_err;
> > > > > >  	int tag;
> > > > > >  	bool needs_reset = false, needs_restore = false;
> > > > > > +	ktime_t start;
> > > > > >
> > > > > >  	hba = container_of(work, struct ufs_hba, eh_work);
> > > > > >
> > > > > > @@ -5911,6 +5915,22 @@ static void ufshcd_err_handler(struct work_struct
> > > > > > *work)
> > > > > >  	}
> > > > > >
> > > > > >  	hba->silence_err_logs = true;
> > > > > > +
> > > > > > +	/* Wait for IO completion for non-fatal errors to avoid aborting IOs
> > > > > > */
> > > > > > +	start = ktime_get();
> > > > > > +	while (hba->outstanding_reqs) {
> > > > > > +		ufshcd_complete_requests(hba);
> > > > > > +		spin_unlock_irqrestore(hba->host->host_lock, flags);
> > > > > > +		schedule();
> > > > > > +		spin_lock_irqsave(hba->host->host_lock, flags);
> > > > > > +		if (ktime_to_ms(ktime_sub(ktime_get(), start)) >
> > > > > > +						LINERESET_IO_TIMEOUT_MS) {
> > > > > > +			dev_err(hba->dev, "%s: timeout, outstanding=0x%lx\n",
> > > > > > +					__func__, hba->outstanding_reqs);
> > > > > > +			break;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > >  	/* release lock as clear command might sleep */
> > > > > >  	spin_unlock_irqrestore(hba->host->host_lock, flags);
> > > > > >  	/* Clear pending transfer requests */
> > > > > > @@ -6302,9 +6322,13 @@ static irqreturn_t ufshcd_intr(int irq, void
> > > > > > *__hba)
> > > > > >  		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
> > > > > >  	}
> > > > > >
> > > > > > -	if (enabled_intr_status && retval == IRQ_NONE) {
> > > > > > -		dev_err(hba->dev, "%s: Unhandled interrupt 0x%08x\n",
> > > > > > -					__func__, intr_status);
> > > > > > +	if (enabled_intr_status && retval == IRQ_NONE &&
> > > > > > +				!ufshcd_eh_in_progress(hba)) {
> > > > > > +		dev_err(hba->dev, "%s: Unhandled interrupt 0x%08x (0x%08x,
> > > > > > 0x%08x)\n",
> > > > > > +					__func__,
> > > > > > +					intr_status,
> > > > > > +					hba->ufs_stats.last_intr_status,
> > > > > > +					enabled_intr_status);
> > > > > >  		ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
> > > > > >  	}
> > > > > >
> > > > > > @@ -6348,7 +6372,10 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba
> > > > > > *hba,
> > > > > >  	 * Even though we use wait_event() which sleeps indefinitely,
> > > > > >  	 * the maximum wait time is bounded by %TM_CMD_TIMEOUT.
> > > > > >  	 */
> > > > > > -	req = blk_get_request(q, REQ_OP_DRV_OUT, BLK_MQ_REQ_RESERVED);
> > > > > > +	req = blk_get_request(q, REQ_OP_DRV_OUT, 0);
> > > > > > +	if (IS_ERR(req))
> > > > > > +		return PTR_ERR(req);
> > > > > > +
> > > > > >  	req->end_io_data = &wait;
> > > > > >  	free_slot = req->tag;
> > > > > >  	WARN_ON_ONCE(free_slot < 0 || free_slot >= hba->nutmrs);
