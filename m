Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBBA5F4CAE
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Oct 2022 01:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJDXms (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Oct 2022 19:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJDXmr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Oct 2022 19:42:47 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B03201B3
        for <linux-scsi@vger.kernel.org>; Tue,  4 Oct 2022 16:42:45 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id b5so13932722pgb.6
        for <linux-scsi@vger.kernel.org>; Tue, 04 Oct 2022 16:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wcg3MPzv3QN9/roevZ+1Ap6gohBmD5NkGzGhhx53WDA=;
        b=UnbIBg6Nyy57/YTpnIROa2GK4SXrz1xs5LLZKpX3miwsP1YRnzZUE3PRvPAt+jzdm5
         IvmJqarG+W+48biNRBlIc1QuDSYZHmd15kEEcSRqVqOZMuJ9D5XmDbs5kVUx6dxotY3a
         4tv5B3CaYKbD+dnfTR6Z68Vqxhsg7MteFfP+wsU0B2mqdy/PN8d4I+1IeZJLhKhfSMfW
         GAcwx9SLAzqd/ev+p6pJaVq/wTdGAafBSUTvl1AIJIqERkyK4t4Dsi1Jv1a/fGBxfTsR
         O+HymsYFYy87Of25yMR/tNMRBoZ+ImyBpx2aOvwXbGZueX7ycleQFYVOToixTMGx6c24
         KwJQ==
X-Gm-Message-State: ACrzQf0pnSQamZFEO0Iy1+igk5YpTQEAvb8Cj8kZjLaz+4RosPxiyfOq
        GwaYap/hqCmzgcXGSh9tkmo=
X-Google-Smtp-Source: AMsMyM54rL0Ele1OrlUcepCMD92IN6zgW3LJphT6dV7uh1D2Iv+lO8SIJicUQTyk1FXe1cAYRQR17A==
X-Received: by 2002:a05:6a00:4006:b0:53e:815a:ff71 with SMTP id by6-20020a056a00400600b0053e815aff71mr29769623pfb.4.1664926965284;
        Tue, 04 Oct 2022 16:42:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b6b5:f763:ff03:8283? ([2620:15c:211:201:b6b5:f763:ff03:8283])
        by smtp.gmail.com with ESMTPSA id c92-20020a17090a496500b0020a11217682sm106954pjh.27.2022.10.04.16.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 16:42:44 -0700 (PDT)
Message-ID: <4fda7b49-7fc0-7372-961e-e70c870d67bb@acm.org>
Date:   Tue, 4 Oct 2022 16:42:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 32/35] scsi: sd: Have scsi-ml retry read_capacity_10
 errors
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, mwilck@suse.com,
        hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
References: <20221003175321.8040-1-michael.christie@oracle.com>
 <20221003175321.8040-33-michael.christie@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221003175321.8040-33-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/3/22 10:53, Mike Christie wrote:
> +	cmd[0] = READ_CAPACITY;
> +	memset(&cmd[1], 0, 9);

Please remove the above code and change the cmd[] declaration into something like

static const u8 cmd[10] = { READ_CAPACITY };

Thanks,

Bart.
