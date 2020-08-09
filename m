Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D523FC34
	for <lists+linux-scsi@lfdr.de>; Sun,  9 Aug 2020 04:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHICiA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 8 Aug 2020 22:38:00 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:55698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726097AbgHICiA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 8 Aug 2020 22:38:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8E2EF18224512;
        Sun,  9 Aug 2020 02:37:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:4321:4605:5007:7903:8603:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12679:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:21972:30054:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:5,LUA_SUMMARY:none
X-HE-Tag: join82_5c010db26fce
X-Filterd-Recvd-Size: 2767
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Aug 2020 02:37:58 +0000 (UTC)
Message-ID: <cd3a39d4ef3da9968026549e285dea3ef4261795.camel@perches.com>
Subject: Re: [PATCH v3 1/3] scsi: 3w-9xxx: Use flexible array members to
 avoid struct padding
From:   Joe Perches <joe@perches.com>
To:     Samuel Holland <samuel@sholland.org>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 08 Aug 2020 19:37:57 -0700
In-Reply-To: <20200809004727.53107-1-samuel@sholland.org>
References: <20200809004727.53107-1-samuel@sholland.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 2020-08-08 at 19:47 -0500, Samuel Holland wrote:
> In preparation for removing the "#pragma pack(1)" from the driver, fix
> all instances where a trailing array member could be replaced by a
> flexible array member. Since a flexible array member has zero size, it
> introduces no padding, whether or not the struct is packed.
[]
> diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
[]
> @@ -676,7 +676,7 @@ static long twa_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
>  	data_buffer_length_adjusted = (driver_command.buffer_length + 511) & ~511;
>  
>  	/* Now allocate ioctl buf memory */
> -	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted+sizeof(TW_Ioctl_Buf_Apache) - 1, &dma_handle, GFP_KERNEL);
> +	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev, data_buffer_length_adjusted + sizeof(TW_Ioctl_Buf_Apache), &dma_handle, GFP_KERNEL);

Trivia:

It's perhaps more sensible to order the arguments with
the size of the struct first then the data length so
the argument is in the order of the expected content.

	cpu_addr = dma_alloc_coherent(&tw_dev->tw_pci_dev->dev,
				      sizeof(TW_Ioctl_Buf_Apache) + data_buffer_length_adjusted,
				      &dma_handle, GFP_KERNEL);

> @@ -685,7 +685,7 @@ static long twa_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
>  	tw_ioctl = (TW_Ioctl_Buf_Apache *)cpu_addr;
>  
>  	/* Now copy down the entire ioctl */
> -	if (copy_from_user(tw_ioctl, argp, driver_command.buffer_length + sizeof(TW_Ioctl_Buf_Apache) - 1))
> +	if (copy_from_user(tw_ioctl, argp, driver_command.buffer_length + sizeof(TW_Ioctl_Buf_Apache)))

	if (copy_from_user(tw_ioctl, argp, sizeof(TW_Ioctl_Buf_Apache) + driver_command.buffer_length))

etc...


