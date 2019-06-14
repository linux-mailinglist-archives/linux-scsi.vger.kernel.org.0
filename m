Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E8450E9
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 02:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfFNAwY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 20:52:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFNAwY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 20:52:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BB5F308338F;
        Fri, 14 Jun 2019 00:52:23 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4EEC1A8F1;
        Fri, 14 Jun 2019 00:52:11 +0000 (UTC)
Date:   Fri, 14 Jun 2019 08:52:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH V2 00/15] scsi: use sg helper to operate sgl
Message-ID: <20190614005205.GA14436@ming.t460p>
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <1560444171.3329.46.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560444171.3329.46.camel@HansenPartnership.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 14 Jun 2019 00:52:24 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 13, 2019 at 09:42:51AM -0700, James Bottomley wrote:
> On Thu, 2019-06-13 at 15:13 +0800, Ming Lei wrote:
> > Hi,
> > 
> > Most of drivers use sg helpers to operate sgl, however there is
> > still a few drivers which operate sgl directly, this way can't
> > work in case of chained sgl.
> 
> This isn't a useful explanation of the issue you make it sound like a
> bug, which it isn't: it's a change of behaviour we'd like to introduce
> in SCSI.  Please reword the explanation more along the lines of
> 
> ---
> Scsi MQ makes a large static allocation for the first scatter gather
> list chunk for the driver to use.  This is a performance headache we'd
> like to fix by reducing the size of the allocation to a 2 element
> array.  Doing this will break the current guarantee that any driver
> using SG_ALL doesn't need to use the scatterlist iterators and can get
> away with directly dereferencing the array.  Thus we need to update all
> drivers to use the scatterlist iterators and remove direct indexing of
> the scatterlist array before reducing the initial scatterlist
> allocation size in SCSI.
> ---
> 
> Which explains what we're trying to do and why.
> 
> In particular changelogs like this
> 
> > The current way isn't safe for chained sgl, so use sgl helper to
> > operate sgl.
> 
> Are just plain wrong:  They were perfectly safe until you altered the
> conditions for using non-chained sgls.  Please use the above
> explanation in the patches, abbreviated if you like, so all recipients
> know why this needs doing and that it isn't an existing bug.

OK, will update with the above commit log in V3.

Thanks,
Ming
