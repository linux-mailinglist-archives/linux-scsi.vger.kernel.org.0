Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2029334062C
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Mar 2021 13:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCRMzM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Mar 2021 08:55:12 -0400
Received: from verein.lst.de ([213.95.11.211]:41581 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhCRMy4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Mar 2021 08:54:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 616BA68C4E; Thu, 18 Mar 2021 13:54:54 +0100 (CET)
Date:   Thu, 18 Mar 2021 13:54:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 4/8] advansys: remove ISA support
Message-ID: <20210318125453.GB21262@lst.de>
References: <20210318063923.302738-1-hch@lst.de> <20210318063923.302738-5-hch@lst.de> <20210318112025.GK3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318112025.GK3420@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Mar 18, 2021 at 11:20:25AM +0000, Matthew Wilcox wrote:
> On Thu, Mar 18, 2021 at 07:39:19AM +0100, Christoph Hellwig wrote:
> > @@ -2875,7 +2859,6 @@ static void asc_prt_asc_board_eeprom(struct seq_file *m, struct Scsi_Host *shost
> >  	uchar serialstr[13];
> >  #ifdef CONFIG_ISA
> >  	ASC_DVC_VAR *asc_dvc_varp;
> > -	int isa_dma_speed[] = { 10, 8, 7, 6, 5, 4, 3, 2 };
> >  
> >  	asc_dvc_varp = &boardp->dvc_var.asc_dvc_var;
> >  #endif /* CONFIG_ISA */
> 
> I think you can remove the conditional definition & assignment of
> asc_dvc_varp here.

The way I read the driver CONFIG_ISA also covers Vesa Local Bus
support, which is not removed by this patch.  Corret me if I'm wrong.
