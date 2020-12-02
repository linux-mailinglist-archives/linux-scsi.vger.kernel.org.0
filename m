Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B245B2CC222
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbgLBQXC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:23:02 -0500
Received: from verein.lst.de ([213.95.11.211]:54865 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389060AbgLBQXC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:23:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E0D1167373; Wed,  2 Dec 2020 17:22:20 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:22:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 02/34] 3w-xxxx: Whitespace fixes and tag with SPDX
Message-ID: <20201202162220.GB32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Dec 02, 2020 at 12:52:17PM +0100, Hannes Reinecke wrote:
> General whitespace cleanup and add an SPDX tag to the file.

I don't think you can simply drop the warranty disclaimer.
