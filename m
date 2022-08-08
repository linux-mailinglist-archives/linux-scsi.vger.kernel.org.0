Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22B758C1AD
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Aug 2022 04:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiHHChy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Aug 2022 22:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiHHChw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Aug 2022 22:37:52 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D215C10CD
        for <linux-scsi@vger.kernel.org>; Sun,  7 Aug 2022 19:37:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VLbcjlD_1659926267;
Received: from 192.168.3.3(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VLbcjlD_1659926267)
          by smtp.aliyun-inc.com;
          Mon, 08 Aug 2022 10:37:47 +0800
Message-ID: <76be7fa8-2c68-331a-db7c-ed346184a08a@linux.alibaba.com>
Date:   Mon, 8 Aug 2022 10:37:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] scsi: megaraid_sas: remove unnecessary kfree
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
References: <1659424740-46918-1-git-send-email-kanie@linux.alibaba.com>
In-Reply-To: <1659424740-46918-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

Gentle ping.

在 2022/8/2 15:19, Guixin Liu 写道:
> When alloc ctrl mem fail, the reply_map will be free in
> megasas_free_ctrl_mem(), no need to free in megasas_alloc_ctrl_mem().
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/scsi/megaraid/megaraid_sas_base.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index a3e117a..f6c37a9 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -7153,22 +7153,18 @@ static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
>   	switch (instance->adapter_type) {
>   	case MFI_SERIES:
>   		if (megasas_alloc_mfi_ctrl_mem(instance))
> -			goto fail;
> +			return -ENOMEM;
>   		break;
>   	case AERO_SERIES:
>   	case VENTURA_SERIES:
>   	case THUNDERBOLT_SERIES:
>   	case INVADER_SERIES:
>   		if (megasas_alloc_fusion_context(instance))
> -			goto fail;
> +			return -ENOMEM;
>   		break;
>   	}
>   
>   	return 0;
> - fail:
> -	kfree(instance->reply_map);
> -	instance->reply_map = NULL;
> -	return -ENOMEM;
>   }
>   
>   /*
