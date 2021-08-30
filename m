Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2C3FB538
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Aug 2021 14:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhH3MCV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Aug 2021 08:02:21 -0400
Received: from verein.lst.de ([213.95.11.211]:40275 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236921AbhH3MBj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 30 Aug 2021 08:01:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25CFD68B05; Mon, 30 Aug 2021 14:00:37 +0200 (CEST)
Date:   Mon, 30 Aug 2021 14:00:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org,
        davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
        pgonda@google.com, martin.b.radev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        rppt@kernel.org, hannes@cmpxchg.org, aneesh.kumar@linux.ibm.com,
        krish.sadhukhan@oracle.com, saravanand@fb.com,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, rientjes@google.com,
        ardb@kernel.org, michael.h.kelley@microsoft.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
        vkuznets@redhat.com, parri.andrea@gmail.com, dave.hansen@intel.com
Subject: Re: [PATCH V4 00/13] x86/Hyper-V: Add Hyper-V Isolation VM support
Message-ID: <20210830120036.GA22005@lst.de>
References: <20210827172114.414281-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827172114.414281-1-ltykernel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sorry for the delayed answer, but I look at the vmap_pfn usage in the
previous version and tried to come up with a better version.  This
mostly untested branch:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hyperv-vmap

get us there for swiotlb and the channel infrastructure  I've started
looking at the network driver and didn't get anywhere due to other work.

As far as I can tell the network driver does gigantic multi-megabyte
vmalloc allocation for the send and receive buffers, which are then
passed to the hardware, but always copied to/from when interacting
with the networking stack.  Did I see that right?  Are these big
buffers actually required unlike the normal buffer management schemes
in other Linux network drivers?

If so I suspect the best way to allocate them is by not using vmalloc
but just discontiguous pages, and then use kmap_local_pfn where the
PFN includes the share_gpa offset when actually copying from/to the
skbs.
