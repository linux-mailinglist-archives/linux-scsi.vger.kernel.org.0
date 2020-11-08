Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8045F2AA8A9
	for <lists+linux-scsi@lfdr.de>; Sun,  8 Nov 2020 01:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgKHA7O (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 7 Nov 2020 19:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHA7N (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 7 Nov 2020 19:59:13 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA45C0613CF;
        Sat,  7 Nov 2020 16:59:13 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id i7so3653658qti.6;
        Sat, 07 Nov 2020 16:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AsoeVCmseQ5falp3iLcr/023VW5hw+9BKoCmJiBAHrM=;
        b=I6pWa/qy63L5WDoz0Trohqivs1fJhx3Ftlr1xuEKVx+OL9oWs+Vk7fg4t3R8EAqqcI
         LfEAJmtBoMby7sWL9nr1Bwos+DeYoTij6/zbNQe2SOFJ1wkbyyw8mQvHyN2Ql88hh01/
         BvmseNbmqd+I5AvewzWOaC8eXza+ly7g5joM8x2qh9oyAVbmHdV3aTaHTE8SB8xaFKSj
         Ndp0O+v3eQX9FG0xfd8dEbUlu9med/6gyaTF1hJ2bz4yJ77xk5/w60CZpyEDhxO53wkN
         3TvePkULpSyqFHrBRY9geyKhhw3r1+HXqPwbFAMqGZ3tyqKHIBMS8tQHii9cw5pDyb/N
         NC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AsoeVCmseQ5falp3iLcr/023VW5hw+9BKoCmJiBAHrM=;
        b=IgEMtR/8/WBpxZxgeKQRcvD7hIB8cw2vKFAdpk0yCXrnV2nSy5umUO5v/4UJ2ukdXX
         aBs+TPCcyShRxg+Hl75Wzk8fC57bjfQvcJKpVi17wUTojyIxFP61vTXd9vRKvBG0VOyX
         a87Ufukesj6whH/2GUf0x+q0Wsjtddka7y6MIQNpJJ1fTLHYGheO7QJ9qaJ/Wdf3+o9s
         /KuuL6Q650laLKfMLeqRaGx5HsyCS7cboVu53a/qM6au4tK5lXNKUWWUx01y4/MzAofR
         O08MfNjyNrJHVKcKGexV/c8qv1IdIEIH3kZfHy3ONBMsv7F0WqIbNS2XesnLMHzNLwkK
         f1og==
X-Gm-Message-State: AOAM531ed2hJBL4sAlYlvqCIg8zLado5NSLSDRNcnVTcG9BW2ujRfVtL
        HVWMOyTwtJVniCCisiGT4ej2Vf03/9Q=
X-Google-Smtp-Source: ABdhPJwm8GbJkxLqfOIO2w/9boHTysTjvBVD8nbbUVGeWvKW8boB6H3XG1z2taCJgaKFb7ZLVlPSgQ==
X-Received: by 2002:ac8:5191:: with SMTP id c17mr8095758qtn.116.1604797152258;
        Sat, 07 Nov 2020 16:59:12 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r14sm3465343qtu.25.2020.11.07.16.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 16:59:11 -0800 (PST)
Date:   Sat, 7 Nov 2020 17:59:10 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] scsi: core: fix -Wformat
Message-ID: <20201108005910.GA95971@ubuntu-m3-large-x86>
References: <20201107081132.2629071-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081132.2629071-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Nov 07, 2020 at 12:11:32AM -0800, Nick Desaulniers wrote:
> Clang is more aggressive about -Wformat warnings when the format flag
> specifies a type smaller than the parameter. Turns out, struct
> Scsi_Host's member can_queue is actually an int. Fixes:
> 
> warning: format specifies type 'short' but the argument has type 'int'
> [-Wformat]
> shost_rd_attr(can_queue, "%hd\n");
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                           %d
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/scsi/scsi_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index d6e344fa33ad..b6378c8ca783 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -370,7 +370,7 @@ static DEVICE_ATTR(eh_deadline, S_IRUGO | S_IWUSR, show_shost_eh_deadline, store
>  
>  shost_rd_attr(unique_id, "%u\n");
>  shost_rd_attr(cmd_per_lun, "%hd\n");
> -shost_rd_attr(can_queue, "%hd\n");
> +shost_rd_attr(can_queue, "%d\n");
>  shost_rd_attr(sg_tablesize, "%hu\n");
>  shost_rd_attr(sg_prot_tablesize, "%hu\n");
>  shost_rd_attr(unchecked_isa_dma, "%d\n");
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
