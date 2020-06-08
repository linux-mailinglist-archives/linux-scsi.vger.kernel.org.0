Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6BA1F118B
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jun 2020 04:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgFHCx2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Jun 2020 22:53:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42790 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFHCx1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Jun 2020 22:53:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0582qxNA090132;
        Sun, 7 Jun 2020 21:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591584779;
        bh=dhAMeBt4kcAcqu7sDNT2ZR+MCN19NDKXPCvR8Kg/PyM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HuziIkI3O+Uc/IRLX7VYCKHDJ1K5N5kJ1HYi8g8DLTM4j+xhrc8vSQ9O2P5z+4znC
         Mi3z2C/W+5Tnz2ljlejhJmrf8J1TmOiFVsJrbJbeYmAvdHzwyogClErINglpnph1JT
         2l3e67rBetMBW7H2o9qaZyHwV5m0zeAoKN70hHa4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0582qxhx112430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Jun 2020 21:52:59 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Jun
 2020 21:52:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Jun 2020 21:52:59 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0582qs9R005834;
        Sun, 7 Jun 2020 21:52:55 -0500
Subject: Re: [PATCH v10 00/10] exynos-ufs: Add support for UFS HCI
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        <robh@kernel.org>
CC:     <krzk@kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <avri.altman@wdc.com>, <stanley.chu@mediatek.com>,
        <linux-scsi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <cang@codeaurora.org>,
        <devicetree@vger.kernel.org>, <kwmad.kim@samsung.com>,
        <linux-kernel@vger.kernel.org>, "'Vinod Koul'" <vkoul@kernel.org>
References: <CGME20200528013223epcas5p2be85fa8803326b49a905fb7225992cad@epcas5p2.samsung.com>
 <20200528011658.71590-1-alim.akhtar@samsung.com>
 <159114947915.26776.12485309894552696104.b4-ty@oracle.com>
 <013a01d63d3e$ecf404d0$c6dc0e70$@samsung.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <89b96bd0-a9a3-cdd8-dc67-1f9f49eef264@ti.com>
Date:   Mon, 8 Jun 2020 08:22:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <013a01d63d3e$ecf404d0$c6dc0e70$@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Alim,

On 6/8/2020 8:15 AM, Alim Akhtar wrote:
> 
> 
>> -----Original Message-----
>> From: Martin K. Petersen <martin.petersen@oracle.com>
>> Sent: 03 June 2020 08:02
>> To: robh@kernel.org; Alim Akhtar <alim.akhtar@samsung.com>
>> Cc: Martin K . Petersen <martin.petersen@oracle.com>; krzk@kernel.org;
> linux-
>> samsung-soc@vger.kernel.org; avri.altman@wdc.com;
>> stanley.chu@mediatek.com; linux-scsi@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; cang@codeaurora.org;
> devicetree@vger.kernel.org;
>> kwmad.kim@samsung.com; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v10 00/10] exynos-ufs: Add support for UFS HCI
>>
>> On Thu, 28 May 2020 06:46:48 +0530, Alim Akhtar wrote:
>>
>>> This patch-set introduces UFS (Universal Flash Storage) host
>>> controller support for Samsung family SoC. Mostly, it consists of UFS
>>> PHY and host specific driver.
>>> [...]
>>
>> Applied [1,2,3,4,5,9] to 5.9/scsi-queue. The series won't show up in my
> public
>> tree until shortly after -rc1 is released.
>>
> Thanks Martin,
> Hi Rob and Kishon/Vinod
> Can you please pickup dt-bindings and PHY driver respectively?

You might have CC'ed me only for the PHY patch. I don't have the dt-bindings in
my inbox. Care to re-send what's missing again? This will be merged after -rc1
is tagged.

Thanks
Kishon

> 
>> Thanks!
>>
>> --
>> Martin K. Petersen	Oracle Linux Engineering
> 
