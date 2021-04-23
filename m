Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78049368BF7
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 06:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhDWEYW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 00:24:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:26473 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDWEYV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 00:24:21 -0400
IronPort-SDR: wFqGTwFgwe5ZrqZlcqj5i+UCCS8rNkIvLG0SHozNqkoG2tn/Th5t7SQfeVfqNtWr/euiq8Ds6b
 yr3Qh8YYFX0w==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192826844"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="192826844"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 21:23:42 -0700
IronPort-SDR: JWllVoPk43r/S37hMosekdbLOWwH5eSI71rVdydNgg/A79tHqHwkYEHL+druSP8sqMtQPH6Uuo
 d36xkU6Pg8kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="421627321"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 22 Apr 2021 21:23:35 -0700
Subject: Re: [PATCH v20 1/2] scsi: ufs: Enable power management for wlun
To:     "Asutosh Das (asd)" <asutoshd@codeaurora.org>, cang@codeaurora.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bean Huo <beanhuo@micron.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Colin Ian King <colin.king@canonical.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Hu <huyue2@yulong.com>,
        Bart van Assche <bvanassche@acm.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>
References: <cover.1618600985.git.asutoshd@codeaurora.org>
 <d660b8d4e1fb192810abd09a8ff0ef4d9f6b96cd.1618600985.git.asutoshd@codeaurora.org>
 <fdadd467-b613-d800-18c5-be064396fd10@intel.com>
 <07e3ea07-e1c3-7b8c-e398-8b008f873e6d@codeaurora.org>
 <90809796-1c32-3709-13d3-65e4d5c387cc@intel.com>
 <1bc4a73e-b22a-6bad-2583-3a0ffa979414@intel.com>
 <651f5d8a-5ab7-77dd-3fed-05feb3fd3e1a@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <efe71230-5b6a-22a8-1aef-f1cae046df22@intel.com>
Date:   Fri, 23 Apr 2021 07:23:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <651f5d8a-5ab7-77dd-3fed-05feb3fd3e1a@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 22/04/21 7:38 pm, Asutosh Das (asd) wrote:
> On 4/20/2021 12:42 AM, Adrian Hunter wrote:
>> On 20/04/21 7:15 am, Adrian Hunter wrote:
>>> On 20/04/21 12:53 am, Asutosh Das (asd) wrote:
>>>> On 4/19/2021 11:37 AM, Adrian Hunter wrote:
>>>>> On 16/04/21 10:49 pm, Asutosh Das wrote:
>>>>>>
>>>>>> Co-developed-by: Can Guo <cang@codeaurora.org>
>>>>>> Signed-off-by: Can Guo <cang@codeaurora.org>
>>>>>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>>>>>> ---
>>>>>
>>>>> I came across 3 issues while testing.  See comments below.
>>>>>
>>>> Hi Adrian
>>>> Thanks for the comments.
>>>>> <SNIP>
>>>>>
>>>>>> @@ -5794,7 +5839,7 @@ static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
>>>>>>        if (ufshcd_is_clkscaling_supported(hba))
>>>>>>            ufshcd_clk_scaling_suspend(hba, false);
>>>>>>        ufshcd_clear_ua_wluns(hba);
>>>>>
>>>>> ufshcd_clear_ua_wluns() deadlocks trying to clear UFS_UPIU_RPMB_WLUN
>>>>> if sdev_rpmb is suspended and sdev_ufs_device is suspending.
>>>>> e.g. ufshcd_wl_suspend() is waiting on host_sem while ufshcd_err_handler()
>>>>> is running, at which point sdev_rpmb has already suspended.
>>>>>
>>>> Umm, I didn't understand this deadlock.
>>>> When you say, sdev_rpmb is suspended, does it mean runtime_suspended?
>>>> sdev_ufs_device is suspending - this can't be runtime_suspending, while ufshcd_err_handling_unprepare is running.
>>>>
>>>> If you've a call-stack of this deadlock, please can you share it with me. I'll also try to reproduce this.
>>>
>>> Yes it is system suspend. sdev_rpmb has suspended, sdev_ufs_device is waiting on host_sem.
>>> ufshcd_err_handler() holds host_sem. ufshcd_clear_ua_wlun(UFS_UPIU_RPMB_WLUN) gets stuck.
>>> I will get some call-stacks.
>>
> Hi Adrian,
> 
> Thanks for the call stacks.
> From the current information, I can't say for sure why it'd get stuck in blk_queue_enter().

