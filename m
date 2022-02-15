Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC734B6A4C
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Feb 2022 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiBOLHr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Feb 2022 06:07:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiBOLHl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Feb 2022 06:07:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1BC107D13
        for <linux-scsi@vger.kernel.org>; Tue, 15 Feb 2022 03:07:31 -0800 (PST)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JydZz6rTgz67bVD;
        Tue, 15 Feb 2022 19:07:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 12:07:29 +0100
Received: from [10.47.81.62] (10.47.81.62) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 11:07:28 +0000
Message-ID: <0a0006af-2878-3e6f-dc27-be04d2866fc3@huawei.com>
Date:   Tue, 15 Feb 2022 11:07:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 28/31] scsi: pm8001: Introduce ccb alloc/free helpers
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "Jason Yan" <yanaijie@huawei.com>,
        Luo Jiaxing <luojiaxing@huawei.com>
References: <20220214021747.4976-1-damien.lemoal@opensource.wdc.com>
 <20220214021747.4976-29-damien.lemoal@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220214021747.4976-29-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.62]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 14/02/2022 02:17, Damien Le Moal wrote:
> Introduce the pm8001_ccb_alloc() and pm8001_ccb_free() helpers to
> replace the typical code patterns:
> 
> 	res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
> 	if (res)
> 		...
> 	ccb = &pm8001_ha->ccb_info[ccb_tag];
> 	ccb->device = pm8001_ha_dev;
> 	ccb->ccb_tag = ccb_tag;
> 	ccb->task = task;
> 	ccb->n_elem = 0;A

nit: stray 'A' character

> 
> and
> 
> 	ccb->task = NULL;
> 	ccb->ccb_tag = PM8001_INVALID_TAG;
> 	pm8001_tag_free(pm8001_ha, tag);

Isn't it possible to do a "memset struct members", such that we order 
the members specifically that we can memset(0) a known region? The 
advantage is that adding/removing a member does not require much code to 
be touched and possibly missed.

> 
> With the simpler function calls:
> 
> 	ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
> 	if (!ccb)
> 		...
> 
> and
> 
> 	pm8001_ccb_free(pm8001_ha, ccb);
> 
> The pm8001_ccb_alloc() helper ensures that all fields of the ccb info
> structure for the newly allocated tag are all initialized, except the
> buf_prd field. The pm8001_ccb_free() helper clears the initialized
> fields and the ccb tag to ensure that iteration over the adapter
> ccb_info array detects ccbs that are in use.


> 
> All call site of the pm8001_tag_alloc() function that use a ccb info
> associated with an allocated tag are converted to use the new helpers.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---

The comments are not a show stopper, so:
Reviewed-by: John Garry <john.garry@huawei.com>

