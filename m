Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392C32D1247
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 14:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgLGNjd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 08:39:33 -0500
Received: from verein.lst.de ([213.95.11.211]:41891 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgLGNjd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Dec 2020 08:39:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A61C68AFE; Mon,  7 Dec 2020 14:38:51 +0100 (CET)
Date:   Mon, 7 Dec 2020 14:38:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/35] scsi: drop gdth driver
Message-ID: <20201207133850.GB29249@lst.de>
References: <20201207124819.95822-1-hare@suse.de> <20201207124819.95822-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207124819.95822-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Dec 07, 2020 at 01:47:45PM +0100, Hannes Reinecke wrote:
> The gdth driver refers to a SCSI parallel, PCI-only HBA RAID adapter
> which was manufactured by the now-defunct ICP Vortex company, later
> acquired by Adaptec and superseded by the aacraid series of controllers.
> The driver itself would require a major overhaul before any modifications
> can be attempted, but seeing that it's unlikely to have any users left
> it should rather be removed completely.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

That is no the tag I gave you..
