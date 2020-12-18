Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB02DDE25
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Dec 2020 06:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgLRFn3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Dec 2020 00:43:29 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:29623 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgLRFn3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Dec 2020 00:43:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608270188; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=OwsFRegftF2w32/gXog44MqpD2EZ8WZconOVWoSuFSw=;
 b=UJYARiWevxuCOvyyJbvpfNw5gF79N/eID1uX6nkVg3OXv7oE0eN+Ydpwjz7F1xLC991IWHbS
 zr6tqvDQyKDBSp2M7H3WZqaCRFbz3IioTN5Y9UDVrEKJifHZyX8cGaijL+6kJdxaoTvxY/v6
 Aahu9kfYuK0wJVVxGmVaBMGmfe8=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fdc414d7549779c5b7b5876 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 05:42:37
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB450C43467; Fri, 18 Dec 2020 05:42:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E016BC433CA;
        Fri, 18 Dec 2020 05:42:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Dec 2020 13:42:35 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/1] scsi: ufs: Fix a possible NULL pointer issue
In-Reply-To: <7eb8f335f4eb85385f54c88952f7749750340320.camel@gmail.com>
References: <1607917296-11735-1-git-send-email-cang@codeaurora.org>
 <7eb8f335f4eb85385f54c88952f7749750340320.camel@gmail.com>
Message-ID: <44d4f6349b7c8d806871acbe22c2bcce@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-12-14 22:32, Bean Huo wrote:
> On Sun, 2020-12-13 at 19:41 -0800, Can Guo wrote:
>> Fixes: 88a92d6ae4fe ("scsi: ufs: Serialize eh_work with system PM
>> events and async scan")
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  drivers/scsi/ufs/ufshcd.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index c1c401b..ef155a9 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -8883,8 +8883,11 @@ int ufshcd_system_suspend(struct ufs_hba *hba)
>>         int ret = 0;
>>         ktime_t start = ktime_get();
>> 
>> +       if (!hba)
>> +               return 0;
>> +
>>         down(&hba->eh_sem);
>> -       if (!hba || !hba->is_powered)
>> +       if (!hba->is_powered)
>>                 return 0;
> 
> 
> Can,
> 
> why not moving down(&hba->eh_sem) after "return 0;"?

In your way, if hba is not powered, ufshcd_system_suspend() returns
0, which is a successful suspend. When ufshcd_system_resume() is called,
if hba is not powered, it goes to out and does up(&hba->eh_sem), which
shall cause unbalance to eh_sem.

Thanks,

Can Guo.
