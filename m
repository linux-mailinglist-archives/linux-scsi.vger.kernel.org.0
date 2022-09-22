Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939925E68EC
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Sep 2022 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIVQ55 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Sep 2022 12:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVQ54 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 22 Sep 2022 12:57:56 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E34F50AF
        for <linux-scsi@vger.kernel.org>; Thu, 22 Sep 2022 09:57:55 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id go6so10418696pjb.2
        for <linux-scsi@vger.kernel.org>; Thu, 22 Sep 2022 09:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=V8oyQe4wFF2jcZ83gvqOWXyMfPhxU1NdI3vx3dP0/Cc=;
        b=rKJ8mNxY7SpW7l9CL9U/bsP6K4ZKI89MVypRCXfXAiyowI4l53FpMEJ4PWloLZk1Go
         otImRBlrP9RQnWMHLxZ4ZC5n9woedxeGNpmUeAzqUln8FbwHUx1411z53ZhxKXpcRv6I
         WHVdXgqXlBpZBDY73I2my0Fd0a0T/yTJGPkqu+yCdpPxswsNRVjK9p2dRQZcmuMncF47
         lm+2+Tm1R9XjeEphYR/pmDyTnzY/ef1nidWAGFANCqjwk0XfdG2XjDBN2xcVwiXxJH3x
         nWaB6cnmwd6GPG4fGhoszHXJGlLKW/Rlz2ngxtVNk2UDcZOjmfaKZEWMKET6zEvb/fgJ
         sIGA==
X-Gm-Message-State: ACrzQf0eJm76poTJwtkpSxZ3oQYo1EKnLpJVxV7PuPqne6PW3iEmLGla
        5tPmuh8vfRl1F6bG8KCwi8A=
X-Google-Smtp-Source: AMsMyM6MSidU0UCQWhJdMdKlnBqZ3wySFigmwH05Sj7HRLiroliPA9uUtj7OMFStP5IELODszfhx1A==
X-Received: by 2002:a17:90a:4607:b0:202:e22d:489c with SMTP id w7-20020a17090a460700b00202e22d489cmr16520094pjg.80.1663865874639;
        Thu, 22 Sep 2022 09:57:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7c7b:f882:f26a:23ca? ([2620:15c:211:201:7c7b:f882:f26a:23ca])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902710700b00176ae5c0f38sm4331492pll.178.2022.09.22.09.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:57:53 -0700 (PDT)
Message-ID: <d31df5c9-3e5c-224a-c8f8-296402e4cb58@acm.org>
Date:   Thu, 22 Sep 2022 09:57:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RFC 01/22] scsi: Add helper to prep sense during error
 handling
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, mwilck@suse.com,
        hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
References: <20220922100704.753666-1-michael.christie@oracle.com>
 <20220922100704.753666-2-michael.christie@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220922100704.753666-2-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/22/22 03:06, Mike Christie wrote:
> +static enum scsi_disposition scsi_prep_sense(struct scsi_cmnd *scmd,
> +					     struct scsi_sense_hdr *sshdr)

How about choosing another name for this function? All other functions 
with "prep" in their name are called before a command is submitted while 
this function is called from the completion path.

Thanks,

Bart.
