Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F0211FD28
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Dec 2019 04:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLPDM5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Dec 2019 22:12:57 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:28636 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbfLPDM5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 15 Dec 2019 22:12:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576465976; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZiprUrxn1OzSYakAwRmYe3AjoV9ggkxRRD81sZxogTQ=;
 b=hkeePl87UKhIWyDQQNCqyXYnMGM2hOl6teDIFNCh+/1PQCLG81PihfVHDx5NPudibDDsFZKH
 hjm6wvR8Qkxxk+APCTbhluxVMKhp8ndx6+DSk2XzrKcncl7ryuUkU5/tw5MozBvNEHq5Dnpl
 wy3q+hm54MKwKmvy1Bk92h9OUwU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df6f638.7f6cfb1b88b8-smtp-out-n03;
 Mon, 16 Dec 2019 03:12:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38C39C447A5; Mon, 16 Dec 2019 03:12:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 287DEC433CB;
        Mon, 16 Dec 2019 03:12:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Dec 2019 11:12:53 +0800
From:   cang@codeaurora.org
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] scsi: ufs: Put SCSI host after remove it
In-Reply-To: <5b77c25f-3cc7-f90b-fcd7-dd4c1e2f46d2@acm.org>
References: <1576328616-30404-1-git-send-email-cang@codeaurora.org>
 <1576328616-30404-2-git-send-email-cang@codeaurora.org>
 <85475247-efd5-732e-ae74-6d9a11e1bdf2@acm.org>
 <5aa3a266e3db3403e663b36ddfdc4d60@codeaurora.org>
 <2956b9c7-b019-e2b3-7a1b-7b796b724add@acm.org>
 <3afbe71cc9f0626edf66f7bc13b331f4@codeaurora.org>
 <5b77c25f-3cc7-f90b-fcd7-dd4c1e2f46d2@acm.org>
Message-ID: <0419d33a1ea98a2da9263131aba2ca71@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-12-16 10:39, Bart Van Assche wrote:
> On 2019-12-15 17:34, cang@codeaurora.org wrote:
>> This is applied to 5.5/scsi-queue. The two changes I patsed from you 
>> are
>> not merged yet, I am still doing code review to them, so there is no
>> blk_cleanup_queue() calls in my code base. I am just saying you may 
>> move
>> your blk_cleanup_queue() calls below cancel_work_sync(&hba->eh_work) 
>> if
>> my change applies. How do you think?
>> 
>> scsi_host_put() was there before but explicitly removed by
>> afa3dfd42d205b106787476647735aa1de1a5d02. I agree with you, without 
>> this
>> change, there is memory leak.
> 
> Hi Can,
> 
> Since your patch restores a call that was removed earlier, please
> consider adding a Fixes: tag to your patch.
> 
> Please also have a look at
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/log/?h=5.6/scsi-queue.
> As one can see my patches that introduce blk_cleanup_queue() and
> blk_mq_free_tag_set() calls have already been queued on Martin's
> 5.6/scsi-queue branch.
> 
> Bart.

Hi Bart,

Sure, I will add the Fixes tag and rebase my changes. How about the 
logic
part of this change? Does it look good to you?

Sorry I was not aware of that your changes have been applied to 
5.6/scsi-queue.
I am still trying to get it tested on my setups...
Anyways, aside of hba->cmd_queue, tearing down hba->tmf_queue before
scsi_remove_host() may be problem too. Requests can still be
sent before and during scsi_remove_host(). If a request timed out,
task abort will be invoked to abort the request, during which
hba->tmf_queue is expected to be present. Please correct me if I am 
wrong.

Thanks,

Can Guo.
