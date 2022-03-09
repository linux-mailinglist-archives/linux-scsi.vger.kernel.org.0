Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263584D2743
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Mar 2022 05:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiCIBcD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Mar 2022 20:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiCIBcC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Mar 2022 20:32:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C752939AF
        for <linux-scsi@vger.kernel.org>; Tue,  8 Mar 2022 17:31:03 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCvkV6dq5zdg1t;
        Wed,  9 Mar 2022 09:29:38 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 09:31:01 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 09:31:00 +0800
Subject: Re: [PATCH 07/12] scsi: iscsi_tcp: Drop target_alloc use
To:     Mike Christie <michael.christie@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <jejb@linux.ibm.com>
References: <20220308002747.122682-1-michael.christie@oracle.com>
 <20220308002747.122682-8-michael.christie@oracle.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <33606611-bef2-9c90-3365-3abe95f9ffc4@huawei.com>
Date:   Wed, 9 Mar 2022 09:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20220308002747.122682-8-michael.christie@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022/3/8 8:27, Mike Christie wrote:
> For software iscsi, we do a session per host so there is no need to set
> the target's can_queue since its the same as the host one. It just results
> in extra atomic checks in the main IO path.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/scsi/iscsi_tcp.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index 3bdefc4b6b17..974245eab605 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -1053,7 +1053,6 @@ static struct scsi_host_template iscsi_sw_tcp_sht = {
>   	.eh_target_reset_handler = iscsi_eh_recover_target,
>   	.dma_boundary		= PAGE_SIZE - 1,
>   	.slave_configure        = iscsi_sw_tcp_slave_configure,
> -	.target_alloc		= iscsi_target_alloc,
>   	.proc_name		= "iscsi_tcp",
>   	.this_id		= -1,
>   	.track_queue_depth	= 1,
> 
Reviewed-by: Wu Bo <wubo40@huawei.com>

.
