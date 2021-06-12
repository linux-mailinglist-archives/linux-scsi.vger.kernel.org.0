Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58833A4D70
	for <lists+linux-scsi@lfdr.de>; Sat, 12 Jun 2021 09:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFLHke (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 12 Jun 2021 03:40:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44263 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhFLHke (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 12 Jun 2021 03:40:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623483515; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Sqvb0JaG61PaXbtftxIbY4pVwmcAlQv37dOCDE0jmNY=;
 b=RfLH6PTKKBsXJv14I3+Vz9iuxHbN76Xlj8xR+u0oF0OQ3eysfTaBJ8mq+OgOdlxhLtKcXIpN
 yPTsxrDu+BI5hJiR6YRGAi3LRY7FaqA8Mavb2U5GV2Dq61GTI3qKSYd5jm68E6bCMB1paghZ
 wMTXFtrNWhObWBkHYy/fDAlyR5Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60c46467ed59bf69cc83018b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Jun 2021 07:38:15
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8287CC4360C; Sat, 12 Jun 2021 07:38:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7FCFC433D3;
        Sat, 12 Jun 2021 07:38:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 12 Jun 2021 15:38:14 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
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
Subject: Re: [PATCH v3 4/9] scsi: ufs: Complete the cmd before returning in
 queuecommand
In-Reply-To: <d017548a-16fb-8ad0-2363-09dad00c9642@acm.org>
References: <1623300218-9454-1-git-send-email-cang@codeaurora.org>
 <1623300218-9454-5-git-send-email-cang@codeaurora.org>
 <d017548a-16fb-8ad0-2363-09dad00c9642@acm.org>
Message-ID: <80926df7e3e41088e59ce5e0dbdec28a@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-06-12 04:52, Bart Van Assche wrote:
> On 6/9/21 9:43 PM, Can Guo wrote:
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 0c9d2ee..7dc0fda 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -2758,6 +2758,16 @@ static int ufshcd_queuecommand(struct Scsi_Host 
>> *host, struct scsi_cmnd *cmd)
>>  		goto out;
>>  	}
>> 
>> +	if (unlikely(test_bit(tag, &hba->outstanding_reqs))) {
>> +		if (hba->wl_pm_op_in_progress) {
>> +			set_host_byte(cmd, DID_BAD_TARGET);
>> +			cmd->scsi_done(cmd);
>> +		} else {
>> +			err = SCSI_MLQUEUE_HOST_BUSY;
>> +		}
>> +		goto out;
>> +	}
>> +
>>  	hba->req_abort_count = 0;
>> 
>>  	err = ufshcd_hold(hba, true);
>> @@ -2768,15 +2778,6 @@ static int ufshcd_queuecommand(struct Scsi_Host 
>> *host, struct scsi_cmnd *cmd)
>>  	WARN_ON(ufshcd_is_clkgating_allowed(hba) &&
>>  		(hba->clk_gating.state != CLKS_ON));
>> 
>> -	if (unlikely(test_bit(tag, &hba->outstanding_reqs))) {
>> -		if (hba->wl_pm_op_in_progress)
>> -			set_host_byte(cmd, DID_BAD_TARGET);
>> -		else
>> -			err = SCSI_MLQUEUE_HOST_BUSY;
>> -		ufshcd_release(hba);
>> -		goto out;
>> -	}
>> -
>>  	lrbp = &hba->lrb[tag];
>>  	WARN_ON(lrbp->cmd);
>>  	lrbp->cmd = cmd;
> 
> Can the code under "if (unlikely(test_bit(tag,
> &hba->outstanding_reqs)))" be deleted instead of moving it? I don't
> think that it is useful to verify whether the block layer tag allocator
> works correctly. Additionally, I'm not aware of any similar code in any
> other SCSI LLD.
> 

ufshcd_abort() aborts PM requests differently from other requests -
it simply evicts the cmd from lrbp [1], schedules error handler and
returns SUCCESS (the reason why I am doing it this way is in patch #8).

After ufshcd_abort() returns, the tag shall be released, the logic
here is to prevent subsequent cmds re-use the lrbp [1] before error
handler recovers the device and host.

Thanks,

Can Guo.

> Thanks,
> 
> Bart.
