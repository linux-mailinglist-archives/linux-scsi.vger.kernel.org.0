Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E6134722E
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Mar 2021 08:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhCXHOs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Mar 2021 03:14:48 -0400
Received: from verein.lst.de ([213.95.11.211]:35708 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235762AbhCXHOO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 24 Mar 2021 03:14:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2396D68B02; Wed, 24 Mar 2021 08:14:13 +0100 (CET)
Date:   Wed, 24 Mar 2021 08:14:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     mwilck@suse.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, David Disseldorp <ddiss@suse.com>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2 1/2] target: pscsi: avoid OOM in pscsi_map_sg()
Message-ID: <20210324071412.GC647@lst.de>
References: <20210323212431.15306-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323212431.15306-1-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Mar 23, 2021 at 10:24:30PM +0100, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> pscsi_map_sg() uses the variable nr_pages as a hint for bio_kmalloc()
> how many vector elements to allocate. If nr_pages is < BIO_MAX_PAGES,
> it will be reset to 0 after successful allocation of the bio.
> 
> If bio_add_pc_page() fails later for whatever reason, pscsi_map_sg()
> tries to allocate another bio, passing nr_vecs=0. This causes
> bio_add_pc_page() to fail immediately in the next call. pci_map_sg()
> continues to allocate zero-length bios until memory is exhausted and
> the kernel crashes with OOM. This can be easily observed by exporting
> a SATA DVD drive via pscsi. The target crashes as soon as the client
> tries to access the DVD LUN. In the case I analyzed, bio_add_pc_page()
> would fail because the DVD device's max_sectors_kb (128) was
> exceeded.
> 
> Avoid this by simply not resetting nr_pages to 0 after allocating the
> bio. This way, the client receives an IO error when it tries to send
> requests exceeding the devices max_sectors_kb, and eventually gets
> it right. The client must still limit max_sectors_kb e.g. by an udev
> rule if (like in my case) the driver doesn't report valid block
> limits, otherwise it encounters I/O errors.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
