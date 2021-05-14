Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C48380399
	for <lists+linux-scsi@lfdr.de>; Fri, 14 May 2021 08:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhENGVZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 May 2021 02:21:25 -0400
Received: from verein.lst.de ([213.95.11.211]:49376 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhENGVX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 May 2021 02:21:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2045B67373; Fri, 14 May 2021 08:20:08 +0200 (CEST)
Date:   Fri, 14 May 2021 08:20:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/8] core: Introduce scsi_get_sector()
Message-ID: <20210514062007.GA5901@lst.de>
References: <20210513223757.3938-1-bvanassche@acm.org> <20210513223757.3938-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513223757.3938-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 13, 2021 at 03:37:50PM -0700, Bart Van Assche wrote:
> Since scsi_get_lba() returns a sector_t value instead of the LBA, the name
> of that function is confusing. Introduce an identical function
> scsi_get_sector(). A later patch will remove scsi_get_lba().

Why not just do a quick rename in a single patch instead of the hard to
review series?
