Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D936D2E8
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Apr 2021 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhD1HS2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Apr 2021 03:18:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhD1HS1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 28 Apr 2021 03:18:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 805AFAF38;
        Wed, 28 Apr 2021 07:17:42 +0000 (UTC)
Date:   Wed, 28 Apr 2021 09:17:42 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Roman Bolshakov <r.bolshakov@yadro.com>,
        linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
        Nilesh Javali <njavali@marvell.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [EXT] Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
Message-ID: <20210428071742.rvgogvzigj2yypx2@beryllium.lan>
References: <20210419100014.47144-1-dwagner@suse.de>
 <YH8QzgWiec8vka20@SPB-NB-133.local>
 <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
 <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
 <20210421075659.dwaz7gt6hyqlzpo4@beryllium.lan>
 <20210427095131.zf6c4siewnrhv7qd@beryllium.lan>
 <alpine.LRH.2.21.9999.2104271531440.24132@irv1user01.caveonetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2104271531440.24132@irv1user01.caveonetworks.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Arun,

On Tue, Apr 27, 2021 at 03:35:47PM -0700, Arun Easi wrote:
> > I am sure this can be done in a more elegant way. Anyway, I am testing
> > this right now, the first 30 minutes look good...
> > 
> 
> Looks ok to me. Just keep in mind that, with this you'd be setting all 
> instances of pn-XXX (multiple initiator ports seeing the same target 
> scenario). It looks like this is what you want, but thought I'd point that 
> out.

Good point. Yes, that's was the plan, set all ports to the same
value. BTW, an 8 hours port toggle test passed. With this setup we don't
need to add dirty patches downstream.

Thanks,
Daniel

