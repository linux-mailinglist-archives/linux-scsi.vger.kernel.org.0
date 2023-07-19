Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD1759D88
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jul 2023 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGSSi2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jul 2023 14:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSSi1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jul 2023 14:38:27 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E87FC7
        for <linux-scsi@vger.kernel.org>; Wed, 19 Jul 2023 11:38:27 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b8b318c5a7so56741655ad.3
        for <linux-scsi@vger.kernel.org>; Wed, 19 Jul 2023 11:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791906; x=1692383906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ICFuB5hn8Hu5GH+U12LfEiv0w6eIDU4+9u4wS6pZ6Q=;
        b=SZsn7VpsDMP6poGlGNvsOTvjxVBUGpT7we5EBddP+mHcipW+f94QDY1V332HHIUICj
         sxmf90OHaglpzNrambe+cu8onbATukZLrO3WWDyOqyEgGIPirZilPQFa1MILhJFSW4zo
         jJk8b0UBIJw0gJkpi/ewmR4cOSeijIrQD6MoJ/T/LOP0ywWWmzFne9TZ4u1GGGVgTNky
         p/TSn9pPiyZxY7EXfwQMt4HO8Cyw3bII2D+yw0/MrmFdJXNDvle8NLRMEuzbrV7Ymh6T
         0FhuwcyVSumA1ZcIdZ6U12kYO9u08cWzi9RGD0JmSMfAoYlufdcpEvrh3/DxUkdaoqPK
         5K/w==
X-Gm-Message-State: ABy/qLbxf6mvmhF6eGJ/ZCoxxX8d9vvKCeZWDodssmvb3gMxf79Tmuwn
        q/vtymhBLvI6mKKC9Mdq1A0=
X-Google-Smtp-Source: APBJJlGmz4QsJyWQ3vIxKMV0kpGglUH7it19Enw6kZZT/S6o0kbxGlH3K+pmLfBtn9GOsgrjI45xxA==
X-Received: by 2002:a17:902:ed8b:b0:1b3:e90b:93e1 with SMTP id e11-20020a170902ed8b00b001b3e90b93e1mr16784838plj.36.1689791906468;
        Wed, 19 Jul 2023 11:38:26 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a2ab:183f:c76c:d30d? ([2620:15c:211:201:a2ab:183f:c76c:d30d])
        by smtp.gmail.com with ESMTPSA id bj8-20020a170902850800b001b6674b6140sm4281303plb.290.2023.07.19.11.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 11:38:26 -0700 (PDT)
Message-ID: <967c1c6a-c9dc-48d5-4671-98148ba82a60@acm.org>
Date:   Wed, 19 Jul 2023 11:38:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v10 07/33] scsi: sd: Have scsi-ml retry read_capacity_16
 errors
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        john.g.garry@oracle.com, mwilck@suse.com, hch@lst.de,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
References: <20230714213419.95492-1-michael.christie@oracle.com>
 <20230714213419.95492-8-michael.christie@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230714213419.95492-8-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/14/23 14:33, Mike Christie wrote:
> This has read_capacity_16 have scsi-ml retry errors instead of driving
> them itself.

Assuming John's comments will be addressed:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

