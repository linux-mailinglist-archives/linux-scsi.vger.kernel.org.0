Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65F42C95C9
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Dec 2020 04:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgLADaZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Nov 2020 22:30:25 -0500
Received: from z5.mailgun.us ([104.130.96.5]:43845 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgLADaY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 30 Nov 2020 22:30:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606793398; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3e5O5WzuaYMeaQ05gvvQ0q7C+TOB0SwgYc2NPdP+STo=;
 b=kA7Z5Jw2kZXuog24sCgvqZVIVqATwlHvNzQ5IJj6H0GiwJXB5sOoTCuSsAAr++BYu9mVK4kY
 psKyLq4jLAbW+gRRsIn8UkEEV1CeUF7pRT3nzXjI/sZ5WOA9kTpUtErYKJX2Zhp6HWYzbTmT
 UOlXBV7I1r3ZQEPN8a/rCyGm4NQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fc5b89c51762b1886534496 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Dec 2020 03:29:32
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D637DC43463; Tue,  1 Dec 2020 03:29:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44E0AC433C6;
        Tue,  1 Dec 2020 03:29:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Dec 2020 11:29:29 +0800
From:   Can Guo <cang@codeaurora.org>
To:     "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        beanhuo@micron.com, matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nguyenb@codeaurora.org, kuohong.wang@mediatek.com,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        andy.teng@mediatek.com, chaotian.jing@mediatek.com,
        cc.chou@mediatek.com, jiajie.hao@mediatek.com,
        alice.chao@mediatek.com
Subject: Re: [RFC PATCH v1] scsi: ufs: Remove pre-defined initial VCC voltage
 values
In-Reply-To: <bf6e03ee-95ab-4768-7ce5-7f196ab6db60@codeaurora.org>
References: <20201130091610.2752-1-stanley.chu@mediatek.com>
 <568660cd-80e6-1b8f-d426-4614c9159ff4@codeaurora.org>
 <X8V83T+Tx6teNLOR@builder.lan>
 <4335d590-0506-d920-8e7f-f0f0372780f9@codeaurora.org>
 <X8WwPs1MPg64FEp8@builder.lan>
 <bf6e03ee-95ab-4768-7ce5-7f196ab6db60@codeaurora.org>
Message-ID: <e2a2c2c7e4de03ac04d812b95aa55c69@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-12-01 11:19, Asutosh Das (asd) wrote:
> On 11/30/2020 6:53 PM, Bjorn Andersson wrote:
>> On Mon 30 Nov 17:54 CST 2020, Asutosh Das (asd) wrote:
>> 
>>> On 11/30/2020 3:14 PM, Bjorn Andersson wrote:
>>>> On Mon 30 Nov 16:51 CST 2020, Asutosh Das (asd) wrote:
>>>> 
>>>>> On 11/30/2020 1:16 AM, Stanley Chu wrote:
>>>>>> UFS specficication allows different VCC configurations for UFS 
>>>>>> devices,
>>>>>> for example,
>>>>>> 	(1). 2.70V - 3.60V (By default)
>>>>>> 	(2). 1.70V - 1.95V (Activated if "vcc-supply-1p8" is declared in
>>>>>>                              device tree)
>>>>>> 	(3). 2.40V - 2.70V (Supported since UFS 3.x)
>>>>>> 
>>>>>> With the introduction of UFS 3.x products, an issue is happening 
>>>>>> that
>>>>>> UFS driver will use wrong "min_uV/max_uV" configuration to toggle 
>>>>>> VCC
>>>>>> regulator on UFU 3.x products with VCC configuration (3) used.
>>>>>> 
>>>>>> To solve this issue, we simply remove pre-defined initial VCC 
>>>>>> voltage
>>>>>> values in UFS driver with below reasons,
>>>>>> 
>>>>>> 1. UFS specifications do not define how to detect the VCC 
>>>>>> configuration
>>>>>>       supported by attached device.
>>>>>> 
>>>>>> 2. Device tree already supports standard regulator properties.
>>>>>> 
>>>>>> Therefore VCC voltage shall be defined correctly in device tree, 
>>>>>> and
>>>>>> shall not be changed by UFS driver. What UFS driver needs to do is 
>>>>>> simply
>>>>>> enabling or disabling the VCC regulator only.
>>>>>> 
>>>>>> This is a RFC conceptional patch. Please help review this and feel
>>>>>> free to feedback any ideas. Once this concept is accepted, and 
>>>>>> then
>>>>>> I would post a more completed patch series to fix this issue.
>>>>>> 
>>>>>> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
>>>>>> ---
>>>>>>     drivers/scsi/ufs/ufshcd-pltfrm.c | 10 +---------
>>>>>>     1 file changed, 1 insertion(+), 9 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c 
>>>>>> b/drivers/scsi/ufs/ufshcd-pltfrm.c
>>>>>> index a6f76399b3ae..3965be03c136 100644
>>>>>> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
>>>>>> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
>>>>>> @@ -133,15 +133,7 @@ static int ufshcd_populate_vreg(struct device 
>>>>>> *dev, const char *name,
>>>>>>     		vreg->max_uA = 0;
>>>>>>     	}
>>>>>> -	if (!strcmp(name, "vcc")) {
>>>>>> -		if (of_property_read_bool(np, "vcc-supply-1p8")) {
>>>>>> -			vreg->min_uV = UFS_VREG_VCC_1P8_MIN_UV;
>>>>>> -			vreg->max_uV = UFS_VREG_VCC_1P8_MAX_UV;
>>>>>> -		} else {
>>>>>> -			vreg->min_uV = UFS_VREG_VCC_MIN_UV;
>>>>>> -			vreg->max_uV = UFS_VREG_VCC_MAX_UV;
>>>>>> -		}
>>>>>> -	} else if (!strcmp(name, "vccq")) {
>>>>>> +	if (!strcmp(name, "vccq")) {
>>>>>>     		vreg->min_uV = UFS_VREG_VCCQ_MIN_UV;
>>>>>>     		vreg->max_uV = UFS_VREG_VCCQ_MAX_UV;
>>>>>>     	} else if (!strcmp(name, "vccq2")) {
>>>>>> 
>>>>> 
>>>>> Hi Stanley
>>>>> 
>>>>> Thanks for the patch. Bao (nguyenb) was also working towards 
>>>>> something
>>>>> similar.
>>>>> Would it be possible for you to take into account the scenario in 
>>>>> which the
>>>>> same platform supports both 2.x and 3.x UFS devices?
>>>>> 
>>>>> These've different voltage requirements, 2.4v-3.6v.
>>>>> I'm not sure if standard dts regulator properties can support this.
>>>>> 
>>>> 
>>>> What is the actual voltage requirement for these devices and how 
>>>> does
>>>> the software know what voltage to pick in this range?
>>>> 
>>>> Regards,
>>>> Bjorn
>>>> 
>>>>> -asd
>>>>> 
>>>>> 
>>>>> -- The Qualcomm Innovation Center, Inc. is a member of the Code 
>>>>> Aurora Forum,
>>>>> Linux Foundation Collaborative Project
>>> 
>>> For platforms that support both 2.x (2.7v-3.6v) and 3.x (2.4v-2.7v), 
>>> the
>>> voltage requirements (Vcc) are 2.4v-3.6v. The software initializes 
>>> the ufs
>>> device at 2.95v & reads the version and if the device is 3.x, it may 
>>> do the
>>> following:
>>> - Set the device power mode to SLEEP
>>> - Disable the Vcc
>>> - Enable the Vcc and set it to 2.5v
>>> - Set the device power mode to ACTIVE
>>> 
>>> All of the above may be done at HS-G1 & moved to max supported gear 
>>> based on
>>> the device version, perhaps?
>>> 
>>> Am open to other ideas though.
>>> 
>> 
>> But that means that for a board where we don't know (don't want to 
>> know)
>> if we have a 2.x or 3.x device we need to set:
>> 
>>    regulator-min-microvolt = <2.4V>
>>    regulator-max-microvolt = <3.6V>
>> 
>> And the 2.5V and the two ranges should be hard coded into the ufshcd 
>> (in
>> particular if they come from the specification).
>> 
>> For devices with only 2.x or 3.x devices, 
>> regulator-{min,max}-microvolt
>> should be adjusted accordingly.
>> 
>> Note that driving the regulators outside these ranges will either 
>> damage
>> the hardware or cause it to misbehave, so these values should be 
>> defined
>> in the board.dts anyways.
>> 
>> Also note that regulator_set_voltage(2.4V, 3.6V) won't give you "a
>> voltage between 2.4V and 3.6V, it will most likely give either 2.4V or
>> any more specific voltage that we've specified in the board file 
>> because
>> the regulator happens to be shared with some other consumer and 
>> changing
>> it in runtime would be bad.
>> 
>> Regards,
>> Bjorn
>> 
> 
> Understood.
> I also understand that assumptions on the regulator limits in the
> driver is a bad idea. I'm not sure how it's designed, but I should
> think the power-grid design should take care of regulator sharing; if
> it's being shared and the platform supports both 2.x and 3.x. Perhaps,
> such platforms be identified using a dts flag - not sure if that's
> such a good idea though.
> 
> I like Stanley's proposal of a vops and let vendors handle it, until
> specs or someone has a better suggestion.

Agree, vops is all we need as of now, please upload a change to add one 
properly.

Thanks,

Can Guo.

> 
> -asd
