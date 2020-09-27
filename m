Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E0279E53
	for <lists+linux-scsi@lfdr.de>; Sun, 27 Sep 2020 06:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgI0Ewd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 27 Sep 2020 00:52:33 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:42408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbgI0Ewd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 27 Sep 2020 00:52:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 382941800F757;
        Sun, 27 Sep 2020 04:52:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3868:3872:4321:4385:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21611:21627:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: war34_5a00deb27176
X-Filterd-Recvd-Size: 1820
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Sep 2020 04:52:30 +0000 (UTC)
Message-ID: <4472b9ad60cde126e2098503665dfc35f8385992.camel@perches.com>
Subject: Re: [PATCH v2 3/3] scsi: megaraid_sas: simplify compat_ioctl
 handling
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Anand Lodnoor <anand.lodnoor@broadcom.com>,
        megaraidlinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sat, 26 Sep 2020 21:52:29 -0700
In-Reply-To: <CAK8P3a01930JPMj6ie=9+GtvRQThPzxH0_ge+OWydcZd7qRkSA@mail.gmail.com>
References: <20200918120955.1465510-1-arnd@arndb.de>
         <20200918121543.1466090-1-arnd@arndb.de>
         <20200919052622.GE30063@infradead.org>
         <CAK8P3a01930JPMj6ie=9+GtvRQThPzxH0_ge+OWydcZd7qRkSA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 2020-09-26 at 23:19 +0200, Arnd Bergmann wrote:
> On Sat, Sep 19, 2020 at 7:26 AM Christoph Hellwig <hch@infradead.org> wrote:
> > On Fri, Sep 18, 2020 at 02:15:43PM +0200, Arnd Bergmann wrote:
[]
> 
> > > +     return ioc;
> > > +out:
> > > +     kfree(ioc);
> > > +
> > > +     return ERR_PTR(err);
> > 
> > spurious empty line.
> 
> ok

I suggest moving the blank line so it's between
the return ioc and out: label.


