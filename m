Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF560E789
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Oct 2022 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiJZSji (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Oct 2022 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiJZSjg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Oct 2022 14:39:36 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4849FCD
        for <linux-scsi@vger.kernel.org>; Wed, 26 Oct 2022 11:39:33 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id r18so15719297pgr.12
        for <linux-scsi@vger.kernel.org>; Wed, 26 Oct 2022 11:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eU0wyCTgrjrfJPJn+rCmeURyzAyNwtbdNUMeNvsQ4ao=;
        b=7LRAzqp9ILWgvRzJaGh6FkUVNH04yAbd6eesycKhpjdQHwPZMSBdakdbJyVAgNA7qN
         xsarJb9FHIgIwe7ufwUaSbXJrd0YZSOl7eUg5dK0FsYQGS2lidQLaZcoT27eo1sXToXa
         rVmHATYmGXUTLo1bX2eSjD5FswKDRgUsyBDgpx2IJthQd5fRai0kEivkSKWD7Dd26Fs0
         5ZrcFb2zAZ8mxieOnmBDSWU36oVq1CYiYhzNsZaPrRwDtyr7Ubsu4q3goruNaR+EXEQs
         91M9cBQf/l0jnC4hahxbw4uCgvp5c2GVbO62zwV3K1VAqY1mmxDub1rRccoMxK1EgCSM
         EaWg==
X-Gm-Message-State: ACrzQf0zg1pzNnO4KOY1/nLfw5MordGOeJQw8gV3ZTzWXEVgQC0HJ2Gf
        U14KlocfEpA2mjaA+3smVz7vmSNnrIs=
X-Google-Smtp-Source: AMsMyM6BcgKDANo5aXbs1zFvcGAkQwyBIJn8up8qQdZ8KNxLFVcb8pZeA4pY3gQnQnzfxQILQllq6Q==
X-Received: by 2002:aa7:9212:0:b0:562:b5f6:f7d7 with SMTP id 18-20020aa79212000000b00562b5f6f7d7mr46528366pfo.70.1666809573059;
        Wed, 26 Oct 2022 11:39:33 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e8f5:d5ef:e031:7146? ([2620:15c:211:201:e8f5:d5ef:e031:7146])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79415000000b00565b259a52asm3315523pfo.1.2022.10.26.11.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 11:39:32 -0700 (PDT)
Message-ID: <9c8b4923-f7b3-d3c8-75e2-a13b376d5340@acm.org>
Date:   Wed, 26 Oct 2022 11:39:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [bug report] scsi: core: Release SCSI devices synchronously
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-scsi@vger.kernel.org
References: <Y1k8+fDG7FFOnbBG@kili>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y1k8+fDG7FFOnbBG@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/26/22 06:58, Dan Carpenter wrote:
> Hello Bart Van Assche,
> 
> The patch f93ed747e2c7: "scsi: core: Release SCSI devices
> synchronously" from Oct 14, 2022, leads to the following three Smatch
> static checker warnings:
> 
> 1) drivers/scsi/bfa/bfad_bsg.c:2551 bfad_iocmd_lunmask_reset_lunscan_mode() warn: sleeping in atomic context
> 
> bfad_iocmd_lunmask() <- disables preempt
> -> bfad_iocmd_lunmask_reset_lunscan_mode()
>     -> scsi_device_put()
> 
> (This is inside the calls to bfad_reset_sdev_bflags() macro).
> 
> 2) drivers/scsi/device_handler/scsi_dh_alua.c:853 alua_rtpg_select_sdev() warn: sleeping in atomic context
> 
> alua_rtpg_work() <- disables preempt
> -> alua_rtpg_select_sdev()
>     -> scsi_device_put()
> 
> 3) drivers/scsi/device_handler/scsi_dh_alua.c:1013 alua_rtpg_queue() warn: sleeping in atomic context
> 
> alua_check_vpd() <- disables preempt
> -> alua_rtpg_queue()
>     -> scsi_device_put()
> 
> Hopefully, this bug report is straight forward.  The fixes are probably
> complicated though.  :P Basically the function marked "disables preempt"
> takes a spin lock and calls the other function which calls
> scsi_device_put().

Thanks Dan for the detailed report. I plan to post fixes for these 
issues soon.

Bart.

