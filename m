Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F207825128F
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Aug 2020 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgHYHGa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Aug 2020 03:06:30 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:38566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729137AbgHYHG3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 Aug 2020 03:06:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A520D100E7B43;
        Tue, 25 Aug 2020 07:06:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3770:3865:3866:3867:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:7904:9010:9025:9388:10004:10400:10848:11232:11658:11914:12043:12048:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:13846:14096:14097:14181:14659:14721:14764:14777:21080:21451:21627:21672:21781:30012:30026:30054:30060:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tooth00_0809ad927059
X-Filterd-Recvd-Size: 2084
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 07:06:27 +0000 (UTC)
Message-ID: <dc8aca7e3772670782c2abc086cab8b6f81be3c1.camel@perches.com>
Subject: Re: [PATCH] scsi: megaraid: Remove unnecessary assignment to
 variable ret
From:   Joe Perches <joe@perches.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Aug 2020 00:06:26 -0700
In-Reply-To: <5e8d3765063043f7a90c92c098317319757595ed.camel@perches.com>
References: <20200825063836.92239-1-jingxiangfeng@huawei.com>
         <5e8d3765063043f7a90c92c098317319757595ed.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2020-08-25 at 00:01 -0700, Joe Perches wrote:
> On Tue, 2020-08-25 at 14:38 +0800, Jing Xiangfeng wrote:
> > The variable ret is being initialized with 'FAILED'. So we can remove
> > this assignement.
> 
> If you are going to change the code at all,
> might as well try to improve it more by removing
> the unnecessary out: label altogether.

Looks like the megaraid mailing list is either subscribers-only
or doesn't exist anymore as my mail to it bounced.

One of the maintainers should remove it or update it.

Maybe:
---
diff --git a/MAINTAINERS b/MAINTAINERS
index ac79fdbdf8d0..0c181cd07201 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11060,7 +11060,7 @@ MEGARAID SCSI/SAS DRIVERS
 M:	Kashyap Desai <kashyap.desai@broadcom.com>
 M:	Sumit Saxena <sumit.saxena@broadcom.com>
 M:	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
-L:	megaraidlinux.pdl@broadcom.com
+L:	megaraidlinux.pdl@broadcom.com (subscribers-only)
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 W:	http://www.avagotech.com/support/


