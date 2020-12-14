Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354102D9CEF
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Dec 2020 17:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502120AbgLNQrS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Dec 2020 11:47:18 -0500
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:46500 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502118AbgLNQrS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 14 Dec 2020 11:47:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6CA581730873;
        Mon, 14 Dec 2020 16:46:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3873:4250:4321:5007:6737:7576:10004:10400:10848:11026:11232:11473:11658:11914:12048:12297:12438:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30012:30029:30054:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: look56_4507fd12741c
X-Filterd-Recvd-Size: 2092
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 14 Dec 2020 16:46:31 +0000 (UTC)
Message-ID: <ade665cbfa138d1851343576caad84a61e904c46.camel@perches.com>
Subject: Re: [PATCH v2 1/6] scsi: ufs: Remove stringize operator '#'
 restriction
From:   Joe Perches <joe@perches.com>
To:     Bean Huo <huobean@gmail.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, rostedt@goodmis.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Dec 2020 08:46:30 -0800
In-Reply-To: <20201214161502.13440-2-huobean@gmail.com>
References: <20201214161502.13440-1-huobean@gmail.com>
         <20201214161502.13440-2-huobean@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2020-12-14 at 17:14 +0100, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Current EM macro definition, we use stringize operator '#', which turns
> the argument it precedes into a quoted string. Thus requires the symbol
> of __print_symbolic() should be the string corresponding to the name of
> the enum.
> 
> However, we have other cases, the symbol and enum name are not the same,
> we can redefine EM/EMe, but there will introduce some redundant codes.
> This patch is to remove this restriction, let others reuse the current
> EM/EMe definition.

I think the other way (adding new definitions for the cases when the
name and string are different) is less error prone.

> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
[]
> +#define UFS_LINK_STATES						\
> +	EM(UIC_LINK_OFF_STATE, "UIC_LINK_OFF_STATE")		\
> +	EM(UIC_LINK_ACTIVE_STATE, "UIC_LINK_ACTIVE_STATE,")	\

For instance:

Like here where you added an unnecessary and unwanted comma


