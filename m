Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13F4F9DAD
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Apr 2022 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiDHTdr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Apr 2022 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiDHTdq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Apr 2022 15:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB240255BF
        for <linux-scsi@vger.kernel.org>; Fri,  8 Apr 2022 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649446300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/4FS6QgJbYZUbVh33aTHwESfnBXpb7C9e5m+pOdZFI=;
        b=Tu30R8NZip4K2SmpzPSvfm9YXChGAYwvAztUfY3zSgq37ZqCLDoNLGDrXoH/cJXbv7+n9X
        Hfujf5fs+T2eDSqmufcNxVziYm1zBRZVD3BuXL8tsjExDZL3v9GTGdfrI8EdArF/pPQ+8V
        51WiEtWyfWxaBMkoDR66Pg/2IRiwtgk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-aPPmRo8FPbeNZk0jvBdPHQ-1; Fri, 08 Apr 2022 15:31:39 -0400
X-MC-Unique: aPPmRo8FPbeNZk0jvBdPHQ-1
Received: by mail-qv1-f71.google.com with SMTP id kk17-20020a056214509100b00443cc96b7d5so10120555qvb.16
        for <linux-scsi@vger.kernel.org>; Fri, 08 Apr 2022 12:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J/4FS6QgJbYZUbVh33aTHwESfnBXpb7C9e5m+pOdZFI=;
        b=E+4YhUoEVBX9jIyavc/Yq1pDLkasVkMsa8ZsxXlvR+JjPDP0/cxgTRjaPk0GZnaWCi
         6QZ8KJdzgImnBCbV/Ehxy81zjbueHlG+Jf+TdMYT1AIXF3MF7G/hO2cuCz8EIyBnI32F
         ZJ21C8A+IRM73Uu8OOU9ZypEEGBMwUqrxm8Wrcc8ajZS2zF1F8UUT0N2mWQATqzXeVUs
         XQnouMnmbubk7Iwl5Nsl13USplwKdS0gClCmFQQ8pokrszWV9Jom/6oxtKI0ZYHVNvO9
         FzMhw+dIvXvo25BA0aUH7Tp41dPUZ0h+ZpVV0ogQoWomKRiWkYHbs4WY+8nPtSvr2yZ8
         uCIQ==
X-Gm-Message-State: AOAM533Rs0p7mY7UtZbO11wfZU0Rurr62qNIZryiQ7AnyVvpWeBf9M6i
        I3U8dEvpJdJY66FCKm06sQcMgKJZyCQyZogvzLLJlABVS7Xp2dhjiwkA7Pgnz+mK/coWxasgavh
        Mu+9CgjXXneX0oWwcRMC23Q==
X-Received: by 2002:a0c:a942:0:b0:443:a395:cc1f with SMTP id z2-20020a0ca942000000b00443a395cc1fmr17508599qva.68.1649446298778;
        Fri, 08 Apr 2022 12:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6WRzVBUsxr4z76/Vo1yRAQPt5Sh/twBX7OswYQzgS+mj+QgxLxxuRtinZMaRFYjPQaDiZQA==
X-Received: by 2002:a0c:a942:0:b0:443:a395:cc1f with SMTP id z2-20020a0ca942000000b00443a395cc1fmr17508574qva.68.1649446298496;
        Fri, 08 Apr 2022 12:31:38 -0700 (PDT)
Received: from emilne (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u129-20020a376087000000b0067e401d7177sm14788983qkb.3.2022.04.08.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 12:31:37 -0700 (PDT)
Message-ID: <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     John Garry <john.garry@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     james.smart@broadcom.com
Date:   Fri, 08 Apr 2022 15:31:35 -0400
In-Reply-To: <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
         <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
         <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
         <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 2022-04-08 at 13:57 +0100, John Garry wrote:
> On 08/04/2022 13:32, Krzysztof Kozlowski wrote:
> > On 08/04/2022 14:14, John Garry wrote:
> > > On 08/04/2022 11:30, Krzysztof Kozlowski wrote:
> > > > Several pointers to 'struct scsi_host_template' do not modify it, so
> > > > made them const for safety.
> > > > 
> > > Is this standard practice? What is so special here?
> > This is standard practice and there is nothing special here. Pointers to
> > const are preferred because:
> > 1. They add safety if data is actually const. This is not yet the case,
> > but scsi_host_template allocation could be made const with some effort.

This seems unlikely, because some drivers, e.g. vmw_pvscsi and scsi_debug,
modify the scsi_host_template based on things like module parameters.

> 
> To me this seems better, but I think that some drivers might modify 
> their scsi_host_template (so not possible)

Several drivers modify scsi_host_template, e.g. .can_queue, .cmd_per_lun

There is also code in lpfc_create_port() that initializes a scsi_host_template
that is embedded in the lpfc_hba struct.  I don't think it gets modified after
scsi_add_host() but it seems like driver maintainers might expect to be able
to do so, in general.

-Ewan

> 
> > 2. The more const variables, the easier function contents and its impact
> > is to understand. This is actually the biggest benefit when dealing with
> > code touching different structures.
> > 
> > In general, constifying is a common practice everywhere in the kernel.
> 
> Thanks,
> John
> 

