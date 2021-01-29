Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2A308579
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Jan 2021 07:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhA2GHM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 Jan 2021 01:07:12 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:20641 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhA2GHK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 29 Jan 2021 01:07:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611900412; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0rkQubtuEtIqttDY1T0ryEW5Vzh9FrLlo5uy520HbSI=;
 b=b1TKLdvD5FtB7sD6usKlbVdmUvNVxfV10n5IJlkh8E8SIxkbW4AfT61LThvwlW8ek/dHJZmy
 sqWj1rT26z3sBr9gpFiqlFvphiQ1zXcTMw0KYDmgjgTR7CCFpTYM4bKInz6/JcxDhubtkoiN
 /4Y4AvSvUw3lN0XQ1RTQpGD8bRo=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6013a5db262adddd45c31331 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 Jan 2021 06:06:19
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19798C43465; Fri, 29 Jan 2021 06:06:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 412E8C433CA;
        Fri, 29 Jan 2021 06:06:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Jan 2021 14:06:18 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     jaegeuk@kernel.org, asutoshd@codeaurora.org,
        nguyenb@codeaurora.org, hongwus@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] scsi: ufs: Fix a race condition btw task
 management request send and compl
In-Reply-To: <73362ca9-93be-c38f-a881-4b7cf690fbc1@acm.org>
References: <1611807365-35513-1-git-send-email-cang@codeaurora.org>
 <1611807365-35513-3-git-send-email-cang@codeaurora.org>
 <73362ca9-93be-c38f-a881-4b7cf690fbc1@acm.org>
Message-ID: <5f77542d66732003f0154a4e8a6ae13b@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-01-29 11:20, Bart Van Assche wrote:
> On 1/27/21 8:16 PM, Can Guo wrote:
>> ufshcd_compl_tm() looks for all 0 bits in the 
>> REG_UTP_TASK_REQ_DOOR_BELL
>> and call complete() for each req who has the req->end_io_data set. 
>> There
>> can be a race condition btw tmc send/compl, because the 
>> req->end_io_data is
>> set, in __ufshcd_issue_tm_cmd(), without host lock protection, so it 
>> is
>> possible that when ufshcd_compl_tm() checks the req->end_io_data, it 
>> is set
>> but the corresponding tag has not been set in 
>> REG_UTP_TASK_REQ_DOOR_BELL.
>> Thus, ufshcd_tmc_handler() may wrongly complete TMRs which have not 
>> been
>> sent out. Fix it by protecting req->end_io_data with host lock, and 
>> let
>> ufshcd_compl_tm() only handle those tm cmds which have been completed
>> instead of looking for 0 bits in the REG_UTP_TASK_REQ_DOOR_BELL.
> 
> I don't know any other block driver that needs locking to protect races
> between submission and completion context. Can the block layer timeout
> mechanism be used instead of the mechanism introduced by this patch,
> e.g. by using blk_execute_rq_nowait() to submit requests? That would
> allow to reuse the existing mechanism in the block layer core to handle
> races between request completion and timeout handling.

This patch is not introducing any new mechanism, it is fixing the
usage of completion (req->end_io_data = c) introduced by commit
69a6c269c097 ("scsi: ufs: Use blk_{get,put}_request() to allocate
and free TMFs"). If you have better idea to get it fixed once for
all, we are glad to take your change to get it fixed asap.

Regards,

Can Guo.

> 
> Thanks,
> 
> Bart.
