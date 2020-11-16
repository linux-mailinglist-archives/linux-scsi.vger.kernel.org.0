Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C612B3B2A
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Nov 2020 02:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgKPBTx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Nov 2020 20:19:53 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:26544 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgKPBTx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 15 Nov 2020 20:19:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605489592; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=v6KLhXj+620b0Cqk/wXyGVyIAZ1iI29OVn20Cf4L4r0=;
 b=I6T1s1DJpNFbHjxgo3Fjqz4JICGoLeKYr4QHV8cR4tc6mOhYBQCavnPG1+vcn/DCsSbIzDpk
 6iV1KtsiA2Ic6HPeknagNmE06KvYEyI3hDuaYxHRxm0QIkwGnsDvxjH4J1rUdD9xSvtTgTh+
 ZB/NDayEBd9AI9vKUKjfWR7Uobc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fb1d3b857dd92cbec9fe47a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 01:19:52
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 668A7C43460; Mon, 16 Nov 2020 01:19:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13408C433C6;
        Mon, 16 Nov 2020 01:19:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Nov 2020 09:19:49 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH RFC v1 1/1] scsi: pm: Leave runtime resume along if block
 layer PM is enabled
In-Reply-To: <97dea590-5f2e-b4e3-ac64-7c346761c523@acm.org>
References: <1605249009-13752-1-git-send-email-cang@codeaurora.org>
 <1605249009-13752-2-git-send-email-cang@codeaurora.org>
 <97dea590-5f2e-b4e3-ac64-7c346761c523@acm.org>
Message-ID: <cd1ae6b2740a0211efe7e602691fd5e4@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

On 2020-11-15 04:57, Bart Van Assche wrote:
> On 11/12/20 10:30 PM, Can Guo wrote:
>> If block layer runtime PM is enabled for one SCSI device, then there 
>> is
>> no need to forcibly change the SCSI device and its request queue's 
>> runtime
>> PM status to active in scsi_dev_type_resume(), since block layer PM 
>> shall
>> resume the SCSI device on the demand of bios.
> 
> Please change "along" into "alone" in the subject of this patch (if 
> that
> is what you meant).
> 

Aha, sorry, a typo here.

>> +	if (scsi_is_sdev_device(dev)) {
>> +		struct scsi_device *sdev;
>> 
>> +		sdev = to_scsi_device(dev);
> 
> A minor comment: I think that "struct scsi_device *sdev =
> to_scsi_device(dev);" fits on a single line.
> 

Sure.

>> +		 * If block layer runtime PM is enabled for the SCSI device,
>> +		 * let block layer PM handle its runtime PM routines.
> 
> Please change "its runtime PM routines" into "runtime resume" or
> similar. I think that will make the comment more clear.
> 

Yes, thanks.

>> +		if (sdev->request_queue->dev)
>> +			return err;
>> +	}
> 
> The 'dev' member only exists in struct request_queue if CONFIG_PM=y so
> the above won't compile if CONFIG_PM=n. How about adding a function in
> include/linux/blk-pm.h to check whether or not runtime PM has been 
> enabled?
> 

You are right.

> Otherwise this patch looks good to me.

Actually, I am thinking about removing all the pm_runtime_set_active()
codes in both scsi_bus_resume_common() and scsi_dev_type_resume() - we
don't need to forcibly set the runtime PM status to RPM_ACTIVE for 
either
SCSI host/target or SCSI devices.

Whenever we access one SCSI device, either block layer or somewhere in
the path (e.g. throgh sg IOCTL, sg_open() calls 
scsi_autopm_get_device())
should runtime resume the device first, and the runtime PM framework 
makes
sure device's gets resumed as well. Thus, the pm_runtime_set_active() 
seems
redundant. What do you think?

Thanks,

Can Guo.

> 
> Thanks,
> 
> Bart.
