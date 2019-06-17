Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD447CA8
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfFQI1v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 04:27:51 -0400
Received: from verein.lst.de ([213.95.11.211]:34095 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfFQI1u (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 04:27:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7284868CEE; Mon, 17 Jun 2019 10:27:21 +0200 (CEST)
Date:   Mon, 17 Jun 2019 10:27:21 +0200
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
        Benjamin Block <bblock@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V4 10/16] s390: zfcp_fc: use sg helper to operate
 scatterlist
Message-ID: <20190617082721.GJ7455@lst.de>
References: <20190617030349.26415-1-ming.lei@redhat.com> <20190617030349.26415-11-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617030349.26415-11-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 17, 2019 at 11:03:43AM +0800, Ming Lei wrote:
> Use the scatterlist iterators and remove direct indexing of the
> scatterlist array.
> 
> This way allows us to pre-allocate one small scatterlist, which can be
> chained with one runtime allocated scatterlist if the pre-allocated one
> isn't enough for the whole request.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
