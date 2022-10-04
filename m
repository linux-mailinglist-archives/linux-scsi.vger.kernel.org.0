Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02A5F4BEA
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Oct 2022 00:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJDWaF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Oct 2022 18:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiJDWaC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Oct 2022 18:30:02 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD4313DD2
        for <linux-scsi@vger.kernel.org>; Tue,  4 Oct 2022 15:30:00 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id s206so13840691pgs.3
        for <linux-scsi@vger.kernel.org>; Tue, 04 Oct 2022 15:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WXO5wJapeQ/FtfzdXMjRdZXO2jO8pBKQvxTnUyw/8Iw=;
        b=cPKD6B0zQfVxtSDhOpa+GNC/SWFfUMIDXvtllZ2H7RXzllbkhtwvLHUqiF0s5KluDP
         x/k8oJ9D/YuoWKAtQroSAbS2ZmhMLmHapg20CAa66zvayF9bR/Ca4lqC2p5rbzFiyAOW
         Twgjv+gCtaSDQLKtzWwgWhCncNhh9w69b8nzz7lkqv2YwGvjMTh3rQXGRrjvm5xMEjok
         kgfzK/ptT7L0eDVtTUL7Lj6fon4z6cmMW7Pe4WrJkqyS+NNbmxyStuMFwiGYDg2pk9c6
         nCSfswkx0Qknu0p+p3keqsoMPmXSJTya99XPFdkZ0M0x5jY1YEB6P/xB939l54BlKH8u
         25jQ==
X-Gm-Message-State: ACrzQf1ZKTk1l3NVT1H9Fo4yLkXMALRxQgHsA/+vN5ccH/tg8wsKWmDY
        9jAzY0Kw4L8U+l8fvzQiUT4=
X-Google-Smtp-Source: AMsMyM4/hXx/xpZ2RlJfW3Qyg4hKN3+SZ1onIU1+B0dsoG+iALhFqM++i7XrqgaQ1zoE4rW4DsQ5xQ==
X-Received: by 2002:a05:6a02:10e:b0:43b:e57d:2bfa with SMTP id bg14-20020a056a02010e00b0043be57d2bfamr24283316pgb.263.1664922600045;
        Tue, 04 Oct 2022 15:30:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b6b5:f763:ff03:8283? ([2620:15c:211:201:b6b5:f763:ff03:8283])
        by smtp.gmail.com with ESMTPSA id w5-20020a623005000000b00553d5920a29sm9686227pfw.101.2022.10.04.15.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:29:59 -0700 (PDT)
Message-ID: <dc04674e-2970-e4f5-4f34-fe8788d4dc8f@acm.org>
Date:   Tue, 4 Oct 2022 15:29:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 03/35] scsi: Add struct for args to execution functions
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, mwilck@suse.com,
        hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
References: <20221003175321.8040-1-michael.christie@oracle.com>
 <20221003175321.8040-4-michael.christie@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221003175321.8040-4-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/3/22 10:52, Mike Christie wrote:
> This begins to move the SCSI execution functions to use a struct for
> passing in args. This patch adds the new struct, converts the low level
> helpers and then adds a new helper the next patches will convert the rest
> of the code to.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
