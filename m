Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C1C5B09FB
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Sep 2022 18:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIGQUO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Sep 2022 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiIGQUA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Sep 2022 12:20:00 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9FE29829;
        Wed,  7 Sep 2022 09:19:50 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id y136so10192646pfb.3;
        Wed, 07 Sep 2022 09:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8cRFoWV95jVQQVKHemCdWmSWnhBkLiIyxGkbvMQcSto=;
        b=cl+8P/MN8abKxq/LlBzm4K7MF6VPxXY5/6GKfBtFowoVuXKhF+2mgxSwwyDEawiRCZ
         8BN01vYVyjBZqafQe7N33QSXiM88CfZR+fTF96iJEntyp02FdXVfuwWCbmUYp88gEFUJ
         Mb9qP6CTPJy7ilch9jnpoeF8YFrZ52B/HKplukTgN3n6+uIwfC9OYyYaJ0fXu2szFnQy
         CVJtm42uE9I6YkfceTu+OhXzMFzYdM+RTEfuWEFzlcaMv/WHN2+QfIYS03gK7kvSk4mn
         r8boKwSsZ+ddisb0fuzlPU03K0QVrvXyaIueYqJIp2ASHEOti9b3SWz+EQ9fgwjw/Ryn
         MBOw==
X-Gm-Message-State: ACgBeo38leEg1AXZru7FS7u0n1zlKhInKzs8RFrwB/eZoCF/DBSmohJ/
        xdXghH+ThNoJFxwYX+tFy1F/me8ZgpM=
X-Google-Smtp-Source: AA6agR5z3+wcK6xSnbbMKyLSeoLEnVny2VFHE0DPELrxgguQpYE/5s26XD62Sdg7mWqXAUdJHhZAfg==
X-Received: by 2002:a05:6a00:22cd:b0:52f:706a:5268 with SMTP id f13-20020a056a0022cd00b0052f706a5268mr4752443pfj.80.1662567589903;
        Wed, 07 Sep 2022 09:19:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:899e:cff7:8f51:a7ba? ([2620:15c:211:201:899e:cff7:8f51:a7ba])
        by smtp.gmail.com with ESMTPSA id p66-20020a622945000000b005361f6a0573sm12839935pfp.44.2022.09.07.09.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 09:19:49 -0700 (PDT)
Message-ID: <73091ce3-5412-b3f8-94c5-c6224ffcc08c@acm.org>
Date:   Wed, 7 Sep 2022 09:19:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] target: core: new key must be used for moved PR
Content-Language: en-US
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, linux@yadro.com
References: <20220907135851.3756-1-d.bogdanov@yadro.com>
 <20220907135851.3756-5-d.bogdanov@yadro.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220907135851.3756-5-d.bogdanov@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/7/22 06:58, Dmitry Bogdanov wrote:
> +	} else {
> +	/*
> +	 * e) Retain the reservation key specified in the SERVICE ACTION
> +	 *    RESERVATION KEY field and associated information;
> +	 */
> +		dest_pr_reg->pr_res_key = sa_res_key;
>   	}

The indentation of the new comment looks wrong to me. Please fix.

Thanks,

Bart.
