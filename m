Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67140506AAA
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Apr 2022 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351573AbiDSLiI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Apr 2022 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351541AbiDSLhy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 Apr 2022 07:37:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB932529B;
        Tue, 19 Apr 2022 04:35:09 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjM9K12jxzFqS9;
        Tue, 19 Apr 2022 19:32:37 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 19:35:06 +0800
Message-ID: <625E9E69.2060008@hisilicon.com>
Date:   Tue, 19 Apr 2022 19:35:05 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jan Kotas <jank@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Li Wei <liwei213@huawei.com>,
        Avri Altman <avri.altman@wdc.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: (subset) [PATCH v3 09/12] arm64: dts: hisilicon: align 'freq-table-hz'
 with dtschema in UFS
References: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com> <20220306111125.116455-10-krzysztof.kozlowski@canonical.com> <165036314214.180327.9388318751451146287.b4-ty@linaro.org>
In-Reply-To: <165036314214.180327.9388318751451146287.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Krzysztof,

On 2022/4/19 18:12, Krzysztof Kozlowski wrote:
> On Sun, 6 Mar 2022 12:11:22 +0100, Krzysztof Kozlowski wrote:
>> The DT schema expects 'freq-table-hz' property to be an uint32-matrix,
>> which is also easier to read.
>>
>>
> 
> Applied, thanks!
> 
> [09/12] arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS
>         commit: 65b96377bf9130617ced41f317f3ec387d3e0dc3
> 

Thanks!

Best Regards,
Wei

> Best regards,
> 

