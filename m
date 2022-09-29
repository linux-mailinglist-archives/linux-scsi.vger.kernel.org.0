Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBEC5EFB7B
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Sep 2022 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiI2RCl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Sep 2022 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiI2RC3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 29 Sep 2022 13:02:29 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2612DE9A
        for <linux-scsi@vger.kernel.org>; Thu, 29 Sep 2022 10:02:25 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id 9so1964272pfz.12
        for <linux-scsi@vger.kernel.org>; Thu, 29 Sep 2022 10:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7YaoXdzTyT1PNHukeN3mstNd359LoPF+zyqkRhYT7h4=;
        b=uPekq3eJkgPvssuZKRFLhV7t001bmzqBP1Z2lGKCxc+sRulm0mOwnDK8IPJdyRzOXr
         Y0VfWuCaf9rIeBrRx5d0wsOIlPY6mDrzzw/S5wmSqCTq+KtobDvdTGDYnV6wrgApKAXV
         GuVQqhgSwjSZLuxmC4oO7vAVxqYnN6A4xIi+Ycda7HwEBDG6Gfh/4i9JXlfNNyP8KoH4
         /S3Q3qBxgytOS/BdgJHxnz69yd0eHUVDuzdqnlGuj3tjuDq39WuWSKxbH520kbGXJKPe
         h3I2+BHqWFXR2ijnrmMOgljKeUIA3T418lB/jMcPu7h6GjTshU+7JFuTv8o3+tu8Ilqk
         ciAQ==
X-Gm-Message-State: ACrzQf0CDP1auBYkNU5GmQpb2ktdhSi9QuN+N/AFEzgAFAfJ3F3eB3RR
        NR9o6O63KnxNeSVt9mMGs4Q=
X-Google-Smtp-Source: AMsMyM6XWlUE2pWo4EkzwP8gcjDEJIySc4cQagqfg9cyTbMqEupUZu6mUJvuVqMBpz04JfQPaMFGsA==
X-Received: by 2002:a63:8ac7:0:b0:440:3c80:5b4f with SMTP id y190-20020a638ac7000000b004403c805b4fmr3748536pgd.404.1664470944651;
        Thu, 29 Sep 2022 10:02:24 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2e63:ed10:2841:950e? ([2620:15c:211:201:2e63:ed10:2841:950e])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79d05000000b0053e2b61b714sm6347767pfp.114.2022.09.29.10.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 10:02:23 -0700 (PDT)
Message-ID: <d77c03f3-9908-1d3d-0526-57cdfb5d5ce7@acm.org>
Date:   Thu, 29 Sep 2022 10:02:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 03/35] scsi: Add struct for args to execution functions
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, mwilck@suse.com,
        hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
References: <20220929025407.119804-1-michael.christie@oracle.com>
 <20220929025407.119804-4-michael.christie@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220929025407.119804-4-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/28/22 19:53, Mike Christie wrote:
> +/* Make sure any sense buffer is the correct size. */
> +#define scsi_exec_req(_args)						\
> +({									\
> +	BUILD_BUG_ON(_args.sense &&					\
> +		     _args.sense_len != SCSI_SENSE_BUFFERSIZE);		\
> +	__scsi_exec_req(&_args);					\
> +})

Hi Mike,

I will take a close look at the entire patch series when I have the time.
So far I only have one question: if _args would be surrounded with
parentheses in the above macro, would that allow to leave out one pair of
parentheses from the code that uses this macro? Would that allow to write
scsi_exec_req((struct scsi_exec_args){...}) instead of
scsi_exec_req(((struct scsi_exec_args){...}))?

Thanks,

Bart.
