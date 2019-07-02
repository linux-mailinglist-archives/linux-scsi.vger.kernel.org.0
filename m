Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D995D2B1
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jul 2019 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGBPWT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 11:22:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41837 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfGBPWT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Jul 2019 11:22:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so6357600pgj.8;
        Tue, 02 Jul 2019 08:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kj2iqZ3cddozRXWMsn7Ev9o9aw1c31FcRRKlce4rrD0=;
        b=VS7czYRv/+6aS3EsQdWmiuHLzAvgk/WTwaU70gqUWu1sGi9bLK0JNbwqaJOKKdYEiH
         T8sO0WTyTWVcV2LWGnKNIRO1liWEk81aXPG0PV11LzbN5HYCyliv4PKGns6hnn/GdqBm
         ML5mUtQ2rKDGkW3luL6Xarp0H3mtui0VZ0OppG5gzh5fv2a3mGbDnXS6MHWfWDO1sc8b
         goEab9NNL32ltJDgKy15YGCOtbP2BLnrsN50ksZa/Pe000D2Kr4ij0i3mQtRVQP7Rof6
         K49AP4h1MLA4RuxJsCIOJ1pOZF+tpA8oOIQBTyqicCo32/rOgG90AIPoL+PKBCW3qq/S
         PXKQ==
X-Gm-Message-State: APjAAAVbegbe0o/l/g3KwT/BvYnOIccjcke4CvvYswxF6I9hKr3HgQzW
        if6PozCpDGJG8LIiGaZPKTlmLAIH
X-Google-Smtp-Source: APXvYqxvONcRcpjM1uC0mIKUkyqzQw2Fdg2yqsQtOE8qHzQFrV16iw0FfG+KYJ2TZy7UcFTSYW/q3w==
X-Received: by 2002:a63:52:: with SMTP id 79mr30859589pga.381.1562080938393;
        Tue, 02 Jul 2019 08:22:18 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a16sm20235061pfd.68.2019.07.02.08.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 08:22:17 -0700 (PDT)
Subject: Re: [PATCH] scsi: target/iblock: Fix overrun in WRITE SAME emulation
To:     Roman Bolshakov <r.bolshakov@yadro.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190701171226.81654-1-r.bolshakov@yadro.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <87cb4792-ebb5-fd37-5fab-b3f66e9ed5e9@acm.org>
Date:   Tue, 2 Jul 2019 08:22:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701171226.81654-1-r.bolshakov@yadro.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/1/19 10:12 AM, Roman Bolshakov wrote:
> WRITE SAME corrupts data on the block device behind iblock if the
> command is emulated. The emulation code issues (M - 1) * N times more
> bios than requested, where M is the number of 512 blocks per real block
> size and N is the NUMBER OF LOGICAL BLOCKS specified in WRITE SAME
> command. So, for a device with 4k blocks, 7 * N more LBAs gets written
> after the requested range.
> 
> The issue happens because the number of 512 byte sectors to be written
> is decreased one by one while the real bios are typically from 1 to 8
> 512 byte sectors per bio.
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>   drivers/target/target_core_iblock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index f4a075303e9a..6949ea8bc387 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -502,7 +502,7 @@ iblock_execute_write_same(struct se_cmd *cmd)
>   
>   		/* Always in 512 byte units for Linux/Block */
>   		block_lba += sg->length >> SECTOR_SHIFT;
> -		sectors -= 1;
> +		sectors -= sg->length >> SECTOR_SHIFT;
>   	}
>   
>   	iblock_submit_bios(&list);

Please add the following to this patch:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: <stable@vger.kernel.org>
Fixes: c66ac9db8d4a ("[SCSI] target: Add LIO target core v4.0.0-rc6")

Thanks,

Bart.


