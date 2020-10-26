Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A59298736
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 08:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1736788AbgJZHCk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 03:02:40 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:47924 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1736776AbgJZHCk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Oct 2020 03:02:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603695759; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4W30NrG0crD/eXRgkUetS2eftLP50C0CS9VL2EWCFO0=;
 b=v/QiIfKq0HBGwKPOaehyLVfS1qAEo7/LssOUxg2WtuARGXY3xN6HemluDBB7HzHqTUPxjPd7
 eQ9vo+mjZnREKERf29TPXqq808DyyFSRlNzXhX2ydHpU+kcdKfnBpNXU69aYHoMHVRi+TCD2
 xWsrAR1wPbNmmlFdx4lu8CfonnE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f96745babdbaddfebb337fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 07:01:47
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B14C2C433FF; Mon, 26 Oct 2020 07:01:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6EDCC433F0;
        Mon, 26 Oct 2020 07:01:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 15:01:45 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] scsi: ufs: Fix unexpected values get from
 ufshcd_read_desc_param()
In-Reply-To: <BY5PR04MB67056EDDDA22DEDAFD1972C1FC190@BY5PR04MB6705.namprd04.prod.outlook.com>
References: <1603346348-14149-1-git-send-email-cang@codeaurora.org>
 <BY5PR04MB6705D719530D5E188ECB724EFC1D0@BY5PR04MB6705.namprd04.prod.outlook.com>
 <5271e570f2e38770da3b23f13e739e41@codeaurora.org>
 <BY5PR04MB67056EDDDA22DEDAFD1972C1FC190@BY5PR04MB6705.namprd04.prod.outlook.com>
Message-ID: <28555cab045fb631c91262c77b71d9fc@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-10-26 13:22, Avri Altman wrote:
>> On 2020-10-22 14:37, Avri Altman wrote:
>> >> Since WB feature has been added, WB related sysfs entries can be
>> >> accessed
>> >> even when an UFS device does not support WB feature. In that case, the
>> >> descriptors which are not supported by the UFS device may be wrongly
>> >> reported when they are accessed from their corrsponding sysfs entries.
>> >> Fix it by adding a sanity check of parameter offset against the actual
>> >> decriptor length.s
>> > This should be a bug fix IMO, and be dealt with similarly like
>> > ufshcd_is_wb_attrs or ufshcd_is_wb_flag.
>> > Thanks,
>> > Avri
>> 
>> Could you please elaborate on ufshcd_is_wb_attrs or ufshcd_is_wb_flag?
>> Sorry that I don't quite get it.
> Since this change is only protecting illegal access from sysfs entries,
> I am suggesting to handle it there, just like ufshcd_is_wb_attrs or
> ufshcd_is_wb_flag
> Are doing it for flags and attributes.
> 
> Thanks,
> Avri

This is a general problem - if later we have HPB entries added into 
sysfs,
we will hit it again. We cannot keep adding checks like 
ufshcd_is_xxx_attrs
or ufshcd_is_xxx_flag to block them, right?

Thanks,

Can Guo.
