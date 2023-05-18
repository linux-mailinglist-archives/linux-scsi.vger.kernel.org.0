Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A295C708711
	for <lists+linux-scsi@lfdr.de>; Thu, 18 May 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjERRmE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 May 2023 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjERRmD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 May 2023 13:42:03 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2EEAA
        for <linux-scsi@vger.kernel.org>; Thu, 18 May 2023 10:42:03 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-52867360efcso1573484a12.2
        for <linux-scsi@vger.kernel.org>; Thu, 18 May 2023 10:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684431722; x=1687023722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeBbiy6X/Idd7+c0V2xgZxhApBBujKrwwPpSU8uDQmc=;
        b=J7Dq1a2x5VZFdrlcImP3gzkKrzQWgdexAorqvWqEPH55gPXvpuzHxUiooDFu/y9dxw
         rwRO1xK8d3mhQ5UjG8Pb263FLOdHFtWnn6VLiLJLeSjO1R4I1ghWPTE1y8nkGMQafr2E
         vU5Br2but9cbiIigQAmM4B8Oz9ukVWcQcwL+JdbgReljZKWdWZZ2kHr2O7nCU3MIekVZ
         XIrYS/U9T8rASpWYr+yeRRhAfRjr21srGiXsNBR0/riiqBZqEPmhURklk+Q2CJ6bMm39
         kfRGcNRluHJTq6x2C397cLQC8QxS9jHs+T3KB0UKMA2G5Xjyd7vol5jR9cADK1tXzqIJ
         EvQw==
X-Gm-Message-State: AC+VfDw3TEohD7s6rOAEeEtVhaWRkYvD2FMl9Zaw2XaeLjfvCEaRZJzQ
        LHHVSucTHpbHWUS95b8s+0v3PL6KQP4=
X-Google-Smtp-Source: ACHHUZ577i1/hM4dtC3+2yzBkQ11hqW25ZdpPNR2Dcu/BoSKEcNuibEgHwPfiIkBYU04UpTPUZ7x/g==
X-Received: by 2002:a17:902:7b8f:b0:1ae:2e0f:1cf6 with SMTP id w15-20020a1709027b8f00b001ae2e0f1cf6mr3206100pll.36.1684431722236;
        Thu, 18 May 2023 10:42:02 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i14-20020a170902c94e00b001a967558656sm1745101pla.42.2023.05.18.10.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 10:42:01 -0700 (PDT)
Message-ID: <f312be96-786e-f5f3-a92e-54a5983dfa19@acm.org>
Date:   Thu, 18 May 2023 10:42:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/8] qla2xxx: klocwork - Fix potential null pointer
 dereference
Content-Language: en-US
To:     Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
        bhazarika@marvell.com, agurumurthy@marvell.com,
        sdeodhar@marvell.com
References: <20230518075841.40363-1-njavali@marvell.com>
 <20230518075841.40363-3-njavali@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230518075841.40363-3-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/18/23 00:58, Nilesh Javali wrote:
> From: Bikash Hazarika <bhazarika@marvell.com>
> 
> Klocwork tool reported 'cur_dsd' may be dereferenced.
> Add fix to validate pointer before dereferencing
> the pointer.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bikash Hazarika <bhazarika@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_iocb.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
> index 6acfdcc48b16..a092151aef77 100644
> --- a/drivers/scsi/qla2xxx/qla_iocb.c
> +++ b/drivers/scsi/qla2xxx/qla_iocb.c
> @@ -664,9 +664,11 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *sp, struct cmd_type_6 *cmd_pkt,
>   	}
>   
>   	/* Null termination */
> -	cur_dsd->address = 0;
> -	cur_dsd->length = 0;
> -	cur_dsd++;
> +	if (cur_dsd) {
> +		cur_dsd->address = 0;
> +		cur_dsd->length = 0;
> +		cur_dsd++;
> +	}
>   	cmd_pkt->control_flags |= cpu_to_le16(CF_DATA_SEG_DESCR_ENABLE);
>   	return 0;
>   }

Please add BUG_ON(!cur_dsd) above the first cur_dsd dereference instead 
of making the above change. The above change hides a bug. Hiding bugs 
doesn't help anyone.

Bart.
