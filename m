Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3C3C8967
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Jul 2021 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhGNRNK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Jul 2021 13:13:10 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48297 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S237725AbhGNRNJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Jul 2021 13:13:09 -0400
Received: (qmail 386661 invoked by uid 1000); 14 Jul 2021 13:10:16 -0400
Date:   Wed, 14 Jul 2021 13:10:16 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Garry <john.garry@huawei.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Hannes Reinecke <hare@suse.com>,
        "chenxiang \(M\)" <chenxiang66@hisilicon.com>,
        Xiejianqin <xiejianqin@hisilicon.com>
Subject: Re: SCSI layer RPM deadlock debug suggestion
Message-ID: <20210714171016.GE380727@rowland.harvard.edu>
References: <9e90d035-fac1-432a-1d34-de5805d8f799@huawei.com>
 <20210702203142.GA49307@rowland.harvard.edu>
 <ec4a3038-34b0-084f-a1bd-039827465dd1@acm.org>
 <1081c3ed-0762-58c7-8b99-8b3721c710bd@huawei.com>
 <20210705131712.GB116379@rowland.harvard.edu>
 <a5b9109c-cad6-0057-29c9-8974fda3347c@suse.de>
 <47f35811-33c5-9620-45d5-8201e5ec5db3@huawei.com>
 <20210714161027.GC380727@rowland.harvard.edu>
 <dc75007c-4a07-d1a9-6b86-2f6d2dc59271@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc75007c-4a07-d1a9-6b86-2f6d2dc59271@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jul 14, 2021 at 05:48:36PM +0100, John Garry wrote:
> > > 
> > > And that looks to solve the deadlock which I was seeing. I'm not sure on
> > > side-effects elsewhere.
> > > 
> > > We'll test it a bit more.
> > 
> > In the absence of any bad reports, here is a proposal for a patch.
> > 
> > Comments?
> > 
> > Alan Stern
> 
> Hi Alan,
> 
> Sorry for not getting back to you sooner. Testing so far with the originally
> proposed change [0] has not raised any issues and has solved the deadlock.
> 
> But we have a list of other problems to deal with in the RPM area related to
> the LLDD/libsas, so were waiting to address all of them (or at least have a
> plan) before progressing this change.
> 
> One such issue is that when we issue the link-reset which causes the device
> to be lost in the test, the disk is not found again. The customer may not be
> happy with this, so we're investigating solutions.
> 
> As for your change itself, I had something similar sitting on our dev
> branch:
> 
> [0] https://github.com/hisilicon/kernel-dev/commit/3696ca85c1e00257c96e40154d28b936742430c4
> 
> For me, I'm happy to hold off on any change, but if you think it's serious
> enough to progress your patch, below, now, then I think that should be ok.

No, I don't think it's all that serious.  The scenario is probably 
pretty rare in real life, outside of a few odd circumstances like yours.  
I'm happy to wait until you're comfortable with a full set of changes.

Alan Stern
