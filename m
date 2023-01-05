Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D4065E2DB
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Jan 2023 03:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjAECRs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Jan 2023 21:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAECRr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Jan 2023 21:17:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F943A3E
        for <linux-scsi@vger.kernel.org>; Wed,  4 Jan 2023 18:17:45 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NnVPC0Tp6zqTsx;
        Thu,  5 Jan 2023 10:13:03 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 10:17:42 +0800
Subject: Re: [PATCH v2] scsi: hisi_sas: fix tags freeing for the reserverd
 tags
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20221215040925.147615-1-yanaijie@huawei.com>
 <6637df86-9302-56c6-b760-3f1b46970f15@hisilicon.com>
 <yq1358p3flx.fsf@ca-mkp.ca.oracle.com>
CC:     Jason Yan <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <john.g.garry@oracle.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <95580723-cbbb-d9d8-db7a-8005c1e273ca@hisilicon.com>
Date:   Thu, 5 Jan 2023 10:17:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <yq1358p3flx.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



ÔÚ 2023/1/5 10:03, Martin K. Petersen Ð´µÀ:
>> I notice that this patch is not merged till now, which affect the boot
>> of this driver.  Could you consider to merge it as soon as possible?
> It's already in 6.2/scsi-fixes.

Ok, thanks!


