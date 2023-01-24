Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5505A679D66
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Jan 2023 16:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjAXP06 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Jan 2023 10:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjAXP05 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 24 Jan 2023 10:26:57 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1689C22DEC
        for <linux-scsi@vger.kernel.org>; Tue, 24 Jan 2023 07:26:56 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id jm10so15004679plb.13
        for <linux-scsi@vger.kernel.org>; Tue, 24 Jan 2023 07:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8dV7eDYS1H4GLp9a7W/N9SpIRzYUS4IC/tWeG1sQZE=;
        b=LvdmcIuBM3evFI7wwm643eHkD8fcSh1r3WSESARNjRKuCuOYAB+0NdyBRo0ReaTw7b
         zfZtNxttWBFcSpJqMiUriDW6hKPR3m68egtsiIPgZliX7TTuKGq7StxsxHZOAjoOBWp4
         uwwYrAVYdddBRsApdfU1+bLOldwF0Fgt1MtQKupyxu8USteFNYlJMJatrGuxiKNMILtg
         erPvcTB/V3lhDWXWgOx99bs37rNFbNxjZ7vaCCT2aKGQEX0vlYXPQYvYQuA9xij8ccbQ
         ieIGOLJmLxKj03BF4atjpCfkToJCZyiFTkmODU5BZFYUYuPDCyegocVzzbfBtgqzBpGK
         T7Xg==
X-Gm-Message-State: AFqh2kpiVd3Koi2OZNb661+lUCkfrOEzesBOcLEHj0TMsXpVB6CYkmvH
        DYHOZVFc8oMeEi46rfaDjGg=
X-Google-Smtp-Source: AMrXdXvV0lo9GPOxYwDtWyqNXMpCACPlrv+/fJmw5dDRKnfaaENIJHuogo5FpNZMoKWu075iRVTtpw==
X-Received: by 2002:a05:6a20:1611:b0:b4:6f9:ef7d with SMTP id l17-20020a056a20161100b000b406f9ef7dmr37275505pzj.35.1674574015480;
        Tue, 24 Jan 2023 07:26:55 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 184-20020a6204c1000000b0058da56167b7sm1710924pfe.127.2023.01.24.07.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:26:54 -0800 (PST)
Message-ID: <3be42d58-2225-c77f-63d6-1a5bcbafeecb@acm.org>
Date:   Tue, 24 Jan 2023 07:26:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] scsi: add non-sleeping variant of scsi_device_put()
 and use it in alua
Content-Language: en-US
To:     Martin Wilck <mwilck@suse.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>
References: <20230124143025.3464-1-mwilck@suse.com>
 <e84388f4-4e33-d7a7-a121-a02dfd9038a5@acm.org>
 <e6828fb381f5a330c1f341d806b3ebfc21f3489b.camel@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e6828fb381f5a330c1f341d806b3ebfc21f3489b.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/24/23 07:26, Martin Wilck wrote:
> Or simply mentioning that the call from scsi_device_put() is legal?

That's fine with me.

Thanks,

Bart.

