Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F8B75A424
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jul 2023 03:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGTBzJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jul 2023 21:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGTBzJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jul 2023 21:55:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482B1FDF;
        Wed, 19 Jul 2023 18:55:08 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R5wj91tGvz18LtY;
        Thu, 20 Jul 2023 09:54:21 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 09:55:05 +0800
Subject: Re: [PATCH v2 6/8] ata,scsi: cleanup ata_port_probe()
To:     Niklas Cassel <nks@flawful.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Hannes Reinecke <hare@suse.com>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20230720004257.307031-1-nks@flawful.org>
 <20230720004257.307031-7-nks@flawful.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <86931749-4a01-f248-942e-cfeb05333219@huawei.com>
Date:   Thu, 20 Jul 2023 09:55:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230720004257.307031-7-nks@flawful.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2023/7/20 8:42, Niklas Cassel wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Rename __ata_port_probe() to ata_port_probe() and drop the wrapper
> ata_sas_async_probe().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   drivers/ata/libata-core.c     |  5 +++--
>   drivers/ata/libata-sata.c     | 13 -------------
>   drivers/ata/libata.h          |  2 --
>   drivers/scsi/libsas/sas_ata.c |  2 +-
>   include/linux/libata.h        |  2 +-
>   5 files changed, 5 insertions(+), 19 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>

Thanks,
Jason
