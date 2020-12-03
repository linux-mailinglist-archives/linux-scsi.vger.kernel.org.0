Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4617B2CCE70
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Dec 2020 06:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgLCFWY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Dec 2020 00:22:24 -0500
Received: from m42-5.mailgun.net ([69.72.42.5]:11219 "EHLO m42-5.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgLCFWY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 3 Dec 2020 00:22:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606972923; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=HahUMtWlaBoRTtgNit+apwzv1egG3PuGsmOhLWWfRXM=;
 b=rdlZqAuuc/AcmozYWnVmhKHJz2fLRkofHhPylYJ69pFDJMUGfVGW2MaqrLfADtEPI+egXO7M
 09mKlwC6lYa2XKbAXgUVq3tig+VNATsbXYgrwnyxQDtoUn2vtgYrE+eJit/1zaXGrzxf8tkT
 Q2nT+5IghauJULwKMRibucIJWrw=
X-Mailgun-Sending-Ip: 69.72.42.5
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fc875de2571f1091a9385d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Dec 2020 05:21:34
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18A18C43462; Thu,  3 Dec 2020 05:21:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4CB0C433C6;
        Thu,  3 Dec 2020 05:21:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Dec 2020 13:21:31 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 2/3] scsi: ufs: Fix a race condition between
 ufshcd_abort and eh_work
In-Reply-To: <1606972749.23925.58.camel@mtkswgap22>
References: <1606910644-21185-1-git-send-email-cang@codeaurora.org>
 <1606910644-21185-3-git-send-email-cang@codeaurora.org>
 <1606962078.23925.47.camel@mtkswgap22>
 <dcb7f5c9738ff18a15b3d15615de0d92@codeaurora.org>
 <1606971101.23925.56.camel@mtkswgap22>
 <843a2bb60b16929239ac5ee100bac465@codeaurora.org>
 <1606972749.23925.58.camel@mtkswgap22>
