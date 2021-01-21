Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87402FE17F
	for <lists+linux-scsi@lfdr.de>; Thu, 21 Jan 2021 06:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbhAUFYJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Jan 2021 00:24:09 -0500
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:40666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727030AbhAUFQz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 21 Jan 2021 00:16:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 39D4A182CED2A;
        Thu, 21 Jan 2021 05:15:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3868:3870:3871:4321:5007:7652:10004:10400:10848:11026:11232:11658:11914:12296:12297:12555:12740:12895:13069:13255:13311:13357:13439:13894:14659:14721:21080:21627:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lip23_251530d27560
X-Filterd-Recvd-Size: 1810
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 Jan 2021 05:15:45 +0000 (UTC)
Message-ID: <6af62f13816f24cd525865c91892d53483748d0e.camel@perches.com>
Subject: Re: [PATCH v2] scsi/qla4xxx: convert sysfs sprintf/snprintf family
 to sysfs_emit/sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Jan 2021 21:15:43 -0800
In-Reply-To: <9d745731-f8a3-98bf-3ca8-6367ef53aa8d@acm.org>
References: <1611201437-111938-1-git-send-email-abaci-bugfix@linux.alibaba.com>
         <9d745731-f8a3-98bf-3ca8-6367ef53aa8d@acm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2021-01-20 at 20:55 -0800, Bart Van Assche wrote:
> On 1/20/21 7:57 PM, Jiapeng Zhong wrote:
> > -		return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d (%x)\n",
> > +		return sysfs_emit_at(buf, PAGE_SIZE, "%d.%02d.%02d (%x)\n",
> >  				ha->fw_info.fw_major, ha->fw_info.fw_minor,
> >  				ha->fw_info.fw_patch, ha->fw_info.fw_build);
> 
> From the sysfs_emit_at() source code:
> 
> WARN(... || at >= PAGE_SIZE, "invalid sysfs_emit_at: buf:%p at:%d\n",
> buf, at)
> 
> In other words, this patch is wrong. sysfs_emit() should have been used
> instead of sysfs_emit_at().

Instead, use the cocci script from

commit aa838896d87a ("drivers core: Use sysfs_emit and sysfs_emit_at for
show(device *...) functions")
 


