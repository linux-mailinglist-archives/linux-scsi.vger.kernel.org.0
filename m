Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF078F8F0
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Sep 2023 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348453AbjIAHLo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Sep 2023 03:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjIAHLo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Sep 2023 03:11:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295FE49;
        Fri,  1 Sep 2023 00:11:41 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcTdF0JvYzNn0g;
        Fri,  1 Sep 2023 15:08:01 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 15:11:39 +0800
Message-ID: <14010198-c128-4960-0d56-5ee28f4da53f@huawei.com>
Date:   Fri, 1 Sep 2023 15:11:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 0/5] Introduce a new helper macro
 DEFINE_SHOW_STORE_ATTRIBUTE at seq_file.c
Content-Language: en-CA
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luo Jiaxing <luojiaxing@huawei.com>
CC:     <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <john.garry@huawei.com>, <himanshu.madhani@cavium.com>,
        <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <uma.shankar@intel.com>, <anshuman.gupta@intel.com>,
        <animesh.manna@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>
References: <1605164864-58944-1-git-send-email-luojiaxing@huawei.com>
 <ZPDZtR8W1TLcOHW+@smile.fi.intel.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <ZPDZtR8W1TLcOHW+@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm100005.china.huawei.com (7.185.36.231) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 2023/9/1 2:19, Andy Shevchenko wrote:
> On Thu, Nov 12, 2020 at 03:07:38PM +0800, Luo Jiaxing wrote:
>> We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
>> for read-only file, but we found many of drivers also want a helper macro
>> for read-write file too.
>>
>> So we add this macro to help decrease code duplication.
> 
> Are you going to pursue this one?
Hi Andy

Jiaxing has left his job, and his email is invalid.

Thanks,
Xingui
> 
