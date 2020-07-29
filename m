Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD8232486
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jul 2020 20:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2SU6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Jul 2020 14:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2SU6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 Jul 2020 14:20:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B755C061794;
        Wed, 29 Jul 2020 11:20:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so14735083pgq.1;
        Wed, 29 Jul 2020 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vW72lIZ0Ccf+1grxPMJ95F8SyVI6+iUmEWNA1w/0dLs=;
        b=s+BE/qStaHWIG5Lq5Y8zKNrw2CHzDJisjuMWjl7Jp2ZmBoytg+ahIkiBYOmXtyXY7s
         XoE/N5Zvs0niauYyCQZfJPftkEoq1Xp3yNg0PnibxPb6SpRSTJ2/5y43BE2q/3vbH4KA
         AZgthmBrlvV7x24id0rD7zv+8+qfeJfjBuMSrT6tluvl0doKeALfRCXlUuvJEdPYOJ/d
         O35IHEkBZ11T13L+/M8hUiYcoeWP6oLshYIsSZwI74SfwtPPUcEDMCW5GeiGNb6BlT5e
         WOLf1LeBT2GBiGVLm/L4PbUVs9fGUwCPCSNPDinhdaIJQDm6sLVD2M77d9iw6vAoj5IA
         BSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vW72lIZ0Ccf+1grxPMJ95F8SyVI6+iUmEWNA1w/0dLs=;
        b=gH8FUkj06wHf6SBMAYl8jBNPG8+7dokqMP11jR8oouYA6LAdH9+zkfBXD+FfDk9wzS
         hWuOJPT+3gO7JwPSvW1lgqAOP0wamX2p5Dgg+q000i5HEZ7Hy5PTsPVlIyeXeloy/ZCU
         eC6GQD/s3+99kDwP2PJwSJPii/s8/2yN9BGDLjR0JW9NKRaqMsmbUWFc0qpMgzrPtWyh
         eQVoRMt72304u2/5fIIGqnszq8AB3GwBJg94pABjH/RIvSeQQ4hwmkHAyZcjogGSFQQF
         e1eD3HziRPc/r//sssYBnjXS+KTr8+PLNSjqLriiJr47ZfGDij6aNg4TM92wVPzZYH3X
         6GKg==
X-Gm-Message-State: AOAM532q3MBkv4aTIp0t3Qz961o01ZaD8uRiF5Rv3AT+rYvO51krYpQv
        zRBW7rW3r2evzFTtrC8d4dU=
X-Google-Smtp-Source: ABdhPJz9XT+Ab8Fqr2MXSwVPubmuHel1dafk38mq1W+T2oWCQaE/h4Q/4T+plIc0bnRUVLyh8TQYmA==
X-Received: by 2002:a63:fe42:: with SMTP id x2mr31003316pgj.207.1596046856188;
        Wed, 29 Jul 2020 11:20:56 -0700 (PDT)
Received: from blackclown ([103.88.82.91])
        by smtp.gmail.com with ESMTPSA id t1sm3166365pgq.66.2020.07.29.11.20.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 11:20:55 -0700 (PDT)
Date:   Wed, 29 Jul 2020 23:50:42 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] scsi: megaraid: Remove pci-dma-compat wrapper
 APIs.
Message-ID: <20200729182042.GA17008@blackclown>
References: <20200727140826.GE14759@blackclown>
 <yq1h7tr80ij.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1h7tr80ij.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jul 28, 2020 at 11:40:12PM -0400, Martin K. Petersen wrote:
> 
> Hello Suraj!
> 
> > The legacy API wrappers in include/linux/pci-dma-compat.h
> > should go away as it creates unnecessary midlayering
> > for include/linux/dma-mapping.h APIs, instead use dma-mapping.h
> > APIs directly.
> 
> Instead of all these individual patches, please submit a combined patch
> series for the changes under SCSI.
> 
> Each patch should fix a single driver. Please don't mix changes to
> completely different drivers such as hpsa and dc395x in a single
> commit. And please don't split semantically identical changes to the
> same driver into multiple commits (megaraid [2/2]).
> 
> Thank you!
> 
Hii Martin,
	Thanks for your response.
I sent a patch series for the above changes.

Thanks,

Suraj Upadhyay
> -- 
> Martin K. Petersen	Oracle Linux Engineering
