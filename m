Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED231FA7F4
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2020 06:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFPEvl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jun 2020 00:51:41 -0400
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:59226 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725306AbgFPEvl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Jun 2020 00:51:41 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 00:51:40 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 529FD182D3EC5
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2020 04:42:26 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1AC321260;
        Tue, 16 Jun 2020 04:42:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:152:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:9025:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12740:12895:13069:13255:13311:13357:13894:14181:14659:14721:21080:21451:21627:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: song81_2704b2626dfc
X-Filterd-Recvd-Size: 2406
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Jun 2020 04:42:23 +0000 (UTC)
Message-ID: <4c9323077204a22683cd3ed92fea303a1a8b67fc.camel@perches.com>
Subject: Re: [PATCH][next] scsi: fnic: Replace vmalloc() + memset() with
 vzalloc() and use array_size()
From:   Joe Perches <joe@perches.com>
To:     "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Mon, 15 Jun 2020 21:42:22 -0700
In-Reply-To: <873653F8-8FBB-4A9B-9380-B476674ECADE@cisco.com>
References: <20200615225428.GA14959@embeddedor>
         <873653F8-8FBB-4A9B-9380-B476674ECADE@cisco.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2020-06-16 at 00:19 +0000, Satish Kharat (satishkh) wrote:
> Reviewed-by: Satish Kharat <satishkh@cisco.com>
> ﻿
> 
> On 6/15/20, 3:49 PM, "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
>     Use vzalloc() instead of the vmalloc() and memset. Also, use array_size()
>     instead of the open-coded version.
>     
>     This issue was found with the help of Coccinelle and, audited and fixed
>     manually.
>     
>     Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
>     Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>     ---
>      drivers/scsi/fnic/fnic_trace.c | 16 ++++------------
>      1 file changed, 4 insertions(+), 12 deletions(-)
>     
>     diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
[]
>     @@ -488,7 +488,7 @@ int fnic_trace_buf_init(void)
>      	}
>      
>      	fnic_trace_entries.page_offset =
>     -		vmalloc(array_size(fnic_max_trace_entries,
>     +		vzalloc(array_size(fnic_max_trace_entries,
>      				   sizeof(unsigned long)));

Perhaps better as
		kvcalloc(fnic_max_trace_entries, sizeof(unsigned long),
			 GFP_KERNEL);


