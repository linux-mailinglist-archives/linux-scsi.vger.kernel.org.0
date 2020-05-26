Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30E21C372F
	for <lists+linux-scsi@lfdr.de>; Mon,  4 May 2020 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgEDKuB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 May 2020 06:50:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728104AbgEDKuA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 May 2020 06:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588589399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QPdkegKkQaUD8YoFWrnzzlTYvUa1Kpn69i8w5h1cwpc=;
        b=bY/m1GNI/qSmqz40EbjmSApjelHi9HlAi96gwCTeKiFwaVt+kC2ozKlOIyunPH/cJl5iw6
        t19zahtwXfsHiHaha4oPBiHl9Hno+u5FmNXxi5q31mNNCLHvSg46YdPDHcAO5SajQdyB1K
        aitviaqBMxdG8seyV3NqTVHXCG+LL5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-4HzxRqcKNV2UCB_DbI-lfQ-1; Mon, 04 May 2020 06:49:55 -0400
X-MC-Unique: 4HzxRqcKNV2UCB_DbI-lfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76EB1107ACCA;
        Mon,  4 May 2020 10:49:54 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57C6A10016DA;
        Mon,  4 May 2020 10:49:46 +0000 (UTC)
Date:   Mon, 4 May 2020 18:49:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH RFC v3 04/41] csiostor: use reserved command for LUN reset
Message-ID: <20200504104942.GE1139563@T590>
References: <20200430131904.5847-5-hare@suse.de>
 <20200430151546.GB1005453@T590>
 <cd0f88db-96ec-d69f-f33e-b10a1cb3756d@suse.de>
 <20200501150129.GB1012188@T590>
 <20200501174505.GC23795@lst.de>
 <eea98eb5-1779-cf06-e930-e47fb4918306@suse.de>
 <20200502142907.GE1013372@T590>
 <8795fedc-8b07-fbfc-89f5-0cb76ee054b0@suse.de>
 <20200504084700.GB1139563@T590>
 <902fae06-8ad7-9abd-c76c-61f975471711@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <902fae06-8ad7-9abd-c76c-61f975471711@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, May 04, 2020 at 12:24:41PM +0200, Hannes Reinecke wrote:
> On 5/4/20 10:47 AM, Ming Lei wrote:
> > On Mon, May 04, 2020 at 08:55:05AM +0200, Hannes Reinecke wrote:
> > > On 5/2/20 4:29 PM, Ming Lei wrote:
> > > > On Sat, May 02, 2020 at 10:49:32AM +0200, Hannes Reinecke wrote:
> > > > > On 5/1/20 7:45 PM, Christoph Hellwig wrote:
> > > > > > On Fri, May 01, 2020 at 11:01:29PM +0800, Ming Lei wrote:
> > > > > > > > We cannot increase MAX_QUEUE arbitrarily as this is a compile time variable,
> > > > > > > > which seems to relate to a hardware setting.
> > > > > > > > 
> > > > > > > > But I can see to update the reserved command functionality for allowing to
> > > > > > > > fetch commands from the normal I/O tag pool; in the case of LUN reset it
> > > > > > > > shouldn't make much of a difference as the all I/O is quiesced anyway.
> > > > > > > 
> > > > > > > It isn't related with reset.
> > > > > > > 
> > > > > > > This patch reduces active IO queue depth by 1 anytime no matter there is reset
> > > > > > > or not, and this way may cause performance regression.
> > > > > > 
> > > > > > But isn't it the right thing to do?  How else do we guarantee that
> > > > > > there always is a tag available for the LU reset?
> > > > > > 
> > > > > Precisely. One could argue that this is an issue with the current driver,
> > > > > too; if all tags have timed-out there is no way how we can send a LUN reset
> > > > > even now. Hence we need to reserve a tag for us to reliably send a LUN
> > > > > reset.
> > > > > And this was precisely the problem what sparked off this entire patchset;
> > > > > some drivers require a valid tag to send internal, non SCSI commands to the
> > > > > hardware.
> > > > 
> > > > Could you explain a bit how you conclude that csio_scsi reset hander has to
> > > > use one unique tag? At least we don't allocate request from block layer for
> > > > ioctl(SG_SCSI_RESET), see scsi_ioctl_reset(). Also this patch doesn't
> > > > use the reserved rq->tag too.
> > > > 
> > > > > And with the current design it requires some really ugly hacks to make this
> > > > > to work.
> > > > 
> > > > You also don't explain how csio_eh_lun_reset_handler() is broken and where
> > > > the ugly hack is in csio scsi too, and how this patch fixes the issue, could
> > > > you document the exact reason in the commit log?
> > > > 
> > > The problem is the ioctl path.
> > > When issuing TMF commands from the ioctl path we currently do not have a
> > > valid SCSI command to pass to the various SCSI EH functions.
> > > This requires the SCSI LLDDs to check for every EH function whether the
> > > passed in SCSI command is valid (ie coming from SCSI EH), or a made up one
> > > coming from the ioctl path.
> > 
> > Could you point out where the check is in csio driver?
> > 
> Okok, I see your point.
> 
> Indeed the csiostor driver doesn't use the 'tag' per se for submitting
> commands; it's just using the scsi command pointer as a tag to figure out if
> a completion has been send from the hw.
> 
> I'll be giving it a bit more thought, and will be dropping it for the next
> round (which will contain only the minimal changes to get the
> 'reserved_cmds' interface in).

IMO, the 'reserved_cmds' interface is only needed in case that RESET
command is transported from IO channel. Any HBA which has dedicated
channel for sending RESET doesn't need this interface.

Thanks,
Ming

