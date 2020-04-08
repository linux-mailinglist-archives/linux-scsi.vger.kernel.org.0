Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B871A29C6
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Apr 2020 21:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgDHTv7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Apr 2020 15:51:59 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:49414 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730187AbgDHTv7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Apr 2020 15:51:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C5D1F838437F;
        Wed,  8 Apr 2020 19:51:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2892:2902:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3870:3871:3872:3874:4250:4321:4433:5007:7903:8660:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13148:13230:13439:14093:14097:14181:14659:14721:21080:21212:21433:21451:21627:21660:21740:21939:30054:30064:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: point91_4b1a2c45aca56
X-Filterd-Recvd-Size: 3830
Received: from XPS-9350 (unknown [172.58.19.195])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Apr 2020 19:51:55 +0000 (UTC)
Message-ID: <2de69a35463317f5eca2ce665b0ee8b90b8c717b.camel@perches.com>
Subject: Re: [PATCH] scsi: core: Rate limit "rejecting I/O" messages
From:   Joe Perches <joe@perches.com>
To:     "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Wed, 08 Apr 2020 12:49:52 -0700
In-Reply-To: <120ce7f4cd1fd070e1f7c353223c21b8e4f29337.camel@redhat.com>
References: <20200408171012.76890-1-dwagner@suse.de>
         <120ce7f4cd1fd070e1f7c353223c21b8e4f29337.camel@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2020-04-08 at 15:16 -0400, Ewan D. Milne wrote:
> On Wed, 2020-04-08 at 19:10 +0200, Daniel Wagner wrote:
> > Prevent excessive logging by rate limiting the "rejecting I/O"
> > messages. For example in setups where remote syslog is used the link
> > is saturated by those messages when a storage controller/disk
> > misbehaves.
> > 
> > Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  drivers/scsi/scsi_lib.c    |  4 ++--
> >  include/scsi/scsi_device.h | 10 ++++++++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 47835c4b4ee0..01c35c58c6f3 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1217,7 +1217,7 @@ scsi_prep_state_check(struct scsi_device *sdev,
> > struct request *req)
> >  		 */
> >  		if (!sdev->offline_already) {
> >  			sdev->offline_already = true;
> > -			sdev_printk(KERN_ERR, sdev,
> > +			sdev_printk_ratelimited(KERN_ERR, sdev,
> >  				    "rejecting I/O to offline
> > device\n");
> 
> I would really prefer we not do it this way if at all possible.
> It loses information we may need to debug SAN outage problems.
> 
> The reason I didn't use ratelimit is that the ratelimit structure is
> per-instance of the ratelimit call here, not per-device.  So this
> doesn't work right -- it will drop messages for other devices.

Could add a ratelimit_state to struct scsi_device.

Something like:
---
 drivers/scsi/scsi_scan.c   | 2 ++
 include/scsi/scsi_device.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f2437a..938c83f 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -279,6 +279,8 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
 					sdev->host->cmd_per_lun : 1);
 
+	ratelimit_state_init(&sdev->rs, DEFAULT_RATELIMIT_INTERVAL,
+			     DEFAULT_RATELIMIT_BURST);
 	scsi_sysfs_device_initialize(sdev);
 
 	if (shost->hostt->slave_alloc) {
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index c3cba2..2600de7 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <scsi/scsi.h>
 #include <linux/atomic.h>
+#include <linux/ratelimit.h>
 
 struct device;
 struct request_queue;
@@ -233,6 +234,7 @@ struct scsi_device {
 	struct mutex		state_mutex;
 	enum scsi_device_state sdev_state;
 	struct task_struct	*quiesced_by;
+	struct ratelimit_state	rs;
 	unsigned long		sdev_data[];
 } __attribute__((aligned(sizeof(unsigned long))));
 


