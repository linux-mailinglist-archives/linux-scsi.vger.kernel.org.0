Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DDA1B5D5
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfEMM2r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 08:28:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMM2r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 May 2019 08:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6RBL9E0XQbNezEx42J2APlxH8qGdY7FDqTbvyR7TmC8=; b=TPg6Iey/rFzPpG4P43E5LWgzC
        ZZUK/gTV0Y88ktoC4kE/SElR5opPtVH3xCTPg/EHrxdQi5mKdeTxSBMHZyQP1hmrCITeMp9z2t+f4
        dxPm3nWVYYI+eA1JBl24+WQVEglteKC7/Wrv+VsXVFH3CnWd2Tr+gycTbp+SJ23X6m1Ydogq9UMJh
        2Fs+QE3gLGPpsu8Xob/o0PfrRYcZTvTj8gkPykGXr4RUu13vgClHB5s5clDUcdTlVPbtTh3jwQTpa
        Hoi+QBg9yLG3MmVs298A6bk/TGUGzywQsC0vd8pJClgzS7ruO8e2Ka7Vn7/njAkjU+bi5B89yP9BD
        f1DiFJY9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQA4U-0005jy-Gr; Mon, 13 May 2019 12:28:46 +0000
Date:   Mon, 13 May 2019 05:28:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     whiteheadm@acm.org
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: Poor SWIOTLB Performance with HIGHMEM64G
Message-ID: <20190513122846.GA15835@infradead.org>
References: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
 <20190513070218.GA25920@infradead.org>
 <CAP8WD_ZuOHn2VWjgYr-rLBd7Lm33nTvCvu7WKqW_0gfzqbbCLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_ZuOHn2VWjgYr-rLBd7Lm33nTvCvu7WKqW_0gfzqbbCLQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, May 13, 2019 at 08:20:03AM -0400, tedheadster wrote:
> On Mon, May 13, 2019 at 3:02 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sun, May 12, 2019 at 02:55:48PM -0400, tedheadster wrote:
> > > Christoph,
> > >   On the same hardware (reboot with different kernel) I am getting
> > > _horrible_ disk I/O performance on the 5.1.1. kernel compiled on a
> > > 32-bit platform using HIGHMEM64G (PAE) to access 32GiB of physical
> > > memory.
> > >
> > > The numbers are truly terrible to copy a 16GiB file from one disk to a
> > > different one:
> >
> > This sounds like your storage controller only supports 32-bit DMA.
> > In that case any memory above that will be bounce buffered, that
> > is copied from one piece of memory to another, which in addition
> > to the copying will also create memory pressure.
> 
> I have this SATA controller (using ahci kernel driver):
> 
>  SATA controller [0106]: Intel Corporation C610/X99 series chipset
> sSATA Controller [AHCI mode] [8086:8d62] (rev 05)


That is odd.  While the AHIC spec allows for devices not to be
64-bit DMA capable, I've never heard of an Intel device that falls
into that category.

Can you apply the patch below and check if one of the messages shows
up in dmesg?

> I guess my request is for the VM folks to _indeed_ spend some effort
> optimizing large highmem setups because a 700% slowdown should be
> embarrassing. Who should I ask in that team about this?

linux-mm@kvack.org

> I do have 64-bit hardware but I regrettably have to run it in 32-bit
> mode with PAE support to access highmem64g memory.

Why?

---
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 021ce46e2e57..96add425253a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -926,8 +926,12 @@ static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
 	if (pdev->dma_mask && pdev->dma_mask < DMA_BIT_MASK(32))
 		return 0;
 
+	if (!using_dac)
+		dev_info(&pdev->dev, "Not 64-bit capable!\n");
+
 	if (using_dac &&
 	    !dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
+		dev_info(&pdev->dev, "failed to set 64-bit mask!\n");
 		rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 		if (rc) {
 			rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
