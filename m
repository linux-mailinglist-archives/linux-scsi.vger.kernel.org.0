Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880CC1501E9
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Feb 2020 08:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgBCHQf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Feb 2020 02:16:35 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:29978 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgBCHQe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Feb 2020 02:16:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580714194; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jUeEF/Zuy5Iv2uD5XELfW5OO2/vfRduEY6ZeD7zd/Vc=;
 b=fRTd3xWlNqjWtpdN0mYXMHEjY/5QvKjjbeAnVo5D+nszxwhVmvMx1RLpV8tmKQDcKEwmNaz/
 qsEJ4F3U7kt824trlD/C9PsnyyYelN4//uGGO71hqWhJ9XOGl/9ByfdBl5UveGPdQY+3Pyit
 HBk3QjF4/hZjMtdRDl68MW73TIA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e37c8cd.7fcc923c9ae8-smtp-out-n03;
 Mon, 03 Feb 2020 07:16:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59490C447AA; Mon,  3 Feb 2020 07:16:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B22F0C43383;
        Mon,  3 Feb 2020 07:16:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Feb 2020 15:16:26 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] scsi: ufs: Add dev ref clock gating wait time
 support
In-Reply-To: <d51c7c51-482a-01c3-fae0-1e83f9df45ac@acm.org>
References: <1579764349-15578-1-git-send-email-cang@codeaurora.org>
 <1579764349-15578-7-git-send-email-cang@codeaurora.org>
 <d51c7c51-482a-01c3-fae0-1e83f9df45ac@acm.org>
Message-ID: <bcbd7e82b1ea6f653d5136e89e70c9f0@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-01-26 11:34, Bart Van Assche wrote:
> On 2020-01-22 23:25, Can Guo wrote:
>> +	/* getting Specification Version in big endian format */
>> +	hba->dev_info.spec_version = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 
>> 8 |
>> +				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
> 
> Please use get_unaligned_be16() instead of open-coding it.
> 
> Thanks,
> 
> Bart.

I am just keeping symmetry with the other device descriptors,
for example w_manufacturer_id.

Thanks,

Can Guo.
