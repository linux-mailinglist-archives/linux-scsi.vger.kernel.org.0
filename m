Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A37B8E95
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Oct 2023 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjJDVPs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Oct 2023 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjJDVPr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Oct 2023 17:15:47 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840E90
        for <linux-scsi@vger.kernel.org>; Wed,  4 Oct 2023 14:15:41 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57b5f0d658dso161287eaf.0
        for <linux-scsi@vger.kernel.org>; Wed, 04 Oct 2023 14:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696454141; x=1697058941;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gz+hnodpe1jpulko1EfHCPfImls0L+7oEzwajkxeIek=;
        b=U9B2S/trVThbemI1zdDDN+o7iSMU3AQsvKqx5H7JjHhyM8et5Bv8MOijaaamsHxfP+
         Se8CdHVVEIH1RdV61mdhVpc+sAUKVjVWomNCaGwWOYkgTPBWwPDVqzrDZR0iXmGFWMPW
         ue60i4lw5/wabbbzqSYS3i7Wkqxc/kf3Tky0FNo5sdHQv5WS0W+gq+/mwmylyNIoL0EY
         0dUy/t7qiRNif/nrLmf88OHymzwxY0odNbBzuAoDxeBKTbrf6/fWuBVcmmvnz/9f0wPu
         GPEtxcVtmN01pkMCStNDSEjeWlgCrEMCr4aymYtnaHDxk3Q0KeSp7ofM3hjwwMP/Jyz2
         HELg==
X-Gm-Message-State: AOJu0YzwgcmHR2SCRDSh6rvrpIZCkYj0TSbSwHjT1AUiRl29Z70UqE1J
        fVsiFnDRsiCCxvwdAUm6CEJVUAvKcmQ=
X-Google-Smtp-Source: AGHT+IHgRzEU9uFAseteebaqymRz1Bakir13tPbItvh/xbPGpNBWPJ7iWadmFYiPHZMa0Oh8MVBcEA==
X-Received: by 2002:a05:6358:8810:b0:143:a0bf:9a49 with SMTP id hv16-20020a056358881000b00143a0bf9a49mr3670394rwb.3.1696454140685;
        Wed, 04 Oct 2023 14:15:40 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id gi9-20020a17090b110900b00277246e857esm2012077pjb.23.2023.10.04.14.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 14:15:39 -0700 (PDT)
Message-ID: <0c1b5bd4-dce4-45ad-b978-8404b81c468d@acm.org>
Date:   Wed, 4 Oct 2023 14:15:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] scsi: sd: Fix sshdr use in sd_suspend_common
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, mwilck@suse.com,
        john.g.garry@oracle.com, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
References: <20231004210013.5601-1-michael.christie@oracle.com>
 <20231004210013.5601-8-michael.christie@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231004210013.5601-8-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/4/23 14:00, Mike Christie wrote:
> If scsi_execute_cmd returns < 0, it doesn't initialize the sshdr, so we
> shouldn't access the sshdr. If it returns 0, then the cmd executed
> successfully, so there is no need to check the sshdr. sd_sync_cache will
> only access the sshdr if it's been setup because it calls
> scsi_status_is_check_condition before accessing it. However, the
> sd_sync_cache caller, sd_suspend_common, does not check.
> 
> sd_suspend_common is only checking for ILLEGAL_REQUEST which it's using
> to determine if the command is supported. If it's not it just ignores
> the error. So to fix its sshdr use this patch just moves that check to
> sd_sync_cache where it converts ILLEGAL_REQUEST to success/0.
> sd_suspend_common was ignoring that error and sd_shutdown doesn't check
> for errors so there will be no behavior changes.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

