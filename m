Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D112CC21E
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbgLBQWF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:22:05 -0500
Received: from verein.lst.de ([213.95.11.211]:54860 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389013AbgLBQWF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:22:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CD5368AFE; Wed,  2 Dec 2020 17:21:20 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:21:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/34] scsi: drop gdth driver
Message-ID: <20201202162118.GA32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Dec 02, 2020 at 12:52:16PM +0100, Hannes Reinecke wrote:
> The gdth driver refers to a SCSI parallel, PCI-only HBA RAID adapter
> which was manufactured by the now-defunct ICP Vortex company, later
> acquired by Adaptec and superseded by the aacraid series of controllers.
> The driver itself would require a major overhaul before any modifications
> can be attempted, but seeing that it's unlikely to have any users left
> it should rather be removed completely.

The driver is pretty horrible, so I'm not going to complain if it
goes away.  Let's hope one relies on it, and we don't have to bring
it back..

Cautiously-Acked-by: Christoph Hellwig <hch@lst.de>

Once this driver is gone we can also remove scsi_get_host_dev and
scsi_free_host_dev.
