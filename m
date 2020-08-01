Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB423511B
	for <lists+linux-scsi@lfdr.de>; Sat,  1 Aug 2020 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHAIKc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 1 Aug 2020 04:10:32 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:39208 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbgHAIKc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 1 Aug 2020 04:10:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 314001800F08E;
        Sat,  1 Aug 2020 08:10:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2196:2199:2393:2525:2560:2563:2682:2685:2692:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4385:5007:6119:7903:8660:9025:10004:10400:10848:11026:11232:11233:11658:11914:12043:12295:12296:12297:12438:12740:12760:12895:13069:13071:13095:13148:13161:13163:13229:13230:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21220:21433:21451:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: bears44_4f154d426f8a
X-Filterd-Recvd-Size: 2765
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Aug 2020 08:10:29 +0000 (UTC)
Message-ID: <0c1803c6aaca42579b7933fd219e4e208ab7524f.camel@perches.com>
Subject: Re: [PATCH] scsi: libcxgbi: use kvzalloc instead of opencoded
 kzalloc/vzalloc
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Aug 2020 01:10:28 -0700
In-Reply-To: <c5a18804-3236-9688-2a3c-68184f0dd9e8@linux.com>
References: <20200731215524.14295-1-efremov@linux.com>
         <33d943d2b83f17371df09b5962c856ea2d894954.camel@perches.com>
         <70fb8220-2102-adb5-bbe6-9c2ea74a0623@linux.com>
         <8638183f559c0f8f8d377bd0a6c91903b2c588df.camel@perches.com>
         <c5a18804-3236-9688-2a3c-68184f0dd9e8@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 2020-08-01 at 10:51 +0300, Denis Efremov wrote:
> On 8/1/20 1:24 AM, Joe Perches wrote:
> > On Sat, 2020-08-01 at 01:10 +0300, Denis Efremov wrote:
> > > On 8/1/20 12:58 AM, Joe Perches wrote:
> > > > On Sat, 2020-08-01 at 00:55 +0300, Denis Efremov wrote:
> > > > > Remove cxgbi_alloc_big_mem(), cxgbi_free_big_mem() functions
> > > > > and use kvzalloc/kvfree instead.
> > > > 
> > > > Sensible, thanks.
> > > > 
> > > > > diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
> > > > []
> > > > > @@ -77,9 +77,9 @@ int cxgbi_device_portmap_create(struct cxgbi_device *cdev, unsigned int base,
> > > > >  {
> > > > >  	struct cxgbi_ports_map *pmap = &cdev->pmap;
> > > > >  
> > > > > -	pmap->port_csk = cxgbi_alloc_big_mem(max_conn *
> > > > > -					     sizeof(struct cxgbi_sock *),
> > > > > -					     GFP_KERNEL);
> > > > > +	pmap->port_csk = kvzalloc(array_size(max_conn,
> > > > > +					     sizeof(struct cxgbi_sock *)),
> > > > > +				  GFP_KERNEL);
> > > > 
> > > > missing __GFP_NOWARN
> > > > 
> > > 
> > > kvmalloc_node adds __GFP_NOWARN internally to kmalloc call
> > > https://elixir.bootlin.com/linux/v5.8-rc4/source/mm/util.c#L568
> > 
> > Only when there's a fallback, and the fallback does not.
> Sorry, Joe, I don't understand why do we need to add __GFP_NOWARN here.

Hi.

The reason to add __GFP_NOWARN is so you don't get a
dump_stack() as there's an existing error message
output below this when OOM.

You should either remove the error message as it just
effectively duplicates the dump_stack or add __GFP_NOWARN.

Your choice.

cheers, Joe

