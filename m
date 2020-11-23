Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD62BFF60
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Nov 2020 06:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgKWFUl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Nov 2020 00:20:41 -0500
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:48336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgKWFUk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 23 Nov 2020 00:20:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 49C051802912A;
        Mon, 23 Nov 2020 05:20:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2540:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4659:5007:6119:7809:9010:9025:9388:10004:10400:10848:11232:11657:11658:11914:12043:12295:12297:12555:12679:12740:12760:12895:13161:13172:13229:13439:14093:14094:14096:14181:14659:14721:21080:21451:21611:21627:21691:21740:21987:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: rain84_0b0907d27362
X-Filterd-Recvd-Size: 3725
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Nov 2020 05:20:38 +0000 (UTC)
Message-ID: <394faaf71b72ba4310a5001b314c080fc47f1cae.camel@perches.com>
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        trix@redhat.com, clang-built-linux@googlegroups.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Sun, 22 Nov 2020 21:20:37 -0800
In-Reply-To: <f7643c9cb0a896f3ead65e86084b7c143e21ef43.camel@perches.com>
References: <20201121165058.1644182-1-trix@redhat.com>
         <5843ef910b0e86c00d9c0143dec20f93823b016b.camel@HansenPartnership.com>
         <f7643c9cb0a896f3ead65e86084b7c143e21ef43.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

(removing almost all the cc: lists and leaving scsi and lkml)

On Sat, 2020-11-21 at 10:02 -0800, Joe Perches wrote:
> On Sat, 2020-11-21 at 09:18 -0800, James Bottomley wrote:
> > On Sat, 2020-11-21 at 08:50 -0800, trix@redhat.com wrote:
> > > A difficult part of automating commits is composing the subsystem
> > > preamble in the commit log.  For the ongoing effort of a fixer
> > > producing one or two fixes a release the use of 'treewide:' does
> > > not seem appropriate.
> > > 
> > > It would be better if the normal prefix was used.  Unfortunately
> > > normal is not consistent across the tree.
> > > 
> > > 	D: Commit subsystem prefix
> > > 
> > > ex/ for FPGA DFL DRIVERS
> > > 
> > > 	D: fpga: dfl:
> > 
> > I've got to bet this is going to cause more issues than it solves. 
> > SCSI uses scsi: <driver>: for drivers but not every driver has a
> > MAINTAINERS entry.  We use either scsi: or scsi: core: for mid layer
> > things, but we're not consistent.  Block uses blk-<something>: for all
> > of it's stuff but almost no <somtehing>s have a MAINTAINERS entry.  So
> > the next thing you're going to cause is an explosion of suggested
> > MAINTAINERs entries.
> 
> As well as some changes require simultaneous changes across
> multiple subsystems.

Perhaps a start of this would be something like the below for a new
MAINTAINERS entry just for SCSI CORE.

This adds an "E:" patch prefix entry as well as a specific file
list for what seem to be "scsi core" files so that the generic
SCSI SUBSYSTEM F:drivers/scsi/ entry does not have to be used.

The SCSI SUBSYSTEM could have an E: entry of "scsi:" so that
driver specific content could be automatically prefixed with
"scsi: <basename(dirname)>:
---
 MAINTAINERS | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f10105cac6f..68521abd1bd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15631,6 +15631,24 @@ S:	Maintained
 W:	http://www.kernel.dk
 F:	drivers/scsi/sr*
 
+SCSI CORE
+M:	"James E.J. Bottomley" <jejb@linux.ibm.com>
+M:	"Martin K. Petersen" <martin.petersen@oracle.com>
+L:	linux-scsi@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-scsi/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
+E:	"scsi: core:"
+F:	include/linux/scsi*
+F:	drivers/scsi/constants.c
+F:	drivers/scsi/hosts.c
+F:	drivers/scsi/scsi.*
+F:	drivers/scsi/scsi_*
+F:	drivers/scsi/sd.c
+F:	drivers/scsi/sense_codes.h
+F:	drivers/scsi/sr.c
+
 SCSI RDMA PROTOCOL (SRP) INITIATOR
 M:	Bart Van Assche <bvanassche@acm.org>
 L:	linux-rdma@vger.kernel.org


