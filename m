Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911A62F378C
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 18:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbhALRq5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 12:46:57 -0500
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:49248 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391624AbhALRqy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Jan 2021 12:46:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D740C181D304D;
        Tue, 12 Jan 2021 17:46:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3868:3873:4321:5007:7652:10004:10400:10848:11026:11232:11658:11914:12043:12048:12114:12297:12438:12740:12895:13069:13311:13357:13439:13894:14659:21080:21627:30030:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: body58_371324127517
X-Filterd-Recvd-Size: 1714
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Jan 2021 17:46:11 +0000 (UTC)
Message-ID: <60398acb9f26e60e3c1d6ab9c2d8bab4a89f2a91.camel@perches.com>
Subject: Re: [PATCH] scsi: mpt3sas: Simplify _base_display_OEMs_branding
From:   Joe Perches <joe@perches.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 12 Jan 2021 09:46:10 -0800
In-Reply-To: <DM5PR0401MB3591D23001DAC0AFB4F11D589BAA0@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <b4a0b8c97a95f56c64532eff83289831449e2b0d.camel@perches.com>
         <DM5PR0401MB3591D23001DAC0AFB4F11D589BAA0@DM5PR0401MB3591.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2021-01-12 at 17:40 +0000, Johannes Thumshirn wrote:
> On 12/01/2021 18:38, Joe Perches wrote:
> >  static void
> >  _base_display_OEMs_branding(struct MPT3SAS_ADAPTER *ioc)
> >  {
> > +	const char *b = NULL;	/* brand */
> > +	const char *v = NULL;	/* vendor */
> 
> Any reason you didn't spell out brand and vendor as the variable names?

80 column lines.


