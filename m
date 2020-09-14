Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFBD2683E1
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Sep 2020 07:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgINFBI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Sep 2020 01:01:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32420 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbgINFBH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 14 Sep 2020 01:01:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600059666; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=incIykKufp2vCbdHmRPdZFVE3aFFHufJedlCIBpyTrM=;
 b=xWiQPi4/rhWs9AJrJrc4ojtILXOQ0tadjH9zbPu/vX/KUBZtr/sYOuPweOZ9KAsgxs3JOIyg
 7D+HB7VPTsqi4kLAxpBai7MU5lZmkiZQMM2xugFOShgmfZQRBQgbRKzdO/pdCwFN1m/5JoXS
 xewCk14DZHe0YMs3QqBdyD2AAPA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f5ef8efcc683673f92bc9d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 05:00:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE400C433FF; Mon, 14 Sep 2020 05:00:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C38FC433C6;
        Mon, 14 Sep 2020 05:00:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 13:00:30 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] scsi: ufs: Abort tasks before clear them from
 doorbell
In-Reply-To: <d151d6a2b53cfbd7bf3f9c9313b49c4c404c4c5a.camel@gmail.com>
References: <1599099873-32579-1-git-send-email-cang@codeaurora.org>
 <1599099873-32579-2-git-send-email-cang@codeaurora.org>
 <1599627906.10803.65.camel@linux.ibm.com>
 <yq14ko62wn5.fsf@ca-mkp.ca.oracle.com>
 <1599706080.10649.30.camel@mtkswgap22>
 <1599718697.3851.3.camel@HansenPartnership.com>
 <1599725880.10649.35.camel@mtkswgap22>
 <1599754148.3575.4.camel@HansenPartnership.com>
 <010101747af387e9-f68ac6fa-1bc6-461d-92ec-dc0ee4486728-000000@us-west-2.amazonses.com>
 <d151d6a2b53cfbd7bf3f9c9313b49c4c404c4c5a.camel@gmail.com>
Message-ID: <030cecc931ef5d210c89d4541c2adea2@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-09-11 17:09, Bean Huo wrote:
> On Fri, 2020-09-11 at 02:16 +0000, Can Guo wrote:
>> > >
>> > > So your resolution looks good to me.
>> > >
>> > > Thanks so much : )
>> >
>> > You're welcome ... but just remember I have to explain this to
>> > Linus
>> > when the merge window opens.  It would be a lot easier if this
>> > hadn't
>> > happened so please don't make it any worse ...
>> >
>> > James
>> 
>> Sorry that my changes got you confused and thank you for help
>> resolve
>> the
>> conflicts. My change ("scsi: ufs: Abort tasks before clearing them
>> from
>> doorbell") is to serve my fixes to ufs error recovery which only got
>> picked
>> up on scsi-queue-5.10. So I checked out to scsi-queue-5.10 and made
>> my
>> changes on the tip of scsi-queue-5.10, below 2 changes were not even
>> present in scsi-queue-5.10 back that time.
> 
> I mentioned here https://patchwork.kernel.org/patch/11734713/
> 
> this change (scsi: ufs: Abort tasks before clearing them from doorbell)
> has conflicts with the scsi-fixes branch. I don't know which branch is
> the main branch we should focus on.
> 
> 
> Bean

Yeah, I know that one, but I was not even working on scsi-fixes branch
at that time. Now I have two more fixes to ufshcd_abort(), not sure
which branch I should work on, so asking the same here.

Regards,

Can Guo.
