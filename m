Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6040042B46C
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Oct 2021 07:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJMFNV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Oct 2021 01:13:21 -0400
Received: from verein.lst.de ([213.95.11.211]:44166 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhJMFNU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Oct 2021 01:13:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A5E8167373; Wed, 13 Oct 2021 07:11:15 +0200 (CEST)
Date:   Wed, 13 Oct 2021 07:11:15 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Saurav Kashyap <skashyap@marvell.com>
Cc:     "hch@lst.de" <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Nilesh Javali <njavali@marvell.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [EXT] Re: [PATCH 0/2] qla2xxx - add nvme map_queues support
Message-ID: <20211013051115.GA25113@lst.de>
References: <20210823125649.16061-1-njavali@marvell.com> <c72c7669-8818-77f1-2e5d-98bb24308f08@grimberg.me> <DM6PR18MB30340DC93DCC82CFFAAE3ACCD2C59@DM6PR18MB3034.namprd18.prod.outlook.com> <YSRrmOmrwm5olk0D@T590> <DM6PR18MB30341F714429F8552EB4E126D2C69@DM6PR18MB3034.namprd18.prod.outlook.com> <DM6PR18MB30345F9B2131600CDFEA91AFD2D39@DM6PR18MB3034.namprd18.prod.outlook.com> <DM6PR18MB3034746DCB33C51D8CA4EEFED2DA9@DM6PR18MB3034.namprd18.prod.outlook.com> <20210914083249.GA5341@lst.de> <DM6PR18MB30342CF2C3CB23EE3B947841D2B79@DM6PR18MB3034.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR18MB30342CF2C3CB23EE3B947841D2B79@DM6PR18MB3034.namprd18.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Oct 13, 2021 at 05:09:04AM +0000, Saurav Kashyap wrote:
> Hi Christoph,
> 
> > > Hi Sagi/Christoph,
> > >
> > > I haven't heard anything on this and there are no review comments on this
> > patch set, kindly include this in nvme tree.
> > >
> > 
> > I'll queue this up once the 5.16 tree opens unless James voices any
> > objections.
> 
> Any updates on this one?

http://git.infradead.org/nvme.git/commitdiff/062b5291ef352d6198c6c8414c71ae2debd06cf7
