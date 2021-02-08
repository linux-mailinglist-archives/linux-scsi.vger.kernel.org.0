Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED897312C09
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Feb 2021 09:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBHIkN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 8 Feb 2021 03:40:13 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:10158 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230305AbhBHIfd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 8 Feb 2021 03:35:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612773313; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=B9NpeYlgAht7Rfozxc2Prjjz/sdwVB6xwetFGGlZF9g=;
 b=eYYyw/SX4sil/C977XPHOr/yZCuonV4soZka8Izpe70P1IPCgcmw0JYsfr0IfLL9RVxk7nDD
 XK04ljtsTnEgEZuxomIacOPq1FJEjzu44oyPx13GhfxjpdtfKjU+FO+pb5wZlPN95e1bGDp8
 KJGk67A0eRazPEubSshm1TNFRB0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6020f79a8e43a988b7664bfd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 08:34:34
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86747C43467; Mon,  8 Feb 2021 08:34:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2DE7C43462;
        Mon,  8 Feb 2021 08:34:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Feb 2021 16:34:33 +0800
From:   Can Guo <cang@codeaurora.org>
To:     daejun7.park@samsung.com
Cc:     Greg KH <gregkh@linuxfoundation.org>, avri.altman@wdc.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, stanley.chu@mediatek.com,
        huobean@gmail.com, bvanassche@acm.org,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>
Subject: Re: [PATCH v19 2/3] scsi: ufs: L2P map management for HPB read
In-Reply-To: <20210208080333epcms2p59403f0acbc9730c9a605d265836a956d@epcms2p5>
References: <5bd43da52369a56f18867fa18efb3020@codeaurora.org>
 <20210129052848epcms2p6e5797efd94e6282b76ad9ae6c99e3ab5@epcms2p6>
 <20210129053005epcms2p323338fbb83459d2786fc0ef92701b147@epcms2p3>
 <CGME20210129052848epcms2p6e5797efd94e6282b76ad9ae6c99e3ab5@epcms2p5>
 <20210208080333epcms2p59403f0acbc9730c9a605d265836a956d@epcms2p5>
Message-ID: <88b608e2e133ba7ccd5bb452898848fd@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-02-08 16:03, Daejun Park wrote:
>> @@ -342,13 +1208,14 @@ void ufshpb_suspend(struct ufs_hba *hba)
>> >  	struct scsi_device *sdev;
>> >
>> >  	shost_for_each_device(sdev, hba->host) {
>> > -		hpb = sdev->hostdata;
>> > +		hpb = ufshpb_get_hpb_data(sdev);
>> >  		if (!hpb)
>> >  			continue;
>> >
>> >  		if (ufshpb_get_state(hpb) != HPB_PRESENT)
>> >  			continue;
>> >  		ufshpb_set_state(hpb, HPB_SUSPEND);
>> > +		ufshpb_cancel_jobs(hpb);
>> 
>> Here may have a dead lock problem - in the case of runtime suspend,
>> when ufshpb_suspend() is invoked, all of hba's children scsi devices
>> are in RPM_SUSPENDED state. When this line tries to cancel a running
>> map work, i.e. when ufshpb_get_map_req() calls below lines, it will
>> be stuck at blk_queue_enter().
>> 
>> req = blk_get_request(hpb->sdev_ufs_lu->request_queue,
>> 		      REQ_OP_SCSI_IN, 0);
>> 
>> Please check block layer power management, and see also commit 
>> d55d15a33
>> ("scsi: block: Do not accept any requests while suspended").
> 
> I am agree with your comment.
> How about add BLK_MQ_REQ_NOWAIT flag on blk_get_request() to avoid 
> hang?
> 

That won't work - BLK_MQ_REQ_NOWAIT allows one to fast fail from 
blk_mq_get_tag(),
but blk_queue_enter() comes before __blk_mq_alloc_request();

Regards,

Can Guo.

> Thanks,
> Daejun