I presume SCSI is leaving the RPMB WLUN device runtime suspended and consequently the queue status is RPM_SUSPENDED

> 
> I tried reproducing this issue on my setup yesterday but couldn't.
> Here's what I did:
> 1. sdev_rpmb is RPM_SUSPENDED, checked before initiating system suspend
> 2. sdev_ufs_device is RPM_RESUMED
> 3. I triggered system suspend (echo mem > /sys/power/state) and scheduled the error handler from ufshcd_wl_suspend().
> 4. Waited until error handler ran and then ufshcd_wl_suspend() blocks on host_sem.
> 5. The ufshcd_clear_wa_wlun(UFS_UPIU_RPMB_WLUN) went through fine.
> 
> Do you've some specific steps to reproduce this or a script, perhaps? If so, please can you share it with me. I will try again.

I was using a device that gives occasional errors, but I will what see I can do.

> My test environment is in 5.10 kernel with Android, I suppose that should be ok though.
> 
> Thanks
> -asd
> 
>> Here are the call stacks
>>
>> [   34.094321] Workqueue: ufs_eh_wq_0 ufshcd_err_handler
>> [   34.094788] Call Trace:
>> [   34.095281]  __schedule+0x275/0x6c0
>> [   34.095743]  schedule+0x41/0xa0
>> [   34.096240]  blk_queue_enter+0x10d/0x230
>> [   34.096693]  ? wait_woken+0x70/0x70
>> [   34.097167]  blk_mq_alloc_request+0x53/0xc0
>> [   34.097610]  blk_get_request+0x1e/0x60
>> [   34.098053]  __scsi_execute+0x3c/0x260
>> [   34.098529]  ufshcd_clear_ua_wlun.cold+0xa6/0x14b
>> [   34.098977]  ufshcd_clear_ua_wluns.part.0+0x4d/0x92
>> [   34.099456]  ufshcd_err_handler+0x97a/0x9ff
>> [   34.099902]  process_one_work+0x1cc/0x360
>> [   34.100384]  worker_thread+0x45/0x3b0
>> [   34.100851]  ? process_one_work+0x360/0x360
>> [   34.101308]  kthread+0xf6/0x130
>> [   34.101728]  ? kthread_park+0x80/0x80
>> [   34.102186]  ret_from_fork+0x1f/0x30
>>
>> [   34.640751] task:kworker/u10:9   state:D stack:14528 pid:  255 ppid:     2 flags:0x00004000
>> [   34.641253] Workqueue: events_unbound async_run_entry_fn
>> [   34.641722] Call Trace:
>> [   34.642217]  __schedule+0x275/0x6c0
>> [   34.642683]  schedule+0x41/0xa0
>> [   34.643179]  schedule_timeout+0x18b/0x290
>> [   34.643645]  ? del_timer_sync+0x30/0x30
>> [   34.644131]  __down_timeout+0x6b/0xc0
>> [   34.644568]  ? ufshcd_clkscale_enable_show+0x20/0x20
>> [   34.645014]  ? async_schedule_node_domain+0x17d/0x190
>> [   34.645496]  down_timeout+0x42/0x50
>> [   34.645947]  ufshcd_wl_suspend+0x79/0xa0
>> [   34.646432]  ? scmd_printk+0x100/0x100
>> [   34.646917]  scsi_bus_suspend_common+0x56/0xc0
>> [   34.647405]  ? scsi_bus_freeze+0x10/0x10
>> [   34.647858]  dpm_run_callback+0x45/0x110
>> [   34.648347]  __device_suspend+0x117/0x460
>> [   34.648788]  async_suspend+0x16/0x90
>> [   34.649251]  async_run_entry_fn+0x26/0x110
>> [   34.649676]  process_one_work+0x1cc/0x360
>> [   34.650137]  worker_thread+0x45/0x3b0
>> [   34.650563]  ? process_one_work+0x360/0x360
>> [   34.650994]  kthread+0xf6/0x130
>> [   34.651455]  ? kthread_park+0x80/0x80
>> [   34.651882]  ret_from_fork+0x1f/0x30
>>
>>
>>
>>>
>>>>
>>>> I'll address the other comments in the next version.
>>>>
>>>>
>>>> Thank you!
>>>>
>>>>>> -    pm_runtime_put(hba->dev);
>>>>>> +    ufshcd_rpm_put(hba);
>>>>>>    }
>>>>>
>>>>> <SNIP>
>>>>>
>>>>>> +void ufshcd_resume_complete(struct device *dev)
>>>>>> +{
>>>>
>>>
>>
> 
> 

