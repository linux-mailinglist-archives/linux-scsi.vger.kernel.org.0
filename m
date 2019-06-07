Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16EC38A46
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 14:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfFGM3J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 08:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbfFGM3J (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 7 Jun 2019 08:29:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7CB930832EA;
        Fri,  7 Jun 2019 12:29:04 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B37810AFF12;
        Fri,  7 Jun 2019 12:29:00 +0000 (UTC)
Message-ID: <5b07a1d65707a117e87ffc0f4173fdf20bbb1e9c.camel@redhat.com>
Subject: Re: [PATCH 1/3] scsi: Do not allow user space to change the SCSI
 device state into SDEV_BLOCK
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>
Date:   Fri, 07 Jun 2019 08:28:59 -0400
In-Reply-To: <470d4c41-1f9e-730e-a1dc-a27f9e971bc1@suse.com>
References: <20190605201435.233701-1-bvanassche@acm.org>
         <20190605201435.233701-2-bvanassche@acm.org>
         <cec3e805-c834-a389-9666-bb79ed86057d@suse.de>
         <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
         <470d4c41-1f9e-730e-a1dc-a27f9e971bc1@suse.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 12:29:08 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 2019-06-07 at 07:52 +0200, Hannes Reinecke wrote:
> On 6/6/19 7:26 PM, Bart Van Assche wrote:
> > On 6/5/19 10:46 PM, Hannes Reinecke wrote:
> > > Why not simply '-EPERM' ?
> > > Translating a state into something else seems counterproductive.
> > 
> > Personally I'm OK with returning -EPERM for attempts from user space to
> > change the device state into SDEV_BLOCK. The state translation is
> > something that was proposed about two months ago (see also
> > https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg82610.html).
> > 
> > > And, while we're at it:
> > > The only meaningful states to be set from userspace are 'RUNNING',
> > > 'OFFLINE', and 'BLOCK'.
> > > Everything else relates to the internal state machine and really
> > > shouldn't be touched from userspace at all.
> > > So I'd rather filter out everything _but_ the three states, avoid
> > > similar issue in the future.
> > 
> > Can you please clarify why you think it is useful to change the SCSI
> > device state from user space into SDEV_BLOCK? As one can see in
> > scsi_device_set_state() transitions from SDEV_BLOCK into the following
> > states are allowed: SDEV_RUNNING, SDEV_OFFLINE, SDEV_TRANSPORT_OFFLINE
> > and SDEV_DEL. The mpt3sas driver and also the FC, iSCSI and SRP
> > transport drivers all can call scsi_internal_device_unblock_nowait() or
> > scsi_target_unblock(). So at least for this LLD and these transport
> > drivers if the device state is set to SDEV_BLOCK from user space that
> > change can be overridden any time by kernel code. So I'm not sure it is
> > useful to change the device state into SDEV_BLOCK from user space.
> > 
> 
> Yes, I agree.
> 
> So let's restrict userspace to only ever setting 'RUNNING' or 'OFFLINE'.
> None of the other states make sense to set from userspace.
> 
> Cheers,
> 
> Hannes

I agree.

-Ewan

