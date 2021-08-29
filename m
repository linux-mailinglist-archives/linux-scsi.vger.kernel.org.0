Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7B3FAA9F
	for <lists+linux-scsi@lfdr.de>; Sun, 29 Aug 2021 11:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhH2J6Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 29 Aug 2021 05:58:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:3357 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234954AbhH2J6X (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 29 Aug 2021 05:58:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="218186770"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="218186770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 02:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="458670272"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2021 02:57:26 -0700
Subject: Re: [PATCH v3 16/18] scsi: ufs: Synchronize SCSI and UFS error
 handling
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>
References: <20210722033439.26550-1-bvanassche@acm.org>
 <20210722033439.26550-17-bvanassche@acm.org>
 <88e0dc4c-34ff-6d87-fa9f-2fc924f50369@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c63ad911-e9cd-8480-ad79-4b7bd9c6a8c7@intel.com>
Date:   Sun, 29 Aug 2021 12:57:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <88e0dc4c-34ff-6d87-fa9f-2fc924f50369@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 28/08/21 12:47 pm, Adrian Hunter wrote:
> On 22/07/21 6:34 am, Bart Van Assche wrote:
>> Use the SCSI error handler instead of a custom error handling strategy.
>> This change reduces the number of potential races in the UFS drivers since
>> the UFS error handler and the SCSI error handler no longer run concurrently.
>>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Stanley Chu <stanley.chu@mediatek.com>
>> Cc: Can Guo <cang@codeaurora.org>
>> Cc: Asutosh Das <asutoshd@codeaurora.org>
>> Cc: Avri Altman <avri.altman@wdc.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
> 
> Hi
> 
> There is a deadlock that seems to be related to this patch, because now
> requests are blocked while the error handler waits on the host_sem.
> 
> 
> Example:
> 
> ufshcd_err_handler() races with ufshcd_wl_suspend() for host_sem.
> ufshcd_wl_suspend() wins the race but now PM requests deadlock:
> 
> because:
>  scsi_queue_rq() -> scsi_host_queue_ready() -> scsi_host_in_recovery() is FALSE

That is scsi_host_queue_ready() is FALSE because scsi_host_in_recovery() is TRUE

> 
> because:
>  scsi_schedule_eh() has done:
> 	    scsi_host_set_state(shost, SHOST_RECOVERY) == 0 ||
> 	    scsi_host_set_state(shost, SHOST_CANCEL_RECOVERY) == 0)
> 
> 
> Some questions for thought:
> 
> Won't any holder of host_sem deadlock if it tries to do SCSI requests
> and the error handler is waiting on host_sem?
> 
> Won't runtime resume deadlock if it is initiated by the error handler?
> 
> 
> Regards
> Adrian
> 

