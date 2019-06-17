Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A635747E53
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfFQJZS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 05:25:18 -0400
Received: from verein.lst.de ([213.95.11.211]:35010 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfFQJZS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 05:25:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1D06168AFE; Mon, 17 Jun 2019 11:24:47 +0200 (CEST)
Date:   Mon, 17 Jun 2019 11:24:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, Jim Gill <jgill@vmware.com>,
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
        Kim Bradley <kim.jamie.bradley@gmail.com>
Subject: Re: [PATCH V4 09/16] staging: rtsx: use sg helper to operate
 scatterlist
Message-ID: <20190617092446.GA8707@lst.de>
References: <20190617030349.26415-1-ming.lei@redhat.com> <20190617030349.26415-10-ming.lei@redhat.com> <20190617082706.GI7455@lst.de> <20190617091524.GB31002@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617091524.GB31002@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> +		struct scatterlist *sg = *cur_sg ?:
> +				(struct scatterlist *)scsi_sglist(srb);
> +

No need for the cast here.  And I have to say I hate that GNU C
non-standard shortshut in ? :.

Why not simply:

		struct scatterlist *sg = *cur_sg;

		if (!sg)
			sg = scsi_sglist(srb);

Which is a little more verbose, but much more readabe.

The rest of the patch looks fine to me.
