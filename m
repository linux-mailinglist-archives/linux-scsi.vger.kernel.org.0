Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522602C1CBA
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Nov 2020 05:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgKXEdT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Nov 2020 23:33:19 -0500
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:53014 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728828AbgKXEdT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 23 Nov 2020 23:33:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C1265837F24A;
        Tue, 24 Nov 2020 04:33:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:4321:4362:5007:9040:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21451:21627:30012:30054:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bread73_1a0b27a2736b
X-Filterd-Recvd-Size: 1221
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Nov 2020 04:33:16 +0000 (UTC)
Message-ID: <3b5f1d63666a1cf70143574f75cfb0d7f5d0e0de.camel@perches.com>
Subject: Re: [PATCH 0/2] scsi: pm8001: logging neatening
From:   Joe Perches <joe@perches.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Nov 2020 20:33:15 -0800
In-Reply-To: <yq1r1ojmoa5.fsf@ca-mkp.ca.oracle.com>
References: <cover.1605914030.git.joe@perches.com>
         <yq1r1ojmoa5.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2020-11-23 at 22:23 -0500, Martin K. Petersen wrote:
> > Reduce code duplication and generic neatening of logging macros
> 
> Applied to 5.11/scsi-staging, thanks!

Thanks.

The kernel robot reported an indentation defect here so I will send
a couple more patches on top of this.


