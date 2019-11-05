Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A174AEF257
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 01:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfKEA5d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 19:57:33 -0500
Received: from verein.lst.de ([213.95.11.211]:42272 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbfKEA5c (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 19:57:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A9B7268BE1; Tue,  5 Nov 2019 01:57:29 +0100 (CET)
Date:   Tue, 5 Nov 2019 01:57:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH RFC v2 2/5] ufs: Use reserved tags for TMFs
Message-ID: <20191105005729.GA29695@lst.de>
References: <20191105004226.232635-1-bvanassche@acm.org> <20191105004226.232635-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105004226.232635-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Nov 04, 2019 at 04:42:23PM -0800, Bart Van Assche wrote:
> Reserved tags are numerically lower than non-reserved tags. Compensate the
> change caused by reserving tags by subtracting the number of reserved tags
> from the tag number assigned by the block layer.

Why would you do that?  Do we really care about the exact tag number?
If so would it make sense to reverse in the block layer how we allocate
private vs normal tags?

Also this change should probably merged into the patch that actually
starts using the private tags by actually allocating requests using
them.
