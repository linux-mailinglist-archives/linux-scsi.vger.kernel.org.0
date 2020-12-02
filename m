Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2252CC239
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbgLBQ0e (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:26:34 -0500
Received: from verein.lst.de ([213.95.11.211]:54909 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgLBQ0e (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:26:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E9AAF67373; Wed,  2 Dec 2020 17:25:52 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:25:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 15/34] aacraid: avoid setting message byte on completion
Message-ID: <20201202162552.GJ32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-16-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-16-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Dec 02, 2020 at 12:52:30PM +0100, Hannes Reinecke wrote:
> The aacraid controller is a RAID controller, and the driver will
> never see any SCSI messages. Plus it's quite pointless to set
> the message byte if the host byte is already set, as the latter
> takes precedence during error recovery.
> So drop the message byte values for the final result.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
