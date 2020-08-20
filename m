Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADA424C5EF
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Aug 2020 20:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHTSyD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Aug 2020 14:54:03 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:33368 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726985AbgHTSyC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Aug 2020 14:54:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7A7D918223278;
        Thu, 20 Aug 2020 18:54:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:4321:5007:8957:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12740:12760:12895:13069:13095:13311:13357:13439:14659:14721:21080:21433:21627:21990:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: thumb46_1e02cc727032
X-Filterd-Recvd-Size: 1887
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Aug 2020 18:54:00 +0000 (UTC)
Message-ID: <a99fde707b367b0cee126b596b2dc7a74dbb84e7.camel@perches.com>
Subject: Re: [PATCH] scsi: mptfusion: Remove unnecessarily casts
From:   Joe Perches <joe@perches.com>
To:     Alex Dewar <alex.dewar90@gmail.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Aug 2020 11:53:58 -0700
In-Reply-To: <20200820180552.853289-1-alex.dewar90@gmail.com>
References: <20200820180552.853289-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2020-08-20 at 19:05 +0100, Alex Dewar wrote:
> In a number of places, the value returned from pci_alloc_consistent() is
> unnecessarily cast from void*. Remove these casts.
[]
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
[]
> @@ -4975,7 +4975,7 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
>  
>  	if (hdr.PageLength > 0) {
>  		data_sz = hdr.PageLength * 4;
> -		ppage0_alloc = (LANPage0_t *) pci_alloc_consistent(ioc->pcidev, data_sz, &page0_dma);
> +		ppage0_alloc = pci_alloc_consistent(ioc->pcidev, data_sz, &page0_dma);
>  		rc = -ENOMEM;
>  		if (ppage0_alloc) {
>  			memset((u8 *)ppage0_alloc, 0, data_sz);

If you are removing unnecessary casts, it'd be better to remove
all of them in the same file or subsystem at once.

Also this memset and cast isn't actually necessary any more
as pci_alloc_consistent already zeros memory.

etc...

