Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6EC776D69
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Aug 2023 03:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjHJBNQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Aug 2023 21:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJBNP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Aug 2023 21:13:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0D91999
        for <linux-scsi@vger.kernel.org>; Wed,  9 Aug 2023 18:13:13 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLpjx6gpbzcdMm;
        Thu, 10 Aug 2023 09:09:41 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 09:13:11 +0800
Subject: Re: [PATCH -next] scsi: libsas: Remove unused declarations
To:     Yue Haibing <yuehaibing@huawei.com>, <john.g.garry@oracle.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>
References: <20230809132249.37948-1-yuehaibing@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <3eb74be1-48be-da61-d038-2e052245d499@huawei.com>
Date:   Thu, 10 Aug 2023 09:13:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230809132249.37948-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2023/8/9 21:22, Yue Haibing wrote:
> Commit 042ebd293b86 ("scsi: libsas: kill useless ha_event and do some cleanup")
> removed sas_hae_reset() but not its declaration.
> Commit 2908d778ab3e ("[SCSI] aic94xx: new driver") declared but never implemented
> other functions.
> 
> Signed-off-by: Yue Haibing<yuehaibing@huawei.com>
> ---
>   drivers/scsi/libsas/sas_internal.h | 7 -------
>   include/scsi/libsas.h              | 2 --
>   2 files changed, 9 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

.
