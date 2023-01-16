Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1E66D1DC
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Jan 2023 23:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjAPWlO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Jan 2023 17:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjAPWlN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Jan 2023 17:41:13 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22E62387A
        for <linux-scsi@vger.kernel.org>; Mon, 16 Jan 2023 14:41:11 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id d3so31663733plr.10
        for <linux-scsi@vger.kernel.org>; Mon, 16 Jan 2023 14:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWQimMFzgfE9t0t/4C+SDjdYtf4oAo21cZYJwBi3jck=;
        b=HomJLlPQRy10+CwWOA8ME1q1zkQ2VPpfDji2jTRaXXFq+qDtsYbQ+gQc4g++KIMj2h
         E+tUg6AMLY8qScBqYrALMw7+37+Y+Wr6eoNQJdljKvvAC13R6cXBD3nYC+Z5n7bmBecM
         2fKwyBQAXZVYxR6ZE20zSZGY5AyOoATss3adUYYGL6uO1z0dgCwQk8PcvyiVMuDw5o3k
         s8nZpct6E7WGjanSl+i4zvbxWHQnHH0EPH169gleGrqLUY6uiPxaT3eEtiWcxAYzsIJO
         3ZnsscEoZR7dWDQ/ypdchXgNAVcljrOjURUIlyv7HSeloWLlT2b84/kllVZH/a2KREgm
         xRng==
X-Gm-Message-State: AFqh2krTvKWauJuTPNHdzhSx3z7aSZ+Q5VwR03erAaQ9tcq3pE4rkDg7
        55CPJhHAojeQOJwD4JA1g3E=
X-Google-Smtp-Source: AMrXdXuTh9xvMyvhThn6YyfnQRAynR3iNm8aFmXU0uJYtzSUjAFdTlAFa/cs9WhLlVedTwiQTVu/lA==
X-Received: by 2002:a17:902:70cc:b0:194:6c1b:e5cc with SMTP id l12-20020a17090270cc00b001946c1be5ccmr1383210plt.38.1673908871093;
        Mon, 16 Jan 2023 14:41:11 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z24-20020a630a58000000b004790eb3fee1sm15885112pgk.90.2023.01.16.14.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 14:41:10 -0800 (PST)
Message-ID: <39006233-ff6f-82ad-b772-e00e789375a5@acm.org>
Date:   Mon, 16 Jan 2023 14:41:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scsi: hpsa: fix allocation size for scsi_host_alloc()
Content-Language: en-US
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Don Brace <don.brace@microchip.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        James Bottomley <JBottomley@parallels.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Stephen M. Cameron" <scameron@beardog.cce.hp.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230116133140.GB8107@altlinux.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230116133140.GB8107@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/16/23 05:31, Alexey V. Vissarionov wrote:
> Fixes: b705690d8d16f708 ("[SCSI] hpsa: combine hpsa_scsi_detect and hpsa_register_scsi")

That seems incorrect to me. Shouldn't the Fixes tag be changed into the 
following?

Fixes: edd163687ea5 ("[SCSI] hpsa: add driver for HP Smart Array 
controllers.")

Thanks,

Bart.
