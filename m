Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C235916D1
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Aug 2022 23:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiHLVqR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Aug 2022 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiHLVqQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Aug 2022 17:46:16 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC6596FD3
        for <linux-scsi@vger.kernel.org>; Fri, 12 Aug 2022 14:46:15 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id bh13so1818652pgb.4
        for <linux-scsi@vger.kernel.org>; Fri, 12 Aug 2022 14:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=g0PZQPj3FEhuSJmM84r9tA07BU17QO2Le2TxX33AsR0=;
        b=qLEpkSDY+W74ldkWA0adV434fSywV//nDAxsHwwJNoR6NzYfUVyqLLaik8RVdmhu8Y
         nguHPoed6YDgjkzQGyhO5Nw4nImBYbtc7yFjrbPbEpX0qxKoUaSxWym78RQf/b1Isv9i
         +zZp6fNSCjWDi4dia+VILJGbwmnTNP37GEujcygNNcheEXKpga2L3DcdFazcRjmZs1Ok
         49Iv/EMp3cBgSAqGMwHVmmlOBhE5H64yeCllPoJ+awkMtTti9EYFGTqJVakQ9aXPHsut
         Ueu0uYVVyknnYdM9RwiWYrCb62tM86v4ZJEF+Ep8Yw6rcuFC54vN/F+T5dplUDGubktp
         tGFw==
X-Gm-Message-State: ACgBeo19p/wmXk4wLYaOTBNq/miHl6k5qoYvfxKYEDTwetkbMztE6e4i
        HB8qmPWP2R3ip1STbSTlfmY=
X-Google-Smtp-Source: AA6agR6Ggn/XVJsb02kR8lAow0DEbtweBrcqrS91eBtWEMVWzWVacpvgG0w4vPbGkcOArWv+f6G0fA==
X-Received: by 2002:a63:f4d:0:b0:41c:5b90:f643 with SMTP id 13-20020a630f4d000000b0041c5b90f643mr4781949pgp.537.1660340774724;
        Fri, 12 Aug 2022 14:46:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2414:9f13:41de:d21d? ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b0016d8d277c02sm2260258plh.25.2022.08.12.14.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 14:46:13 -0700 (PDT)
Message-ID: <031208a8-6250-15ed-ddb1-0bcdc83dfd5e@acm.org>
Date:   Fri, 12 Aug 2022 14:46:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] scsi: core: Remove procfs support
Content-Language: en-US
To:     dgilbert@interlog.com,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20220812204553.2202539-1-bvanassche@acm.org>
 <20220812204553.2202539-4-bvanassche@acm.org>
 <7a3b2aea-336a-c2ea-155d-de2b08380793@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7a3b2aea-336a-c2ea-155d-de2b08380793@interlog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/12/22 14:17, Douglas Gilbert wrote:
> On 2022-08-12 16:45, Bart Van Assche wrote:
>> There are equivalents for all /proc/scsi functionality in sysfs. The most
>> prominent user of /proc/scsi is the sg3_utils software package. Support
>> for systems without /proc/scsi was added to sg3_utils in 2008. Hence
>> remove procfs support from the SCSI core.
> 
> Perhaps it is just me but I find 'cat /proc/scsi/sg/debug' very useful
> when something goes wrong with the sg driver or something that it depends
> on. Part of my sg driver rewrite (3 years and still pending) was to
> transfer the output that formerly went to /proc/scsi/sg/debug to
> debugfs instead (or as well).
> 
> The most recent version of that procfs-->debugfs work for the sg driver
> can be found in a post to this list titled: "[PATCH v24 35/46] sg: first
> debugfs support" on 20220410.
> 
> Put another way, there are many hours of debugging experience that will be
> lost by:
>    drivers/scsi/sg.c           | 358 ---------------------------

Hi Doug,

How about extracting patch "[PATCH v24 35/46] sg: first debugfs support" 
from that 46 patch series and including it in this patch series?

Thanks,

Bart.
