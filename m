Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8720C2CC28D
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgLBQhW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:37:22 -0500
Received: from verein.lst.de ([213.95.11.211]:54997 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389178AbgLBQhW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:37:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88B1767373; Wed,  2 Dec 2020 17:36:40 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:36:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 30/34] ips: use correct command completion on error
Message-ID: <20201202163640.GY32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-31-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-31-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Dec 02, 2020 at 12:52:45PM +0100, Hannes Reinecke wrote:
> A non-zero queuecommand() return code means 'busy', ie the command
> hasn't been submitted. So any command which should be failed need
> to be completed via the ->scsi_done() callback with the appropriate
> result code set.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
