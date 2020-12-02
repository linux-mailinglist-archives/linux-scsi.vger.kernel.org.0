Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064F52CC275
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgLBQfl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:35:41 -0500
Received: from verein.lst.de ([213.95.11.211]:54976 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgLBQfl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:35:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AFB3767373; Wed,  2 Dec 2020 17:34:59 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:34:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 25/34] mac53c94: Do not set invalid command result
Message-ID: <20201202163459.GT32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-26-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-26-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Dec 02, 2020 at 12:52:40PM +0100, Hannes Reinecke wrote:
> CMD_ACCEPT_MSG is an internal definition, and most certainly not
> a SCSI status. As the latter gets set during command completion
> we can drop the assignment here.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
