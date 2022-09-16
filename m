Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80A5BB10C
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Sep 2022 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIPQTh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Sep 2022 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPQTd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 16 Sep 2022 12:19:33 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9EE321
        for <linux-scsi@vger.kernel.org>; Fri, 16 Sep 2022 09:19:27 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so152850pjq.3
        for <linux-scsi@vger.kernel.org>; Fri, 16 Sep 2022 09:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XiQfLejD+ikYTrirS2m9xfoWAcYSxqAJLJbjvmNRJ5g=;
        b=uq6DbZDbYQ57FegLuXEOKoF5ibZPyIprgT+tmlMODEy/0VgKWZ0dmo67V9vKQYbVMJ
         Bfxh03YlYTMhETsmkI0voca2pvK+ja+o+yXtRSpVzvTkEqQX5qmSAEKL5zRCMrhVDxl/
         OI1kYu1/EnFP596NDvWWvuD6pDORJKFNfx8kk5ktuWG4XXhIGLOhcEJhnyVJZRCkNSxv
         5tI6BiOsvfZ5lBW7nwsG7yj9+Wapim9dwYnXn3F9z2LKoUbfVijvc0DkOE78PLZ7vPjF
         m31U08GheJiTNNc4xVM4uxsd19s1P+7SEc8Sg5tsYoD6JdW/fjevTIL9cSuBCx5z+qss
         fKKg==
X-Gm-Message-State: ACrzQf0nB/9z9kj3fWoSN1sghSB8dQ7jyLRimoXil0xAJR+10UHQlZAD
        CDaL3+O/GfAzDdJObFB7Azm6efi1veQ=
X-Google-Smtp-Source: AMsMyM67L2wMYb4XBi/1nrWiY7FWzUA74iYsva05MGEf1MxvtX9UZRYW42O47ZKVIyEJfPbZwsO0Gg==
X-Received: by 2002:a17:902:ce85:b0:178:292b:a87a with SMTP id f5-20020a170902ce8500b00178292ba87amr558180plg.167.1663345166195;
        Fri, 16 Sep 2022 09:19:26 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b2fd:791c:a216:ceef? ([2620:15c:211:201:b2fd:791c:a216:ceef])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b001786b712bf7sm4242548plh.151.2022.09.16.09.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 09:19:25 -0700 (PDT)
Message-ID: <44e17063-3e69-98b8-b6e8-b73f8e449715@acm.org>
Date:   Fri, 16 Sep 2022 09:19:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] scsi: core: Add io timeout count for scsi device
Content-Language: en-US
To:     Wu Bo <wubo40@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        qiuchangqi.qiu@huawei.com
References: <32aff63d-1b79-916a-50e2-1e6c113ed9ef@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <32aff63d-1b79-916a-50e2-1e6c113ed9ef@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/15/22 19:01, Wu Bo wrote:
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 448748e..e84aea9 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -334,6 +334,7 @@ enum blk_eh_timer_return scsi_timeout(struct request 
> *req)
>          trace_scsi_dispatch_cmd_timeout(scmd);
>          scsi_log_completion(scmd, TIMEOUT_ERROR);
> 
> +       atomic_inc(&scmd->device->iotmo_cnt);
>          if (host->eh_deadline != -1 && !host->last_reset)
>                  host->last_reset = jiffies;

Please rebase this patch on top of Martin's for-next branch and repost 
this patch. I cannot apply this patch with "git am" on Martin's for-next 
branch.

Thanks,

Bart.

