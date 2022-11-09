Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D6623309
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Nov 2022 19:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiKISxk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Nov 2022 13:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKISxY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Nov 2022 13:53:24 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE872CC8E
        for <linux-scsi@vger.kernel.org>; Wed,  9 Nov 2022 10:53:06 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id 6so8852286pgm.6
        for <linux-scsi@vger.kernel.org>; Wed, 09 Nov 2022 10:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lrc/uLIcFcj1d0iy2wOT5Ei4pXT/qhnAJhbp1OLFE10=;
        b=qlpBNisEFcy2mLqF/UwzXU7vQvF3OwR5vz6dTueXQVw8JYDPashlRAGpDywjJcT0wP
         eCbGlXyDYzfdaQKlZUBDa8bs6sS3nLUVvL1Jg60QJmpDPdHgDGAhvmo8PLb307Meo1Xq
         y3KR4z1fQjAayccSEgHTKGOHQlU469/ltQTeyF2W7C6UyOON9aoT0NpZRJ5BCXiRVMXM
         yAewgjvAEl/VcwVcadx9SxR0jIBgXgsWCZ304J+GXkHJwiV7QacCJwTATqX8mjUdndQd
         ZKlYUXChrEnjY12nDlTy3VvM7C24tHTDu1Rv7hQwsKn/obF8E+TXmYRd0IdmbJkm2u0V
         9b8A==
X-Gm-Message-State: ACrzQf1OUhllUXsUfZMIIMjjpt+nGzh7Upl1YXdlrN8+QpxRAqvmnqYH
        t5daKybHZGwW9WHWGTpEiX0=
X-Google-Smtp-Source: AMsMyM4YkSteikAIHprtOea4dxJgv+9HDPO1nkaCOyz5tLiXKwzT/gQVthd/YnRy/73RLKJhKDwxdw==
X-Received: by 2002:aa7:8750:0:b0:56c:318a:f811 with SMTP id g16-20020aa78750000000b0056c318af811mr61550981pfo.14.1668019985588;
        Wed, 09 Nov 2022 10:53:05 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id i193-20020a6287ca000000b00561d79f1064sm8558440pfe.57.2022.11.09.10.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:53:04 -0800 (PST)
Message-ID: <56cdf9ed-e6f6-d152-7908-18d03694e5c8@acm.org>
Date:   Wed, 9 Nov 2022 10:53:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 29/35] scsi: Have scsi-ml retry scsi_report_lun_scan
 errors
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, mwilck@suse.com,
        hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
References: <20221104231927.9613-1-michael.christie@oracle.com>
 <20221104231927.9613-30-michael.christie@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221104231927.9613-30-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/4/22 16:19, Mike Christie wrote:
> This has scsi_report_lun_scan have scsi-ml retry errors instead of driving
> them itself.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


