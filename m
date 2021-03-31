Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85D34EEEE
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Mar 2021 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhC3REG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Mar 2021 13:04:06 -0400
Received: from verein.lst.de ([213.95.11.211]:59800 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232634AbhC3RDX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 30 Mar 2021 13:03:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26B5568B02; Tue, 30 Mar 2021 19:03:21 +0200 (CEST)
Date:   Tue, 30 Mar 2021 19:03:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/8] Buslogic: remove ISA support
Message-ID: <20210330170320.GC13829@lst.de>
References: <20210326055822.1437471-1-hch@lst.de> <20210326055822.1437471-3-hch@lst.de> <90427abe-f0a3-c6fc-a674-7a3967e20882@gonehiking.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90427abe-f0a3-c6fc-a674-7a3967e20882@gonehiking.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Mar 29, 2021 at 02:29:21PM -0600, Khalid Aziz wrote:
> On 3/25/21 11:58 PM, Christoph Hellwig wrote:
> > The ISA support in Buslogic has been broken for a long time, as all
> > the I/O path expects a struct device for DMA mapping that is derived from
> > the PCI device, which would simply crash for ISA adapters.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/scsi/BusLogic.c | 156 ++--------------------------------------
> >  drivers/scsi/BusLogic.h |   3 -
> >  drivers/scsi/Kconfig    |   2 +-
> >  3 files changed, 6 insertions(+), 155 deletions(-)
> > 
> 
> Hi Chris,
> 
> This looks good. There is more code that can be removed, for instance
> all of the code that supports "IO:" driver option to specify ISA port
> addresses. enum blogic_adapter_bus_type can shrink. "limited_isa" and
> "probe*" members of struct blogic_probe_options can go away. You could
> add those to this patch, or if you would like, I can create a follow-on
> patch to remove that code.

I've added the above suggestions.  If there is anything more you
can easily think of let me know.
