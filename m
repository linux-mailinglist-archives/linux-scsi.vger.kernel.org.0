Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A899AFBD64
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Nov 2019 02:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfKNBSU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Nov 2019 20:18:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNBST (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 13 Nov 2019 20:18:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6F74260D85; Thu, 14 Nov 2019 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573694298;
        bh=u5vRIXV5qHvRwmoVSfcZHp7ushgdb7aZN/PjAN8IygQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BwgecA2IyMHTv/JlRDzVRZS+QD32i5hOe0I9ZVBgB93DUPwt9SqHdVqdEWmXQTOvA
         axTUhsHksXCBVQbFgMTD0QrIZQcJwiVwkdd0MJ0esIfaAJDFfg6zD6ccFhQPUye7Tm
         W7QdONdCd713u62SpPMtyKkUOrrOVcpUw2p6xn/8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 30954602F7;
        Thu, 14 Nov 2019 01:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573694296;
        bh=u5vRIXV5qHvRwmoVSfcZHp7ushgdb7aZN/PjAN8IygQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VFhyJjum3Ca3bmZFsw62G/rOUVPPRD69EbvSn7E2tfKfAZ33ShEmdwq4WVzBL48FC
         NXbEuEJz/QHoeSgydsll0HCyiNTZxCNgh40qFnGOoku91MIlFj9ODyzTR9aISMoigD
         xfJEqqiTyajCCB4TMUx/wCrY/mcIjrDY+34O1IRA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Nov 2019 09:18:16 +0800
From:   cang@codeaurora.org
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [EXT] [PATCH v1 5/5] scsi: ufs: Complete pending requests in host
 reset and restore path
In-Reply-To: <0dc202a1decb6bbc103253b8c3c8c8ce@codeaurora.org>
References: <1573200932-384-1-git-send-email-cang@codeaurora.org>
 <1573200932-384-6-git-send-email-cang@codeaurora.org>
 <BN7PR08MB56849EEE83414549F4787BCEDB760@BN7PR08MB5684.namprd08.prod.outlook.com>
 <0dc202a1decb6bbc103253b8c3c8c8ce@codeaurora.org>
Message-ID: <760d101a874e934f205701d282b3cc6f@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-11-14 09:03, cang@codeaurora.org wrote:
> On 2019-11-14 06:04, Bean Huo (beanhuo) wrote:
>>> 
>>> In UFS host reset and restore path, before probe, we stop and start 
>>> the host
>>> controller once. After host controller is stopped, the pending 
>>> requests, if any,
>>> are cleared from the doorbell, but no completion IRQ would be raised 
>>> due to the
>>> hba is stopped.
>>> These pending requests shall be completed along with the first 
>>> NOP_OUT
>>> command(as it is the first command which can raise a transfer 
>>> completion
>>> IRQ) sent during probe.
>> 
>> Hi, Can
>> I am not sure for this point, because there is HW/SW device reset
>> before or after host reset/restore.
>> Device HW/SW reset also will clear the pended tasks in device side.
>> That will be better.
>> I think Qcom platform already enabled HW reset.
>> 
>> //Bean
>> 
> 
> Hi Bean,
> 
> By pending tasks here, it means the requests sent down from scsi/block 
> layer,
> but have not yet been handled by ufs driver(cmd->scsi_done() have not
> been called yet for these requests).
> For these requests, although removed by host and UFS device in their
> HW queues(doorbell),
> UFS driver still needs to complete them from SW side(call
> cmd->scsi_done() for each one of them) to
> let upper layer know that they are finished(although not successfully)
> to avoid hitting
> timeout of these pending tasks. I hope I make my explanation clearly.
> 
> Best Regards,
> Can Guo.
> 

Hi Bean,

Just want to add up more phrases. We do have HW/SW reset.
Sorry about below lines which make you confused. Here I am just 
describing what
is like with previous code. Since these pending requests does not have
a chance to be handled in their IRQ handler after hba is stopped, and as
they have been cleared from doorbell already, then once there is an 
available
transfer completion IRQ, these requests will be handled in the IRQ 
handler,
no matter what is the transfer completion IRQ fired for. And NOP_OUT is 
just
the first command that can fire a transer completion IRQ.

Can Guo.

These pending requests shall be completed along with the first NOP_OUT
command(as it is the first command which can raise a transfer completion
IRQ) sent during probe.

>>> Since the OCSs of these pending requests are not SUCCESS(because they 
>>> are not
>>> yet literally finished), their UPIUs shall be dumped. When there are 
>>> multiple
>>> pending requests, the UPIU dump can be overwhelming and may lead to 
>>> stability
>>> issues because it is in atomic context.
>>> Therefore, before probe, complete these pending requests right after 
>>> host
>>> controller is stopped.
