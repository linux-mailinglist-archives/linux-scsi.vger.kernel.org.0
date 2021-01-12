Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4635E2F2AC9
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 10:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbhALJIX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 04:08:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727750AbhALJIW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Jan 2021 04:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610442415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQxW4Rp9hAeG9MWVRxpWkAVSDGuS5ozpYGrzrzDY5aQ=;
        b=QRhVy01IUIgCz5VNqsbol2PvZM4rtHMkhXlnPpUpI90zgEoPm1lw+DKI7+kZITV5xZ6tlt
        3sjtuLX7UEJVg8hCr6WDRtWoyxSTs70OwdmRdhjdOtKA9Y/kQpHNhiiCPVzqv0qEvubmkG
        EcDCTqZM9Ao2hOeSC5bL84xNiUvS3KY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-nRd17vSBMJ-FatVTOrF8wQ-1; Tue, 12 Jan 2021 04:06:51 -0500
X-MC-Unique: nRd17vSBMJ-FatVTOrF8wQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE610B8121;
        Tue, 12 Jan 2021 09:06:49 +0000 (UTC)
Received: from T590 (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B2756F44B;
        Tue, 12 Jan 2021 09:06:39 +0000 (UTC)
Date:   Tue, 12 Jan 2021 17:06:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: About scsi device queue depth
Message-ID: <20210112090634.GA97446@T590>
References: <9ff894da-cf2c-9094-2690-1973cc57835a@huawei.com>
 <20210112014203.GA60605@T590>
 <4b50f067-a368-2197-c331-a8c981f5cd02@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b50f067-a368-2197-c331-a8c981f5cd02@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jan 12, 2021 at 08:56:45AM +0000, John Garry wrote:
> Hi Ming,
> 
> > > 
> > > I was looking at some IOMMU issue on a LSI RAID 3008 card, and noticed that
> > > performance there is not what I get on other SAS HBAs - it's lower.
> > > 
> > > After some debugging and fiddling with sdev queue depth in mpt3sas driver, I
> > > am finding that performance changes appreciably with sdev queue depth:
> > > 
> > > sdev qdepth	fio number jobs* 	1	10	20
> > > 16					1590	1654	1660
> > > 32					1545	1646	1654
> > > 64					1436	1085	1070
> > > 254 (default)				1436	1070	1050
> > 
> > What does the performance number mean? IOPS or others? What is the fio
> > io test? random IO or sequential IO?
> 
> So those figures are x1K IOPs read performance; so 1590, above, is 1.59M
> IOPs read. Here's the fio script:
> 
> [global]
> rw=read
> direct=1
> ioengine=libaio
> iodepth=40
> numjobs=20
> bs=4k
> ;size=10240000m
> ;zero_buffers=1
> group_reporting=1
> ;ioscheduler=noop
> ;cpumask=0xffe
> ;cpus_allowed=1-47
> ;gtod_reduce=1
> ;iodepth_batch=2
> ;iodepth_batch_complete=2
> runtime=60
> ;thread
> loops = 10000

Is there any effect on random read IOPS when you decrease sdev queue
depth? For sequential IO, IO merge can be enhanced by that way.

> 
> > > 
> > > fio queue depth is 40, and I'm using 12x SAS SSDs.
> > > 
> > > I got comparable disparity in results for fio queue depth = 128 and num jobs
> > > = 1:
> > > 
> > > sdev qdepth	fio number jobs* 	1	
> > > 16					1640
> > > 32					1618	
> > > 64					1577	
> > > 254 (default)				1437	
> > > 
> > > IO sched = none.
> > > 
> > > That driver also sets queue depth tracking = 1, but never seems to kick in.
> > > 
> > > So it seems to me that the block layer is merging more bios per request, as
> > > averge sg count per request goes up from 1 - > upto 6 or more. As I see,
> > > when queue depth lowers the only thing that is really changing is that we
> > > fail more often in getting the budget in
> > > scsi_mq_get_budget()->scsi_dev_queue_ready().
> > 
> > Right, the behavior basically doesn't change compared with block legacy
> > io path. And that is why sdev->queue_depth is a bit important for HDD.
> 
> OK
> 
> > 
> > > 
> > > So initial sdev queue depth comes from cmd_per_lun by default or manually
> > > setting in the driver via scsi_change_queue_depth(). It seems to me that
> > > some drivers are not setting this optimally, as above.
> > > 
> > > Thoughts on guidance for setting sdev queue depth? Could blk-mq changed this
> > > behavior?
> > 
> > So far, the sdev queue depth is provided by SCSI layer, and blk-mq can
> > queue one request only if budget is obtained via .get_budget().
> > 
> 
> Well, based on my testing, default sdev queue depth seems too large for that
> LLDD ...

Yeah, it is similar with NVMe since people often cares latency more for
SSD.


-- 
Ming

