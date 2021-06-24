Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52A3B2735
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Jun 2021 08:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFXGPL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Jun 2021 02:15:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58379 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFXGPK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Jun 2021 02:15:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624515172; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZrMHDWlFZx5T/DA/qDlkCvHV/LEE6wAJDGPH7Xn/SU4=;
 b=d9+fkVvzP5b6yCzDJ82ypf1el+IHjw2Vm/z+05zW9/A0VTbFElsl6TCbADqkEs452f7OCI4Q
 oK0O0F1+CR/4ejdNH/NFa5MwikprSdu8bIH362DTIPaQljdpGKGZaLisBJ7kIXqJrdhkTkPH
 5gjO3f+cJ0MHb+9Y74/pjYrIu2Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60d42251dc4628fe7e8d8073 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 06:12:33
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A806BC43217; Thu, 24 Jun 2021 06:12:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DBDAC433D3;
        Thu, 24 Jun 2021 06:12:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 24 Jun 2021 14:12:31 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] scsi: ufs: Remove host_sem used in
 suspend/resume
In-Reply-To: <a87e5ca5-390f-8ca0-41bf-27cdc70e3316@intel.com>
References: <1624433711-9339-1-git-send-email-cang@codeaurora.org>
 <1624433711-9339-8-git-send-email-cang@codeaurora.org>
 <ed59d61a-6951-2acd-4f89-40f8dc5015e1@intel.com>
 <9105f328ee6ce916a7f01027b0d28332@codeaurora.org>
 <a87e5ca5-390f-8ca0-41bf-27cdc70e3316@intel.com>
Message-ID: <1b351766a6e40d0df90b3adec964eb33@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-06-24 13:52, Adrian Hunter wrote:
> On 24/06/21 5:16 am, Can Guo wrote:
>> On 2021-06-23 22:30, Adrian Hunter wrote:
>>> On 23/06/21 10:35 am, Can Guo wrote:
>>>> To protect system suspend/resume from being disturbed by error 
>>>> handling,
>>>> instead of using host_sem, let error handler call 
>>>> lock_system_sleep() and
>>>> unlock_system_sleep() which achieve the same purpose. Remove the 
>>>> host_sem
>>>> used in suspend/resume paths to make the code more readable.
>>>> 
>>>> Suggested-by: Bart Van Assche <bvanassche@acm.org>
>>>> Signed-off-by: Can Guo <cang@codeaurora.org>
>>>> ---
>>>>  drivers/scsi/ufs/ufshcd.c | 12 +++++++-----
>>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>> 
>>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>>>> index 3695dd2..a09e4a2 100644
>>>> --- a/drivers/scsi/ufs/ufshcd.c
>>>> +++ b/drivers/scsi/ufs/ufshcd.c
>>>> @@ -5907,6 +5907,11 @@ static void ufshcd_clk_scaling_suspend(struct 
>>>> ufs_hba *hba, bool suspend)
>>>> 
>>>>  static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
>>>>  {
>>>> +    /*
>>>> +     * It is not safe to perform error handling while suspend or 
>>>> resume is
>>>> +     * in progress. Hence the lock_system_sleep() call.
>>>> +     */
>>>> +    lock_system_sleep();
>>> 
>>> It looks to me like the system takes this lock quite early, even 
>>> before
>>> freezing tasks, so if anything needs the error handler to run it will
>>> deadlock.
>> 
>> Hi Adrian,
>> 
>> UFS/hba system suspend/resume does not invoke or call error handling 
>> in a
>> synchronous way. So, whatever UFS errors (which schedules the error 
>> handler)
>> happens during suspend/resume, error handler will just wait here till 
>> system
>> suspend/resume release the lock. Hence no worries of deadlock here.
> 
> It looks to me like the state can change to 
> UFSHCD_STATE_EH_SCHEDULED_FATAL
> and since user processes are not frozen, nor file systems sync'ed, 
> everything
> is going to deadlock.
> i.e.
> I/O is blocked waiting on error handling
> error handling is blocked waiting on lock_system_sleep()
> suspend is blocked waiting on I/O
> 

Hi Adrian,

First of all, enter_state(suspend_state_t state) uses 
mutex_trylock(&system_transition_mutex).
Second, even that happens, in ufshcd_queuecommand(), below logic will 
break the cycle, by
fast failing the PM request (below codes are from the code tip with this 
whole series applied).

         case UFSHCD_STATE_EH_SCHEDULED_FATAL:
                 /*
                  * ufshcd_rpm_get_sync() is used at error handling 
preparation
                  * stage. If a scsi cmd, e.g., the SSU cmd, is sent from 
the
                  * PM ops, it can never be finished if we let SCSI layer 
keep
                  * retrying it, which gets err handler stuck forever. 
Neither
                  * can we let the scsi cmd pass through, because UFS is 
in bad
                  * state, the scsi cmd may eventually time out, which 
will get
                  * err handler blocked for too long. So, just fail the 
scsi cmd
                  * sent from PM ops, err handler can recover PM error 
anyways.
                  */
                 if (cmd->request->rq_flags & RQF_PM) {
                         hba->force_reset = true;
                         set_host_byte(cmd, DID_BAD_TARGET);
                         cmd->scsi_done(cmd);
                         goto out;
                 }
                 fallthrough;
         case UFSHCD_STATE_RESET:

Thanks,

Can Guo.

>> 
>> Thanks,
>> 
>> Can Guo.
>> 
>>> 
>>>>      ufshcd_rpm_get_sync(hba);
>>>>      if 
>>>> (pm_runtime_status_suspended(&hba->sdev_ufs_device->sdev_gendev) ||
>>>>          hba->is_wlu_sys_suspended) {
>>>> @@ -5951,6 +5956,7 @@ static void 
>>>> ufshcd_err_handling_unprepare(struct ufs_hba *hba)
>>>>          ufshcd_clk_scaling_suspend(hba, false);
>>>>      ufshcd_clear_ua_wluns(hba);
>>>>      ufshcd_rpm_put(hba);
>>>> +    unlock_system_sleep();
>>>>  }
>>>> 
>>>>  static inline bool ufshcd_err_handling_should_stop(struct ufs_hba 
>>>> *hba)
>>>> @@ -9053,16 +9059,13 @@ static int ufshcd_wl_suspend(struct device 
>>>> *dev)
>>>>      ktime_t start = ktime_get();
>>>> 
>>>>      hba = shost_priv(sdev->host);
>>>> -    down(&hba->host_sem);
>>>> 
>>>>      if (pm_runtime_suspended(dev))
>>>>          goto out;
>>>> 
>>>>      ret = __ufshcd_wl_suspend(hba, UFS_SYSTEM_PM);
>>>> -    if (ret) {
>>>> +    if (ret)
>>>>          dev_err(&sdev->sdev_gendev, "%s failed: %d\n", __func__,  
>>>> ret);
>>>> -        up(&hba->host_sem);
>>>> -    }
>>>> 
>>>>  out:
>>>>      if (!ret)
>>>> @@ -9095,7 +9098,6 @@ static int ufshcd_wl_resume(struct device 
>>>> *dev)
>>>>          hba->curr_dev_pwr_mode, hba->uic_link_state);
>>>>      if (!ret)
>>>>          hba->is_wlu_sys_suspended = false;
>>>> -    up(&hba->host_sem);
>>>>      return ret;
>>>>  }
>>>>  #endif
>>>> 
