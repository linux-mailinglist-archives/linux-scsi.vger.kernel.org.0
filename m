Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F973B80E4
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Jun 2021 12:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhF3Kis (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Jun 2021 06:38:48 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60192 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhF3Kir (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 30 Jun 2021 06:38:47 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D4AA092009C; Wed, 30 Jun 2021 12:36:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C737792009B;
        Wed, 30 Jun 2021 12:36:14 +0200 (CEST)
Date:   Wed, 30 Jun 2021 12:36:14 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Nix <nix@esperi.org.uk>, Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PING][PATCH v2 0/5] Bring the BusLogic host bus adapter driver
 up to Y2021
In-Reply-To: <yq1eed9cjkl.fsf@ca-mkp.ca.oracle.com>
Message-ID: <alpine.DEB.2.21.2106250007050.37803@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104201934280.44318@angie.orcam.me.uk> <alpine.DEB.2.21.2106110102340.1657@angie.orcam.me.uk> <yq1eed9cjkl.fsf@ca-mkp.ca.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Martin,

> > Where are we with this patch series?  I can see it's been archived in
> > patchwork in the new state.  With the unexpected serial device fixes
> > which preempted me and which I've just posted, moving them off the
> > table I now have some spare cycles to get back here, but I'm not sure
> > what to do.
> 
> Some of the patches were clashing with my device discovery changes.
> Your series is still in my inbox, have just been swamped with testing
> and integrating several fundamental core modifications the last few
> weeks.
> 
> I'll get to it before the merge window...

 Sounds good, thanks!  I got distracted again, in particular by this nice 
HiFive Unmatched board, but please do let me know if I can assist you with 
these changes somehow.  E.g. shall I resolve the clashes (which branch?)?
I'm away from my lab for the time being, but I can do all the usual stuff 
remotely.

  Maciej
