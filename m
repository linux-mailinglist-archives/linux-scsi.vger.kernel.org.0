Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7D47D10
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFQI3w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 04:29:52 -0400
Received: from verein.lst.de ([213.95.11.211]:34173 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfFQI3w (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 04:29:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4E31468D04; Mon, 17 Jun 2019 10:29:23 +0200 (CEST)
Date:   Mon, 17 Jun 2019 10:29:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH V4 14/16] scsi: ppa: use sg helper to operate
 scatterlist
Message-ID: <20190617082923.GN7455@lst.de>
References: <20190617030349.26415-1-ming.lei@redhat.com> <20190617030349.26415-15-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617030349.26415-15-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 17, 2019 at 11:03:47AM +0800, Ming Lei wrote:
> Use the scatterlist iterators and remove direct indexing of the
> scatterlist array.
> 
> This way allows us to pre-allocate one small scatterlist, which can be
> chained with one runtime allocated scatterlist if the pre-allocated one
> isn't enough for the whole request.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
