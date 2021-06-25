Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9A3B3C4B
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Jun 2021 07:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhFYFkP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Jun 2021 01:40:15 -0400
Received: from verein.lst.de ([213.95.11.211]:56678 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233104AbhFYFkO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 25 Jun 2021 01:40:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EBAEB67373; Fri, 25 Jun 2021 07:37:51 +0200 (CEST)
Date:   Fri, 25 Jun 2021 07:37:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: remove REQ_OP_SCSI_{IN,OUT}
Message-ID: <20210625053751.GA22164@lst.de>
References: <20210624123935.479229-1-hch@lst.de> <BYAPR04MB4965F273BBD2CBD0958B44FE86079@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965F273BBD2CBD0958B44FE86079@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 24, 2021 at 10:57:44PM +0000, Chaitanya Kulkarni wrote:
> On 6/24/21 05:40, Christoph Hellwig wrote:
> > With the legacy IDE driver gone drivers now use either REQ_OP_DRV_*
> > or REQ_OP_SCSI_*, so unify the two concepts of passthrough requests
> > into a single one.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Nice cleanup, we got two bits free for new req_op.

We could in fact easily reduce REQ_OP_BITS to 5 now with space to spare.
But we haven't run out of flags bits quite yet.