Message-ID: <77285270581ceec46f5204f04173b6ca@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-12-03 13:19, Stanley Chu wrote:
> On Thu, 2020-12-03 at 13:11 +0800, Can Guo wrote:
>> On 2020-12-03 12:51, Stanley Chu wrote:
>> > On Thu, 2020-12-03 at 12:01 +0800, Can Guo wrote:
>> >> On 2020-12-03 10:21, Stanley Chu wrote:
>> >> > On Wed, 2020-12-02 at 04:04 -0800, Can Guo wrote:
>> >> >> In current task abort routine, if task abort happens to the device
>> >> >> W-LU,
>> >> >> the code directly jumps to ufshcd_eh_host_reset_handler() to perform a
>> >> >> full reset and restore then returns FAIL or SUCCESS. Commands sent to
>> >> >> the
>> >> >> device W-LU are most likely the SSU cmds sent during UFS PM
>> >> >> operations. If
>> >> >> such SSU cmd enters task abort routine, when
>> >> >> ufshcd_eh_host_reset_handler()
>> >> >> flushes eh_work, it will get stuck there since err_handler is
>> >> >> serialized
>> >> >> with PM operations.
>> >> >>
>> >> >> In order to unblock above call path, we merely clean up the lrb taken
>> >> >> by
>> >> >> this cmd, queue the eh_work and return SUCCESS. Once the cmd is
>> >> >> aborted,
>> >> >> the PM operation which sends out the cmd just errors out, then
>> >> >> err_handler
>> >> >> shall be able to proceed with the full reset and restore.
>> >> >>
>> >> >> In this scenario, the cmd is aborted even before it is actually
>> >> >> cleared by
>> >> >> HW, set the lrb->in_use flag to prevent subsequent cmds, including
>> >> >> SCSI
>> >> >> cmds and dev cmds, from taking the lrb released from abort. The flag
>> >> >> shall
>> >> >> evetually be cleared in __ufshcd_transfer_req_compl() invoked by the
>> >> >> full
>> >> >> reset and restore from err_handler.
>> >> >>
>> >> >> Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>
>> >> >> Signed-off-by: Can Guo <cang@codeaurora.org>
>> >> >> ---
>> >> >>  drivers/scsi/ufs/ufshcd.c | 60
>> >> >> +++++++++++++++++++++++++++++++++++++----------
>> >> >>  drivers/scsi/ufs/ufshcd.h |  2 ++
>> >> >>  2 files changed, 49 insertions(+), 13 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> >> >> index f0bb3fc..26c1fa0 100644
>> >> >> --- a/drivers/scsi/ufs/ufshcd.c
>> >> >> +++ b/drivers/scsi/ufs/ufshcd.c
>> >> >> @@ -2539,6 +2539,14 @@ static int ufshcd_queuecommand(struct Scsi_Host
>> >> >> *host, struct scsi_cmnd *cmd)
>> >> >>  		(hba->clk_gating.state != CLKS_ON));
>> >> >>
>> >> >>  	lrbp = &hba->lrb[tag];
>> >> >> +	if (unlikely(lrbp->in_use)) {
>> >> >> +		if (hba->pm_op_in_progress)
>> >> >> +			set_host_byte(cmd, DID_BAD_TARGET);
>> >> >> +		else
>> >> >> +			err = SCSI_MLQUEUE_HOST_BUSY;
>> >> >> +		ufshcd_release(hba);
>> >> >> +		goto out;
>> >> >> +	}
>> >> >>
>> >> >>  	WARN_ON(lrbp->cmd);
>> >> >>  	lrbp->cmd = cmd;
>> >> >> @@ -2781,6 +2789,11 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba
>> >> >> *hba,
>> >> >>
>> >> >>  	init_completion(&wait);
>> >> >>  	lrbp = &hba->lrb[tag];
>> >> >> +	if (unlikely(lrbp->in_use)) {
>> >> >> +		err = -EBUSY;
>> >> >> +		goto out;
>> >> >> +	}
>> >> >> +
>> >> >>  	WARN_ON(lrbp->cmd);
>> >> >>  	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
>> >> >>  	if (unlikely(err))
>> >> >> @@ -2797,6 +2810,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba
>> >> >> *hba,
>> >> >>
>> >> >>  	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
>> >> >>
>> >> >> +out:
>> >> >>  	ufshcd_add_query_upiu_trace(hba, tag,
>> >> >>  			err ? "query_complete_err" : "query_complete");
>> >> >>
>> >> >> @@ -4929,9 +4943,11 @@ static void __ufshcd_transfer_req_compl(struct
>> >> >> ufs_hba *hba,
>> >> >>  	struct scsi_cmnd *cmd;
>> >> >>  	int result;
>> >> >>  	int index;
>> >> >> +	bool update_scaling = false;
>> >> >>
>> >> >>  	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
>> >> >>  		lrbp = &hba->lrb[index];
>> >> >> +		lrbp->in_use = false;
>> >> >>  		lrbp->compl_time_stamp = ktime_get();
>> >> >>  		cmd = lrbp->cmd;
>> >> >>  		if (cmd) {
>> >> >> @@ -4944,15 +4960,17 @@ static void __ufshcd_transfer_req_compl(struct
>> >> >> ufs_hba *hba,
>> >> >>  			/* Do not touch lrbp after scsi done */
>> >> >>  			cmd->scsi_done(cmd);
>> >> >>  			__ufshcd_release(hba);
>> >> >> +			update_scaling = true;
>> >> >>  		} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
>> >> >>  			lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
>> >> >>  			if (hba->dev_cmd.complete) {
>> >> >>  				ufshcd_add_command_trace(hba, index,
>> >> >>  						"dev_complete");
>> >> >>  				complete(hba->dev_cmd.complete);
>> >> >> +				update_scaling = true;
>> >> >>  			}
>> >> >>  		}
>> >> >> -		if (ufshcd_is_clkscaling_supported(hba))
>> >> >> +		if (ufshcd_is_clkscaling_supported(hba) && update_scaling)
>> >> >>  			hba->clk_scaling.active_reqs--;
>> >> >>  	}
>> >> >>
>> >> >> @@ -6374,8 +6392,12 @@ static int ufshcd_issue_devman_upiu_cmd(struct
>> >> >> ufs_hba *hba,
>> >> >>
>> >> >>  	init_completion(&wait);
>> >> >>  	lrbp = &hba->lrb[tag];
>> >> >> -	WARN_ON(lrbp->cmd);
>> >> >> +	if (unlikely(lrbp->in_use)) {
>> >> >> +		err = -EBUSY;
>> >> >> +		goto out;
>> >> >> +	}
>> >> >>
>> >> >> +	WARN_ON(lrbp->cmd);
>> >> >>  	lrbp->cmd = NULL;
>> >> >>  	lrbp->sense_bufflen = 0;
>> >> >>  	lrbp->sense_buffer = NULL;
>> >> >> @@ -6447,6 +6469,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct
>> >> >> ufs_hba *hba,
>> >> >>  		}
>> >> >>  	}
>> >> >>
>> >> >> +out:
>> >> >>  	blk_put_request(req);
>> >> >>  out_unlock:
>> >> >>  	up_read(&hba->clk_scaling_lock);
>> >> >> @@ -6696,16 +6719,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>> >> >>  		BUG();
>> >> >>  	}
>> >> >>
>> >> >> -	/*
>> >> >> -	 * Task abort to the device W-LUN is illegal. When this command
>> >> >> -	 * will fail, due to spec violation, scsi err handling next step
>> >> >> -	 * will be to send LU reset which, again, is a spec violation.
>> >> >> -	 * To avoid these unnecessary/illegal step we skip to the last error
>> >> >> -	 * handling stage: reset and restore.
>> >> >> -	 */
>> >> >> -	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN)
>> >> >> -		return ufshcd_eh_host_reset_handler(cmd);
>> >> >> -
>> >> >>  	ufshcd_hold(hba, false);
>> >> >>  	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
>> >> >>  	/* If command is already aborted/completed, return SUCCESS */
>> >> >> @@ -6726,7 +6739,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>> >> >>  	 * to reduce repeated printouts. For other aborted requests only
>> >> >> print
>> >> >>  	 * basic details.
>> >> >>  	 */
>> >> >> -	scsi_print_command(hba->lrb[tag].cmd);
>> >> >> +	scsi_print_command(cmd);
>> >> >>  	if (!hba->req_abort_count) {
>> >> >>  		ufshcd_update_reg_hist(&hba->ufs_stats.task_abort, 0);
>> >> >>  		ufshcd_print_host_regs(hba);
>> >> >> @@ -6745,6 +6758,27 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>> >> >>  		goto cleanup;
>> >> >>  	}
>> >> >>
>> >> >> +	/*
>> >> >> +	 * Task abort to the device W-LUN is illegal. When this command
>> >> >> +	 * will fail, due to spec violation, scsi err handling next step
>> >> >> +	 * will be to send LU reset which, again, is a spec violation.
>> >> >> +	 * To avoid these unnecessary/illegal steps, first we clean up
>> >> >> +	 * the lrb taken by this cmd and mark the lrb as in_use, then
>> >> >> +	 * queue the eh_work and bail.
>> >> >> +	 */
>> >> >> +	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN) {
>> >> >> +		spin_lock_irqsave(host->host_lock, flags);
>> >> >> +		if (lrbp->cmd) {
>> >> >> +			__ufshcd_transfer_req_compl(hba, (1UL << tag));
>> >> >> +			__set_bit(tag, &hba->outstanding_reqs);
>> >> >> +			lrbp->in_use = true;
>> >> >> +			hba->force_reset = true;
>> >> >> +			ufshcd_schedule_eh_work(hba);
>> >> >
>> >> > ufshcd_schedule_eh_work() will set hba->ufshcd_state as
>> >> > UFSHCD_STATE_EH_SCHEDULED_FATAL. While in this state,
>> >> > ufshcd_queuecommand() will set_host_byte(DID_BAD_TARGET) which is
>> >> > similar as what you would like to do in this patch.
>> >> >
>> >> > Is this enough for avoiding reusing tag issue? Just wonder if
>> >> > lrpb->in_use flag is really required to be added.
>> >>
>> >> Hi Stanley,
>> >>
>> >> Thanks for the discussion.
>> >>
>> >> To be accurate, it is to prevent lrb from being re-used, not the
>> >> tag.
>> >> Block layer and/or scsi layer can re-use the tag right after
>> >> we abort the cmd, but the lrb is empty since we cleared it from
>> >> abort path and we need to make sure the lrb stays empty before the
>> >> full reset and restore happens.
>> >
>> > What is the definition of "empty" here?
>> 
>> Yes, it means lrb->cmd is NULL.
>> 
>> >
>> > If it means lrb->cmd shall be empty (to not invoking scsi_done again),
>> > then the hba->ufshcd_state check in ufshcd_queuecommend() will also
>> > clear the re-used lrb->cmd if ufshcd_state is in
>> > UFSHCD_STATE_EH_SCHEDULED_FATAL case.
>> 
>> Yes, but that would have a race condition - say a cmd re-uses the tag
>> and
>> occupies the lrb in queuecommand, at the same time the real completion
>> IRQ
>> of previous cmd comes (althrough we aborted it due to it timed out, 
>> but
>> the
>> completion IRQ can come at any time before the full reset and restore 
>> is
>> performed), then the new cmd will be wrongly completed by IRQ handler
>> from
>> __ufshcd_transfer_req_compl() which is actually fired by the last cmd,
>> so
>> we need to block it even before the cmd takes the lrb - before
>> 
>> lrbp->cmd = cmd;
> 
> I see.
> Thanks for the explanation.
> 
>> 
>> >
>> > However ufshcd_state cannot protect other paths now, for example,
>> > ufshcd_exec_dev_cmd(), so lrbp->in_use may be required for this usage,
>> > or ufshcd_state check can be added to help.
>> >
>> > BTW, would you also need to consider ufshcd_issue_devman_upiu_cmd()
>> > that
>> > is another possible path to re-use lrb?
>> 
>> In this change, there are checks of lrb->in_use in
>> ufshcd_queuecommand(),
>> ufshcd_exec_dev_cmd() and ufshcd_issue_devman_upiu_cmd().
> 
> Oops I missed it. Sorry for this noise.
> 
> Feel free to add
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>

Thanks for your review! :)

Regards,

Can Guo.
