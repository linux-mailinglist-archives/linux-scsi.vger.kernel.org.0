Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9460542D216
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Oct 2021 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhJNGEY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Oct 2021 02:04:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:33091 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNGEY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 14 Oct 2021 02:04:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214546365"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214546365"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 23:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="571124458"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2021 23:02:16 -0700
Subject: Re: [PATCH 1/1] scsi: ufs: core: Fix task management completion
 timeout race
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <huobean@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-scsi@vger.kernel.org
References: <20211013150116.31158-1-adrian.hunter@intel.com>
 <20211013150116.31158-2-adrian.hunter@intel.com>
 <40259621-aac4-e69f-c230-6376bf4d3e36@acm.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <235af725-5346-d830-b62b-21b729aa8703@intel.com>
Date:   Thu, 14 Oct 2021 09:02:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <40259621-aac4-e69f-c230-6376bf4d3e36@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 14/10/2021 07:14, Bart Van Assche wrote:
> On 10/13/21 08:01, Adrian Hunter wrote:
>> __ufshcd_issue_tm_cmd() clears req->end_io_data after timing out,
>> which races with the completion function ufshcd_tmc_handler() which
>> expects req->end_io_data to have a value.
>>
>> Note __ufshcd_issue_tm_cmd() and ufshcd_tmc_handler() are already
>> synchronized using hba->tmf_rqs and hba->outstanding_tasks under the
>> host_lock spinlock.
>>
>> It is also not necessary (nor typical) to clear req->end_io_data because
>> the block layer does it before allocating out requests e.g. via
>> blk_get_request().
>>
>> So fix by not clearing it.
>>
>> Fixes: f5ef336fd2e4c3 ("scsi: ufs: core: Fix task management completion")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   drivers/scsi/ufs/ufshcd.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 95be7ecdfe10..f34b3994d1aa 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -6550,11 +6550,6 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
>>       err = wait_for_completion_io_timeout(&wait,
>>               msecs_to_jiffies(TM_CMD_TIMEOUT));
>>       if (!err) {
>> -        /*
>> -         * Make sure that ufshcd_compl_tm() does not trigger a
>> -         * use-after-free.
>> -         */
>> -        req->end_io_data = NULL;
>>           ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_ERR);
>>           dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
>>                   __func__, tm_function);
> 
> With this patch applied ufshcd_tmc_handler() can trigger a use-after-free of the stack memory used for the 'wait' completion.

AFAICT that would only happen because blk_mq_tagset_busy_iter() is not synchronized with respect to blk_put_request().
But ufshcd_tmc_handler() does not use blk_mq_tagset_busy_iter() anymore, so that can't happen.

Wouldn't it be better to keep the code that clears req->end_io_data and to change complete(c) into if(c) complete(c) in ufshcd_tmc_handler()?

If that were needed, it would imply the synchronization was broken i.e. why are we referencing a request that has already been through blk_put_request()?
