Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1B42D224
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Oct 2021 08:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhJNGNX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Oct 2021 02:13:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:64290 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhJNGNU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 14 Oct 2021 02:13:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="225061304"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="225061304"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 23:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="571126616"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2021 23:11:12 -0700
Subject: Re: [PATCH 5/5] scsi: ufs: Add a sysfs attribute for triggering the
 UFS EH
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Asutosh Das <asutoshd@codeaurora.org>
References: <20211012215433.3725777-1-bvanassche@acm.org>
 <20211012215433.3725777-6-bvanassche@acm.org>
 <cd4b5103-e0fd-feed-2663-b505bcf019d8@intel.com>
 <598bbbc4-ab07-0354-045a-14ba5220f814@acm.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <14c84351-7b3a-e003-fe42-b614b9923de3@intel.com>
Date:   Thu, 14 Oct 2021 09:11:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <598bbbc4-ab07-0354-045a-14ba5220f814@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 13/10/2021 19:56, Bart Van Assche wrote:
> On 10/13/21 1:09 AM, Adrian Hunter wrote:
>> On 13/10/2021 00:54, Bart Van Assche wrote:
>>> Make it possible to test the impact of the UFS error handler on software
>>> that submits SCSI commands to the UFS driver.
>>
>> Are you sure this isn't better suited to debugfs?
> 
> I will convert this attribute into a debugfs attribute.
> 
>>> +    if (ufshcd_eh_in_progress(hba))
>>> +        return -EBUSY;
>>
>> Does it matter if ufshcd_eh_in_progress()?
> 
> The UFS error handler modifies hba->ufshcd_state and assumes that no other code modifies hba->ufshcd_state while the error handler is in progress. Hence this check.

No the error handler takes care not to overwrite ufshcd_state changes
made by the interrupt handler, by always checking if the state is
UFSHCD_STATE_RESET before changing it to UFSHCD_STATE_OPERATIONAL.

Setting saved_err/saved_uic_err and calling ufshcd_schedule_eh_work()
all under spinlock, would be just like an error interrupt, which can
happen while the error handler is running.

> 
>>> +    } else {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    scsi_schedule_eh(hba->host);
>>
>> Probably should be:
>>
>>     queue_work(hba->eh_wq, &hba->eh_work);
> 
> No. This patch is intended for Martin Petersen's 5.16/scsi-queue branch. The patch "Revert "scsi: ufs: Synchronize SCSI and UFS error handling"" has been queued on the 5.15/scsi-fixes branch only.
> 
>> However, it might be simpler to replace everything with:
>>
>>     spin_lock(hba->host->host_lock);
>>     hba->saved_err |= <something>;
>>     hba->saved_uic_err |= <something else>;
>>     ufshcd_schedule_eh_work(hba);
>>     spin_unlock(hba->host->host_lock);
>>
>> Perhaps letting the user specify values to determine <something>
>> and <something else>
> 
> I will look into this.
> 
> Thanks,
> 
> Bart.

