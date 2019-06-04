Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8923E3415B
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfFDIO5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 04:14:57 -0400
Received: from verein.lst.de ([213.95.11.211]:34127 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfFDIO5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 04:14:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2FF6068B02; Tue,  4 Jun 2019 10:14:31 +0200 (CEST)
Date:   Tue, 4 Jun 2019 10:14:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 01/24] block: disable elevator for reserved tags
Message-ID: <20190604081430.GA16717@lst.de>
References: <20190529132901.27645-1-hare@suse.de> <20190529132901.27645-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529132901.27645-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 29, 2019 at 03:28:38PM +0200, Hannes Reinecke wrote:
> Reserved requests are internal to the driver and we wouldn't know
> if and how they should be merged.
> So disable the elevator for reserved tags.

Internal request better be REQ_OP_DRV* pass through requests,
for which we never merge anyway.  So this patch doesn't look like
it actually is needed.
