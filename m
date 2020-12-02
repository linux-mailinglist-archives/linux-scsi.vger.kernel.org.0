Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418E92CC26D
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgLBQd4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:33:56 -0500
Received: from verein.lst.de ([213.95.11.211]:54952 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgLBQd4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:33:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A71868AFE; Wed,  2 Dec 2020 17:33:14 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:33:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 19/34] aic7xxx,aic79xx: drop internal SCSI message
 definition
Message-ID: <20201202163314.GN32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-20-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-20-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Dec 02, 2020 at 12:52:34PM +0100, Hannes Reinecke wrote:
> Use the standard SCSI message definitions instead of the
> driver-internal ones.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
