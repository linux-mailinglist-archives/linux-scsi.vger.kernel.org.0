Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D92CC264
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgLBQcj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:32:39 -0500
Received: from verein.lst.de ([213.95.11.211]:54935 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgLBQci (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:32:38 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB93A67373; Wed,  2 Dec 2020 17:31:54 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:31:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 16/34] hpsa: do not set COMMAND_COMPLETE
Message-ID: <20201202163152.GK32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-17-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-17-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Dec 02, 2020 at 12:52:31PM +0100, Hannes Reinecke wrote:
> COMMAND_COMPLETE is defined as '0', and it is a SCSI parallel message
> to boot. So drop the call to set_msg_byte().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
